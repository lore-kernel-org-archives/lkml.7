Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44ACBC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 21:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0E67208E3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 21:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561758823;
	bh=bIdhLNCOCvTpIlSqvWyBAmuqLWiJiKYa64Wg6jjNPtU=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=wwinXQggEAIk7EMxKo5sHHQSrt9HIaHtMoDkFMA0MONMf3dqCEFgOQtvqnnQbbvip
	 SOTfW6SctrOJvpZqrtouP5hQ0C7TAiels/YBg0PYL2XUw+00NZt5mj8jCgK6XW/MxN
	 5A2b03vuoS+BDcH8S+gwlkdoS0AOao7LouHO5wXQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbfF1Vxl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 17:53:41 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:33266 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbfF1Vxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 17:53:41 -0400
Received: by mail-io1-f67.google.com with SMTP id u13so15672899iop.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 14:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tG78IFLwxazoEY5I7So3WWKeTgT2uGn4fd2JIYxAWvk=;
        b=dgEk4koLFJ7DU8uVvGC0GqWKOVqCjmGTVBmu9eBABN85pVS29Fj1JsmzlJK4pWLFAB
         V1/uUaH0Ik6x4DpMAMm73VDBCWyF1xeEUcZZITw/LvfUKAJ/AQKk+ZAagoQ/IiLreSbS
         RaG4HOXsq0Y2LZxD7cwgz8BwBpuEvFJO0Xy90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tG78IFLwxazoEY5I7So3WWKeTgT2uGn4fd2JIYxAWvk=;
        b=MTAK684V1935LLxfTDU11N9hWrFS+JxvsmYu9P/2k489UO+Q/bXGL8Aw/TZO1WtKrk
         yh8r5R7YF6TfzozyD7agm8Gpl31Son4n3GU81CJyxCOKh+5u2QapEFfMd8cfpEuu3cYU
         OEhnSU8tErSdVrwnYB+EESS7vUftZwWknd6uSW/EKrDHnz7MO/UAoszbaBpxpLGWMx+E
         HcSsDh102TZiQ45tibGstj5S/SSBzip+2dHVAsFFLKVoZFK8XCzsJ6Wdtj0fo6bUKqiI
         INAy5UPGaE7P4jZ4Om7gVX4FQ9CEsgrq7xWA83xg5/EtYoYbDsqFE2P4chkiB4jd+X+E
         yWMQ==
X-Gm-Message-State: APjAAAXv+lSlJb79gaNs54Ur1eWDJyTAxGRKVegFe8egL91nQYmWz++o
        4JkokXXPoL5aaZDPjlOtxHabLgV90ro=
X-Google-Smtp-Source: APXvYqzDgBxcUzx44ZbJwvU/XNQCc29hjDxPAkHnkv+FRwA4SmQ8HsxLq3CAcg0F+WGgDCbmbrqy7w==
X-Received: by 2002:a5e:cb06:: with SMTP id p6mr13197460iom.79.1561758819613;
        Fri, 28 Jun 2019 14:53:39 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id t14sm6321149ioi.60.2019.06.28.14.53.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2019 14:53:39 -0700 (PDT)
Subject: Re: [PATCH v1] Doc : fs : convert xfs.txt to ReST
To:     Sheriff Esseson <sheriffesseson@gmail.com>
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190628214302.GA12096@localhost>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <c677acf2-22d2-64d0-f3d1-00996a5bbdfc@linuxfoundation.org>
Date:   Fri, 28 Jun 2019 15:53:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190628214302.GA12096@localhost>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sheriff,

On 6/28/19 3:43 PM, Sheriff Esseson wrote:
> 	Convert xfs.txt to ReST, markup and rename accordingly. Update
> 	Documentation/index.rst.
> 	
> 	While at it, make "value" in "option=value" form xfs options definable by
> 	the user, by embedding in angle "<>" brackets, rather than something
> 	predifined elsewhere. This is inline with the conventions in manuals.
> 	
> 	Also, make defaults of boolean options prefixed with "(*)". This is
> 	so that options can be compressed to "[no]option" and on a single line, which renders
> 	consistently and nicely in htmldocs.
> 	lastly, enforce a "one option, one definition" policy to keep things
> 	consistent and simple.
> 

The commit log looks odd with these indentations.

> Signed-off-by: Sheriff Esseson <sheriffesseson@gmail.com>
> ---
>   Documentation/filesystems/index.rst           |   1 +
>   .../filesystems/{xfs.txt => xfs.rst}          | 190 ++++++++++--------
>   2 files changed, 103 insertions(+), 88 deletions(-)
>   rename Documentation/filesystems/{xfs.txt => xfs.rst} (74%)
> 
> diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
> index 1131c34d7..be91fe616 100644
> --- a/Documentation/filesystems/index.rst
> +++ b/Documentation/filesystems/index.rst
> @@ -41,3 +41,4 @@ Documentation for individual filesystem types can be found here.
>      :maxdepth: 2
>   
>      binderfs.rst
> +   xfs.rst
> diff --git a/Documentation/filesystems/xfs.txt b/Documentation/filesystems/xfs.rst
> similarity index 74%
> rename from Documentation/filesystems/xfs.txt
> rename to Documentation/filesystems/xfs.rst
> index a5cbb5e0e..5e29e1583 100644
> --- a/Documentation/filesystems/xfs.txt
> +++ b/Documentation/filesystems/xfs.rst
> @@ -1,4 +1,4 @@
> -
> +======================
>   The SGI XFS Filesystem
>   ======================
>   
> @@ -18,10 +18,10 @@ Mount Options
>   =============
>   
>   When mounting an XFS filesystem, the following options are accepted.
> -For boolean mount options, the names with the (*) suffix is the
> +For boolean mount options, the names with the "(*)" prefix is the
>   default behaviour.
>   
> -  allocsize=size
> +   allocsize=<size>
>   	Sets the buffered I/O end-of-file preallocation size when
>   	doing delayed allocation writeout (default size is 64KiB).
>   	Valid values for this option are page size (typically 4KiB)
> @@ -34,181 +34,195 @@ default behaviour.
>   	to the file. Specifying a fixed allocsize value turns off
>   	the dynamic behaviour.
>   
> -  attr2
> -  noattr2
> +   [no]attr2
>   	The options enable/disable an "opportunistic" improvement to
>   	be made in the way inline extended attributes are stored
>   	on-disk.  When the new form is used for the first time when
> -	attr2 is selected (either when setting or removing extended
> +	``attr2`` is selected (either when setting or removing extended
>   	attributes) the on-disk superblock feature bit field will be
>   	updated to reflect this format being in use.
>   
>   	The default behaviour is determined by the on-disk feature
> -	bit indicating that attr2 behaviour is active. If either
> -	mount option it set, then that becomes the new default used
> -	by the filesystem.
> -
> -	CRC enabled filesystems always use the attr2 format, and so
> -	will reject the noattr2 mount option if it is set.
> +	bit indicating that ``attr2`` behaviour is active. If either
> +	mount options is set, then that becomes the new default used
> +	by the filesystem. However on CRC enabled filesystems, the
> +        ``attr2`` format is always used , and so
> +	will reject the ``noattr2`` mount option if it is set.
>   
> -  discard
> -  nodiscard (*)
> +   (*)[no]discard
>   	Enable/disable the issuing of commands to let the block
>   	device reclaim space freed by the filesystem.  This is
>   	useful for SSD devices, thinly provisioned LUNs and virtual
>   	machine images, but may have a performance impact.
>   
> -	Note: It is currently recommended that you use the fstrim
> -	application to discard unused blocks rather than the discard
> +	Note: It is currently recommended that you use the ``fstrim``
> +	application to discard unused blocks rather than the ``discard``
>   	mount option because the performance impact of this option
>   	is quite severe.
>   
> -  grpid/bsdgroups
> -  nogrpid/sysvgroups (*)
> +   grpid/bsdgroups
> +   nogrpid/(*)sysvgroups
>   	These options define what group ID a newly created file
> -	gets.  When grpid is set, it takes the group ID of the
> +	gets.  When ``grpid`` is set, it takes the group ID of the
>   	directory in which it is created; otherwise it takes the
> -	fsgid of the current process, unless the directory has the
> -	setgid bit set, in which case it takes the gid from the
> -	parent directory, and also gets the setgid bit set if it is
> +	``fsgid`` of the current process, unless the directory has the
> +	``setgid`` bit set, in which case it takes the ``gid`` from the
> +	parent directory, and also gets the ``setgid`` bit set if it is
>   	a directory itself.
>   
> -  filestreams
> +   filestreams
>   	Make the data allocator use the filestreams allocation mode
>   	across the entire filesystem rather than just on directories
>   	configured to use it.
>   
> -  ikeep
> -  noikeep (*)
> -	When ikeep is specified, XFS does not delete empty inode
> -	clusters and keeps them around on disk.  When noikeep is
> +   (*)[no]ikeep
> +	When ``ikeep`` is specified, XFS does not delete empty inode
> +	clusters and keeps them around on disk.  When ``noikeep`` is
>   	specified, empty inode clusters are returned to the free
>   	space pool.
>   
> -  inode32
> -  inode64 (*)
> -	When inode32 is specified, it indicates that XFS limits
> +   inode32 | (*)inode64
> +	When ``inode32`` is specified, it indicates that XFS limits
>   	inode creation to locations which will not result in inode
>   	numbers with more than 32 bits of significance.
>   
> -	When inode64 is specified, it indicates that XFS is allowed
> +	When ``inode64`` is specified, it indicates that XFS is allowed
>   	to create inodes at any location in the filesystem,
>   	including those which will result in inode numbers occupying
> -	more than 32 bits of significance.
> +	more than 32 bits of significance.
>   
> -	inode32 is provided for backwards compatibility with older
> +	``inode32`` is provided for backwards compatibility with older
>   	systems and applications, since 64 bits inode numbers might
>   	cause problems for some applications that cannot handle
>   	large inode numbers.  If applications are in use which do
> -	not handle inode numbers bigger than 32 bits, the inode32
> +	not handle inode numbers bigger than 32 bits, the ``inode32``
>   	option should be specified.
>   
>   
> -  largeio
> -  nolargeio (*)
> -	If "nolargeio" is specified, the optimal I/O reported in
> -	st_blksize by stat(2) will be as small as possible to allow
> +   (*)[no]largeio
> +	If ``nolargeio`` is specified, the optimal I/O reported in
> +	st_blksize by **stat(2)** will be as small as possible to allow
>   	user applications to avoid inefficient read/modify/write
>   	I/O.  This is typically the page size of the machine, as
>   	this is the granularity of the page cache.
>   
> -	If "largeio" specified, a filesystem that was created with a
> -	"swidth" specified will return the "swidth" value (in bytes)
> -	in st_blksize. If the filesystem does not have a "swidth"
> -	specified but does specify an "allocsize" then "allocsize"
> +	If ``largeio`` specified, a filesystem that was created with a
> +	``swidth`` specified will return the ``swidth`` value (in bytes)
> +	in st_blksize. If the filesystem does not have a ``swidth``
> +	specified but does specify an ``allocsize`` then ``allocsize``
>   	(in bytes) will be returned instead. Otherwise the behaviour
> -	is the same as if "nolargeio" was specified.
> +	is the same as if ``nolargeio`` was specified.
>   
> -  logbufs=value
> -	Set the number of in-memory log buffers.  Valid numbers
> +   logbufs=<value>
> +	Set the number of in-memory log buffers to ``value``.  Valid numbers
>   	range from 2-8 inclusive.
>   
>   	The default value is 8 buffers.
>   
>   	If the memory cost of 8 log buffers is too high on small
>   	systems, then it may be reduced at some cost to performance
> -	on metadata intensive workloads. The logbsize option below
> +	on metadata intensive workloads. The ``logbsize`` option below
>   	controls the size of each buffer and so is also relevant to
>   	this case.
>   
> -  logbsize=value
> -	Set the size of each in-memory log buffer.  The size may be
> -	specified in bytes, or in kilobytes with a "k" suffix.
> +   logbsize=<value>
> +	Set the size of each in-memory log buffer to ``value``.  The size
> +        may be specified in bytes, or in kilobytes with a "k" suffix.
>   	Valid sizes for version 1 and version 2 logs are 16384 (16k)
>   	and 32768 (32k).  Valid sizes for version 2 logs also
>   	include 65536 (64k), 131072 (128k) and 262144 (256k). The
> -	logbsize must be an integer multiple of the log
> -	stripe unit configured at mkfs time.
> +	``logbsize`` must be an integer multiple of the
> +        "log stripe unit" configured at mkfs time.
>   
>   	The default value for for version 1 logs is 32768, while the
> -	default value for version 2 logs is MAX(32768, log_sunit).
> +	default value for version 2 logs is ``MAX(32768, log_sunit)``.
>   
> -  logdev=device and rtdev=device
> -	Use an external log (metadata journal) and/or real-time device.
> -	An XFS filesystem has up to three parts: a data section, a log
> -	section, and a real-time section.  The real-time section is
> -	optional, and the log section can be separate from the data
> -	section or contained within it.
> +   logdev=<device>
> +	Use ``device`` as an external log.
> +	In an XFS filesystem, the log section can be separate from
> +        the data section or contained within it.
>   
> -  noalign
> +   rtdev=<device>
> +        An XFS filesystem has up to three parts: a data section, a log
> +	section, and a real-time section.  The real-time section is optional.
> +        If enabled, ``rtdev`` sets ``device`` to be used as an
> +        external real-time section, similar to ``logdev`` above.
> +
> +   noalign
>   	Data allocations will not be aligned at stripe unit
>   	boundaries. This is only relevant to filesystems created
>   	with non-zero data alignment parameters (sunit, swidth) by
>   	mkfs.
>   
> -  norecovery
> +   norecovery
>   	The filesystem will be mounted without running log recovery.
>   	If the filesystem was not cleanly unmounted, it is likely to
> -	be inconsistent when mounted in "norecovery" mode.
> +	be inconsistent when mounted in ``norecovery`` mode.
>   	Some files or directories may not be accessible because of this.
> -	Filesystems mounted "norecovery" must be mounted read-only or
> +	Filesystems mounted ``norecovery`` must be mounted read-only or
>   	the mount will fail.
>   
> -  nouuid
> +   nouuid
>   	Don't check for double mounted file systems using the file
>   	system uuid.  This is useful to mount LVM snapshot volumes,
> -	and often used in combination with "norecovery" for mounting
> +	and often used in combination with ``norecovery`` for mounting
>   	read-only snapshots.
>   
> -  noquota
> +   noquota
>   	Forcibly turns off all quota accounting and enforcement
>   	within the filesystem.
>   
> -  uquota/usrquota/uqnoenforce/quota
> +   uquota/usrquota/uqnoenforce/quota
>   	User disk quota accounting enabled, and limits (optionally)
> -	enforced.  Refer to xfs_quota(8) for further details.
> +	enforced.  Refer to **xfs_quota(8)** for further details.
>   
> -  gquota/grpquota/gqnoenforce
> +   gquota/grpquota/gqnoenforce
>   	Group disk quota accounting enabled and limits (optionally)
> -	enforced.  Refer to xfs_quota(8) for further details.
> +	enforced.  Refer to **xfs_quota(8)** for further details.
>   
> -  pquota/prjquota/pqnoenforce
> +   pquota/prjquota/pqnoenforce
>   	Project disk quota accounting enabled and limits (optionally)
> -	enforced.  Refer to xfs_quota(8) for further details.
> +	enforced.  Refer to **xfs_quota(8)** for further details.
>   
> -  sunit=value and swidth=value
> -	Used to specify the stripe unit and width for a RAID device
> -	or a stripe volume.  "value" must be specified in 512-byte
> -	block units. These options are only relevant to filesystems
> +   sunit=<value>
> +	Used to specify the stripe unit for a RAID device
> +	or (in conjunction with ``swidth`` below) a stripe volume.  ``value`` must be specified in 512-byte
> +	block units. This option is only relevant to filesystems
>   	that were created with non-zero data alignment parameters.
>   
> -	The sunit and swidth parameters specified must be compatible
> +	The ``sunit`` parameter specified must be compatible
>   	with the existing filesystem alignment characteristics.  In
> -	general, that means the only valid changes to sunit are
> -	increasing it by a power-of-2 multiple. Valid swidth values
> -	are any integer multiple of a valid sunit value.
> +	general, that means the only valid changes to ``sunit`` are
> +	increasing it by a power-of-2 multiple.
>   
> -	Typically the only time these mount options are necessary if
> -	after an underlying RAID device has had it's geometry
> +	Typically, this mount option is necessary only
> +	after an underlying RAID device has had its geometry
>   	modified, such as adding a new disk to a RAID5 lun and
>   	reshaping it.
>   
> -  swalloc
> +   swidth=<value>
> +        Used to specify the stripe width for a RAID device
> +	or (in conjunction with ``sunit`` above) a stripe volume.  ``value`` must be specified in 512-byte
> +	block units. This option, like ``sunit`` above, is only
> +        relevant to filesystems that were created with non-zero data alignment parameters.
> +
> +	The ``swidth`` parameter specified must be compatible
> +	with the existing filesystem alignment characteristics.  In
> +	general, that means the only valid swidth values
> +	are any integer multiple of a valid ``sunit`` value.
> +
> +	Typically, this mount option is necessary only
> +	after an underlying RAID device has had its geometry
> +	modified, such as adding a new disk to a RAID5 lun and
> +	reshaping it.
> +
> +
> +   swalloc
>   	Data allocations will be rounded up to stripe width boundaries
>   	when the current end of file is being extended and the file
>   	size is larger than the stripe width size.
>   
> -  wsync
> +   wsync
>   	When specified, all filesystem namespace operations are
>   	executed synchronously. This ensures that when the namespace
>   	operation (create, unlink, etc) completes, the change to the
> @@ -302,27 +316,27 @@ The following sysctls are available for the XFS filesystem:
>   
>     fs.xfs.inherit_sync		(Min: 0  Default: 1  Max: 1)
>   	Setting this to "1" will cause the "sync" flag set
> -	by the xfs_io(8) chattr command on a directory to be
> +	by the **xfs_io(8)** chattr command on a directory to be
>   	inherited by files in that directory.
>   
>     fs.xfs.inherit_nodump		(Min: 0  Default: 1  Max: 1)
>   	Setting this to "1" will cause the "nodump" flag set
> -	by the xfs_io(8) chattr command on a directory to be
> +	by the **xfs_io(8)** chattr command on a directory to be
>   	inherited by files in that directory.
>   
>     fs.xfs.inherit_noatime	(Min: 0  Default: 1  Max: 1)
>   	Setting this to "1" will cause the "noatime" flag set
> -	by the xfs_io(8) chattr command on a directory to be
> +	by the **xfs_io(8)** chattr command on a directory to be
>   	inherited by files in that directory.
>   
>     fs.xfs.inherit_nosymlinks	(Min: 0  Default: 1  Max: 1)
>   	Setting this to "1" will cause the "nosymlinks" flag set
> -	by the xfs_io(8) chattr command on a directory to be
> +	by the **xfs_io(8)** chattr command on a directory to be
>   	inherited by files in that directory.
>   
>     fs.xfs.inherit_nodefrag	(Min: 0  Default: 1  Max: 1)
>   	Setting this to "1" will cause the "nodefrag" flag set
> -	by the xfs_io(8) chattr command on a directory to be
> +	by the **xfs_io(8)** chattr command on a directory to be
>   	inherited by files in that directory.
>   
>     fs.xfs.rotorstep		(Min: 1  Default: 1  Max: 256)
> 

