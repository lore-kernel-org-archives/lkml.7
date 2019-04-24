Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5C4CC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3A4A21903
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556127440;
	bh=SXN5ALCi7pHmuheWQdGmIOtPGRWc5TDENC2iqp2pl+c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=psNgHd1xOIZuXOvnK9VKTfsAFNWXpQ4xn1CN9eaGRSDa1zCz8Gj5tl0d/6+LB5mGi
	 bS7uZ0+x9LYC+Evcn7JGzmV9ak0FaHiXfDKKfn7rKFVEzPQRpWEbmHe2MGhzkKHRqw
	 Q1DV1ga72cOpM3MB2+bAwauHIiCAmqPTLJ8WxUlA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392062AbfDXRhT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:37:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:36108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403957AbfDXRhN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:37:13 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6992A21904;
        Wed, 24 Apr 2019 17:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556127432;
        bh=SXN5ALCi7pHmuheWQdGmIOtPGRWc5TDENC2iqp2pl+c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=alGDKeyvNyYFLopLSgGrVLaU03KSCerNX0xCjbgcNv5/OoYoE2DNtvf0EH4iIr/c6
         2QkdZH3S8pak9H2rMVNtqwcldSJecGtpDE9MAPk/y3NYcLF6KEfEGQTI7tWzAlFywy
         5M35B9B34nb53/v7/nGG4nCX++zYsEwAkPHS/2X0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrea Righi <righi.andrea@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 5.0 089/115] x86/kprobes: Avoid kretprobe recursion bug
Date:   Wed, 24 Apr 2019 19:10:25 +0200
Message-Id: <20190424170930.080148720@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170924.797924502@linuxfoundation.org>
References: <20190424170924.797924502@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

commit b191fa96ea6dc00d331dcc28c1f7db5e075693a0 upstream.

Avoid kretprobe recursion loop bg by setting a dummy
kprobes to current_kprobe per-CPU variable.

This bug has been introduced with the asm-coded trampoline
code, since previously it used another kprobe for hooking
the function return placeholder (which only has a nop) and
trampoline handler was called from that kprobe.

This revives the old lost kprobe again.

With this fix, we don't see deadlock anymore.

And you can see that all inner-called kretprobe are skipped.

  event_1                                  235               0
  event_2                                19375           19612

The 1st column is recorded count and the 2nd is missed count.
Above shows (event_1 rec) + (event_2 rec) ~= (event_2 missed)
(some difference are here because the counter is racy)

Reported-by: Andrea Righi <righi.andrea@gmail.com>
Tested-by: Andrea Righi <righi.andrea@gmail.com>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Acked-by: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Fixes: c9becf58d935 ("[PATCH] kretprobe: kretprobe-booster")
Link: http://lkml.kernel.org/r/155094064889.6137.972160690963039.stgit@devbox
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/kprobes/core.c |   22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -749,11 +749,16 @@ asm(
 NOKPROBE_SYMBOL(kretprobe_trampoline);
 STACK_FRAME_NON_STANDARD(kretprobe_trampoline);
 
+static struct kprobe kretprobe_kprobe = {
+	.addr = (void *)kretprobe_trampoline,
+};
+
 /*
  * Called from kretprobe_trampoline
  */
 static __used void *trampoline_handler(struct pt_regs *regs)
 {
+	struct kprobe_ctlblk *kcb;
 	struct kretprobe_instance *ri = NULL;
 	struct hlist_head *head, empty_rp;
 	struct hlist_node *tmp;
@@ -763,6 +768,17 @@ static __used void *trampoline_handler(s
 	void *frame_pointer;
 	bool skipped = false;
 
+	preempt_disable();
+
+	/*
+	 * Set a dummy kprobe for avoiding kretprobe recursion.
+	 * Since kretprobe never run in kprobe handler, kprobe must not
+	 * be running at this point.
+	 */
+	kcb = get_kprobe_ctlblk();
+	__this_cpu_write(current_kprobe, &kretprobe_kprobe);
+	kcb->kprobe_status = KPROBE_HIT_ACTIVE;
+
 	INIT_HLIST_HEAD(&empty_rp);
 	kretprobe_hash_lock(current, &head, &flags);
 	/* fixup registers */
@@ -838,10 +854,9 @@ static __used void *trampoline_handler(s
 		orig_ret_address = (unsigned long)ri->ret_addr;
 		if (ri->rp && ri->rp->handler) {
 			__this_cpu_write(current_kprobe, &ri->rp->kp);
-			get_kprobe_ctlblk()->kprobe_status = KPROBE_HIT_ACTIVE;
 			ri->ret_addr = correct_ret_addr;
 			ri->rp->handler(ri, regs);
-			__this_cpu_write(current_kprobe, NULL);
+			__this_cpu_write(current_kprobe, &kretprobe_kprobe);
 		}
 
 		recycle_rp_inst(ri, &empty_rp);
@@ -857,6 +872,9 @@ static __used void *trampoline_handler(s
 
 	kretprobe_hash_unlock(current, &flags);
 
+	__this_cpu_write(current_kprobe, NULL);
+	preempt_enable();
+
 	hlist_for_each_entry_safe(ri, tmp, &empty_rp, hlist) {
 		hlist_del(&ri->hlist);
 		kfree(ri);


