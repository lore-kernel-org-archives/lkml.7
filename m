Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF9FC31E48
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 17:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8686521721
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 17:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560362146;
	bh=3rx6Bkfh5euv6JwZIYP36BwGbKOAUf0YaU9Uzl9ugZs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=T+zeURm8+QyaH9tkRclvQGQIjYKdUXudSSDwfxe92z5jnMT2MPeZPeX77Tj14R7Fx
	 576e7LxzelvBU9mZhQp4bM1Sg8j87eKMVaakyCBnVAreRLXtq7dWboGOyPsWf9GuNT
	 GyIfeE4/OcomuVzsDXilfP49mDz1zNOd1XnjFDU8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390605AbfFLRzp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 13:55:45 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40478 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388722AbfFLRxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 13:53:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Zt3xoMrxZU+L1IqkBU/DdgxjyhNGin3s3jVYlUtGi7w=; b=KZbejZKoEgJtow9o5a7n7Xm31r
        uL7HeN0o/NrRjMOd4hp7+au7j/xc/3NPYkc/2YiFhdiFf1b5lbgtEFfkNjqm5l5WA2DSUIMurUpCu
        Rixsw1xpv1Hl1R6aqu4PJ9+ki7C2tvJMTuwPyiL+l3rav2rxOGI5jadFy6YedPOZUpYzbSYhXeZn+
        fPu5T6m2mh9VhBCyuEszurKErXMDOLzRTywxcdHYZwDTsFCJrKszI9PwEmqV7Lb28JNf/43sBms+n
        hQ8x86uZ6p7qoR9ytLObSaHbeQ2ySX6N0h8zJZjR6hlkOt0I3KXkKUDqd9DC6eD0VONAw9O6RLll1
        qFEuesWQ==;
Received: from 201.86.169.251.dynamic.adsl.gvt.net.br ([201.86.169.251] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hb7Qt-0002Dd-2K; Wed, 12 Jun 2019 17:53:11 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hb7Qq-0001gN-8y; Wed, 12 Jun 2019 14:53:08 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Borislav Petkov <bp@alien8.de>, Jens Axboe <axboe@kernel.dk>,
        "David S. Miller" <davem@davemloft.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-ide@vger.kernel.org, linux-m68k@lists.linux-m68k.org
Subject: [PATCH v4 11/28] docs: ide: convert docs to ReST and rename to *.rst
Date:   Wed, 12 Jun 2019 14:52:47 -0300
Message-Id: <c8d81e59f9d7d6611531086b59e26ee399ade3a8.1560361364.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1560361364.git.mchehab+samsung@kernel.org>
References: <cover.1560361364.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The conversion is actually:
  - add blank lines and identation in order to identify paragraphs;
  - fix tables markups;
  - add some lists markups;
  - mark literal blocks;
  - adjust title markups.

At its new index.rst, let's add a :orphan: while this is not linked to
the main index.rst file, in order to avoid build warnings.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 .../admin-guide/kernel-parameters.txt         |   2 +-
 Documentation/cdrom/ide-cd.rst                |  18 +--
 Documentation/ide/changelogs.rst              |  17 ++
 .../ide/{ide-tape.txt => ide-tape.rst}        |  23 +--
 Documentation/ide/{ide.txt => ide.rst}        | 147 ++++++++++--------
 Documentation/ide/index.rst                   |  21 +++
 ...arm-plug-howto.txt => warm-plug-howto.rst} |  10 +-
 arch/m68k/q40/README                          |   2 +-
 drivers/ide/Kconfig                           |  20 +--
 9 files changed, 155 insertions(+), 105 deletions(-)
 create mode 100644 Documentation/ide/changelogs.rst
 rename Documentation/ide/{ide-tape.txt => ide-tape.rst} (83%)
 rename Documentation/ide/{ide.txt => ide.rst} (72%)
 create mode 100644 Documentation/ide/index.rst
 rename Documentation/ide/{warm-plug-howto.txt => warm-plug-howto.rst} (61%)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 581d8888e829..affed5d447de 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1502,7 +1502,7 @@
 			Format: =0.0 to prevent dma on hda, =0.1 hdb =1.0 hdc
 			.vlb_clock .pci_clock .noflush .nohpa .noprobe .nowerr
 			.cdrom .chs .ignore_cable are additional options
-			See Documentation/ide/ide.txt.
+			See Documentation/ide/ide.rst.
 
 	ide-generic.probe-mask= [HW] (E)IDE subsystem
 			Format: <int>
diff --git a/Documentation/cdrom/ide-cd.rst b/Documentation/cdrom/ide-cd.rst
index dadc94ef6b6c..bdccb74fc92d 100644
--- a/Documentation/cdrom/ide-cd.rst
+++ b/Documentation/cdrom/ide-cd.rst
@@ -47,7 +47,7 @@ This driver provides the following features:
 ---------------
 
 0. The ide-cd relies on the ide disk driver.  See
-   Documentation/ide/ide.txt for up-to-date information on the ide
+   Documentation/ide/ide.rst for up-to-date information on the ide
    driver.
 
 1. Make sure that the ide and ide-cd drivers are compiled into the
@@ -62,7 +62,7 @@ This driver provides the following features:
 
    Depending on what type of IDE interface you have, you may need to
    specify additional configuration options.  See
-   Documentation/ide/ide.txt.
+   Documentation/ide/ide.rst.
 
 2. You should also ensure that the iso9660 filesystem is either
    compiled into the kernel or available as a loadable module.  You
@@ -82,7 +82,7 @@ This driver provides the following features:
    on the primary IDE interface are called `hda` and `hdb`,
    respectively.  The drives on the secondary interface are called
    `hdc` and `hdd`.  (Interfaces at other locations get other letters
-   in the third position; see Documentation/ide/ide.txt.)
+   in the third position; see Documentation/ide/ide.rst.)
 
    If you want your CDROM drive to be found automatically by the
    driver, you should make sure your IDE interface uses either the
@@ -91,7 +91,7 @@ This driver provides the following features:
    be jumpered as `master`.  (If for some reason you cannot configure
    your system in this manner, you can probably still use the driver.
    You may have to pass extra configuration information to the kernel
-   when you boot, however.  See Documentation/ide/ide.txt for more
+   when you boot, however.  See Documentation/ide/ide.rst for more
    information.)
 
 4. Boot the system.  If the drive is recognized, you should see a
@@ -163,7 +163,7 @@ to change.  If the slot number is -1, the drive is unloaded.
 This section discusses some common problems encountered when trying to
 use the driver, and some possible solutions.  Note that if you are
 experiencing problems, you should probably also review
-Documentation/ide/ide.txt for current information about the underlying
+Documentation/ide/ide.rst for current information about the underlying
 IDE support code.  Some of these items apply only to earlier versions
 of the driver, but are mentioned here for completeness.
 
@@ -173,7 +173,7 @@ from the driver.
 a. Drive is not detected during booting.
 
    - Review the configuration instructions above and in
-     Documentation/ide/ide.txt, and check how your hardware is
+     Documentation/ide/ide.rst, and check how your hardware is
      configured.
 
    - If your drive is the only device on an IDE interface, it should
@@ -181,7 +181,7 @@ a. Drive is not detected during booting.
 
    - If your IDE interface is not at the standard addresses of 0x170
      or 0x1f0, you'll need to explicitly inform the driver using a
-     lilo option.  See Documentation/ide/ide.txt.  (This feature was
+     lilo option.  See Documentation/ide/ide.rst.  (This feature was
      added around kernel version 1.3.30.)
 
    - If the autoprobing is not finding your drive, you can tell the
@@ -207,7 +207,7 @@ a. Drive is not detected during booting.
      Support for some interfaces needing extra initialization is
      provided in later 1.3.x kernels.  You may need to turn on
      additional kernel configuration options to get them to work;
-     see Documentation/ide/ide.txt.
+     see Documentation/ide/ide.rst.
 
      Even if support is not available for your interface, you may be
      able to get it to work with the following procedure.  First boot
@@ -261,7 +261,7 @@ c. System hangups.
     be worked around by specifying the `serialize` option when
     booting.  Recent kernels should be able to detect the need for
     this automatically in most cases, but the detection is not
-    foolproof.  See Documentation/ide/ide.txt for more information
+    foolproof.  See Documentation/ide/ide.rst for more information
     about the `serialize` option and the CMD640B.
 
   - Note that many MS-DOS CDROM drivers will work with such buggy
diff --git a/Documentation/ide/changelogs.rst b/Documentation/ide/changelogs.rst
new file mode 100644
index 000000000000..fdf9d0fb8027
--- /dev/null
+++ b/Documentation/ide/changelogs.rst
@@ -0,0 +1,17 @@
+Changelog for ide cd
+--------------------
+
+ .. include:: ChangeLog.ide-cd.1994-2004
+    :literal:
+
+Changelog for ide floppy
+------------------------
+
+ .. include:: ChangeLog.ide-floppy.1996-2002
+    :literal:
+
+Changelog for ide tape
+----------------------
+
+ .. include:: ChangeLog.ide-tape.1995-2002
+    :literal:
diff --git a/Documentation/ide/ide-tape.txt b/Documentation/ide/ide-tape.rst
similarity index 83%
rename from Documentation/ide/ide-tape.txt
rename to Documentation/ide/ide-tape.rst
index 3f348a0b21d8..3e061d9c0e38 100644
--- a/Documentation/ide/ide-tape.txt
+++ b/Documentation/ide/ide-tape.rst
@@ -1,4 +1,6 @@
-IDE ATAPI streaming tape driver.
+===============================
+IDE ATAPI streaming tape driver
+===============================
 
 This driver is a part of the Linux ide driver.
 
@@ -10,14 +12,14 @@ to the request-list of the block device, and waits for their completion.
 The block device major and minor numbers are determined from the
 tape's relative position in the ide interfaces, as explained in ide.c.
 
-The character device interface consists of the following devices:
+The character device interface consists of the following devices::
 
-ht0		major 37, minor 0	first  IDE tape, rewind on close.
-ht1		major 37, minor 1	second IDE tape, rewind on close.
-...
-nht0		major 37, minor 128	first  IDE tape, no rewind on close.
-nht1		major 37, minor 129	second IDE tape, no rewind on close.
-...
+  ht0		major 37, minor 0	first  IDE tape, rewind on close.
+  ht1		major 37, minor 1	second IDE tape, rewind on close.
+  ...
+  nht0		major 37, minor 128	first  IDE tape, no rewind on close.
+  nht1		major 37, minor 129	second IDE tape, no rewind on close.
+  ...
 
 The general magnetic tape commands compatible interface, as defined by
 include/linux/mtio.h, is accessible through the character device.
@@ -40,9 +42,10 @@ Testing was done with a 2 GB CONNER CTMA 4000 IDE ATAPI Streaming Tape Drive.
 Here are some words from the first releases of hd.c, which are quoted
 in ide.c and apply here as well:
 
-| Special care is recommended.  Have Fun!
+* Special care is recommended.  Have Fun!
 
-Possible improvements:
+Possible improvements
+=====================
 
 1. Support for the ATAPI overlap protocol.
 
diff --git a/Documentation/ide/ide.txt b/Documentation/ide/ide.rst
similarity index 72%
rename from Documentation/ide/ide.txt
rename to Documentation/ide/ide.rst
index 7aca987c23d9..88bdcba92f7d 100644
--- a/Documentation/ide/ide.txt
+++ b/Documentation/ide/ide.rst
@@ -1,41 +1,43 @@
-
-	Information regarding the Enhanced IDE drive in Linux 2.6
-
-==============================================================================
-
+============================================
+Information regarding the Enhanced IDE drive
+============================================
 
    The hdparm utility can be used to control various IDE features on a
    running system. It is packaged separately.  Please Look for it on popular
    linux FTP sites.
 
+-------------------------------------------------------------------------------
 
+.. important::
 
-***  IMPORTANT NOTICES:  BUGGY IDE CHIPSETS CAN CORRUPT DATA!!
-***  =================
-***  PCI versions of the CMD640 and RZ1000 interfaces are now detected
-***  automatically at startup when PCI BIOS support is configured.
-***
-***  Linux disables the "prefetch" ("readahead") mode of the RZ1000
-***  to prevent data corruption possible due to hardware design flaws.
-***
-***  For the CMD640, linux disables "IRQ unmasking" (hdparm -u1) on any
-***  drive for which the "prefetch" mode of the CMD640 is turned on.
-***  If "prefetch" is disabled (hdparm -p8), then "IRQ unmasking" can be
-***  used again.
-***
-***  For the CMD640, linux disables "32bit I/O" (hdparm -c1) on any drive
-***  for which the "prefetch" mode of the CMD640 is turned off.
-***  If "prefetch" is enabled (hdparm -p9), then "32bit I/O" can be
-***  used again.
-***
-***  The CMD640 is also used on some Vesa Local Bus (VLB) cards, and is *NOT*
-***  automatically detected by Linux.  For safe, reliable operation with such
-***  interfaces, one *MUST* use the "cmd640.probe_vlb" kernel option.
-***
-***  Use of the "serialize" option is no longer necessary.
-
-================================================================================
-Common pitfalls:
+   BUGGY IDE CHIPSETS CAN CORRUPT DATA!!
+
+    PCI versions of the CMD640 and RZ1000 interfaces are now detected
+    automatically at startup when PCI BIOS support is configured.
+
+    Linux disables the "prefetch" ("readahead") mode of the RZ1000
+    to prevent data corruption possible due to hardware design flaws.
+
+    For the CMD640, linux disables "IRQ unmasking" (hdparm -u1) on any
+    drive for which the "prefetch" mode of the CMD640 is turned on.
+    If "prefetch" is disabled (hdparm -p8), then "IRQ unmasking" can be
+    used again.
+
+    For the CMD640, linux disables "32bit I/O" (hdparm -c1) on any drive
+    for which the "prefetch" mode of the CMD640 is turned off.
+    If "prefetch" is enabled (hdparm -p9), then "32bit I/O" can be
+    used again.
+
+    The CMD640 is also used on some Vesa Local Bus (VLB) cards, and is *NOT*
+    automatically detected by Linux.  For safe, reliable operation with such
+    interfaces, one *MUST* use the "cmd640.probe_vlb" kernel option.
+
+    Use of the "serialize" option is no longer necessary.
+
+-------------------------------------------------------------------------------
+
+Common pitfalls
+===============
 
 - 40-conductor IDE cables are capable of transferring data in DMA modes up to
   udma2, but no faster.
@@ -49,19 +51,18 @@ Common pitfalls:
 - Even better try to stick to the same vendor and device type on the same
   cable.
 
-================================================================================
-
-This is the multiple IDE interface driver, as evolved from hd.c.
+This is the multiple IDE interface driver, as evolved from hd.c
+===============================================================
 
 It supports up to 9 IDE interfaces per default, on one or more IRQs (usually
-14 & 15).  There can be up to two drives per interface, as per the ATA-6 spec.
+14 & 15).  There can be up to two drives per interface, as per the ATA-6 spec.::
 
-Primary:    ide0, port 0x1f0; major=3;  hda is minor=0; hdb is minor=64
-Secondary:  ide1, port 0x170; major=22; hdc is minor=0; hdd is minor=64
-Tertiary:   ide2, port 0x1e8; major=33; hde is minor=0; hdf is minor=64
-Quaternary: ide3, port 0x168; major=34; hdg is minor=0; hdh is minor=64
-fifth..     ide4, usually PCI, probed
-sixth..     ide5, usually PCI, probed
+  Primary:    ide0, port 0x1f0; major=3;  hda is minor=0; hdb is minor=64
+  Secondary:  ide1, port 0x170; major=22; hdc is minor=0; hdd is minor=64
+  Tertiary:   ide2, port 0x1e8; major=33; hde is minor=0; hdf is minor=64
+  Quaternary: ide3, port 0x168; major=34; hdg is minor=0; hdh is minor=64
+  fifth..     ide4, usually PCI, probed
+  sixth..     ide5, usually PCI, probed
 
 To access devices on interfaces > ide0, device entries please make sure that
 device files for them are present in /dev.  If not, please create such
@@ -80,12 +81,15 @@ seldom occurs.  Be careful, and if in doubt, don't do it!
 
 Drives are normally found by auto-probing and/or examining the CMOS/BIOS data.
 For really weird situations, the apparent (fdisk) geometry can also be specified
-on the kernel "command line" using LILO.  The format of such lines is:
+on the kernel "command line" using LILO.  The format of such lines is::
 
 	ide_core.chs=[interface_number.device_number]:cyls,heads,sects
-or	ide_core.cdrom=[interface_number.device_number]
 
-For example:
+or::
+
+	ide_core.cdrom=[interface_number.device_number]
+
+For example::
 
 	ide_core.chs=1.0:1050,32,64  ide_core.cdrom=1.1
 
@@ -96,10 +100,12 @@ geometry for partitioning purposes (fdisk).
 If the auto-probing during boot time confuses a drive (ie. the drive works
 with hd.c but not with ide.c), then an command line option may be specified
 for each drive for which you'd like the drive to skip the hardware
-probe/identification sequence.  For example:
+probe/identification sequence.  For example::
 
 	ide_core.noprobe=0.1
-or
+
+or::
+
 	ide_core.chs=1.0:768,16,32
 	ide_core.noprobe=1.0
 
@@ -115,22 +121,24 @@ Such drives will be identified at boot time, just like a hard disk.
 
 If for some reason your cdrom drive is *not* found at boot time, you can force
 the probe to look harder by supplying a kernel command line parameter
-via LILO, such as:
+via LILO, such as:::
 
 	ide_core.cdrom=1.0	/* "master" on second interface (hdc) */
-or
+
+or::
+
 	ide_core.cdrom=1.1	/* "slave" on second interface (hdd) */
 
 For example, a GW2000 system might have a hard drive on the primary
 interface (/dev/hda) and an IDE cdrom drive on the secondary interface
-(/dev/hdc).  To mount a CD in the cdrom drive, one would use something like:
+(/dev/hdc).  To mount a CD in the cdrom drive, one would use something like::
 
 	ln -sf /dev/hdc /dev/cdrom
 	mkdir /mnt/cdrom
 	mount /dev/cdrom /mnt/cdrom -t iso9660 -o ro
 
 If, after doing all of the above, mount doesn't work and you see
-errors from the driver (with dmesg) complaining about `status=0xff',
+errors from the driver (with dmesg) complaining about `status=0xff`,
 this means that the hardware is not responding to the driver's attempts
 to read it.  One of the following is probably the problem:
 
@@ -165,7 +173,7 @@ drivers can always be compiled as loadable modules, the chipset drivers
 can only be compiled into the kernel, and the core code (ide.c) can be
 compiled as a loadable module provided no chipset support is needed.
 
-When using ide.c as a module in combination with kmod, add:
+When using ide.c as a module in combination with kmod, add::
 
 	alias block-major-3 ide-probe
 
@@ -176,10 +184,8 @@ driver using the "options=" keyword to insmod, while replacing any ',' with
 ';'.
 
 
-================================================================================
-
 Summary of ide driver parameters for kernel command line
---------------------------------------------------------
+========================================================
 
 For legacy IDE VLB host drivers (ali14xx/dtc2278/ht6560b/qd65xx/umc8672)
 you need to explicitly enable probing by using "probe" kernel parameter,
@@ -226,28 +232,31 @@ Other kernel parameters for ide_core are:
 
 * "chs=[interface_number.device_number]" to force device as a disk (using CHS)
 
-================================================================================
 
 Some Terminology
-----------------
-IDE = Integrated Drive Electronics, meaning that each drive has a built-in
-controller, which is why an "IDE interface card" is not a "controller card".
+================
 
-ATA = AT (the old IBM 286 computer) Attachment Interface, a draft American
-National Standard for connecting hard drives to PCs.  This is the official
-name for "IDE".
+IDE
+  Integrated Drive Electronics, meaning that each drive has a built-in
+  controller, which is why an "IDE interface card" is not a "controller card".
 
-The latest standards define some enhancements, known as the ATA-6 spec,
-which grew out of vendor-specific "Enhanced IDE" (EIDE) implementations.
+ATA
+  AT (the old IBM 286 computer) Attachment Interface, a draft American
+  National Standard for connecting hard drives to PCs.  This is the official
+  name for "IDE".
 
-ATAPI = ATA Packet Interface, a new protocol for controlling the drives,
-similar to SCSI protocols, created at the same time as the ATA2 standard.
-ATAPI is currently used for controlling CDROM, TAPE and FLOPPY (ZIP or
-LS120/240) devices, removable R/W cartridges, and for high capacity hard disk
-drives.
+  The latest standards define some enhancements, known as the ATA-6 spec,
+  which grew out of vendor-specific "Enhanced IDE" (EIDE) implementations.
+
+ATAPI
+  ATA Packet Interface, a new protocol for controlling the drives,
+  similar to SCSI protocols, created at the same time as the ATA2 standard.
+  ATAPI is currently used for controlling CDROM, TAPE and FLOPPY (ZIP or
+  LS120/240) devices, removable R/W cartridges, and for high capacity hard disk
+  drives.
 
 mlord@pobox.com
---
+
 
 Wed Apr 17 22:52:44 CEST 2002 edited by Marcin Dalecki, the current
 maintainer.
diff --git a/Documentation/ide/index.rst b/Documentation/ide/index.rst
new file mode 100644
index 000000000000..45bc12d3957f
--- /dev/null
+++ b/Documentation/ide/index.rst
@@ -0,0 +1,21 @@
+:orphan:
+
+==================================
+Integrated Drive Electronics (IDE)
+==================================
+
+.. toctree::
+    :maxdepth: 1
+
+    ide
+    ide-tape
+    warm-plug-howto
+
+    changelogs
+
+.. only::  subproject and html
+
+   Indices
+   =======
+
+   * :ref:`genindex`
diff --git a/Documentation/ide/warm-plug-howto.txt b/Documentation/ide/warm-plug-howto.rst
similarity index 61%
rename from Documentation/ide/warm-plug-howto.txt
rename to Documentation/ide/warm-plug-howto.rst
index 98152bcd515a..c245242ef2f1 100644
--- a/Documentation/ide/warm-plug-howto.txt
+++ b/Documentation/ide/warm-plug-howto.rst
@@ -1,14 +1,14 @@
-
+===================
 IDE warm-plug HOWTO
 ===================
 
-To warm-plug devices on a port 'idex':
+To warm-plug devices on a port 'idex'::
 
-# echo -n "1" > /sys/class/ide_port/idex/delete_devices
+	# echo -n "1" > /sys/class/ide_port/idex/delete_devices
 
-unplug old device(s) and plug new device(s)
+unplug old device(s) and plug new device(s)::
 
-# echo -n "1" > /sys/class/ide_port/idex/scan
+	# echo -n "1" > /sys/class/ide_port/idex/scan
 
 done
 
diff --git a/arch/m68k/q40/README b/arch/m68k/q40/README
index 93f4c4cd3c45..a4991d2d8af6 100644
--- a/arch/m68k/q40/README
+++ b/arch/m68k/q40/README
@@ -31,7 +31,7 @@ drivers used by the Q40, apart from the very obvious (console etc.):
 		char/joystick/*		# most of this should work, not
 				        # in default config.in
 	        block/q40ide.c		# startup for ide
-		      ide*		# see Documentation/ide/ide.txt
+		      ide*		# see Documentation/ide/ide.rst
 		      floppy.c		# normal PC driver, DMA emu in asm/floppy.h
 					# and arch/m68k/kernel/entry.S
 					# see drivers/block/README.fd
diff --git a/drivers/ide/Kconfig b/drivers/ide/Kconfig
index fdd2a62f9d52..9eada392df15 100644
--- a/drivers/ide/Kconfig
+++ b/drivers/ide/Kconfig
@@ -25,13 +25,13 @@ menuconfig IDE
 	  To compile this driver as a module, choose M here: the
 	  module will be called ide-core.
 
-	  For further information, please read <file:Documentation/ide/ide.txt>.
+	  For further information, please read <file:Documentation/ide/ide.rst>.
 
 	  If unsure, say N.
 
 if IDE
 
-comment "Please see Documentation/ide/ide.txt for help/info on IDE drives"
+comment "Please see Documentation/ide/ide.rst for help/info on IDE drives"
 
 config IDE_XFER_MODE
 	bool
@@ -163,7 +163,7 @@ config BLK_DEV_IDETAPE
 	  along with other IDE devices, as "hdb" or "hdc", or something
 	  similar, and will be mapped to a character device such as "ht0"
 	  (check the boot messages with dmesg).  Be sure to consult the
-	  <file:drivers/ide/ide-tape.c> and <file:Documentation/ide/ide.txt>
+	  <file:drivers/ide/ide-tape.c> and <file:Documentation/ide/ide.rst>
 	  files for usage information.
 
 	  To compile this driver as a module, choose M here: the
@@ -251,7 +251,7 @@ config BLK_DEV_CMD640
 
 	  The CMD640 chip is also used on add-in cards by Acculogic, and on
 	  the "CSA-6400E PCI to IDE controller" that some people have. For
-	  details, read <file:Documentation/ide/ide.txt>.
+	  details, read <file:Documentation/ide/ide.rst>.
 
 config BLK_DEV_CMD640_ENHANCED
 	bool "CMD640 enhanced support"
@@ -259,7 +259,7 @@ config BLK_DEV_CMD640_ENHANCED
 	help
 	  This option includes support for setting/autotuning PIO modes and
 	  prefetch on CMD640 IDE interfaces.  For details, read
-	  <file:Documentation/ide/ide.txt>. If you have a CMD640 IDE interface
+	  <file:Documentation/ide/ide.rst>. If you have a CMD640 IDE interface
 	  and your BIOS does not already do this for you, then say Y here.
 	  Otherwise say N.
 
@@ -819,7 +819,7 @@ config BLK_DEV_ALI14XX
 	  boot parameter.  It enables support for the secondary IDE interface
 	  of the ALI M1439/1443/1445/1487/1489 chipsets, and permits faster
 	  I/O speeds to be set as well.
-	  See the files <file:Documentation/ide/ide.txt> and
+	  See the files <file:Documentation/ide/ide.rst> and
 	  <file:drivers/ide/ali14xx.c> for more info.
 
 config BLK_DEV_DTC2278
@@ -830,7 +830,7 @@ config BLK_DEV_DTC2278
 	  This driver is enabled at runtime using the "dtc2278.probe" kernel
 	  boot parameter. It enables support for the secondary IDE interface
 	  of the DTC-2278 card, and permits faster I/O speeds to be set as
-	  well. See the <file:Documentation/ide/ide.txt> and
+	  well. See the <file:Documentation/ide/ide.rst> and
 	  <file:drivers/ide/dtc2278.c> files for more info.
 
 config BLK_DEV_HT6560B
@@ -841,7 +841,7 @@ config BLK_DEV_HT6560B
 	  This driver is enabled at runtime using the "ht6560b.probe" kernel
 	  boot parameter. It enables support for the secondary IDE interface
 	  of the Holtek card, and permits faster I/O speeds to be set as well.
-	  See the <file:Documentation/ide/ide.txt> and
+	  See the <file:Documentation/ide/ide.rst> and
 	  <file:drivers/ide/ht6560b.c> files for more info.
 
 config BLK_DEV_QD65XX
@@ -851,7 +851,7 @@ config BLK_DEV_QD65XX
 	help
 	  This driver is enabled at runtime using the "qd65xx.probe" kernel
 	  boot parameter.  It permits faster I/O speeds to be set.  See the
-	  <file:Documentation/ide/ide.txt> and <file:drivers/ide/qd65xx.c>
+	  <file:Documentation/ide/ide.rst> and <file:drivers/ide/qd65xx.c>
 	  for more info.
 
 config BLK_DEV_UMC8672
@@ -862,7 +862,7 @@ config BLK_DEV_UMC8672
 	  This driver is enabled at runtime using the "umc8672.probe" kernel
 	  boot parameter. It enables support for the secondary IDE interface
 	  of the UMC-8672, and permits faster I/O speeds to be set as well.
-	  See the files <file:Documentation/ide/ide.txt> and
+	  See the files <file:Documentation/ide/ide.rst> and
 	  <file:drivers/ide/umc8672.c> for more info.
 
 endif
-- 
2.21.0

