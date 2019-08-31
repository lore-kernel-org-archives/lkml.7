Return-Path: <SRS0=k4ck=W3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80258C3A59F
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 06:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E2BD23431
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 06:08:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pKEWbtp8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbfHaGI3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 31 Aug 2019 02:08:29 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34429 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbfHaGI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Aug 2019 02:08:28 -0400
Received: by mail-wm1-f67.google.com with SMTP id y135so5769949wmc.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 23:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3NQT/+H/R/Gs9klh5utfpPtpga01Z/bPDqOTKDdobn4=;
        b=pKEWbtp87WRZkEQMPoUvMKiZmvK2H8bkjGIN+0ebQE+E197iGUHa9IAGOWKmbsMfEq
         tnOBAuY6AFPzlCfvboxOuNVBv0Ex1TGDpHIvyOdnATwBPrc7tJz7n0pv1isYTulaDwOm
         qL0dcdbhLC1bCIMwgGTg80g+FerKedCkM++fyDd6epwt4AoHlNVwyuabMeLQsWySEPzM
         tFxCP0d5W6dAAzjQaZUugV4qwX0/5N2ObXN/d/faL4BbZOAyEoErgPr/ZJonrOemhQNo
         +WnvEbXtP3BnGCBrUI7jRzAWq/sWhqoEpDu4UKykoVggVB/INMt3GTobFset8lE/TgK5
         tFEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3NQT/+H/R/Gs9klh5utfpPtpga01Z/bPDqOTKDdobn4=;
        b=Yp716rdlbGB5CjcCgF8cP+ELzpWbksIiqIhePtTeFCkofSRNROqfptzgBhx1pK5kge
         IfRHGnMwkD74IryfFo++x24Mpe7/fOwG8qJ99SAY8gR/CjWEfzCbOf4ITQAvLztdqLRQ
         3TO05NVNLGBir2w+IxEI+XhUV29Q4P3qWidjRSo1lZnAXqgPRDHS4Xhecm9QO1Tsqxmt
         u0iq5FLbxH9Yd3V+AFMVwrvezH2ZBkVwUWTgrfdKLW/2RekkzL/qgbd+Y5cozmJEzNOI
         +9EDZ+Z2V186Tz1BeHAtTXaCcMVQ+s/G2e35wicZa1k4oLgBLHpWWa0a6hAcu7VevBNH
         77YQ==
X-Gm-Message-State: APjAAAV8xOzioc85ZsBjs7SWJr5IyDrwB/sPtdFJqN67DoezWRSy0j0N
        5ViB96RJ0wBN8SXy2oPbVAs=
X-Google-Smtp-Source: APXvYqxCnZpiqqgEQocPhfIsdjxHKdW2GUjXJL3ylDacBgc2XlgpLzU3zKXXzlQi6aeNVE6uAYLCGw==
X-Received: by 2002:a1c:2b85:: with SMTP id r127mr7079242wmr.30.1567231706449;
        Fri, 30 Aug 2019 23:08:26 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:222:2f1b::2])
        by smtp.gmail.com with ESMTPSA id l62sm14708814wml.13.2019.08.30.23.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2019 23:08:25 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Russell King <linux@armlinux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH v2] ARM: Emit __gnu_mcount_nc when using Clang 10.0.0 or newer
Date:   Fri, 30 Aug 2019 23:05:31 -0700
Message-Id: <20190831060530.43082-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190829062635.45609-1-natechancellor@gmail.com>
References: <20190829062635.45609-1-natechancellor@gmail.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, multi_v7_defconfig + CONFIG_FUNCTION_TRACER fails to build
with clang:

arm-linux-gnueabi-ld: kernel/softirq.o: in function `_local_bh_enable':
softirq.c:(.text+0x504): undefined reference to `mcount'
arm-linux-gnueabi-ld: kernel/softirq.o: in function `__local_bh_enable_ip':
softirq.c:(.text+0x58c): undefined reference to `mcount'
arm-linux-gnueabi-ld: kernel/softirq.o: in function `do_softirq':
softirq.c:(.text+0x6c8): undefined reference to `mcount'
arm-linux-gnueabi-ld: kernel/softirq.o: in function `irq_enter':
softirq.c:(.text+0x75c): undefined reference to `mcount'
arm-linux-gnueabi-ld: kernel/softirq.o: in function `irq_exit':
softirq.c:(.text+0x840): undefined reference to `mcount'
arm-linux-gnueabi-ld: kernel/softirq.o:softirq.c:(.text+0xa50): more undefined references to `mcount' follow

clang can emit a working mcount symbol, __gnu_mcount_nc, when
'-meabi gnu' is passed to it. Until r369147 in LLVM, this was
broken and caused the kernel not to boot with '-pg' because the
calling convention was not correct. Always build with '-meabi gnu'
when using clang but ensure that '-pg' (which is added with
CONFIG_FUNCTION_TRACER and its prereq CONFIG_HAVE_FUNCTION_TRACER)
cannot be added with it unless this is fixed (which means using
clang 10.0.0 and newer).

Link: https://github.com/ClangBuiltLinux/linux/issues/35
Link: https://bugs.llvm.org/show_bug.cgi?id=33845
Link: https://github.com/llvm/llvm-project/commit/16fa8b09702378bacfa3d07081afe6b353b99e60
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Stefan Agner <stefan@agner.ch>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

v1 -> v2:

* Add Nick and Stefan's reviewed by tags
* Move version check from Makefile to Kconfig. This prevents '-pg` from
  ever being added if '-meabi gnu' would produce a non-booting kernel
  and it allows clang 9.0.0 and earlier to build and link all*config
  kernels because the function tracer can't be selected.

 arch/arm/Kconfig  | 2 +-
 arch/arm/Makefile | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index a98c7af50bf0..440ad41e77e4 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -83,7 +83,7 @@ config ARM
 	select HAVE_FAST_GUP if ARM_LPAE
 	select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
 	select HAVE_FUNCTION_GRAPH_TRACER if !THUMB2_KERNEL && !CC_IS_CLANG
-	select HAVE_FUNCTION_TRACER if !XIP_KERNEL
+	select HAVE_FUNCTION_TRACER if !XIP_KERNEL && (CC_IS_GCC || CLANG_VERSION >= 100000)
 	select HAVE_GCC_PLUGINS
 	select HAVE_HW_BREAKPOINT if PERF_EVENTS && (CPU_V6 || CPU_V6K || CPU_V7)
 	select HAVE_IDE if PCI || ISA || PCMCIA
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index a43fc753aa53..aa7023db66c7 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -115,6 +115,10 @@ ifeq ($(CONFIG_ARM_UNWIND),y)
 CFLAGS_ABI	+=-funwind-tables
 endif
 
+ifeq ($(CONFIG_CC_IS_CLANG),y)
+CFLAGS_ABI	+= -meabi gnu
+endif
+
 # Accept old syntax despite ".syntax unified"
 AFLAGS_NOWARN	:=$(call as-option,-Wa$(comma)-mno-warn-deprecated,-Wa$(comma)-W)
 
-- 
2.23.0

