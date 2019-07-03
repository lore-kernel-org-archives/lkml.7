Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C51C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 10:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9A5A218A0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 10:04:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbfGCKEL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 06:04:11 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:50257 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbfGCKEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 06:04:11 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <rcz@pengutronix.de>)
        id 1hic7V-0008LN-6F; Wed, 03 Jul 2019 12:04:09 +0200
Received: from rcz by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <rcz@pengutronix.de>)
        id 1hic7U-0003NM-QN; Wed, 03 Jul 2019 12:04:08 +0200
From:   Rouven Czerwinski <r.czerwinski@pengutronix.de>
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     linux-kernel@vger.kernel.org, tee-dev@lists.linaro.org,
        Rouven Czerwinski <r.czerwinski@pengutronix.de>
Subject: [PATCH] tee: optee: add might_sleep for RPC requests
Date:   Wed,  3 Jul 2019 12:03:50 +0200
Message-Id: <20190703100349.12893-1-r.czerwinski@pengutronix.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: rcz@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the kernel is compiled with CONFIG_PREEMPT_VOLUNTARY and OP-TEE is
executing a long running workload, the following errors are raised:

[ 1705.971228] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
[ 1705.977195] rcu:     (detected by 0, t=2102 jiffies, g=51977, q=3)
[ 1705.983152] rcu: All QSes seen, last rcu_sched kthread activity 2102 (140596-138494), jiffies_till_next_fqs=1, root ->qsmask 0x0
[ 1705.994729] optee-xtest     R  running task        0   169    157 0x00000002

While OP-TEE is returning regulary to the kernel due to timer
interrrupts, the OPTEE_SMC_FUNC_FOREIGN_INTR case does not contain an
explicit rescheduling point. Add a might_sleep() to the RPC request case
to ensure that the kernel can reschedule another task if OP-TEE requests
RPC handling.

Signed-off-by: Rouven Czerwinski <r.czerwinski@pengutronix.de>
---
 drivers/tee/optee/call.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
index aa942703ae65..13b0269a0abc 100644
--- a/drivers/tee/optee/call.c
+++ b/drivers/tee/optee/call.c
@@ -148,6 +148,7 @@ u32 optee_do_call_with_arg(struct tee_context *ctx, phys_addr_t parg)
 			 */
 			optee_cq_wait_for_completion(&optee->call_queue, &w);
 		} else if (OPTEE_SMC_RETURN_IS_RPC(res.a0)) {
+			might_sleep();
 			param.a0 = res.a0;
 			param.a1 = res.a1;
 			param.a2 = res.a2;
-- 
2.20.1

