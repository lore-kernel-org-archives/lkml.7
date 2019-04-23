Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AFDAC10F11
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 01:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3168C2077C
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 01:22:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729215AbfDWBWa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 21:22:30 -0400
Received: from mail2.tencent.com ([163.177.67.195]:35609 "EHLO
        mail2.tencent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727263AbfDWBW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 21:22:29 -0400
Received: from EXHUB-SZMail01.tencent.com (unknown [10.14.6.21])
        by mail2.tencent.com (Postfix) with ESMTP id A4D688EB65;
        Tue, 23 Apr 2019 09:22:27 +0800 (CST)
Received: from localhost.localdomain (10.35.10.40) by
 EXHUB-SZMail01.tencent.com (10.14.6.21) with Microsoft SMTP Server id
 14.3.408.0; Tue, 23 Apr 2019 09:22:27 +0800
From:   Jiang Biao <benbjiang@tencent.com>
To:     <paulmck@linux.ibm.com>, <josh@joshtriplett.org>
CC:     <linux-kernel@vger.kernel.org>, <benbjiang@tencent.com>
Subject: [PATCH] rcu/tree_exp: cleanup initialized but not used rdp
Date:   Tue, 23 Apr 2019 09:21:55 +0800
Message-ID: <20190423012155.30606-1-benbjiang@tencent.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.35.10.40]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rdp is initialized but never used in synchronize_rcu_expedited(),
just remove it.

Signed-off-by: Jiang Biao <benbjiang@tencent.com>
---
 kernel/rcu/tree_exp.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 4c2a0189e748..5772612379e4 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -733,7 +733,6 @@ static void sync_sched_exp_online_cleanup(int cpu)
  */
 void synchronize_rcu_expedited(void)
 {
-	struct rcu_data *rdp;
 	struct rcu_exp_work rew;
 	struct rcu_node *rnp;
 	unsigned long s;
@@ -770,7 +769,6 @@ void synchronize_rcu_expedited(void)
 	}
 
 	/* Wait for expedited grace period to complete. */
-	rdp = per_cpu_ptr(&rcu_data, raw_smp_processor_id());
 	rnp = rcu_get_root();
 	wait_event(rnp->exp_wq[rcu_seq_ctr(s) & 0x3],
 		   sync_exp_work_done(s));
-- 
2.17.2 (Apple Git-113)

