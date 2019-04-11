Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F07C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 18:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A05282146F
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 18:01:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DUxRl5u9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbfDKSBb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 14:01:31 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42455 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbfDKSB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 14:01:28 -0400
Received: by mail-pf1-f194.google.com with SMTP id w25so3814006pfi.9
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 11:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sgh5nTWzjTHRgFzbdPHxAju6sMEf7AAdMUWwjzGDW68=;
        b=DUxRl5u9n71ywc3/DbRZE2AKdg5b61iCssBLWuqDywmnvnVZaNTMSm0rwtIRFjXWA7
         IpYFxZJtKe5Gf2UvwtrHOn6hgPCuvT2ZLOpr00rOk2nZuDFjHaSK6XEjwYd/5niA8KZx
         lvcUEzg5lI+4dl/1gS8ZdCm+uYVdN/pOmE1Oo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sgh5nTWzjTHRgFzbdPHxAju6sMEf7AAdMUWwjzGDW68=;
        b=V95a2TG6G2dkNWwajR/UuKABUdXNEq2bFywJ5zpAcE9UMP41vxLa7IQbIyGsxluOE7
         lXNM/gXr2VkscgjunnEnD4CvlVcB/LvVX/NCAZ9jM0MV6WHLHnELcLoEEkXRiwrizKdL
         FeWud+T0zSkpwkglPgy9+we4jQiU1pD6JNbCRALXzNoy866e3R7LJhNgbcKNuERbpJPh
         Qv92xbVuwPQxdWJchg007BjLgcNhOkVnPqro4V+eGWnZV7oRR/qVcslSrwqxQq8xyqJX
         aEjh1LFzd8TLqAsSM9uQApiYYlk6VEqJ9Y6RHhvJfjTjN7pE3oG/l9H5ZrxyFDd/DVWt
         vkfw==
X-Gm-Message-State: APjAAAXQkjq+2Fs6ygaoUCd3DDCcY2cI8RDUBvt9uOiwvf7kInVeKMp+
        q61mzMVyPU4Ift7Xpv94eN2+qQ==
X-Google-Smtp-Source: APXvYqyYb6skeDLrB8fCrVcgL4OHjA00ZOvbgTUty0hnTQdhG88vGQlp2F84v4cgvaWbc00AkWY86Q==
X-Received: by 2002:a62:5ec2:: with SMTP id s185mr50811342pfb.16.1555005687538;
        Thu, 11 Apr 2019 11:01:27 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id e8sm85868958pfc.47.2019.04.11.11.01.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Apr 2019 11:01:25 -0700 (PDT)
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
        kernel-hardening@lists.openwall.com,
        linux-security-module@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] security: Create "kernel hardening" config area
Date:   Thu, 11 Apr 2019 11:01:15 -0700
Message-Id: <20190411180117.27704-2-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190411180117.27704-1-keescook@chromium.org>
References: <20190411180117.27704-1-keescook@chromium.org>
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
 scripts/gcc-plugins/Kconfig | 74 +++--------------------------
 security/Kconfig            |  2 +
 security/Kconfig.hardening  | 93 +++++++++++++++++++++++++++++++++++++
 3 files changed, 102 insertions(+), 67 deletions(-)
 create mode 100644 security/Kconfig.hardening

diff --git a/scripts/gcc-plugins/Kconfig b/scripts/gcc-plugins/Kconfig
index 74271dba4f94..84d471dea2b7 100644
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
@@ -25,6 +26,8 @@ menuconfig GCC_PLUGINS
 
 if GCC_PLUGINS
 
+menu "GCC plugins"
+
 config GCC_PLUGIN_CYC_COMPLEXITY
 	bool "Compute the cyclomatic complexity of a function" if EXPERT
 	depends on !COMPILE_TEST	# too noisy
@@ -66,71 +69,6 @@ config GCC_PLUGIN_LATENT_ENTROPY
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
@@ -226,4 +164,6 @@ config GCC_PLUGIN_ARM_SSP_PER_TASK
 	bool
 	depends on GCC_PLUGINS && ARM
 
+endmenu
+
 endif
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
index 000000000000..01a119437dfc
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
+	depends on GCC_PLUGINS
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

