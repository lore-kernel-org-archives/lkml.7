Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 634FBC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36C282082C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:42:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728623AbfDCQmm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 12:42:42 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:42033 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728413AbfDCQmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 12:42:39 -0400
Received: from localhost ([127.0.0.1] helo=flow.W.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hBiy9-0004GO-9U; Wed, 03 Apr 2019 18:42:33 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 26/27] x86/fpu: Restore FPU register in copy_fpstate_to_sigframe() in order to use the fastpath
Date:   Wed,  3 Apr 2019 18:41:55 +0200
Message-Id: <20190403164156.19645-27-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190403164156.19645-1-bigeasy@linutronix.de>
References: <20190403164156.19645-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a task is scheduled out and receives a signal then it won't be able to take
the fastpath because the register aren't available. The slowpath is more
expensive compared to xrstor + xsave which usually succeeds.

Some clock_gettime() numbers from a bigger box with AVX512 during bootup:
- __fpregs_load_activate() takes 140ns - 350ns. If it was the most recent FPU
  context on the CPU then the optimisation in __fpregs_load_activate() will
  skip the load (which was disabled during the test).

- copy_fpregs_to_sigframe() takes 200ns - 450ns if it succeeds. On a
  pagefault it is 1.8us - 3us usually in the 2.6us area.

- The slowpath takes 1.5 - 6us. Usually in the 2.6us area.

My testcases (including lat_sig) take the fastpath without
__fpregs_load_activate(). I expect this to be the majority.

Since the slowpath is in the >1us area it makes sense to load the
registers and attempt to save them directly. The direct save may fail
but should only happen on the first invocation or after fork() while the
page is RO.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/x86/kernel/fpu/signal.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index baf1588d7060c..16f700d5b3a47 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -176,19 +176,20 @@ int copy_fpstate_to_sigframe(void __user *buf, void __user *buf_fx, int size)
 
 	fpregs_lock();
 	/*
-	 * If we do not need to load the FPU registers at return to userspace
-	 * then the CPU has the current state. Try to save it directly to
-	 * userland's stack frame if it does not cause a pagefault. If it does,
-	 * try the slowpath.
+	 * Load the FPU register if they are not valid for the current task.
+	 * With a valid FPU state we can attempt to save the state directly to
+	 * userland's stack frame which will likely succeed. If it does not, do
+	 * the slowpath.
 	 */
-	if (!test_thread_flag(TIF_NEED_FPU_LOAD)) {
-		pagefault_disable();
-		ret = copy_fpregs_to_sigframe(buf_fx);
-		pagefault_enable();
-		if (ret)
-			copy_fpregs_to_fpstate(fpu);
-		set_thread_flag(TIF_NEED_FPU_LOAD);
-	}
+	if (test_thread_flag(TIF_NEED_FPU_LOAD))
+		__fpregs_load_activate();
+
+	pagefault_disable();
+	ret = copy_fpregs_to_sigframe(buf_fx);
+	pagefault_enable();
+	if (ret && !test_thread_flag(TIF_NEED_FPU_LOAD))
+		copy_fpregs_to_fpstate(fpu);
+	set_thread_flag(TIF_NEED_FPU_LOAD);
 	fpregs_unlock();
 
 	if (ret) {
-- 
2.20.1

