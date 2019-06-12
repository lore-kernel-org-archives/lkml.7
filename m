Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_ABUSE_SURBL,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A3B9C31E47
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 17:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDEE721743
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 17:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560362094;
	bh=vJO93+W+lSVVSVS0xEIursEb7O2CrzfpZA23zdkSo7M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NeSwDZV503wNP4TcKEiKJDAqo7u97vIuW+SE7G318WtdmeWN+6JVkZZJxK9apjZKu
	 zfaxY23xi4gLKADs7eslNaHSOgzDoIlbqcgwAQ3OgsivFsmEdM+9AE0adpLmuC7IYt
	 wH4xQmsZRzWerNaxoF7lPGXqQhDn8so6JI1NxJ3E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390039AbfFLRyx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 13:54:53 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40618 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389155AbfFLRxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 13:53:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
        To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=4MYZT4pzrCZoCZjaU/1JqX3qZkOUhwFwDNW79Od+j6I=; b=QAU8CmLqcNPXlA1UKyzEMgJMUM
        T58yKv//suQ8WQwkJ0YAapLzCk9RF+N20CrmYsPCOp6Wt2xhpqKhh6jijp4Wa/o2sw1PoFxhmoL4T
        qCjKlOFle7O0JYfcQZ/0R+6A0Z+RFx82qtqDUoUoKI2GxlC9MYjkvMRavDnpv0F2egxDHk29KlL1Q
        FjsGx3dw36nv9PeiRuCwjRgtwJQHW7rpcWLPuudNtbQL74QU8vUKDfyojeO+YLNyw0dw8tU9DTNAk
        Q14X/4K/iwKiwGW+sER/gwYVRScQDaVYwj8OuW+BZsz5p5d/xbLvt0+KyxjeRD7ekZWg+StBxHEAS
        KtUahMpQ==;
Received: from 201.86.169.251.dynamic.adsl.gvt.net.br ([201.86.169.251] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hb7Qt-0002De-2v; Wed, 12 Jun 2019 17:53:14 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hb7Qq-0001gD-77; Wed, 12 Jun 2019 14:53:08 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Maik Broemme <mbroemme@libmpq.org>,
        Thomas Winischhofer <thomas@winischhofer.net>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        Bernie Thompson <bernie@plugable.com>,
        Michal Januszewski <spock@gentoo.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org
Subject: [PATCH v4 09/28] docs: fb: convert docs to ReST and rename to *.rst
Date:   Wed, 12 Jun 2019 14:52:45 -0300
Message-Id: <b600b218b502362d385c4654db9619c346373561.1560361364.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1560361364.git.mchehab+samsung@kernel.org>
References: <cover.1560361364.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Also, removed the Maintained by, as requested by Geert.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 .../admin-guide/kernel-parameters.txt         |   2 +-
 Documentation/fb/{api.txt => api.rst}         |  29 +-
 Documentation/fb/{arkfb.txt => arkfb.rst}     |   8 +-
 .../fb/{aty128fb.txt => aty128fb.rst}         |  35 +-
 .../fb/{cirrusfb.txt => cirrusfb.rst}         |  47 +-
 .../fb/{cmap_xfbdev.txt => cmap_xfbdev.rst}   |  57 +--
 .../fb/{deferred_io.txt => deferred_io.rst}   |  28 +-
 Documentation/fb/{efifb.txt => efifb.rst}     |  18 +-
 .../fb/{ep93xx-fb.txt => ep93xx-fb.rst}       |  27 +-
 Documentation/fb/{fbcon.txt => fbcon.rst}     | 177 +++----
 .../fb/{framebuffer.txt => framebuffer.rst}   |  80 ++--
 Documentation/fb/{gxfb.txt => gxfb.rst}       |  24 +-
 Documentation/fb/index.rst                    |  50 ++
 .../fb/{intel810.txt => intel810.rst}         |  79 ++--
 Documentation/fb/{intelfb.txt => intelfb.rst} |  62 +--
 .../fb/{internals.txt => internals.rst}       |  24 +-
 Documentation/fb/{lxfb.txt => lxfb.rst}       |  25 +-
 Documentation/fb/matroxfb.rst                 | 443 ++++++++++++++++++
 Documentation/fb/matroxfb.txt                 | 413 ----------------
 .../fb/{metronomefb.txt => metronomefb.rst}   |   8 +-
 Documentation/fb/{modedb.txt => modedb.rst}   |  44 +-
 Documentation/fb/pvr2fb.rst                   |  66 +++
 Documentation/fb/pvr2fb.txt                   |  65 ---
 Documentation/fb/{pxafb.txt => pxafb.rst}     |  81 +++-
 Documentation/fb/{s3fb.txt => s3fb.rst}       |   8 +-
 .../fb/{sa1100fb.txt => sa1100fb.rst}         |  23 +-
 Documentation/fb/sh7760fb.rst                 | 130 +++++
 Documentation/fb/sh7760fb.txt                 | 131 ------
 Documentation/fb/{sisfb.txt => sisfb.rst}     |  40 +-
 Documentation/fb/{sm501.txt => sm501.rst}     |   7 +-
 Documentation/fb/{sm712fb.txt => sm712fb.rst} |  18 +-
 Documentation/fb/sstfb.rst                    | 207 ++++++++
 Documentation/fb/sstfb.txt                    | 174 -------
 Documentation/fb/{tgafb.txt => tgafb.rst}     |  30 +-
 .../fb/{tridentfb.txt => tridentfb.rst}       |  36 +-
 Documentation/fb/{udlfb.txt => udlfb.rst}     |  55 ++-
 Documentation/fb/{uvesafb.txt => uvesafb.rst} | 128 ++---
 Documentation/fb/{vesafb.txt => vesafb.rst}   | 121 ++---
 Documentation/fb/viafb.rst                    | 297 ++++++++++++
 Documentation/fb/viafb.txt                    | 252 ----------
 .../fb/{vt8623fb.txt => vt8623fb.rst}         |  10 +-
 MAINTAINERS                                   |  10 +-
 drivers/tty/Kconfig                           |   2 +-
 drivers/video/fbdev/Kconfig                   |  24 +-
 drivers/video/fbdev/matrox/matroxfb_base.c    |   2 +-
 drivers/video/fbdev/pxafb.c                   |   2 +-
 drivers/video/fbdev/sh7760fb.c                |   2 +-
 47 files changed, 1944 insertions(+), 1657 deletions(-)
 rename Documentation/fb/{api.txt => api.rst} (97%)
 rename Documentation/fb/{arkfb.txt => arkfb.rst} (92%)
 rename Documentation/fb/{aty128fb.txt => aty128fb.rst} (61%)
 rename Documentation/fb/{cirrusfb.txt => cirrusfb.rst} (75%)
 rename Documentation/fb/{cmap_xfbdev.txt => cmap_xfbdev.rst} (50%)
 rename Documentation/fb/{deferred_io.txt => deferred_io.rst} (86%)
 rename Documentation/fb/{efifb.txt => efifb.rst} (75%)
 rename Documentation/fb/{ep93xx-fb.txt => ep93xx-fb.rst} (85%)
 rename Documentation/fb/{fbcon.txt => fbcon.rst} (69%)
 rename Documentation/fb/{framebuffer.txt => framebuffer.rst} (92%)
 rename Documentation/fb/{gxfb.txt => gxfb.rst} (60%)
 create mode 100644 Documentation/fb/index.rst
 rename Documentation/fb/{intel810.txt => intel810.rst} (83%)
 rename Documentation/fb/{intelfb.txt => intelfb.rst} (73%)
 rename Documentation/fb/{internals.txt => internals.rst} (82%)
 rename Documentation/fb/{lxfb.txt => lxfb.rst} (60%)
 create mode 100644 Documentation/fb/matroxfb.rst
 delete mode 100644 Documentation/fb/matroxfb.txt
 rename Documentation/fb/{metronomefb.txt => metronomefb.rst} (98%)
 rename Documentation/fb/{modedb.txt => modedb.rst} (87%)
 create mode 100644 Documentation/fb/pvr2fb.rst
 delete mode 100644 Documentation/fb/pvr2fb.txt
 rename Documentation/fb/{pxafb.txt => pxafb.rst} (78%)
 rename Documentation/fb/{s3fb.txt => s3fb.rst} (94%)
 rename Documentation/fb/{sa1100fb.txt => sa1100fb.rst} (64%)
 create mode 100644 Documentation/fb/sh7760fb.rst
 delete mode 100644 Documentation/fb/sh7760fb.txt
 rename Documentation/fb/{sisfb.txt => sisfb.rst} (85%)
 rename Documentation/fb/{sm501.txt => sm501.rst} (65%)
 rename Documentation/fb/{sm712fb.txt => sm712fb.rst} (59%)
 create mode 100644 Documentation/fb/sstfb.rst
 delete mode 100644 Documentation/fb/sstfb.txt
 rename Documentation/fb/{tgafb.txt => tgafb.rst} (71%)
 rename Documentation/fb/{tridentfb.txt => tridentfb.rst} (70%)
 rename Documentation/fb/{udlfb.txt => udlfb.rst} (77%)
 rename Documentation/fb/{uvesafb.txt => uvesafb.rst} (52%)
 rename Documentation/fb/{vesafb.txt => vesafb.rst} (57%)
 create mode 100644 Documentation/fb/viafb.rst
 delete mode 100644 Documentation/fb/viafb.txt
 rename Documentation/fb/{vt8623fb.txt => vt8623fb.rst} (85%)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 83e64d779887..581d8888e829 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5046,7 +5046,7 @@
 			vector=percpu: enable percpu vector domain
 
 	video=		[FB] Frame buffer configuration
-			See Documentation/fb/modedb.txt.
+			See Documentation/fb/modedb.rst.
 
 	video.brightness_switch_enabled= [0,1]
 			If set to 1, on receiving an ACPI notify event
diff --git a/Documentation/fb/api.txt b/Documentation/fb/api.rst
similarity index 97%
rename from Documentation/fb/api.txt
rename to Documentation/fb/api.rst
index d52cf1e3b975..79ec33dded74 100644
--- a/Documentation/fb/api.txt
+++ b/Documentation/fb/api.rst
@@ -1,5 +1,6 @@
-			The Frame Buffer Device API
-			---------------------------
+===========================
+The Frame Buffer Device API
+===========================
 
 Last revised: June 21, 2011
 
@@ -21,13 +22,13 @@ deal with different behaviours.
 ---------------
 
 Device and driver capabilities are reported in the fixed screen information
-capabilities field.
+capabilities field::
 
-struct fb_fix_screeninfo {
+  struct fb_fix_screeninfo {
 	...
 	__u16 capabilities;		/* see FB_CAP_*			*/
 	...
-};
+  };
 
 Application should use those capabilities to find out what features they can
 expect from the device and driver.
@@ -151,9 +152,9 @@ fb_fix_screeninfo and fb_var_screeninfo structure respectively.
 struct fb_fix_screeninfo stores device independent unchangeable information
 about the frame buffer device and the current format. Those information can't
 be directly modified by applications, but can be changed by the driver when an
-application modifies the format.
+application modifies the format::
 
-struct fb_fix_screeninfo {
+  struct fb_fix_screeninfo {
 	char id[16];			/* identification string eg "TT Builtin" */
 	unsigned long smem_start;	/* Start of frame buffer mem */
 					/* (physical address) */
@@ -172,13 +173,13 @@ struct fb_fix_screeninfo {
 					/*  specific chip/card we have	*/
 	__u16 capabilities;		/* see FB_CAP_*			*/
 	__u16 reserved[2];		/* Reserved for future compatibility */
-};
+  };
 
 struct fb_var_screeninfo stores device independent changeable information
 about a frame buffer device, its current format and video mode, as well as
-other miscellaneous parameters.
+other miscellaneous parameters::
 
-struct fb_var_screeninfo {
+  struct fb_var_screeninfo {
 	__u32 xres;			/* visible resolution		*/
 	__u32 yres;
 	__u32 xres_virtual;		/* virtual resolution		*/
@@ -216,7 +217,7 @@ struct fb_var_screeninfo {
 	__u32 rotate;			/* angle we rotate counter clockwise */
 	__u32 colorspace;		/* colorspace for FOURCC-based modes */
 	__u32 reserved[4];		/* Reserved for future compatibility */
-};
+  };
 
 To modify variable information, applications call the FBIOPUT_VSCREENINFO
 ioctl with a pointer to a fb_var_screeninfo structure. If the call is
@@ -255,14 +256,14 @@ monochrome, grayscale or pseudocolor visuals, although this is not required.
 
 - For truecolor and directcolor formats, applications set the grayscale field
   to zero, and the red, blue, green and transp fields to describe the layout of
-  color components in memory.
+  color components in memory::
 
-struct fb_bitfield {
+    struct fb_bitfield {
 	__u32 offset;			/* beginning of bitfield	*/
 	__u32 length;			/* length of bitfield		*/
 	__u32 msb_right;		/* != 0 : Most significant bit is */
 					/* right */
-};
+    };
 
   Pixel values are bits_per_pixel wide and are split in non-overlapping red,
   green, blue and alpha (transparency) components. Location and size of each
diff --git a/Documentation/fb/arkfb.txt b/Documentation/fb/arkfb.rst
similarity index 92%
rename from Documentation/fb/arkfb.txt
rename to Documentation/fb/arkfb.rst
index e8487a9d6a05..aeca8773dd7e 100644
--- a/Documentation/fb/arkfb.txt
+++ b/Documentation/fb/arkfb.rst
@@ -1,6 +1,6 @@
-
-	arkfb - fbdev driver for ARK Logic chips
-	========================================
+========================================
+arkfb - fbdev driver for ARK Logic chips
+========================================
 
 
 Supported Hardware
@@ -47,7 +47,7 @@ Missing Features
 (alias TODO list)
 
 	* secondary (not initialized by BIOS) device support
-   	* big endian support
+	* big endian support
 	* DPMS support
 	* MMIO support
 	* interlaced mode variant
diff --git a/Documentation/fb/aty128fb.txt b/Documentation/fb/aty128fb.rst
similarity index 61%
rename from Documentation/fb/aty128fb.txt
rename to Documentation/fb/aty128fb.rst
index b605204fcfe1..3f107718f933 100644
--- a/Documentation/fb/aty128fb.txt
+++ b/Documentation/fb/aty128fb.rst
@@ -1,8 +1,9 @@
-[This file is cloned from VesaFB/matroxfb]
-
+=================
 What is aty128fb?
 =================
 
+.. [This file is cloned from VesaFB/matroxfb]
+
 This is a driver for a graphic framebuffer for ATI Rage128 based devices
 on Intel and PPC boxes.
 
@@ -24,15 +25,15 @@ How to use it?
 ==============
 
 Switching modes is done using the  video=aty128fb:<resolution>... modedb
-boot parameter or using `fbset' program.
+boot parameter or using `fbset` program.
 
-See Documentation/fb/modedb.txt for more information on modedb
+See Documentation/fb/modedb.rst for more information on modedb
 resolutions.
 
 You should compile in both vgacon (to boot if you remove your Rage128 from
 box) and aty128fb (for graphics mode). You should not compile-in vesafb
-unless you have primary display on non-Rage128 VBE2.0 device (see 
-Documentation/fb/vesafb.txt for details).
+unless you have primary display on non-Rage128 VBE2.0 device (see
+Documentation/fb/vesafb.rst for details).
 
 
 X11
@@ -48,16 +49,18 @@ Configuration
 =============
 
 You can pass kernel command line options to vesafb with
-`video=aty128fb:option1,option2:value2,option3' (multiple options should
-be separated by comma, values are separated from options by `:'). 
+`video=aty128fb:option1,option2:value2,option3` (multiple options should
+be separated by comma, values are separated from options by `:`).
 Accepted options:
 
-noaccel  - do not use acceleration engine. It is default.
-accel    - use acceleration engine. Not finished.
-vmode:x  - chooses PowerMacintosh video mode <x>. Deprecated.
-cmode:x  - chooses PowerMacintosh colour mode <x>. Deprecated.
-<XxX@X>  - selects startup videomode. See modedb.txt for detailed
-	   explanation. Default is 640x480x8bpp.
+========= =======================================================
+noaccel   do not use acceleration engine. It is default.
+accel     use acceleration engine. Not finished.
+vmode:x   chooses PowerMacintosh video mode <x>. Deprecated.
+cmode:x   chooses PowerMacintosh colour mode <x>. Deprecated.
+<XxX@X>   selects startup videomode. See modedb.txt for detailed
+	  explanation. Default is 640x480x8bpp.
+========= =======================================================
 
 
 Limitations
@@ -65,8 +68,8 @@ Limitations
 
 There are known and unknown bugs, features and misfeatures.
 Currently there are following known bugs:
- + This driver is still experimental and is not finished.  Too many
+
+ - This driver is still experimental and is not finished.  Too many
    bugs/errata to list here.
 
---
 Brad Douglas <brad@neruo.com>
diff --git a/Documentation/fb/cirrusfb.txt b/Documentation/fb/cirrusfb.rst
similarity index 75%
rename from Documentation/fb/cirrusfb.txt
rename to Documentation/fb/cirrusfb.rst
index f75950d330a4..8c3e6c6cb114 100644
--- a/Documentation/fb/cirrusfb.txt
+++ b/Documentation/fb/cirrusfb.rst
@@ -1,32 +1,32 @@
+============================================
+Framebuffer driver for Cirrus Logic chipsets
+============================================
 
-		Framebuffer driver for Cirrus Logic chipsets
-		Copyright 1999 Jeff Garzik <jgarzik@pobox.com>
+Copyright 1999 Jeff Garzik <jgarzik@pobox.com>
 
 
-
-{ just a little something to get people going; contributors welcome! }
-
+.. just a little something to get people going; contributors welcome!
 
 
 Chip families supported:
-	SD64
-	Piccolo
-	Picasso
-	Spectrum
-	Alpine (GD-543x/4x)
-	Picasso4 (GD-5446)
-	GD-5480
-	Laguna (GD-546x)
+	- SD64
+	- Piccolo
+	- Picasso
+	- Spectrum
+	- Alpine (GD-543x/4x)
+	- Picasso4 (GD-5446)
+	- GD-5480
+	- Laguna (GD-546x)
 
 Bus's supported:
-	PCI
-	Zorro
+	- PCI
+	- Zorro
 
 Architectures supported:
-	i386
-	Alpha
-	PPC (Motorola Powerstack)
-	m68k (Amiga)
+	- i386
+	- Alpha
+	- PPC (Motorola Powerstack)
+	- m68k (Amiga)
 
 
 
@@ -34,10 +34,9 @@ Default video modes
 -------------------
 At the moment, there are two kernel command line arguments supported:
 
-mode:640x480
-mode:800x600
-	or
-mode:1024x768
+- mode:640x480
+- mode:800x600
+- mode:1024x768
 
 Full support for startup video modes (modedb) will be integrated soon.
 
@@ -93,5 +92,3 @@ Version 1.9.4
 Version 1.9.3
 -------------
 * Bundled with kernel 2.3.14-pre1 or later.
-
-
diff --git a/Documentation/fb/cmap_xfbdev.txt b/Documentation/fb/cmap_xfbdev.rst
similarity index 50%
rename from Documentation/fb/cmap_xfbdev.txt
rename to Documentation/fb/cmap_xfbdev.rst
index 55e1f0a3d2b4..5db5e9787361 100644
--- a/Documentation/fb/cmap_xfbdev.txt
+++ b/Documentation/fb/cmap_xfbdev.rst
@@ -1,26 +1,29 @@
+==========================
 Understanding fbdev's cmap
---------------------------
+==========================
 
 These notes explain how X's dix layer uses fbdev's cmap structures.
 
-*. example of relevant structures in fbdev as used for a 3-bit grayscale cmap
-struct fb_var_screeninfo {
-        .bits_per_pixel = 8,
-        .grayscale      = 1,
-        .red =          { 4, 3, 0 },
-        .green =        { 0, 0, 0 },
-        .blue =         { 0, 0, 0 },
-}
-struct fb_fix_screeninfo {
-        .visual =       FB_VISUAL_STATIC_PSEUDOCOLOR,
-}
-for (i = 0; i < 8; i++)
+-  example of relevant structures in fbdev as used for a 3-bit grayscale cmap::
+
+    struct fb_var_screeninfo {
+	    .bits_per_pixel = 8,
+	    .grayscale      = 1,
+	    .red =          { 4, 3, 0 },
+	    .green =        { 0, 0, 0 },
+	    .blue =         { 0, 0, 0 },
+    }
+    struct fb_fix_screeninfo {
+	    .visual =       FB_VISUAL_STATIC_PSEUDOCOLOR,
+    }
+    for (i = 0; i < 8; i++)
 	info->cmap.red[i] = (((2*i)+1)*(0xFFFF))/16;
-memcpy(info->cmap.green, info->cmap.red, sizeof(u16)*8);
-memcpy(info->cmap.blue, info->cmap.red, sizeof(u16)*8);
+    memcpy(info->cmap.green, info->cmap.red, sizeof(u16)*8);
+    memcpy(info->cmap.blue, info->cmap.red, sizeof(u16)*8);
 
-*. X11 apps do something like the following when trying to use grayscale.
-for (i=0; i < 8; i++) {
+-  X11 apps do something like the following when trying to use grayscale::
+
+    for (i=0; i < 8; i++) {
 	char colorspec[64];
 	memset(colorspec,0,64);
 	sprintf(colorspec, "rgb:%x/%x/%x", i*36,i*36,i*36);
@@ -28,26 +31,26 @@ for (i=0; i < 8; i++) {
 		printf("Can't get color %s\n",colorspec);
 	XAllocColor(outputDisplay, testColormap, &wantedColor);
 	grays[i] = wantedColor;
-}
+    }
+
 There's also named equivalents like gray1..x provided you have an rgb.txt.
 
 Somewhere in X's callchain, this results in a call to X code that handles the
 colormap. For example, Xfbdev hits the following:
 
-xc-011010/programs/Xserver/dix/colormap.c:
+xc-011010/programs/Xserver/dix/colormap.c::
 
-FindBestPixel(pentFirst, size, prgb, channel)
+  FindBestPixel(pentFirst, size, prgb, channel)
 
-dr = (long) pent->co.local.red - prgb->red;
-dg = (long) pent->co.local.green - prgb->green;
-db = (long) pent->co.local.blue - prgb->blue;
-sq = dr * dr;
-UnsignedToBigNum (sq, &sum);
-BigNumAdd (&sum, &temp, &sum);
+  dr = (long) pent->co.local.red - prgb->red;
+  dg = (long) pent->co.local.green - prgb->green;
+  db = (long) pent->co.local.blue - prgb->blue;
+  sq = dr * dr;
+  UnsignedToBigNum (sq, &sum);
+  BigNumAdd (&sum, &temp, &sum);
 
 co.local.red are entries that were brought in through FBIOGETCMAP which come
 directly from the info->cmap.red that was listed above. The prgb is the rgb
 that the app wants to match to. The above code is doing what looks like a least
 squares matching function. That's why the cmap entries can't be set to the left
 hand side boundaries of a color range.
-
diff --git a/Documentation/fb/deferred_io.txt b/Documentation/fb/deferred_io.rst
similarity index 86%
rename from Documentation/fb/deferred_io.txt
rename to Documentation/fb/deferred_io.rst
index 748328370250..7300cff255a3 100644
--- a/Documentation/fb/deferred_io.txt
+++ b/Documentation/fb/deferred_io.rst
@@ -1,5 +1,6 @@
+===========
 Deferred IO
------------
+===========
 
 Deferred IO is a way to delay and repurpose IO. It uses host memory as a
 buffer and the MMU pagefault as a pretrigger for when to perform the device
@@ -16,7 +17,7 @@ works:
 - app continues writing to that page with no additional cost. this is
   the key benefit.
 - the workqueue task comes in and mkcleans the pages on the list, then
- completes the work associated with updating the framebuffer. this is
+  completes the work associated with updating the framebuffer. this is
   the real work talking to the device.
 - app tries to write to the address (that has now been mkcleaned)
 - get pagefault and the above sequence occurs again
@@ -47,29 +48,32 @@ How to use it: (for fbdev drivers)
 ----------------------------------
 The following example may be helpful.
 
-1. Setup your structure. Eg:
+1. Setup your structure. Eg::
 
-static struct fb_deferred_io hecubafb_defio = {
-	.delay		= HZ,
-	.deferred_io	= hecubafb_dpy_deferred_io,
-};
+	static struct fb_deferred_io hecubafb_defio = {
+		.delay		= HZ,
+		.deferred_io	= hecubafb_dpy_deferred_io,
+	};
 
 The delay is the minimum delay between when the page_mkwrite trigger occurs
 and when the deferred_io callback is called. The deferred_io callback is
 explained below.
 
-2. Setup your deferred IO callback. Eg:
-static void hecubafb_dpy_deferred_io(struct fb_info *info,
-				struct list_head *pagelist)
+2. Setup your deferred IO callback. Eg::
+
+	static void hecubafb_dpy_deferred_io(struct fb_info *info,
+					     struct list_head *pagelist)
 
 The deferred_io callback is where you would perform all your IO to the display
 device. You receive the pagelist which is the list of pages that were written
 to during the delay. You must not modify this list. This callback is called
 from a workqueue.
 
-3. Call init
+3. Call init::
+
 	info->fbdefio = &hecubafb_defio;
 	fb_deferred_io_init(info);
 
-4. Call cleanup
+4. Call cleanup::
+
 	fb_deferred_io_cleanup(info);
diff --git a/Documentation/fb/efifb.txt b/Documentation/fb/efifb.rst
similarity index 75%
rename from Documentation/fb/efifb.txt
rename to Documentation/fb/efifb.rst
index 1a85c1bdaf38..04840331a00e 100644
--- a/Documentation/fb/efifb.txt
+++ b/Documentation/fb/efifb.rst
@@ -1,6 +1,6 @@
-
+==============
 What is efifb?
-===============
+==============
 
 This is a generic EFI platform driver for Intel based Apple computers.
 efifb is only for EFI booted Intel Macs.
@@ -8,16 +8,17 @@ efifb is only for EFI booted Intel Macs.
 Supported Hardware
 ==================
 
-iMac 17"/20"
-Macbook
-Macbook Pro 15"/17"
-MacMini
+- iMac 17"/20"
+- Macbook
+- Macbook Pro 15"/17"
+- MacMini
 
 How to use it?
 ==============
 
 efifb does not have any kind of autodetection of your machine.
-You have to add the following kernel parameters in your elilo.conf:
+You have to add the following kernel parameters in your elilo.conf::
+
 	Macbook :
 		video=efifb:macbook
 	MacMini :
@@ -29,9 +30,10 @@ You have to add the following kernel parameters in your elilo.conf:
 
 Accepted options:
 
+======= ===========================================================
 nowc	Don't map the framebuffer write combined. This can be used
 	to workaround side-effects and slowdowns on other CPU cores
 	when large amounts of console data are written.
+======= ===========================================================
 
---
 Edgar Hucek <gimli@dark-green.com>
diff --git a/Documentation/fb/ep93xx-fb.txt b/Documentation/fb/ep93xx-fb.rst
similarity index 85%
rename from Documentation/fb/ep93xx-fb.txt
rename to Documentation/fb/ep93xx-fb.rst
index 5af1bd9effae..6f7767926d1a 100644
--- a/Documentation/fb/ep93xx-fb.txt
+++ b/Documentation/fb/ep93xx-fb.rst
@@ -4,7 +4,7 @@ Driver for EP93xx LCD controller
 
 The EP93xx LCD controller can drive both standard desktop monitors and
 embedded LCD displays. If you have a standard desktop monitor then you
-can use the standard Linux video mode database. In your board file:
+can use the standard Linux video mode database. In your board file::
 
 	static struct ep93xxfb_mach_info some_board_fb_info = {
 		.num_modes	= EP93XXFB_USE_MODEDB,
@@ -12,7 +12,7 @@ can use the standard Linux video mode database. In your board file:
 	};
 
 If you have an embedded LCD display then you need to define a video
-mode for it as follows:
+mode for it as follows::
 
 	static struct fb_videomode some_board_video_modes[] = {
 		{
@@ -23,11 +23,11 @@ mode for it as follows:
 
 Note that the pixel clock value is in pico-seconds. You can use the
 KHZ2PICOS macro to convert the pixel clock value. Most other values
-are in pixel clocks. See Documentation/fb/framebuffer.txt for further
+are in pixel clocks. See Documentation/fb/framebuffer.rst for further
 details.
 
 The ep93xxfb_mach_info structure for your board should look like the
-following:
+following::
 
 	static struct ep93xxfb_mach_info some_board_fb_info = {
 		.num_modes	= ARRAY_SIZE(some_board_video_modes),
@@ -37,7 +37,7 @@ following:
 	};
 
 The framebuffer device can be registered by adding the following to
-your board initialisation function:
+your board initialisation function::
 
 	ep93xx_register_fb(&some_board_fb_info);
 
@@ -50,6 +50,7 @@ to configure the controller. The video attributes flags are fully
 documented in section 7 of the EP93xx users' guide. The following
 flags are available:
 
+=============================== ==========================================
 EP93XXFB_PCLK_FALLING		Clock data on the falling edge of the
 				pixel clock. The default is to clock
 				data on the rising edge.
@@ -62,10 +63,12 @@ EP93XXFB_SYNC_HORIZ_HIGH	Horizontal sync is active high. By
 
 EP93XXFB_SYNC_VERT_HIGH		Vertical sync is active high. By
 				default the vertical sync is active high.
+=============================== ==========================================
 
 The physical address of the framebuffer can be controlled using the
 following flags:
 
+=============================== ======================================
 EP93XXFB_USE_SDCSN0		Use SDCSn[0] for the framebuffer. This
 				is the default setting.
 
@@ -74,6 +77,7 @@ EP93XXFB_USE_SDCSN1		Use SDCSn[1] for the framebuffer.
 EP93XXFB_USE_SDCSN2		Use SDCSn[2] for the framebuffer.
 
 EP93XXFB_USE_SDCSN3		Use SDCSn[3] for the framebuffer.
+=============================== ======================================
 
 ==================
 Platform callbacks
@@ -87,7 +91,7 @@ blanked or unblanked.
 
 The setup and teardown devices pass the platform_device structure as
 an argument. The fb_info and ep93xxfb_mach_info structures can be
-obtained as follows:
+obtained as follows::
 
 	static int some_board_fb_setup(struct platform_device *pdev)
 	{
@@ -101,17 +105,17 @@ obtained as follows:
 Setting the video mode
 ======================
 
-The video mode is set using the following syntax:
+The video mode is set using the following syntax::
 
 	video=XRESxYRES[-BPP][@REFRESH]
 
 If the EP93xx video driver is built-in then the video mode is set on
-the Linux kernel command line, for example:
+the Linux kernel command line, for example::
 
 	video=ep93xx-fb:800x600-16@60
 
 If the EP93xx video driver is built as a module then the video mode is
-set when the module is installed:
+set when the module is installed::
 
 	modprobe ep93xx-fb video=320x240
 
@@ -121,13 +125,14 @@ Screenpage bug
 
 At least on the EP9315 there is a silicon bug which causes bit 27 of
 the VIDSCRNPAGE (framebuffer physical offset) to be tied low. There is
-an unofficial errata for this bug at:
+an unofficial errata for this bug at::
+
 	http://marc.info/?l=linux-arm-kernel&m=110061245502000&w=2
 
 By default the EP93xx framebuffer driver checks if the allocated physical
 address has bit 27 set. If it does, then the memory is freed and an
 error is returned. The check can be disabled by adding the following
-option when loading the driver:
+option when loading the driver::
 
       ep93xx-fb.check_screenpage_bug=0
 
diff --git a/Documentation/fb/fbcon.txt b/Documentation/fb/fbcon.rst
similarity index 69%
rename from Documentation/fb/fbcon.txt
rename to Documentation/fb/fbcon.rst
index 60a5ec04e8f0..cfb9f7c38f18 100644
--- a/Documentation/fb/fbcon.txt
+++ b/Documentation/fb/fbcon.rst
@@ -1,39 +1,41 @@
+=======================
 The Framebuffer Console
 =======================
 
-	The framebuffer console (fbcon), as its name implies, is a text
+The framebuffer console (fbcon), as its name implies, is a text
 console running on top of the framebuffer device. It has the functionality of
 any standard text console driver, such as the VGA console, with the added
 features that can be attributed to the graphical nature of the framebuffer.
 
-	 In the x86 architecture, the framebuffer console is optional, and
+In the x86 architecture, the framebuffer console is optional, and
 some even treat it as a toy. For other architectures, it is the only available
 display device, text or graphical.
 
-	 What are the features of fbcon?  The framebuffer console supports
+What are the features of fbcon?  The framebuffer console supports
 high resolutions, varying font types, display rotation, primitive multihead,
 etc. Theoretically, multi-colored fonts, blending, aliasing, and any feature
 made available by the underlying graphics card are also possible.
 
 A. Configuration
+================
 
-	The framebuffer console can be enabled by using your favorite kernel
+The framebuffer console can be enabled by using your favorite kernel
 configuration tool.  It is under Device Drivers->Graphics Support->Frame
 buffer Devices->Console display driver support->Framebuffer Console Support.
 Select 'y' to compile support statically or 'm' for module support.  The
 module will be fbcon.
 
-	In order for fbcon to activate, at least one framebuffer driver is
+In order for fbcon to activate, at least one framebuffer driver is
 required, so choose from any of the numerous drivers available. For x86
 systems, they almost universally have VGA cards, so vga16fb and vesafb will
 always be available. However, using a chipset-specific driver will give you
 more speed and features, such as the ability to change the video mode
 dynamically.
 
-	To display the penguin logo, choose any logo available in Graphics
+To display the penguin logo, choose any logo available in Graphics
 support->Bootup logo.
 
-	Also, you will need to select at least one compiled-in font, but if
+Also, you will need to select at least one compiled-in font, but if
 you don't do anything, the kernel configuration tool will select one for you,
 usually an 8x16 font.
 
@@ -44,6 +46,7 @@ fortunate to have a driver that does not alter the graphics chip, then you
 will still get a VGA console.
 
 B. Loading
+==========
 
 Possible scenarios:
 
@@ -72,33 +75,33 @@ Possible scenarios:
 
 C. Boot options
 
-         The framebuffer console has several, largely unknown, boot options
-         that can change its behavior.
+	 The framebuffer console has several, largely unknown, boot options
+	 that can change its behavior.
 
 1. fbcon=font:<name>
 
-        Select the initial font to use. The value 'name' can be any of the
-        compiled-in fonts: 10x18, 6x10, 7x14, Acorn8x8, MINI4x6,
-        PEARL8x8, ProFont6x11, SUN12x22, SUN8x16, VGA8x16, VGA8x8.
+	Select the initial font to use. The value 'name' can be any of the
+	compiled-in fonts: 10x18, 6x10, 7x14, Acorn8x8, MINI4x6,
+	PEARL8x8, ProFont6x11, SUN12x22, SUN8x16, VGA8x16, VGA8x8.
 
 	Note, not all drivers can handle font with widths not divisible by 8,
-        such as vga16fb.
+	such as vga16fb.
 
 2. fbcon=scrollback:<value>[k]
 
-        The scrollback buffer is memory that is used to preserve display
-        contents that has already scrolled past your view.  This is accessed
-        by using the Shift-PageUp key combination.  The value 'value' is any
-        integer. It defaults to 32KB.  The 'k' suffix is optional, and will
-        multiply the 'value' by 1024.
+	The scrollback buffer is memory that is used to preserve display
+	contents that has already scrolled past your view.  This is accessed
+	by using the Shift-PageUp key combination.  The value 'value' is any
+	integer. It defaults to 32KB.  The 'k' suffix is optional, and will
+	multiply the 'value' by 1024.
 
 3. fbcon=map:<0123>
 
-        This is an interesting option. It tells which driver gets mapped to
-        which console. The value '0123' is a sequence that gets repeated until
-        the total length is 64 which is the number of consoles available. In
-        the above example, it is expanded to 012301230123... and the mapping
-        will be:
+	This is an interesting option. It tells which driver gets mapped to
+	which console. The value '0123' is a sequence that gets repeated until
+	the total length is 64 which is the number of consoles available. In
+	the above example, it is expanded to 012301230123... and the mapping
+	will be::
 
 		tty | 1 2 3 4 5 6 7 8 9 ...
 		fb  | 0 1 2 3 0 1 2 3 0 ...
@@ -126,20 +129,20 @@ C. Boot options
 
 4. fbcon=rotate:<n>
 
-        This option changes the orientation angle of the console display. The
-        value 'n' accepts the following:
+	This option changes the orientation angle of the console display. The
+	value 'n' accepts the following:
 
-	      0 - normal orientation (0 degree)
-	      1 - clockwise orientation (90 degrees)
-	      2 - upside down orientation (180 degrees)
-	      3 - counterclockwise orientation (270 degrees)
+	    - 0 - normal orientation (0 degree)
+	    - 1 - clockwise orientation (90 degrees)
+	    - 2 - upside down orientation (180 degrees)
+	    - 3 - counterclockwise orientation (270 degrees)
 
 	The angle can be changed anytime afterwards by 'echoing' the same
 	numbers to any one of the 2 attributes found in
 	/sys/class/graphics/fbcon:
 
-		rotate     - rotate the display of the active console
-		rotate_all - rotate the display of all consoles
+		- rotate     - rotate the display of the active console
+		- rotate_all - rotate the display of all consoles
 
 	Console rotation will only become available if Framebuffer Console
 	Rotation support is compiled in your kernel.
@@ -177,9 +180,9 @@ Before going on to how to attach, detach and unload the framebuffer console, an
 illustration of the dependencies may help.
 
 The console layer, as with most subsystems, needs a driver that interfaces with
-the hardware. Thus, in a VGA console:
+the hardware. Thus, in a VGA console::
 
-console ---> VGA driver ---> hardware.
+	console ---> VGA driver ---> hardware.
 
 Assuming the VGA driver can be unloaded, one must first unbind the VGA driver
 from the console layer before unloading the driver.  The VGA driver cannot be
@@ -187,9 +190,9 @@ unloaded if it is still bound to the console layer. (See
 Documentation/console/console.txt for more information).
 
 This is more complicated in the case of the framebuffer console (fbcon),
-because fbcon is an intermediate layer between the console and the drivers:
+because fbcon is an intermediate layer between the console and the drivers::
 
-console ---> fbcon ---> fbdev drivers ---> hardware
+	console ---> fbcon ---> fbdev drivers ---> hardware
 
 The fbdev drivers cannot be unloaded if bound to fbcon, and fbcon cannot
 be unloaded if it's bound to the console layer.
@@ -204,12 +207,12 @@ So, how do we unbind fbcon from the console? Part of the answer is in
 Documentation/console/console.txt. To summarize:
 
 Echo a value to the bind file that represents the framebuffer console
-driver. So assuming vtcon1 represents fbcon, then:
+driver. So assuming vtcon1 represents fbcon, then::
 
-echo 1 > sys/class/vtconsole/vtcon1/bind - attach framebuffer console to
-                                           console layer
-echo 0 > sys/class/vtconsole/vtcon1/bind - detach framebuffer console from
-                                           console layer
+  echo 1 > sys/class/vtconsole/vtcon1/bind - attach framebuffer console to
+					     console layer
+  echo 0 > sys/class/vtconsole/vtcon1/bind - detach framebuffer console from
+					     console layer
 
 If fbcon is detached from the console layer, your boot console driver (which is
 usually VGA text mode) will take over.  A few drivers (rivafb and i810fb) will
@@ -223,19 +226,19 @@ restored properly. The following is one of the several methods that you can do:
 2. In your kernel configuration, ensure that CONFIG_FRAMEBUFFER_CONSOLE is set
    to 'y' or 'm'. Enable one or more of your favorite framebuffer drivers.
 
-3. Boot into text mode and as root run:
+3. Boot into text mode and as root run::
 
 	vbetool vbestate save > <vga state file>
 
-	The above command saves the register contents of your graphics
-	hardware to <vga state file>.  You need to do this step only once as
-	the state file can be reused.
+   The above command saves the register contents of your graphics
+   hardware to <vga state file>.  You need to do this step only once as
+   the state file can be reused.
 
-4. If fbcon is compiled as a module, load fbcon by doing:
+4. If fbcon is compiled as a module, load fbcon by doing::
 
        modprobe fbcon
 
-5. Now to detach fbcon:
+5. Now to detach fbcon::
 
        vbetool vbestate restore < <vga state file> && \
        echo 0 > /sys/class/vtconsole/vtcon1/bind
@@ -243,7 +246,7 @@ restored properly. The following is one of the several methods that you can do:
 6. That's it, you're back to VGA mode. And if you compiled fbcon as a module,
    you can unload it by 'rmmod fbcon'.
 
-7. To reattach fbcon:
+7. To reattach fbcon::
 
        echo 1 > /sys/class/vtconsole/vtcon1/bind
 
@@ -266,82 +269,82 @@ the following:
 
 Variation 1:
 
-    a. Before detaching fbcon, do
+    a. Before detaching fbcon, do::
 
-       vbetool vbemode save > <vesa state file> # do once for each vesafb mode,
-						# the file can be reused
+	vbetool vbemode save > <vesa state file> # do once for each vesafb mode,
+						 # the file can be reused
 
     b. Detach fbcon as in step 5.
 
-    c. Attach fbcon
+    c. Attach fbcon::
 
-        vbetool vbestate restore < <vesa state file> && \
+	vbetool vbestate restore < <vesa state file> && \
 	echo 1 > /sys/class/vtconsole/vtcon1/bind
 
 Variation 2:
 
-    a. Before detaching fbcon, do:
+    a. Before detaching fbcon, do::
+
 	echo <ID> > /sys/class/tty/console/bind
 
-
-       vbetool vbemode get
+	vbetool vbemode get
 
     b. Take note of the mode number
 
     b. Detach fbcon as in step 5.
 
-    c. Attach fbcon:
+    c. Attach fbcon::
 
-       vbetool vbemode set <mode number> && \
-       echo 1 > /sys/class/vtconsole/vtcon1/bind
+	vbetool vbemode set <mode number> && \
+	echo 1 > /sys/class/vtconsole/vtcon1/bind
 
 Samples:
 ========
 
 Here are 2 sample bash scripts that you can use to bind or unbind the
-framebuffer console driver if you are on an X86 box:
+framebuffer console driver if you are on an X86 box::
 
----------------------------------------------------------------------------
-#!/bin/bash
-# Unbind fbcon
+  #!/bin/bash
+  # Unbind fbcon
 
-# Change this to where your actual vgastate file is located
-# Or Use VGASTATE=$1 to indicate the state file at runtime
-VGASTATE=/tmp/vgastate
+  # Change this to where your actual vgastate file is located
+  # Or Use VGASTATE=$1 to indicate the state file at runtime
+  VGASTATE=/tmp/vgastate
 
-# path to vbetool
-VBETOOL=/usr/local/bin
+  # path to vbetool
+  VBETOOL=/usr/local/bin
 
 
-for (( i = 0; i < 16; i++))
-do
-  if test -x /sys/class/vtconsole/vtcon$i; then
-      if [ `cat /sys/class/vtconsole/vtcon$i/name | grep -c "frame buffer"` \
-           = 1 ]; then
+  for (( i = 0; i < 16; i++))
+  do
+    if test -x /sys/class/vtconsole/vtcon$i; then
+	if [ `cat /sys/class/vtconsole/vtcon$i/name | grep -c "frame buffer"` \
+	     = 1 ]; then
 	    if test -x $VBETOOL/vbetool; then
 	       echo Unbinding vtcon$i
 	       $VBETOOL/vbetool vbestate restore < $VGASTATE
 	       echo 0 > /sys/class/vtconsole/vtcon$i/bind
 	    fi
-      fi
-  fi
-done
+	fi
+    fi
+  done
 
 ---------------------------------------------------------------------------
-#!/bin/bash
-# Bind fbcon
 
-for (( i = 0; i < 16; i++))
-do
-  if test -x /sys/class/vtconsole/vtcon$i; then
-      if [ `cat /sys/class/vtconsole/vtcon$i/name | grep -c "frame buffer"` \
-           = 1 ]; then
+::
+
+  #!/bin/bash
+  # Bind fbcon
+
+  for (( i = 0; i < 16; i++))
+  do
+    if test -x /sys/class/vtconsole/vtcon$i; then
+	if [ `cat /sys/class/vtconsole/vtcon$i/name | grep -c "frame buffer"` \
+	     = 1 ]; then
 	  echo Unbinding vtcon$i
 	  echo 1 > /sys/class/vtconsole/vtcon$i/bind
-      fi
-  fi
-done
----------------------------------------------------------------------------
+	fi
+    fi
+  done
 
---
 Antonino Daplas <adaplas@pol.net>
diff --git a/Documentation/fb/framebuffer.txt b/Documentation/fb/framebuffer.rst
similarity index 92%
rename from Documentation/fb/framebuffer.txt
rename to Documentation/fb/framebuffer.rst
index 58c5ae2e9f59..7fe087310c82 100644
--- a/Documentation/fb/framebuffer.txt
+++ b/Documentation/fb/framebuffer.rst
@@ -1,7 +1,7 @@
-			The Frame Buffer Device
-			-----------------------
+=======================
+The Frame Buffer Device
+=======================
 
-Maintained by Geert Uytterhoeven <geert@linux-m68k.org>
 Last revised: May 10, 2001
 
 
@@ -26,7 +26,7 @@ other device in /dev. It's a character device using major 29; the minor
 specifies the frame buffer number.
 
 By convention, the following device nodes are used (numbers indicate the device
-minor numbers):
+minor numbers)::
 
       0 = /dev/fb0	First frame buffer
       1 = /dev/fb1	Second frame buffer
@@ -34,15 +34,15 @@ minor numbers):
      31 = /dev/fb31	32nd frame buffer
 
 For backwards compatibility, you may want to create the following symbolic
-links:
+links::
 
     /dev/fb0current -> fb0
     /dev/fb1current -> fb1
 
 and so on...
 
-The frame buffer devices are also `normal' memory devices, this means, you can
-read and write their contents. You can, for example, make a screen snapshot by
+The frame buffer devices are also `normal` memory devices, this means, you can
+read and write their contents. You can, for example, make a screen snapshot by::
 
   cp /dev/fb0 myfile
 
@@ -54,11 +54,11 @@ Application software that uses the frame buffer device (e.g. the X server) will
 use /dev/fb0 by default (older software uses /dev/fb0current). You can specify
 an alternative frame buffer device by setting the environment variable
 $FRAMEBUFFER to the path name of a frame buffer device, e.g. (for sh/bash
-users):
+users)::
 
     export FRAMEBUFFER=/dev/fb1
 
-or (for csh users):
+or (for csh users)::
 
     setenv FRAMEBUFFER /dev/fb1
 
@@ -90,9 +90,9 @@ which data structures they work. Here's just a brief overview:
     possible).
 
   - You can get and set parts of the color map. Communication is done with 16
-    bits per color part (red, green, blue, transparency) to support all 
-    existing hardware. The driver does all the computations needed to apply 
-    it to the hardware (round it down to less bits, maybe throw away 
+    bits per color part (red, green, blue, transparency) to support all
+    existing hardware. The driver does all the computations needed to apply
+    it to the hardware (round it down to less bits, maybe throw away
     transparency).
 
 All this hardware abstraction makes the implementation of application programs
@@ -113,10 +113,10 @@ much trouble...
 3. Frame Buffer Resolution Maintenance
 --------------------------------------
 
-Frame buffer resolutions are maintained using the utility `fbset'. It can
+Frame buffer resolutions are maintained using the utility `fbset`. It can
 change the video mode properties of a frame buffer device. Its main usage is
-to change the current video mode, e.g. during boot up in one of your /etc/rc.*
-or /etc/init.d/* files.
+to change the current video mode, e.g. during boot up in one of your `/etc/rc.*`
+or `/etc/init.d/*` files.
 
 Fbset uses a video mode database stored in a configuration file, so you can
 easily add your own modes and refer to them with a simple identifier.
@@ -129,8 +129,8 @@ The X server (XF68_FBDev) is the most notable application program for the frame
 buffer device. Starting with XFree86 release 3.2, the X server is part of
 XFree86 and has 2 modes:
 
-  - If the `Display' subsection for the `fbdev' driver in the /etc/XF86Config
-    file contains a
+  - If the `Display` subsection for the `fbdev` driver in the /etc/XF86Config
+    file contains a::
 
 	Modes "default"
 
@@ -146,7 +146,7 @@ XFree86 and has 2 modes:
     same virtual desktop size. The frame buffer device that's used is still
     /dev/fb0current (or $FRAMEBUFFER), but the available resolutions are
     defined by /etc/XF86Config now. The disadvantage is that you have to
-    specify the timings in a different format (but `fbset -x' may help).
+    specify the timings in a different format (but `fbset -x` may help).
 
 To tune a video mode, you can use fbset or xvidtune. Note that xvidtune doesn't
 work 100% with XF68_FBDev: the reported clock values are always incorrect.
@@ -172,29 +172,29 @@ retrace, the electron beam is turned off (blanked).
 
 The speed at which the electron beam paints the pixels is determined by the
 dotclock in the graphics board. For a dotclock of e.g. 28.37516 MHz (millions
-of cycles per second), each pixel is 35242 ps (picoseconds) long:
+of cycles per second), each pixel is 35242 ps (picoseconds) long::
 
     1/(28.37516E6 Hz) = 35.242E-9 s
 
-If the screen resolution is 640x480, it will take
+If the screen resolution is 640x480, it will take::
 
     640*35.242E-9 s = 22.555E-6 s
 
 to paint the 640 (xres) pixels on one scanline. But the horizontal retrace
-also takes time (e.g. 272 `pixels'), so a full scanline takes
+also takes time (e.g. 272 `pixels`), so a full scanline takes::
 
     (640+272)*35.242E-9 s = 32.141E-6 s
 
-We'll say that the horizontal scanrate is about 31 kHz:
+We'll say that the horizontal scanrate is about 31 kHz::
 
     1/(32.141E-6 s) = 31.113E3 Hz
 
 A full screen counts 480 (yres) lines, but we have to consider the vertical
-retrace too (e.g. 49 `lines'). So a full screen will take
+retrace too (e.g. 49 `lines`). So a full screen will take::
 
     (480+49)*32.141E-6 s = 17.002E-3 s
 
-The vertical scanrate is about 59 Hz:
+The vertical scanrate is about 59 Hz::
 
     1/(17.002E-3 s) = 58.815 Hz
 
@@ -212,7 +212,7 @@ influenced by the moments at which the synchronization pulses occur.
 The following picture summarizes all timings. The horizontal retrace time is
 the sum of the left margin, the right margin and the hsync length, while the
 vertical retrace time is the sum of the upper margin, the lower margin and the
-vsync length.
+vsync length::
 
   +----------+---------------------------------------------+----------+-------+
   |          |                ↑                            |          |       |
@@ -256,7 +256,8 @@ The frame buffer device expects all horizontal timings in number of dotclocks
 6. Converting XFree86 timing values info frame buffer device timings
 --------------------------------------------------------------------
 
-An XFree86 mode line consists of the following fields:
+An XFree86 mode line consists of the following fields::
+
  "800x600"     50      800  856  976 1040    600  637  643  666
  < name >     DCF       HR  SH1  SH2  HFL     VR  SV1  SV2  VFL
 
@@ -271,19 +272,27 @@ The frame buffer device uses the following fields:
   - vsync_len: length of vertical sync
 
 1) Pixelclock:
+
    xfree: in MHz
+
    fb: in picoseconds (ps)
 
    pixclock = 1000000 / DCF
 
 2) horizontal timings:
+
    left_margin = HFL - SH2
+
    right_margin = SH1 - HR
+
    hsync_len = SH2 - SH1
 
 3) vertical timings:
+
    upper_margin = VFL - SV2
+
    lower_margin = SV1 - VR
+
    vsync_len = SV2 - SV1
 
 Good examples for VESA timings can be found in the XFree86 source tree,
@@ -303,9 +312,10 @@ and to the following documentation:
   - The manual pages for fbset: fbset(8), fb.modes(5)
   - The manual pages for XFree86: XF68_FBDev(1), XF86Config(4/5)
   - The mighty kernel sources:
-      o linux/drivers/video/
-      o linux/include/linux/fb.h
-      o linux/include/video/
+
+      - linux/drivers/video/
+      - linux/include/linux/fb.h
+      - linux/include/video/
 
 
 
@@ -330,14 +340,14 @@ and on its mirrors.
 
 The latest version of fbset can be found at
 
-    http://www.linux-fbdev.org/ 
+    http://www.linux-fbdev.org/
+
+
+10. Credits
+-----------
 
-  
-10. Credits                                                       
-----------                                                       
-                
 This readme was written by Geert Uytterhoeven, partly based on the original
-`X-framebuffer.README' by Roman Hodek and Martin Schaller. Section 6 was
+`X-framebuffer.README` by Roman Hodek and Martin Schaller. Section 6 was
 provided by Frank Neumann.
 
 The frame buffer device abstraction was designed by Martin Schaller.
diff --git a/Documentation/fb/gxfb.txt b/Documentation/fb/gxfb.rst
similarity index 60%
rename from Documentation/fb/gxfb.txt
rename to Documentation/fb/gxfb.rst
index 2f640903bbb2..5738709bccbb 100644
--- a/Documentation/fb/gxfb.txt
+++ b/Documentation/fb/gxfb.rst
@@ -1,7 +1,8 @@
-[This file is cloned from VesaFB/aty128fb]
-
+=============
 What is gxfb?
-=================
+=============
+
+.. [This file is cloned from VesaFB/aty128fb]
 
 This is a graphics framebuffer driver for AMD Geode GX2 based processors.
 
@@ -23,9 +24,9 @@ How to use it?
 ==============
 
 Switching modes is done using  gxfb.mode_option=<resolution>... boot
-parameter or using `fbset' program.
+parameter or using `fbset` program.
 
-See Documentation/fb/modedb.txt for more information on modedb
+See Documentation/fb/modedb.rst for more information on modedb
 resolutions.
 
 
@@ -42,11 +43,12 @@ You can pass kernel command line options to gxfb with gxfb.<option>.
 For example, gxfb.mode_option=800x600@75.
 Accepted options:
 
-mode_option	- specify the video mode.  Of the form
-		  <x>x<y>[-<bpp>][@<refresh>]
-vram		- size of video ram (normally auto-detected)
-vt_switch	- enable vt switching during suspend/resume.  The vt
-		  switch is slow, but harmless.
+================ ==================================================
+mode_option	 specify the video mode.  Of the form
+		 <x>x<y>[-<bpp>][@<refresh>]
+vram		 size of video ram (normally auto-detected)
+vt_switch	 enable vt switching during suspend/resume.  The vt
+		 switch is slow, but harmless.
+================ ==================================================
 
---
 Andres Salomon <dilinger@debian.org>
diff --git a/Documentation/fb/index.rst b/Documentation/fb/index.rst
new file mode 100644
index 000000000000..d47313714635
--- /dev/null
+++ b/Documentation/fb/index.rst
@@ -0,0 +1,50 @@
+:orphan:
+
+============
+Frame Buffer
+============
+
+.. toctree::
+    :maxdepth: 1
+
+    api
+    arkfb
+    aty128fb
+    cirrusfb
+    cmap_xfbdev
+    deferred_io
+    efifb
+    ep93xx-fb
+    fbcon
+    framebuffer
+    gxfb
+    intel810
+    intelfb
+    internals
+    lxfb
+    matroxfb
+    metronomefb
+    modedb
+    pvr2fb
+    pxafb
+    s3fb
+    sa1100fb
+    sh7760fb
+    sisfb
+    sm501
+    sm712fb
+    sstfb
+    tgafb
+    tridentfb
+    udlfb
+    uvesafb
+    vesafb
+    viafb
+    vt8623fb
+
+.. only::  subproject and html
+
+   Indices
+   =======
+
+   * :ref:`genindex`
diff --git a/Documentation/fb/intel810.txt b/Documentation/fb/intel810.rst
similarity index 83%
rename from Documentation/fb/intel810.txt
rename to Documentation/fb/intel810.rst
index a8e9f5bca6f3..eb86098db91f 100644
--- a/Documentation/fb/intel810.txt
+++ b/Documentation/fb/intel810.rst
@@ -1,26 +1,31 @@
+================================
 Intel 810/815 Framebuffer driver
- 	Tony Daplas <adaplas@pol.net>
-	http://i810fb.sourceforge.net
+================================
 
-	March 17, 2002
+Tony Daplas <adaplas@pol.net>
 
-	First Released: July 2001
-	Last Update:    September 12, 2005
-================================================================
+http://i810fb.sourceforge.net
+
+March 17, 2002
+
+First Released: July 2001
+Last Update:    September 12, 2005
 
 A. Introduction
+===============
 
 	This is a framebuffer driver for various Intel 810/815 compatible
 	graphics devices.  These include:
 
-	Intel 810
-	Intel 810E
-	Intel 810-DC100
-	Intel 815 Internal graphics only, 100Mhz FSB
-	Intel 815 Internal graphics only
-	Intel 815 Internal graphics and AGP
+	- Intel 810
+	- Intel 810E
+	- Intel 810-DC100
+	- Intel 815 Internal graphics only, 100Mhz FSB
+	- Intel 815 Internal graphics only
+	- Intel 815 Internal graphics and AGP
 
 B.  Features
+============
 
 	- Choice of using Discrete Video Timings, VESA Generalized Timing
 	  Formula, or a framebuffer specific database to set the video mode
@@ -45,10 +50,11 @@ B.  Features
 	- Can concurrently run with xfree86 running with native i810 drivers
 
 	- Hardware Cursor Support
- 
+
 	- Supports EDID probing either by DDC/I2C or through the BIOS
 
 C.  List of available options
+=============================
 
    a. "video=i810fb"
 	enables the i810 driver
@@ -158,7 +164,7 @@ C.  List of available options
 	(default = not set)
 
    n. "dcolor"
-        Use directcolor visual instead of truecolor for pixel depths greater
+	Use directcolor visual instead of truecolor for pixel depths greater
 	than 8 bpp.  Useful for color tuning, such as gamma control.
 
 	Recommendation: do not set
@@ -167,35 +173,37 @@ C.  List of available options
    o. <xres>x<yres>[-<bpp>][@<refresh>]
 	The driver will now accept specification of boot mode option.  If this
 	is specified, the options 'xres' and 'yres' will be ignored. See
-	Documentation/fb/modedb.txt for usage.
+	Documentation/fb/modedb.rst for usage.
 
 D. Kernel booting
+=================
 
 Separate each option/option-pair by commas (,) and the option from its value
-with a colon (:) as in the following:
+with a colon (:) as in the following::
 
-video=i810fb:option1,option2:value2
+	video=i810fb:option1,option2:value2
 
 Sample Usage
 ------------
 
-In /etc/lilo.conf, add the line:
+In /etc/lilo.conf, add the line::
 
-append="video=i810fb:vram:2,xres:1024,yres:768,bpp:8,hsync1:30,hsync2:55, \
-        vsync1:50,vsync2:85,accel,mtrr"
+  append="video=i810fb:vram:2,xres:1024,yres:768,bpp:8,hsync1:30,hsync2:55, \
+	  vsync1:50,vsync2:85,accel,mtrr"
 
 This will initialize the framebuffer to 1024x768 at 8bpp.  The framebuffer
 will use 2 MB of System RAM. MTRR support will be enabled. The refresh rate
 will be computed based on the hsync1/hsync2 and vsync1/vsync2 values.
 
 IMPORTANT:
-You must include hsync1, hsync2, vsync1 and vsync2 to enable video modes
-better than 640x480 at 60Hz. HOWEVER, if your chipset/display combination
-supports I2C and has an EDID block, you can safely exclude hsync1, hsync2,
-vsync1 and vsync2 parameters.  These parameters will be taken from the EDID
-block.
+  You must include hsync1, hsync2, vsync1 and vsync2 to enable video modes
+  better than 640x480 at 60Hz. HOWEVER, if your chipset/display combination
+  supports I2C and has an EDID block, you can safely exclude hsync1, hsync2,
+  vsync1 and vsync2 parameters.  These parameters will be taken from the EDID
+  block.
 
 E.  Module options
+==================
 
 The module parameters are essentially similar to the kernel
 parameters. The main difference is that you need to include a Boolean value
@@ -206,31 +214,32 @@ Example, to enable MTRR, include "mtrr=1".
 Sample Usage
 ------------
 
-Using the same setup as described above, load the module like this:
+Using the same setup as described above, load the module like this::
 
 	modprobe i810fb vram=2 xres=1024 bpp=8 hsync1=30 hsync2=55 vsync1=50 \
-	         vsync2=85 accel=1 mtrr=1
+		 vsync2=85 accel=1 mtrr=1
 
-Or just add the following to a configuration file in /etc/modprobe.d/
+Or just add the following to a configuration file in /etc/modprobe.d/::
 
 	options i810fb vram=2 xres=1024 bpp=16 hsync1=30 hsync2=55 vsync1=50 \
 	vsync2=85 accel=1 mtrr=1
 
-and just do a
+and just do a::
 
 	modprobe i810fb
 
 
 F.  Setup
+=========
 
-	a. Do your usual method of configuring the kernel.
+	a. Do your usual method of configuring the kernel
 
-	make menuconfig/xconfig/config
+	   make menuconfig/xconfig/config
 
 	b. Under "Code maturity level options" enable "Prompt for development
 	   and/or incomplete code/drivers".
 
- 	c. Enable agpgart support for the Intel 810/815 on-board graphics.
+	c. Enable agpgart support for the Intel 810/815 on-board graphics.
 	   This is required.  The option is under "Character Devices".
 
 	d. Under "Graphics Support", select "Intel 810/815" either statically
@@ -242,7 +251,7 @@ F.  Setup
 	   set 'Enable DDC Support' to 'y'. To make this option appear, set
 	   'use VESA Generalized Timing Formula' to 'y'.
 
-        f. If you want a framebuffer console, enable it under "Console
+	f. If you want a framebuffer console, enable it under "Console
 	   Drivers".
 
 	g. Compile your kernel.
@@ -253,6 +262,7 @@ F.  Setup
 	    patch to see the chipset in action (or inaction :-).
 
 G.  Acknowledgment:
+===================
 
 	1.  Geert Uytterhoeven - his excellent howto and the virtual
 	    framebuffer driver code made this possible.
@@ -269,10 +279,9 @@ G.  Acknowledgment:
 	   optimizations possible.
 
 H.  Home Page:
+==============
 
 	A more complete, and probably updated information is provided at
 	http://i810fb.sourceforge.net.
 
-###########################
 Tony
-
diff --git a/Documentation/fb/intelfb.txt b/Documentation/fb/intelfb.rst
similarity index 73%
rename from Documentation/fb/intelfb.txt
rename to Documentation/fb/intelfb.rst
index feac4e4d6968..e2d0903f4efb 100644
--- a/Documentation/fb/intelfb.txt
+++ b/Documentation/fb/intelfb.rst
@@ -1,24 +1,28 @@
+=============================================================
 Intel 830M/845G/852GM/855GM/865G/915G/945G Framebuffer driver
-================================================================
+=============================================================
 
 A. Introduction
-	This is a framebuffer driver for various Intel 8xx/9xx compatible
+===============
+
+This is a framebuffer driver for various Intel 8xx/9xx compatible
 graphics devices.  These would include:
 
-	Intel 830M
-	Intel 845G
-	Intel 852GM
-	Intel 855GM
-	Intel 865G
-	Intel 915G
-	Intel 915GM
-	Intel 945G
-	Intel 945GM
-	Intel 945GME
-	Intel 965G
-	Intel 965GM
+	- Intel 830M
+	- Intel 845G
+	- Intel 852GM
+	- Intel 855GM
+	- Intel 865G
+	- Intel 915G
+	- Intel 915GM
+	- Intel 945G
+	- Intel 945GM
+	- Intel 945GME
+	- Intel 965G
+	- Intel 965GM
 
 B.  List of available options
+=============================
 
    a. "video=intelfb"
 	enables the intelfb driver
@@ -39,12 +43,12 @@ B.  List of available options
 	(default = 4 MB)
 
    d. "voffset=<value>"
-        select at what offset in MB of the logical memory to allocate the
+	select at what offset in MB of the logical memory to allocate the
 	framebuffer memory.  The intent is to avoid the memory blocks
 	used by standard graphics applications (XFree86). Depending on your
-        usage, adjust the value up or down, (0 for maximum usage, 63/127 MB
-        for the least amount).  Note, an arbitrary setting may conflict
-        with XFree86.
+	usage, adjust the value up or down, (0 for maximum usage, 63/127 MB
+	for the least amount).  Note, an arbitrary setting may conflict
+	with XFree86.
 
 	Recommendation: do not set
 	(default = 48 MB)
@@ -80,18 +84,19 @@ B.  List of available options
    The default parameter (not named) is the mode.
 
 C. Kernel booting
+=================
 
 Separate each option/option-pair by commas (,) and the option from its value
-with an equals sign (=) as in the following:
+with an equals sign (=) as in the following::
 
-video=intelfb:option1,option2=value2
+	video=intelfb:option1,option2=value2
 
 Sample Usage
 ------------
 
-In /etc/lilo.conf, add the line:
+In /etc/lilo.conf, add the line::
 
-append="video=intelfb:mode=800x600-32@75,accel,hwcursor,vram=8"
+	append="video=intelfb:mode=800x600-32@75,accel,hwcursor,vram=8"
 
 This will initialize the framebuffer to 800x600 at 32bpp and 75Hz. The
 framebuffer will use 8 MB of System RAM. hw acceleration of text and cursor
@@ -106,8 +111,9 @@ in this directory.
 
 
 D.  Module options
+==================
 
-	The module parameters are essentially similar to the kernel
+The module parameters are essentially similar to the kernel
 parameters. The main difference is that you need to include a Boolean value
 (1 for TRUE, and 0 for FALSE) for those options which don't need a value.
 
@@ -116,23 +122,24 @@ Example, to enable MTRR, include "mtrr=1".
 Sample Usage
 ------------
 
-Using the same setup as described above, load the module like this:
+Using the same setup as described above, load the module like this::
 
 	modprobe intelfb mode=800x600-32@75 vram=8 accel=1 hwcursor=1
 
-Or just add the following to a configuration file in /etc/modprobe.d/
+Or just add the following to a configuration file in /etc/modprobe.d/::
 
 	options intelfb mode=800x600-32@75 vram=8 accel=1 hwcursor=1
 
-and just do a
+and just do a::
 
 	modprobe intelfb
 
 
 E.  Acknowledgment:
+===================
 
 	1.  Geert Uytterhoeven - his excellent howto and the virtual
-                                 framebuffer driver code made this possible.
+	    framebuffer driver code made this possible.
 
 	2.  Jeff Hartmann for his agpgart code.
 
@@ -145,5 +152,4 @@ E.  Acknowledgment:
 
 	6.  Andrew Morton for his kernel patches maintenance.
 
-###########################
 Sylvain
diff --git a/Documentation/fb/internals.txt b/Documentation/fb/internals.rst
similarity index 82%
rename from Documentation/fb/internals.txt
rename to Documentation/fb/internals.rst
index 9b2a2b2f3e57..696b50aa7c24 100644
--- a/Documentation/fb/internals.txt
+++ b/Documentation/fb/internals.rst
@@ -1,13 +1,19 @@
+=============================
+Frame Buffer device internals
+=============================
 
 This is a first start for some documentation about frame buffer device
 internals.
 
-Geert Uytterhoeven <geert@linux-m68k.org>, 21 July 1998
-James Simmons <jsimmons@user.sf.net>, Nov 26 2002
+Authors:
+
+- Geert Uytterhoeven <geert@linux-m68k.org>, 21 July 1998
+- James Simmons <jsimmons@user.sf.net>, Nov 26 2002
 
 --------------------------------------------------------------------------------
 
-	    ***  STRUCTURES USED BY THE FRAME BUFFER DEVICE API  ***
+Structures used by the frame buffer device API
+==============================================
 
 The following structures play a role in the game of frame buffer devices. They
 are defined in <linux/fb.h>.
@@ -40,19 +46,18 @@ are defined in <linux/fb.h>.
     Generic information, API and low level information about a specific frame
     buffer device instance (slot number, board address, ...).
 
-  - struct `par'
+  - struct `par`
 
     Device dependent information that uniquely defines the video mode for this
     particular piece of hardware.
 
 
---------------------------------------------------------------------------------
-
-	    ***  VISUALS USED BY THE FRAME BUFFER DEVICE API  ***
+Visuals used by the frame buffer device API
+===========================================
 
 
 Monochrome (FB_VISUAL_MONO01 and FB_VISUAL_MONO10)
--------------------------------------------------
+--------------------------------------------------
 Each pixel is either black or white.
 
 
@@ -70,7 +75,7 @@ The pixel value is broken up into red, green, and blue fields.
 
 Direct color (FB_VISUAL_DIRECTCOLOR)
 ------------------------------------
-The pixel value is broken up into red, green, and blue fields, each of which 
+The pixel value is broken up into red, green, and blue fields, each of which
 are looked up in separate red, green, and blue lookup tables.
 
 
@@ -79,4 +84,3 @@ Grayscale displays
 Grayscale and static grayscale are special variants of pseudo color and static
 pseudo color, where the red, green and blue components are always equal to
 each other.
-
diff --git a/Documentation/fb/lxfb.txt b/Documentation/fb/lxfb.rst
similarity index 60%
rename from Documentation/fb/lxfb.txt
rename to Documentation/fb/lxfb.rst
index 38b3ca6f6ca7..863e6b98fbae 100644
--- a/Documentation/fb/lxfb.txt
+++ b/Documentation/fb/lxfb.rst
@@ -1,7 +1,9 @@
-[This file is cloned from VesaFB/aty128fb]
-
+=============
 What is lxfb?
-=================
+=============
+
+.. [This file is cloned from VesaFB/aty128fb]
+
 
 This is a graphics framebuffer driver for AMD Geode LX based processors.
 
@@ -23,9 +25,9 @@ How to use it?
 ==============
 
 Switching modes is done using  lxfb.mode_option=<resolution>... boot
-parameter or using `fbset' program.
+parameter or using `fbset` program.
 
-See Documentation/fb/modedb.txt for more information on modedb
+See Documentation/fb/modedb.rst for more information on modedb
 resolutions.
 
 
@@ -42,11 +44,12 @@ You can pass kernel command line options to lxfb with lxfb.<option>.
 For example, lxfb.mode_option=800x600@75.
 Accepted options:
 
-mode_option	- specify the video mode.  Of the form
-		  <x>x<y>[-<bpp>][@<refresh>]
-vram		- size of video ram (normally auto-detected)
-vt_switch	- enable vt switching during suspend/resume.  The vt
-		  switch is slow, but harmless.
+================ ==================================================
+mode_option	 specify the video mode.  Of the form
+		 <x>x<y>[-<bpp>][@<refresh>]
+vram		 size of video ram (normally auto-detected)
+vt_switch	 enable vt switching during suspend/resume.  The vt
+		 switch is slow, but harmless.
+================ ==================================================
 
---
 Andres Salomon <dilinger@debian.org>
diff --git a/Documentation/fb/matroxfb.rst b/Documentation/fb/matroxfb.rst
new file mode 100644
index 000000000000..f1859d98606e
--- /dev/null
+++ b/Documentation/fb/matroxfb.rst
@@ -0,0 +1,443 @@
+=================
+What is matroxfb?
+=================
+
+.. [This file is cloned from VesaFB. Thanks go to Gerd Knorr]
+
+
+This is a driver for a graphic framebuffer for Matrox devices on
+Alpha, Intel and PPC boxes.
+
+Advantages:
+
+ * It provides a nice large console (128 cols + 48 lines with 1024x768)
+   without using tiny, unreadable fonts.
+ * You can run XF{68,86}_FBDev or XFree86 fbdev driver on top of /dev/fb0
+ * Most important: boot logo :-)
+
+Disadvantages:
+
+ * graphic mode is slower than text mode... but you should not notice
+   if you use same resolution as you used in textmode.
+
+
+How to use it?
+==============
+
+Switching modes is done using the video=matroxfb:vesa:... boot parameter
+or using `fbset` program.
+
+If you want, for example, enable a resolution of 1280x1024x24bpp you should
+pass to the kernel this command line: "video=matroxfb:vesa:0x1BB".
+
+You should compile in both vgacon (to boot if you remove you Matrox from
+box) and matroxfb (for graphics mode). You should not compile-in vesafb
+unless you have primary display on non-Matrox VBE2.0 device (see
+Documentation/fb/vesafb.rst for details).
+
+Currently supported video modes are (through vesa:... interface, PowerMac
+has [as addon] compatibility code):
+
+
+Graphic modes
+-------------
+
+===  =======  =======  =======  =======  =======
+bpp  640x400  640x480  768x576  800x600  960x720
+===  =======  =======  =======  =======  =======
+  4             0x12             0x102
+  8   0x100    0x101    0x180    0x103    0x188
+ 15            0x110    0x181    0x113    0x189
+ 16            0x111    0x182    0x114    0x18A
+ 24            0x1B2    0x184    0x1B5    0x18C
+ 32            0x112    0x183    0x115    0x18B
+===  =======  =======  =======  =======  =======
+
+
+Graphic modes (continued)
+-------------------------
+
+===  ======== ======== ========= ========= =========
+bpp  1024x768 1152x864 1280x1024 1408x1056 1600x1200
+===  ======== ======== ========= ========= =========
+  4    0x104             0x106
+  8    0x105    0x190    0x107     0x198     0x11C
+ 15    0x116    0x191    0x119     0x199     0x11D
+ 16    0x117    0x192    0x11A     0x19A     0x11E
+ 24    0x1B8    0x194    0x1BB     0x19C     0x1BF
+ 32    0x118    0x193    0x11B     0x19B
+===  ======== ======== ========= ========= =========
+
+
+Text modes
+----------
+
+==== =======  =======  ========  ========  ========
+text 640x400  640x480  1056x344  1056x400  1056x480
+==== =======  =======  ========  ========  ========
+ 8x8   0x1C0    0x108     0x10A     0x10B     0x10C
+8x16 2, 3, 7                        0x109
+==== =======  =======  ========  ========  ========
+
+You can enter these number either hexadecimal (leading `0x`) or decimal
+(0x100 = 256). You can also use value + 512 to achieve compatibility
+with your old number passed to vesafb.
+
+Non-listed number can be achieved by more complicated command-line, for
+example 1600x1200x32bpp can be specified by `video=matroxfb:vesa:0x11C,depth:32`.
+
+
+X11
+===
+
+XF{68,86}_FBDev should work just fine, but it is non-accelerated. On non-intel
+architectures there are some glitches for 24bpp videomodes. 8, 16 and 32bpp
+works fine.
+
+Running another (accelerated) X-Server like XF86_SVGA works too. But (at least)
+XFree servers have big troubles in multihead configurations (even on first
+head, not even talking about second). Running XFree86 4.x accelerated mga
+driver is possible, but you must not enable DRI - if you do, resolution and
+color depth of your X desktop must match resolution and color depths of your
+virtual consoles, otherwise X will corrupt accelerator settings.
+
+
+SVGALib
+=======
+
+Driver contains SVGALib compatibility code. It is turned on by choosing textual
+mode for console. You can do it at boot time by using videomode
+2,3,7,0x108-0x10C or 0x1C0. At runtime, `fbset -depth 0` does this work.
+Unfortunately, after SVGALib application exits, screen contents is corrupted.
+Switching to another console and back fixes it. I hope that it is SVGALib's
+problem and not mine, but I'm not sure.
+
+
+Configuration
+=============
+
+You can pass kernel command line options to matroxfb with
+`video=matroxfb:option1,option2:value2,option3` (multiple options should be
+separated by comma, values are separated from options by `:`).
+Accepted options:
+
+============ ===================================================================
+mem:X        size of memory (X can be in megabytes, kilobytes or bytes)
+	     You can only decrease value determined by driver because of
+	     it always probe for memory. Default is to use whole detected
+	     memory usable for on-screen display (i.e. max. 8 MB).
+disabled     do not load driver; you can use also `off`, but `disabled`
+	     is here too.
+enabled      load driver, if you have `video=matroxfb:disabled` in LILO
+	     configuration, you can override it by this (you cannot override
+	     `off`). It is default.
+noaccel      do not use acceleration engine. It does not work on Alphas.
+accel        use acceleration engine. It is default.
+nopan        create initial consoles with vyres = yres, thus disabling virtual
+	     scrolling.
+pan          create initial consoles as tall as possible (vyres = memory/vxres).
+	     It is default.
+nopciretry   disable PCI retries. It is needed for some broken chipsets,
+	     it is autodetected for intel's 82437. In this case device does
+	     not comply to PCI 2.1 specs (it will not guarantee that every
+	     transaction terminate with success or retry in 32 PCLK).
+pciretry     enable PCI retries. It is default, except for intel's 82437.
+novga        disables VGA I/O ports. It is default if BIOS did not enable
+	     device. You should not use this option, some boards then do not
+	     restart without power off.
+vga          preserve state of VGA I/O ports. It is default. Driver does not
+	     enable VGA I/O if BIOS did not it (it is not safe to enable it in
+	     most cases).
+nobios       disables BIOS ROM. It is default if BIOS did not enable BIOS
+	     itself. You should not use this option, some boards then do not
+	     restart without power off.
+bios         preserve state of BIOS ROM. It is default. Driver does not enable
+	     BIOS if BIOS was not enabled before.
+noinit       tells driver, that devices were already initialized. You should use
+	     it if you have G100 and/or if driver cannot detect memory, you see
+	     strange pattern on screen and so on. Devices not enabled by BIOS
+	     are still initialized. It is default.
+init         driver initializes every device it knows about.
+memtype      specifies memory type, implies 'init'. This is valid only for G200
+	     and G400 and has following meaning:
+
+	       G200:
+		 -  0 -> 2x128Kx32 chips, 2MB onboard, probably sgram
+		 -  1 -> 2x128Kx32 chips, 4MB onboard, probably sgram
+		 -  2 -> 2x256Kx32 chips, 4MB onboard, probably sgram
+		 -  3 -> 2x256Kx32 chips, 8MB onboard, probably sgram
+		 -  4 -> 2x512Kx16 chips, 8/16MB onboard, probably sdram only
+		 -  5 -> same as above
+		 -  6 -> 4x128Kx32 chips, 4MB onboard, probably sgram
+		 -  7 -> 4x128Kx32 chips, 8MB onboard, probably sgram
+	       G400:
+		 -  0 -> 2x512Kx16 SDRAM, 16/32MB
+		 -	 2x512Kx32 SGRAM, 16/32MB
+		 -  1 -> 2x256Kx32 SGRAM, 8/16MB
+		 -  2 -> 4x128Kx32 SGRAM, 8/16MB
+		 -  3 -> 4x512Kx32 SDRAM, 32MB
+		 -  4 -> 4x256Kx32 SGRAM, 16/32MB
+		 -  5 -> 2x1Mx32 SDRAM, 32MB
+		 -  6 -> reserved
+		 -  7 -> reserved
+
+	     You should use sdram or sgram parameter in addition to memtype
+	     parameter.
+nomtrr       disables write combining on frame buffer. This slows down driver
+	     but there is reported minor incompatibility between GUS DMA and
+	     XFree under high loads if write combining is enabled (sound
+	     dropouts).
+mtrr         enables write combining on frame buffer. It speeds up video
+	     accesses much. It is default. You must have MTRR support enabled
+	     in kernel and your CPU must have MTRR (f.e. Pentium II have them).
+sgram        tells to driver that you have Gxx0 with SGRAM memory. It has no
+	     effect without `init`.
+sdram        tells to driver that you have Gxx0 with SDRAM memory.
+	     It is a default.
+inv24        change timings parameters for 24bpp modes on Millennium and
+	     Millennium II. Specify this if you see strange color shadows
+	     around  characters.
+noinv24      use standard timings. It is the default.
+inverse      invert colors on screen (for LCD displays)
+noinverse    show true colors on screen. It is default.
+dev:X        bind driver to device X. Driver numbers device from 0 up to N,
+	     where device 0 is first `known` device found, 1 second and so on.
+	     lspci lists devices in this order.
+	     Default is `every` known device.
+nohwcursor   disables hardware cursor (use software cursor instead).
+hwcursor     enables hardware cursor. It is default. If you are using
+	     non-accelerated mode (`noaccel` or `fbset -accel false`), software
+	     cursor is used (except for text mode).
+noblink      disables cursor blinking. Cursor in text mode always blinks (hw
+	     limitation).
+blink        enables cursor blinking. It is default.
+nofastfont   disables fastfont feature. It is default.
+fastfont:X   enables fastfont feature. X specifies size of memory reserved for
+	     font data, it must be >= (fontwidth*fontheight*chars_in_font)/8.
+	     It is faster on Gx00 series, but slower on older cards.
+grayscale    enable grayscale summing. It works in PSEUDOCOLOR modes (text,
+	     4bpp, 8bpp). In DIRECTCOLOR modes it is limited to characters
+	     displayed through putc/putcs. Direct accesses to framebuffer
+	     can paint colors.
+nograyscale  disable grayscale summing. It is default.
+cross4MB     enables that pixel line can cross 4MB boundary. It is default for
+	     non-Millennium.
+nocross4MB   pixel line must not cross 4MB boundary. It is default for
+	     Millennium I or II, because of these devices have hardware
+	     limitations which do not allow this. But this option is
+	     incompatible with some (if not all yet released) versions of
+	     XF86_FBDev.
+dfp          enables digital flat panel interface. This option is incompatible
+	     with secondary (TV) output - if DFP is active, TV output must be
+	     inactive and vice versa. DFP always uses same timing as primary
+	     (monitor) output.
+dfp:X        use settings X for digital flat panel interface. X is number from
+	     0 to 0xFF, and meaning of each individual bit is described in
+	     G400 manual, in description of DAC register 0x1F. For normal
+	     operation you should set all bits to zero, except lowest bit. This
+	     lowest bit selects who is source of display clocks, whether G400,
+	     or panel. Default value is now read back from hardware - so you
+	     should specify this value only if you are also using `init`
+	     parameter.
+outputs:XYZ  set mapping between CRTC and outputs. Each letter can have value
+	     of 0 (for no CRTC), 1 (CRTC1) or 2 (CRTC2), and first letter
+	     corresponds to primary analog output, second letter to the
+	     secondary analog output and third letter to the DVI output.
+	     Default setting is 100 for cards below G400 or G400 without DFP,
+	     101 for G400 with DFP, and 111 for G450 and G550. You can set
+	     mapping only on first card, use matroxset for setting up other
+	     devices.
+vesa:X       selects startup videomode. X is number from 0 to 0x1FF, see table
+	     above for detailed explanation. Default is 640x480x8bpp if driver
+	     has 8bpp support. Otherwise first available of 640x350x4bpp,
+	     640x480x15bpp, 640x480x24bpp, 640x480x32bpp or 80x25 text
+	     (80x25 text is always available).
+============ ===================================================================
+
+If you are not satisfied with videomode selected by `vesa` option, you
+can modify it with these options:
+
+============ ===================================================================
+xres:X       horizontal resolution, in pixels. Default is derived from `vesa`
+	     option.
+yres:X       vertical resolution, in pixel lines. Default is derived from `vesa`
+	     option.
+upper:X      top boundary: lines between end of VSYNC pulse and start of first
+	     pixel line of picture. Default is derived from `vesa` option.
+lower:X      bottom boundary: lines between end of picture and start of VSYNC
+	     pulse. Default is derived from `vesa` option.
+vslen:X      length of VSYNC pulse, in lines. Default is derived from `vesa`
+	     option.
+left:X       left boundary: pixels between end of HSYNC pulse and first pixel.
+	     Default is derived from `vesa` option.
+right:X      right boundary: pixels between end of picture and start of HSYNC
+	     pulse. Default is derived from `vesa` option.
+hslen:X      length of HSYNC pulse, in pixels. Default is derived from `vesa`
+	     option.
+pixclock:X   dotclocks, in ps (picoseconds). Default is derived from `vesa`
+	     option and from `fh` and `fv` options.
+sync:X       sync. pulse - bit 0 inverts HSYNC polarity, bit 1 VSYNC polarity.
+	     If bit 3 (value 0x08) is set, composite sync instead of HSYNC is
+	     generated. If bit 5 (value 0x20) is set, sync on green is turned
+	     on. Do not forget that if you want sync on green, you also probably
+	     want composite sync.
+	     Default depends on `vesa`.
+depth:X      Bits per pixel: 0=text, 4,8,15,16,24 or 32. Default depends on
+	     `vesa`.
+============ ===================================================================
+
+If you know capabilities of your monitor, you can specify some (or all) of
+`maxclk`, `fh` and `fv`. In this case, `pixclock` is computed so that
+pixclock <= maxclk, real_fh <= fh and real_fv <= fv.
+
+============ ==================================================================
+maxclk:X     maximum dotclock. X can be specified in MHz, kHz or Hz. Default is
+	     `don`t care`.
+fh:X         maximum horizontal synchronization frequency. X can be specified
+	     in kHz or Hz. Default is `don't care`.
+fv:X         maximum vertical frequency. X must be specified in Hz. Default is
+	     70 for modes derived from `vesa` with yres <= 400, 60Hz for
+	     yres > 400.
+============ ==================================================================
+
+
+Limitations
+===========
+
+There are known and unknown bugs, features and misfeatures.
+Currently there are following known bugs:
+
+ - SVGALib does not restore screen on exit
+ - generic fbcon-cfbX procedures do not work on Alphas. Due to this,
+   `noaccel` (and cfb4 accel) driver does not work on Alpha. So everyone
+   with access to `/dev/fb*` on Alpha can hang machine (you should restrict
+   access to `/dev/fb*` - everyone with access to this device can destroy
+   your monitor, believe me...).
+ - 24bpp does not support correctly XF-FBDev on big-endian architectures.
+ - interlaced text mode is not supported; it looks like hardware limitation,
+   but I'm not sure.
+ - Gxx0 SGRAM/SDRAM is not autodetected.
+ - If you are using more than one framebuffer device, you must boot kernel
+   with 'video=scrollback:0'.
+ - maybe more...
+
+And following misfeatures:
+
+ - SVGALib does not restore screen on exit.
+ - pixclock for text modes is limited by hardware to
+
+    - 83 MHz on G200
+    - 66 MHz on Millennium I
+    - 60 MHz on Millennium II
+
+   Because I have no access to other devices, I do not know specific
+   frequencies for them. So driver does not check this and allows you to
+   set frequency higher that this. It causes sparks, black holes and other
+   pretty effects on screen. Device was not destroyed during tests. :-)
+ - my Millennium G200 oscillator has frequency range from 35 MHz to 380 MHz
+   (and it works with 8bpp on about 320 MHz dotclocks (and changed mclk)).
+   But Matrox says on product sheet that VCO limit is 50-250 MHz, so I believe
+   them (maybe that chip overheats, but it has a very big cooler (G100 has
+   none), so it should work).
+ - special mixed video/graphics videomodes of Mystique and Gx00 - 2G8V16 and
+   G16V16 are not supported
+ - color keying is not supported
+ - feature connector of Mystique and Gx00 is set to VGA mode (it is disabled
+   by BIOS)
+ - DDC (monitor detection) is supported through dualhead driver
+ - some check for input values are not so strict how it should be (you can
+   specify vslen=4000 and so on).
+ - maybe more...
+
+And following features:
+
+ - 4bpp is available only on Millennium I and Millennium II. It is hardware
+   limitation.
+ - selection between 1:5:5:5 and 5:6:5 16bpp videomode is done by -rgba
+   option of fbset: "fbset -depth 16 -rgba 5,5,5" selects 1:5:5:5, anything
+   else selects 5:6:5 mode.
+ - text mode uses 6 bit VGA palette instead of 8 bit (one of 262144 colors
+   instead of one of 16M colors). It is due to hardware limitation of
+   Millennium I/II and SVGALib compatibility.
+
+
+Benchmarks
+==========
+It is time to redraw whole screen 1000 times in 1024x768, 60Hz. It is
+time for draw 6144000 characters on screen through /dev/vcsa
+(for 32bpp it is about 3GB of data (exactly 3000 MB); for 8x16 font in
+16 seconds, i.e. 187 MBps).
+Times were obtained from one older version of driver, now they are about 3%
+faster, it is kernel-space only time on P-II/350 MHz, Millennium I in 33 MHz
+PCI slot, G200 in AGP 2x slot. I did not test vgacon::
+
+  NOACCEL
+	8x16                 12x22
+	Millennium I  G200   Millennium I  G200
+  8bpp    16.42         9.54   12.33         9.13
+  16bpp   21.00        15.70   19.11        15.02
+  24bpp   36.66        36.66   35.00        35.00
+  32bpp   35.00        30.00   33.85        28.66
+
+  ACCEL, nofastfont
+	8x16                 12x22                6x11
+	Millennium I  G200   Millennium I  G200   Millennium I  G200
+  8bpp     7.79         7.24   13.55         7.78   30.00        21.01
+  16bpp    9.13         7.78   16.16         7.78   30.00        21.01
+  24bpp   14.17        10.72   18.69        10.24   34.99        21.01
+  32bpp   16.15	     16.16   18.73        13.09   34.99        21.01
+
+  ACCEL, fastfont
+	8x16                 12x22                6x11
+	Millennium I  G200   Millennium I  G200   Millennium I  G200
+  8bpp     8.41         6.01    6.54         4.37   16.00        10.51
+  16bpp    9.54         9.12    8.76         6.17   17.52        14.01
+  24bpp   15.00        12.36   11.67        10.00   22.01        18.32
+  32bpp   16.18        18.29*  12.71        12.74   24.44        21.00
+
+  TEXT
+	8x16
+	Millennium I  G200
+  TEXT     3.29         1.50
+
+  * Yes, it is slower than Millennium I.
+
+
+Dualhead G400
+=============
+Driver supports dualhead G400 with some limitations:
+ + secondary head shares videomemory with primary head. It is not problem
+   if you have 32MB of videoram, but if you have only 16MB, you may have
+   to think twice before choosing videomode (for example twice 1880x1440x32bpp
+   is not possible).
+ + due to hardware limitation, secondary head can use only 16 and 32bpp
+   videomodes.
+ + secondary head is not accelerated. There were bad problems with accelerated
+   XFree when secondary head used to use acceleration.
+ + secondary head always powerups in 640x480@60-32 videomode. You have to use
+   fbset to change this mode.
+ + secondary head always powerups in monitor mode. You have to use fbmatroxset
+   to change it to TV mode. Also, you must select at least 525 lines for
+   NTSC output and 625 lines for PAL output.
+ + kernel is not fully multihead ready. So some things are impossible to do.
+ + if you compiled it as module, you must insert i2c-matroxfb, matroxfb_maven
+   and matroxfb_crtc2 into kernel.
+
+
+Dualhead G450
+=============
+Driver supports dualhead G450 with some limitations:
+ + secondary head shares videomemory with primary head. It is not problem
+   if you have 32MB of videoram, but if you have only 16MB, you may have
+   to think twice before choosing videomode.
+ + due to hardware limitation, secondary head can use only 16 and 32bpp
+   videomodes.
+ + secondary head is not accelerated.
+ + secondary head always powerups in 640x480@60-32 videomode. You have to use
+   fbset to change this mode.
+ + TV output is not supported
+ + kernel is not fully multihead ready, so some things are impossible to do.
+ + if you compiled it as module, you must insert matroxfb_g450 and matroxfb_crtc2
+   into kernel.
+
+Petr Vandrovec <vandrove@vc.cvut.cz>
diff --git a/Documentation/fb/matroxfb.txt b/Documentation/fb/matroxfb.txt
deleted file mode 100644
index b95f5bb522f2..000000000000
--- a/Documentation/fb/matroxfb.txt
+++ /dev/null
@@ -1,413 +0,0 @@
-[This file is cloned from VesaFB. Thanks go to Gerd Knorr]
-
-What is matroxfb?
-=================
-
-This is a driver for a graphic framebuffer for Matrox devices on
-Alpha, Intel and PPC boxes.
-
-Advantages:
-
- * It provides a nice large console (128 cols + 48 lines with 1024x768)
-   without using tiny, unreadable fonts.
- * You can run XF{68,86}_FBDev or XFree86 fbdev driver on top of /dev/fb0
- * Most important: boot logo :-)
-
-Disadvantages:
-
- * graphic mode is slower than text mode... but you should not notice
-   if you use same resolution as you used in textmode.
-
-
-How to use it?
-==============
-
-Switching modes is done using the video=matroxfb:vesa:... boot parameter
-or using `fbset' program.
-
-If you want, for example, enable a resolution of 1280x1024x24bpp you should
-pass to the kernel this command line: "video=matroxfb:vesa:0x1BB".
-
-You should compile in both vgacon (to boot if you remove you Matrox from
-box) and matroxfb (for graphics mode). You should not compile-in vesafb
-unless you have primary display on non-Matrox VBE2.0 device (see 
-Documentation/fb/vesafb.txt for details).
-
-Currently supported video modes are (through vesa:... interface, PowerMac
-has [as addon] compatibility code):
-
-
-[Graphic modes]
-
-bpp | 640x400  640x480  768x576  800x600  960x720
-----+--------------------------------------------
-  4 |            0x12             0x102            
-  8 |  0x100    0x101    0x180    0x103    0x188   
- 15 |           0x110    0x181    0x113    0x189   
- 16 |           0x111    0x182    0x114    0x18A   
- 24 |           0x1B2    0x184    0x1B5    0x18C   
- 32 |           0x112    0x183    0x115    0x18B   
-
-
-[Graphic modes (continued)]
-
-bpp | 1024x768 1152x864 1280x1024 1408x1056 1600x1200
-----+------------------------------------------------
-  4 |   0x104             0x106
-  8 |   0x105    0x190    0x107     0x198     0x11C
- 15 |   0x116    0x191    0x119     0x199     0x11D
- 16 |   0x117    0x192    0x11A     0x19A     0x11E
- 24 |   0x1B8    0x194    0x1BB     0x19C     0x1BF
- 32 |   0x118    0x193    0x11B     0x19B
-
-
-[Text modes]
-
-text | 640x400  640x480  1056x344  1056x400  1056x480
------+------------------------------------------------
- 8x8 |  0x1C0    0x108     0x10A     0x10B     0x10C
-8x16 | 2, 3, 7                       0x109
-
-You can enter these number either hexadecimal (leading `0x') or decimal
-(0x100 = 256). You can also use value + 512 to achieve compatibility
-with your old number passed to vesafb.
-
-Non-listed number can be achieved by more complicated command-line, for
-example 1600x1200x32bpp can be specified by `video=matroxfb:vesa:0x11C,depth:32'.
-
-
-X11
-===
-
-XF{68,86}_FBDev should work just fine, but it is non-accelerated. On non-intel
-architectures there are some glitches for 24bpp videomodes. 8, 16 and 32bpp
-works fine.
-
-Running another (accelerated) X-Server like XF86_SVGA works too. But (at least)
-XFree servers have big troubles in multihead configurations (even on first
-head, not even talking about second). Running XFree86 4.x accelerated mga 
-driver is possible, but you must not enable DRI - if you do, resolution and
-color depth of your X desktop must match resolution and color depths of your
-virtual consoles, otherwise X will corrupt accelerator settings.
-
-
-SVGALib
-=======
-
-Driver contains SVGALib compatibility code. It is turned on by choosing textual
-mode for console. You can do it at boot time by using videomode
-2,3,7,0x108-0x10C or 0x1C0. At runtime, `fbset -depth 0' does this work.
-Unfortunately, after SVGALib application exits, screen contents is corrupted.
-Switching to another console and back fixes it. I hope that it is SVGALib's
-problem and not mine, but I'm not sure.
-
-
-Configuration
-=============
-
-You can pass kernel command line options to matroxfb with
-`video=matroxfb:option1,option2:value2,option3' (multiple options should be 
-separated by comma, values are separated from options by `:'). 
-Accepted options:
-
-mem:X    - size of memory (X can be in megabytes, kilobytes or bytes)
-           You can only decrease value determined by driver because of
-	   it always probe for memory. Default is to use whole detected
-	   memory usable for on-screen display (i.e. max. 8 MB).
-disabled - do not load driver; you can use also `off', but `disabled'
-           is here too.
-enabled  - load driver, if you have `video=matroxfb:disabled' in LILO
-           configuration, you can override it by this (you cannot override
-	   `off'). It is default.
-noaccel  - do not use acceleration engine. It does not work on Alphas.
-accel    - use acceleration engine. It is default.
-nopan    - create initial consoles with vyres = yres, thus disabling virtual
-           scrolling.
-pan      - create initial consoles as tall as possible (vyres = memory/vxres).
-           It is default.
-nopciretry - disable PCI retries. It is needed for some broken chipsets,
-           it is autodetected for intel's 82437. In this case device does
-	   not comply to PCI 2.1 specs (it will not guarantee that every
-	   transaction terminate with success or retry in 32 PCLK).
-pciretry - enable PCI retries. It is default, except for intel's 82437.
-novga    - disables VGA I/O ports. It is default if BIOS did not enable device.
-           You should not use this option, some boards then do not restart
-	   without power off.
-vga      - preserve state of VGA I/O ports. It is default. Driver does not
-           enable VGA I/O if BIOS did not it (it is not safe to enable it in
-	   most cases).
-nobios   - disables BIOS ROM. It is default if BIOS did not enable BIOS itself.
-           You should not use this option, some boards then do not restart
-	   without power off.
-bios     - preserve state of BIOS ROM. It is default. Driver does not enable
-           BIOS if BIOS was not enabled before.
-noinit   - tells driver, that devices were already initialized. You should use
-           it if you have G100 and/or if driver cannot detect memory, you see
-	   strange pattern on screen and so on. Devices not enabled by BIOS
-	   are still initialized. It is default.
-init     - driver initializes every device it knows about.
-memtype  - specifies memory type, implies 'init'. This is valid only for G200 
-           and G400 and has following meaning:
-             G200: 0 -> 2x128Kx32 chips, 2MB onboard, probably sgram
-                   1 -> 2x128Kx32 chips, 4MB onboard, probably sgram
-                   2 -> 2x256Kx32 chips, 4MB onboard, probably sgram
-                   3 -> 2x256Kx32 chips, 8MB onboard, probably sgram
-                   4 -> 2x512Kx16 chips, 8/16MB onboard, probably sdram only
-                   5 -> same as above
-                   6 -> 4x128Kx32 chips, 4MB onboard, probably sgram
-                   7 -> 4x128Kx32 chips, 8MB onboard, probably sgram
-             G400: 0 -> 2x512Kx16 SDRAM, 16/32MB
-                        2x512Kx32 SGRAM, 16/32MB
-                   1 -> 2x256Kx32 SGRAM, 8/16MB
-                   2 -> 4x128Kx32 SGRAM, 8/16MB
-                   3 -> 4x512Kx32 SDRAM, 32MB
-                   4 -> 4x256Kx32 SGRAM, 16/32MB
-                   5 -> 2x1Mx32 SDRAM, 32MB
-                   6 -> reserved
-                   7 -> reserved
-           You should use sdram or sgram parameter in addition to memtype 
-           parameter.
-nomtrr   - disables write combining on frame buffer. This slows down driver but
-           there is reported minor incompatibility between GUS DMA and XFree
-	   under high loads if write combining is enabled (sound dropouts).
-mtrr     - enables write combining on frame buffer. It speeds up video accesses
-           much. It is default. You must have MTRR support enabled in kernel
-	   and your CPU must have MTRR (f.e. Pentium II have them).
-sgram    - tells to driver that you have Gxx0 with SGRAM memory. It has no
-           effect without `init'.
-sdram    - tells to driver that you have Gxx0 with SDRAM memory.
-           It is a default.
-inv24    - change timings parameters for 24bpp modes on Millennium and
-           Millennium II. Specify this if you see strange color shadows around
-	   characters.
-noinv24  - use standard timings. It is the default.
-inverse  - invert colors on screen (for LCD displays)
-noinverse - show true colors on screen. It is default.
-dev:X    - bind driver to device X. Driver numbers device from 0 up to N,
-           where device 0 is first `known' device found, 1 second and so on.
-	   lspci lists devices in this order.
-	   Default is `every' known device.
-nohwcursor - disables hardware cursor (use software cursor instead).
-hwcursor - enables hardware cursor. It is default. If you are using
-           non-accelerated mode (`noaccel' or `fbset -accel false'), software
-	   cursor is used (except for text mode).
-noblink  - disables cursor blinking. Cursor in text mode always blinks (hw
-           limitation).
-blink    - enables cursor blinking. It is default.
-nofastfont - disables fastfont feature. It is default.
-fastfont:X - enables fastfont feature. X specifies size of memory reserved for
-             font data, it must be >= (fontwidth*fontheight*chars_in_font)/8.
-	     It is faster on Gx00 series, but slower on older cards.
-grayscale - enable grayscale summing. It works in PSEUDOCOLOR modes (text,
-            4bpp, 8bpp). In DIRECTCOLOR modes it is limited to characters
-	    displayed through putc/putcs. Direct accesses to framebuffer
-	    can paint colors.
-nograyscale - disable grayscale summing. It is default.
-cross4MB - enables that pixel line can cross 4MB boundary. It is default for
-           non-Millennium.
-nocross4MB - pixel line must not cross 4MB boundary. It is default for
-             Millennium I or II, because of these devices have hardware
-	     limitations which do not allow this. But this option is
-	     incompatible with some (if not all yet released) versions of
-	     XF86_FBDev.
-dfp      - enables digital flat panel interface. This option is incompatible with
-           secondary (TV) output - if DFP is active, TV output must be
-	   inactive and vice versa. DFP always uses same timing as primary
-	   (monitor) output.
-dfp:X    - use settings X for digital flat panel interface. X is number from
-           0 to 0xFF, and meaning of each individual bit is described in
-	   G400 manual, in description of DAC register 0x1F. For normal operation
-	   you should set all bits to zero, except lowest bit. This lowest bit
-	   selects who is source of display clocks, whether G400, or panel.
-	   Default value is now read back from hardware - so you should specify
-	   this value only if you are also using `init' parameter.
-outputs:XYZ - set mapping between CRTC and outputs. Each letter can have value
-           of 0 (for no CRTC), 1 (CRTC1) or 2 (CRTC2), and first letter corresponds
-	   to primary analog output, second letter to the secondary analog output
-	   and third letter to the DVI output. Default setting is 100 for
-	   cards below G400 or G400 without DFP, 101 for G400 with DFP, and
-	   111 for G450 and G550. You can set mapping only on first card,
-	   use matroxset for setting up other devices.
-vesa:X   - selects startup videomode. X is number from 0 to 0x1FF, see table
-           above for detailed explanation. Default is 640x480x8bpp if driver
-	   has 8bpp support. Otherwise first available of 640x350x4bpp,
-	   640x480x15bpp, 640x480x24bpp, 640x480x32bpp or 80x25 text
-	   (80x25 text is always available).
-
-If you are not satisfied with videomode selected by `vesa' option, you
-can modify it with these options:
-
-xres:X   - horizontal resolution, in pixels. Default is derived from `vesa'
-           option.
-yres:X   - vertical resolution, in pixel lines. Default is derived from `vesa'
-           option.
-upper:X  - top boundary: lines between end of VSYNC pulse and start of first
-           pixel line of picture. Default is derived from `vesa' option.
-lower:X  - bottom boundary: lines between end of picture and start of VSYNC
-           pulse. Default is derived from `vesa' option.
-vslen:X  - length of VSYNC pulse, in lines. Default is derived from `vesa'
-           option.
-left:X   - left boundary: pixels between end of HSYNC pulse and first pixel.
-           Default is derived from `vesa' option.
-right:X  - right boundary: pixels between end of picture and start of HSYNC
-           pulse. Default is derived from `vesa' option.
-hslen:X  - length of HSYNC pulse, in pixels. Default is derived from `vesa'
-           option.
-pixclock:X - dotclocks, in ps (picoseconds). Default is derived from `vesa'
-             option and from `fh' and `fv' options.
-sync:X   - sync. pulse - bit 0 inverts HSYNC polarity, bit 1 VSYNC polarity.
-           If bit 3 (value 0x08) is set, composite sync instead of HSYNC is
-	   generated. If bit 5 (value 0x20) is set, sync on green is turned on.
-	   Do not forget that if you want sync on green, you also probably
-	   want composite sync.
-	   Default depends on `vesa'.
-depth:X  - Bits per pixel: 0=text, 4,8,15,16,24 or 32. Default depends on
-           `vesa'.
-
-If you know capabilities of your monitor, you can specify some (or all) of
-`maxclk', `fh' and `fv'. In this case, `pixclock' is computed so that
-pixclock <= maxclk, real_fh <= fh and real_fv <= fv.
-
-maxclk:X - maximum dotclock. X can be specified in MHz, kHz or Hz. Default is
-           `don't care'.
-fh:X     - maximum horizontal synchronization frequency. X can be specified
-           in kHz or Hz. Default is `don't care'.
-fv:X     - maximum vertical frequency. X must be specified in Hz. Default is
-           70 for modes derived from `vesa' with yres <= 400, 60Hz for
-	   yres > 400.
-
-
-Limitations
-===========
-
-There are known and unknown bugs, features and misfeatures.
-Currently there are following known bugs:
- + SVGALib does not restore screen on exit
- + generic fbcon-cfbX procedures do not work on Alphas. Due to this,
-   `noaccel' (and cfb4 accel) driver does not work on Alpha. So everyone
-   with access to /dev/fb* on Alpha can hang machine (you should restrict
-   access to /dev/fb* - everyone with access to this device can destroy
-   your monitor, believe me...).
- + 24bpp does not support correctly XF-FBDev on big-endian architectures.
- + interlaced text mode is not supported; it looks like hardware limitation,
-   but I'm not sure.
- + Gxx0 SGRAM/SDRAM is not autodetected.
- + If you are using more than one framebuffer device, you must boot kernel
-   with 'video=scrollback:0'.
- + maybe more...
-And following misfeatures:
- + SVGALib does not restore screen on exit.
- + pixclock for text modes is limited by hardware to
-    83 MHz on G200
-    66 MHz on Millennium I
-    60 MHz on Millennium II
-   Because I have no access to other devices, I do not know specific
-   frequencies for them. So driver does not check this and allows you to
-   set frequency higher that this. It causes sparks, black holes and other
-   pretty effects on screen. Device was not destroyed during tests. :-)
- + my Millennium G200 oscillator has frequency range from 35 MHz to 380 MHz
-   (and it works with 8bpp on about 320 MHz dotclocks (and changed mclk)).
-   But Matrox says on product sheet that VCO limit is 50-250 MHz, so I believe
-   them (maybe that chip overheats, but it has a very big cooler (G100 has
-   none), so it should work).
- + special mixed video/graphics videomodes of Mystique and Gx00 - 2G8V16 and
-   G16V16 are not supported
- + color keying is not supported
- + feature connector of Mystique and Gx00 is set to VGA mode (it is disabled
-   by BIOS)
- + DDC (monitor detection) is supported through dualhead driver
- + some check for input values are not so strict how it should be (you can
-   specify vslen=4000 and so on).
- + maybe more...
-And following features:
- + 4bpp is available only on Millennium I and Millennium II. It is hardware
-   limitation.
- + selection between 1:5:5:5 and 5:6:5 16bpp videomode is done by -rgba 
-   option of fbset: "fbset -depth 16 -rgba 5,5,5" selects 1:5:5:5, anything
-   else selects 5:6:5 mode.
- + text mode uses 6 bit VGA palette instead of 8 bit (one of 262144 colors
-   instead of one of 16M colors). It is due to hardware limitation of 
-   Millennium I/II and SVGALib compatibility.
-
-
-Benchmarks
-==========
-It is time to redraw whole screen 1000 times in 1024x768, 60Hz. It is
-time for draw 6144000 characters on screen through /dev/vcsa
-(for 32bpp it is about 3GB of data (exactly 3000 MB); for 8x16 font in 
-16 seconds, i.e. 187 MBps).
-Times were obtained from one older version of driver, now they are about 3%
-faster, it is kernel-space only time on P-II/350 MHz, Millennium I in 33 MHz
-PCI slot, G200 in AGP 2x slot. I did not test vgacon.
-
-NOACCEL
-        8x16                 12x22
-        Millennium I  G200   Millennium I  G200
-8bpp    16.42         9.54   12.33         9.13
-16bpp   21.00        15.70   19.11        15.02
-24bpp   36.66        36.66   35.00        35.00
-32bpp   35.00        30.00   33.85        28.66
-
-ACCEL, nofastfont
-        8x16                 12x22                6x11
-	Millennium I  G200   Millennium I  G200   Millennium I  G200
-8bpp     7.79         7.24   13.55         7.78   30.00        21.01
-16bpp    9.13         7.78   16.16         7.78   30.00        21.01
-24bpp   14.17        10.72   18.69        10.24   34.99        21.01
-32bpp   16.15	     16.16   18.73        13.09   34.99        21.01
-
-ACCEL, fastfont
-        8x16                 12x22                6x11
-	Millennium I  G200   Millennium I  G200   Millennium I  G200
-8bpp     8.41         6.01    6.54         4.37   16.00        10.51
-16bpp    9.54         9.12    8.76         6.17   17.52        14.01
-24bpp   15.00        12.36   11.67        10.00   22.01        18.32
-32bpp   16.18        18.29*  12.71        12.74   24.44        21.00
-
-TEXT
-        8x16
-	Millennium I  G200
-TEXT     3.29         1.50
-
-* Yes, it is slower than Millennium I.
-
-
-Dualhead G400
-=============
-Driver supports dualhead G400 with some limitations:
- + secondary head shares videomemory with primary head. It is not problem
-   if you have 32MB of videoram, but if you have only 16MB, you may have
-   to think twice before choosing videomode (for example twice 1880x1440x32bpp
-   is not possible).
- + due to hardware limitation, secondary head can use only 16 and 32bpp
-   videomodes.
- + secondary head is not accelerated. There were bad problems with accelerated
-   XFree when secondary head used to use acceleration.
- + secondary head always powerups in 640x480@60-32 videomode. You have to use
-   fbset to change this mode.
- + secondary head always powerups in monitor mode. You have to use fbmatroxset
-   to change it to TV mode. Also, you must select at least 525 lines for
-   NTSC output and 625 lines for PAL output.
- + kernel is not fully multihead ready. So some things are impossible to do.
- + if you compiled it as module, you must insert i2c-matroxfb, matroxfb_maven
-   and matroxfb_crtc2 into kernel.
-
-
-Dualhead G450
-=============
-Driver supports dualhead G450 with some limitations:
- + secondary head shares videomemory with primary head. It is not problem
-   if you have 32MB of videoram, but if you have only 16MB, you may have
-   to think twice before choosing videomode.
- + due to hardware limitation, secondary head can use only 16 and 32bpp
-   videomodes.
- + secondary head is not accelerated.
- + secondary head always powerups in 640x480@60-32 videomode. You have to use
-   fbset to change this mode.
- + TV output is not supported
- + kernel is not fully multihead ready, so some things are impossible to do.
- + if you compiled it as module, you must insert matroxfb_g450 and matroxfb_crtc2
-   into kernel.
-	
---
-Petr Vandrovec <vandrove@vc.cvut.cz>
diff --git a/Documentation/fb/metronomefb.txt b/Documentation/fb/metronomefb.rst
similarity index 98%
rename from Documentation/fb/metronomefb.txt
rename to Documentation/fb/metronomefb.rst
index 237ca412582d..63e1d31a7e54 100644
--- a/Documentation/fb/metronomefb.txt
+++ b/Documentation/fb/metronomefb.rst
@@ -1,6 +1,9 @@
-			Metronomefb
-			-----------
+===========
+Metronomefb
+===========
+
 Maintained by Jaya Kumar <jayakumar.lkml.gmail.com>
+
 Last revised: Mar 10, 2008
 
 Metronomefb is a driver for the Metronome display controller. The controller
@@ -33,4 +36,3 @@ the physical media.
 Metronomefb uses the deferred IO interface so that it can provide a memory
 mappable frame buffer. It has been tested with tinyx (Xfbdev). It is known
 to work at this time with xeyes, xclock, xloadimage, xpdf.
-
diff --git a/Documentation/fb/modedb.txt b/Documentation/fb/modedb.rst
similarity index 87%
rename from Documentation/fb/modedb.txt
rename to Documentation/fb/modedb.rst
index 16aa08453911..3c2397293977 100644
--- a/Documentation/fb/modedb.txt
+++ b/Documentation/fb/modedb.rst
@@ -1,6 +1,6 @@
-
-
-			modedb default video mode support
+=================================
+modedb default video mode support
+=================================
 
 
 Currently all frame buffer device drivers have their own video mode databases,
@@ -18,7 +18,7 @@ When a frame buffer device receives a video= option it doesn't know, it should
 consider that to be a video mode option. If no frame buffer device is specified
 in a video= option, fbmem considers that to be a global video mode option.
 
-Valid mode specifiers (mode_option argument):
+Valid mode specifiers (mode_option argument)::
 
     <xres>x<yres>[M][R][-<bpp>][@<refresh>][i][m][eDd]
     <name>[-<bpp>][@<refresh>]
@@ -45,15 +45,18 @@ signals (e.g. HDMI and DVI-I). For other outputs it behaves like 'e'. If 'd'
 is specified the output is disabled.
 
 You can additionally specify which output the options matches to.
-To force the VGA output to be enabled and drive a specific mode say:
+To force the VGA output to be enabled and drive a specific mode say::
+
     video=VGA-1:1280x1024@60me
 
-Specifying the option multiple times for different ports is possible, e.g.:
+Specifying the option multiple times for different ports is possible, e.g.::
+
     video=LVDS-1:d video=HDMI-1:D
 
-***** oOo ***** oOo ***** oOo ***** oOo ***** oOo ***** oOo ***** oOo *****
+-----------------------------------------------------------------------------
 
 What is the VESA(TM) Coordinated Video Timings (CVT)?
+=====================================================
 
 From the VESA(TM) Website:
 
@@ -90,14 +93,14 @@ determined from its EDID. The version 1.3 of the EDID has extra 128-byte
 blocks where additional timing information is placed.  As of this time, there
 is no support yet in the layer to parse this additional blocks.)
 
-CVT also introduced a new naming convention (should be seen from dmesg output):
+CVT also introduced a new naming convention (should be seen from dmesg output)::
 
     <pix>M<a>[-R]
 
     where: pix = total amount of pixels in MB (xres x yres)
-           M   = always present
-           a   = aspect ratio (3 - 4:3; 4 - 5:4; 9 - 15:9, 16:9; A - 16:10)
-          -R   = reduced blanking
+	   M   = always present
+	   a   = aspect ratio (3 - 4:3; 4 - 5:4; 9 - 15:9, 16:9; A - 16:10)
+	  -R   = reduced blanking
 
 	  example:  .48M3-R - 800x600 with reduced blanking
 
@@ -110,15 +113,15 @@ Note: VESA(TM) has restrictions on what is a standard CVT timing:
 If one of the above are not satisfied, the kernel will print a warning but the
 timings will still be calculated.
 
-***** oOo ***** oOo ***** oOo ***** oOo ***** oOo ***** oOo ***** oOo *****
+-----------------------------------------------------------------------------
 
-To find a suitable video mode, you just call
+To find a suitable video mode, you just call::
 
-int __init fb_find_mode(struct fb_var_screeninfo *var,
-                        struct fb_info *info, const char *mode_option,
-                        const struct fb_videomode *db, unsigned int dbsize,
-                        const struct fb_videomode *default_mode,
-                        unsigned int default_bpp)
+  int __init fb_find_mode(struct fb_var_screeninfo *var,
+			  struct fb_info *info, const char *mode_option,
+			  const struct fb_videomode *db, unsigned int dbsize,
+			  const struct fb_videomode *default_mode,
+			  unsigned int default_bpp)
 
 with db/dbsize your non-standard video mode database, or NULL to use the
 standard video mode database.
@@ -127,12 +130,13 @@ fb_find_mode() first tries the specified video mode (or any mode that matches,
 e.g. there can be multiple 640x480 modes, each of them is tried). If that
 fails, the default mode is tried. If that fails, it walks over all modes.
 
-To specify a video mode at bootup, use the following boot options:
+To specify a video mode at bootup, use the following boot options::
+
     video=<driver>:<xres>x<yres>[-<bpp>][@refresh]
 
 where <driver> is a name from the table below.  Valid default modes can be
 found in linux/drivers/video/modedb.c.  Check your driver's documentation.
-There may be more modes.
+There may be more modes::
 
     Drivers that support modedb boot options
     Boot Name	  Cards Supported
diff --git a/Documentation/fb/pvr2fb.rst b/Documentation/fb/pvr2fb.rst
new file mode 100644
index 000000000000..fcf2c21c8fcf
--- /dev/null
+++ b/Documentation/fb/pvr2fb.rst
@@ -0,0 +1,66 @@
+===============
+What is pvr2fb?
+===============
+
+This is a driver for PowerVR 2 based graphics frame buffers, such as the
+one found in the Dreamcast.
+
+Advantages:
+
+ * It provides a nice large console (128 cols + 48 lines with 1024x768)
+   without using tiny, unreadable fonts (NOT on the Dreamcast)
+ * You can run XF86_FBDev on top of /dev/fb0
+ * Most important: boot logo :-)
+
+Disadvantages:
+
+ * Driver is largely untested on non-Dreamcast systems.
+
+Configuration
+=============
+
+You can pass kernel command line options to pvr2fb with
+`video=pvr2fb:option1,option2:value2,option3` (multiple options should be
+separated by comma, values are separated from options by `:`).
+
+Accepted options:
+
+==========  ==================================================================
+font:X      default font to use. All fonts are supported, including the
+	    SUN12x22 font which is very nice at high resolutions.
+
+
+mode:X      default video mode with format [xres]x[yres]-<bpp>@<refresh rate>
+	    The following video modes are supported:
+	    640x640-16@60, 640x480-24@60, 640x480-32@60. The Dreamcast
+	    defaults to 640x480-16@60. At the time of writing the
+	    24bpp and 32bpp modes function poorly. Work to fix that is
+	    ongoing
+
+	    Note: the 640x240 mode is currently broken, and should not be
+	    used for any reason. It is only mentioned here as a reference.
+
+inverse     invert colors on screen (for LCD displays)
+
+nomtrr      disables write combining on frame buffer. This slows down driver
+	    but there is reported minor incompatibility between GUS DMA and
+	    XFree under high loads if write combining is enabled (sound
+	    dropouts). MTRR is enabled by default on systems that have it
+	    configured and that support it.
+
+cable:X     cable type. This can be any of the following: vga, rgb, and
+	    composite. If none is specified, we guess.
+
+output:X    output type. This can be any of the following: pal, ntsc, and
+	    vga. If none is specified, we guess.
+==========  ==================================================================
+
+X11
+===
+
+XF86_FBDev has been shown to work on the Dreamcast in the past - though not yet
+on any 2.6 series kernel.
+
+Paul Mundt <lethal@linuxdc.org>
+
+Updated by Adrian McMenamin <adrian@mcmen.demon.co.uk>
diff --git a/Documentation/fb/pvr2fb.txt b/Documentation/fb/pvr2fb.txt
deleted file mode 100644
index 36bdeff585e2..000000000000
--- a/Documentation/fb/pvr2fb.txt
+++ /dev/null
@@ -1,65 +0,0 @@
-$Id: pvr2fb.txt,v 1.1 2001/05/24 05:09:16 mrbrown Exp $
-
-What is pvr2fb?
-===============
-
-This is a driver for PowerVR 2 based graphics frame buffers, such as the
-one found in the Dreamcast.
-
-Advantages:
-
- * It provides a nice large console (128 cols + 48 lines with 1024x768)
-   without using tiny, unreadable fonts (NOT on the Dreamcast)
- * You can run XF86_FBDev on top of /dev/fb0
- * Most important: boot logo :-)
-
-Disadvantages:
-
- * Driver is largely untested on non-Dreamcast systems.
-
-Configuration
-=============
-
-You can pass kernel command line options to pvr2fb with
-`video=pvr2fb:option1,option2:value2,option3' (multiple options should be
-separated by comma, values are separated from options by `:').
-Accepted options:
-
-font:X    - default font to use. All fonts are supported, including the
-            SUN12x22 font which is very nice at high resolutions.
-
-	    
-mode:X    - default video mode with format [xres]x[yres]-<bpp>@<refresh rate>
-            The following video modes are supported:
-            640x640-16@60, 640x480-24@60, 640x480-32@60. The Dreamcast
-            defaults to 640x480-16@60. At the time of writing the
-            24bpp and 32bpp modes function poorly. Work to fix that is
-            ongoing
-
-            Note: the 640x240 mode is currently broken, and should not be
-            used for any reason. It is only mentioned here as a reference.
-
-inverse   - invert colors on screen (for LCD displays)
-
-nomtrr    - disables write combining on frame buffer. This slows down driver
-            but there is reported minor incompatibility between GUS DMA and
-            XFree under high loads if write combining is enabled (sound
-            dropouts). MTRR is enabled by default on systems that have it
-            configured and that support it.
-
-cable:X   - cable type. This can be any of the following: vga, rgb, and
-            composite. If none is specified, we guess.
-
-output:X  - output type. This can be any of the following: pal, ntsc, and
-            vga. If none is specified, we guess.
-
-X11
-===
-
-XF86_FBDev has been shown to work on the Dreamcast in the past - though not yet
-on any 2.6 series kernel.
-
---
-Paul Mundt <lethal@linuxdc.org>
-Updated by Adrian McMenamin <adrian@mcmen.demon.co.uk>
-
diff --git a/Documentation/fb/pxafb.txt b/Documentation/fb/pxafb.rst
similarity index 78%
rename from Documentation/fb/pxafb.txt
rename to Documentation/fb/pxafb.rst
index d143a0a749f9..90177f5e7e76 100644
--- a/Documentation/fb/pxafb.txt
+++ b/Documentation/fb/pxafb.rst
@@ -1,59 +1,82 @@
+================================
 Driver for PXA25x LCD controller
 ================================
 
 The driver supports the following options, either via
 options=<OPTIONS> when modular or video=pxafb:<OPTIONS> when built in.
 
-For example:
+For example::
+
 	modprobe pxafb options=vmem:2M,mode:640x480-8,passive
-or on the kernel command line
+
+or on the kernel command line::
+
 	video=pxafb:vmem:2M,mode:640x480-8,passive
 
 vmem: VIDEO_MEM_SIZE
+
 	Amount of video memory to allocate (can be suffixed with K or M
 	for kilobytes or megabytes)
 
 mode:XRESxYRES[-BPP]
+
 	XRES == LCCR1_PPL + 1
+
 	YRES == LLCR2_LPP + 1
+
 		The resolution of the display in pixels
+
 	BPP == The bit depth. Valid values are 1, 2, 4, 8 and 16.
 
 pixclock:PIXCLOCK
+
 	Pixel clock in picoseconds
 
 left:LEFT == LCCR1_BLW + 1
+
 right:RIGHT == LCCR1_ELW + 1
+
 hsynclen:HSYNC == LCCR1_HSW + 1
+
 upper:UPPER == LCCR2_BFW
+
 lower:LOWER == LCCR2_EFR
+
 vsynclen:VSYNC == LCCR2_VSW + 1
+
 	Display margins and sync times
 
 color | mono => LCCR0_CMS
+
 	umm...
 
 active | passive => LCCR0_PAS
+
 	Active (TFT) or Passive (STN) display
 
 single | dual => LCCR0_SDS
+
 	Single or dual panel passive display
 
 4pix | 8pix => LCCR0_DPD
+
 	4 or 8 pixel monochrome single panel data
 
-hsync:HSYNC
-vsync:VSYNC
+hsync:HSYNC, vsync:VSYNC
+
 	Horizontal and vertical sync. 0 => active low, 1 => active
 	high.
 
 dpc:DPC
+
 	Double pixel clock. 1=>true, 0=>false
 
 outputen:POLARITY
+
 	Output Enable Polarity. 0 => active low, 1 => active high
 
 pixclockpol:POLARITY
+
 	pixel clock polarity
 	0 => falling edge, 1 => rising edge
 
@@ -76,44 +99,50 @@ Overlay Support for PXA27x and later LCD controllers
      not for such purpose).
 
   2. overlay framebuffer is allocated dynamically according to specified
-     'struct fb_var_screeninfo', the amount is decided by:
+     'struct fb_var_screeninfo', the amount is decided by::
 
-        var->xres_virtual * var->yres_virtual * bpp
+	var->xres_virtual * var->yres_virtual * bpp
 
      bpp = 16 -- for RGB565 or RGBT555
-         = 24 -- for YUV444 packed
-         = 24 -- for YUV444 planar
-	 = 16 -- for YUV422 planar (1 pixel = 1 Y + 1/2 Cb + 1/2 Cr)
-	 = 12 -- for YUV420 planar (1 pixel = 1 Y + 1/4 Cb + 1/4 Cr)
+
+     bpp = 24 -- for YUV444 packed
+
+     bpp = 24 -- for YUV444 planar
+
+     bpp = 16 -- for YUV422 planar (1 pixel = 1 Y + 1/2 Cb + 1/2 Cr)
+
+     bpp = 12 -- for YUV420 planar (1 pixel = 1 Y + 1/4 Cb + 1/4 Cr)
 
      NOTE:
 
      a. overlay does not support panning in x-direction, thus
-        var->xres_virtual will always be equal to var->xres
+	var->xres_virtual will always be equal to var->xres
 
      b. line length of overlay(s) must be on a 32-bit word boundary,
-        for YUV planar modes, it is a requirement for the component
+	for YUV planar modes, it is a requirement for the component
 	with minimum bits per pixel,  e.g. for YUV420, Cr component
 	for one pixel is actually 2-bits, it means the line length
 	should be a multiple of 16-pixels
 
      c. starting horizontal position (XPOS) should start on a 32-bit
-        word boundary, otherwise the fb_check_var() will just fail.
+	word boundary, otherwise the fb_check_var() will just fail.
 
      d. the rectangle of the overlay should be within the base plane,
-        otherwise fail
+	otherwise fail
 
      Applications should follow the sequence below to operate an overlay
      framebuffer:
 
-         a. open("/dev/fb[1-2]", ...)
+	 a. open("/dev/fb[1-2]", ...)
 	 b. ioctl(fd, FBIOGET_VSCREENINFO, ...)
 	 c. modify 'var' with desired parameters:
+
 	    1) var->xres and var->yres
 	    2) larger var->yres_virtual if more memory is required,
 	       usually for double-buffering
 	    3) var->nonstd for starting (x, y) and color format
 	    4) var->{red, green, blue, transp} if RGB mode is to be used
+
 	 d. ioctl(fd, FBIOPUT_VSCREENINFO, ...)
 	 e. ioctl(fd, FBIOGET_FSCREENINFO, ...)
 	 f. mmap
@@ -124,19 +153,21 @@ Overlay Support for PXA27x and later LCD controllers
      and lengths of each component within the framebuffer.
 
   4. var->nonstd is used to pass starting (x, y) position and color format,
-     the detailed bit fields are shown below:
+     the detailed bit fields are shown below::
 
-    31                23  20         10          0
-     +-----------------+---+----------+----------+
-     |  ... unused ... |FOR|   XPOS   |   YPOS   |
-     +-----------------+---+----------+----------+
+      31                23  20         10          0
+       +-----------------+---+----------+----------+
+       |  ... unused ... |FOR|   XPOS   |   YPOS   |
+       +-----------------+---+----------+----------+
 
      FOR  - color format, as defined by OVERLAY_FORMAT_* in pxafb.h
-            0 - RGB
-	    1 - YUV444 PACKED
-	    2 - YUV444 PLANAR
-	    3 - YUV422 PLANAR
-	    4 - YUR420 PLANAR
+
+	  - 0 - RGB
+	  - 1 - YUV444 PACKED
+	  - 2 - YUV444 PLANAR
+	  - 3 - YUV422 PLANAR
+	  - 4 - YUR420 PLANAR
 
      XPOS - starting horizontal position
+
      YPOS - starting vertical position
diff --git a/Documentation/fb/s3fb.txt b/Documentation/fb/s3fb.rst
similarity index 94%
rename from Documentation/fb/s3fb.txt
rename to Documentation/fb/s3fb.rst
index 2c97770bdbaa..e809d69c21a7 100644
--- a/Documentation/fb/s3fb.txt
+++ b/Documentation/fb/s3fb.rst
@@ -1,6 +1,6 @@
-
-	s3fb - fbdev driver for S3 Trio/Virge chips
-	===========================================
+===========================================
+s3fb - fbdev driver for S3 Trio/Virge chips
+===========================================
 
 
 Supported Hardware
@@ -56,7 +56,7 @@ Missing Features
 (alias TODO list)
 
 	* secondary (not initialized by BIOS) device support
-   	* big endian support
+	* big endian support
 	* Zorro bus support
 	* MMIO support
 	* 24 bpp mode support on more cards
diff --git a/Documentation/fb/sa1100fb.txt b/Documentation/fb/sa1100fb.rst
similarity index 64%
rename from Documentation/fb/sa1100fb.txt
rename to Documentation/fb/sa1100fb.rst
index f1b4220464df..67e2650e017d 100644
--- a/Documentation/fb/sa1100fb.txt
+++ b/Documentation/fb/sa1100fb.rst
@@ -1,17 +1,19 @@
-[This file is cloned from VesaFB/matroxfb]
-
+=================
 What is sa1100fb?
 =================
 
+.. [This file is cloned from VesaFB/matroxfb]
+
+
 This is a driver for a graphic framebuffer for the SA-1100 LCD
 controller.
 
 Configuration
 ==============
 
-For most common passive displays, giving the option
+For most common passive displays, giving the option::
 
-video=sa1100fb:bpp:<value>,lccr0:<value>,lccr1:<value>,lccr2:<value>,lccr3:<value>
+  video=sa1100fb:bpp:<value>,lccr0:<value>,lccr1:<value>,lccr2:<value>,lccr3:<value>
 
 on the kernel command line should be enough to configure the
 controller. The bits per pixel (bpp) value should be 4, 8, 12, or
@@ -27,13 +29,12 @@ sa1100fb_init_fbinfo(), sa1100fb_activate_var(),
 sa1100fb_disable_lcd_controller(), and sa1100fb_enable_lcd_controller()
 will probably be necessary.
 
-Accepted options:
+Accepted options::
 
-bpp:<value>	Configure for <value> bits per pixel
-lccr0:<value>	Configure LCD control register 0 (11.7.3)
-lccr1:<value>	Configure LCD control register 1 (11.7.4)
-lccr2:<value>	Configure LCD control register 2 (11.7.5)
-lccr3:<value>	Configure LCD control register 3 (11.7.6)
+	bpp:<value>	Configure for <value> bits per pixel
+	lccr0:<value>	Configure LCD control register 0 (11.7.3)
+	lccr1:<value>	Configure LCD control register 1 (11.7.4)
+	lccr2:<value>	Configure LCD control register 2 (11.7.5)
+	lccr3:<value>	Configure LCD control register 3 (11.7.6)
 
---
 Mark Huang <mhuang@livetoy.com>
diff --git a/Documentation/fb/sh7760fb.rst b/Documentation/fb/sh7760fb.rst
new file mode 100644
index 000000000000..c3266485f810
--- /dev/null
+++ b/Documentation/fb/sh7760fb.rst
@@ -0,0 +1,130 @@
+================================================
+SH7760/SH7763 integrated LCDC Framebuffer driver
+================================================
+
+0. Overview
+-----------
+The SH7760/SH7763 have an integrated LCD Display controller (LCDC) which
+supports (in theory) resolutions ranging from 1x1 to 1024x1024,
+with color depths ranging from 1 to 16 bits, on STN, DSTN and TFT Panels.
+
+Caveats:
+
+* Framebuffer memory must be a large chunk allocated at the top
+  of Area3 (HW requirement). Because of this requirement you should NOT
+  make the driver a module since at runtime it may become impossible to
+  get a large enough contiguous chunk of memory.
+
+* The driver does not support changing resolution while loaded
+  (displays aren't hotpluggable anyway)
+
+* Heavy flickering may be observed
+  a) if you're using 15/16bit color modes at >= 640x480 px resolutions,
+  b) during PCMCIA (or any other slow bus) activity.
+
+* Rotation works only 90degress clockwise, and only if horizontal
+  resolution is <= 320 pixels.
+
+Files:
+	- drivers/video/sh7760fb.c
+	- include/asm-sh/sh7760fb.h
+	- Documentation/fb/sh7760fb.rst
+
+1. Platform setup
+-----------------
+SH7760:
+ Video data is fetched via the DMABRG DMA engine, so you have to
+ configure the SH DMAC for DMABRG mode (write 0x94808080 to the
+ DMARSRA register somewhere at boot).
+
+ PFC registers PCCR and PCDR must be set to peripheral mode.
+ (write zeros to both).
+
+The driver does NOT do the above for you since board setup is, well, job
+of the board setup code.
+
+2. Panel definitions
+--------------------
+The LCDC must explicitly be told about the type of LCD panel
+attached.  Data must be wrapped in a "struct sh7760fb_platdata" and
+passed to the driver as platform_data.
+
+Suggest you take a closer look at the SH7760 Manual, Section 30.
+(http://documentation.renesas.com/eng/products/mpumcu/e602291_sh7760.pdf)
+
+The following code illustrates what needs to be done to
+get the framebuffer working on a 640x480 TFT::
+
+  #include <linux/fb.h>
+  #include <asm/sh7760fb.h>
+
+  /*
+   * NEC NL6440bc26-01 640x480 TFT
+   * dotclock 25175 kHz
+   * Xres                640     Yres            480
+   * Htotal      800     Vtotal          525
+   * HsynStart   656     VsynStart       490
+   * HsynLenn    30      VsynLenn        2
+   *
+   * The linux framebuffer layer does not use the syncstart/synclen
+   * values but right/left/upper/lower margin values. The comments
+   * for the x_margin explain how to calculate those from given
+   * panel sync timings.
+   */
+  static struct fb_videomode nl6448bc26 = {
+         .name           = "NL6448BC26",
+         .refresh        = 60,
+         .xres           = 640,
+         .yres           = 480,
+         .pixclock       = 39683,        /* in picoseconds! */
+         .hsync_len      = 30,
+         .vsync_len      = 2,
+         .left_margin    = 114,  /* HTOT - (HSYNSLEN + HSYNSTART) */
+         .right_margin   = 16,   /* HSYNSTART - XRES */
+         .upper_margin   = 33,   /* VTOT - (VSYNLEN + VSYNSTART) */
+         .lower_margin   = 10,   /* VSYNSTART - YRES */
+         .sync           = FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+         .vmode          = FB_VMODE_NONINTERLACED,
+         .flag           = 0,
+  };
+
+  static struct sh7760fb_platdata sh7760fb_nl6448 = {
+         .def_mode       = &nl6448bc26,
+         .ldmtr          = LDMTR_TFT_COLOR_16,   /* 16bit TFT panel */
+         .lddfr          = LDDFR_8BPP,           /* we want 8bit output */
+         .ldpmmr         = 0x0070,
+         .ldpspr         = 0x0500,
+         .ldaclnr        = 0,
+         .ldickr         = LDICKR_CLKSRC(LCDC_CLKSRC_EXTERNAL) |
+			 LDICKR_CLKDIV(1),
+         .rotate         = 0,
+         .novsync        = 1,
+         .blank          = NULL,
+  };
+
+  /* SH7760:
+   * 0xFE300800: 256 * 4byte xRGB palette ram
+   * 0xFE300C00: 42 bytes ctrl registers
+   */
+  static struct resource sh7760_lcdc_res[] = {
+         [0] = {
+	       .start  = 0xFE300800,
+	       .end    = 0xFE300CFF,
+	       .flags  = IORESOURCE_MEM,
+         },
+         [1] = {
+	       .start  = 65,
+	       .end    = 65,
+	       .flags  = IORESOURCE_IRQ,
+         },
+  };
+
+  static struct platform_device sh7760_lcdc_dev = {
+         .dev    = {
+	       .platform_data = &sh7760fb_nl6448,
+         },
+         .name           = "sh7760-lcdc",
+         .id             = -1,
+         .resource       = sh7760_lcdc_res,
+         .num_resources  = ARRAY_SIZE(sh7760_lcdc_res),
+  };
diff --git a/Documentation/fb/sh7760fb.txt b/Documentation/fb/sh7760fb.txt
deleted file mode 100644
index b994c3b10549..000000000000
--- a/Documentation/fb/sh7760fb.txt
+++ /dev/null
@@ -1,131 +0,0 @@
-SH7760/SH7763 integrated LCDC Framebuffer driver
-================================================
-
-0. Overview
------------
-The SH7760/SH7763 have an integrated LCD Display controller (LCDC) which
-supports (in theory) resolutions ranging from 1x1 to 1024x1024,
-with color depths ranging from 1 to 16 bits, on STN, DSTN and TFT Panels.
-
-Caveats:
-* Framebuffer memory must be a large chunk allocated at the top
-  of Area3 (HW requirement). Because of this requirement you should NOT
-  make the driver a module since at runtime it may become impossible to
-  get a large enough contiguous chunk of memory.
-
-* The driver does not support changing resolution while loaded
-  (displays aren't hotpluggable anyway)
-
-* Heavy flickering may be observed
-  a) if you're using 15/16bit color modes at >= 640x480 px resolutions,
-  b) during PCMCIA (or any other slow bus) activity.
-
-* Rotation works only 90degress clockwise, and only if horizontal
-  resolution is <= 320 pixels.
-
-files:   drivers/video/sh7760fb.c
-        include/asm-sh/sh7760fb.h
-        Documentation/fb/sh7760fb.txt
-
-1. Platform setup
------------------
-SH7760:
- Video data is fetched via the DMABRG DMA engine, so you have to
- configure the SH DMAC for DMABRG mode (write 0x94808080 to the
- DMARSRA register somewhere at boot).
-
- PFC registers PCCR and PCDR must be set to peripheral mode.
- (write zeros to both).
-
-The driver does NOT do the above for you since board setup is, well, job
-of the board setup code.
-
-2. Panel definitions
---------------------
-The LCDC must explicitly be told about the type of LCD panel
-attached.  Data must be wrapped in a "struct sh7760fb_platdata" and
-passed to the driver as platform_data.
-
-Suggest you take a closer look at the SH7760 Manual, Section 30.
-(http://documentation.renesas.com/eng/products/mpumcu/e602291_sh7760.pdf)
-
-The following code illustrates what needs to be done to
-get the framebuffer working on a 640x480 TFT:
-
-====================== cut here ======================================
-
-#include <linux/fb.h>
-#include <asm/sh7760fb.h>
-
-/*
- * NEC NL6440bc26-01 640x480 TFT
- * dotclock 25175 kHz
- * Xres                640     Yres            480
- * Htotal      800     Vtotal          525
- * HsynStart   656     VsynStart       490
- * HsynLenn    30      VsynLenn        2
- *
- * The linux framebuffer layer does not use the syncstart/synclen
- * values but right/left/upper/lower margin values. The comments
- * for the x_margin explain how to calculate those from given
- * panel sync timings.
- */
-static struct fb_videomode nl6448bc26 = {
-       .name           = "NL6448BC26",
-       .refresh        = 60,
-       .xres           = 640,
-       .yres           = 480,
-       .pixclock       = 39683,        /* in picoseconds! */
-       .hsync_len      = 30,
-       .vsync_len      = 2,
-       .left_margin    = 114,  /* HTOT - (HSYNSLEN + HSYNSTART) */
-       .right_margin   = 16,   /* HSYNSTART - XRES */
-       .upper_margin   = 33,   /* VTOT - (VSYNLEN + VSYNSTART) */
-       .lower_margin   = 10,   /* VSYNSTART - YRES */
-       .sync           = FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
-       .vmode          = FB_VMODE_NONINTERLACED,
-       .flag           = 0,
-};
-
-static struct sh7760fb_platdata sh7760fb_nl6448 = {
-       .def_mode       = &nl6448bc26,
-       .ldmtr          = LDMTR_TFT_COLOR_16,   /* 16bit TFT panel */
-       .lddfr          = LDDFR_8BPP,           /* we want 8bit output */
-       .ldpmmr         = 0x0070,
-       .ldpspr         = 0x0500,
-       .ldaclnr        = 0,
-       .ldickr         = LDICKR_CLKSRC(LCDC_CLKSRC_EXTERNAL) |
-                         LDICKR_CLKDIV(1),
-       .rotate         = 0,
-       .novsync        = 1,
-       .blank          = NULL,
-};
-
-/* SH7760:
- * 0xFE300800: 256 * 4byte xRGB palette ram
- * 0xFE300C00: 42 bytes ctrl registers
- */
-static struct resource sh7760_lcdc_res[] = {
-       [0] = {
-               .start  = 0xFE300800,
-               .end    = 0xFE300CFF,
-               .flags  = IORESOURCE_MEM,
-       },
-       [1] = {
-               .start  = 65,
-               .end    = 65,
-               .flags  = IORESOURCE_IRQ,
-       },
-};
-
-static struct platform_device sh7760_lcdc_dev = {
-       .dev    = {
-               .platform_data = &sh7760fb_nl6448,
-       },
-       .name           = "sh7760-lcdc",
-       .id             = -1,
-       .resource       = sh7760_lcdc_res,
-       .num_resources  = ARRAY_SIZE(sh7760_lcdc_res),
-};
-
-====================== cut here ======================================
diff --git a/Documentation/fb/sisfb.txt b/Documentation/fb/sisfb.rst
similarity index 85%
rename from Documentation/fb/sisfb.txt
rename to Documentation/fb/sisfb.rst
index 2e68e503e72f..8f4e502ea12e 100644
--- a/Documentation/fb/sisfb.txt
+++ b/Documentation/fb/sisfb.rst
@@ -1,4 +1,4 @@
-
+==============
 What is sisfb?
 ==============
 
@@ -41,11 +41,11 @@ statement to add the parameters to the kernel command line. Please see lilo's
 parameters are given with the modprobe (or insmod) command.
 
 Example for sisfb as part of the static kernel: Add the following line to your
-lilo.conf:
+lilo.conf::
 
      append="video=sisfb:mode:1024x768x16,mem:12288,rate:75"
 
-Example for sisfb as a module: Start sisfb by typing
+Example for sisfb as a module: Start sisfb by typing::
 
      modprobe sisfb mode=1024x768x16 rate=75 mem=12288
 
@@ -57,7 +57,7 @@ described above or the vesa keyword instead of mode). If compiled as a module,
 the parameter format reads mode=none or mode=1024x768x16 (or whatever mode you
 want to use). Using a "=" for a ":" (and vice versa) is a huge difference!
 Additionally: If you give more than one argument to the in-kernel sisfb, the
-arguments are separated with ",". For example:
+arguments are separated with ",". For example::
 
    video=sisfb:mode:1024x768x16,rate:75,mem:12288
 
@@ -73,6 +73,7 @@ supported options including some explanation.
 
 The desired display mode can be specified using the keyword "mode" with
 a parameter in one of the following formats:
+
   - XxYxDepth or
   - XxY-Depth or
   - XxY-Depth@Rate or
@@ -130,29 +131,30 @@ Configuration
 
 (Some) accepted options:
 
-off      - Disable sisfb. This option is only understood if sisfb is
-           in-kernel, not a module.
-mem:X    - size of memory for the console, rest will be used for DRI/DRM. X
-           is in kilobytes. On 300 series, the default is 4096, 8192 or
+=========  ==================================================================
+off        Disable sisfb. This option is only understood if sisfb is
+	   in-kernel, not a module.
+mem:X      size of memory for the console, rest will be used for DRI/DRM. X
+	   is in kilobytes. On 300 series, the default is 4096, 8192 or
 	   16384 (each in kilobyte) depending on how much video ram the card
-           has. On 315/330 series, the default is the maximum available ram
+	   has. On 315/330 series, the default is the maximum available ram
 	   (since DRI/DRM is not supported for these chipsets).
-noaccel  - do not use 2D acceleration engine. (Default: use acceleration)
-noypan   - disable y-panning and scroll by redrawing the entire screen.
-           This is much slower than y-panning. (Default: use y-panning)
-vesa:X   - selects startup videomode. X is number from 0 to 0x1FF and
-           represents the VESA mode number (can be given in decimal or
+noaccel    do not use 2D acceleration engine. (Default: use acceleration)
+noypan     disable y-panning and scroll by redrawing the entire screen.
+	   This is much slower than y-panning. (Default: use y-panning)
+vesa:X     selects startup videomode. X is number from 0 to 0x1FF and
+	   represents the VESA mode number (can be given in decimal or
 	   hexadecimal form, the latter prefixed with "0x").
-mode:X   - selects startup videomode. Please see above for the format of
-           "X".
+mode:X     selects startup videomode. Please see above for the format of
+	   "X".
+=========  ==================================================================
 
 Boolean options such as "noaccel" or "noypan" are to be given without a
 parameter if sisfb is in-kernel (for example "video=sisfb:noypan). If
 sisfb is a module, these are to be set to 1 (for example "modprobe sisfb
 noypan=1").
 
---
+
 Thomas Winischhofer <thomas@winischhofer.net>
+
 May 27, 2004
-
-
diff --git a/Documentation/fb/sm501.txt b/Documentation/fb/sm501.rst
similarity index 65%
rename from Documentation/fb/sm501.txt
rename to Documentation/fb/sm501.rst
index 187f3b3ccb6c..03e02c8042a7 100644
--- a/Documentation/fb/sm501.txt
+++ b/Documentation/fb/sm501.rst
@@ -1,6 +1,11 @@
+=======
+sm501fb
+=======
+
 Configuration:
 
-You can pass the following kernel command line options to sm501 videoframebuffer:
+You can pass the following kernel command line options to sm501
+videoframebuffer::
 
 	sm501fb.bpp=	SM501 Display driver:
 			Specify bits-per-pixel if not specified by 'mode'
diff --git a/Documentation/fb/sm712fb.txt b/Documentation/fb/sm712fb.rst
similarity index 59%
rename from Documentation/fb/sm712fb.txt
rename to Documentation/fb/sm712fb.rst
index c388442edf51..994dad3b0238 100644
--- a/Documentation/fb/sm712fb.txt
+++ b/Documentation/fb/sm712fb.rst
@@ -1,5 +1,6 @@
+================
 What is sm712fb?
-=================
+================
 
 This is a graphics framebuffer driver for Silicon Motion SM712 based processors.
 
@@ -15,13 +16,16 @@ You should not compile-in vesafb.
 
 Currently supported video modes are:
 
-[Graphic modes]
+Graphic modes
+-------------
 
-bpp | 640x480  800x600  1024x768  1280x1024
-----+--------------------------------------------
-  8 | 0x301    0x303    0x305    0x307
- 16 | 0x311    0x314    0x317    0x31A
- 24 | 0x312    0x315    0x318    0x31B
+===  =======  =======  ========  =========
+bpp  640x480  800x600  1024x768  1280x1024
+===  =======  =======  ========  =========
+  8  0x301    0x303    0x305     0x307
+ 16  0x311    0x314    0x317     0x31A
+ 24  0x312    0x315    0x318     0x31B
+===  =======  =======  ========  =========
 
 Missing Features
 ================
diff --git a/Documentation/fb/sstfb.rst b/Documentation/fb/sstfb.rst
new file mode 100644
index 000000000000..8e8c1b940359
--- /dev/null
+++ b/Documentation/fb/sstfb.rst
@@ -0,0 +1,207 @@
+=====
+sstfb
+=====
+
+Introduction
+============
+
+This is a frame buffer device driver for 3dfx' Voodoo Graphics
+(aka voodoo 1, aka sst1) and Voodoo² (aka Voodoo 2, aka CVG) based
+video boards. It's highly experimental code, but is guaranteed to work
+on my computer, with my "Maxi Gamer 3D" and "Maxi Gamer 3d²" boards,
+and with me "between chair and keyboard". Some people tested other
+combinations and it seems that it works.
+The main page is located at <http://sstfb.sourceforge.net>, and if
+you want the latest version, check out the CVS, as the driver is a work
+in progress, I feel uncomfortable with releasing tarballs of something
+not completely working...Don't worry, it's still more than usable
+(I eat my own dog food)
+
+Please read the Bug section, and report any success or failure to me
+(Ghozlane Toumi <gtoumi@laposte.net>).
+BTW, If you have only one monitor , and you don't feel like playing
+with the vga passthrou cable, I can only suggest borrowing a screen
+somewhere...
+
+
+Installation
+============
+
+This driver (should) work on ix86, with "late" 2.2.x kernel (tested
+with x = 19) and "recent" 2.4.x kernel, as a module or compiled in.
+It has been included in mainstream kernel since the infamous 2.4.10.
+You can apply the patches found in `sstfb/kernel/*-2.{2|4}.x.patch`,
+and copy sstfb.c to linux/drivers/video/, or apply a single patch,
+`sstfb/patch-2.{2|4}.x-sstfb-yymmdd` to your linux source tree.
+
+Then configure your kernel as usual: choose "m" or "y" to 3Dfx Voodoo
+Graphics in section "console". Compile, install, have fun... and please
+drop me a report :)
+
+
+Module Usage
+============
+
+.. warning::
+
+       #. You should read completely this section before issuing any command.
+
+       #. If you have only one monitor to play with, once you insmod the
+	  module, the 3dfx takes control of the output, so you'll have to
+	  plug the monitor to the "normal" video board in order to issue
+	  the commands, or you can blindly use sst_dbg_vgapass
+	  in the tools directory (See Tools). The latest solution is pass the
+	  parameter vgapass=1 when insmodding the driver. (See Kernel/Modules
+	  Options)
+
+Module insertion
+----------------
+
+       #. insmod sstfb.o
+
+	  you should see some strange output from the board:
+	  a big blue square, a green and a red small squares and a vertical
+	  white rectangle. why? the function's name is self-explanatory:
+	  "sstfb_test()"...
+	  (if you don't have a second monitor, you'll have to plug your monitor
+	  directly to the 2D videocard to see what you're typing)
+
+       #. con2fb /dev/fbx /dev/ttyx
+
+	  bind a tty to the new frame buffer. if you already have a frame
+	  buffer driver, the voodoo fb will likely be /dev/fb1. if not,
+	  the device will be /dev/fb0. You can check this by doing a
+	  cat /proc/fb. You can find a copy of con2fb in tools/ directory.
+	  if you don't have another fb device, this step is superfluous,
+	  as the console subsystem automagicaly binds ttys to the fb.
+       #. switch to the virtual console you just mapped. "tadaaa" ...
+
+Module removal
+--------------
+
+       #. con2fb /dev/fbx /dev/ttyx
+
+	  bind the tty to the old frame buffer so the module can be removed.
+	  (how does it work with vgacon ? short answer : it doesn't work)
+
+       #. rmmod sstfb
+
+
+Kernel/Modules Options
+----------------------
+
+You can pass some options to the sstfb module, and via the kernel
+command line when the driver is compiled in:
+for module : insmod sstfb.o option1=value1 option2=value2 ...
+in kernel :  video=sstfb:option1,option2:value2,option3 ...
+
+sstfb supports the following options:
+
+=============== =============== ===============================================
+Module		Kernel		Description
+=============== =============== ===============================================
+vgapass=0	vganopass	Enable or disable VGA passthrou cable.
+vgapass=1	vgapass		When enabled, the monitor will get the signal
+				from the VGA board and not from the voodoo.
+
+				Default: nopass
+
+mem=x		mem:x		Force frame buffer memory in MiB
+				allowed values: 0, 1, 2, 4.
+
+				Default: 0 (= autodetect)
+
+inverse=1	inverse		Supposed to enable inverse console.
+				doesn't work yet...
+
+clipping=1	clipping	Enable or disable clipping.
+clipping=0	noclipping	With clipping enabled, all offscreen
+				reads and writes are discarded.
+
+				Default: enable clipping.
+
+gfxclk=x	gfxclk:x	Force graphic clock frequency (in MHz).
+				Be careful with this option, it may be
+				DANGEROUS.
+
+				Default: auto
+
+					- 50Mhz for Voodoo 1,
+					- 75MHz for Voodoo 2.
+
+slowpci=1	fastpci		Enable or disable fast PCI read/writes.
+slowpci=1	slowpci		Default : fastpci
+
+dev=x		dev:x		Attach the driver to device number x.
+				0 is the first compatible board (in
+				lspci order)
+=============== =============== ===============================================
+
+Tools
+=====
+
+These tools are mostly for debugging purposes, but you can
+find some of these interesting:
+
+- `con2fb`, maps a tty to a fbramebuffer::
+
+	con2fb /dev/fb1 /dev/tty5
+
+- `sst_dbg_vgapass`, changes vga passthrou. You have to recompile the
+  driver with SST_DEBUG and SST_DEBUG_IOCTL set to 1::
+
+	sst_dbg_vgapass /dev/fb1 1 (enables vga cable)
+	sst_dbg_vgapass /dev/fb1 0 (disables vga cable)
+
+- `glide_reset`, resets the voodoo using glide
+  use this after rmmoding sstfb, if the module refuses to
+  reinsert.
+
+Bugs
+====
+
+- DO NOT use glide while the sstfb module is in, you'll most likely
+  hang your computer.
+- If you see some artefacts (pixels not cleaning and stuff like that),
+  try turning off clipping (clipping=0), and/or using slowpci
+- the driver don't detect the 4Mb frame buffer voodoos, it seems that
+  the 2 last Mbs wrap around. looking into that .
+- The driver is 16 bpp only, 24/32 won't work.
+- The driver is not your_favorite_toy-safe. this includes SMP...
+
+	[Actually from inspection it seems to be safe - Alan]
+
+- When using XFree86 FBdev (X over fbdev) you may see strange color
+  patterns at the border of your windows (the pixels lose the lowest
+  byte -> basically the blue component and some of the green). I'm unable
+  to reproduce this with XFree86-3.3, but one of the testers has this
+  problem with XFree86-4. Apparently recent Xfree86-4.x solve this
+  problem.
+- I didn't really test changing the palette, so you may find some weird
+  things when playing with that.
+- Sometimes the driver will not recognise the DAC, and the
+  initialisation will fail. This is specifically true for
+  voodoo 2 boards, but it should be solved in recent versions. Please
+  contact me.
+- The 24/32 is not likely to work anytime soon, knowing that the
+  hardware does ... unusual things in 24/32 bpp.
+- When used with another video board, current limitations of the linux
+  console subsystem can cause some troubles, specifically, you should
+  disable software scrollback, as it can oops badly ...
+
+Todo
+====
+
+- Get rid of the previous paragraph.
+- Buy more coffee.
+- test/port to other arch.
+- try to add panning using tweeks with front and back buffer .
+- try to implement accel on voodoo2, this board can actually do a
+  lot in 2D even if it was sold as a 3D only board ...
+
+Ghozlane Toumi <gtoumi@laposte.net>
+
+
+Date: 2002/05/09 20:11:45
+
+http://sstfb.sourceforge.net/README
diff --git a/Documentation/fb/sstfb.txt b/Documentation/fb/sstfb.txt
deleted file mode 100644
index 13db1075e4a5..000000000000
--- a/Documentation/fb/sstfb.txt
+++ /dev/null
@@ -1,174 +0,0 @@
-
-Introduction
-
-	  This is a frame buffer device driver for 3dfx' Voodoo Graphics 
-	(aka voodoo 1, aka sst1) and Voodoo² (aka Voodoo 2, aka CVG) based 
-	video boards. It's highly experimental code, but is guaranteed to work
-	on my computer, with my "Maxi Gamer 3D" and "Maxi Gamer 3d²" boards,
-	and with me "between chair and keyboard". Some people tested other
-	combinations and it seems that it works.
-	  The main page is located at <http://sstfb.sourceforge.net>, and if
-	you want the latest version, check out the CVS, as the driver is a work
-	in progress, I feel uncomfortable with releasing tarballs of something
-	not completely working...Don't worry, it's still more than usable
-	(I eat my own dog food)
-
-	  Please read the Bug section, and report any success or failure to me
-	(Ghozlane Toumi <gtoumi@laposte.net>).
-	  BTW, If you have only one monitor , and you don't feel like playing
-	with the vga passthrou cable, I can only suggest borrowing a screen
-	somewhere... 
-
-
-Installation 
-
-	  This driver (should) work on ix86, with "late" 2.2.x kernel (tested
-	with x = 19) and "recent" 2.4.x kernel, as a module or compiled in.
-	  It has been included in mainstream kernel since the infamous 2.4.10.
-	  You can apply the patches found in sstfb/kernel/*-2.{2|4}.x.patch,
-	and copy sstfb.c to linux/drivers/video/, or apply a single patch, 
-	sstfb/patch-2.{2|4}.x-sstfb-yymmdd to your linux source tree.
-
-	  Then configure your kernel as usual: choose "m" or "y" to 3Dfx Voodoo
-	Graphics in section "console". Compile, install, have fun... and please
-	drop me a report :)
-
-
-Module Usage
-	
-	Warnings.
-	# You should read completely this section before issuing any command.
-	# If you have only one monitor to play with, once you insmod the
-	  module, the 3dfx takes control of the output, so you'll have to
-	  plug the monitor to the "normal" video board in order to issue
-	  the commands, or you can blindly use sst_dbg_vgapass
-          in the tools directory (See Tools). The latest solution is pass the
-	  parameter vgapass=1 when insmodding the driver. (See Kernel/Modules
-	  Options)
-
-	Module insertion:
-	# insmod sstfb.o
-	  you should see some strange output from the board: 
-	  a big blue square, a green and a red small squares and a vertical
-	  white rectangle. why? the function's name is self-explanatory:
-	  "sstfb_test()"...
-	  (if you don't have a second monitor, you'll have to plug your monitor
-	  directly to the 2D videocard to see what you're typing)
-	# con2fb /dev/fbx /dev/ttyx
-	  bind a tty to the new frame buffer. if you already have a frame
-	  buffer driver, the voodoo fb will likely be /dev/fb1. if not, 
-	  the device will be /dev/fb0. You can check this by doing a 
-	  cat /proc/fb. You can find a copy of con2fb in tools/ directory.
-	  if you don't have another fb device, this step is superfluous,
-	  as the console subsystem automagicaly binds ttys to the fb.
-	# switch to the virtual console you just mapped. "tadaaa" ...
-
-	Module removal:
-	# con2fb /dev/fbx /dev/ttyx
-	  bind the tty to the old frame buffer so the module can be removed.
-	  (how does it work with vgacon ? short answer : it doesn't work)
-	# rmmod sstfb
-
-
-Kernel/Modules Options
-
-	You can pass some options to the sstfb module, and via the kernel 
-	command line when the driver is compiled in:
-	for module : insmod sstfb.o option1=value1 option2=value2 ...
-	in kernel :  video=sstfb:option1,option2:value2,option3 ...
-	
-	sstfb supports the following options :
-
-Module		Kernel		Description
-
-vgapass=0	vganopass	Enable or disable VGA passthrou cable.
-vgapass=1	vgapass		When enabled, the monitor will get the signal
-				from the VGA board and not from the voodoo.
-				Default: nopass
-
-mem=x		mem:x		Force frame buffer memory in MiB
-				allowed values: 0, 1, 2, 4.
-				Default: 0 (= autodetect)
-
-inverse=1	inverse		Supposed to enable inverse console.
-				doesn't work yet...
-
-clipping=1	clipping	Enable or disable clipping.
-clipping=0	noclipping	With clipping enabled, all offscreen
-				reads and writes are discarded.
-				Default: enable clipping.
-
-gfxclk=x	gfxclk:x	Force graphic clock frequency (in MHz).
-				Be careful with this option, it may be
-				DANGEROUS.
-				Default: auto 
-					50Mhz for Voodoo 1,
-					75MHz for Voodoo 2. 
-
-slowpci=1	fastpci		Enable or disable fast PCI read/writes.
-slowpci=1	slowpci		Default : fastpci
-
-dev=x		dev:x		Attach the driver to device number x.
-				0 is the first compatible board (in 
-				lspci order)
-
-Tools
-
-	These tools are mostly for debugging purposes, but you can 
-	find some of these interesting :
-	 - con2fb , maps a tty to a fbramebuffer .
-		con2fb /dev/fb1 /dev/tty5
-	 - sst_dbg_vgapass , changes vga passthrou. You have to recompile the
-	driver with SST_DEBUG and SST_DEBUG_IOCTL set to 1
-		sst_dbg_vgapass /dev/fb1 1 (enables vga cable)
-		sst_dbg_vgapass /dev/fb1 0 (disables vga cable)
-	 - glide_reset , resets the voodoo using glide
-		use this after rmmoding sstfb, if the module refuses to
-		reinsert .
-
-Bugs
-
-	- DO NOT use glide while the sstfb module is in, you'll most likely
-	hang your computer.
-	- If you see some artefacts (pixels not cleaning and stuff like that), 
-	try turning off clipping (clipping=0), and/or using slowpci
-	- the driver don't detect the 4Mb frame buffer voodoos, it seems that
-	the 2 last Mbs wrap around. looking into that .
-	- The driver is 16 bpp only, 24/32 won't work.
-	- The driver is not your_favorite_toy-safe. this includes SMP...
-          [Actually from inspection it seems to be safe - Alan]
-	- When using XFree86 FBdev (X over fbdev) you may see strange color
-	patterns at the border of your windows (the pixels lose the lowest
-	byte -> basically the blue component and some of the green). I'm unable
-	to reproduce this with XFree86-3.3, but one of the testers has this
-	problem with XFree86-4. Apparently recent Xfree86-4.x solve this
-	problem.
-	- I didn't really test changing the palette, so you may find some weird
-	things when playing with that.
-	- Sometimes the driver will not recognise the DAC, and the
-        initialisation will fail. This is specifically true for
-	voodoo 2 boards, but it should be solved in recent versions. Please
-	contact me.
-	- The 24/32 is not likely to work anytime soon, knowing that the
-	hardware does ... unusual things in 24/32 bpp.
-	- When used with another video board, current limitations of the linux
-	console subsystem can cause some troubles, specifically, you should
-	disable software scrollback, as it can oops badly ...
-
-Todo
-
-	- Get rid of the previous paragraph.
-	- Buy more coffee.
-	- test/port to other arch.
-	- try to add panning using tweeks with front and back buffer .
-	- try to implement accel on voodoo2, this board can actually do a 
-	  lot in 2D even if it was sold as a 3D only board ...
-
-ghoz.
-
--- 
-Ghozlane Toumi <gtoumi@laposte.net>
-
-
-$Date: 2002/05/09 20:11:45 $
-http://sstfb.sourceforge.net/README
diff --git a/Documentation/fb/tgafb.txt b/Documentation/fb/tgafb.rst
similarity index 71%
rename from Documentation/fb/tgafb.txt
rename to Documentation/fb/tgafb.rst
index 250083ada8fb..0c50d2134aa4 100644
--- a/Documentation/fb/tgafb.txt
+++ b/Documentation/fb/tgafb.rst
@@ -1,15 +1,14 @@
-$Id: tgafb.txt,v 1.1.2.2 2000/04/04 06:50:18 mato Exp $
-
+==============
 What is tgafb?
-===============
+==============
 
 This is a driver for DECChip 21030 based graphics framebuffers, a.k.a. TGA
 cards, which are usually found in older Digital Alpha systems. The
 following models are supported:
 
-ZLxP-E1 (8bpp, 2 MB VRAM)
-ZLxP-E2 (32bpp, 8 MB VRAM)
-ZLxP-E3 (32bpp, 16 MB VRAM, Zbuffer)
+- ZLxP-E1 (8bpp, 2 MB VRAM)
+- ZLxP-E2 (32bpp, 8 MB VRAM)
+- ZLxP-E3 (32bpp, 16 MB VRAM, Zbuffer)
 
 This version is an almost complete rewrite of the code written by Geert
 Uytterhoeven, which was based on the original TGA console code written by
@@ -18,7 +17,7 @@ Jay Estabrook.
 Major new features since Linux 2.0.x:
 
  * Support for multiple resolutions
- * Support for fixed-frequency and other oddball monitors 
+ * Support for fixed-frequency and other oddball monitors
    (by allowing the video mode to be set at boot time)
 
 User-visible changes since Linux 2.2.x:
@@ -36,19 +35,22 @@ Configuration
 =============
 
 You can pass kernel command line options to tgafb with
-`video=tgafb:option1,option2:value2,option3' (multiple options should be
-separated by comma, values are separated from options by `:').
+`video=tgafb:option1,option2:value2,option3` (multiple options should be
+separated by comma, values are separated from options by `:`).
+
 Accepted options:
 
-font:X    - default font to use. All fonts are supported, including the
-            SUN12x22 font which is very nice at high resolutions.
+==========  ============================================================
+font:X      default font to use. All fonts are supported, including the
+	    SUN12x22 font which is very nice at high resolutions.
 
-mode:X    - default video mode. The following video modes are supported:
-            640x480-60, 800x600-56, 640x480-72, 800x600-60, 800x600-72, 
+mode:X      default video mode. The following video modes are supported:
+	    640x480-60, 800x600-56, 640x480-72, 800x600-60, 800x600-72,
 	    1024x768-60, 1152x864-60, 1024x768-70, 1024x768-76,
 	    1152x864-70, 1280x1024-61, 1024x768-85, 1280x1024-70,
 	    1152x864-84, 1280x1024-76, 1280x1024-85
- 
+==========  ============================================================
+
 
 Known Issues
 ============
diff --git a/Documentation/fb/tridentfb.txt b/Documentation/fb/tridentfb.rst
similarity index 70%
rename from Documentation/fb/tridentfb.txt
rename to Documentation/fb/tridentfb.rst
index 45d9de5b13a3..7921c9dee78c 100644
--- a/Documentation/fb/tridentfb.txt
+++ b/Documentation/fb/tridentfb.rst
@@ -1,3 +1,7 @@
+=========
+Tridentfb
+=========
+
 Tridentfb is a framebuffer driver for some Trident chip based cards.
 
 The following list of chips is thought to be supported although not all are
@@ -17,6 +21,7 @@ limited comparing to the range if acceleration is disabled (see list
 of parameters below).
 
 Known bugs:
+
 1. The driver randomly locks up on 3DImage975 chip with acceleration
    enabled. The same happens in X11 (Xorg).
 2. The ramdac speeds require some more fine tuning. It is possible to
@@ -26,28 +31,30 @@ Known bugs:
 How to use it?
 ==============
 
-When booting you can pass the video parameter.
-video=tridentfb
+When booting you can pass the video parameter::
 
-The parameters for tridentfb are concatenated with a ':' as in this example.
+	video=tridentfb
 
-video=tridentfb:800x600-16@75,noaccel
+The parameters for tridentfb are concatenated with a ':' as in this example::
+
+	video=tridentfb:800x600-16@75,noaccel
 
 The second level parameters that tridentfb understands are:
 
-noaccel - turns off acceleration (when it doesn't work for your card)
+========  =====================================================================
+noaccel   turns off acceleration (when it doesn't work for your card)
 
-fp	- use flat panel related stuff
-crt 	- assume monitor is present instead of fp
+fp	  use flat panel related stuff
+crt 	  assume monitor is present instead of fp
 
-center 	- for flat panels and resolutions smaller than native size center the
+center 	  for flat panels and resolutions smaller than native size center the
 	  image, otherwise use
 stretch
 
-memsize - integer value in KB, use if your card's memory size is misdetected.
+memsize   integer value in KB, use if your card's memory size is misdetected.
 	  look at the driver output to see what it says when initializing.
 
-memdiff - integer value in KB, should be nonzero if your card reports
+memdiff   integer value in KB, should be nonzero if your card reports
 	  more memory than it actually has. For instance mine is 192K less than
 	  detection says in all three BIOS selectable situations 2M, 4M, 8M.
 	  Only use if your video memory is taken from main memory hence of
@@ -56,12 +63,13 @@ memdiff - integer value in KB, should be nonzero if your card reports
 	  at the bottom this might help by not letting change to that mode
 	  anymore.
 
-nativex - the width in pixels of the flat panel.If you know it (usually 1024
+nativex   the width in pixels of the flat panel.If you know it (usually 1024
 	  800 or 1280) and it is not what the driver seems to detect use it.
 
-bpp	- bits per pixel (8,16 or 32)
-mode	- a mode name like 800x600-8@75 as described in
-	  Documentation/fb/modedb.txt
+bpp	  bits per pixel (8,16 or 32)
+mode	  a mode name like 800x600-8@75 as described in
+	  Documentation/fb/modedb.rst
+========  =====================================================================
 
 Using insane values for the above parameters will probably result in driver
 misbehaviour so take care(for instance memsize=12345678 or memdiff=23784 or
diff --git a/Documentation/fb/udlfb.txt b/Documentation/fb/udlfb.rst
similarity index 77%
rename from Documentation/fb/udlfb.txt
rename to Documentation/fb/udlfb.rst
index c985cb65dd06..732b37db3504 100644
--- a/Documentation/fb/udlfb.txt
+++ b/Documentation/fb/udlfb.rst
@@ -1,6 +1,6 @@
-
+==============
 What is udlfb?
-===============
+==============
 
 This is a driver for DisplayLink USB 2.0 era graphics chips.
 
@@ -100,6 +100,7 @@ options udlfb fb_defio=0 console=1 shadow=1
 
 Accepted boolean options:
 
+=============== ================================================================
 fb_defio	Make use of the fb_defio (CONFIG_FB_DEFERRED_IO) kernel
 		module to track changed areas of the framebuffer by page faults.
 		Standard fbdev applications that use mmap but that do not
@@ -109,7 +110,7 @@ fb_defio	Make use of the fb_defio (CONFIG_FB_DEFERRED_IO) kernel
 		more stable, and higher performance.
 		default: fb_defio=1
 
-console	Allow fbcon to attach to udlfb provided framebuffers.
+console		Allow fbcon to attach to udlfb provided framebuffers.
 		Can be disabled if fbcon and other clients
 		(e.g. X with --shared-vt) are in conflict.
 		default: console=1
@@ -119,6 +120,7 @@ shadow		Allocate a 2nd framebuffer to shadow what's currently across
 		do not transmit. Spends host memory to save USB transfers.
 		Enabled by default. Only disable on very low memory systems.
 		default: shadow=1
+=============== ================================================================
 
 Sysfs Attributes
 ================
@@ -126,34 +128,35 @@ Sysfs Attributes
 Udlfb creates several files in /sys/class/graphics/fb?
 Where ? is the sequential framebuffer id of the particular DisplayLink device
 
-edid	       		If a valid EDID blob is written to this file (typically
-			by a udev rule), then udlfb will use this EDID as a
-			backup in case reading the actual EDID of the monitor
-			attached to the DisplayLink device fails. This is
-			especially useful for fixed panels, etc. that cannot
-			communicate their capabilities via EDID. Reading
-			this file returns the current EDID of the attached
-			monitor (or last backup value written). This is
-			useful to get the EDID of the attached monitor,
-			which can be passed to utilities like parse-edid.
+======================== ========================================================
+edid			 If a valid EDID blob is written to this file (typically
+			 by a udev rule), then udlfb will use this EDID as a
+			 backup in case reading the actual EDID of the monitor
+			 attached to the DisplayLink device fails. This is
+			 especially useful for fixed panels, etc. that cannot
+			 communicate their capabilities via EDID. Reading
+			 this file returns the current EDID of the attached
+			 monitor (or last backup value written). This is
+			 useful to get the EDID of the attached monitor,
+			 which can be passed to utilities like parse-edid.
 
-metrics_bytes_rendered	32-bit count of pixel bytes rendered
+metrics_bytes_rendered	 32-bit count of pixel bytes rendered
 
-metrics_bytes_identical 32-bit count of how many of those bytes were found to be
-			unchanged, based on a shadow framebuffer check
+metrics_bytes_identical  32-bit count of how many of those bytes were found to be
+			 unchanged, based on a shadow framebuffer check
 
-metrics_bytes_sent	32-bit count of how many bytes were transferred over
-			USB to communicate the resulting changed pixels to the
-			hardware. Includes compression and protocol overhead
+metrics_bytes_sent	 32-bit count of how many bytes were transferred over
+			 USB to communicate the resulting changed pixels to the
+			 hardware. Includes compression and protocol overhead
 
 metrics_cpu_kcycles_used 32-bit count of CPU cycles used in processing the
-			above pixels (in thousands of cycles).
+			 above pixels (in thousands of cycles).
 
-metrics_reset		Write-only. Any write to this file resets all metrics
-			above to zero.  Note that the 32-bit counters above
-			roll over very quickly. To get reliable results, design
-			performance tests to start and finish in a very short
-			period of time (one minute or less is safe).
+metrics_reset		 Write-only. Any write to this file resets all metrics
+			 above to zero.  Note that the 32-bit counters above
+			 roll over very quickly. To get reliable results, design
+			 performance tests to start and finish in a very short
+			 period of time (one minute or less is safe).
+======================== ========================================================
 
---
 Bernie Thompson <bernie@plugable.com>
diff --git a/Documentation/fb/uvesafb.txt b/Documentation/fb/uvesafb.rst
similarity index 52%
rename from Documentation/fb/uvesafb.txt
rename to Documentation/fb/uvesafb.rst
index aa924196c366..d1c2523fbb33 100644
--- a/Documentation/fb/uvesafb.txt
+++ b/Documentation/fb/uvesafb.rst
@@ -1,4 +1,4 @@
-
+==========================================================
 uvesafb - A Generic Driver for VBE2+ compliant video cards
 ==========================================================
 
@@ -49,7 +49,7 @@ The most important limitations are:
 
 uvesafb can be compiled either as a module, or directly into the kernel.
 In both cases it supports the same set of configuration options, which
-are either given on the kernel command line or as module parameters, e.g.:
+are either given on the kernel command line or as module parameters, e.g.::
 
  video=uvesafb:1024x768-32,mtrr:3,ywrap (compiled into the kernel)
 
@@ -57,85 +57,90 @@ are either given on the kernel command line or as module parameters, e.g.:
 
 Accepted options:
 
+======= =========================================================
 ypan    Enable display panning using the VESA protected mode
-        interface.  The visible screen is just a window of the
-        video memory, console scrolling is done by changing the
-        start of the window.  This option is available on x86
-        only and is the default option on that architecture.
+	interface.  The visible screen is just a window of the
+	video memory, console scrolling is done by changing the
+	start of the window.  This option is available on x86
+	only and is the default option on that architecture.
 
 ywrap   Same as ypan, but assumes your gfx board can wrap-around
-        the video memory (i.e. starts reading from top if it
-        reaches the end of video memory).  Faster than ypan.
-        Available on x86 only.
+	the video memory (i.e. starts reading from top if it
+	reaches the end of video memory).  Faster than ypan.
+	Available on x86 only.
 
 redraw  Scroll by redrawing the affected part of the screen, this
-        is the default on non-x86.
+	is the default on non-x86.
+======= =========================================================
 
 (If you're using uvesafb as a module, the above three options are
- used a parameter of the scroll option, e.g. scroll=ypan.)
+used a parameter of the scroll option, e.g. scroll=ypan.)
 
-vgapal  Use the standard VGA registers for palette changes.
+=========== ====================================================================
+vgapal      Use the standard VGA registers for palette changes.
 
-pmipal  Use the protected mode interface for palette changes.
-        This is the default if the protected mode interface is
-        available.  Available on x86 only.
+pmipal      Use the protected mode interface for palette changes.
+            This is the default if the protected mode interface is
+            available.  Available on x86 only.
 
-mtrr:n  Setup memory type range registers for the framebuffer
-        where n:
-              0 - disabled (equivalent to nomtrr)
-              3 - write-combining (default)
+mtrr:n      Setup memory type range registers for the framebuffer
+            where n:
 
-	Values other than 0 and 3 will result in a warning and will be
-	treated just like 3.
+                - 0 - disabled (equivalent to nomtrr)
+                - 3 - write-combining (default)
 
-nomtrr  Do not use memory type range registers.
+            Values other than 0 and 3 will result in a warning and will be
+            treated just like 3.
+
+nomtrr      Do not use memory type range registers.
 
 vremap:n
-        Remap 'n' MiB of video RAM.  If 0 or not specified, remap memory
-        according to video mode.
+            Remap 'n' MiB of video RAM.  If 0 or not specified, remap memory
+            according to video mode.
 
-vtotal:n
-        If the video BIOS of your card incorrectly determines the total
-        amount of video RAM, use this option to override the BIOS (in MiB).
+vtotal:n    If the video BIOS of your card incorrectly determines the total
+            amount of video RAM, use this option to override the BIOS (in MiB).
 
-<mode>  The mode you want to set, in the standard modedb format.  Refer to
-        modedb.txt for a detailed description.  When uvesafb is compiled as
-        a module, the mode string should be provided as a value of the
-        'mode_option' option.
+<mode>      The mode you want to set, in the standard modedb format.  Refer to
+            modedb.txt for a detailed description.  When uvesafb is compiled as
+            a module, the mode string should be provided as a value of the
+            'mode_option' option.
 
-vbemode:x
-        Force the use of VBE mode x.  The mode will only be set if it's
-        found in the VBE-provided list of supported modes.
-        NOTE: The mode number 'x' should be specified in VESA mode number
-        notation, not the Linux kernel one (eg. 257 instead of 769).
-        HINT: If you use this option because normal <mode> parameter does
-        not work for you and you use a X server, you'll probably want to
-        set the 'nocrtc' option to ensure that the video mode is properly
-        restored after console <-> X switches.
+vbemode:x   Force the use of VBE mode x.  The mode will only be set if it's
+            found in the VBE-provided list of supported modes.
+            NOTE: The mode number 'x' should be specified in VESA mode number
+            notation, not the Linux kernel one (eg. 257 instead of 769).
+            HINT: If you use this option because normal <mode> parameter does
+            not work for you and you use a X server, you'll probably want to
+            set the 'nocrtc' option to ensure that the video mode is properly
+            restored after console <-> X switches.
 
-nocrtc  Do not use CRTC timings while setting the video mode.  This option
-        has any effect only if the Video BIOS is VBE 3.0 compliant.  Use it
-        if you have problems with modes set the standard way.  Note that
-        using this option implies that any refresh rate adjustments will
-        be ignored and the refresh rate will stay at your BIOS default (60 Hz).
+nocrtc      Do not use CRTC timings while setting the video mode.  This option
+            has any effect only if the Video BIOS is VBE 3.0 compliant.  Use it
+            if you have problems with modes set the standard way.  Note that
+            using this option implies that any refresh rate adjustments will
+            be ignored and the refresh rate will stay at your BIOS default
+            (60 Hz).
 
-noedid  Do not try to fetch and use EDID-provided modes.
+noedid      Do not try to fetch and use EDID-provided modes.
 
-noblank Disable hardware blanking.
+noblank     Disable hardware blanking.
 
-v86d:path
-        Set path to the v86d executable. This option is only available as
-        a module parameter, and not as a part of the video= string.  If you
-        need to use it and have uvesafb built into the kernel, use
-        uvesafb.v86d="path".
+v86d:path   Set path to the v86d executable. This option is only available as
+            a module parameter, and not as a part of the video= string.  If you
+            need to use it and have uvesafb built into the kernel, use
+            uvesafb.v86d="path".
+=========== ====================================================================
 
 Additionally, the following parameters may be provided.  They all override the
 EDID-provided values and BIOS defaults.  Refer to your monitor's specs to get
 the correct values for maxhf, maxvf and maxclk for your hardware.
 
+=========== ======================================
 maxhf:n     Maximum horizontal frequency (in kHz).
 maxvf:n     Maximum vertical frequency (in Hz).
 maxclk:n    Maximum pixel clock (in MHz).
+=========== ======================================
 
 4. The sysfs interface
 ----------------------
@@ -146,27 +151,26 @@ additional information.
 Driver attributes:
 
 /sys/bus/platform/drivers/uvesafb
-  - v86d (default: /sbin/v86d)
+  v86d
+    (default: /sbin/v86d)
+
     Path to the v86d executable. v86d is started by uvesafb
     if an instance of the daemon isn't already running.
 
 Device attributes:
 
 /sys/bus/platform/drivers/uvesafb/uvesafb.0
-  - nocrtc
+  nocrtc
     Use the default refresh rate (60 Hz) if set to 1.
 
-  - oem_product_name
-  - oem_product_rev
-  - oem_string
-  - oem_vendor
+  oem_product_name, oem_product_rev, oem_string, oem_vendor
     Information about the card and its maker.
 
-  - vbe_modes
+  vbe_modes
     A list of video modes supported by the Video BIOS along with their
     VBE mode numbers in hex.
 
-  - vbe_version
+  vbe_version
     A BCD value indicating the implemented VBE standard.
 
 5. Miscellaneous
@@ -176,9 +180,9 @@ Uvesafb will set a video mode with the default refresh rate and timings
 from the Video BIOS if you set pixclock to 0 in fb_var_screeninfo.
 
 
---
+
  Michal Januszewski <spock@gentoo.org>
+
  Last updated: 2017-10-10
 
  Documentation of the uvesafb options is loosely based on vesafb.txt.
-
diff --git a/Documentation/fb/vesafb.txt b/Documentation/fb/vesafb.rst
similarity index 57%
rename from Documentation/fb/vesafb.txt
rename to Documentation/fb/vesafb.rst
index 413bb73235be..2ed0dfb661cf 100644
--- a/Documentation/fb/vesafb.txt
+++ b/Documentation/fb/vesafb.rst
@@ -1,4 +1,4 @@
-
+===============
 What is vesafb?
 ===============
 
@@ -40,30 +40,35 @@ The graphic modes are NOT in the list which you get if you boot with
 vga=ask and hit return. The mode you wish to use is derived from the
 VESA mode number. Here are those VESA mode numbers:
 
-    | 640x480  800x600  1024x768 1280x1024
-----+-------------------------------------
-256 |  0x101    0x103    0x105    0x107   
-32k |  0x110    0x113    0x116    0x119   
-64k |  0x111    0x114    0x117    0x11A   
-16M |  0x112    0x115    0x118    0x11B   
+====== =======  =======  ======== =========
+colors 640x480  800x600  1024x768 1280x1024
+====== =======  =======  ======== =========
+256    0x101    0x103    0x105    0x107
+32k    0x110    0x113    0x116    0x119
+64k    0x111    0x114    0x117    0x11A
+16M    0x112    0x115    0x118    0x11B
+====== =======  =======  ======== =========
+
 
 The video mode number of the Linux kernel is the VESA mode number plus
-0x200.
- 
+0x200:
+
  Linux_kernel_mode_number = VESA_mode_number + 0x200
 
 So the table for the Kernel mode numbers are:
 
-    | 640x480  800x600  1024x768 1280x1024
-----+-------------------------------------
-256 |  0x301    0x303    0x305    0x307   
-32k |  0x310    0x313    0x316    0x319   
-64k |  0x311    0x314    0x317    0x31A   
-16M |  0x312    0x315    0x318    0x31B   
+====== =======  =======  ======== =========
+colors 640x480  800x600  1024x768 1280x1024
+====== =======  =======  ======== =========
+256    0x301    0x303    0x305    0x307
+32k    0x310    0x313    0x316    0x319
+64k    0x311    0x314    0x317    0x31A
+16M    0x312    0x315    0x318    0x31B
+====== =======  =======  ======== =========
 
 To enable one of those modes you have to specify "vga=ask" in the
 lilo.conf file and rerun LILO. Then you can type in the desired
-mode at the "vga=ask" prompt. For example if you like to use 
+mode at the "vga=ask" prompt. For example if you like to use
 1024x768x256 colors you have to say "305" at this prompt.
 
 If this does not work, this might be because your BIOS does not support
@@ -72,10 +77,10 @@ Even if your board does, it might be the BIOS which does not.  VESA BIOS
 Extensions v2.0 are required, 1.2 is NOT sufficient.  You will get a
 "bad mode number" message if something goes wrong.
 
-1. Note: LILO cannot handle hex, for booting directly with 
-         "vga=mode-number" you have to transform the numbers to decimal.
+1. Note: LILO cannot handle hex, for booting directly with
+   "vga=mode-number" you have to transform the numbers to decimal.
 2. Note: Some newer versions of LILO appear to work with those hex values,
-         if you set the 0x in front of the numbers.
+   if you set the 0x in front of the numbers.
 
 X11
 ===
@@ -120,62 +125,68 @@ Accepted options:
 
 inverse	use inverse color map
 
-ypan	enable display panning using the VESA protected mode 
-	interface.  The visible screen is just a window of the
-	video memory, console scrolling is done by changing the
-	start of the window.
-	pro:	* scrolling (fullscreen) is fast, because there is
+========= ======================================================================
+ypan	  enable display panning using the VESA protected mode
+          interface.  The visible screen is just a window of the
+          video memory, console scrolling is done by changing the
+          start of the window.
+
+          pro:
+
+                * scrolling (fullscreen) is fast, because there is
 		  no need to copy around data.
 		* You'll get scrollback (the Shift-PgUp thing),
 		  the video memory can be used as scrollback buffer
-	kontra: * scrolling only parts of the screen causes some
+
+          kontra:
+
+		* scrolling only parts of the screen causes some
 		  ugly flicker effects (boot logo flickers for
 		  example).
 
-ywrap	Same as ypan, but assumes your gfx board can wrap-around 
-	the video memory (i.e. starts reading from top if it
-	reaches the end of video memory).  Faster than ypan.
+ywrap	  Same as ypan, but assumes your gfx board can wrap-around
+          the video memory (i.e. starts reading from top if it
+          reaches the end of video memory).  Faster than ypan.
 
-redraw	scroll by redrawing the affected part of the screen, this
-	is the safe (and slow) default.
+redraw	  Scroll by redrawing the affected part of the screen, this
+          is the safe (and slow) default.
 
 
-vgapal	Use the standard vga registers for palette changes.
-	This is the default.
-pmipal	Use the protected mode interface for palette changes.
+vgapal	  Use the standard vga registers for palette changes.
+          This is the default.
+pmipal    Use the protected mode interface for palette changes.
 
-mtrr:n	setup memory type range registers for the vesafb framebuffer
-	where n:
-	      0 - disabled (equivalent to nomtrr) (default)
-	      1 - uncachable
-	      2 - write-back
-	      3 - write-combining
-	      4 - write-through
+mtrr:n	  Setup memory type range registers for the vesafb framebuffer
+          where n:
 
-	If you see the following in dmesg, choose the type that matches the
-	old one. In this example, use "mtrr:2".
+              - 0 - disabled (equivalent to nomtrr) (default)
+              - 1 - uncachable
+              - 2 - write-back
+              - 3 - write-combining
+              - 4 - write-through
+
+          If you see the following in dmesg, choose the type that matches the
+          old one. In this example, use "mtrr:2".
 ...
-mtrr: type mismatch for e0000000,8000000 old: write-back new: write-combining
+mtrr:     type mismatch for e0000000,8000000 old: write-back new:
+	  write-combining
 ...
 
-nomtrr  disable mtrr
+nomtrr    disable mtrr
 
 vremap:n
-        remap 'n' MiB of video RAM. If 0 or not specified, remap memory
-	according to video mode. (2.5.66 patch/idea by Antonino Daplas
-	reversed to give override possibility (allocate more fb memory
-	than the kernel would) to 2.4 by tmb@iki.fi)
+          Remap 'n' MiB of video RAM. If 0 or not specified, remap memory
+          according to video mode. (2.5.66 patch/idea by Antonino Daplas
+          reversed to give override possibility (allocate more fb memory
+          than the kernel would) to 2.4 by tmb@iki.fi)
 
-vtotal:n
-        if the video BIOS of your card incorrectly determines the total
-        amount of video RAM, use this option to override the BIOS (in MiB).
+vtotal:n  If the video BIOS of your card incorrectly determines the total
+          amount of video RAM, use this option to override the BIOS (in MiB).
+========= ======================================================================
 
 Have fun!
 
-  Gerd
-
---
 Gerd Knorr <kraxel@goldbach.in-berlin.de>
 
-Minor (mostly typo) changes 
+Minor (mostly typo) changes
 by Nico Schmoigl <schmoigl@rumms.uni-mannheim.de>
diff --git a/Documentation/fb/viafb.rst b/Documentation/fb/viafb.rst
new file mode 100644
index 000000000000..8eb7a3bb068c
--- /dev/null
+++ b/Documentation/fb/viafb.rst
@@ -0,0 +1,297 @@
+=======================================================
+VIA Integration Graphic Chip Console Framebuffer Driver
+=======================================================
+
+Platform
+--------
+    The console framebuffer driver is for graphics chips of
+    VIA UniChrome Family
+    (CLE266, PM800 / CN400 / CN300,
+    P4M800CE / P4M800Pro / CN700 / VN800,
+    CX700 / VX700, K8M890, P4M890,
+    CN896 / P4M900, VX800, VX855)
+
+Driver features
+---------------
+    Device: CRT, LCD, DVI
+
+    Support viafb_mode::
+
+	CRT:
+	    640x480(60, 75, 85, 100, 120 Hz), 720x480(60 Hz),
+	    720x576(60 Hz), 800x600(60, 75, 85, 100, 120 Hz),
+	    848x480(60 Hz), 856x480(60 Hz), 1024x512(60 Hz),
+	    1024x768(60, 75, 85, 100 Hz), 1152x864(75 Hz),
+	    1280x768(60 Hz), 1280x960(60 Hz), 1280x1024(60, 75, 85 Hz),
+	    1440x1050(60 Hz), 1600x1200(60, 75 Hz), 1280x720(60 Hz),
+	    1920x1080(60 Hz), 1400x1050(60 Hz), 800x480(60 Hz)
+
+    color depth: 8 bpp, 16 bpp, 32 bpp supports.
+
+    Support 2D hardware accelerator.
+
+Using the viafb module
+----------------------
+    Start viafb with default settings::
+
+	#modprobe viafb
+
+    Start viafb with user options::
+
+	#modprobe viafb viafb_mode=800x600 viafb_bpp=16 viafb_refresh=60
+		  viafb_active_dev=CRT+DVI viafb_dvi_port=DVP1
+		  viafb_mode1=1024x768 viafb_bpp=16 viafb_refresh1=60
+		  viafb_SAMM_ON=1
+
+    viafb_mode:
+	- 640x480 (default)
+	- 720x480
+	- 800x600
+	- 1024x768
+
+    viafb_bpp:
+	- 8, 16, 32 (default:32)
+
+    viafb_refresh:
+	- 60, 75, 85, 100, 120 (default:60)
+
+    viafb_lcd_dsp_method:
+	- 0 : expansion (default)
+	- 1 : centering
+
+    viafb_lcd_mode:
+	0 : LCD panel with LSB data format input (default)
+	1 : LCD panel with MSB data format input
+
+    viafb_lcd_panel_id:
+	- 0 : Resolution: 640x480, Channel: single, Dithering: Enable
+	- 1 : Resolution: 800x600, Channel: single, Dithering: Enable
+	- 2 : Resolution: 1024x768, Channel: single, Dithering: Enable (default)
+	- 3 : Resolution: 1280x768, Channel: single, Dithering: Enable
+	- 4 : Resolution: 1280x1024, Channel: dual, Dithering: Enable
+	- 5 : Resolution: 1400x1050, Channel: dual, Dithering: Enable
+	- 6 : Resolution: 1600x1200, Channel: dual, Dithering: Enable
+
+	- 8 : Resolution: 800x480, Channel: single, Dithering: Enable
+	- 9 : Resolution: 1024x768, Channel: dual, Dithering: Enable
+	- 10: Resolution: 1024x768, Channel: single, Dithering: Disable
+	- 11: Resolution: 1024x768, Channel: dual, Dithering: Disable
+	- 12: Resolution: 1280x768, Channel: single, Dithering: Disable
+	- 13: Resolution: 1280x1024, Channel: dual, Dithering: Disable
+	- 14: Resolution: 1400x1050, Channel: dual, Dithering: Disable
+	- 15: Resolution: 1600x1200, Channel: dual, Dithering: Disable
+	- 16: Resolution: 1366x768, Channel: single, Dithering: Disable
+	- 17: Resolution: 1024x600, Channel: single, Dithering: Enable
+	- 18: Resolution: 1280x768, Channel: dual, Dithering: Enable
+	- 19: Resolution: 1280x800, Channel: single, Dithering: Enable
+
+    viafb_accel:
+	- 0 : No 2D Hardware Acceleration
+	- 1 : 2D Hardware Acceleration (default)
+
+    viafb_SAMM_ON:
+	- 0 : viafb_SAMM_ON disable (default)
+	- 1 : viafb_SAMM_ON enable
+
+    viafb_mode1: (secondary display device)
+	- 640x480 (default)
+	- 720x480
+	- 800x600
+	- 1024x768
+
+    viafb_bpp1: (secondary display device)
+	- 8, 16, 32 (default:32)
+
+    viafb_refresh1: (secondary display device)
+	- 60, 75, 85, 100, 120 (default:60)
+
+    viafb_active_dev:
+	This option is used to specify active devices.(CRT, DVI, CRT+LCD...)
+	DVI stands for DVI or HDMI, E.g., If you want to enable HDMI,
+	set viafb_active_dev=DVI. In SAMM case, the previous of
+	viafb_active_dev is primary device, and the following is
+	secondary device.
+
+	For example:
+
+	To enable one device, such as DVI only, we can use::
+
+	    modprobe viafb viafb_active_dev=DVI
+
+	To enable two devices, such as CRT+DVI::
+
+	    modprobe viafb viafb_active_dev=CRT+DVI;
+
+	For DuoView case, we can use::
+
+	    modprobe viafb viafb_active_dev=CRT+DVI
+
+	OR::
+
+	    modprobe viafb viafb_active_dev=DVI+CRT...
+
+	For SAMM case:
+
+	If CRT is primary and DVI is secondary, we should use::
+
+	    modprobe viafb viafb_active_dev=CRT+DVI viafb_SAMM_ON=1...
+
+	If DVI is primary and CRT is secondary, we should use::
+
+	    modprobe viafb viafb_active_dev=DVI+CRT viafb_SAMM_ON=1...
+
+    viafb_display_hardware_layout:
+	This option is used to specify display hardware layout for CX700 chip.
+
+	- 1 : LCD only
+	- 2 : DVI only
+	- 3 : LCD+DVI (default)
+	- 4 : LCD1+LCD2 (internal + internal)
+	- 16: LCD1+ExternalLCD2 (internal + external)
+
+    viafb_second_size:
+	This option is used to set second device memory size(MB) in SAMM case.
+	The minimal size is 16.
+
+    viafb_platform_epia_dvi:
+	This option is used to enable DVI on EPIA - M
+
+	- 0 : No DVI on EPIA - M (default)
+	- 1 : DVI on EPIA - M
+
+    viafb_bus_width:
+	When using 24 - Bit Bus Width Digital Interface,
+	this option should be set.
+
+	- 12: 12-Bit LVDS or 12-Bit TMDS (default)
+	- 24: 24-Bit LVDS or 24-Bit TMDS
+
+    viafb_device_lcd_dualedge:
+	When using Dual Edge Panel, this option should be set.
+
+	- 0 : No Dual Edge Panel (default)
+	- 1 : Dual Edge Panel
+
+    viafb_lcd_port:
+	This option is used to specify LCD output port,
+	available values are "DVP0" "DVP1" "DFP_HIGHLOW" "DFP_HIGH" "DFP_LOW".
+
+	for external LCD + external DVI on CX700(External LCD is on DVP0),
+	we should use::
+
+	    modprobe viafb viafb_lcd_port=DVP0...
+
+Notes:
+    1. CRT may not display properly for DuoView CRT & DVI display at
+       the "640x480" PAL mode with DVI overscan enabled.
+    2. SAMM stands for single adapter multi monitors. It is different from
+       multi-head since SAMM support multi monitor at driver layers, thus fbcon
+       layer doesn't even know about it; SAMM's second screen doesn't have a
+       device node file, thus a user mode application can't access it directly.
+       When SAMM is enabled, viafb_mode and viafb_mode1, viafb_bpp and
+       viafb_bpp1, viafb_refresh and viafb_refresh1 can be different.
+    3. When console is depending on viafbinfo1, dynamically change resolution
+       and bpp, need to call VIAFB specified ioctl interface VIAFB_SET_DEVICE
+       instead of calling common ioctl function FBIOPUT_VSCREENINFO since
+       viafb doesn't support multi-head well, or it will cause screen crush.
+
+
+Configure viafb with "fbset" tool
+---------------------------------
+
+    "fbset" is an inbox utility of Linux.
+
+    1. Inquire current viafb information, type::
+
+	   # fbset -i
+
+    2. Set various resolutions and viafb_refresh rates::
+
+	   # fbset <resolution-vertical_sync>
+
+       example::
+
+	   # fbset "1024x768-75"
+
+       or::
+
+	   # fbset -g 1024 768 1024 768 32
+
+       Check the file "/etc/fb.modes" to find display modes available.
+
+    3. Set the color depth::
+
+	   # fbset -depth <value>
+
+       example::
+
+	   # fbset -depth 16
+
+
+Configure viafb via /proc
+-------------------------
+    The following files exist in /proc/viafb
+
+    supported_output_devices
+	This read-only file contains a full ',' separated list containing all
+	output devices that could be available on your platform. It is likely
+	that not all of those have a connector on your hardware but it should
+	provide a good starting point to figure out which of those names match
+	a real connector.
+
+	Example::
+
+		# cat /proc/viafb/supported_output_devices
+
+    iga1/output_devices, iga2/output_devices
+	These two files are readable and writable. iga1 and iga2 are the two
+	independent units that produce the screen image. Those images can be
+	forwarded to one or more output devices. Reading those files is a way
+	to query which output devices are currently used by an iga.
+
+	Example::
+
+		# cat /proc/viafb/iga1/output_devices
+
+	If there are no output devices printed the output of this iga is lost.
+	This can happen for example if only one (the other) iga is used.
+	Writing to these files allows adjusting the output devices during
+	runtime. One can add new devices, remove existing ones or switch
+	between igas. Essentially you can write a ',' separated list of device
+	names (or a single one) in the same format as the output to those
+	files. You can add a '+' or '-' as a prefix allowing simple addition
+	and removal of devices. So a prefix '+' adds the devices from your list
+	to the already existing ones, '-' removes the listed devices from the
+	existing ones and if no prefix is given it replaces all existing ones
+	with the listed ones. If you remove devices they are expected to turn
+	off. If you add devices that are already part of the other iga they are
+	removed there and added to the new one.
+
+	Examples:
+
+	Add CRT as output device to iga1::
+
+		# echo +CRT > /proc/viafb/iga1/output_devices
+
+	Remove (turn off) DVP1 and LVDS1 as output devices of iga2::
+
+		# echo -DVP1,LVDS1 > /proc/viafb/iga2/output_devices
+
+	Replace all iga1 output devices by CRT::
+
+		# echo CRT > /proc/viafb/iga1/output_devices
+
+
+Bootup with viafb
+-----------------
+
+Add the following line to your grub.conf::
+
+    append = "video=viafb:viafb_mode=1024x768,viafb_bpp=32,viafb_refresh=85"
+
+
+VIA Framebuffer modes
+=====================
+
+.. include:: viafb.modes
+   :literal:
diff --git a/Documentation/fb/viafb.txt b/Documentation/fb/viafb.txt
deleted file mode 100644
index 1cb2462a71ce..000000000000
--- a/Documentation/fb/viafb.txt
+++ /dev/null
@@ -1,252 +0,0 @@
-
-        VIA Integration Graphic Chip Console Framebuffer Driver
-
-[Platform]
------------------------
-    The console framebuffer driver is for graphics chips of
-    VIA UniChrome Family(CLE266, PM800 / CN400 / CN300,
-                        P4M800CE / P4M800Pro / CN700 / VN800,
-                        CX700 / VX700, K8M890, P4M890,
-                        CN896 / P4M900, VX800, VX855)
-
-[Driver features]
-------------------------
-    Device: CRT, LCD, DVI
-
-    Support viafb_mode:
-        CRT:
-            640x480(60, 75, 85, 100, 120 Hz), 720x480(60 Hz),
-            720x576(60 Hz), 800x600(60, 75, 85, 100, 120 Hz),
-            848x480(60 Hz), 856x480(60 Hz), 1024x512(60 Hz),
-            1024x768(60, 75, 85, 100 Hz), 1152x864(75 Hz),
-            1280x768(60 Hz), 1280x960(60 Hz), 1280x1024(60, 75, 85 Hz),
-            1440x1050(60 Hz), 1600x1200(60, 75 Hz), 1280x720(60 Hz),
-            1920x1080(60 Hz), 1400x1050(60 Hz), 800x480(60 Hz)
-
-    color depth: 8 bpp, 16 bpp, 32 bpp supports.
-
-    Support 2D hardware accelerator.
-
-[Using the viafb module]
--- -- --------------------
-    Start viafb with default settings:
-        #modprobe viafb
-
-    Start viafb with user options:
-        #modprobe viafb viafb_mode=800x600 viafb_bpp=16 viafb_refresh=60
-                  viafb_active_dev=CRT+DVI viafb_dvi_port=DVP1
-                  viafb_mode1=1024x768 viafb_bpp=16 viafb_refresh1=60
-                  viafb_SAMM_ON=1
-
-    viafb_mode:
-        640x480 (default)
-        720x480
-        800x600
-        1024x768
-        ......
-
-    viafb_bpp:
-        8, 16, 32 (default:32)
-
-    viafb_refresh:
-        60, 75, 85, 100, 120 (default:60)
-
-    viafb_lcd_dsp_method:
-        0 : expansion (default)
-        1 : centering
-
-    viafb_lcd_mode:
-        0 : LCD panel with LSB data format input (default)
-        1 : LCD panel with MSB data format input
-
-    viafb_lcd_panel_id:
-        0 : Resolution: 640x480, Channel: single, Dithering: Enable
-        1 : Resolution: 800x600, Channel: single, Dithering: Enable
-        2 : Resolution: 1024x768, Channel: single, Dithering: Enable (default)
-        3 : Resolution: 1280x768, Channel: single, Dithering: Enable
-        4 : Resolution: 1280x1024, Channel: dual, Dithering: Enable
-        5 : Resolution: 1400x1050, Channel: dual, Dithering: Enable
-        6 : Resolution: 1600x1200, Channel: dual, Dithering: Enable
-
-        8 : Resolution: 800x480, Channel: single, Dithering: Enable
-        9 : Resolution: 1024x768, Channel: dual, Dithering: Enable
-        10: Resolution: 1024x768, Channel: single, Dithering: Disable
-        11: Resolution: 1024x768, Channel: dual, Dithering: Disable
-        12: Resolution: 1280x768, Channel: single, Dithering: Disable
-        13: Resolution: 1280x1024, Channel: dual, Dithering: Disable
-        14: Resolution: 1400x1050, Channel: dual, Dithering: Disable
-        15: Resolution: 1600x1200, Channel: dual, Dithering: Disable
-        16: Resolution: 1366x768, Channel: single, Dithering: Disable
-        17: Resolution: 1024x600, Channel: single, Dithering: Enable
-        18: Resolution: 1280x768, Channel: dual, Dithering: Enable
-        19: Resolution: 1280x800, Channel: single, Dithering: Enable
-
-    viafb_accel:
-        0 : No 2D Hardware Acceleration
-        1 : 2D Hardware Acceleration (default)
-
-    viafb_SAMM_ON:
-        0 : viafb_SAMM_ON disable (default)
-        1 : viafb_SAMM_ON enable
-
-    viafb_mode1: (secondary display device)
-        640x480 (default)
-        720x480
-        800x600
-        1024x768
-        ... ...
-
-    viafb_bpp1: (secondary display device)
-        8, 16, 32 (default:32)
-
-    viafb_refresh1: (secondary display device)
-        60, 75, 85, 100, 120 (default:60)
-
-    viafb_active_dev:
-        This option is used to specify active devices.(CRT, DVI, CRT+LCD...)
-        DVI stands for DVI or HDMI, E.g., If you want to enable HDMI,
-        set viafb_active_dev=DVI. In SAMM case, the previous of
-        viafb_active_dev is primary device, and the following is
-        secondary device.
-
-        For example:
-        To enable one device, such as DVI only, we can use:
-            modprobe viafb viafb_active_dev=DVI
-        To enable two devices, such as CRT+DVI:
-            modprobe viafb viafb_active_dev=CRT+DVI;
-
-        For DuoView case, we can use:
-            modprobe viafb viafb_active_dev=CRT+DVI
-            OR
-            modprobe viafb viafb_active_dev=DVI+CRT...
-
-        For SAMM case:
-        If CRT is primary and DVI is secondary, we should use:
-            modprobe viafb viafb_active_dev=CRT+DVI viafb_SAMM_ON=1...
-        If DVI is primary and CRT is secondary, we should use:
-            modprobe viafb viafb_active_dev=DVI+CRT viafb_SAMM_ON=1...
-
-    viafb_display_hardware_layout:
-        This option is used to specify display hardware layout for CX700 chip.
-        1 : LCD only
-        2 : DVI only
-        3 : LCD+DVI (default)
-        4 : LCD1+LCD2 (internal + internal)
-        16: LCD1+ExternalLCD2 (internal + external)
-
-    viafb_second_size:
-        This option is used to set second device memory size(MB) in SAMM case.
-        The minimal size is 16.
-
-    viafb_platform_epia_dvi:
-        This option is used to enable DVI on EPIA - M
-        0 : No DVI on EPIA - M (default)
-        1 : DVI on EPIA - M
-
-    viafb_bus_width:
-        When using 24 - Bit Bus Width Digital Interface,
-        this option should be set.
-        12: 12-Bit LVDS or 12-Bit TMDS (default)
-        24: 24-Bit LVDS or 24-Bit TMDS
-
-    viafb_device_lcd_dualedge:
-        When using Dual Edge Panel, this option should be set.
-        0 : No Dual Edge Panel (default)
-        1 : Dual Edge Panel
-
-    viafb_lcd_port:
-        This option is used to specify LCD output port,
-        available values are "DVP0" "DVP1" "DFP_HIGHLOW" "DFP_HIGH" "DFP_LOW".
-        for external LCD + external DVI on CX700(External LCD is on DVP0),
-        we should use:
-            modprobe viafb viafb_lcd_port=DVP0...
-
-Notes:
-    1. CRT may not display properly for DuoView CRT & DVI display at
-       the "640x480" PAL mode with DVI overscan enabled.
-    2. SAMM stands for single adapter multi monitors. It is different from
-       multi-head since SAMM support multi monitor at driver layers, thus fbcon
-       layer doesn't even know about it; SAMM's second screen doesn't have a
-       device node file, thus a user mode application can't access it directly.
-       When SAMM is enabled, viafb_mode and viafb_mode1, viafb_bpp and
-       viafb_bpp1, viafb_refresh and viafb_refresh1 can be different.
-    3. When console is depending on viafbinfo1, dynamically change resolution
-       and bpp, need to call VIAFB specified ioctl interface VIAFB_SET_DEVICE
-       instead of calling common ioctl function FBIOPUT_VSCREENINFO since
-       viafb doesn't support multi-head well, or it will cause screen crush.
-
-
-[Configure viafb with "fbset" tool]
------------------------------------
-    "fbset" is an inbox utility of Linux.
-    1. Inquire current viafb information, type,
-           # fbset -i
-
-    2. Set various resolutions and viafb_refresh rates,
-           # fbset <resolution-vertical_sync>
-
-       example,
-           # fbset "1024x768-75"
-       or
-           # fbset -g 1024 768 1024 768 32
-       Check the file "/etc/fb.modes" to find display modes available.
-
-    3. Set the color depth,
-           # fbset -depth <value>
-
-       example,
-           # fbset -depth 16
-
-
-[Configure viafb via /proc]
----------------------------
-    The following files exist in /proc/viafb
-
-    supported_output_devices
-
-        This read-only file contains a full ',' separated list containing all
-        output devices that could be available on your platform. It is likely
-        that not all of those have a connector on your hardware but it should
-        provide a good starting point to figure out which of those names match
-        a real connector.
-        Example:
-        # cat /proc/viafb/supported_output_devices
-
-    iga1/output_devices
-    iga2/output_devices
-
-        These two files are readable and writable. iga1 and iga2 are the two
-        independent units that produce the screen image. Those images can be
-        forwarded to one or more output devices. Reading those files is a way
-        to query which output devices are currently used by an iga.
-        Example:
-        # cat /proc/viafb/iga1/output_devices
-        If there are no output devices printed the output of this iga is lost.
-        This can happen for example if only one (the other) iga is used.
-        Writing to these files allows adjusting the output devices during
-        runtime. One can add new devices, remove existing ones or switch
-        between igas. Essentially you can write a ',' separated list of device
-        names (or a single one) in the same format as the output to those
-        files. You can add a '+' or '-' as a prefix allowing simple addition
-        and removal of devices. So a prefix '+' adds the devices from your list
-        to the already existing ones, '-' removes the listed devices from the
-        existing ones and if no prefix is given it replaces all existing ones
-        with the listed ones. If you remove devices they are expected to turn
-        off. If you add devices that are already part of the other iga they are
-        removed there and added to the new one.
-        Examples:
-        Add CRT as output device to iga1
-        # echo +CRT > /proc/viafb/iga1/output_devices
-
-        Remove (turn off) DVP1 and LVDS1 as output devices of iga2
-        # echo -DVP1,LVDS1 > /proc/viafb/iga2/output_devices
-
-        Replace all iga1 output devices by CRT
-        # echo CRT > /proc/viafb/iga1/output_devices
-
-
-[Bootup with viafb]:
---------------------
-    Add the following line to your grub.conf:
-    append = "video=viafb:viafb_mode=1024x768,viafb_bpp=32,viafb_refresh=85"
-
diff --git a/Documentation/fb/vt8623fb.txt b/Documentation/fb/vt8623fb.rst
similarity index 85%
rename from Documentation/fb/vt8623fb.txt
rename to Documentation/fb/vt8623fb.rst
index f654576c56b7..ba1730937dd8 100644
--- a/Documentation/fb/vt8623fb.txt
+++ b/Documentation/fb/vt8623fb.rst
@@ -1,13 +1,13 @@
-
-	vt8623fb - fbdev driver for graphics core in VIA VT8623 chipset
-	===============================================================
+===============================================================
+vt8623fb - fbdev driver for graphics core in VIA VT8623 chipset
+===============================================================
 
 
 Supported Hardware
 ==================
 
-	VIA VT8623 [CLE266] chipset and	its graphics core
-		(known as CastleRock or Unichrome)
+VIA VT8623 [CLE266] chipset and	its graphics core
+(known as CastleRock or Unichrome)
 
 I tested vt8623fb on VIA EPIA ML-6000
 
diff --git a/MAINTAINERS b/MAINTAINERS
index aa9a382d6da5..5ed1fc93969a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4808,7 +4808,7 @@ S:	Maintained
 W:	http://plugable.com/category/projects/udlfb/
 F:	drivers/video/fbdev/udlfb.c
 F:	include/video/udlfb.h
-F:	Documentation/fb/udlfb.txt
+F:	Documentation/fb/udlfb.rst
 
 DISTRIBUTED LOCK MANAGER (DLM)
 M:	Christine Caulfield <ccaulfie@redhat.com>
@@ -7957,7 +7957,7 @@ INTEL FRAMEBUFFER DRIVER (excluding 810 and 815)
 M:	Maik Broemme <mbroemme@libmpq.org>
 L:	linux-fbdev@vger.kernel.org
 S:	Maintained
-F:	Documentation/fb/intelfb.txt
+F:	Documentation/fb/intelfb.rst
 F:	drivers/video/fbdev/intelfb/
 
 INTEL GPIO DRIVERS
@@ -14405,7 +14405,7 @@ M:	Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
 L:	linux-fbdev@vger.kernel.org
 S:	Maintained
 F:	drivers/video/fbdev/sm712*
-F:	Documentation/fb/sm712fb.txt
+F:	Documentation/fb/sm712fb.rst
 
 SIMPLE FIRMWARE INTERFACE (SFI)
 M:	Len Brown <lenb@kernel.org>
@@ -14475,7 +14475,7 @@ SIS FRAMEBUFFER DRIVER
 M:	Thomas Winischhofer <thomas@winischhofer.net>
 W:	http://www.winischhofer.net/linuxsisvga.shtml
 S:	Maintained
-F:	Documentation/fb/sisfb.txt
+F:	Documentation/fb/sisfb.rst
 F:	drivers/video/fbdev/sis/
 F:	include/video/sisfb.h
 
@@ -16682,7 +16682,7 @@ M:	Michal Januszewski <spock@gentoo.org>
 L:	linux-fbdev@vger.kernel.org
 W:	https://github.com/mjanusz/v86d
 S:	Maintained
-F:	Documentation/fb/uvesafb.txt
+F:	Documentation/fb/uvesafb.rst
 F:	drivers/video/fbdev/uvesafb.*
 
 VF610 NAND DRIVER
diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
index 3b1d312bb175..0e3e4dacbc12 100644
--- a/drivers/tty/Kconfig
+++ b/drivers/tty/Kconfig
@@ -95,7 +95,7 @@ config VT_HW_CONSOLE_BINDING
 
 	 See <file:Documentation/console/console.txt> for more
 	 information. For framebuffer console users, please refer to
-	 <file:Documentation/fb/fbcon.txt>.
+	 <file:Documentation/fb/fbcon.rst>.
 
 config UNIX98_PTYS
 	bool "Unix98 PTY support" if EXPERT
diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index df4c40e28f05..2315a5b72d71 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -31,7 +31,7 @@ menuconfig FB
 	  in the /dev directory, i.e. /dev/fb*.
 
 	  You need an utility program called fbset to make full use of frame
-	  buffer devices. Please read <file:Documentation/fb/framebuffer.txt>
+	  buffer devices. Please read <file:Documentation/fb/framebuffer.rst>
 	  and the Framebuffer-HOWTO at
 	  <http://www.munted.org.uk/programming/Framebuffer-HOWTO-1.3.html> for more
 	  information.
@@ -241,7 +241,7 @@ config FB_CIRRUS
 	  If you have a PCI-based system, this enables support for these
 	  chips: GD-543x, GD-544x, GD-5480.
 
-	  Please read the file <file:Documentation/fb/cirrusfb.txt>.
+	  Please read the file <file:Documentation/fb/cirrusfb.rst>.
 
 	  Say N unless you have such a graphics board or plan to get one
 	  before you next recompile the kernel.
@@ -615,7 +615,7 @@ config FB_UVESA
 
 	  This driver generally provides more features than vesafb but
 	  requires a userspace helper application called 'v86d'. See
-	  <file:Documentation/fb/uvesafb.txt> for more information.
+	  <file:Documentation/fb/uvesafb.rst> for more information.
 
 	  If unsure, say N.
 
@@ -630,7 +630,7 @@ config FB_VESA
 	  This is the frame buffer device driver for generic VESA 2.0
 	  compliant graphic cards. The older VESA 1.2 cards are not supported.
 	  You will get a boot time penguin logo at no additional cost. Please
-	  read <file:Documentation/fb/vesafb.txt>. If unsure, say Y.
+	  read <file:Documentation/fb/vesafb.rst>. If unsure, say Y.
 
 config FB_EFI
 	bool "EFI-based Framebuffer Support"
@@ -828,7 +828,7 @@ config FB_PVR2
 	  module load time.  The parameters look like "video=pvr2:XXX", where
 	  the meaning of XXX can be found at the end of the main source file
 	  (<file:drivers/video/pvr2fb.c>). Please see the file
-	  <file:Documentation/fb/pvr2fb.txt>.
+	  <file:Documentation/fb/pvr2fb.rst>.
 
 config FB_OPENCORES
 	tristate "OpenCores VGA/LCD core 2.0 framebuffer support"
@@ -991,7 +991,7 @@ config FB_I810
 	  module will be called i810fb.
 
 	  For more information, please read
-	  <file:Documentation/fb/intel810.txt>
+	  <file:Documentation/fb/intel810.rst>
 
 config FB_I810_GTF
 	bool "use VESA Generalized Timing Formula"
@@ -1061,7 +1061,7 @@ config FB_INTEL
 	  To compile this driver as a module, choose M here: the
 	  module will be called intelfb.
 
-	  For more information, please read <file:Documentation/fb/intelfb.txt>
+	  For more information, please read <file:Documentation/fb/intelfb.rst>
 
 config FB_INTEL_DEBUG
 	bool "Intel driver Debug Messages"
@@ -1098,7 +1098,7 @@ config FB_MATROX
 
 	  You can pass several parameters to the driver at boot time or at
 	  module load time. The parameters look like "video=matroxfb:XXX", and
-	  are described in <file:Documentation/fb/matroxfb.txt>.
+	  are described in <file:Documentation/fb/matroxfb.rst>.
 
 config FB_MATROX_MILLENIUM
 	bool "Millennium I/II support"
@@ -1249,7 +1249,7 @@ config FB_ATY128
 	help
 	  This driver supports graphics boards with the ATI Rage128 chips.
 	  Say Y if you have such a graphics board and read
-	  <file:Documentation/fb/aty128fb.txt>.
+	  <file:Documentation/fb/aty128fb.rst>.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called aty128fb.
@@ -1511,7 +1511,7 @@ config FB_VOODOO1
 
 	  WARNING: Do not use any application that uses the 3D engine
 	  (namely glide) while using this driver.
-	  Please read the <file:Documentation/fb/sstfb.txt> for supported
+	  Please read the <file:Documentation/fb/sstfb.rst> for supported
 	  options and other important info  support.
 
 config FB_VT8623
@@ -1543,7 +1543,7 @@ config FB_TRIDENT
 	  There are also integrated versions of these chips called CyberXXXX,
 	  CyberImage or CyberBlade. These chips are mostly found in laptops
 	  but also on some motherboards including early VIA EPIA motherboards.
-	  For more information, read <file:Documentation/fb/tridentfb.txt>
+	  For more information, read <file:Documentation/fb/tridentfb.rst>
 
 	  Say Y if you have such a graphics board.
 
@@ -1783,7 +1783,7 @@ config FB_PXA_PARAMETERS
 	  single model of flatpanel then you can safely leave this
 	  option disabled.
 
-	  <file:Documentation/fb/pxafb.txt> describes the available parameters.
+	  <file:Documentation/fb/pxafb.rst> describes the available parameters.
 
 config PXA3XX_GCU
 	tristate "PXA3xx 2D graphics accelerator driver"
diff --git a/drivers/video/fbdev/matrox/matroxfb_base.c b/drivers/video/fbdev/matrox/matroxfb_base.c
index c76bef078c75..1a555f70923a 100644
--- a/drivers/video/fbdev/matrox/matroxfb_base.c
+++ b/drivers/video/fbdev/matrox/matroxfb_base.c
@@ -2502,7 +2502,7 @@ MODULE_PARM_DESC(nobios, "Disables ROM BIOS (0 or 1=disabled) (default=do not ch
 module_param(noinit, int, 0);
 MODULE_PARM_DESC(noinit, "Disables W/SG/SD-RAM and bus interface initialization (0 or 1=do not initialize) (default=0)");
 module_param(memtype, int, 0);
-MODULE_PARM_DESC(memtype, "Memory type for G200/G400 (see Documentation/fb/matroxfb.txt for explanation) (default=3 for G200, 0 for G400)");
+MODULE_PARM_DESC(memtype, "Memory type for G200/G400 (see Documentation/fb/matroxfb.rst for explanation) (default=3 for G200, 0 for G400)");
 module_param(mtrr, int, 0);
 MODULE_PARM_DESC(mtrr, "This speeds up video memory accesses (0=disabled or 1) (default=1)");
 module_param(sgram, int, 0);
diff --git a/drivers/video/fbdev/pxafb.c b/drivers/video/fbdev/pxafb.c
index d59c8a59f582..4282cb117b92 100644
--- a/drivers/video/fbdev/pxafb.c
+++ b/drivers/video/fbdev/pxafb.c
@@ -2068,7 +2068,7 @@ static int __init pxafb_setup_options(void)
 #define pxafb_setup_options()		(0)
 
 module_param_string(options, g_options, sizeof(g_options), 0);
-MODULE_PARM_DESC(options, "LCD parameters (see Documentation/fb/pxafb.txt)");
+MODULE_PARM_DESC(options, "LCD parameters (see Documentation/fb/pxafb.rst)");
 #endif
 
 #else
diff --git a/drivers/video/fbdev/sh7760fb.c b/drivers/video/fbdev/sh7760fb.c
index 405715b60ec7..ab8fe838c776 100644
--- a/drivers/video/fbdev/sh7760fb.c
+++ b/drivers/video/fbdev/sh7760fb.c
@@ -6,7 +6,7 @@
  *             Manuel Lauss <mano@roarinelk.homelinux.net>
  * (c) 2008 Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
  *
- * PLEASE HAVE A LOOK AT Documentation/fb/sh7760fb.txt!
+ * PLEASE HAVE A LOOK AT Documentation/fb/sh7760fb.rst!
  *
  * Thanks to Siegfried Schaefer <s.schaefer at schaefer-edv.de>
  *     for his original source and testing!
-- 
2.21.0

