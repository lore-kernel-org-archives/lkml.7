Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C593C282DA
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 21:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 659F420883
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 21:26:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="Shkioco4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbfDIV02 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 17:26:28 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33209 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbfDIV0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 17:26:00 -0400
Received: by mail-ed1-f68.google.com with SMTP id b8so157491edq.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 14:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DygVSYvz5m9dBESggmimXQQjt5Z2HpKNF+jJeVcx8s4=;
        b=Shkioco4nRNSQGoqnv1xPT+0jyWUqUrxnxqFWT3McBDB/hhaNrNZgSyZtga/puxnA4
         EThn5XeJk4gdke5kScjjpxUxIiKEdJFGVQH4Utb9/1PmGLK9SURM9TmOax9DE5/pxXJ3
         E0+uFuCQawAJic9FBQBV4hpebacv5aUAB0kkA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DygVSYvz5m9dBESggmimXQQjt5Z2HpKNF+jJeVcx8s4=;
        b=j07jkdFxbT9tjmATpb/Lz0FMdar6FoJZ+UWda+PlSTcn/HmuQs9i2dY0av0K41gNX+
         dLnmylIcaq2JV3lxf3eNEWLJcF/0Cx2Xnrmz7hWMcl+7kSw6Qo7bHmy2duH3aZRGkd66
         8f11kITq83o9PDzuZw3f8PFCYlatPvwtR6zjLsjtXwDij/FZPEzewbYYFZIRGpamfe3G
         Aece6y3DLYFKDuKN/rwy9S3UEiL1XLfRyxM/vjiLNpXgsmJKM7oOwIkp4DRgZnkzWcRq
         PMkO1iexx8lmf5vgGh+22Um84gFpl14W3k6DWnREybJP5ZuENU+hbVgUf/ME/K/ghN/t
         HkEw==
X-Gm-Message-State: APjAAAXKq8jfSgxszdUWdD4WtVfSw1LGXKHs2Azyp0rfKNlvxolTNCZd
        Pyh7LsxOBYG4btZG2Duoa+2hpQ==
X-Google-Smtp-Source: APXvYqxMXLNQ6m8619zE/aD4JCrgkV4BHS2akXq5Xg4GirgGVVplxWTH8V1SEafgLh12YaWasiqNPA==
X-Received: by 2002:aa7:c88b:: with SMTP id p11mr17373736eds.79.1554845158624;
        Tue, 09 Apr 2019 14:25:58 -0700 (PDT)
Received: from prevas-ravi.prevas.se (ip-5-186-118-63.cgn.fibianet.dk. [5.186.118.63])
        by smtp.gmail.com with ESMTPSA id i26sm3477986ejc.51.2019.04.09.14.25.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 14:25:58 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org
Cc:     Jason Baron <jbaron@akamai.com>, linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Ingo Molnar <mingo@redhat.com>
Subject: [PATCH 08/10] x86-64: select DYNAMIC_DEBUG_RELATIVE_POINTERS
Date:   Tue,  9 Apr 2019 23:25:15 +0200
Message-Id: <20190409212517.7321-9-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190409212517.7321-1-linux@rasmusvillemoes.dk>
References: <20190409212517.7321-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reduces the size of struct _ddebug from 56 to 40 bytes. There's
one such struct for each pr_debug(), netdev_debug() etc. in a
CONFIG_DYNAMIC_DEBUG kernel. An Ubuntu 4.15 kernel has about 2550
entries in the __verbose section of vmlinux, amounting to ~40K
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
index 5ad92419be19..eb5488b4577d 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -30,6 +30,7 @@ config X86_64
 	select SWIOTLB
 	select X86_DEV_DMA_OPS
 	select ARCH_HAS_SYSCALL_WRAPPER
+	select DYNAMIC_DEBUG_RELATIVE_POINTERS
 
 #
 # Arch settings
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
index a0ab9ab61c75..793d2c6735b9 100644
--- a/arch/x86/include/asm/Kbuild
+++ b/arch/x86/include/asm/Kbuild
@@ -7,6 +7,7 @@ generated-y += unistd_64_x32.h
 generated-y += xen-hypercalls.h
 
 generic-y += dma-contiguous.h
+generic-y += dynamic_debug.h
 generic-y += early_ioremap.h
 generic-y += export.h
 generic-y += mcs_spinlock.h
-- 
2.20.1

