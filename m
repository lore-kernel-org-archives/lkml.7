Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 197C1C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 13:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F4182087E
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 13:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555939950;
	bh=f5T6MvE7VNdjLmm5iVsBS8gKycGyFAqkBQ9yi2/7F2k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=c5zBWI5LllyiyEWdi9NkpNoIvwgjNAuhljrPlELUk87VxuFjd+NU/hvBSTHTyprbB
	 dX0eNpreKpm+iVZJdI5xakybumgkob8Ys+odCltCr99C63oSn+Q/0K8uJ8Ms6GBCPH
	 5bVGbAT4NuLbNVznc6G79rvfIFYXtZ63NY5D8Bog=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbfDVNc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 09:32:28 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37634 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727399AbfDVN2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 09:28:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=3x4H5mEGyZKwIzr3GUIqoH31lU/0J3sIFJEZufYIvjs=; b=iav2l0iSi//6NlEVnwV7Cldh8T
        Rn8YfB6jEpZQMoq0FKxVyD3hHdlWmWhUujgOICvU5S0DOxc7A6koBPdJwHG8hxe5QKkWziSfe4ZeM
        w4nFo/vz5lfGbXHx8uHGBXlS/UHKS+4TBZnM4fMx7Dkf3CrQ2ybLv/bd1lMGy1a5/EnLB/Kk/+uQm
        GMRVumyDHW5FTGxlATzYcF9eXt6VTSIezOauJUutpkgBLkqrDayfUAgTBy0+IjOKUiV5Q+7VvbQ1/
        LaLXcThcW66+rjJ3/Oi+qqG6hcDDuLAPYsAb4ZAdmzUnTXuC9APb10FXX2Ngklgc6GXVi0yfALwUZ
        uGZdxUzQ==;
Received: from 179.176.125.229.dynamic.adsl.gvt.net.br ([179.176.125.229] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hIYzZ-0005Hs-Aj; Mon, 22 Apr 2019 13:28:18 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hIYzU-0005oi-C2; Mon, 22 Apr 2019 10:28:12 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v2 65/79] docs: ioctl: convert to ReST
Date:   Mon, 22 Apr 2019 10:27:54 -0300
Message-Id: <3bc56b16284ce581b00400d49ab9e984ab714756.1555938376.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1555938375.git.mchehab+samsung@kernel.org>
References: <cover.1555938375.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the iio documentation files to ReST, add an
index for them and adjust in order to produce a nice html
output via the Sphinx build system.

The cdrom.txt and hdio.txt have their own particular syntax.
In order to speedup the conversion, I used a small ancillary
perl script:

	my $d;
	$d .= $_ while(<>);
	$d =~ s/(\nCDROM\S+)\s+(\w[^\n]*)/$1\n\t$2\n/g;
	$d =~ s/(\nHDIO\S+)\s+(\w[^\n]*)/$1\n\t$2\n/g;
	$d =~ s/(\n\s*usage:)[\s\n]*(\w[^\n]*)/$1:\n\n\t  $2\n/g;
	$d =~ s/(\n\s*)(E\w+[\s\n]*\w[^\n]*)/$1- $2/g;
	$d =~ s/(\n\s*)(inputs|outputs|notes):\s*(\w[^\n]*)/$1$2:\n\t\t$3\n/g;
	print $d;

It basically add blank lines on a few interesting places. The
script is not perfect: still several things require manual work,
but it saved quite some time doing some obvious stuff.

At its new index.rst, let's add a :orphan: while this is not linked to
the main index.rst file, in order to avoid build warnings.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 ...g-up-ioctls.txt => botching-up-ioctls.rst} |    1 +
 Documentation/ioctl/cdrom.rst                 | 1233 +++++++++++++++++
 Documentation/ioctl/cdrom.txt                 |  967 -------------
 Documentation/ioctl/{hdio.txt => hdio.rst}    |  835 +++++++----
 Documentation/ioctl/index.rst                 |   16 +
 ...{ioctl-decoding.txt => ioctl-decoding.rst} |   13 +-
 drivers/gpu/drm/drm_ioctl.c                   |    2 +-
 7 files changed, 1814 insertions(+), 1253 deletions(-)
 rename Documentation/ioctl/{botching-up-ioctls.txt => botching-up-ioctls.rst} (99%)
 create mode 100644 Documentation/ioctl/cdrom.rst
 delete mode 100644 Documentation/ioctl/cdrom.txt
 rename Documentation/ioctl/{hdio.txt => hdio.rst} (54%)
 create mode 100644 Documentation/ioctl/index.rst
 rename Documentation/ioctl/{ioctl-decoding.txt => ioctl-decoding.rst} (54%)

diff --git a/Documentation/ioctl/botching-up-ioctls.txt b/Documentation/ioctl/botching-up-ioctls.rst
similarity index 99%
rename from Documentation/ioctl/botching-up-ioctls.txt
rename to Documentation/ioctl/botching-up-ioctls.rst
index 883fb034bd04..ac697fef3545 100644
--- a/Documentation/ioctl/botching-up-ioctls.txt
+++ b/Documentation/ioctl/botching-up-ioctls.rst
@@ -1,3 +1,4 @@
+=================================
 (How to avoid) Botching up ioctls
 =================================
 
diff --git a/Documentation/ioctl/cdrom.rst b/Documentation/ioctl/cdrom.rst
new file mode 100644
index 000000000000..3b4c0506de46
--- /dev/null
+++ b/Documentation/ioctl/cdrom.rst
@@ -0,0 +1,1233 @@
+============================
+Summary of CDROM ioctl calls
+============================
+
+- Edward A. Falk <efalk@google.com>
+
+November, 2004
+
+This document attempts to describe the ioctl(2) calls supported by
+the CDROM layer.  These are by-and-large implemented (as of Linux 2.6)
+in drivers/cdrom/cdrom.c and drivers/block/scsi_ioctl.c
+
+ioctl values are listed in <linux/cdrom.h>.  As of this writing, they
+are as follows:
+
+	======================	===============================================
+	CDROMPAUSE		Pause Audio Operation
+	CDROMRESUME		Resume paused Audio Operation
+	CDROMPLAYMSF		Play Audio MSF (struct cdrom_msf)
+	CDROMPLAYTRKIND		Play Audio Track/index (struct cdrom_ti)
+	CDROMREADTOCHDR		Read TOC header (struct cdrom_tochdr)
+	CDROMREADTOCENTRY	Read TOC entry (struct cdrom_tocentry)
+	CDROMSTOP		Stop the cdrom drive
+	CDROMSTART		Start the cdrom drive
+	CDROMEJECT		Ejects the cdrom media
+	CDROMVOLCTRL		Control output volume (struct cdrom_volctrl)
+	CDROMSUBCHNL		Read subchannel data (struct cdrom_subchnl)
+	CDROMREADMODE2		Read CDROM mode 2 data (2336 Bytes)
+				(struct cdrom_read)
+	CDROMREADMODE1		Read CDROM mode 1 data (2048 Bytes)
+				(struct cdrom_read)
+	CDROMREADAUDIO		(struct cdrom_read_audio)
+	CDROMEJECT_SW		enable(1)/disable(0) auto-ejecting
+	CDROMMULTISESSION	Obtain the start-of-last-session
+				address of multi session disks
+				(struct cdrom_multisession)
+	CDROM_GET_MCN		Obtain the "Universal Product Code"
+				if available (struct cdrom_mcn)
+	CDROM_GET_UPC		Deprecated, use CDROM_GET_MCN instead.
+	CDROMRESET		hard-reset the drive
+	CDROMVOLREAD		Get the drive's volume setting
+				(struct cdrom_volctrl)
+	CDROMREADRAW		read data in raw mode (2352 Bytes)
+				(struct cdrom_read)
+	CDROMREADCOOKED		read data in cooked mode
+	CDROMSEEK		seek msf address
+	CDROMPLAYBLK		scsi-cd only, (struct cdrom_blk)
+	CDROMREADALL		read all 2646 bytes
+	CDROMGETSPINDOWN	return 4-bit spindown value
+	CDROMSETSPINDOWN	set 4-bit spindown value
+	CDROMCLOSETRAY		pendant of CDROMEJECT
+	CDROM_SET_OPTIONS	Set behavior options
+	CDROM_CLEAR_OPTIONS	Clear behavior options
+	CDROM_SELECT_SPEED	Set the CD-ROM speed
+	CDROM_SELECT_DISC	Select disc (for juke-boxes)
+	CDROM_MEDIA_CHANGED	Check is media changed
+	CDROM_DRIVE_STATUS	Get tray position, etc.
+	CDROM_DISC_STATUS	Get disc type, etc.
+	CDROM_CHANGER_NSLOTS	Get number of slots
+	CDROM_LOCKDOOR		lock or unlock door
+	CDROM_DEBUG		Turn debug messages on/off
+	CDROM_GET_CAPABILITY	get capabilities
+	CDROMAUDIOBUFSIZ	set the audio buffer size
+	DVD_READ_STRUCT		Read structure
+	DVD_WRITE_STRUCT	Write structure
+	DVD_AUTH		Authentication
+	CDROM_SEND_PACKET	send a packet to the drive
+	CDROM_NEXT_WRITABLE	get next writable block
+	CDROM_LAST_WRITTEN	get last block written on disc
+	======================	===============================================
+
+
+The information that follows was determined from reading kernel source
+code.  It is likely that some corrections will be made over time.
+
+------------------------------------------------------------------------------
+
+General:
+
+	Unless otherwise specified, all ioctl calls return 0 on success
+	and -1 with errno set to an appropriate value on error.  (Some
+	ioctls return non-negative data values.)
+
+	Unless otherwise specified, all ioctl calls return -1 and set
+	errno to EFAULT on a failed attempt to copy data to or from user
+	address space.
+
+	Individual drivers may return error codes not listed here.
+
+	Unless otherwise specified, all data structures and constants
+	are defined in <linux/cdrom.h>
+
+------------------------------------------------------------------------------
+
+
+CDROMPAUSE
+	Pause Audio Operation
+
+
+	usage::
+
+	  ioctl(fd, CDROMPAUSE, 0);
+
+
+	inputs:
+		none
+
+
+	outputs:
+		none
+
+
+	error return:
+	  - ENOSYS	cd drive not audio-capable.
+
+
+CDROMRESUME
+	Resume paused Audio Operation
+
+
+	usage::
+
+	  ioctl(fd, CDROMRESUME, 0);
+
+
+	inputs:
+		none
+
+
+	outputs:
+		none
+
+
+	error return:
+	  - ENOSYS	cd drive not audio-capable.
+
+
+CDROMPLAYMSF
+	Play Audio MSF
+
+	(struct cdrom_msf)
+
+
+	usage::
+
+	  struct cdrom_msf msf;
+
+	  ioctl(fd, CDROMPLAYMSF, &msf);
+
+	inputs:
+		cdrom_msf structure, describing a segment of music to play
+
+
+	outputs:
+		none
+
+
+	error return:
+	  - ENOSYS	cd drive not audio-capable.
+
+	notes:
+		- MSF stands for minutes-seconds-frames
+		- LBA stands for logical block address
+		- Segment is described as start and end times, where each time
+		  is described as minutes:seconds:frames.
+		  A frame is 1/75 of a second.
+
+
+CDROMPLAYTRKIND
+	Play Audio Track/index
+
+	(struct cdrom_ti)
+
+
+	usage::
+
+	  struct cdrom_ti ti;
+
+	  ioctl(fd, CDROMPLAYTRKIND, &ti);
+
+	inputs:
+		cdrom_ti structure, describing a segment of music to play
+
+
+	outputs:
+		none
+
+
+	error return:
+	  - ENOSYS	cd drive not audio-capable.
+
+	notes:
+		- Segment is described as start and end times, where each time
+		  is described as a track and an index.
+
+
+
+CDROMREADTOCHDR
+	Read TOC header
+
+	(struct cdrom_tochdr)
+
+
+	usage::
+
+	  cdrom_tochdr header;
+
+	  ioctl(fd, CDROMREADTOCHDR, &header);
+
+	inputs:
+		cdrom_tochdr structure
+
+
+	outputs:
+		cdrom_tochdr structure
+
+
+	error return:
+	  - ENOSYS	cd drive not audio-capable.
+
+
+
+CDROMREADTOCENTRY
+	Read TOC entry
+
+	(struct cdrom_tocentry)
+
+
+	usage::
+
+	  struct cdrom_tocentry entry;
+
+	  ioctl(fd, CDROMREADTOCENTRY, &entry);
+
+	inputs:
+		cdrom_tocentry structure
+
+
+	outputs:
+		cdrom_tocentry structure
+
+
+	error return:
+	  - ENOSYS	cd drive not audio-capable.
+	  - EINVAL	entry.cdte_format not CDROM_MSF or CDROM_LBA
+	  - EINVAL	requested track out of bounds
+	  - EIO		I/O error reading TOC
+
+	notes:
+		- TOC stands for Table Of Contents
+		- MSF stands for minutes-seconds-frames
+		- LBA stands for logical block address
+
+
+
+CDROMSTOP
+	Stop the cdrom drive
+
+
+	usage::
+
+	  ioctl(fd, CDROMSTOP, 0);
+
+
+	inputs:
+		none
+
+
+	outputs:
+		none
+
+
+	error return:
+	  - ENOSYS	cd drive not audio-capable.
+
+	notes:
+	  - Exact interpretation of this ioctl depends on the device,
+	    but most seem to spin the drive down.
+
+
+CDROMSTART
+	Start the cdrom drive
+
+
+	usage::
+
+	  ioctl(fd, CDROMSTART, 0);
+
+
+	inputs:
+		none
+
+
+	outputs:
+		none
+
+
+	error return:
+	  - ENOSYS	cd drive not audio-capable.
+
+	notes:
+	  - Exact interpretation of this ioctl depends on the device,
+	    but most seem to spin the drive up and/or close the tray.
+	    Other devices ignore the ioctl completely.
+
+
+CDROMEJECT
+	- Ejects the cdrom media
+
+
+	usage::
+
+	  ioctl(fd, CDROMEJECT, 0);
+
+
+	inputs:
+		none
+
+
+	outputs:
+		none
+
+
+	error returns:
+	  - ENOSYS	cd drive not capable of ejecting
+	  - EBUSY	other processes are accessing drive, or door is locked
+
+	notes:
+		- See CDROM_LOCKDOOR, below.
+
+
+
+
+CDROMCLOSETRAY
+	pendant of CDROMEJECT
+
+
+	usage::
+
+	  ioctl(fd, CDROMCLOSETRAY, 0);
+
+
+	inputs:
+		none
+
+
+	outputs:
+		none
+
+
+	error returns:
+	  - ENOSYS	cd drive not capable of closing the tray
+	  - EBUSY	other processes are accessing drive, or door is locked
+
+	notes:
+		- See CDROM_LOCKDOOR, below.
+
+
+
+
+CDROMVOLCTRL
+	Control output volume (struct cdrom_volctrl)
+
+
+	usage::
+
+	  struct cdrom_volctrl volume;
+
+	  ioctl(fd, CDROMVOLCTRL, &volume);
+
+	inputs:
+		cdrom_volctrl structure containing volumes for up to 4
+		channels.
+
+	outputs:
+		none
+
+
+	error return:
+	  - ENOSYS	cd drive not audio-capable.
+
+
+
+CDROMVOLREAD
+	Get the drive's volume setting
+
+	(struct cdrom_volctrl)
+
+
+	usage::
+
+	  struct cdrom_volctrl volume;
+
+	  ioctl(fd, CDROMVOLREAD, &volume);
+
+	inputs:
+		none
+
+
+	outputs:
+		The current volume settings.
+
+
+	error return:
+	  - ENOSYS	cd drive not audio-capable.
+
+
+
+CDROMSUBCHNL
+	Read subchannel data
+
+	(struct cdrom_subchnl)
+
+
+	usage::
+
+	  struct cdrom_subchnl q;
+
+	  ioctl(fd, CDROMSUBCHNL, &q);
+
+	inputs:
+		cdrom_subchnl structure
+
+
+	outputs:
+		cdrom_subchnl structure
+
+
+	error return:
+	  - ENOSYS	cd drive not audio-capable.
+	  - EINVAL	format not CDROM_MSF or CDROM_LBA
+
+	notes:
+		- Format is converted to CDROM_MSF or CDROM_LBA
+		  as per user request on return
+
+
+
+CDROMREADRAW
+	read data in raw mode (2352 Bytes)
+
+	(struct cdrom_read)
+
+	usage::
+
+	  union {
+
+	    struct cdrom_msf msf;		/* input */
+	    char buffer[CD_FRAMESIZE_RAW];	/* return */
+	  } arg;
+	  ioctl(fd, CDROMREADRAW, &arg);
+
+	inputs:
+		cdrom_msf structure indicating an address to read.
+
+		Only the start values are significant.
+
+	outputs:
+		Data written to address provided by user.
+
+
+	error return:
+	  - EINVAL	address less than 0, or msf less than 0:2:0
+	  - ENOMEM	out of memory
+
+	notes:
+		- As of 2.6.8.1, comments in <linux/cdrom.h> indicate that this
+		  ioctl accepts a cdrom_read structure, but actual source code
+		  reads a cdrom_msf structure and writes a buffer of data to
+		  the same address.
+
+		- MSF values are converted to LBA values via this formula::
+
+		    lba = (((m * CD_SECS) + s) * CD_FRAMES + f) - CD_MSF_OFFSET;
+
+
+
+
+CDROMREADMODE1
+	Read CDROM mode 1 data (2048 Bytes)
+
+	(struct cdrom_read)
+
+	notes:
+		Identical to CDROMREADRAW except that block size is
+		CD_FRAMESIZE (2048) bytes
+
+
+
+CDROMREADMODE2
+	Read CDROM mode 2 data (2336 Bytes)
+
+	(struct cdrom_read)
+
+	notes:
+		Identical to CDROMREADRAW except that block size is
+		CD_FRAMESIZE_RAW0 (2336) bytes
+
+
+
+CDROMREADAUDIO
+	(struct cdrom_read_audio)
+
+	usage::
+
+	  struct cdrom_read_audio ra;
+
+	  ioctl(fd, CDROMREADAUDIO, &ra);
+
+	inputs:
+		cdrom_read_audio structure containing read start
+		point and length
+
+	outputs:
+		audio data, returned to buffer indicated by ra
+
+
+	error return:
+	  - EINVAL	format not CDROM_MSF or CDROM_LBA
+	  - EINVAL	nframes not in range [1 75]
+	  - ENXIO	drive has no queue (probably means invalid fd)
+	  - ENOMEM	out of memory
+
+
+CDROMEJECT_SW
+	enable(1)/disable(0) auto-ejecting
+
+
+	usage::
+
+	  int val;
+
+	  ioctl(fd, CDROMEJECT_SW, val);
+
+	inputs:
+		Flag specifying auto-eject flag.
+
+
+	outputs:
+		none
+
+
+	error return:
+	  - ENOSYS	Drive is not capable of ejecting.
+	  - EBUSY	Door is locked
+
+
+
+
+CDROMMULTISESSION
+	Obtain the start-of-last-session address of multi session disks
+
+	(struct cdrom_multisession)
+
+	usage::
+
+	  struct cdrom_multisession ms_info;
+
+	  ioctl(fd, CDROMMULTISESSION, &ms_info);
+
+	inputs:
+		cdrom_multisession structure containing desired
+
+	  format.
+
+	outputs:
+		cdrom_multisession structure is filled with last_session
+		information.
+
+	error return:
+	  - EINVAL	format not CDROM_MSF or CDROM_LBA
+
+
+CDROM_GET_MCN
+	Obtain the "Universal Product Code"
+	if available
+
+	(struct cdrom_mcn)
+
+
+	usage::
+
+	  struct cdrom_mcn mcn;
+
+	  ioctl(fd, CDROM_GET_MCN, &mcn);
+
+	inputs:
+		none
+
+
+	outputs:
+		Universal Product Code
+
+
+	error return:
+	  - ENOSYS	Drive is not capable of reading MCN data.
+
+	notes:
+		- Source code comments state::
+
+		    The following function is implemented, although very few
+		    audio discs give Universal Product Code information, which
+		    should just be the Medium Catalog Number on the box.  Note,
+		    that the way the code is written on the CD is /not/ uniform
+		    across all discs!
+
+
+
+
+CDROM_GET_UPC
+	CDROM_GET_MCN  (deprecated)
+
+
+	Not implemented, as of 2.6.8.1
+
+
+
+CDROMRESET
+	hard-reset the drive
+
+
+	usage::
+
+	  ioctl(fd, CDROMRESET, 0);
+
+
+	inputs:
+		none
+
+
+	outputs:
+		none
+
+
+	error return:
+	  - EACCES	Access denied:  requires CAP_SYS_ADMIN
+	  - ENOSYS	Drive is not capable of resetting.
+
+
+
+
+CDROMREADCOOKED
+	read data in cooked mode
+
+
+	usage::
+
+	  u8 buffer[CD_FRAMESIZE]
+
+	  ioctl(fd, CDROMREADCOOKED, buffer);
+
+	inputs:
+		none
+
+
+	outputs:
+		2048 bytes of data, "cooked" mode.
+
+
+	notes:
+		Not implemented on all drives.
+
+
+
+
+
+CDROMREADALL
+	read all 2646 bytes
+
+
+	Same as CDROMREADCOOKED, but reads 2646 bytes.
+
+
+
+CDROMSEEK
+	seek msf address
+
+
+	usage::
+
+	  struct cdrom_msf msf;
+
+	  ioctl(fd, CDROMSEEK, &msf);
+
+	inputs:
+		MSF address to seek to.
+
+
+	outputs:
+		none
+
+
+
+
+CDROMPLAYBLK
+	scsi-cd only
+
+	(struct cdrom_blk)
+
+
+	usage::
+
+	  struct cdrom_blk blk;
+
+	  ioctl(fd, CDROMPLAYBLK, &blk);
+
+	inputs:
+		Region to play
+
+
+	outputs:
+		none
+
+
+
+
+CDROMGETSPINDOWN
+	usage::
+
+	  char spindown;
+
+	  ioctl(fd, CDROMGETSPINDOWN, &spindown);
+
+	inputs:
+		none
+
+
+	outputs:
+		The value of the current 4-bit spindown value.
+
+
+
+
+
+CDROMSETSPINDOWN
+	usage::
+
+	  char spindown
+
+	  ioctl(fd, CDROMSETSPINDOWN, &spindown);
+
+	inputs:
+		4-bit value used to control spindown (TODO: more detail here)
+
+
+	outputs:
+		none
+
+
+
+
+
+
+CDROM_SET_OPTIONS
+	Set behavior options
+
+
+	usage::
+
+	  int options;
+
+	  ioctl(fd, CDROM_SET_OPTIONS, options);
+
+	inputs:
+		New values for drive options.  The logical 'or' of:
+
+	    ==============      ==================================
+	    CDO_AUTO_CLOSE	close tray on first open(2)
+	    CDO_AUTO_EJECT	open tray on last release
+	    CDO_USE_FFLAGS	use O_NONBLOCK information on open
+	    CDO_LOCK		lock tray on open files
+	    CDO_CHECK_TYPE	check type on open for data
+	    ==============      ==================================
+
+	outputs:
+		Returns the resulting options settings in the
+		ioctl return value.  Returns -1 on error.
+
+	error return:
+	  - ENOSYS	selected option(s) not supported by drive.
+
+
+
+
+CDROM_CLEAR_OPTIONS
+	Clear behavior options
+
+
+	Same as CDROM_SET_OPTIONS, except that selected options are
+	turned off.
+
+
+
+CDROM_SELECT_SPEED
+	Set the CD-ROM speed
+
+
+	usage::
+
+	  int speed;
+
+	  ioctl(fd, CDROM_SELECT_SPEED, speed);
+
+	inputs:
+		New drive speed.
+
+
+	outputs:
+		none
+
+
+	error return:
+	  - ENOSYS	speed selection not supported by drive.
+
+
+
+CDROM_SELECT_DISC
+	Select disc (for juke-boxes)
+
+
+	usage::
+
+	  int disk;
+
+	  ioctl(fd, CDROM_SELECT_DISC, disk);
+
+	inputs:
+		Disk to load into drive.
+
+
+	outputs:
+		none
+
+
+	error return:
+	  - EINVAL	Disk number beyond capacity of drive
+
+
+
+CDROM_MEDIA_CHANGED
+	Check is media changed
+
+
+	usage::
+
+	  int slot;
+
+	  ioctl(fd, CDROM_MEDIA_CHANGED, slot);
+
+	inputs:
+		Slot number to be tested, always zero except for jukeboxes.
+
+		May also be special values CDSL_NONE or CDSL_CURRENT
+
+	outputs:
+		Ioctl return value is 0 or 1 depending on whether the media
+
+	  has been changed, or -1 on error.
+
+	error returns:
+	  - ENOSYS	Drive can't detect media change
+	  - EINVAL	Slot number beyond capacity of drive
+	  - ENOMEM	Out of memory
+
+
+
+CDROM_DRIVE_STATUS
+	Get tray position, etc.
+
+
+	usage::
+
+	  int slot;
+
+	  ioctl(fd, CDROM_DRIVE_STATUS, slot);
+
+	inputs:
+		Slot number to be tested, always zero except for jukeboxes.
+
+		May also be special values CDSL_NONE or CDSL_CURRENT
+
+	outputs:
+		Ioctl return value will be one of the following values
+
+	  from <linux/cdrom.h>:
+
+	    =================== ==========================
+	    CDS_NO_INFO		Information not available.
+	    CDS_NO_DISC
+	    CDS_TRAY_OPEN
+	    CDS_DRIVE_NOT_READY
+	    CDS_DISC_OK
+	    -1			error
+	    =================== ==========================
+
+	error returns:
+	  - ENOSYS	Drive can't detect drive status
+	  - EINVAL	Slot number beyond capacity of drive
+	  - ENOMEM	Out of memory
+
+
+
+
+CDROM_DISC_STATUS
+	Get disc type, etc.
+
+
+	usage::
+
+	  ioctl(fd, CDROM_DISC_STATUS, 0);
+
+
+	inputs:
+		none
+
+
+	outputs:
+		Ioctl return value will be one of the following values
+
+	  from <linux/cdrom.h>:
+
+	    - CDS_NO_INFO
+	    - CDS_AUDIO
+	    - CDS_MIXED
+	    - CDS_XA_2_2
+	    - CDS_XA_2_1
+	    - CDS_DATA_1
+
+	error returns:
+		none at present
+
+	notes:
+	    - Source code comments state::
+
+
+		Ok, this is where problems start.  The current interface for
+		the CDROM_DISC_STATUS ioctl is flawed.  It makes the false
+		assumption that CDs are all CDS_DATA_1 or all CDS_AUDIO, etc.
+		Unfortunately, while this is often the case, it is also
+		very common for CDs to have some tracks with data, and some
+		tracks with audio.	Just because I feel like it, I declare
+		the following to be the best way to cope.  If the CD has
+		ANY data tracks on it, it will be returned as a data CD.
+		If it has any XA tracks, I will return it as that.	Now I
+		could simplify this interface by combining these returns with
+		the above, but this more clearly demonstrates the problem
+		with the current interface.  Too bad this wasn't designed
+		to use bitmasks...	       -Erik
+
+		Well, now we have the option CDS_MIXED: a mixed-type CD.
+		User level programmers might feel the ioctl is not very
+		useful.
+				---david
+
+
+
+
+CDROM_CHANGER_NSLOTS
+	Get number of slots
+
+
+	usage::
+
+	  ioctl(fd, CDROM_CHANGER_NSLOTS, 0);
+
+
+	inputs:
+		none
+
+
+	outputs:
+		The ioctl return value will be the number of slots in a
+		CD changer.  Typically 1 for non-multi-disk devices.
+
+	error returns:
+		none
+
+
+
+CDROM_LOCKDOOR
+	lock or unlock door
+
+
+	usage::
+
+	  int lock;
+
+	  ioctl(fd, CDROM_LOCKDOOR, lock);
+
+	inputs:
+		Door lock flag, 1=lock, 0=unlock
+
+
+	outputs:
+		none
+
+
+	error returns:
+	  - EDRIVE_CANT_DO_THIS
+
+				Door lock function not supported.
+	  - EBUSY
+
+				Attempt to unlock when multiple users
+				have the drive open and not CAP_SYS_ADMIN
+
+	notes:
+		As of 2.6.8.1, the lock flag is a global lock, meaning that
+		all CD drives will be locked or unlocked together.  This is
+		probably a bug.
+
+		The EDRIVE_CANT_DO_THIS value is defined in <linux/cdrom.h>
+		and is currently (2.6.8.1) the same as EOPNOTSUPP
+
+
+
+CDROM_DEBUG
+	Turn debug messages on/off
+
+
+	usage::
+
+	  int debug;
+
+	  ioctl(fd, CDROM_DEBUG, debug);
+
+	inputs:
+		Cdrom debug flag, 0=disable, 1=enable
+
+
+	outputs:
+		The ioctl return value will be the new debug flag.
+
+
+	error return:
+	  - EACCES	Access denied:  requires CAP_SYS_ADMIN
+
+
+
+CDROM_GET_CAPABILITY
+	get capabilities
+
+
+	usage::
+
+	  ioctl(fd, CDROM_GET_CAPABILITY, 0);
+
+
+	inputs:
+		none
+
+
+	outputs:
+		The ioctl return value is the current device capability
+		flags.  See CDC_CLOSE_TRAY, CDC_OPEN_TRAY, etc.
+
+
+
+CDROMAUDIOBUFSIZ
+	set the audio buffer size
+
+
+	usage::
+
+	  int arg;
+
+	  ioctl(fd, CDROMAUDIOBUFSIZ, val);
+
+	inputs:
+		New audio buffer size
+
+
+	outputs:
+		The ioctl return value is the new audio buffer size, or -1
+		on error.
+
+	error return:
+	  - ENOSYS	Not supported by this driver.
+
+	notes:
+		Not supported by all drivers.
+
+
+
+
+DVD_READ_STRUCT			Read structure
+
+	usage::
+
+	  dvd_struct s;
+
+	  ioctl(fd, DVD_READ_STRUCT, &s);
+
+	inputs:
+		dvd_struct structure, containing:
+
+	    =================== ==========================================
+	    type		specifies the information desired, one of
+				DVD_STRUCT_PHYSICAL, DVD_STRUCT_COPYRIGHT,
+				DVD_STRUCT_DISCKEY, DVD_STRUCT_BCA,
+				DVD_STRUCT_MANUFACT
+	    physical.layer_num	desired layer, indexed from 0
+	    copyright.layer_num	desired layer, indexed from 0
+	    disckey.agid
+	    =================== ==========================================
+
+	outputs:
+		dvd_struct structure, containing:
+
+	    =================== ================================
+	    physical		for type == DVD_STRUCT_PHYSICAL
+	    copyright		for type == DVD_STRUCT_COPYRIGHT
+	    disckey.value	for type == DVD_STRUCT_DISCKEY
+	    bca.{len,value}	for type == DVD_STRUCT_BCA
+	    manufact.{len,valu}	for type == DVD_STRUCT_MANUFACT
+	    =================== ================================
+
+	error returns:
+	  - EINVAL	physical.layer_num exceeds number of layers
+	  - EIO		Received invalid response from drive
+
+
+
+DVD_WRITE_STRUCT		Write structure
+
+	Not implemented, as of 2.6.8.1
+
+
+
+DVD_AUTH			Authentication
+
+	usage::
+
+	  dvd_authinfo ai;
+
+	  ioctl(fd, DVD_AUTH, &ai);
+
+	inputs:
+		dvd_authinfo structure.  See <linux/cdrom.h>
+
+
+	outputs:
+		dvd_authinfo structure.
+
+
+	error return:
+	  - ENOTTY	ai.type not recognized.
+
+
+
+CDROM_SEND_PACKET
+	send a packet to the drive
+
+
+	usage::
+
+	  struct cdrom_generic_command cgc;
+
+	  ioctl(fd, CDROM_SEND_PACKET, &cgc);
+
+	inputs:
+		cdrom_generic_command structure containing the packet to send.
+
+
+	outputs:
+		none
+
+	  cdrom_generic_command structure containing results.
+
+	error return:
+	  - EIO
+
+			command failed.
+	  - EPERM
+
+			Operation not permitted, either because a
+			write command was attempted on a drive which
+			is opened read-only, or because the command
+			requires CAP_SYS_RAWIO
+	  - EINVAL
+
+			cgc.data_direction not set
+
+
+
+CDROM_NEXT_WRITABLE
+	get next writable block
+
+
+	usage::
+
+	  long next;
+
+	  ioctl(fd, CDROM_NEXT_WRITABLE, &next);
+
+	inputs:
+		none
+
+
+	outputs:
+		The next writable block.
+
+
+	notes:
+		If the device does not support this ioctl directly, the
+
+	  ioctl will return CDROM_LAST_WRITTEN + 7.
+
+
+
+CDROM_LAST_WRITTEN
+	get last block written on disc
+
+
+	usage::
+
+	  long last;
+
+	  ioctl(fd, CDROM_LAST_WRITTEN, &last);
+
+	inputs:
+		none
+
+
+	outputs:
+		The last block written on disc
+
+
+	notes:
+		If the device does not support this ioctl directly, the
+		result is derived from the disc's table of contents.  If the
+		table of contents can't be read, this ioctl returns an
+		error.
diff --git a/Documentation/ioctl/cdrom.txt b/Documentation/ioctl/cdrom.txt
deleted file mode 100644
index a4d62a9d6771..000000000000
--- a/Documentation/ioctl/cdrom.txt
+++ /dev/null
@@ -1,967 +0,0 @@
-		Summary of CDROM ioctl calls.
-		============================
-
-		Edward A. Falk <efalk@google.com>
-
-		November, 2004
-
-This document attempts to describe the ioctl(2) calls supported by
-the CDROM layer.  These are by-and-large implemented (as of Linux 2.6)
-in drivers/cdrom/cdrom.c and drivers/block/scsi_ioctl.c
-
-ioctl values are listed in <linux/cdrom.h>.  As of this writing, they
-are as follows:
-
-	CDROMPAUSE		Pause Audio Operation
-	CDROMRESUME		Resume paused Audio Operation
-	CDROMPLAYMSF		Play Audio MSF (struct cdrom_msf)
-	CDROMPLAYTRKIND		Play Audio Track/index (struct cdrom_ti)
-	CDROMREADTOCHDR		Read TOC header (struct cdrom_tochdr)
-	CDROMREADTOCENTRY	Read TOC entry (struct cdrom_tocentry)
-	CDROMSTOP		Stop the cdrom drive
-	CDROMSTART		Start the cdrom drive
-	CDROMEJECT		Ejects the cdrom media
-	CDROMVOLCTRL		Control output volume (struct cdrom_volctrl)
-	CDROMSUBCHNL		Read subchannel data (struct cdrom_subchnl)
-	CDROMREADMODE2		Read CDROM mode 2 data (2336 Bytes)
-					   (struct cdrom_read)
-	CDROMREADMODE1		Read CDROM mode 1 data (2048 Bytes)
-					   (struct cdrom_read)
-	CDROMREADAUDIO		(struct cdrom_read_audio)
-	CDROMEJECT_SW		enable(1)/disable(0) auto-ejecting
-	CDROMMULTISESSION	Obtain the start-of-last-session
-				  address of multi session disks
-				  (struct cdrom_multisession)
-	CDROM_GET_MCN		Obtain the "Universal Product Code"
-				   if available (struct cdrom_mcn)
-	CDROM_GET_UPC		Deprecated, use CDROM_GET_MCN instead.
-	CDROMRESET		hard-reset the drive
-	CDROMVOLREAD		Get the drive's volume setting
-					  (struct cdrom_volctrl)
-	CDROMREADRAW		read data in raw mode (2352 Bytes)
-					   (struct cdrom_read)
-	CDROMREADCOOKED		read data in cooked mode
-	CDROMSEEK		seek msf address
-	CDROMPLAYBLK		scsi-cd only, (struct cdrom_blk)
-	CDROMREADALL		read all 2646 bytes
-	CDROMGETSPINDOWN	return 4-bit spindown value
-	CDROMSETSPINDOWN	set 4-bit spindown value
-	CDROMCLOSETRAY		pendant of CDROMEJECT
-	CDROM_SET_OPTIONS	Set behavior options
-	CDROM_CLEAR_OPTIONS	Clear behavior options
-	CDROM_SELECT_SPEED	Set the CD-ROM speed
-	CDROM_SELECT_DISC	Select disc (for juke-boxes)
-	CDROM_MEDIA_CHANGED	Check is media changed
-	CDROM_DRIVE_STATUS	Get tray position, etc.
-	CDROM_DISC_STATUS	Get disc type, etc.
-	CDROM_CHANGER_NSLOTS	Get number of slots
-	CDROM_LOCKDOOR		lock or unlock door
-	CDROM_DEBUG		Turn debug messages on/off
-	CDROM_GET_CAPABILITY	get capabilities
-	CDROMAUDIOBUFSIZ	set the audio buffer size
-	DVD_READ_STRUCT		Read structure
-	DVD_WRITE_STRUCT	Write structure
-	DVD_AUTH		Authentication
-	CDROM_SEND_PACKET	send a packet to the drive
-	CDROM_NEXT_WRITABLE	get next writable block
-	CDROM_LAST_WRITTEN	get last block written on disc
-
-
-The information that follows was determined from reading kernel source
-code.  It is likely that some corrections will be made over time.
-
-
-
-
-
-
-
-General:
-
-	Unless otherwise specified, all ioctl calls return 0 on success
-	and -1 with errno set to an appropriate value on error.  (Some
-	ioctls return non-negative data values.)
-
-	Unless otherwise specified, all ioctl calls return -1 and set
-	errno to EFAULT on a failed attempt to copy data to or from user
-	address space.
-
-	Individual drivers may return error codes not listed here.
-
-	Unless otherwise specified, all data structures and constants
-	are defined in <linux/cdrom.h>
-
-
-
-
-CDROMPAUSE			Pause Audio Operation
-
-	usage:
-
-	  ioctl(fd, CDROMPAUSE, 0);
-
-	inputs:		none
-
-	outputs:	none
-
-	error return:
-	  ENOSYS	cd drive not audio-capable.
-
-
-CDROMRESUME			Resume paused Audio Operation
-
-	usage:
-
-	  ioctl(fd, CDROMRESUME, 0);
-
-	inputs:		none
-
-	outputs:	none
-
-	error return:
-	  ENOSYS	cd drive not audio-capable.
-
-
-CDROMPLAYMSF			Play Audio MSF (struct cdrom_msf)
-
-	usage:
-
-	  struct cdrom_msf msf;
-	  ioctl(fd, CDROMPLAYMSF, &msf);
-
-	inputs:
-	  cdrom_msf structure, describing a segment of music to play
-
-	outputs:	none
-
-	error return:
-	  ENOSYS	cd drive not audio-capable.
-
-	notes:
-	  MSF stands for minutes-seconds-frames
-	  LBA stands for logical block address
-
-	  Segment is described as start and end times, where each time
-	  is described as minutes:seconds:frames.  A frame is 1/75 of
-	  a second.
-
-
-CDROMPLAYTRKIND			Play Audio Track/index (struct cdrom_ti)
-
-	usage:
-
-	  struct cdrom_ti ti;
-	  ioctl(fd, CDROMPLAYTRKIND, &ti);
-
-	inputs:
-	  cdrom_ti structure, describing a segment of music to play
-
-	outputs:	none
-
-	error return:
-	  ENOSYS	cd drive not audio-capable.
-
-	notes:
-	  Segment is described as start and end times, where each time
-	  is described as a track and an index.
-
-
-
-CDROMREADTOCHDR			Read TOC header (struct cdrom_tochdr)
-
-	usage:
-
-	  cdrom_tochdr header;
-	  ioctl(fd, CDROMREADTOCHDR, &header);
-
-	inputs:
-	  cdrom_tochdr structure
-
-	outputs:
-	  cdrom_tochdr structure
-
-	error return:
-	  ENOSYS	cd drive not audio-capable.
-
-
-
-CDROMREADTOCENTRY		Read TOC entry (struct cdrom_tocentry)
-
-	usage:
-
-	  struct cdrom_tocentry entry;
-	  ioctl(fd, CDROMREADTOCENTRY, &entry);
-
-	inputs:
-	  cdrom_tocentry structure
-
-	outputs:
-	  cdrom_tocentry structure
-
-	error return:
-	  ENOSYS	cd drive not audio-capable.
-	  EINVAL	entry.cdte_format not CDROM_MSF or CDROM_LBA
-	  EINVAL	requested track out of bounds
-	  EIO		I/O error reading TOC
-
-	notes:
-	  TOC stands for Table Of Contents
-	  MSF stands for minutes-seconds-frames
-	  LBA stands for logical block address
-
-
-
-CDROMSTOP			Stop the cdrom drive
-
-	usage:
-
-	  ioctl(fd, CDROMSTOP, 0);
-
-	inputs:		none
-
-	outputs:	none
-
-	error return:
-	  ENOSYS	cd drive not audio-capable.
-
-	notes:
-	  Exact interpretation of this ioctl depends on the device,
-	  but most seem to spin the drive down.
-
-
-CDROMSTART			Start the cdrom drive
-
-	usage:
-
-	  ioctl(fd, CDROMSTART, 0);
-
-	inputs:		none
-
-	outputs:	none
-
-	error return:
-	  ENOSYS	cd drive not audio-capable.
-
-	notes:
-	  Exact interpretation of this ioctl depends on the device,
-	  but most seem to spin the drive up and/or close the tray.
-	  Other devices ignore the ioctl completely.
-
-
-CDROMEJECT			Ejects the cdrom media
-
-	usage:
-
-	  ioctl(fd, CDROMEJECT, 0);
-
-	inputs:		none
-
-	outputs:	none
-
-	error returns:
-	  ENOSYS	cd drive not capable of ejecting
-	  EBUSY		other processes are accessing drive, or door is locked
-
-	notes:
-	  See CDROM_LOCKDOOR, below.
-
-
-
-CDROMCLOSETRAY			pendant of CDROMEJECT
-
-	usage:
-
-	  ioctl(fd, CDROMCLOSETRAY, 0);
-
-	inputs:		none
-
-	outputs:	none
-
-	error returns:
-	  ENOSYS	cd drive not capable of closing the tray
-	  EBUSY		other processes are accessing drive, or door is locked
-
-	notes:
-	  See CDROM_LOCKDOOR, below.
-
-
-
-CDROMVOLCTRL			Control output volume (struct cdrom_volctrl)
-
-	usage:
-
-	  struct cdrom_volctrl volume;
-	  ioctl(fd, CDROMVOLCTRL, &volume);
-
-	inputs:
-	  cdrom_volctrl structure containing volumes for up to 4
-	  channels.
-
-	outputs:	none
-
-	error return:
-	  ENOSYS	cd drive not audio-capable.
-
-
-
-CDROMVOLREAD			Get the drive's volume setting
-					  (struct cdrom_volctrl)
-
-	usage:
-
-	  struct cdrom_volctrl volume;
-	  ioctl(fd, CDROMVOLREAD, &volume);
-
-	inputs:		none
-
-	outputs:
-	  The current volume settings.
-
-	error return:
-	  ENOSYS	cd drive not audio-capable.
-
-
-
-CDROMSUBCHNL			Read subchannel data (struct cdrom_subchnl)
-
-	usage:
-
-	  struct cdrom_subchnl q;
-	  ioctl(fd, CDROMSUBCHNL, &q);
-
-	inputs:
-	  cdrom_subchnl structure
-
-	outputs:
-	  cdrom_subchnl structure
-
-	error return:
-	  ENOSYS	cd drive not audio-capable.
-	  EINVAL	format not CDROM_MSF or CDROM_LBA
-
-	notes:
-	  Format is converted to CDROM_MSF or CDROM_LBA
-	  as per user request on return
-
-
-
-CDROMREADRAW			read data in raw mode (2352 Bytes)
-					   (struct cdrom_read)
-
-	usage:
-
-	  union {
-	    struct cdrom_msf msf;		/* input */
-	    char buffer[CD_FRAMESIZE_RAW];	/* return */
-	  } arg;
-	  ioctl(fd, CDROMREADRAW, &arg);
-
-	inputs:
-	  cdrom_msf structure indicating an address to read.
-	  Only the start values are significant.
-
-	outputs:
-	  Data written to address provided by user.
-
-	error return:
-	  EINVAL	address less than 0, or msf less than 0:2:0
-	  ENOMEM	out of memory
-
-	notes:
-	  As of 2.6.8.1, comments in <linux/cdrom.h> indicate that this
-	  ioctl accepts a cdrom_read structure, but actual source code
-	  reads a cdrom_msf structure and writes a buffer of data to
-	  the same address.
-
-	  MSF values are converted to LBA values via this formula:
-
-	    lba = (((m * CD_SECS) + s) * CD_FRAMES + f) - CD_MSF_OFFSET;
-
-
-
-
-CDROMREADMODE1			Read CDROM mode 1 data (2048 Bytes)
-					   (struct cdrom_read)
-
-	notes:
-	  Identical to CDROMREADRAW except that block size is
-	  CD_FRAMESIZE (2048) bytes
-
-
-
-CDROMREADMODE2			Read CDROM mode 2 data (2336 Bytes)
-					   (struct cdrom_read)
-
-	notes:
-	  Identical to CDROMREADRAW except that block size is
-	  CD_FRAMESIZE_RAW0 (2336) bytes
-
-
-
-CDROMREADAUDIO			(struct cdrom_read_audio)
-
-	usage:
-
-	  struct cdrom_read_audio ra;
-	  ioctl(fd, CDROMREADAUDIO, &ra);
-
-	inputs:
-	  cdrom_read_audio structure containing read start
-	  point and length
-
-	outputs:
-	  audio data, returned to buffer indicated by ra
-
-	error return:
-	  EINVAL	format not CDROM_MSF or CDROM_LBA
-	  EINVAL	nframes not in range [1 75]
-	  ENXIO		drive has no queue (probably means invalid fd)
-	  ENOMEM	out of memory
-
-
-CDROMEJECT_SW			enable(1)/disable(0) auto-ejecting
-
-	usage:
-
-	  int val;
-	  ioctl(fd, CDROMEJECT_SW, val);
-
-	inputs:
-	  Flag specifying auto-eject flag.
-
-	outputs:	none
-
-	error return:
-	  ENOSYS	Drive is not capable of ejecting.
-	  EBUSY		Door is locked
-
-
-
-
-CDROMMULTISESSION		Obtain the start-of-last-session
-				  address of multi session disks
-				  (struct cdrom_multisession)
-	usage:
-
-	  struct cdrom_multisession ms_info;
-	  ioctl(fd, CDROMMULTISESSION, &ms_info);
-
-	inputs:
-	  cdrom_multisession structure containing desired
-	  format.
-
-	outputs:
-	  cdrom_multisession structure is filled with last_session
-	  information.
-
-	error return:
-	  EINVAL	format not CDROM_MSF or CDROM_LBA
-
-
-CDROM_GET_MCN			Obtain the "Universal Product Code"
-				   if available (struct cdrom_mcn)
-
-	usage:
-
-	  struct cdrom_mcn mcn;
-	  ioctl(fd, CDROM_GET_MCN, &mcn);
-
-	inputs:		none
-
-	outputs:
-	  Universal Product Code
-
-	error return:
-	  ENOSYS	Drive is not capable of reading MCN data.
-
-	notes:
-	  Source code comments state:
-
-	    The following function is implemented, although very few
-	    audio discs give Universal Product Code information, which
-	    should just be the Medium Catalog Number on the box.  Note,
-	    that the way the code is written on the CD is /not/ uniform
-	    across all discs!
-
-
-
-
-CDROM_GET_UPC			CDROM_GET_MCN  (deprecated)
-
-	Not implemented, as of 2.6.8.1
-
-
-
-CDROMRESET			hard-reset the drive
-
-	usage:
-
-	  ioctl(fd, CDROMRESET, 0);
-
-	inputs:		none
-
-	outputs:	none
-
-	error return:
-	  EACCES	Access denied:  requires CAP_SYS_ADMIN
-	  ENOSYS	Drive is not capable of resetting.
-
-
-
-
-CDROMREADCOOKED			read data in cooked mode
-
-	usage:
-
-	  u8 buffer[CD_FRAMESIZE]
-	  ioctl(fd, CDROMREADCOOKED, buffer);
-
-	inputs:		none
-
-	outputs:
-	  2048 bytes of data, "cooked" mode.
-
-	notes:
-	  Not implemented on all drives.
-
-
-
-
-CDROMREADALL			read all 2646 bytes
-
-	Same as CDROMREADCOOKED, but reads 2646 bytes.
-
-
-
-CDROMSEEK			seek msf address
-
-	usage:
-
-	  struct cdrom_msf msf;
-	  ioctl(fd, CDROMSEEK, &msf);
-
-	inputs:
-	  MSF address to seek to.
-
-	outputs:	none
-
-
-
-CDROMPLAYBLK			scsi-cd only, (struct cdrom_blk)
-
-	usage:
-
-	  struct cdrom_blk blk;
-	  ioctl(fd, CDROMPLAYBLK, &blk);
-
-	inputs:
-	  Region to play
-
-	outputs:	none
-
-
-
-CDROMGETSPINDOWN
-
-	usage:
-
-	  char spindown;
-	  ioctl(fd, CDROMGETSPINDOWN, &spindown);
-
-	inputs:		none
-
-	outputs:
-	  The value of the current 4-bit spindown value.
-
-
-
-
-CDROMSETSPINDOWN
-
-	usage:
-
-	  char spindown
-	  ioctl(fd, CDROMSETSPINDOWN, &spindown);
-
-	inputs:
-	  4-bit value used to control spindown (TODO: more detail here)
-
-	outputs:	none
-
-
-
-
-
-CDROM_SET_OPTIONS		Set behavior options
-
-	usage:
-
-	  int options;
-	  ioctl(fd, CDROM_SET_OPTIONS, options);
-
-	inputs:
-	  New values for drive options.  The logical 'or' of:
-	    CDO_AUTO_CLOSE	close tray on first open(2)
-	    CDO_AUTO_EJECT	open tray on last release
-	    CDO_USE_FFLAGS	use O_NONBLOCK information on open
-	    CDO_LOCK		lock tray on open files
-	    CDO_CHECK_TYPE	check type on open for data
-
-	outputs:
-	  Returns the resulting options settings in the
-	  ioctl return value.  Returns -1 on error.
-
-	error return:
-	  ENOSYS	selected option(s) not supported by drive.
-
-
-
-
-CDROM_CLEAR_OPTIONS		Clear behavior options
-
-	Same as CDROM_SET_OPTIONS, except that selected options are
-	turned off.
-
-
-
-CDROM_SELECT_SPEED		Set the CD-ROM speed
-
-	usage:
-
-	  int speed;
-	  ioctl(fd, CDROM_SELECT_SPEED, speed);
-
-	inputs:
-	  New drive speed.
-
-	outputs:	none
-
-	error return:
-	  ENOSYS	speed selection not supported by drive.
-
-
-
-CDROM_SELECT_DISC		Select disc (for juke-boxes)
-
-	usage:
-
-	  int disk;
-	  ioctl(fd, CDROM_SELECT_DISC, disk);
-
-	inputs:
-	  Disk to load into drive.
-
-	outputs:	none
-
-	error return:
-	  EINVAL	Disk number beyond capacity of drive
-
-
-
-CDROM_MEDIA_CHANGED		Check is media changed
-
-	usage:
-
-	  int slot;
-	  ioctl(fd, CDROM_MEDIA_CHANGED, slot);
-
-	inputs:
-	  Slot number to be tested, always zero except for jukeboxes.
-	  May also be special values CDSL_NONE or CDSL_CURRENT
-
-	outputs:
-	  Ioctl return value is 0 or 1 depending on whether the media
-	  has been changed, or -1 on error.
-
-	error returns:
-	  ENOSYS	Drive can't detect media change
-	  EINVAL	Slot number beyond capacity of drive
-	  ENOMEM	Out of memory
-
-
-
-CDROM_DRIVE_STATUS		Get tray position, etc.
-
-	usage:
-
-	  int slot;
-	  ioctl(fd, CDROM_DRIVE_STATUS, slot);
-
-	inputs:
-	  Slot number to be tested, always zero except for jukeboxes.
-	  May also be special values CDSL_NONE or CDSL_CURRENT
-
-	outputs:
-	  Ioctl return value will be one of the following values
-	  from <linux/cdrom.h>:
-
-	    CDS_NO_INFO		Information not available.
-	    CDS_NO_DISC
-	    CDS_TRAY_OPEN
-	    CDS_DRIVE_NOT_READY
-	    CDS_DISC_OK
-	    -1			error
-
-	error returns:
-	  ENOSYS	Drive can't detect drive status
-	  EINVAL	Slot number beyond capacity of drive
-	  ENOMEM	Out of memory
-
-
-
-
-CDROM_DISC_STATUS		Get disc type, etc.
-
-	usage:
-
-	  ioctl(fd, CDROM_DISC_STATUS, 0);
-
-	inputs:		none
-
-	outputs:
-	  Ioctl return value will be one of the following values
-	  from <linux/cdrom.h>:
-	    CDS_NO_INFO
-	    CDS_AUDIO
-	    CDS_MIXED
-	    CDS_XA_2_2
-	    CDS_XA_2_1
-	    CDS_DATA_1
-
-	error returns:	none at present
-
-	notes:
-	  Source code comments state:
-
-	    Ok, this is where problems start.  The current interface for
-	    the CDROM_DISC_STATUS ioctl is flawed.  It makes the false
-	    assumption that CDs are all CDS_DATA_1 or all CDS_AUDIO, etc.
-	    Unfortunately, while this is often the case, it is also
-	    very common for CDs to have some tracks with data, and some
-	    tracks with audio.	Just because I feel like it, I declare
-	    the following to be the best way to cope.  If the CD has
-	    ANY data tracks on it, it will be returned as a data CD.
-	    If it has any XA tracks, I will return it as that.	Now I
-	    could simplify this interface by combining these returns with
-	    the above, but this more clearly demonstrates the problem
-	    with the current interface.  Too bad this wasn't designed
-	    to use bitmasks...	       -Erik
-
-	    Well, now we have the option CDS_MIXED: a mixed-type CD.
-	    User level programmers might feel the ioctl is not very
-	    useful.
-			---david
-
-
-
-
-CDROM_CHANGER_NSLOTS		Get number of slots
-
-	usage:
-
-	  ioctl(fd, CDROM_CHANGER_NSLOTS, 0);
-
-	inputs:		none
-
-	outputs:
-	  The ioctl return value will be the number of slots in a
-	  CD changer.  Typically 1 for non-multi-disk devices.
-
-	error returns:	none
-
-
-
-CDROM_LOCKDOOR			lock or unlock door
-
-	usage:
-
-	  int lock;
-	  ioctl(fd, CDROM_LOCKDOOR, lock);
-
-	inputs:
-	  Door lock flag, 1=lock, 0=unlock
-
-	outputs:	none
-
-	error returns:
-	  EDRIVE_CANT_DO_THIS	Door lock function not supported.
-	  EBUSY			Attempt to unlock when multiple users
-	  			have the drive open and not CAP_SYS_ADMIN
-
-	notes:
-	  As of 2.6.8.1, the lock flag is a global lock, meaning that
-	  all CD drives will be locked or unlocked together.  This is
-	  probably a bug.
-
-	  The EDRIVE_CANT_DO_THIS value is defined in <linux/cdrom.h>
-	  and is currently (2.6.8.1) the same as EOPNOTSUPP
-
-
-
-CDROM_DEBUG			Turn debug messages on/off
-
-	usage:
-
-	  int debug;
-	  ioctl(fd, CDROM_DEBUG, debug);
-
-	inputs:
-	  Cdrom debug flag, 0=disable, 1=enable
-
-	outputs:
-	  The ioctl return value will be the new debug flag.
-
-	error return:
-	  EACCES	Access denied:  requires CAP_SYS_ADMIN
-
-
-
-CDROM_GET_CAPABILITY		get capabilities
-
-	usage:
-
-	  ioctl(fd, CDROM_GET_CAPABILITY, 0);
-
-	inputs:		none
-
-	outputs:
-	  The ioctl return value is the current device capability
-	  flags.  See CDC_CLOSE_TRAY, CDC_OPEN_TRAY, etc.
-
-
-
-CDROMAUDIOBUFSIZ		set the audio buffer size
-
-	usage:
-
-	  int arg;
-	  ioctl(fd, CDROMAUDIOBUFSIZ, val);
-
-	inputs:
-	  New audio buffer size
-
-	outputs:
-	  The ioctl return value is the new audio buffer size, or -1
-	  on error.
-
-	error return:
-	  ENOSYS	Not supported by this driver.
-
-	notes:
-	  Not supported by all drivers.
-
-
-
-DVD_READ_STRUCT			Read structure
-
-	usage:
-
-	  dvd_struct s;
-	  ioctl(fd, DVD_READ_STRUCT, &s);
-
-	inputs:
-	  dvd_struct structure, containing:
-	    type		specifies the information desired, one of
-	    			DVD_STRUCT_PHYSICAL, DVD_STRUCT_COPYRIGHT,
-				DVD_STRUCT_DISCKEY, DVD_STRUCT_BCA,
-				DVD_STRUCT_MANUFACT
-	    physical.layer_num	desired layer, indexed from 0
-	    copyright.layer_num	desired layer, indexed from 0
-	    disckey.agid
-
-	outputs:
-	  dvd_struct structure, containing:
-	    physical		for type == DVD_STRUCT_PHYSICAL
-	    copyright		for type == DVD_STRUCT_COPYRIGHT
-	    disckey.value	for type == DVD_STRUCT_DISCKEY
-	    bca.{len,value}	for type == DVD_STRUCT_BCA
-	    manufact.{len,valu}	for type == DVD_STRUCT_MANUFACT
-
-	error returns:
-	  EINVAL	physical.layer_num exceeds number of layers
-	  EIO		Received invalid response from drive
-
-
-
-DVD_WRITE_STRUCT		Write structure
-
-	Not implemented, as of 2.6.8.1
-
-
-
-DVD_AUTH			Authentication
-
-	usage:
-
-	  dvd_authinfo ai;
-	  ioctl(fd, DVD_AUTH, &ai);
-
-	inputs:
-	  dvd_authinfo structure.  See <linux/cdrom.h>
-
-	outputs:
-	  dvd_authinfo structure.
-
-	error return:
-	  ENOTTY	ai.type not recognized.
-
-
-
-CDROM_SEND_PACKET		send a packet to the drive
-
-	usage:
-
-	  struct cdrom_generic_command cgc;
-	  ioctl(fd, CDROM_SEND_PACKET, &cgc);
-
-	inputs:
-	  cdrom_generic_command structure containing the packet to send.
-
-	outputs:	none
-	  cdrom_generic_command structure containing results.
-
-	error return:
-	  EIO		command failed.
-	  EPERM		Operation not permitted, either because a
-			write command was attempted on a drive which
-			is opened read-only, or because the command
-			requires CAP_SYS_RAWIO
-	  EINVAL	cgc.data_direction not set
-
-
-
-CDROM_NEXT_WRITABLE		get next writable block
-
-	usage:
-
-	  long next;
-	  ioctl(fd, CDROM_NEXT_WRITABLE, &next);
-
-	inputs:		none
-
-	outputs:
-	  The next writable block.
-
-	notes:
-	  If the device does not support this ioctl directly, the
-	  ioctl will return CDROM_LAST_WRITTEN + 7.
-
-
-
-CDROM_LAST_WRITTEN		get last block written on disc
-
-	usage:
-
-	  long last;
-	  ioctl(fd, CDROM_LAST_WRITTEN, &last);
-
-	inputs:		none
-
-	outputs:
-	  The last block written on disc
-
-	notes:
-	  If the device does not support this ioctl directly, the
-	  result is derived from the disc's table of contents.  If the
-	  table of contents can't be read, this ioctl returns an
-	  error.
diff --git a/Documentation/ioctl/hdio.txt b/Documentation/ioctl/hdio.rst
similarity index 54%
rename from Documentation/ioctl/hdio.txt
rename to Documentation/ioctl/hdio.rst
index 18eb98c44ffe..e822e3dff176 100644
--- a/Documentation/ioctl/hdio.txt
+++ b/Documentation/ioctl/hdio.rst
@@ -1,9 +1,10 @@
-		Summary of HDIO_ ioctl calls.
-		============================
+==============================
+Summary of `HDIO_` ioctl calls
+==============================
 
-		Edward A. Falk <efalk@google.com>
+- Edward A. Falk <efalk@google.com>
 
-		November, 2004
+November, 2004
 
 This document attempts to describe the ioctl(2) calls supported by
 the HD/IDE layer.  These are by-and-large implemented (as of Linux 2.6)
@@ -14,6 +15,7 @@ are as follows:
 
     ioctls that pass argument pointers to user space:
 
+	=======================	=======================================
 	HDIO_GETGEO		get device geometry
 	HDIO_GET_UNMASKINTR	get current unmask setting
 	HDIO_GET_MULTCOUNT	get current IDE blockmode setting
@@ -36,9 +38,11 @@ are as follows:
 	HDIO_DRIVE_TASK		execute task and special drive command
 	HDIO_DRIVE_CMD		execute a special drive command
 	HDIO_DRIVE_CMD_AEB	HDIO_DRIVE_TASK
+	=======================	=======================================
 
     ioctls that pass non-pointer values:
 
+	=======================	=======================================
 	HDIO_SET_MULTCOUNT	change IDE blockmode
 	HDIO_SET_UNMASKINTR	permit other irqs during I/O
 	HDIO_SET_KEEPSETTINGS	keep ioctl settings on reset
@@ -57,16 +61,13 @@ are as follows:
 
 	HDIO_SET_IDE_SCSI	Set scsi emulation mode on/off
 	HDIO_SET_SCSI_IDE	not implemented yet
+	=======================	=======================================
 
 
 The information that follows was determined from reading kernel source
 code.  It is likely that some corrections will be made over time.
 
-
-
-
-
-
+------------------------------------------------------------------------------
 
 General:
 
@@ -80,459 +81,610 @@ General:
 	Unless otherwise specified, all data structures and constants
 	are defined in <linux/hdreg.h>
 
+------------------------------------------------------------------------------
 
+HDIO_GETGEO
+	get device geometry
 
-HDIO_GETGEO			get device geometry
 
-	usage:
+	usage::
 
 	  struct hd_geometry geom;
+
 	  ioctl(fd, HDIO_GETGEO, &geom);
 
 
-	inputs:		none
+	inputs:
+		none
+
+
 
 	outputs:
+		hd_geometry structure containing:
 
-	  hd_geometry structure containing:
 
+	    =========	==================================
 	    heads	number of heads
 	    sectors	number of sectors/track
 	    cylinders	number of cylinders, mod 65536
 	    start	starting sector of this partition.
+	    =========	==================================
 
 
 	error returns:
-	  EINVAL	if the device is not a disk drive or floppy drive,
-	  		or if the user passes a null pointer
+	  - EINVAL
+
+			if the device is not a disk drive or floppy drive,
+			or if the user passes a null pointer
 
 
 	notes:
+		Not particularly useful with modern disk drives, whose geometry
+		is a polite fiction anyway.  Modern drives are addressed
+		purely by sector number nowadays (lba addressing), and the
+		drive geometry is an abstraction which is actually subject
+		to change.  Currently (as of Nov 2004), the geometry values
+		are the "bios" values -- presumably the values the drive had
+		when Linux first booted.
 
-	  Not particularly useful with modern disk drives, whose geometry
-	  is a polite fiction anyway.  Modern drives are addressed
-	  purely by sector number nowadays (lba addressing), and the
-	  drive geometry is an abstraction which is actually subject
-	  to change.  Currently (as of Nov 2004), the geometry values
-	  are the "bios" values -- presumably the values the drive had
-	  when Linux first booted.
+		In addition, the cylinders field of the hd_geometry is an
+		unsigned short, meaning that on most architectures, this
+		ioctl will not return a meaningful value on drives with more
+		than 65535 tracks.
 
-	  In addition, the cylinders field of the hd_geometry is an
-	  unsigned short, meaning that on most architectures, this
-	  ioctl will not return a meaningful value on drives with more
-	  than 65535 tracks.
+		The start field is unsigned long, meaning that it will not
+		contain a meaningful value for disks over 219 Gb in size.
 
-	  The start field is unsigned long, meaning that it will not
-	  contain a meaningful value for disks over 219 Gb in size.
 
 
 
+HDIO_GET_UNMASKINTR
+	get current unmask setting
 
-HDIO_GET_UNMASKINTR		get current unmask setting
 
-	usage:
+	usage::
 
 	  long val;
+
 	  ioctl(fd, HDIO_GET_UNMASKINTR, &val);
 
-	inputs:		none
+	inputs:
+		none
+
+
 
 	outputs:
-	  The value of the drive's current unmask setting
+		The value of the drive's current unmask setting
 
 
 
-HDIO_SET_UNMASKINTR		permit other irqs during I/O
 
-	usage:
+
+HDIO_SET_UNMASKINTR
+	permit other irqs during I/O
+
+
+	usage::
 
 	  unsigned long val;
+
 	  ioctl(fd, HDIO_SET_UNMASKINTR, val);
 
 	inputs:
-	  New value for unmask flag
+		New value for unmask flag
+
+
+
+	outputs:
+		none
+
 
-	outputs:	none
 
 	error return:
-	  EINVAL	(bdev != bdev->bd_contains) (not sure what this means)
-	  EACCES	Access denied:  requires CAP_SYS_ADMIN
-	  EINVAL	value out of range [0 1]
-	  EBUSY		Controller busy
+	  - EINVAL	(bdev != bdev->bd_contains) (not sure what this means)
+	  - EACCES	Access denied:  requires CAP_SYS_ADMIN
+	  - EINVAL	value out of range [0 1]
+	  - EBUSY	Controller busy
 
 
 
 
-HDIO_GET_MULTCOUNT		get current IDE blockmode setting
+HDIO_GET_MULTCOUNT
+	get current IDE blockmode setting
 
-	usage:
+
+	usage::
 
 	  long val;
+
 	  ioctl(fd, HDIO_GET_MULTCOUNT, &val);
 
-	inputs:		none
+	inputs:
+		none
+
+
 
 	outputs:
-	  The value of the current IDE block mode setting.  This
-	  controls how many sectors the drive will transfer per
-	  interrupt.
+		The value of the current IDE block mode setting.  This
+		controls how many sectors the drive will transfer per
+		interrupt.
 
 
 
-HDIO_SET_MULTCOUNT		change IDE blockmode
+HDIO_SET_MULTCOUNT
+	change IDE blockmode
 
-	usage:
+
+	usage::
 
 	  int val;
+
 	  ioctl(fd, HDIO_SET_MULTCOUNT, val);
 
 	inputs:
-	  New value for IDE block mode setting.  This controls how many
-	  sectors the drive will transfer per interrupt.
+		New value for IDE block mode setting.  This controls how many
+		sectors the drive will transfer per interrupt.
+
+	outputs:
+		none
+
 
-	outputs:	none
 
 	error return:
-	  EINVAL	(bdev != bdev->bd_contains) (not sure what this means)
-	  EACCES	Access denied:  requires CAP_SYS_ADMIN
-	  EINVAL	value out of range supported by disk.
-	  EBUSY		Controller busy or blockmode already set.
-	  EIO		Drive did not accept new block mode.
+	  - EINVAL	(bdev != bdev->bd_contains) (not sure what this means)
+	  - EACCES	Access denied:  requires CAP_SYS_ADMIN
+	  - EINVAL	value out of range supported by disk.
+	  - EBUSY	Controller busy or blockmode already set.
+	  - EIO		Drive did not accept new block mode.
 
 	notes:
-
-	  Source code comments read:
+	  Source code comments read::
 
 	    This is tightly woven into the driver->do_special cannot
 	    touch.  DON'T do it again until a total personality rewrite
 	    is committed.
 
 	  If blockmode has already been set, this ioctl will fail with
-	  EBUSY
+	  -EBUSY
 
 
 
-HDIO_GET_QDMA			get use-qdma flag
+HDIO_GET_QDMA
+	get use-qdma flag
+
 
 	Not implemented, as of 2.6.8.1
 
 
 
-HDIO_SET_XFER			set transfer rate via proc
+HDIO_SET_XFER
+	set transfer rate via proc
+
 
 	Not implemented, as of 2.6.8.1
 
 
 
-HDIO_OBSOLETE_IDENTITY		OBSOLETE, DO NOT USE
+HDIO_OBSOLETE_IDENTITY
+	OBSOLETE, DO NOT USE
+
 
 	Same as HDIO_GET_IDENTITY (see below), except that it only
 	returns the first 142 bytes of drive identity information.
 
 
 
-HDIO_GET_IDENTITY		get IDE identification info
+HDIO_GET_IDENTITY
+	get IDE identification info
 
-	usage:
+
+	usage::
 
 	  unsigned char identity[512];
+
 	  ioctl(fd, HDIO_GET_IDENTITY, identity);
 
-	inputs:		none
+	inputs:
+		none
+
+
 
 	outputs:
-
-	  ATA drive identity information.  For full description, see
-	  the IDENTIFY DEVICE and IDENTIFY PACKET DEVICE commands in
-	  the ATA specification.
+		ATA drive identity information.  For full description, see
+		the IDENTIFY DEVICE and IDENTIFY PACKET DEVICE commands in
+		the ATA specification.
 
 	error returns:
-	  EINVAL	(bdev != bdev->bd_contains) (not sure what this means)
-	  ENOMSG	IDENTIFY DEVICE information not available
+	  - EINVAL	(bdev != bdev->bd_contains) (not sure what this means)
+	  - ENOMSG	IDENTIFY DEVICE information not available
 
 	notes:
+		Returns information that was obtained when the drive was
+		probed.  Some of this information is subject to change, and
+		this ioctl does not re-probe the drive to update the
+		information.
 
-	  Returns information that was obtained when the drive was
-	  probed.  Some of this information is subject to change, and
-	  this ioctl does not re-probe the drive to update the
-	  information.
+		This information is also available from /proc/ide/hdX/identify
 
-	  This information is also available from /proc/ide/hdX/identify
 
 
+HDIO_GET_KEEPSETTINGS
+	get keep-settings-on-reset flag
 
-HDIO_GET_KEEPSETTINGS		get keep-settings-on-reset flag
 
-	usage:
+	usage::
 
 	  long val;
+
 	  ioctl(fd, HDIO_GET_KEEPSETTINGS, &val);
 
-	inputs:		none
+	inputs:
+		none
+
+
 
 	outputs:
-	  The value of the current "keep settings" flag
+		The value of the current "keep settings" flag
+
+
 
 	notes:
+		When set, indicates that kernel should restore settings
+		after a drive reset.
 
-	  When set, indicates that kernel should restore settings
-	  after a drive reset.
 
 
+HDIO_SET_KEEPSETTINGS
+	keep ioctl settings on reset
 
-HDIO_SET_KEEPSETTINGS		keep ioctl settings on reset
 
-	usage:
+	usage::
 
 	  long val;
+
 	  ioctl(fd, HDIO_SET_KEEPSETTINGS, val);
 
 	inputs:
-	  New value for keep_settings flag
+		New value for keep_settings flag
+
+
+
+	outputs:
+		none
+
 
-	outputs:	none
 
 	error return:
-	  EINVAL	(bdev != bdev->bd_contains) (not sure what this means)
-	  EACCES	Access denied:  requires CAP_SYS_ADMIN
-	  EINVAL	value out of range [0 1]
-	  EBUSY		Controller busy
+	  - EINVAL	(bdev != bdev->bd_contains) (not sure what this means)
+	  - EACCES	Access denied:  requires CAP_SYS_ADMIN
+	  - EINVAL	value out of range [0 1]
+	  - EBUSY		Controller busy
 
 
 
-HDIO_GET_32BIT			get current io_32bit setting
+HDIO_GET_32BIT
+	get current io_32bit setting
 
-	usage:
+
+	usage::
 
 	  long val;
+
 	  ioctl(fd, HDIO_GET_32BIT, &val);
 
-	inputs:		none
+	inputs:
+		none
+
+
 
 	outputs:
-	  The value of the current io_32bit setting
+		The value of the current io_32bit setting
+
+
 
 	notes:
+		0=16-bit, 1=32-bit, 2,3 = 32bit+sync
 
-	  0=16-bit, 1=32-bit, 2,3 = 32bit+sync
 
 
 
-HDIO_GET_NOWERR			get ignore-write-error flag
 
-	usage:
+HDIO_GET_NOWERR
+	get ignore-write-error flag
+
+
+	usage::
 
 	  long val;
+
 	  ioctl(fd, HDIO_GET_NOWERR, &val);
 
-	inputs:		none
+	inputs:
+		none
+
+
 
 	outputs:
-	  The value of the current ignore-write-error flag
+		The value of the current ignore-write-error flag
 
 
 
-HDIO_GET_DMA			get use-dma flag
 
-	usage:
+
+HDIO_GET_DMA
+	get use-dma flag
+
+
+	usage::
 
 	  long val;
+
 	  ioctl(fd, HDIO_GET_DMA, &val);
 
-	inputs:		none
+	inputs:
+		none
+
+
 
 	outputs:
-	  The value of the current use-dma flag
+		The value of the current use-dma flag
 
 
 
-HDIO_GET_NICE			get nice flags
 
-	usage:
+
+HDIO_GET_NICE
+	get nice flags
+
+
+	usage::
 
 	  long nice;
+
 	  ioctl(fd, HDIO_GET_NICE, &nice);
 
-	inputs:		none
+	inputs:
+		none
+
+
 
 	outputs:
+		The drive's "nice" values.
+
 
-	  The drive's "nice" values.
 
 	notes:
+		Per-drive flags which determine when the system will give more
+		bandwidth to other devices sharing the same IDE bus.
 
-	  Per-drive flags which determine when the system will give more
-	  bandwidth to other devices sharing the same IDE bus.
-	  See <linux/hdreg.h>, near symbol IDE_NICE_DSC_OVERLAP.
+		See <linux/hdreg.h>, near symbol IDE_NICE_DSC_OVERLAP.
 
 
 
 
-HDIO_SET_NICE			set nice flags
+HDIO_SET_NICE
+	set nice flags
 
-	usage:
+
+	usage::
 
 	  unsigned long nice;
+
 	  ...
 	  ioctl(fd, HDIO_SET_NICE, nice);
 
 	inputs:
-	  bitmask of nice flags.
+		bitmask of nice flags.
+
+
+
+	outputs:
+		none
+
 
-	outputs:	none
 
 	error returns:
-	  EACCES	Access denied:  requires CAP_SYS_ADMIN
-	  EPERM		Flags other than DSC_OVERLAP and NICE_1 set.
-	  EPERM		DSC_OVERLAP specified but not supported by drive
+	  - EACCES	Access denied:  requires CAP_SYS_ADMIN
+	  - EPERM	Flags other than DSC_OVERLAP and NICE_1 set.
+	  - EPERM	DSC_OVERLAP specified but not supported by drive
 
 	notes:
+		This ioctl sets the DSC_OVERLAP and NICE_1 flags from values
+		provided by the user.
 
-	  This ioctl sets the DSC_OVERLAP and NICE_1 flags from values
-	  provided by the user.
+		Nice flags are listed in <linux/hdreg.h>, starting with
+		IDE_NICE_DSC_OVERLAP.  These values represent shifts.
 
-	  Nice flags are listed in <linux/hdreg.h>, starting with
-	  IDE_NICE_DSC_OVERLAP.  These values represent shifts.
 
 
 
 
+HDIO_GET_WCACHE
+	get write cache mode on|off
 
-HDIO_GET_WCACHE			get write cache mode on|off
 
-	usage:
+	usage::
 
 	  long val;
+
 	  ioctl(fd, HDIO_GET_WCACHE, &val);
 
-	inputs:		none
+	inputs:
+		none
+
+
 
 	outputs:
-	  The value of the current write cache mode
+		The value of the current write cache mode
 
 
 
-HDIO_GET_ACOUSTIC		get acoustic value
 
-	usage:
+
+HDIO_GET_ACOUSTIC
+	get acoustic value
+
+
+	usage::
 
 	  long val;
+
 	  ioctl(fd, HDIO_GET_ACOUSTIC, &val);
 
-	inputs:		none
+	inputs:
+		none
+
+
 
 	outputs:
-	  The value of the current acoustic settings
+		The value of the current acoustic settings
+
+
 
 	notes:
+		See HDIO_SET_ACOUSTIC
+
 
-	  See HDIO_SET_ACOUSTIC
 
 
 
 HDIO_GET_ADDRESS
+	usage::
 
-	usage:
 
 	  long val;
+
 	  ioctl(fd, HDIO_GET_ADDRESS, &val);
 
-	inputs:		none
+	inputs:
+		none
+
+
 
 	outputs:
-	  The value of the current addressing mode:
-	    0 = 28-bit
-	    1 = 48-bit
-	    2 = 48-bit doing 28-bit
-	    3 = 64-bit
+		The value of the current addressing mode:
 
+	    =  ===================
+	    0  28-bit
+	    1  48-bit
+	    2  48-bit doing 28-bit
+	    3  64-bit
+	    =  ===================
 
 
-HDIO_GET_BUSSTATE		get the bus state of the hwif
 
-	usage:
+HDIO_GET_BUSSTATE
+	get the bus state of the hwif
+
+
+	usage::
 
 	  long state;
+
 	  ioctl(fd, HDIO_SCAN_HWIF, &state);
 
-	inputs:		none
+	inputs:
+		none
+
+
 
 	outputs:
-	  Current power state of the IDE bus.  One of BUSSTATE_OFF,
-	  BUSSTATE_ON, or BUSSTATE_TRISTATE
+		Current power state of the IDE bus.  One of BUSSTATE_OFF,
+		BUSSTATE_ON, or BUSSTATE_TRISTATE
 
 	error returns:
-	  EACCES	Access denied:  requires CAP_SYS_ADMIN
+	  - EACCES	Access denied:  requires CAP_SYS_ADMIN
 
 
 
 
-HDIO_SET_BUSSTATE		set the bus state of the hwif
+HDIO_SET_BUSSTATE
+	set the bus state of the hwif
 
-	usage:
+
+	usage::
 
 	  int state;
+
 	  ...
 	  ioctl(fd, HDIO_SCAN_HWIF, state);
 
 	inputs:
-	  Desired IDE power state.  One of BUSSTATE_OFF, BUSSTATE_ON,
-	  or BUSSTATE_TRISTATE
+		Desired IDE power state.  One of BUSSTATE_OFF, BUSSTATE_ON,
+		or BUSSTATE_TRISTATE
+
+	outputs:
+		none
+
 
-	outputs:	none
 
 	error returns:
-	  EACCES	Access denied:  requires CAP_SYS_RAWIO
-	  EOPNOTSUPP	Hardware interface does not support bus power control
+	  - EACCES	Access denied:  requires CAP_SYS_RAWIO
+	  - EOPNOTSUPP	Hardware interface does not support bus power control
 
 
 
 
-HDIO_TRISTATE_HWIF		execute a channel tristate
+HDIO_TRISTATE_HWIF
+	execute a channel tristate
+
 
 	Not implemented, as of 2.6.8.1.  See HDIO_SET_BUSSTATE
 
 
 
-HDIO_DRIVE_RESET		execute a device reset
+HDIO_DRIVE_RESET
+	execute a device reset
 
-	usage:
+
+	usage::
 
 	  int args[3]
+
 	  ...
 	  ioctl(fd, HDIO_DRIVE_RESET, args);
 
-	inputs:		none
+	inputs:
+		none
+
+
+
+	outputs:
+		none
+
 
-	outputs:	none
 
 	error returns:
-	  EACCES	Access denied:  requires CAP_SYS_ADMIN
-	  ENXIO		No such device:	phy dead or ctl_addr == 0
-	  EIO		I/O error:	reset timed out or hardware error
+	  - EACCES	Access denied:  requires CAP_SYS_ADMIN
+	  - ENXIO	No such device:	phy dead or ctl_addr == 0
+	  - EIO		I/O error:	reset timed out or hardware error
 
 	notes:
 
-	  Execute a reset on the device as soon as the current IO
-	  operation has completed.
+	  - Execute a reset on the device as soon as the current IO
+	    operation has completed.
 
-	  Executes an ATAPI soft reset if applicable, otherwise
-	  executes an ATA soft reset on the controller.
+	  - Executes an ATAPI soft reset if applicable, otherwise
+	    executes an ATA soft reset on the controller.
 
 
 
-HDIO_DRIVE_TASKFILE		execute raw taskfile
+HDIO_DRIVE_TASKFILE
+	execute raw taskfile
 
-	Note:  If you don't have a copy of the ANSI ATA specification
-	handy, you should probably ignore this ioctl.
 
-	Execute an ATA disk command directly by writing the "taskfile"
-	registers of the drive.  Requires ADMIN and RAWIO access
-	privileges.
+	Note:
+		If you don't have a copy of the ANSI ATA specification
+		handy, you should probably ignore this ioctl.
 
-	usage:
+	- Execute an ATA disk command directly by writing the "taskfile"
+	  registers of the drive.  Requires ADMIN and RAWIO access
+	  privileges.
+
+	usage::
 
 	  struct {
+
 	    ide_task_request_t req_task;
 	    u8 outbuf[OUTPUT_SIZE];
 	    u8 inbuf[INPUT_SIZE];
@@ -548,6 +700,7 @@ HDIO_DRIVE_TASKFILE		execute raw taskfile
 
 	  (See below for details on memory area passed to ioctl.)
 
+	  ============	===================================================
 	  io_ports[8]	values to be written to taskfile registers
 	  hob_ports[8]	high-order bytes, for extended commands.
 	  out_flags	flags indicating which registers are valid
@@ -557,24 +710,29 @@ HDIO_DRIVE_TASKFILE		execute raw taskfile
 	  out_size	size of output buffer
 	  outbuf	buffer of data to be transmitted to disk
 	  inbuf		buffer of data to be received from disk (see [1])
+	  ============	===================================================
 
 	outputs:
 
+	  ===========	====================================================
 	  io_ports[]	values returned in the taskfile registers
 	  hob_ports[]	high-order bytes, for extended commands.
 	  out_flags	flags indicating which registers are valid (see [2])
 	  in_flags	flags indicating which registers should be returned
 	  outbuf	buffer of data to be transmitted to disk (see [1])
 	  inbuf		buffer of data to be received from disk
+	  ===========	====================================================
 
 	error returns:
-	  EACCES	CAP_SYS_ADMIN or CAP_SYS_RAWIO privilege not set.
-	  ENOMSG	Device is not a disk drive.
-	  ENOMEM	Unable to allocate memory for task
-	  EFAULT	req_cmd == TASKFILE_IN_OUT (not implemented as of 2.6.8)
-	  EPERM		req_cmd == TASKFILE_MULTI_OUT and drive
-	  		multi-count not yet set.
-	  EIO		Drive failed the command.
+	  - EACCES	CAP_SYS_ADMIN or CAP_SYS_RAWIO privilege not set.
+	  - ENOMSG	Device is not a disk drive.
+	  - ENOMEM	Unable to allocate memory for task
+	  - EFAULT	req_cmd == TASKFILE_IN_OUT (not implemented as of 2.6.8)
+	  - EPERM
+
+			req_cmd == TASKFILE_MULTI_OUT and drive
+			multi-count not yet set.
+	  - EIO		Drive failed the command.
 
 	notes:
 
@@ -615,22 +773,25 @@ HDIO_DRIVE_TASKFILE		execute raw taskfile
 	  Command is passed to the disk drive via the ide_task_request_t
 	  structure, which contains these fields:
 
+	    ============	===============================================
 	    io_ports[8]		values for the taskfile registers
 	    hob_ports[8]	high-order bytes, for extended commands
 	    out_flags		flags indicating which entries in the
-	    			io_ports[] and hob_ports[] arrays
+				io_ports[] and hob_ports[] arrays
 				contain valid values.  Type ide_reg_valid_t.
 	    in_flags		flags indicating which entries in the
-	    			io_ports[] and hob_ports[] arrays
+				io_ports[] and hob_ports[] arrays
 				are expected to contain valid values
 				on return.
 	    data_phase		See below
 	    req_cmd		Command type, see below
 	    out_size		output (user->drive) buffer size, bytes
 	    in_size		input (drive->user) buffer size, bytes
+	    ============	===============================================
 
 	  When out_flags is zero, the following registers are loaded.
 
+	    ============	===============================================
 	    HOB_FEATURE		If the drive supports LBA48
 	    HOB_NSECTOR		If the drive supports LBA48
 	    HOB_SECTOR		If the drive supports LBA48
@@ -644,9 +805,11 @@ HDIO_DRIVE_TASKFILE		execute raw taskfile
 	    SELECT		First, masked with 0xE0 if LBA48, 0xEF
 				otherwise; then, or'ed with the default
 				value of SELECT.
+	    ============	===============================================
 
 	  If any bit in out_flags is set, the following registers are loaded.
 
+	    ============	===============================================
 	    HOB_DATA		If out_flags.b.data is set.  HOB_DATA will
 				travel on DD8-DD15 on little endian machines
 				and on DD0-DD7 on big endian machines.
@@ -664,6 +827,7 @@ HDIO_DRIVE_TASKFILE		execute raw taskfile
 	    HCYL		If out_flags.b.hcyl is set
 	    SELECT		Or'ed with the default value of SELECT and
 				loaded regardless of out_flags.b.select.
+	    ============	===============================================
 
 	  Taskfile registers are read back from the drive into
 	  {io|hob}_ports[] after the command completes iff one of the
@@ -674,6 +838,7 @@ HDIO_DRIVE_TASKFILE		execute raw taskfile
 	    2. One or more than one bits are set in out_flags.
 	    3. The requested data_phase is TASKFILE_NO_DATA.
 
+	    ============	===============================================
 	    HOB_DATA		If in_flags.b.data is set.  It will contain
 				DD8-DD15 on little endian machines and
 				DD0-DD7 on big endian machines.
@@ -689,10 +854,12 @@ HDIO_DRIVE_TASKFILE		execute raw taskfile
 	    SECTOR
 	    LCYL
 	    HCYL
+	    ============	===============================================
 
 	  The data_phase field describes the data transfer to be
 	  performed.  Value is one of:
 
+	    ===================        ========================================
 	    TASKFILE_IN
 	    TASKFILE_MULTI_IN
 	    TASKFILE_OUT
@@ -708,15 +875,18 @@ HDIO_DRIVE_TASKFILE		execute raw taskfile
 	    TASKFILE_P_OUT		unimplemented
 	    TASKFILE_P_OUT_DMA		unimplemented
 	    TASKFILE_P_OUT_DMAQ		unimplemented
+	    ===================        ========================================
 
 	  The req_cmd field classifies the command type.  It may be
 	  one of:
 
+	    ========================    =======================================
 	    IDE_DRIVE_TASK_NO_DATA
 	    IDE_DRIVE_TASK_SET_XFER	unimplemented
 	    IDE_DRIVE_TASK_IN
 	    IDE_DRIVE_TASK_OUT		unimplemented
 	    IDE_DRIVE_TASK_RAW_WRITE
+	    ========================    =======================================
 
 	  [6] Do not access {in|out}_flags->all except for resetting
 	  all the bits.  Always access individual bit fields.  ->all
@@ -726,45 +896,57 @@ HDIO_DRIVE_TASKFILE		execute raw taskfile
 
 
 
-HDIO_DRIVE_CMD			execute a special drive command
+HDIO_DRIVE_CMD
+	execute a special drive command
+
 
 	Note:  If you don't have a copy of the ANSI ATA specification
 	handy, you should probably ignore this ioctl.
 
-	usage:
+	usage::
 
 	  u8 args[4+XFER_SIZE];
+
 	  ...
 	  ioctl(fd, HDIO_DRIVE_CMD, args);
 
 	inputs:
+	    Commands other than WIN_SMART:
 
-	  Commands other than WIN_SMART
+	    =======     =======
 	    args[0]	COMMAND
 	    args[1]	NSECTOR
 	    args[2]	FEATURE
 	    args[3]	NSECTOR
+	    =======     =======
 
-	  WIN_SMART
+	    WIN_SMART:
+
+	    =======     =======
 	    args[0]	COMMAND
 	    args[1]	SECTOR
 	    args[2]	FEATURE
 	    args[3]	NSECTOR
+	    =======     =======
 
 	outputs:
+		args[] buffer is filled with register values followed by any
+
 
-	  args[] buffer is filled with register values followed by any
 	  data returned by the disk.
+
+	    ========	====================================================
 	    args[0]	status
 	    args[1]	error
 	    args[2]	NSECTOR
 	    args[3]	undefined
 	    args[4+]	NSECTOR * 512 bytes of data returned by the command.
+	    ========	====================================================
 
 	error returns:
-	  EACCES	Access denied:  requires CAP_SYS_RAWIO
-	  ENOMEM	Unable to allocate memory for task
-	  EIO		Drive reports error
+	  - EACCES	Access denied:  requires CAP_SYS_RAWIO
+	  - ENOMEM	Unable to allocate memory for task
+	  - EIO		Drive reports error
 
 	notes:
 
@@ -789,20 +971,24 @@ HDIO_DRIVE_CMD			execute a special drive command
 
 
 
-HDIO_DRIVE_TASK			execute task and special drive command
+HDIO_DRIVE_TASK
+	execute task and special drive command
+
 
 	Note:  If you don't have a copy of the ANSI ATA specification
 	handy, you should probably ignore this ioctl.
 
-	usage:
+	usage::
 
 	  u8 args[7];
+
 	  ...
 	  ioctl(fd, HDIO_DRIVE_TASK, args);
 
 	inputs:
+	    Taskfile register values:
 
-	  Taskfile register values:
+	    =======	=======
 	    args[0]	COMMAND
 	    args[1]	FEATURE
 	    args[2]	NSECTOR
@@ -810,10 +996,13 @@ HDIO_DRIVE_TASK			execute task and special drive command
 	    args[4]	LCYL
 	    args[5]	HCYL
 	    args[6]	SELECT
+	    =======	=======
 
 	outputs:
+	    Taskfile register values:
 
-	  Taskfile register values:
+
+	    =======	=======
 	    args[0]	status
 	    args[1]	error
 	    args[2]	NSECTOR
@@ -821,12 +1010,13 @@ HDIO_DRIVE_TASK			execute task and special drive command
 	    args[4]	LCYL
 	    args[5]	HCYL
 	    args[6]	SELECT
+	    =======	=======
 
 	error returns:
-	  EACCES	Access denied:  requires CAP_SYS_RAWIO
-	  ENOMEM	Unable to allocate memory for task
-	  ENOMSG	Device is not a disk drive.
-	  EIO		Drive failed the command.
+	  - EACCES	Access denied:  requires CAP_SYS_RAWIO
+	  - ENOMEM	Unable to allocate memory for task
+	  - ENOMSG	Device is not a disk drive.
+	  - EIO		Drive failed the command.
 
 	notes:
 
@@ -836,236 +1026,317 @@ HDIO_DRIVE_TASK			execute task and special drive command
 
 
 
-HDIO_DRIVE_CMD_AEB		HDIO_DRIVE_TASK
+HDIO_DRIVE_CMD_AEB
+	HDIO_DRIVE_TASK
+
 
 	Not implemented, as of 2.6.8.1
 
 
 
-HDIO_SET_32BIT			change io_32bit flags
+HDIO_SET_32BIT
+	change io_32bit flags
 
-	usage:
+
+	usage::
 
 	  int val;
+
 	  ioctl(fd, HDIO_SET_32BIT, val);
 
 	inputs:
-	  New value for io_32bit flag
+		New value for io_32bit flag
+
+
+
+	outputs:
+		none
+
 
-	outputs:	none
 
 	error return:
-	  EINVAL	(bdev != bdev->bd_contains) (not sure what this means)
-	  EACCES	Access denied:  requires CAP_SYS_ADMIN
-	  EINVAL	value out of range [0 3]
-	  EBUSY		Controller busy
+	  - EINVAL	(bdev != bdev->bd_contains) (not sure what this means)
+	  - EACCES	Access denied:  requires CAP_SYS_ADMIN
+	  - EINVAL	value out of range [0 3]
+	  - EBUSY	Controller busy
 
 
 
 
-HDIO_SET_NOWERR			change ignore-write-error flag
+HDIO_SET_NOWERR
+	change ignore-write-error flag
 
-	usage:
+
+	usage::
 
 	  int val;
+
 	  ioctl(fd, HDIO_SET_NOWERR, val);
 
 	inputs:
-	  New value for ignore-write-error flag.  Used for ignoring
+		New value for ignore-write-error flag.  Used for ignoring
+
+
 	  WRERR_STAT
 
-	outputs:	none
+	outputs:
+		none
+
+
 
 	error return:
-	  EINVAL	(bdev != bdev->bd_contains) (not sure what this means)
-	  EACCES	Access denied:  requires CAP_SYS_ADMIN
-	  EINVAL	value out of range [0 1]
-	  EBUSY		Controller busy
+	  - EINVAL	(bdev != bdev->bd_contains) (not sure what this means)
+	  - EACCES	Access denied:  requires CAP_SYS_ADMIN
+	  - EINVAL	value out of range [0 1]
+	  - EBUSY		Controller busy
 
 
 
-HDIO_SET_DMA			change use-dma flag
+HDIO_SET_DMA
+	change use-dma flag
 
-	usage:
+
+	usage::
 
 	  long val;
+
 	  ioctl(fd, HDIO_SET_DMA, val);
 
 	inputs:
-	  New value for use-dma flag
+		New value for use-dma flag
+
+
+
+	outputs:
+		none
+
 
-	outputs:	none
 
 	error return:
-	  EINVAL	(bdev != bdev->bd_contains) (not sure what this means)
-	  EACCES	Access denied:  requires CAP_SYS_ADMIN
-	  EINVAL	value out of range [0 1]
-	  EBUSY		Controller busy
+	  - EINVAL	(bdev != bdev->bd_contains) (not sure what this means)
+	  - EACCES	Access denied:  requires CAP_SYS_ADMIN
+	  - EINVAL	value out of range [0 1]
+	  - EBUSY	Controller busy
 
 
 
-HDIO_SET_PIO_MODE		reconfig interface to new speed
+HDIO_SET_PIO_MODE
+	reconfig interface to new speed
 
-	usage:
+
+	usage::
 
 	  long val;
+
 	  ioctl(fd, HDIO_SET_PIO_MODE, val);
 
 	inputs:
-	  New interface speed.
+		New interface speed.
+
+
+
+	outputs:
+		none
+
 
-	outputs:	none
 
 	error return:
-	  EINVAL	(bdev != bdev->bd_contains) (not sure what this means)
-	  EACCES	Access denied:  requires CAP_SYS_ADMIN
-	  EINVAL	value out of range [0 255]
-	  EBUSY		Controller busy
+	  - EINVAL	(bdev != bdev->bd_contains) (not sure what this means)
+	  - EACCES	Access denied:  requires CAP_SYS_ADMIN
+	  - EINVAL	value out of range [0 255]
+	  - EBUSY	Controller busy
 
 
 
-HDIO_SCAN_HWIF			register and (re)scan interface
+HDIO_SCAN_HWIF
+	register and (re)scan interface
 
-	usage:
+
+	usage::
 
 	  int args[3]
+
 	  ...
 	  ioctl(fd, HDIO_SCAN_HWIF, args);
 
 	inputs:
+
+	  =======	=========================
 	  args[0]	io address to probe
+
+
 	  args[1]	control address to probe
 	  args[2]	irq number
+	  =======	=========================
+
+	outputs:
+		none
+
 
-	outputs:	none
 
 	error returns:
-	  EACCES	Access denied:  requires CAP_SYS_RAWIO
-	  EIO		Probe failed.
+	  - EACCES	Access denied:  requires CAP_SYS_RAWIO
+	  - EIO		Probe failed.
 
 	notes:
+		This ioctl initializes the addresses and irq for a disk
+		controller, probes for drives, and creates /proc/ide
+		interfaces as appropriate.
 
-	  This ioctl initializes the addresses and irq for a disk
-	  controller, probes for drives, and creates /proc/ide
-	  interfaces as appropriate.
 
 
+HDIO_UNREGISTER_HWIF
+	unregister interface
 
-HDIO_UNREGISTER_HWIF		unregister interface
 
-	usage:
+	usage::
 
 	  int index;
+
 	  ioctl(fd, HDIO_UNREGISTER_HWIF, index);
 
 	inputs:
-	  index		index of hardware interface to unregister
+		index		index of hardware interface to unregister
+
+
+
+	outputs:
+		none
+
 
-	outputs:	none
 
 	error returns:
-	  EACCES	Access denied:  requires CAP_SYS_RAWIO
+	  - EACCES	Access denied:  requires CAP_SYS_RAWIO
 
 	notes:
+		This ioctl removes a hardware interface from the kernel.
 
-	  This ioctl removes a hardware interface from the kernel.
+		Currently (2.6.8) this ioctl silently fails if any drive on
+		the interface is busy.
 
-	  Currently (2.6.8) this ioctl silently fails if any drive on
-	  the interface is busy.
 
 
+HDIO_SET_WCACHE
+	change write cache enable-disable
 
-HDIO_SET_WCACHE			change write cache enable-disable
 
-	usage:
+	usage::
 
 	  int val;
+
 	  ioctl(fd, HDIO_SET_WCACHE, val);
 
 	inputs:
-	  New value for write cache enable
+		New value for write cache enable
+
+
+
+	outputs:
+		none
+
 
-	outputs:	none
 
 	error return:
-	  EINVAL	(bdev != bdev->bd_contains) (not sure what this means)
-	  EACCES	Access denied:  requires CAP_SYS_ADMIN
-	  EINVAL	value out of range [0 1]
-	  EBUSY		Controller busy
+	  - EINVAL	(bdev != bdev->bd_contains) (not sure what this means)
+	  - EACCES	Access denied:  requires CAP_SYS_ADMIN
+	  - EINVAL	value out of range [0 1]
+	  - EBUSY	Controller busy
 
 
 
-HDIO_SET_ACOUSTIC		change acoustic behavior
+HDIO_SET_ACOUSTIC
+	change acoustic behavior
 
-	usage:
+
+	usage::
 
 	  int val;
+
 	  ioctl(fd, HDIO_SET_ACOUSTIC, val);
 
 	inputs:
-	  New value for drive acoustic settings
+		New value for drive acoustic settings
+
+
+
+	outputs:
+		none
+
 
-	outputs:	none
 
 	error return:
-	  EINVAL	(bdev != bdev->bd_contains) (not sure what this means)
-	  EACCES	Access denied:  requires CAP_SYS_ADMIN
-	  EINVAL	value out of range [0 254]
-	  EBUSY		Controller busy
+	  - EINVAL	(bdev != bdev->bd_contains) (not sure what this means)
+	  - EACCES	Access denied:  requires CAP_SYS_ADMIN
+	  - EINVAL	value out of range [0 254]
+	  - EBUSY	Controller busy
 
 
 
-HDIO_SET_QDMA			change use-qdma flag
+HDIO_SET_QDMA
+	change use-qdma flag
+
 
 	Not implemented, as of 2.6.8.1
 
 
 
-HDIO_SET_ADDRESS		change lba addressing modes
+HDIO_SET_ADDRESS
+	change lba addressing modes
 
-	usage:
+
+	usage::
 
 	  int val;
+
 	  ioctl(fd, HDIO_SET_ADDRESS, val);
 
 	inputs:
-	  New value for addressing mode
-	    0 = 28-bit
-	    1 = 48-bit
-	    2 = 48-bit doing 28-bit
+		New value for addressing mode
+
+	    =   ===================
+	    0   28-bit
+	    1   48-bit
+	    2   48-bit doing 28-bit
+	    =   ===================
+
+	outputs:
+		none
+
 
-	outputs:	none
 
 	error return:
-	  EINVAL	(bdev != bdev->bd_contains) (not sure what this means)
-	  EACCES	Access denied:  requires CAP_SYS_ADMIN
-	  EINVAL	value out of range [0 2]
-	  EBUSY		Controller busy
-	  EIO		Drive does not support lba48 mode.
+	  - EINVAL	(bdev != bdev->bd_contains) (not sure what this means)
+	  - EACCES	Access denied:  requires CAP_SYS_ADMIN
+	  - EINVAL	value out of range [0 2]
+	  - EBUSY		Controller busy
+	  - EIO		Drive does not support lba48 mode.
 
 
 HDIO_SET_IDE_SCSI
+	usage::
 
-	usage:
 
 	  long val;
+
 	  ioctl(fd, HDIO_SET_IDE_SCSI, val);
 
 	inputs:
-	  New value for scsi emulation mode (?)
+		New value for scsi emulation mode (?)
+
+
+
+	outputs:
+		none
+
 
-	outputs:	none
 
 	error return:
-	  EINVAL	(bdev != bdev->bd_contains) (not sure what this means)
-	  EACCES	Access denied:  requires CAP_SYS_ADMIN
-	  EINVAL	value out of range [0 1]
-	  EBUSY		Controller busy
+	  - EINVAL	(bdev != bdev->bd_contains) (not sure what this means)
+	  - EACCES	Access denied:  requires CAP_SYS_ADMIN
+	  - EINVAL	value out of range [0 1]
+	  - EBUSY	Controller busy
 
 
 
 HDIO_SET_SCSI_IDE
-
 	Not implemented, as of 2.6.8.1
-
-
diff --git a/Documentation/ioctl/index.rst b/Documentation/ioctl/index.rst
new file mode 100644
index 000000000000..1a6f437566e3
--- /dev/null
+++ b/Documentation/ioctl/index.rst
@@ -0,0 +1,16 @@
+:orphan:
+
+======
+IOCTLs
+======
+
+.. toctree::
+   :maxdepth: 1
+
+   ioctl-number
+
+   botching-up-ioctls
+   ioctl-decoding
+
+   cdrom
+   hdio
diff --git a/Documentation/ioctl/ioctl-decoding.txt b/Documentation/ioctl/ioctl-decoding.rst
similarity index 54%
rename from Documentation/ioctl/ioctl-decoding.txt
rename to Documentation/ioctl/ioctl-decoding.rst
index e35efb0cec2e..380d6bb3e3ea 100644
--- a/Documentation/ioctl/ioctl-decoding.txt
+++ b/Documentation/ioctl/ioctl-decoding.rst
@@ -1,10 +1,16 @@
+==============================
+Decoding an IOCTL Magic Number
+==============================
+
 To decode a hex IOCTL code:
 
 Most architectures use this generic format, but check
 include/ARCH/ioctl.h for specifics, e.g. powerpc
 uses 3 bits to encode read/write and 13 bits for size.
 
- bits    meaning
+ ====== ==================================
+ bits   meaning
+ ====== ==================================
  31-30	00 - no parameters: uses _IO macro
 	10 - read: _IOR
 	01 - write: _IOW
@@ -16,9 +22,10 @@ uses 3 bits to encode read/write and 13 bits for size.
 	unique to each driver
 
  7-0	function #
+ ====== ==================================
 
 
 So for example 0x82187201 is a read with arg length of 0x218,
-character 'r' function 1. Grepping the source reveals this is:
+character 'r' function 1. Grepping the source reveals this is::
 
-#define VFAT_IOCTL_READDIR_BOTH         _IOR('r', 1, struct dirent [2])
+	#define VFAT_IOCTL_READDIR_BOTH         _IOR('r', 1, struct dirent [2])
diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c
index ce8a70875bd5..ae44a1a31d9f 100644
--- a/drivers/gpu/drm/drm_ioctl.c
+++ b/drivers/gpu/drm/drm_ioctl.c
@@ -720,7 +720,7 @@ static const struct drm_ioctl_desc drm_ioctls[] = {
  *     };
  *
  * Please make sure that you follow all the best practices from
- * ``Documentation/ioctl/botching-up-ioctls.txt``. Note that drm_ioctl()
+ * ``Documentation/ioctl/botching-up-ioctls.rst``. Note that drm_ioctl()
  * automatically zero-extends structures, hence make sure you can add more stuff
  * at the end, i.e. don't put a variable sized array there.
  *
-- 
2.20.1

