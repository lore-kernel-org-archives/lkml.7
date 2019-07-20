Return-Path: <SRS0=8q5G=VR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9030CC76188
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 09:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66A592084D
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 09:00:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727172AbfGTI5I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jul 2019 04:57:08 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33775 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727159AbfGTI5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jul 2019 04:57:08 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1holAZ-00079f-6P; Sat, 20 Jul 2019 10:56:43 +0200
Date:   Sat, 20 Jul 2019 10:56:41 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
cc:     Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Eiichi Tsukata <devel@etsukata.com>, edwintorok@gmail.com,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH] x86/entry/64: Prevent clobbering of saved CR2 value
In-Reply-To: <alpine.DEB.2.21.1907200018050.1782@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.21.1907201020540.1782@nanos.tec.linutronix.de>
References: <20190702053151.26922-1-devel@etsukata.com> <20190702072821.GX3419@hirez.programming.kicks-ass.net> <alpine.DEB.2.21.1907021400350.1802@nanos.tec.linutronix.de> <20190702113355.5be9ebfe@gandalf.local.home> <20190702133905.1482b87e@gandalf.local.home>
 <20190719202836.GB13680@linux.intel.com> <alpine.DEB.2.21.1907200018050.1782@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The recent fix for CR2 corruption introduced a new way to reliably corrupt
the saved CR2 value.

CR2 is saved early in the entry code in RDX, which is the third argument to
the fault handling functions. But it missed that between saving and
invoking the fault handler enter_from_user_mode() can be called. RDX is a
caller saved register so the invoked function can freely clobber it with
the obvious consequences.

The TRACE_IRQS_OFF call is safe as it calls through the thunk which
preserves RDX.

Store CR2 in R12 instead which is a callee saved register and move R12 to
RDX just before calling the fault handler.

Fixes: a0d14b8909de ("x86/mm, tracing: Fix CR2 corruption")
Reported-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/entry/entry_64.S |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -875,7 +875,12 @@ apicinterrupt IRQ_WORK_VECTOR			irq_work
 	UNWIND_HINT_REGS
 
 	.if \read_cr2
-	GET_CR2_INTO(%rdx);			/* can clobber %rax */
+	/*
+	 * Store CR2 early so subsequent faults cannot clobber it. Use R12 as
+	 * intermediate storage as RDX can be clobbered in enter_from_user_mode().
+	 * GET_CR2_INTO can clobber RAX.
+	 */
+	GET_CR2_INTO(%r12);
 	.endif
 
 	.if \shift_ist != -1
@@ -904,6 +909,10 @@ apicinterrupt IRQ_WORK_VECTOR			irq_work
 	subq	$\ist_offset, CPU_TSS_IST(\shift_ist)
 	.endif
 
+	.if \read_cr2
+	movq	%r12, %rdx			/* Move CR2 into 3rd argument */
+	.endif
+
 	call	\do_sym
 
 	.if \shift_ist != -1
