Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A22C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 19:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BFFF21850
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 19:49:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Tp0+ApHt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbfDWTts (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 15:49:48 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35534 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbfDWTtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 15:49:32 -0400
Received: by mail-pf1-f194.google.com with SMTP id t21so8026919pfh.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 12:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=URKuk0ypK06hT4XKJa7CoXAJpL44zlAI9HDKPAQ7SNY=;
        b=Tp0+ApHtknMJIeHfnk/6Ldq3W6h8WLUFxgb5NEs+wLNTXOf8BWw/+EaAvCNZFBR6hk
         96b6cTMZ6g1UEpdazi8hbWjTB9R5ncHUHRlv5h6n0DX28wfiXeg6bc+LmQ8IJPgzeyDQ
         3h1Nny1w3YZ6Hj94iPco+uptzsJE54170RpFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=URKuk0ypK06hT4XKJa7CoXAJpL44zlAI9HDKPAQ7SNY=;
        b=URDXFMPUHOU2XNTNrBusLQf2cj7j/dluupiwJdWDDhlxjdzIba0r9uvAK1ADYsHUEC
         vt1yWWuAxqNbUEqyMIcm5lipAvT1r67RqHbEb5rFqfMmL76GjSn8GSNt2l/20omWpe+i
         HeiGasviQwEbBk6g08Mbi75GmRPTf7yOu5IFuiZ0Paq1O6qjqJIfM5OFBMwCBRGSE9lI
         O6qmL7Z6VvcEkhHuoRfhq/M1lUouWVbWL6i6+nkJJMfJEf3lFrj7G/mO2jQ23UGDHjYO
         D6cHhQucc8tFb2Pwj/h4n4aVIRIq5MmQlEAQHV1737T9g/mk44S1Kotuf+XE/LlwGMQk
         hHqg==
X-Gm-Message-State: APjAAAXkYZm92X6y0W6LGU28ON3j9MqbptUpBN/f5Y0oJjETbgyxK8kC
        7VnYebKCCHBPQKJRo3UQSBQo9w==
X-Google-Smtp-Source: APXvYqyecH5RI4lfqflcGZ7dIshMKAPZIYezjXDA/qHjDbkprN/2t8g0y0Ye3ffB660Qz4n/GeoVOw==
X-Received: by 2002:aa7:97b0:: with SMTP id d16mr5396163pfq.233.1556048972099;
        Tue, 23 Apr 2019 12:49:32 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id n26sm30303570pfi.165.2019.04.23.12.49.29
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
Subject: [PATCH v3 2/3] security: Move stackleak config to Kconfig.hardening
Date:   Tue, 23 Apr 2019 12:49:24 -0700
Message-Id: <20190423194925.32151-3-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190423194925.32151-1-keescook@chromium.org>
References: <20190423194925.32151-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This moves the stackleak plugin options to Kconfig.hardening's memory
initialization menu.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 scripts/gcc-plugins/Kconfig | 51 ---------------------------------
 security/Kconfig.hardening  | 57 +++++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+), 51 deletions(-)

diff --git a/scripts/gcc-plugins/Kconfig b/scripts/gcc-plugins/Kconfig
index 352f03878a1e..80220ed26a35 100644
--- a/scripts/gcc-plugins/Kconfig
+++ b/scripts/gcc-plugins/Kconfig
@@ -108,57 +108,6 @@ config GCC_PLUGIN_RANDSTRUCT_PERFORMANCE
 	  in structures.  This reduces the performance hit of RANDSTRUCT
 	  at the cost of weakened randomization.
 
-config GCC_PLUGIN_STACKLEAK
-	bool "Erase the kernel stack before returning from syscalls"
-	depends on GCC_PLUGINS
-	depends on HAVE_ARCH_STACKLEAK
-	help
-	  This option makes the kernel erase the kernel stack before
-	  returning from system calls. That reduces the information which
-	  kernel stack leak bugs can reveal and blocks some uninitialized
-	  stack variable attacks.
-
-	  The tradeoff is the performance impact: on a single CPU system kernel
-	  compilation sees a 1% slowdown, other systems and workloads may vary
-	  and you are advised to test this feature on your expected workload
-	  before deploying it.
-
-	  This plugin was ported from grsecurity/PaX. More information at:
-	   * https://grsecurity.net/
-	   * https://pax.grsecurity.net/
-
-config STACKLEAK_TRACK_MIN_SIZE
-	int "Minimum stack frame size of functions tracked by STACKLEAK"
-	default 100
-	range 0 4096
-	depends on GCC_PLUGIN_STACKLEAK
-	help
-	  The STACKLEAK gcc plugin instruments the kernel code for tracking
-	  the lowest border of the kernel stack (and for some other purposes).
-	  It inserts the stackleak_track_stack() call for the functions with
-	  a stack frame size greater than or equal to this parameter.
-	  If unsure, leave the default value 100.
-
-config STACKLEAK_METRICS
-	bool "Show STACKLEAK metrics in the /proc file system"
-	depends on GCC_PLUGIN_STACKLEAK
-	depends on PROC_FS
-	help
-	  If this is set, STACKLEAK metrics for every task are available in
-	  the /proc file system. In particular, /proc/<pid>/stack_depth
-	  shows the maximum kernel stack consumption for the current and
-	  previous syscalls. Although this information is not precise, it
-	  can be useful for estimating the STACKLEAK performance impact for
-	  your workloads.
-
-config STACKLEAK_RUNTIME_DISABLE
-	bool "Allow runtime disabling of kernel stack erasing"
-	depends on GCC_PLUGIN_STACKLEAK
-	help
-	  This option provides 'stack_erasing' sysctl, which can be used in
-	  runtime to control kernel stack erasing for kernels built with
-	  CONFIG_GCC_PLUGIN_STACKLEAK.
-
 config GCC_PLUGIN_ARM_SSP_PER_TASK
 	bool
 	depends on GCC_PLUGINS && ARM
diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
index 19881341f1c2..a96d4a43ca65 100644
--- a/security/Kconfig.hardening
+++ b/security/Kconfig.hardening
@@ -88,6 +88,63 @@ config GCC_PLUGIN_STRUCTLEAK_VERBOSE
 	  initialized. Since not all existing initializers are detected
 	  by the plugin, this can produce false positive warnings.
 
+config GCC_PLUGIN_STACKLEAK
+	bool "Poison kernel stack before returning from syscalls"
+	depends on GCC_PLUGINS
+	depends on HAVE_ARCH_STACKLEAK
+	help
+	  This option makes the kernel erase the kernel stack before
+	  returning from system calls. This has the effect of leaving
+	  the stack initialized to the poison value, which both reduces
+	  the lifetime of any sensitive stack contents and reduces
+	  potential for uninitialized stack variable exploits or information
+	  exposures (it does not cover functions reaching the same stack
+	  depth as prior functions during the same syscall). This blocks
+	  most uninitialized stack variable attacks, with the performance
+	  impact being driven by the depth of the stack usage, rather than
+	  the function calling complexity.
+
+	  The performance impact on a single CPU system kernel compilation
+	  sees a 1% slowdown, other systems and workloads may vary and you
+	  are advised to test this feature on your expected workload before
+	  deploying it.
+
+	  This plugin was ported from grsecurity/PaX. More information at:
+	   * https://grsecurity.net/
+	   * https://pax.grsecurity.net/
+
+config STACKLEAK_TRACK_MIN_SIZE
+	int "Minimum stack frame size of functions tracked by STACKLEAK"
+	default 100
+	range 0 4096
+	depends on GCC_PLUGIN_STACKLEAK
+	help
+	  The STACKLEAK gcc plugin instruments the kernel code for tracking
+	  the lowest border of the kernel stack (and for some other purposes).
+	  It inserts the stackleak_track_stack() call for the functions with
+	  a stack frame size greater than or equal to this parameter.
+	  If unsure, leave the default value 100.
+
+config STACKLEAK_METRICS
+	bool "Show STACKLEAK metrics in the /proc file system"
+	depends on GCC_PLUGIN_STACKLEAK
+	depends on PROC_FS
+	help
+	  If this is set, STACKLEAK metrics for every task are available in
+	  the /proc file system. In particular, /proc/<pid>/stack_depth
+	  shows the maximum kernel stack consumption for the current and
+	  previous syscalls. Although this information is not precise, it
+	  can be useful for estimating the STACKLEAK performance impact for
+	  your workloads.
+
+config STACKLEAK_RUNTIME_DISABLE
+	bool "Allow runtime disabling of kernel stack erasing"
+	depends on GCC_PLUGIN_STACKLEAK
+	help
+	  This option provides 'stack_erasing' sysctl, which can be used in
+	  runtime to control kernel stack erasing for kernels built with
+	  CONFIG_GCC_PLUGIN_STACKLEAK.
+
 endmenu
 
 endmenu
-- 
2.17.1

