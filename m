Return-Path: <SRS0=8q5G=VR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4110EC76188
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 12:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1691B21872
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 12:52:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728347AbfGTMwN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jul 2019 08:52:13 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34321 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728331AbfGTMwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jul 2019 08:52:13 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hooqR-0005Ql-Qz; Sat, 20 Jul 2019 14:52:11 +0200
Date:   Sat, 20 Jul 2019 12:50:00 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] smp/urgent for 5.3-rc1
References: <156362700018.18624.18097992605540415098.tglx@nanos.tec.linutronix.de>
Message-ID: <156362700019.18624.17617457563286881221.tglx@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest smp-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp-urgent-for-linus

up to:  19dbdcb8039c: smp: Warn on function calls from softirq context

Add warnings to the smp function calls so callers from wrong contexts get
detected.

Thanks,

	tglx

------------------>
Peter Zijlstra (1):
      smp: Warn on function calls from softirq context


 kernel/smp.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/kernel/smp.c b/kernel/smp.c
index 616d4d114847..7dbcb402c2fc 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -291,6 +291,14 @@ int smp_call_function_single(int cpu, smp_call_func_t func, void *info,
 	WARN_ON_ONCE(cpu_online(this_cpu) && irqs_disabled()
 		     && !oops_in_progress);
 
+	/*
+	 * When @wait we can deadlock when we interrupt between llist_add() and
+	 * arch_send_call_function_ipi*(); when !@wait we can deadlock due to
+	 * csd_lock() on because the interrupt context uses the same csd
+	 * storage.
+	 */
+	WARN_ON_ONCE(!in_task());
+
 	csd = &csd_stack;
 	if (!wait) {
 		csd = this_cpu_ptr(&csd_data);
@@ -416,6 +424,14 @@ void smp_call_function_many(const struct cpumask *mask,
 	WARN_ON_ONCE(cpu_online(this_cpu) && irqs_disabled()
 		     && !oops_in_progress && !early_boot_irqs_disabled);
 
+	/*
+	 * When @wait we can deadlock when we interrupt between llist_add() and
+	 * arch_send_call_function_ipi*(); when !@wait we can deadlock due to
+	 * csd_lock() on because the interrupt context uses the same csd
+	 * storage.
+	 */
+	WARN_ON_ONCE(!in_task());
+
 	/* Try to fastpath.  So, what's a CPU they want? Ignoring this one. */
 	cpu = cpumask_first_and(mask, cpu_online_mask);
 	if (cpu == this_cpu)

