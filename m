Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA55BCA9EA1
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 08:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92D3821D80
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 08:09:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="i2EVw/kS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2632742AbfJRIJU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 04:09:20 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:43220 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504965AbfJRIIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 04:08:53 -0400
Received: by mail-io1-f67.google.com with SMTP id v2so6351226iob.10
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 01:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XAlS+g/VLgE4rEuH3+BZzhhhkoWoqTznFAgiPaBBdkM=;
        b=i2EVw/kSrpt8aNbRp/WKPt2JviofZ7qDWXFw6l5+4dIZg0e3LUo8JQALzz+FpAgjId
         lPtkJ43DwSMl/E1obPH8aRp0BWMn0+V8T7d79ZUEknf9W2A7n00WBr+NiolV/P4/b5Nz
         Sw8g494vIO+E+58FuadPQg0OveqzWHEuRoloIs73NQZC0Y75VN4lPxhlmS+GQL+G6Tjs
         JDOaWnSuQuVqCYgvR6xiSYVuUNznmja+Miastj30Z63krqq6+3ufxhBiWMNXNc/QcVQg
         wcgiMxt37rvCegVXhPlKftfQRrhPeEDEUb0xXNI7rUvhKOTfzD/j1UClilQtf7+llVDa
         ZglQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XAlS+g/VLgE4rEuH3+BZzhhhkoWoqTznFAgiPaBBdkM=;
        b=eyJSBWzh5ybsQYqS4VVupLm7Qbh2qae2EWiGOPfIi7P6Lb4klhe5vZ0OxvPETpRrj5
         +ClzaURAkkb4mF0amrrQxhLqZFe4QM53mBdjVmiBYRuJcDGlI0P74/flZx/NFr5lg2bL
         Tlevjg8QIMEiWXsjA2QMYdl/6iL3adKDM6A27gX1F0uDKApjjITXmBSXMBc+gKNuvlgS
         rciDcMVE5pp/CYfWr2lHwpsDVpZAvPMReFWIfwT8QCEpCPVNHCxzafeLGm3uucFt+IiU
         HEMCzF4RJT13szYMyzTiwxQsEUzIEzi7NH2BgLMq6yn79guouIqsusbldCNSNzGu5kLY
         kkjg==
X-Gm-Message-State: APjAAAWE9VLd6FwwEd/QqBFmvJA4F1qmH9cuIDNiB/+kvgbLp3oP61QE
        T6Qy2car/l/2xElvYQhVJqSMK+k8Fmk=
X-Google-Smtp-Source: APXvYqz6fz9s80QCJELY/AmGNWmewV1gzmQr+Gh+lGc6atfv7x8xe/sXok18fOSlODh7AVPBpR+iew==
X-Received: by 2002:a6b:5814:: with SMTP id m20mr7405315iob.242.1571386132798;
        Fri, 18 Oct 2019 01:08:52 -0700 (PDT)
Received: from viisi.Home ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id z86sm2121026ilf.73.2019.10.18.01.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 01:08:52 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
To:     linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/8] riscv: add prototypes for assembly language functions from head.S
Date:   Fri, 18 Oct 2019 01:08:35 -0700
Message-Id: <20191018080841.26712-3-paul.walmsley@sifive.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191018080841.26712-1-paul.walmsley@sifive.com>
References: <20191018080841.26712-1-paul.walmsley@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add prototypes for assembly language functions defined in head.S,
and include these prototypes into C source files that call those
functions.

This patch resolves the following warnings from sparse:

arch/riscv/kernel/setup.c:39:10: warning: symbol 'hart_lottery' was not declared. Should it be static?
arch/riscv/kernel/setup.c:42:13: warning: symbol 'parse_dtb' was not declared. Should it be static?
arch/riscv/kernel/smpboot.c:33:6: warning: symbol '__cpu_up_stack_pointer' was not declared. Should it be static?
arch/riscv/kernel/smpboot.c:34:6: warning: symbol '__cpu_up_task_pointer' was not declared. Should it be static?
arch/riscv/kernel/smpboot.c:133:24: warning: symbol 'smp_callin' was not declared. Should it be static?
arch/riscv/mm/fault.c:25:17: warning: symbol 'do_page_fault' was not declared. Should it be static?

This change should have no functional impact.

Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
---
 arch/riscv/kernel/head.h    | 21 +++++++++++++++++++++
 arch/riscv/kernel/setup.c   |  2 ++
 arch/riscv/kernel/smpboot.c |  2 ++
 arch/riscv/mm/fault.c       |  2 ++
 arch/riscv/mm/init.c        |  2 ++
 5 files changed, 29 insertions(+)
 create mode 100644 arch/riscv/kernel/head.h

diff --git a/arch/riscv/kernel/head.h b/arch/riscv/kernel/head.h
new file mode 100644
index 000000000000..105fb0496b24
--- /dev/null
+++ b/arch/riscv/kernel/head.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2019 SiFive, Inc.
+ */
+#ifndef __ASM_HEAD_H
+#define __ASM_HEAD_H
+
+#include <linux/linkage.h>
+#include <linux/init.h>
+
+extern atomic_t hart_lottery;
+
+asmlinkage void do_page_fault(struct pt_regs *regs);
+asmlinkage void __init setup_vm(uintptr_t dtb_pa);
+
+extern void *__cpu_up_stack_pointer[];
+extern void *__cpu_up_task_pointer[];
+
+void __init parse_dtb(void);
+
+#endif /* __ASM_HEAD_H */
diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index a990a6cb184f..845ae0e12115 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -24,6 +24,8 @@
 #include <asm/tlbflush.h>
 #include <asm/thread_info.h>
 
+#include "head.h"
+
 #ifdef CONFIG_DUMMY_CONSOLE
 struct screen_info screen_info = {
 	.orig_video_lines	= 30,
diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index 18ae6da5115e..59fa59e013d4 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -30,6 +30,8 @@
 #include <asm/sections.h>
 #include <asm/sbi.h>
 
+#include "head.h"
+
 void *__cpu_up_stack_pointer[NR_CPUS];
 void *__cpu_up_task_pointer[NR_CPUS];
 static DECLARE_COMPLETION(cpu_running);
diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
index 96add1427a75..247b8c859c44 100644
--- a/arch/riscv/mm/fault.c
+++ b/arch/riscv/mm/fault.c
@@ -18,6 +18,8 @@
 #include <asm/ptrace.h>
 #include <asm/tlbflush.h>
 
+#include "../kernel/head.h"
+
 /*
  * This routine handles page faults.  It determines the address and the
  * problem, and then passes it off to one of the appropriate routines.
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 83f7d12042fb..fa8748a74414 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -19,6 +19,8 @@
 #include <asm/pgtable.h>
 #include <asm/io.h>
 
+#include "../kernel/head.h"
+
 unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)]
 							__page_aligned_bss;
 EXPORT_SYMBOL(empty_zero_page);
-- 
2.23.0

