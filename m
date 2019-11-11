Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A6EC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 14:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDBEA21783
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 14:47:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aynPu28s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbfKKOrS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 09:47:18 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48648 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727334AbfKKOrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 09:47:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=KJGs8SxkcPD2SAGIWx8b4wB5ck5tD95hTOnR4IN4KSU=; b=aynPu28scJhQ5dq1+bGw/lDjD8
        xwnPoVAnwhvqhVSXu9V6fv8Gye68gsqsKpSmJ2f+CseF88mtVtRSaQrdyL7NudcTZFI13xiZzdcaT
        Ra0r+B+Z+RmPwYboOdtsFfkz/sEmsUrm65lcduNlmOCh4WLSGa1BKqvWlXBLxG8zRwPwmlG+Oguvq
        rnKBz4UDyKSehTndx+ai2JJge5jeW9Md6epTMDCGJeXVDb0TqfH/kqCvK/lMsKh+kYow5WDrjYv13
        QhEcTT9eZI9+uw2ZFvmjhwBjg1G4j9yuoiq1ZtGbD/lP2hkAwF1mEmUqZPYurDEim8zs6Xj6fBnLK
        pJ4dHWpw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iUAyB-0006a9-OR; Mon, 11 Nov 2019 14:47:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 30CAD3072BB;
        Mon, 11 Nov 2019 15:45:58 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id ADD9F29A37A93; Mon, 11 Nov 2019 15:47:03 +0100 (CET)
Message-Id: <20191111132458.401696663@infradead.org>
User-Agent: quilt/0.65
Date:   Mon, 11 Nov 2019 14:13:08 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, bristot@redhat.com,
        jbaron@akamai.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, mingo@kernel.org, namit@vmware.com,
        hpa@zytor.com, luto@kernel.org, ard.biesheuvel@linaro.org,
        jpoimboe@redhat.com, jeyu@kernel.org, alexei.starovoitov@gmail.com
Subject: [PATCH -v5 16/17] x86/kprobe: Add comments to arch_{,un}optimize_kprobes()
References: <20191111131252.921588318@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a few words describing how it is safe to overwrite the 4 bytes
after a kprobe. In specific it is possible the JMP.d32 required for
the optimized kprobe overwrites multiple instructions.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/kprobes/opt.c |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

--- a/arch/x86/kernel/kprobes/opt.c
+++ b/arch/x86/kernel/kprobes/opt.c
@@ -414,8 +414,12 @@ int arch_prepare_optimized_kprobe(struct
 }
 
 /*
- * Replace breakpoints (int3) with relative jumps.
+ * Replace breakpoints (INT3) with relative jumps (JMP.d32).
  * Caller must call with locking kprobe_mutex and text_mutex.
+ *
+ * The caller will have installed a regular kprobe and after that issued
+ * syncrhonize_rcu_tasks(), this ensures that the instruction(s) that live in
+ * the 4 bytes after the INT3 are unused and can now be overwritten.
  */
 void arch_optimize_kprobes(struct list_head *oplist)
 {
@@ -441,7 +445,13 @@ void arch_optimize_kprobes(struct list_h
 	}
 }
 
-/* Replace a relative jump with a breakpoint (int3).  */
+/*
+ * Replace a relative jump (JMP.d32) with a breakpoint (INT3).
+ *
+ * After that, we can restore the 4 bytes after the INT3 to undo what
+ * arch_optimize_kprobes() scribbled. This is safe since those bytes will be
+ * unused once the INT3 lands.
+ */
 void arch_unoptimize_kprobe(struct optimized_kprobe *op)
 {
 	arch_arm_kprobe(&op->kp);


