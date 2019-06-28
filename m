Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03254C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 15:04:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B311920828
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 15:04:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HVNtPG8j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbfF1PEG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 11:04:06 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37462 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726616AbfF1PEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 11:04:06 -0400
Received: by mail-pf1-f193.google.com with SMTP id 19so3130150pfa.4;
        Fri, 28 Jun 2019 08:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tz0edf+rd9vp7v1ChxqEU+68pyAZ++RVYkMsXebKtbg=;
        b=HVNtPG8jYPnm/sSqgyB0GMB2fQaZH+K9j1iVSKMTOSd1Sk7f51l+tMXSGAA3b2JlYm
         oNWZqG3Kb7sJBLNts/ieJ2uXnJh8a2v4g6AqT11B2AjA8Qafwr5wi69YiGgpW1Nv1DRo
         kIu1QceS7WVIWWY5N6MqCPlXyf/Gt3Ipzt1AAzFyvQa3gJ4EOhRUPTila7qtWLpVi3mD
         lKa0n4Ih9wy+hO/+17Y40raSvhWiNRPHEBPfMb8eGlsfH80YdM5gHYSPlvyvpNoZabCO
         UjaY/qobpylgC6okRnu9IdY6QlM1u6QnrltNOcMR4bM9LjA+e5OR3opaFUTsA7tSt6SE
         fuGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tz0edf+rd9vp7v1ChxqEU+68pyAZ++RVYkMsXebKtbg=;
        b=XNHgHChN2EIskyo5rbtPTTfZ/MRgWaB+N73UUssdDjJpvZ8yyqle8plti+FSjuojfG
         ps46YNBgD9ZG7jj1tgYFKVuoscD0e3r7Aad5VC70x5W+9gdi/FNICrKxwd+FW9ARIPT/
         Dyih9R5NUngvJ2m/FyuZV2aSOQ8/j76OIFmDvBpzzhfyyl02Pkh8yF7zPHEHC40UNcCJ
         PUHM1wjwcA6VZrZiol9+U4kgPJNEbBN1xL3Rklbho632yrrcxhF2bJnjVTTcCc6UkZnS
         N76XxYB/9pIx3eCoYjehL38B2YJCUWPrwsmDpX3VhfTmL+kCXaikr4pSLzv4taXKyaiY
         CTDQ==
X-Gm-Message-State: APjAAAWSwYHe8JtNSEjA0BEG+MQiNYEHh8FCzFjxIZmPcQj6nQRvT3LY
        ynYWkC0/z1yaFeJDm+GSz0s=
X-Google-Smtp-Source: APXvYqwwQ1mKQOMsDi+7EnY/DnlVrfcC6ujoZhxD+Wf7Howk5vlexUJq2k11fnPfWXkDLZIJvWRT2g==
X-Received: by 2002:a63:e156:: with SMTP id h22mr9627060pgk.370.1561734244747;
        Fri, 28 Jun 2019 08:04:04 -0700 (PDT)
Received: from bnva-HP-Pavilion-g6-Notebook-PC.domain.name ([117.241.203.131])
        by smtp.gmail.com with ESMTPSA id u75sm2412629pgb.92.2019.06.28.08.04.00
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 28 Jun 2019 08:04:03 -0700 (PDT)
From:   Vandana BN <bnvandana@gmail.com>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-sh@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org
Cc:     skhan@linuxfoundation.org, gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Vandana BN <bnvandana@gmail.com>
Subject: [PATCH v3] Documentation:sh:convert register-banks.txt  and new-machine.txt to rst format.
Date:   Fri, 28 Jun 2019 20:33:45 +0530
Message-Id: <20190628150345.8490-1-bnvandana@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190627063347.11137-1-bnvandana@gmail.com>
References: <20190627063347.11137-1-bnvandana@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch converts new-machine.txt and register-banks.txt
to ReST format, No content change.
Added interfaces.rst to contain kernel-doc markups from index.rst
Added interfaces.rst,new-machine.rst and register-banks.rst to sh/index.rst

Signed-off-by: Vandana BN <bnvandana@gmail.com>
---
 Documentation/sh/index.rst                    |  63 +------
 Documentation/sh/interface.rst                |  59 ++++++
 .../sh/{new-machine.txt => new-machine.rst}   | 171 +++++++++---------
 ...{register-banks.txt => register-banks.rst} |   8 +-
 4 files changed, 161 insertions(+), 140 deletions(-)
 create mode 100644 Documentation/sh/interface.rst
 rename Documentation/sh/{new-machine.txt => new-machine.rst} (79%)
 rename Documentation/sh/{register-banks.txt => register-banks.rst} (90%)

diff --git a/Documentation/sh/index.rst b/Documentation/sh/index.rst
index bc8db7ba894a..e9e4720cce0c 100644
--- a/Documentation/sh/index.rst
+++ b/Documentation/sh/index.rst
@@ -1,59 +1,12 @@
-=======================
-SuperH Interfaces Guide
-=======================
+====================
+SuperH Documentation
+====================

 :Author: Paul Mundt

-Memory Management
-=================
+.. toctree::
+   :maxdepth: 2

-SH-4
-----
-
-Store Queue API
-~~~~~~~~~~~~~~~
-
-.. kernel-doc:: arch/sh/kernel/cpu/sh4/sq.c
-   :export:
-
-SH-5
-----
-
-TLB Interfaces
-~~~~~~~~~~~~~~
-
-.. kernel-doc:: arch/sh/mm/tlb-sh5.c
-   :internal:
-
-.. kernel-doc:: arch/sh/include/asm/tlb_64.h
-   :internal:
-
-Machine Specific Interfaces
-===========================
-
-mach-dreamcast
---------------
-
-.. kernel-doc:: arch/sh/boards/mach-dreamcast/rtc.c
-   :internal:
-
-mach-x3proto
-------------
-
-.. kernel-doc:: arch/sh/boards/mach-x3proto/ilsel.c
-   :export:
-
-Busses
-======
-
-SuperHyway
-----------
-
-.. kernel-doc:: drivers/sh/superhyway/superhyway.c
-   :export:
-
-Maple
------
-
-.. kernel-doc:: drivers/sh/maple/maple.c
-   :export:
+   interface
+   new-machine
+   register-banks
diff --git a/Documentation/sh/interface.rst b/Documentation/sh/interface.rst
new file mode 100644
index 000000000000..bc8db7ba894a
--- /dev/null
+++ b/Documentation/sh/interface.rst
@@ -0,0 +1,59 @@
+=======================
+SuperH Interfaces Guide
+=======================
+
+:Author: Paul Mundt
+
+Memory Management
+=================
+
+SH-4
+----
+
+Store Queue API
+~~~~~~~~~~~~~~~
+
+.. kernel-doc:: arch/sh/kernel/cpu/sh4/sq.c
+   :export:
+
+SH-5
+----
+
+TLB Interfaces
+~~~~~~~~~~~~~~
+
+.. kernel-doc:: arch/sh/mm/tlb-sh5.c
+   :internal:
+
+.. kernel-doc:: arch/sh/include/asm/tlb_64.h
+   :internal:
+
+Machine Specific Interfaces
+===========================
+
+mach-dreamcast
+--------------
+
+.. kernel-doc:: arch/sh/boards/mach-dreamcast/rtc.c
+   :internal:
+
+mach-x3proto
+------------
+
+.. kernel-doc:: arch/sh/boards/mach-x3proto/ilsel.c
+   :export:
+
+Busses
+======
+
+SuperHyway
+----------
+
+.. kernel-doc:: drivers/sh/superhyway/superhyway.c
+   :export:
+
+Maple
+-----
+
+.. kernel-doc:: drivers/sh/maple/maple.c
+   :export:
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

