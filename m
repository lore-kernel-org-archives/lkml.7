Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF0AC76191
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 08:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D08121783
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 08:03:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="YWZfyVJv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389117AbfGRIDu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 04:03:50 -0400
Received: from m12-15.163.com ([220.181.12.15]:49108 "EHLO m12-15.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726386AbfGRIDt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 04:03:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=vemFgWn+I5Tiq8h8lD
        ayl3nPQQ4C47V77JdTp+lszco=; b=YWZfyVJvAZjeddrIgfuZBY5hXyNr5NNLXi
        JZehYciX3yP6fblkxRvy+JopO1o11rDN4/3up/5FkF/2AkXDM03Ux3pj7JHDNeZk
        iOG61czG5h1M7PWV6wcNGqIUzSCckunzH4HTzyamRUp5iP2o8aYmnHN9COznuHzP
        OEa6ue728=
Received: from e69c04485.et15sqa.tbsite.net (unknown [106.11.237.165])
        by smtp11 (Coremail) with SMTP id D8CowAC31zvDJzBdd5x8Fg--.42538S2;
        Thu, 18 Jul 2019 16:03:19 +0800 (CST)
From:   luferry@163.com
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-kernel@vger.kernel.org, luferry <luferry@163.com>
Subject: [PATCH v2] smp: avoid generic_exec_single cause system lockup
Date:   Thu, 18 Jul 2019 16:03:08 +0800
Message-Id: <20190718080308.48381-1-luferry@163.com>
X-Mailer: git-send-email 2.14.1.40.g8e62ba1
X-CM-TRANSID: D8CowAC31zvDJzBdd5x8Fg--.42538S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJF43urWrGrW7Xw1rtw4Dtwb_yoW5Ww43pF
        W8Cr17Cr40qa4xA3y7Jw4Sv3y5Xrs5JrWIkrs7Cr9xA3y7AFyvqFnaka1YqayFkwn2kayF
        vFZ8ZFW0v3WUAF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UieOXUUUUU=
X-Originating-IP: [106.11.237.165]
X-CM-SenderInfo: poxiv2lu16il2tof0z/xtbBZgj1WlaD2nDHZwAAse
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: luferry <luferry@163.com>

The race can reproduced by sending wait enabled IPI in softirq/irq env

src cpu only send ipi when dst cpu with queue empty, if interrupts
disturbed between llist_add and send_ipi. Interrupt handler may raise
softirq.In irq env, if src cpu try send_ipi to same dst cpu with
wait enabled. Since dst cpu's queue is not empty, src cpu won't send
ipi and dst cpu won't be waked up. src cpu will stall in
csd_lock_wait(csd). Which may cause soft lockup or hard lockup depends on
which time other cpus do send IPI to dst cpu.

So just send IPI when wait enabled and in_interrupt()

if (llist_add(&csd->llist, &per_cpu(call_single_queue, cpu)))
	// src cpu got interrupt here
     arch_send_call_function_single_ipi(cpu);

CPU0                                   CPU1

kernel env:smp_call_function         call_single_queue empty
kernel env:llist_add
                                       call_single_queue got csd
get interrupt
raise softirq
irq env:smp_call_function with wait
irq env:llist_add
irq env:queue not empty and skip send ipi
irq env:waiting for csd execution

Signed-off-by: luferry <luferry@163.com>
---
 kernel/smp.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/smp.c b/kernel/smp.c
index d155374632eb..5f5343e17bb3 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -142,9 +142,8 @@ static DEFINE_PER_CPU_SHARED_ALIGNED(call_single_data_t, csd_data);
 static int generic_exec_single(int cpu, call_single_data_t *csd,
 			       smp_call_func_t func, void *info)
 {
+	unsigned long flags;
 	if (cpu == smp_processor_id()) {
-		unsigned long flags;
-
 		/*
 		 * We can unlock early even for the synchronous on-stack case,
 		 * since we're doing this from the same CPU..
@@ -176,8 +175,10 @@ static int generic_exec_single(int cpu, call_single_data_t *csd,
 	 * locking and barrier primitives. Generic code isn't really
 	 * equipped to do the right thing...
 	 */
+	local_irq_save(flags);
 	if (llist_add(&csd->llist, &per_cpu(call_single_queue, cpu)))
 		arch_send_call_function_single_ipi(cpu);
+	local_irq_restore(flags);
 
 	return 0;
 }
@@ -404,6 +405,7 @@ EXPORT_SYMBOL_GPL(smp_call_function_any);
 void smp_call_function_many(const struct cpumask *mask,
 			    smp_call_func_t func, void *info, bool wait)
 {
+	unsigned long flags;
 	struct call_function_data *cfd;
 	int cpu, next_cpu, this_cpu = smp_processor_id();
 
@@ -446,6 +448,8 @@ void smp_call_function_many(const struct cpumask *mask,
 		return;
 
 	cpumask_clear(cfd->cpumask_ipi);
+
+	local_irq_save(flags);
 	for_each_cpu(cpu, cfd->cpumask) {
 		call_single_data_t *csd = per_cpu_ptr(cfd->csd, cpu);
 
@@ -460,6 +464,7 @@ void smp_call_function_many(const struct cpumask *mask,
 
 	/* Send a message to all CPUs in the map */
 	arch_send_call_function_ipi_mask(cfd->cpumask_ipi);
+	local_irq_restore(flags);
 
 	if (wait) {
 		for_each_cpu(cpu, cfd->cpumask) {
-- 
2.14.1.40.g8e62ba1


