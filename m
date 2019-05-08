Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6193FC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 15:23:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2705521530
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 15:23:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XfxA54mp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbfEHPXo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 11:23:44 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44233 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727112AbfEHPXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 11:23:42 -0400
Received: by mail-pl1-f193.google.com with SMTP id d3so6066153plj.11;
        Wed, 08 May 2019 08:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+HtXa4Ue9AbTj0aCIbX5pYV5pqTXz//dsdosYq60Tuc=;
        b=XfxA54mp9EMnunv7+lG6hqgizijWPnfMtaft1/tW5sJ/8oAQFyH/9hyiAK/0UeBTeu
         47nUU3GPZedUMOpH5Ck/4uALKLBLXWw1P1napdM2b+eZPJ6qpHGfk0F5Ibnd1ZgPD49o
         mRNNsCHsRZo1Y3c2Tv+apVJxrL6hJzn4HlkjgEm3zRXrDzdEvr4LDRNHSB/Gmbns7IHt
         8B7XuprISHRTJnoCdXdy7FcMl6f6M6+HT0FORVYWw3pYhxXlz83s3XNwnxnSLcrMltRE
         RAukZ8MHQm8y/gkWSGcr1/GLmmY+DsyxM6+AwNiHhatuCLKCImNMjq0AkIo3wy3/5zPq
         vh5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+HtXa4Ue9AbTj0aCIbX5pYV5pqTXz//dsdosYq60Tuc=;
        b=R8lj87SU4w9CvEjRjmxCaKCgFcRQaRDDUz4Fc7pKF887P6QFeWsscqru13N/ShzAus
         4OQfAtiIl4wsrQLohF7Cld0uo1NzZieWNGiDl+W8QfEjZuYWA/id6HewUoct9fzaJiu8
         D7YwE0s8fwSmo17uCWQApMz9HVqs0K0Rj7xnmiy6djBet+1fibT9svX24FiSVbWoAMIH
         Tzikj2kZrRorn2C6b1aav0QcLs6cJC7SjTRl3z3fOKW2GqJYTfCJFTDDO/7KSlZx4D1i
         6KENNMXiO/o6AwK3RRkLJ0GzYWlZ1uuhzvkSWh/hoeG08Dx18w68tEzIOnM0EjFbinkE
         C6Nw==
X-Gm-Message-State: APjAAAVM8HEGIKlDflMLv7o4AL2tK9e9CApgugTfdVx549dziUSSdXZO
        TCbyMZ+89gQxGIWmpNVFC10=
X-Google-Smtp-Source: APXvYqyUjhw1p6ZEqTOZzafbT4V6UVfd0HgEUG+drhfd3huNXjt5/uYM+jZvFi6hIQoZXGMVHz4oQw==
X-Received: by 2002:a17:902:b193:: with SMTP id s19mr49134718plr.17.1557329021875;
        Wed, 08 May 2019 08:23:41 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id o73sm7459360pfi.137.2019.05.08.08.23.36
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 08 May 2019 08:23:41 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     x86@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH v4 16/27] Documentation: x86: convert microcode.txt to reST
Date:   Wed,  8 May 2019 23:21:30 +0800
Message-Id: <20190508152141.8740-17-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190508152141.8740-1-changbin.du@gmail.com>
References: <20190508152141.8740-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This converts the plain text documentation to reStructuredText format and
add it to Sphinx TOC tree. No essential content change.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/x86/index.rst                   |  1 +
 .../x86/{microcode.txt => microcode.rst}      | 62 ++++++++++---------
 2 files changed, 35 insertions(+), 28 deletions(-)
 rename Documentation/x86/{microcode.txt => microcode.rst} (81%)

diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
index 6719defc16f8..ae29c026be72 100644
--- a/Documentation/x86/index.rst
+++ b/Documentation/x86/index.rst
@@ -22,3 +22,4 @@ x86-specific Documentation
    intel_mpx
    amd-memory-encryption
    pti
+   microcode
diff --git a/Documentation/x86/microcode.txt b/Documentation/x86/microcode.rst
similarity index 81%
rename from Documentation/x86/microcode.txt
rename to Documentation/x86/microcode.rst
index 79fdb4a8148a..a320d37982ed 100644
--- a/Documentation/x86/microcode.txt
+++ b/Documentation/x86/microcode.rst
@@ -1,7 +1,11 @@
-	The Linux Microcode Loader
+.. SPDX-License-Identifier: GPL-2.0
 
-Authors: Fenghua Yu <fenghua.yu@intel.com>
-	 Borislav Petkov <bp@suse.de>
+==========================
+The Linux Microcode Loader
+==========================
+
+:Authors: - Fenghua Yu <fenghua.yu@intel.com>
+          - Borislav Petkov <bp@suse.de>
 
 The kernel has a x86 microcode loading facility which is supposed to
 provide microcode loading methods in the OS. Potential use cases are
@@ -10,8 +14,8 @@ and updating the microcode on long-running systems without rebooting.
 
 The loader supports three loading methods:
 
-1. Early load microcode
-=======================
+Early load microcode
+====================
 
 The kernel can update microcode very early during boot. Loading
 microcode early can fix CPU issues before they are observed during
@@ -26,8 +30,10 @@ loader parses the combined initrd image during boot.
 
 The microcode files in cpio name space are:
 
-on Intel: kernel/x86/microcode/GenuineIntel.bin
-on AMD  : kernel/x86/microcode/AuthenticAMD.bin
+on Intel:
+  kernel/x86/microcode/GenuineIntel.bin
+on AMD  :
+  kernel/x86/microcode/AuthenticAMD.bin
 
 During BSP (BootStrapping Processor) boot (pre-SMP), the kernel
 scans the microcode file in the initrd. If microcode matching the
@@ -42,8 +48,8 @@ Here's a crude example how to prepare an initrd with microcode (this is
 normally done automatically by the distribution, when recreating the
 initrd, so you don't really have to do it yourself. It is documented
 here for future reference only).
+::
 
----
   #!/bin/bash
 
   if [ -z "$1" ]; then
@@ -76,15 +82,15 @@ here for future reference only).
   cat ucode.cpio $INITRD.orig > $INITRD
 
   rm -rf $TMPDIR
----
+
 
 The system needs to have the microcode packages installed into
 /lib/firmware or you need to fixup the paths above if yours are
 somewhere else and/or you've downloaded them directly from the processor
 vendor's site.
 
-2. Late loading
-===============
+Late loading
+============
 
 There are two legacy user space interfaces to load microcode, either through
 /dev/cpu/microcode or through /sys/devices/system/cpu/microcode/reload file
@@ -94,9 +100,9 @@ The /dev/cpu/microcode method is deprecated because it needs a special
 userspace tool for that.
 
 The easier method is simply installing the microcode packages your distro
-supplies and running:
+supplies and running::
 
-# echo 1 > /sys/devices/system/cpu/microcode/reload
+  # echo 1 > /sys/devices/system/cpu/microcode/reload
 
 as root.
 
@@ -104,29 +110,29 @@ The loading mechanism looks for microcode blobs in
 /lib/firmware/{intel-ucode,amd-ucode}. The default distro installation
 packages already put them there.
 
-3. Builtin microcode
-====================
+Builtin microcode
+=================
 
 The loader supports also loading of a builtin microcode supplied through
 the regular builtin firmware method CONFIG_EXTRA_FIRMWARE. Only 64-bit is
 currently supported.
 
-Here's an example:
+Here's an example::
 
-CONFIG_EXTRA_FIRMWARE="intel-ucode/06-3a-09 amd-ucode/microcode_amd_fam15h.bin"
-CONFIG_EXTRA_FIRMWARE_DIR="/lib/firmware"
+  CONFIG_EXTRA_FIRMWARE="intel-ucode/06-3a-09 amd-ucode/microcode_amd_fam15h.bin"
+  CONFIG_EXTRA_FIRMWARE_DIR="/lib/firmware"
 
-This basically means, you have the following tree structure locally:
+This basically means, you have the following tree structure locally::
 
-/lib/firmware/
-|-- amd-ucode
-...
-|   |-- microcode_amd_fam15h.bin
-...
-|-- intel-ucode
-...
-|   |-- 06-3a-09
-...
+  /lib/firmware/
+  |-- amd-ucode
+  ...
+  |   |-- microcode_amd_fam15h.bin
+  ...
+  |-- intel-ucode
+  ...
+  |   |-- 06-3a-09
+  ...
 
 so that the build system can find those files and integrate them into
 the final kernel image. The early loader finds them and applies them.
-- 
2.20.1

