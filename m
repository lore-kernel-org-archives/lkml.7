Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE8DC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 16:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B63221925
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 16:11:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbfKLQLE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 11:11:04 -0500
Received: from ms.lwn.net ([45.79.88.28]:41728 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726008AbfKLQLE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 11:11:04 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 6E5F85A0;
        Tue, 12 Nov 2019 16:11:02 +0000 (UTC)
Date:   Tue, 12 Nov 2019 09:11:00 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [RFC PATCH] Documentation: filesystems: convert vfat.txt to RST
Message-ID: <20191112091100.3fb3dd06@lwn.net>
In-Reply-To: <20191108183941.71760-1-dwlsalmeida@gmail.com>
References: <20191108183941.71760-1-dwlsalmeida@gmail.com>
Organization: LWN.net
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  8 Nov 2019 15:39:41 -0300
"Daniel W. S. Almeida" <dwlsalmeida@gmail.com> wrote:

> From: "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
> 
> Converts vfat.txt to the reStructuredText format, improving presentation
> without changing the underlying content.
> 
> Signed-off-by: Daniel W. S. Almeida <dwlsalmeida@gmail.com>

Thanks for doing this conversion!  A number of my comments from the FUSE
patch apply here as well:

- Copy the maintainer

- Update MAINTAINERS

- Limit use of markup

- Consider a move to the admin guide.  It's less obvious here, though,
  because the information about the structure of the filesystem itself
  arguably does not belong there.  A better place, honestly, might be as a
  DOC block in the driver source itself, but that would need to be run past
  the maintainer.

A few other minor comments below.

>  Documentation/filesystems/index.rst |   1 +
>  Documentation/filesystems/vfat.rst  | 389 ++++++++++++++++++++++++++++
>  Documentation/filesystems/vfat.txt  | 347 -------------------------
>  3 files changed, 390 insertions(+), 347 deletions(-)
>  create mode 100644 Documentation/filesystems/vfat.rst
>  delete mode 100644 Documentation/filesystems/vfat.txt
> 
> diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
> index 2c3a9f761205..aaffaa9042c3 100644
> --- a/Documentation/filesystems/index.rst
> +++ b/Documentation/filesystems/index.rst
> @@ -47,3 +47,4 @@ Documentation for filesystem implementations.
>     :maxdepth: 2
>  
>     virtiofs
> +   vfat
> diff --git a/Documentation/filesystems/vfat.rst b/Documentation/filesystems/vfat.rst
> new file mode 100644
> index 000000000000..e24e69a2817d
> --- /dev/null
> +++ b/Documentation/filesystems/vfat.rst
> @@ -0,0 +1,389 @@
> +====
> +VFAT
> +====
> +
> +USING VFAT
> +==========
> +
> +To use the vfat filesystem, use the filesystem type 'vfat'.  i.e.::
> +
> +  mount -t vfat /dev/fd0 /mnt
> +
> +
> +No special partition formatter is required.
> +``mkdosfs`` will work fine if you want to format from within Linux.
> +
> +VFAT MOUNT OPTIONS
> +==================
> +
> +**uid=###**
> +	Set the owner of all files on this filesystem.
> +	The default is the *uid* of current process.
> +
> +**gid=###**
> +	Set the group of all files on this filesystem.
> +	The default is the *gid* of current process.
> +
> +**umask=###**     
> +	The permission mask (for files and directories, see *umask(1)*).
> +	The default is the *umask* of current process.
> +
> +**dmask=###**
> +	The permission mask for the directory.
> +	The default is the *umask* of current process.
> +
> +**fmask=###**
> +	The permission mask for files.
> +	The default is the *umask* of current process.
> +
> +**allow_utime=###**
> +	This option controls the permission check of mtime/atime.
> +
> +		**-20**: If current process is in group of file's group ID, you can change timestamp.

This has become a very long line; it will be more readable if you break
it. 

> +
> +		**-2**: Other users can change timestamp.
> +
> +	The default is set from ``dmask`` option. If the directory is
> +	writable, *utime(2)* is also allowed. i.e. ``~dmask & 022``.
> +
> +	Normally ``utime(2)`` checks current process is owner of
> +	the file, or it has ``CAP_FOWNER`` capability.  But FAT
> +	filesystem doesn't have uid/gid on disk, so normal
> +	check is too unflexible. With this option you can
> +	relax it.
> +
> +**codepage=###**
> +	Sets the codepage number for converting to shortname
> +	characters on FAT filesystem.
> +	By default, ``FAT_DEFAULT_CODEPAGE`` setting is used.
> +
> +**iocharset=<name>**
> +	Character set to use for converting between the
> +	encoding is used for user visible filename and 16 bit
> +	Unicode characters. Long filenames are stored on disk
> +	in Unicode format, but Unix for the most part doesn't
> +	know how to deal with Unicode.
> +	By default, ``FAT_DEFAULT_IOCHARSET`` setting is used.
> +
> +	There is also an option of doing UTF-8 translations
> +	with the utf8 option.
> +
> +.. note:: ``iocharset=utf8`` is not recommended. If unsure, you should consider the utf8 option instead.

Here too.  This should be something like:

  .. note::
      ``iocharset=utf8`` is not recommended. If unsure, you should consider
      the utf8 option instead.

> +
> +**utf8=<bool>**
> +	UTF-8 is the filesystem safe version of Unicode that
> +	is used by the console. It can be enabled or disabled
> +	for the filesystem with this option.
> +	If 'uni_xlate' gets set, UTF-8 gets disabled.
> +	By default, ``FAT_DEFAULT_UTF8`` setting is used.
> +
> +**uni_xlate=<bool>**
> +	Translate unhandled Unicode characters to special
> +	escaped sequences.  This would let you backup and
> +	restore filenames that are created with any Unicode
> +	characters.  Until Linux supports Unicode for real,
> +	this gives you an alternative.  Without this option,
> +	a '?' is used when no translation is possible.  The
> +	escape character is ':' because it is otherwise
> +	illegal on the vfat filesystem.  The escape sequence
> +	that gets used is ':' and the four digits of hexadecimal
> +	unicode.
> +
> +**nonumtail=<bool>**
> +	When creating 8.3 aliases, normally the alias will
> +	end in '~1' or tilde followed by some number.  If this
> +	option is set, then if the filename is 
> +	"longfilename.txt" and "longfile.txt" does not
> +	currently exist in the directory, ``longfile.txt`` will
> +	be the short alias instead of ``longfi~1.txt``. 
> +                  
> +**usefree**
> +	Use the "free clusters" value stored on ``FSINFO``. It'll
> +	be used to determine number of free clusters without
> +	scanning disk. But it's not used by default, because
> +	recent Windows don't update it correctly in some
> +	case. If you are sure the "free clusters" on ``FSINFO`` is
> +	correct, by this option you can avoid scanning disk.
> +
> +**quiet**
> +	Stops printing certain warning messages.
> +
> +**check=s|r|n**   
> +	Case sensitivity checking setting.
> +
> +	**s**: strict, case sensitive
> +
> +	**r**: relaxed, case insensitive
> +
> +	**n**: normal, default setting, currently case insensitive
> +
> +**nocase**
> +	This was deprecated for vfat. Use ``shortname=win95`` instead.
> +
> +**shortname=lower|win95|winnt|mixed**
> +	Shortname display/create setting.
> +
> +	**lower**: convert to lowercase for display,
> +	emulate the Windows 95 rule for create.
> +
> +	**win95**: emulate the Windows 95 rule for display/create.
> +
> +	**winnt**: emulate the Windows NT rule for display/create.
> +
> +	**mixed**: emulate the Windows NT rule for display,
> +	emulate the Windows 95 rule for create.
> +
> +	Default setting is `mixed`.
> +
> +**tz=UTC**        
> +	Interpret timestamps as UTC rather than local time.
> +	This option disables the conversion of timestamps
> +	between local time (as used by Windows on FAT) and UTC
> +	(which Linux uses internally).  This is particularly
> +	useful when mounting devices (like digital cameras)
> +	that are set to UTC in order to avoid the pitfalls of
> +	local time.
> +
> +**time_offset=minutes**
> +	Set offset for conversion of timestamps from local time
> +	used by FAT to UTC. I.e. <minutes> minutes will be subtracted
> +	from each timestamp to convert it to UTC used internally by
> +	Linux. This is useful when time zone set in ``sys_tz`` is
> +	not the time zone used by the filesystem. Note that this
> +	option still does not provide correct time stamps in all
> +	cases in presence of DST - time stamps in a different DST
> +	setting will be off by one hour.
> +
> +**showexec**      
> +	If set, the execute permission bits of the file will be
> +	allowed only if the extension part of the name is ``.EXE``,
> +	``.COM``, or ``.BAT``. Not set by default.
> +
> +**debug**
> +	Can be set, but unused by the current implementation.
> +
> +**sys_immutable**
> +	If set, ATTR_SYS attribute on FAT is handled as
> +	``IMMUTABLE`` flag on Linux. Not set by default.
> +
> +**flush**        
> +	If set, the filesystem will try to flush to disk more
> +	early than normal. Not set by default.
> +
> +**rodir**	 
> +	FAT has the ``ATTR_RO`` (read-only) attribute. On Windows,
> +	the ``ATTR_RO`` of the directory will just be ignored,
> +	and is used only by applications as a flag (e.g. it's set
> +	for the customized folder).
> +
> +	If you want to use ``ATTR_RO`` as read-only flag even for
> +	the directory, set this option.
> +
> +**errors=panic|continue|remount-ro**
> +	specify FAT behavior on critical errors: panic, continue
> +	without doing anything or remount the partition in
> +	read-only mode (default behavior).
> +
> +**discard**
> +	If set, issues discard/TRIM commands to the block
> +	device when blocks are freed. This is useful for SSD devices
> +	and sparse/thinly-provisoned LUNs.
> +
> +**nfs=stale_rw|nostale_ro**
> +	Enable this only if you want to export the FAT filesystem
> +	over NFS.
> +
> +		**stale_rw**: This option maintains an index (cache) of directory
> +		*inodes* by *i_logstart* which is used by the nfs-related code to
> +		improve look-ups. Full file operations (read/write) over *NFS* is
> +		supported but with cache eviction at *NFS* server, this could
> +		result in ``ESTALE`` issues.
> +
> +		**nostale_ro**: This option bases the *inode* number and filehandle
> +		on the on-disk location of a file in the MS-DOS directory entry.
> +		This ensures that ``ESTALE`` will not be returned after a file is
> +		evicted from the *inode* cache. However, it means that operations
> +		such as rename, create and unlink could cause filehandles that
> +		previously pointed at one file to point at a different file,
> +		potentially causing data corruption. For this reason, this
> +		option also mounts the filesystem readonly.
> +
> +	To maintain backward compatibility, ``'-o nfs'`` is also accepted,
> +	defaulting to ``stale_rw``
> +
> +**dos1xfloppy  <bool>: 0,1,yes,no,true,false**
> +	If set, use a fallback default BIOS Parameter Block
> +	configuration, determined by backing device size. These static
> +	parameters match defaults assumed by DOS 1.x for 160 kiB,
> +	180 kiB, 320 kiB, and 360 kiB floppies and floppy images.
> +
> +
> +
> +LIMITATION
> +==========
> +The fallocated region of file is discarded at umount/evict time

Put a blank line after the subheading markup.

> +when using fallocate with FALLOC_FL_KEEP_SIZE.
> +So, User should assume that fallocated region can be discarded at
> +last close if there is memory pressure resulting in eviction of
> +the inode from the memory. As a result, for any dependency on
> +the fallocated region, user should make sure to recheck fallocate
> +after reopening the file.
> +
> +TODO
> +====
> +Need to get rid of the raw scanning stuff.  Instead, always use
> +a get next directory entry approach.  The only thing left that uses
> +raw scanning is the directory renaming code.
> +
> +
> +POSSIBLE PROBLEMS
> +=================
> +
> +- vfat_valid_longname does not properly checked reserved names.
> +- When a volume name is the same as a directory name in the root
> +  directory of the filesystem, the directory name sometimes shows
> +  up as an empty file.
> +- autoconv option does not work correctly.
> +
> +BUG REPORTS
> +===========
> +If you have trouble with the *VFAT* filesystem, mail bug reports to
> +chaffee@bmrc.cs.berkeley.edu.
> +
> +Please specify the filename and the operation that gave you trouble.
> +
> +TEST SUITE
> +==========
> +If you plan to make any modifications to the vfat filesystem, please
> +get the test suite that comes with the vfat distribution at
> +
> +`<http://web.archive.org/web/*/http://bmrc.berkeley.edu/people/chaffee/vfat.html>`_
> +
> +This tests quite a few parts of the vfat filesystem and additional
> +tests for new features or untested features would be appreciated.
> +
> +NOTES ON THE STRUCTURE OF THE VFAT FILESYSTEM
> +=============================================
> +This documentation was provided by Galen C. Hunt gchunt@cs.rochester.edu and lightly annotated by Gordon Chaffee.

One more time, please avoid these really long lines.

> +
> +This document presents a very rough, technical overview of my
> +knowledge of the extended FAT file system used in Windows NT 3.5 and
> +Windows 95.  I don't guarantee that any of the following is correct,
> +but it appears to be so.

A paragraph like that suggests that this information might be a wee bit out
of date - even if VFAT hasn't been changing much.  It might be worth asking
the maintainer for an opinion on how current things are and maybe putting
in a warning if it's truly obsolete.

> +The extended FAT file system is almost identical to the FAT
> +file system used in DOS versions up to and including *6.223410239847*
> +:-).  The significant change has been the addition of long file names.
> +These names support up to *255* characters including spaces and lower
> +case characters as opposed to the traditional *8.3* short names.
> +
> +Here is the description of the traditional *FAT* entry in the current
> +Windows 95 filesystem: ::

Too many colons, just say "filesystem::".  There's a number of these.

I'll stop here, that's enough to work on for now.

Thanks,

jon
