Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 588A9CA9EB3
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 00:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2588321D7C
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 00:49:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ehkIOPdn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407324AbfJRAtx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 20:49:53 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:37910 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726951AbfJRAtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 20:49:53 -0400
Received: by mail-il1-f196.google.com with SMTP id y5so3941400ilb.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 17:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BhNZJ/+01P0kEF6Kf+e/ysZ/4G6fTDDw4/sqJjXlOAY=;
        b=ehkIOPdn3CRMG5PytE7+4nIxgQAUmtNUHg9RLR/0iq3ceQ+LLyOya4r2zB9ZQv3rLT
         EOV6baW5GLOj4xjTpQTUcNeZg2Do0rH9/rM2eoFeq95ROtZugTPXYljg086q218p37XU
         PupD2xZ3y/8wUtdn4md7XSrO2J63hei4Qi49d6JEvzx6AV0EgK3LhO2WASmsnw6jks4K
         43ERMMOjyJISfX4oh0rL3ExTo+az5GNY6b/fiYN+fP0D1JLHXmaYglSRH1YYAI7kUt3V
         sOalfJpAWI/cKyGM6KDmaSVXDFCGebnbMVU+PT+3wE2TKqj48f/dVcUvKXtS2Qas/QBh
         9Vrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BhNZJ/+01P0kEF6Kf+e/ysZ/4G6fTDDw4/sqJjXlOAY=;
        b=IemtN8JxeLiwfImKY2EAPuBbMS+ejZ9AWUcsMsJyvR/NdrfxiXHnIGfNU1nBghCVYO
         xJkBr4E7bBPZ25SLA4AW799FDy8J7bhTAxTxecuaIaWesBhOD+bVSlf5lULIAopR/kE0
         c7vSOph0un9rZlAa1eeuTpXtnDKfTtE94YSCzvHxaDLgo2jbHJmwaHPs2DaNhDbnpCxf
         8pgE5nIIsI2MNxJlyTV/AC2WjwjgcqEUCW18VzEpZDHpcJes4opIS0VKlDdD2wg02ss/
         3gOSeND1o9XPGpuRzcrtWM7a7QdYTyp9GyhevtRa1hvZSQyUmwlQxnM/tIvSaXczL8wj
         9xrA==
X-Gm-Message-State: APjAAAX02rn014t26+/nlQulMduYntJGxRGm+2w+OGIOfmRnEAZwhcbp
        2UrhfrBnrPV/Vfg1YEVF/2PLqcPDhnw=
X-Google-Smtp-Source: APXvYqya70OHf3T73kG/NYr+Aj+62vc/dsfk6f+RNF4DoKCCuzt8IZZ4Up75ZCR68rBdX/tViOE9ew==
X-Received: by 2002:a92:c88b:: with SMTP id w11mr6675702ilo.154.1571359790821;
        Thu, 17 Oct 2019 17:49:50 -0700 (PDT)
Received: from viisi.Home ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id z20sm1493891iof.38.2019.10.17.17.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 17:49:50 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
To:     linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] riscv: add prototypes for assembly language functions from head.S
Date:   Thu, 17 Oct 2019 17:49:23 -0700
Message-Id: <20191018004929.3445-3-paul.walmsley@sifive.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191018004929.3445-1-paul.walmsley@sifive.com>
References: <20191018004929.3445-1-paul.walmsley@sifive.com>
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
index 96add1427a75..ec15a9b15448 100644
--- a/arch/riscv/mm/fault.c
+++ b/arch/riscv/mm/fault.c
@@ -18,6 +18,8 @@
 #include <asm/ptrace.h>
 #include <asm/tlbflush.h>
 
+#include "../head.h"
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

