package canvas.utils;

import sys.io.File;
import sys.FileSystem;

import canvas.graphics.Font;
import canvas.graphics.BitmapData;

import canvas.media.Sound;

/**
 * A utility class for loading/retrieving cached assets.
 */
class Assets {
    /**
     * Clears all cached assets from memory.
     */
    public static function clearCache():Void {
        for(cache in [bitmapCache, soundCache, fontCache])
            cache.dispose();
    }

    /**
     * Returns whether or not a given asset path exists.
     * 
     * @param  path  The asset path to check.
     */
    public static function exists(path:String):Bool {
        return FileSystem.exists(path);
    }

    /**
     * Returns bitmap data from a specified file path.
     * 
     * @param  filePath  A file path of the image to load.
     */
    public static function getBitmapData(filePath:String):BitmapData {
        final key:String = '#__BITMAP__${filePath}';
        if(!bitmapCache.exists(filePath))
            bitmapCache.add(key, BitmapData.fromFile(filePath));

        return bitmapCache.get(key);
    }

    /**
     * Returns sound data from a specified file path.
     * 
     * @param  filePath  A file path of the sound to load.
     */
    public static function getSound(filePath:String):Sound {
        final key:String = '#__SOUND__${filePath}';
        if(!soundCache.exists(filePath))
            soundCache.add(key, Sound.fromFile(filePath));

        return soundCache.get(key);
    }

    /**
     * Returns font data from a specified file path.
     * 
     * @param  filePath  A file path of the font to load.
     */
    public static function getFont(filePath:String):Font {
        final key:String = '#__FONT__${filePath}';
        if(!fontCache.exists(filePath))
            fontCache.add(key, new Font(filePath));

        return fontCache.get(key);
    }

    /**
     * Returns text data from a specified file path.
     * 
     * @param  filePath  A file path of the text file to load.
     */
    public static function getText(filePath:String):String {
        return File.getContent(filePath);
    }

    // --------------- //
    // [ Private API ] //
    // --------------- //
    
    private static var bitmapCache:AssetCache<BitmapData> = new AssetCache();
    private static var soundCache:AssetCache<Sound> = new AssetCache();
    private static var fontCache:AssetCache<Font> = new AssetCache();
}