Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 356F8C31E5C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 22:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07C442080A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 22:20:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="ISlv02d0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728960AbfFQWU4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 18:20:56 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38265 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728869AbfFQWUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 18:20:52 -0400
Received: by mail-ed1-f68.google.com with SMTP id r12so16236461edo.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 15:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bHWU1/zLipnGqc0n+XQPlTCaQ0Jr3fgq5cWCSnU6FTc=;
        b=ISlv02d0yZPCoT+2J5Nxfwghg9VNAKdW1cOPveYlEFmFN0PK3VpIw6u9/cGotdHLwM
         s+5o8o/Z88PFQ6JdSdrIuDkscqrnPGO7cepcHmGpzR6ea4s0pEH34ORmYCeDM6hA65uH
         JOfsH5lBMBAAB6GJAT1x7f4Gj+X28dZjrdQ/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bHWU1/zLipnGqc0n+XQPlTCaQ0Jr3fgq5cWCSnU6FTc=;
        b=WlxctSSc1f7BQ6pWsV8Ak7rmhQccuHJaFAs3aqjrEvNBpRQU61oMuvyTiU0Qc7Ua4D
         x4d1Ds1ZWaZ1BSbdnwnsom3wOio0rfTF53fBJHUSOiQQfqHPNzgGCGojEoYDjTKhJoZJ
         RNVnNvAaKlxtXFknl7tGfVKmK9lvILVkOToEwcKrSbWNpsdR3o0uEiuTL1IMCCFUE8Yw
         3rbQQjo+KcoocmG9QeOtuHr541oPC9fOCESWi2YW/XWfgsgos8A+jL30o5Sq8qVXui5c
         a4VRD4yhxvN6vp4Rvej8WPCH02BESoVcuK4QZo11rWs5880i92t/DZ7Lh6D9fdG64oTI
         XVcw==
X-Gm-Message-State: APjAAAWvWmo5OH2QqRzyJc/e66sniKipI2LzD1vum1IyHiO+MJQHMOpa
        nTWrB/ZjmG66aFpVJ7yuplLf/A==
X-Google-Smtp-Source: APXvYqx5uoIu7M+u5hodNjItt8K01vuS4nPQZd+7papwIJhGcu69sxd2RimKUtVHy8+604pZvkAR5w==
X-Received: by 2002:a50:9590:: with SMTP id w16mr100449827eda.0.1560810051277;
        Mon, 17 Jun 2019 15:20:51 -0700 (PDT)
Received: from prevas-ravi.prevas.se (ip-5-186-113-204.cgn.fibianet.dk. [5.186.113.204])
        by smtp.gmail.com with ESMTPSA id 9sm1034852ejg.49.2019.06.17.15.20.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 15:20:50 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Jason Baron <jbaron@akamai.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v6 8/8] x86-64: select HAVE_DYNAMIC_DEBUG_RELATIVE_POINTERS
Date:   Tue, 18 Jun 2019 00:20:34 +0200
Message-Id: <20190617222034.10799-9-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190617222034.10799-1-linux@rasmusvillemoes.dk>
References: <20190617222034.10799-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows reducing the size of struct _ddebug from 56 to 40
bytes. There's one such struct for each pr_debug(), netdev_debug()
etc. in a CONFIG_DYNAMIC_DEBUG kernel. An Ubuntu 4.15 kernel has about
2550 entries in the __verbose section of vmlinux, amounting to ~40K
saved. (Modules also become smaller, but it's harder to quantify how
much that yields at runtime.)

For comparison, the __bug_table section of that Ubuntu kernel is 75576
bytes, i.e. 6298 12-byte bug_entrys, so GENERIC_BUG_RELATIVE_POINTERS
saves ~50K.

Due to the build-time sanity checks in asm-generic/dynamic_debug.h, we
need to add another #undef to vclock_gettime.c.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 arch/x86/Kconfig                            | 1 +
 arch/x86/entry/vdso/vdso32/vclock_gettime.c | 1 +
 arch/x86/include/asm/Kbuild                 | 1 +
 3 files changed, 3 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 2bbbd4d1ba31..ed44ea2b9556 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -30,6 +30,7 @@ config X86_64
 	select NEED_DMA_MAP_STATE
 	select SWIOTLB
 	select ARCH_HAS_SYSCALL_WRAPPER
+	select HAVE_DYNAMIC_DEBUG_RELATIVE_POINTERS
 
 config FORCE_DYNAMIC_FTRACE
 	def_bool y
diff --git a/arch/x86/entry/vdso/vdso32/vclock_gettime.c b/arch/x86/entry/vdso/vdso32/vclock_gettime.c
index 9242b28418d5..9acec4426206 100644
--- a/arch/x86/entry/vdso/vdso32/vclock_gettime.c
+++ b/arch/x86/entry/vdso/vdso32/vclock_gettime.c
@@ -17,6 +17,7 @@
 #undef CONFIG_ILLEGAL_POINTER_VALUE
 #undef CONFIG_SPARSEMEM_VMEMMAP
 #undef CONFIG_NR_CPUS
+#undef CONFIG_DYNAMIC_DEBUG_RELATIVE_POINTERS
 
 #define CONFIG_X86_32 1
 #define CONFIG_PGTABLE_LEVELS 2
diff --git a/arch/x86/include/asm/Kbuild b/arch/x86/include/asm/Kbuild
index 8b52bc5ddf69..3b630b4d37d7 100644
--- a/arch/x86/include/asm/Kbuild
+++ b/arch/x86/include/asm/Kbuild
@@ -8,6 +8,7 @@ generated-y += unistd_64_x32.h
 generated-y += xen-hypercalls.h
 
 generic-y += dma-contiguous.h
+generic-y += dynamic_debug.h
 generic-y += early_ioremap.h
 generic-y += export.h
 generic-y += mcs_spinlock.h
-- 
2.20.1

