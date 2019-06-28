Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43AF8C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 13:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0367820644
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 13:25:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gbYw+9tb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbfF1NZU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 09:25:20 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34327 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbfF1NZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 09:25:20 -0400
Received: by mail-pl1-f195.google.com with SMTP id i2so3266587plt.1;
        Fri, 28 Jun 2019 06:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=32ErQPXIbrc8JNIUwd6ZeT6JCviUE7r1Zg+q3Fn+0pw=;
        b=gbYw+9tbXyA+d+t38B7uTwBqE1dR3/xm6u36GO/TZrfzSNV5MkdMLL4+u/zJz8k8b1
         gDeaoO4WP6ZWnm9wpSpxwuyEfMZd7bDi5wcOx6eSCFdU2gtu9iJDOa/HNd1mamLsYJIG
         tQ7/AsfEIJlnvOR2zWd5z038mybVkihvgJgZKUpy2YECrt+6fE3+PsreuYmVwiZeiC63
         ywxARD6lOd4LCZvAEFT4YMlxslaSH/1xwhZD689bhr/FIEGe84jflWU/pqvkTE1Aec3H
         usUtVEhO8a+MjVDQQzhEpjSvqoeFUBHBRk1ky8G2CEUnYXwhJsSr+qldxiUtsLKvP4TG
         obbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=32ErQPXIbrc8JNIUwd6ZeT6JCviUE7r1Zg+q3Fn+0pw=;
        b=OjfX4aXbKIdqPSMaokCHvTs6Kpa2lz8RALU9dsL3GCALoea7i486SMPRV2iUiTmVCj
         rgxrG9SsmPb5KXWX9jOIqlBmX1nK1Vx0LMH8x2AU6zAZaRrJfZD9E2amL7iD6lvC7uy7
         ja/H7rJNRaO9i4WavVJpgZRPHQoSKJAzXMEOlZcnLcL+rb0gEaap0FjMC44iR4wd03NJ
         RaDtK3MTH2VwGALZUdIEJ5QzuZKPGXT5my8MLf2EuEeQEf9vuR9dMlYBnO29JGlR2qy9
         t8aYo3afHrQgocKrLn93/Son0Yscs5jerpuS1oE+Rho747myRQBdAcDGsEZ6BMVnnPRg
         CJhQ==
X-Gm-Message-State: APjAAAUuQorGauhmh8HqCg1u6WuuRQQ+V9baJUIMGsfDQayEudbMDgGq
        HDjPgesio1y2AVmwsjXGMeM=
X-Google-Smtp-Source: APXvYqxP3R0x+RIGncA0GElcVIS8Sdr+5ymvIKEp2v9V52Y+ZiiI7pW13eMmX5euQ6+C1sTqg1u3kQ==
X-Received: by 2002:a17:902:8d92:: with SMTP id v18mr11839312plo.211.1561728318418;
        Fri, 28 Jun 2019 06:25:18 -0700 (PDT)
Received: from bnva-HP-Pavilion-g6-Notebook-PC.domain.name ([117.241.203.131])
        by smtp.gmail.com with ESMTPSA id y19sm2355134pfe.150.2019.06.28.06.25.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 28 Jun 2019 06:25:17 -0700 (PDT)
From:   Vandana BN <bnvandana@gmail.com>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-sh@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org
Cc:     skhan@linuxfoundation.org, gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Vandana BN <bnvandana@gmail.com>
Subject: [PATCH v2] Documentation:sh:convert register-banks.txt  and new-machine.txt to rst format.
Date:   Fri, 28 Jun 2019 18:54:59 +0530
Message-Id: <20190628132459.5409-1-bnvandana@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190627063347.11137-1-bnvandana@gmail.com>
References: <20190627063347.11137-1-bnvandana@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch converts new-machine.txt and register-banks.txt to ReST format, No content
change.
Added new-machine.rst and register-banks.rst to sh/index.rst

Signed-off-by: Vandana BN <bnvandana@gmail.com>
---
 Documentation/sh/index.rst                    |   6 +
 .../sh/{new-machine.txt => new-machine.rst}   | 171 +++++++++---------
 ...{register-banks.txt => register-banks.rst} |   8 +-
 3 files changed, 100 insertions(+), 85 deletions(-)
 rename Documentation/sh/{new-machine.txt => new-machine.rst} (79%)
 rename Documentation/sh/{register-banks.txt => register-banks.rst} (90%)

diff --git a/Documentation/sh/index.rst b/Documentation/sh/index.rst
index bc8db7ba894a..25471d3fc294 100644
--- a/Documentation/sh/index.rst
+++ b/Documentation/sh/index.rst
@@ -57,3 +57,9 @@ Maple

 .. kernel-doc:: drivers/sh/maple/maple.c
    :export:
+
+.. toctree::
+   :maxdepth: 2
+
+   new-machine
+   register-banks
diff --git a/Documentation/sh/new-machine.txt b/Documentation/sh/new-machine.rst
similarity index 79%
rename from Documentation/sh/new-machine.txt
rename to Documentation/sh/new-machine.rst
index e0961a66130b..b16c33342642 100644
--- a/Documentation/sh/new-machine.txt
+++ b/Documentation/sh/new-machine.rst
@@ -1,8 +1,8 @@
+================================
+Adding a new board to LinuxSH
+================================

-                Adding a new board to LinuxSH
-               ================================
-
-               Paul Mundt <lethal@linux-sh.org>
+Paul Mundt <lethal@linux-sh.org>

 This document attempts to outline what steps are necessary to add support
 for new boards to the LinuxSH port under the new 2.5 and 2.6 kernels. This
@@ -19,65 +19,67 @@ include/asm-sh/. For the new kernel, things are broken out by board type,
 companion chip type, and CPU type. Looking at a tree view of this directory
 hierarchy looks like the following:

-Board-specific code:
-
-.
-|-- arch
-|   `-- sh
-|       `-- boards
-|           |-- adx
-|           |   `-- board-specific files
-|           |-- bigsur
-|           |   `-- board-specific files
-|           |
-|           ... more boards here ...
-|
-`-- include
-    `-- asm-sh
-        |-- adx
-        |   `-- board-specific headers
-        |-- bigsur
-        |   `-- board-specific headers
-        |
-	.. more boards here ...
-
-Next, for companion chips:
-.
-`-- arch
-    `-- sh
-        `-- cchips
-            `-- hd6446x
-                `-- hd64461
-                    `-- cchip-specific files
+Board-specific code::
+
+ .
+ |-- arch
+ |   `-- sh
+ |       `-- boards
+ |           |-- adx
+ |           |   `-- board-specific files
+ |           |-- bigsur
+ |           |   `-- board-specific files
+ |           |
+ |           ... more boards here ...
+ |
+ `-- include
+     `-- asm-sh
+         |-- adx
+         |   `-- board-specific headers
+         |-- bigsur
+         |   `-- board-specific headers
+         |
+       	 .. more boards here ...
+
+Next, for companion chips::
+
+ .
+ `-- arch
+     `-- sh
+         `-- cchips
+             `-- hd6446x
+                 `-- hd64461
+                     `-- cchip-specific files

 ... and so on. Headers for the companion chips are treated the same way as
 board-specific headers. Thus, include/asm-sh/hd64461 is home to all of the
 hd64461-specific headers.

-Finally, CPU family support is also abstracted:
-.
-|-- arch
-|   `-- sh
-|       |-- kernel
-|       |   `-- cpu
-|       |       |-- sh2
-|       |       |   `-- SH-2 generic files
-|       |       |-- sh3
-|       |       |   `-- SH-3 generic files
-|       |       `-- sh4
-|       |           `-- SH-4 generic files
-|       `-- mm
-|           `-- This is also broken out per CPU family, so each family can
-|               have their own set of cache/tlb functions.
-|
-`-- include
-    `-- asm-sh
-        |-- cpu-sh2
-        |   `-- SH-2 specific headers
-        |-- cpu-sh3
-        |   `-- SH-3 specific headers
-        `-- cpu-sh4
-            `-- SH-4 specific headers
+Finally, CPU family support is also abstracted::
+
+ .
+ |-- arch
+ |   `-- sh
+ |       |-- kernel
+ |       |   `-- cpu
+ |       |       |-- sh2
+ |       |       |   `-- SH-2 generic files
+ |       |       |-- sh3
+ |       |       |   `-- SH-3 generic files
+ |       |       `-- sh4
+ |       |           `-- SH-4 generic files
+ |       `-- mm
+ |           `-- This is also broken out per CPU family, so each family can
+ |               have their own set of cache/tlb functions.
+ |
+ `-- include
+     `-- asm-sh
+         |-- cpu-sh2
+         |   `-- SH-2 specific headers
+         |-- cpu-sh3
+         |   `-- SH-3 specific headers
+         `-- cpu-sh4
+             `-- SH-4 specific headers

 It should be noted that CPU subtypes are _not_ abstracted. Thus, these still
 need to be dealt with by the CPU family specific code.
@@ -112,18 +114,20 @@ setup code, we're required at the very least to provide definitions for
 get_system_type() and platform_setup(). For our imaginary board, this
 might look something like:

-/*
- * arch/sh/boards/vapor/setup.c - Setup code for imaginary board
- */
-#include <linux/init.h>
+.. code-block:: c
+
+    /*
+     * arch/sh/boards/vapor/setup.c - Setup code for imaginary board
+     */
+    #include <linux/init.h>

-const char *get_system_type(void)
-{
-	return "FooTech Vaporboard";
-}
+    const char *get_system_type(void)
+    {
+        return "FooTech Vaporboard";
+    }

-int __init platform_setup(void)
-{
+    int __init platform_setup(void)
+    {
   	/*
 	 * If our hardware actually existed, we would do real
 	 * setup here. Though it's also sane to leave this empty
@@ -136,7 +140,8 @@ int __init platform_setup(void)
 	/* And whatever else ... */

 	return 0;
-}
+    }
+

 Our new imaginary board will also have to tie into the machvec in order for it
 to be of any use.
@@ -172,16 +177,17 @@ sufficient.
    vector.

    Note that these prototypes are generated automatically by setting
-   __IO_PREFIX to something sensible. A typical example would be:
+   __IO_PREFIX to something sensible. A typical example would be::

 	#define __IO_PREFIX vapor
    	#include <asm/io_generic.h>

+
    somewhere in the board-specific header. Any boards being ported that still
    have a legacy io.h should remove it entirely and switch to the new model.

  - Add machine vector definitions to the board's setup.c. At a bare minimum,
-   this must be defined as something like:
+   this must be defined as something like::

 	struct sh_machine_vector mv_vapor __initmv = {
 		.mv_name = "vapor",
@@ -202,11 +208,11 @@ Large portions of the build system are now entirely dynamic, and merely
 require the proper entry here and there in order to get things done.

 The first thing to do is to add an entry to arch/sh/Kconfig, under the
-"System type" menu:
+"System type" menu::

-config SH_VAPOR
-	bool "Vapor"
-	help
+ config SH_VAPOR
+	 bool "Vapor"
+	 help
 	  select Vapor if configuring for a FooTech Vaporboard.

 next, this has to be added into arch/sh/Makefile. All boards require a
@@ -232,6 +238,8 @@ space restating it here. After this is done, you will be able to use
 implicit checks for your board if you need this somewhere throughout the
 common code, such as:

+::
+
 	/* Make sure we're on the FooTech Vaporboard */
 	if (!mach_is_vapor())
 		return -ENODEV;
@@ -253,12 +261,13 @@ build target, and it will be implicitly listed as such in the help text.
 Looking at the 'make help' output, you should now see something like:

 Architecture specific targets (sh):
-  zImage                  - Compressed kernel image (arch/sh/boot/zImage)
-  adx_defconfig           - Build for adx
-  cqreek_defconfig        - Build for cqreek
-  dreamcast_defconfig     - Build for dreamcast
-...
-  vapor_defconfig         - Build for vapor
+
+ - zImage                  - Compressed kernel image (arch/sh/boot/zImage)
+ - adx_defconfig           - Build for adx
+ - cqreek_defconfig        - Build for cqreek
+ - dreamcast_defconfig     - Build for dreamcast
+ - ...
+ - vapor_defconfig         - Build for vapor

 which then allows you to do:

diff --git a/Documentation/sh/register-banks.txt b/Documentation/sh/register-banks.rst
similarity index 90%
rename from Documentation/sh/register-banks.txt
rename to Documentation/sh/register-banks.rst
index a6719f2f6594..acccfaf80355 100644
--- a/Documentation/sh/register-banks.txt
+++ b/Documentation/sh/register-banks.rst
@@ -1,8 +1,9 @@
-	Notes on register bank usage in the kernel
-	==========================================
+==========================================
+Notes on register bank usage in the kernel
+==========================================

 Introduction
-------------
+============

 The SH-3 and SH-4 CPU families traditionally include a single partial register
 bank (selected by SR.RB, only r0 ... r7 are banked), whereas other families
@@ -30,4 +31,3 @@ Presently the kernel uses several of these registers.
 		- The SR.IMASK interrupt handler makes use of this to set the
 		  interrupt priority level (used by local_irq_enable())
 	- r7_bank (current)
-
--
2.17.1

