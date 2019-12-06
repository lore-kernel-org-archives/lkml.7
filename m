Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D890FC43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 16:15:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4E0F206DF
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 16:15:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbfLFQPh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 11:15:37 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:58981 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726271AbfLFQPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 11:15:37 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R951e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=rocking@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0Tk8WAei_1575648901;
Received: from localhost(mailfrom:rocking@linux.alibaba.com fp:SMTPD_---0Tk8WAei_1575648901)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 07 Dec 2019 00:15:35 +0800
From:   Peng Wang <rocking@linux.alibaba.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de
Cc:     linux-kernel@vger.kernel.org, Peng Wang <rocking@linux.alibaba.com>
Subject: [PATCH] schied/fair: Skip updating "contrib" without load
Date:   Sat,  7 Dec 2019 00:14:22 +0800
Message-Id: <1575648862-12095-1-git-send-email-rocking@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We only update load_sum/runnable_load_sum/util_sum with
decayed old sum when load is clear.

Signed-off-by: Peng Wang <rocking@linux.alibaba.com>
---
 kernel/sched/pelt.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index a96db50..4392953 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -129,8 +129,9 @@ static u32 __accumulate_pelt_segments(u64 periods, u32 d1, u32 d3)
 		 * Step 2
 		 */
 		delta %= 1024;
-		contrib = __accumulate_pelt_segments(periods,
-				1024 - sa->period_contrib, delta);
+		if (load)
+			contrib = __accumulate_pelt_segments(periods,
+					1024 - sa->period_contrib, delta);
 	}
 	sa->period_contrib = delta;
 
-- 
1.8.3.1

