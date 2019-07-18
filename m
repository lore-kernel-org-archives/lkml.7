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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96184C76191
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 04:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EC042085A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 04:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Sa2Z0P88"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbfGREGr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 00:06:47 -0400
Received: from m12-17.163.com ([220.181.12.17]:43218 "EHLO m12-17.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725976AbfGREGr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 00:06:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=knoKCX55PhQ0en+A33
        V0OQf+LqeP1gKbcJi8ENBx2k4=; b=Sa2Z0P88qtO0ECsr8F6/0hxX2ZcqqiCvSn
        /vGKlpjKhJz7cfMtBEvCmOoLabWKdE9nKtF5mee/OkStkjECsFe0bFWmBw4cpGoz
        UNz1rtysG4sY37sbfxdGP8O9krRzp+mAlz8vccbOLRwZW/0yuAvjCoRD8LhM0PCU
        tYKeXk6oA=
Received: from e69c04485.et15sqa.tbsite.net (unknown [106.11.237.24])
        by smtp13 (Coremail) with SMTP id EcCowADXNREb8C9dJVEiEA--.864S2;
        Thu, 18 Jul 2019 12:05:51 +0800 (CST)
From:   luferry@163.com
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-kernel@vger.kernel.org, luferry <luferry@163.com>
Subject: [PATCH] smp: avoid generic_exec_single cause system lockup
Date:   Thu, 18 Jul 2019 12:04:38 +0800
Message-Id: <20190718040438.62433-1-luferry@163.com>
X-Mailer: git-send-email 2.14.1.40.g8e62ba1
X-CM-TRANSID: EcCowADXNREb8C9dJVEiEA--.864S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ar4DXr1UKr13JrWUWw15Jwb_yoW8uryxpF
        W8GrnrCw4jqa4Iy3srJw4fZ3yUJw4rJrWakFs5C393Aw42qF95XF9akF4FqayF9wn29FWY
        vrs5ZFW0yw1UAr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jjPfQUUUUU=
X-Originating-IP: [106.11.237.24]
X-CM-SenderInfo: poxiv2lu16il2tof0z/xtbBax-1Wletwg-4fAAAso
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
 kernel/smp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/smp.c b/kernel/smp.c
index d155374632eb..de31a49b9fa7 100644
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
-- 
2.14.1.40.g8e62ba1


