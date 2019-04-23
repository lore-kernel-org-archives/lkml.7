Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D5A2C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 19:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58B0F21773
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 19:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="h3swRhic"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbfDWTti (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 15:49:38 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39938 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbfDWTtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 15:49:32 -0400
Received: by mail-pl1-f193.google.com with SMTP id b3so8032366plr.7
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 12:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uOtKe5kyml7Js+Q+L87rwnDRHYJQCKAPp2OSkZdqNJI=;
        b=h3swRhiciAEavLEU7ENqTEjg0wN2iiR/MN9y8Hna8P/bGPEx/d/Eq1EQHJOlCPg+56
         TnFSmyf/mnJi1j7ACoWNaui2dTB8k7lJaTGCQHpzwTgXFiHJNoczQEsDo5HtGwcx2rEG
         R6B7TaSFbb2Je7R7JHahwvM9UOuXUXMoeAmTI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uOtKe5kyml7Js+Q+L87rwnDRHYJQCKAPp2OSkZdqNJI=;
        b=gCmoAiZilF9ImthhdU1mLkcxeXnO+dC/y1Ic17SZ73R5hYazocZ0qDqhGnP01D6DVE
         iKE6RZsWHf/cWEhVF6GhCtUdsM0vH/h845lthEhQfmkP5vCkb8Kss2S1REGeM4oR2shu
         bmloaZ3j+/DqX2nFI5DCE1O9L6EyWCsqwevndUR1ruGbFEFh2hs8VKHfuoUm6LQIoNIF
         cppmGwEzaneyfbBcEbaZ+xU4DZkhF+E7bLamrfZsC0usQGRpUFZOB9zIXlRpV1c1Pq8P
         0t6hzzOQG7HJGBINMVSw6a9IBtvKKZEQJNJW6YN8scQwGR3v/wXJprpmF4gPSbKU9gav
         dECA==
X-Gm-Message-State: APjAAAVJwAldhDObg9S1KD5pt1L74y8TYG5tKcFkTkyhJ6buvsfBy78v
        6FjeIzSSWdpKePuKJUApLMyLCA==
X-Google-Smtp-Source: APXvYqwFaRFwRy9VH6uH2q5jqI5hM3KzhHgD0CYIl1z3fLB1uzjxbvsnIzJ7vuH0E21hrNVEMnSzkQ==
X-Received: by 2002:a17:902:9a85:: with SMTP id w5mr27979569plp.157.1556048971421;
        Tue, 23 Apr 2019 12:49:31 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id a12sm17537959pgq.21.2019.04.23.12.49.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Apr 2019 12:49:29 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Alexander Potapenko <glider@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        James Morris <jmorris@namei.org>,
        Alexander Popov <alex.popov@linux.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Sandeep Patil <sspatil@android.com>,
        Laura Abbott <labbott@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Emese Revfy <re.emese@gmail.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 1/3] security: Create "kernel hardening" config area
Date:   Tue, 23 Apr 2019 12:49:23 -0700
Message-Id: <20190423194925.32151-2-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190423194925.32151-1-keescook@chromium.org>
References: <20190423194925.32151-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now kernel hardening options are scattered around various Kconfig
files. This can be a central place to collect these kinds of options
going forward. This is initially populated with the memory initialization
options from the gcc-plugins.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 scripts/gcc-plugins/Kconfig | 75 +++---------------------------
 security/Kconfig            |  2 +
 security/Kconfig.hardening  | 93 +++++++++++++++++++++++++++++++++++++
 3 files changed, 101 insertions(+), 69 deletions(-)
 create mode 100644 security/Kconfig.hardening

diff --git a/scripts/gcc-plugins/Kconfig b/scripts/gcc-plugins/Kconfig
index 74271dba4f94..352f03878a1e 100644
--- a/scripts/gcc-plugins/Kconfig
+++ b/scripts/gcc-plugins/Kconfig
@@ -13,17 +13,19 @@ config HAVE_GCC_PLUGINS
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
 
 	  See Documentation/gcc-plugins.txt for details.
 
-if GCC_PLUGINS
+menu "GCC plugins"
+	depends on GCC_PLUGINS
 
 config GCC_PLUGIN_CYC_COMPLEXITY
 	bool "Compute the cyclomatic complexity of a function" if EXPERT
@@ -66,71 +68,6 @@ config GCC_PLUGIN_LATENT_ENTROPY
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
@@ -226,4 +163,4 @@ config GCC_PLUGIN_ARM_SSP_PER_TASK
 	bool
 	depends on GCC_PLUGINS && ARM
 
-endif
+endmenu
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
index 000000000000..19881341f1c2
--- /dev/null
+++ b/security/Kconfig.hardening
@@ -0,0 +1,93 @@
+menu "Kernel hardening options"
+
+config GCC_PLUGIN_STRUCTLEAK
+	bool
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
+	default GCC_PLUGIN_STRUCTLEAK_BYREF_ALL if COMPILE_TEST && GCC_PLUGINS
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

