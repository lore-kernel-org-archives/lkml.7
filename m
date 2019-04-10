Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B28D6C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:16:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BC1920830
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:16:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XLsREfCw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387747AbfDJQQZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 12:16:25 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37363 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387721AbfDJQQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 12:16:22 -0400
Received: by mail-pl1-f195.google.com with SMTP id w23so1717286ply.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 09:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4Wn4tYZKtyQIbqgdelcndTQ7HKhw2rd1tFQ7AR2NLSY=;
        b=XLsREfCwxZo6YbXBti+6yI1YNNTD5ljjsLcsyNo/Y7t3unozeSVUQw1UBBrgBvftpk
         b5SxINtyvYKXwhcWCPXNESzyhk2C/F6sYiSseOZf7O2z60mAZMDfqIEnqlX2B5WHZ9xi
         pGk+EbfYaPiilcHxNgTFhT2yOyCCqV7UCrJbQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4Wn4tYZKtyQIbqgdelcndTQ7HKhw2rd1tFQ7AR2NLSY=;
        b=XaF1O3O1edXeiz+JpiPrDDlJFtJxp+UlDJlqp65P8yiYzO1YZIMa174qPnvOPyI232
         7RVBuDVX7o041hz5EYj6Jy6EgagqgyuRs+7dAPBhi2kTL0DMF2zpmHqX04+DunCQDIRq
         ZVe98HXSS3f/YKK0XQukyQhvaw8hXGaG43cKvSNyHYjlZgdpUnaqZxPuQgAXn41f/8nY
         JkrybBlrRmRORffOORGpwq2sgFuwCHVS75xlmsN9nHRWKCFVBYKCQdV/2Rr/oldvtZXG
         phoDXIIEIiNX+EM9Nc4cbSINUe1hEwpXVbQlf0bgGwehEOLr/lDW1RGS9f7NMhrIPPju
         sqmw==
X-Gm-Message-State: APjAAAURJHlo4eP7nc1oIGqIrDNq8WEmUkS/9GQluQg1aW62r+J1aVWN
        X/NS3rGeeeJQoBkgaFB4k6rmsw==
X-Google-Smtp-Source: APXvYqxK+h5jiN9iKivMZH6Qpj7WRrDDWue1wq5Qvc4y2pUUe1u7rjZAoe9SvEw052fJmBYZQ8cDDw==
X-Received: by 2002:a17:902:b191:: with SMTP id s17mr43294465plr.70.1554912981415;
        Wed, 10 Apr 2019 09:16:21 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id d15sm51895998pfo.34.2019.04.10.09.16.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Apr 2019 09:16:18 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Alexander Potapenko <glider@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Sandeep Patil <sspatil@android.com>,
        Laura Abbott <labbott@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Alexander Popov <alpopov@ptsecurity.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Emese Revfy <re.emese@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Subject: [PATCH 1/3] Kconfig: Create "kernel hardening" config area
Date:   Wed, 10 Apr 2019 09:16:10 -0700
Message-Id: <20190410161612.18545-2-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190410161612.18545-1-keescook@chromium.org>
References: <20190410161612.18545-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now kernel hardening options are scattered around various Kconfig
files. This can be a central place to collect these kinds of options
going forward.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 scripts/gcc-plugins/Kconfig | 70 ++-------------------------
 security/Kconfig            |  2 +
 security/Kconfig.hardening  | 94 +++++++++++++++++++++++++++++++++++++
 3 files changed, 99 insertions(+), 67 deletions(-)
 create mode 100644 security/Kconfig.hardening

diff --git a/scripts/gcc-plugins/Kconfig b/scripts/gcc-plugins/Kconfig
index 74271dba4f94..01874ef0f883 100644
--- a/scripts/gcc-plugins/Kconfig
+++ b/scripts/gcc-plugins/Kconfig
@@ -13,10 +13,11 @@ config HAVE_GCC_PLUGINS
 	  An arch should select this symbol if it supports building with
 	  GCC plugins.
 
-menuconfig GCC_PLUGINS
-	bool "GCC plugins"
+config GCC_PLUGINS
+	bool
 	depends on HAVE_GCC_PLUGINS
 	depends on PLUGIN_HOSTCC != ""
+	default y
 	help
 	  GCC plugins are loadable modules that provide extra features to the
 	  compiler. They are useful for runtime instrumentation and static analysis.
@@ -66,71 +67,6 @@ config GCC_PLUGIN_LATENT_ENTROPY
 	   * https://grsecurity.net/
 	   * https://pax.grsecurity.net/
 
-config GCC_PLUGIN_STRUCTLEAK
-	bool "Zero initialize stack variables"
-	help
-	  While the kernel is built with warnings enabled for any missed
-	  stack variable initializations, this warning is silenced for
-	  anything passed by reference to another function, under the
-	  occasionally misguided assumption that the function will do
-	  the initialization. As this regularly leads to exploitable
-	  flaws, this plugin is available to identify and zero-initialize
-	  such variables, depending on the chosen level of coverage.
-
-	  This plugin was originally ported from grsecurity/PaX. More
-	  information at:
-	   * https://grsecurity.net/
-	   * https://pax.grsecurity.net/
-
-choice
-	prompt "Coverage"
-	depends on GCC_PLUGIN_STRUCTLEAK
-	default GCC_PLUGIN_STRUCTLEAK_BYREF_ALL
-	help
-	  This chooses the level of coverage over classes of potentially
-	  uninitialized variables. The selected class will be
-	  zero-initialized before use.
-
-	config GCC_PLUGIN_STRUCTLEAK_USER
-		bool "structs marked for userspace"
-		help
-		  Zero-initialize any structures on the stack containing
-		  a __user attribute. This can prevent some classes of
-		  uninitialized stack variable exploits and information
-		  exposures, like CVE-2013-2141:
-		  https://git.kernel.org/linus/b9e146d8eb3b9eca
-
-	config GCC_PLUGIN_STRUCTLEAK_BYREF
-		bool "structs passed by reference"
-		help
-		  Zero-initialize any structures on the stack that may
-		  be passed by reference and had not already been
-		  explicitly initialized. This can prevent most classes
-		  of uninitialized stack variable exploits and information
-		  exposures, like CVE-2017-1000410:
-		  https://git.kernel.org/linus/06e7e776ca4d3654
-
-	config GCC_PLUGIN_STRUCTLEAK_BYREF_ALL
-		bool "anything passed by reference"
-		help
-		  Zero-initialize any stack variables that may be passed
-		  by reference and had not already been explicitly
-		  initialized. This is intended to eliminate all classes
-		  of uninitialized stack variable exploits and information
-		  exposures.
-
-endchoice
-
-config GCC_PLUGIN_STRUCTLEAK_VERBOSE
-	bool "Report forcefully initialized variables"
-	depends on GCC_PLUGIN_STRUCTLEAK
-	depends on !COMPILE_TEST	# too noisy
-	help
-	  This option will cause a warning to be printed each time the
-	  structleak plugin finds a variable it thinks needs to be
-	  initialized. Since not all existing initializers are detected
-	  by the plugin, this can produce false positive warnings.
-
 config GCC_PLUGIN_RANDSTRUCT
 	bool "Randomize layout of sensitive kernel structures"
 	select MODVERSIONS if MODULES
diff --git a/security/Kconfig b/security/Kconfig
index 1d6463fb1450..7aec8d094ce2 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -249,5 +249,7 @@ config LSM
 
 	  If unsure, leave this as the default.
 
+source "security/Kconfig.hardening"
+
 endmenu
 
diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
new file mode 100644
index 000000000000..8223a8ab1a12
--- /dev/null
+++ b/security/Kconfig.hardening
@@ -0,0 +1,94 @@
+menu "Kernel hardening options"
+
+config GCC_PLUGIN_STRUCTLEAK
+	bool
+	depends on GCC_PLUGIN_STRUCTLEAK_USER || GCC_PLUGIN_STRUCTLEAK_BYREF || GCC_PLUGIN_STRUCTLEAK_BYREF_ALL
+	help
+	  While the kernel is built with warnings enabled for any missed
+	  stack variable initializations, this warning is silenced for
+	  anything passed by reference to another function, under the
+	  occasionally misguided assumption that the function will do
+	  the initialization. As this regularly leads to exploitable
+	  flaws, this plugin is available to identify and zero-initialize
+	  such variables, depending on the chosen level of coverage.
+
+	  This plugin was originally ported from grsecurity/PaX. More
+	  information at:
+	   * https://grsecurity.net/
+	   * https://pax.grsecurity.net/
+
+menu "Memory initialization"
+
+choice
+	prompt "Initialize kernel stack variables at function entry"
+	depends on CC_HAS_AUTO_VAR_INIT || GCC_PLUGINS
+	default INIT_STACK_NONE
+	help
+	  This option enables initialization of stack variables at
+	  function entry time. This has the possibility to have the
+	  greatest coverage (since all functions can have their
+	  variables initialized), but the performance impact depends
+	  on the function calling complexity of a given workload's
+	  syscalls.
+
+	  This chooses the level of coverage over classes of potentially
+	  uninitialized variables. The selected class will be
+	  initialized before use in a function.
+
+	config INIT_STACK_NONE
+		bool "no automatic initialization (weakest)"
+		help
+		  Disable automatic stack variable initialization.
+		  This leaves the kernel vulnerable to the standard
+		  classes of uninitialized stack variable exploits
+		  and information exposures.
+
+	config GCC_PLUGIN_STRUCTLEAK_USER
+		bool "zero-init structs marked for userspace (weak)"
+		depends on GCC_PLUGINS
+		select GCC_PLUGIN_STRUCTLEAK
+		help
+		  Zero-initialize any structures on the stack containing
+		  a __user attribute. This can prevent some classes of
+		  uninitialized stack variable exploits and information
+		  exposures, like CVE-2013-2141:
+		  https://git.kernel.org/linus/b9e146d8eb3b9eca
+
+	config GCC_PLUGIN_STRUCTLEAK_BYREF
+		bool "zero-init structs passed by reference (strong)"
+		depends on GCC_PLUGINS
+		select GCC_PLUGIN_STRUCTLEAK
+		help
+		  Zero-initialize any structures on the stack that may
+		  be passed by reference and had not already been
+		  explicitly initialized. This can prevent most classes
+		  of uninitialized stack variable exploits and information
+		  exposures, like CVE-2017-1000410:
+		  https://git.kernel.org/linus/06e7e776ca4d3654
+
+	config GCC_PLUGIN_STRUCTLEAK_BYREF_ALL
+		bool "zero-init anything passed by reference (very strong)"
+		depends on GCC_PLUGINS
+		select GCC_PLUGIN_STRUCTLEAK
+		help
+		  Zero-initialize any stack variables that may be passed
+		  by reference and had not already been explicitly
+		  initialized. This is intended to eliminate all classes
+		  of uninitialized stack variable exploits and information
+		  exposures.
+
+endchoice
+
+config GCC_PLUGIN_STRUCTLEAK_VERBOSE
+	bool "Report forcefully initialized variables"
+	depends on GCC_PLUGIN_STRUCTLEAK
+	depends on !COMPILE_TEST	# too noisy
+	help
+	  This option will cause a warning to be printed each time the
+	  structleak plugin finds a variable it thinks needs to be
+	  initialized. Since not all existing initializers are detected
+	  by the plugin, this can produce false positive warnings.
+
+endmenu
+
+endmenu
-- 
2.17.1

