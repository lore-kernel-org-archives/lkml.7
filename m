Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E6CC10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D4B620830
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:16:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HAfcWkyY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387736AbfDJQQY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 12:16:24 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37361 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387714AbfDJQQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 12:16:21 -0400
Received: by mail-pl1-f194.google.com with SMTP id w23so1717262ply.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 09:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jOAlchro4PEoZdHvDj8sDe2jZk8Rf4hGGmuG3/k8DZI=;
        b=HAfcWkyYnc857BWbNNM4BRW0N+qz3JI7ozhNlOdbNjd4G7S4dwz0UdeBP8T37u5h15
         gcTXjFAyGLZBl5LBFVhdMuSCGTKvGUgFp23zAALiOZhmZ5Q0FaPxxaEIPNdH0e8AV8tH
         i36LqZeW0ec2+NTkk2DDkw63a1ANIP6JLqaqU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jOAlchro4PEoZdHvDj8sDe2jZk8Rf4hGGmuG3/k8DZI=;
        b=XZlqFsWzFWI0MzGlYDuWOcVc4B+UaCHCj04nU3VDBBhwCvPE9JuYesBc35HNM1MPMr
         C1VaCx5UcMqno6G+1a/gi7DjOOMTeLf9u41KXea+iXI7GzNti9UyzBPNAQo+GpVvxh8r
         FYb+SR9Pmbo3hDIGANqx6E5tqNdzOpWxa8k5YrtJ/4ANOG1ctgllOdBeAQ6qKqF3droP
         XxGeUbrk1cAs0xbLXz8xRnDLwERD8xn0Gzh8JZYbjZvpUTnOjSLTSaXUk3nEzBXycgFQ
         ByuS8guwsIfdHQsITiBRP2LYA7W0HSe57CpVmQTLKipqKw+ZFTBM2aSOU0WZBEiMxslY
         pBtw==
X-Gm-Message-State: APjAAAVWeK3f6pWxHoWT8vCrNFHtXkIRMzg5gxU4xDi6Y4KHHcgwGgEt
        rb/QvdKaQ0ikiB3mUIoG4MZUcw==
X-Google-Smtp-Source: APXvYqzbZIWrtM83HY1hK84i8J68//7D3HvDn0on6ILWordOt/oR+/1TsM9Q03wKk/bxFMwxYyoR0g==
X-Received: by 2002:a17:902:31a4:: with SMTP id x33mr45065265plb.24.1554912980506;
        Wed, 10 Apr 2019 09:16:20 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id r76sm38658632pfa.39.2019.04.10.09.16.17
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
Subject: [PATCH 2/3] kbuild: Move stackleak config to Kconfig.hardening
Date:   Wed, 10 Apr 2019 09:16:11 -0700
Message-Id: <20190410161612.18545-3-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190410161612.18545-1-keescook@chromium.org>
References: <20190410161612.18545-1-keescook@chromium.org>
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
index 01874ef0f883..50cfcf1ed979 100644
--- a/scripts/gcc-plugins/Kconfig
+++ b/scripts/gcc-plugins/Kconfig
@@ -107,57 +107,6 @@ config GCC_PLUGIN_RANDSTRUCT_PERFORMANCE
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
index 8223a8ab1a12..9942d9869864 100644
--- a/security/Kconfig.hardening
+++ b/security/Kconfig.hardening
@@ -89,6 +89,63 @@ config GCC_PLUGIN_STRUCTLEAK_VERBOSE
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

