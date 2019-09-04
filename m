Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBB53C3A5A9
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 19:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8153A21883
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 19:54:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="RYqZnuhm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730501AbfIDTyq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 15:54:46 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:38581 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730462AbfIDTyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 15:54:45 -0400
Received: by mail-io1-f66.google.com with SMTP id p12so47087146iog.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 12:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=LlDPSpEczR5fvkibAFO5ZZRZGBz+aXPzFC2kng0jziw=;
        b=RYqZnuhmNd8oj1G0LxozGHsQy7uyZPoCcXks41skJkE6cUhOrz6IA7RM3coDs9YY05
         nA6wLO6qI9srj92LTt2ZoUrtqth9FgzHW9mb/upxz+3wZg0PkuAtPVdkv0onzzfw/VDw
         iAKVu/Di2b1tKS0xVYBDyXKUv4v+8zZ2AGXe2oq2WsLPcYAquOvym+ukXcxfPqIzSqGK
         cwlRoP4G/i9qLyy1nnmLRnalI2hZa6yVWUtdgNHye7rjhc4zB6UvGKf8rkW+BeoeSm83
         OiRgaY3CgbLZ4bXOMhed4XLCeh1qzMrGKQs6bduFDlVUMz1F3umjWCRrmCT1B07/zGsW
         +adA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=LlDPSpEczR5fvkibAFO5ZZRZGBz+aXPzFC2kng0jziw=;
        b=DuWJkPwxMZZ04gjJQPqdaJQ3WN7QqG2x1Lpgb+lw3hKmCq1c2DAPtuNkU1/OK+R58M
         HmeOmBvizst626bpDvRhbAk3LH3FAwbOFsW06Z4dyT5UMFX7lst06WkHYBA8lMyLLCeR
         0KrprsDY4Sf6jrKM89H9YzEFPpEJzsKUtQFmYKlEXonmclB7adSLEhwD4CJdna519kkR
         4Aj1vpqV8El9+6Y+dzp2tLCnsSp2uFQqSSYdLH6kgXaOv8HJCJNGlXPbTB3Ugi6oCuMS
         hUEqEXwDq9cheZTs0LZglkA+2Eobl8TR0urvIk2fySwJO0Gph82Kk/zwFHSG6hsKsP0H
         mV3Q==
X-Gm-Message-State: APjAAAWtXU8Jme4mD24fcZf0TIdH4ORd8o5mppe8N/fasS028UMI5MvW
        sMTZbW/sYp0NE9q1+DgwrMiPaA==
X-Google-Smtp-Source: APXvYqwSihk3BoH49liqRzwu0WHQ8cc9wMxBVqQG42DA+3Yj0C4NpZ/zeFIWqjtZU0o3VDjaryxLUQ==
X-Received: by 2002:a02:cf10:: with SMTP id q16mr533015jar.89.1567626882839;
        Wed, 04 Sep 2019 12:54:42 -0700 (PDT)
Received: from localhost (75-161-11-128.albq.qwest.net. [75.161.11.128])
        by smtp.gmail.com with ESMTPSA id q74sm35036563iod.72.2019.09.04.12.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2019 12:54:42 -0700 (PDT)
Date:   Wed, 4 Sep 2019 12:54:41 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Mao Han <han_mao@c-sky.com>
cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, Greentime Hu <green.hu@gmail.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Christoph Hellwig <hch@lst.de>, Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH V6 1/3] riscv: Add perf callchain support
In-Reply-To: <86d18d80affc39cf9579a24f1beb7c8631cfa9bd.1567060834.git.han_mao@c-sky.com>
Message-ID: <alpine.DEB.2.21.9999.1909041247560.13502@viisi.sifive.com>
References: <cover.1567060834.git.han_mao@c-sky.com> <86d18d80affc39cf9579a24f1beb7c8631cfa9bd.1567060834.git.han_mao@c-sky.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mao Han,

On Thu, 29 Aug 2019, Mao Han wrote:

> This patch add support for perf callchain sampling on riscv platform.
> The return address of leaf function is retrieved from pt_regs as
> it is not saved in the outmost frame.
> 
> Signed-off-by: Mao Han <han_mao@c-sky.com>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Greentime Hu <green.hu@gmail.com>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: linux-riscv <linux-riscv@lists.infradead.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Guo Ren <guoren@kernel.org>

There are some 'checkpatch.pl --strict' warnings with this patch (below).  
These have been fixed here.  The following patch has been queued for 
v5.4-rc1 with Greentime's Tested-by:.  Thanks for your hard work following 
up on the feedback with these patches -


- Paul


CHECK: Alignment should match open parenthesis
#77: FILE: arch/riscv/kernel/perf_callchain.c:18:
+static unsigned long user_backtrace(struct perf_callchain_entry_ctx 
*entry,
+			unsigned long fp, unsigned long reg_ra)

CHECK: Blank lines aren't necessary after an open brace '{'
#146: FILE: arch/riscv/kernel/perf_callchain.c:87:
+{
+

CHECK: Alignment should match open parenthesis
#165: FILE: arch/riscv/kernel/stacktrace.c:23:
+void notrace walk_stackframe(struct task_struct *task,
 	struct pt_regs *regs, bool (*fn)(unsigned long, void *), void *arg)

------

From: Mao Han <han_mao@c-sky.com>
Date: Thu, 29 Aug 2019 14:57:00 +0800
Subject: [PATCH] riscv: Add perf callchain support

This patch adds support for perf callchain sampling on riscv platforms.
The return address of leaf function is retrieved from pt_regs as
it is not saved in the outmost frame.

Signed-off-by: Mao Han <han_mao@c-sky.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Greentime Hu <green.hu@gmail.com>
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: linux-riscv <linux-riscv@lists.infradead.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Guo Ren <guoren@kernel.org>
Tested-by: Greentime Hu <greentime.hu@sifive.com>
[paul.walmsley@sifive.com: fixed some 'checkpatch.pl --strict' issues;
 fixed patch description spelling]
Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
---
 arch/riscv/Makefile                |  3 +
 arch/riscv/kernel/Makefile         |  3 +-
 arch/riscv/kernel/perf_callchain.c | 94 ++++++++++++++++++++++++++++++
 arch/riscv/kernel/stacktrace.c     |  4 +-
 4 files changed, 101 insertions(+), 3 deletions(-)
 create mode 100644 arch/riscv/kernel/perf_callchain.c

diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index a73659e30f8d..4f0a3d2018d2 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -54,6 +54,9 @@ endif
 ifeq ($(CONFIG_MODULE_SECTIONS),y)
 	KBUILD_LDFLAGS_MODULE += -T $(srctree)/arch/riscv/kernel/module.lds
 endif
+ifeq ($(CONFIG_PERF_EVENTS),y)
+        KBUILD_CFLAGS += -fno-omit-frame-pointer
+endif
 
 KBUILD_CFLAGS_MODULE += $(call cc-option,-mno-relax)
 
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index 2420d37d96de..b1bea89fc814 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -38,6 +38,7 @@ obj-$(CONFIG_MODULE_SECTIONS)	+= module-sections.o
 obj-$(CONFIG_FUNCTION_TRACER)	+= mcount.o ftrace.o
 obj-$(CONFIG_DYNAMIC_FTRACE)	+= mcount-dyn.o
 
-obj-$(CONFIG_PERF_EVENTS)      += perf_event.o
+obj-$(CONFIG_PERF_EVENTS)	+= perf_event.o
+obj-$(CONFIG_PERF_EVENTS)	+= perf_callchain.o
 
 clean:
diff --git a/arch/riscv/kernel/perf_callchain.c b/arch/riscv/kernel/perf_callchain.c
new file mode 100644
index 000000000000..8d2804f05cf9
--- /dev/null
+++ b/arch/riscv/kernel/perf_callchain.c
@@ -0,0 +1,94 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2019 Hangzhou C-SKY Microsystems co.,ltd. */
+
+#include <linux/perf_event.h>
+#include <linux/uaccess.h>
+
+/* Kernel callchain */
+struct stackframe {
+	unsigned long fp;
+	unsigned long ra;
+};
+
+/*
+ * Get the return address for a single stackframe and return a pointer to the
+ * next frame tail.
+ */
+static unsigned long user_backtrace(struct perf_callchain_entry_ctx *entry,
+				    unsigned long fp, unsigned long reg_ra)
+{
+	struct stackframe buftail;
+	unsigned long ra = 0;
+	unsigned long *user_frame_tail =
+			(unsigned long *)(fp - sizeof(struct stackframe));
+
+	/* Check accessibility of one struct frame_tail beyond */
+	if (!access_ok(user_frame_tail, sizeof(buftail)))
+		return 0;
+	if (__copy_from_user_inatomic(&buftail, user_frame_tail,
+				      sizeof(buftail)))
+		return 0;
+
+	if (reg_ra != 0)
+		ra = reg_ra;
+	else
+		ra = buftail.ra;
+
+	fp = buftail.fp;
+	if (ra != 0)
+		perf_callchain_store(entry, ra);
+	else
+		return 0;
+
+	return fp;
+}
+
+/*
+ * This will be called when the target is in user mode
+ * This function will only be called when we use
+ * "PERF_SAMPLE_CALLCHAIN" in
+ * kernel/events/core.c:perf_prepare_sample()
+ *
+ * How to trigger perf_callchain_[user/kernel] :
+ * $ perf record -e cpu-clock --call-graph fp ./program
+ * $ perf report --call-graph
+ *
+ * On RISC-V platform, the program being sampled and the C library
+ * need to be compiled with -fno-omit-frame-pointer, otherwise
+ * the user stack will not contain function frame.
+ */
+void perf_callchain_user(struct perf_callchain_entry_ctx *entry,
+			 struct pt_regs *regs)
+{
+	unsigned long fp = 0;
+
+	/* RISC-V does not support perf in guest mode. */
+	if (perf_guest_cbs && perf_guest_cbs->is_in_guest())
+		return;
+
+	fp = regs->s0;
+	perf_callchain_store(entry, regs->sepc);
+
+	fp = user_backtrace(entry, fp, regs->ra);
+	while (fp && !(fp & 0x3) && entry->nr < entry->max_stack)
+		fp = user_backtrace(entry, fp, 0);
+}
+
+bool fill_callchain(unsigned long pc, void *entry)
+{
+	return perf_callchain_store(entry, pc);
+}
+
+void notrace walk_stackframe(struct task_struct *task,
+	struct pt_regs *regs, bool (*fn)(unsigned long, void *), void *arg);
+void perf_callchain_kernel(struct perf_callchain_entry_ctx *entry,
+			   struct pt_regs *regs)
+{
+	/* RISC-V does not support perf in guest mode. */
+	if (perf_guest_cbs && perf_guest_cbs->is_in_guest()) {
+		pr_warn("RISC-V does not support perf in guest mode!");
+		return;
+	}
+
+	walk_stackframe(NULL, regs, fill_callchain, entry);
+}
diff --git a/arch/riscv/kernel/stacktrace.c b/arch/riscv/kernel/stacktrace.c
index f15642715d1a..0940681d2f68 100644
--- a/arch/riscv/kernel/stacktrace.c
+++ b/arch/riscv/kernel/stacktrace.c
@@ -19,8 +19,8 @@ struct stackframe {
 	unsigned long ra;
 };
 
-static void notrace walk_stackframe(struct task_struct *task,
-	struct pt_regs *regs, bool (*fn)(unsigned long, void *), void *arg)
+void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs,
+			     bool (*fn)(unsigned long, void *), void *arg)
 {
 	unsigned long fp, sp, pc;
 
-- 
2.23.0

