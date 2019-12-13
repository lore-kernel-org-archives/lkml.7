Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF6EBC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 03:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1602206D8
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 03:46:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731598AbfLMDqD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 22:46:03 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:39756 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731357AbfLMDqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 22:46:03 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04427;MF=rocking@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0TklN2C6_1576208759;
Received: from localhost(mailfrom:rocking@linux.alibaba.com fp:SMTPD_---0TklN2C6_1576208759)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 13 Dec 2019 11:45:59 +0800
From:   Peng Wang <rocking@linux.alibaba.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de
Cc:     linux-kernel@vger.kernel.org, Peng Wang <rocking@linux.alibaba.com>
Subject: [PATCH v2] schied/fair: Skip calculating @contrib without load
Date:   Fri, 13 Dec 2019 11:45:40 +0800
Message-Id: <1576208740-35609-1-git-send-email-rocking@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1575648862-12095-1-git-send-email-rocking@linux.alibaba.com>
References: <1575648862-12095-1-git-send-email-rocking@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because of the:

	if (!load)
		runnable = running = 0;

clause in ___update_load_sum(), all the actual users of @contrib in
accumulate_sum():

	if (load)
		sa->load_sum += load * contrib;
	if (runnable)
		sa->runnable_load_sum += runnable * contrib;
	if (running)
		sa->util_sum += contrib << SCHED_CAPACITY_SHIFT;

don't happen, and therefore we don't care what @contrib actually is and
calculating it is pointless.

If we count the times when @load equals zero and not as below:

	if (load) {
		load_is_not_zero_count++;
		contrib = __accumulate_pelt_segments(periods,
				1024 - sa->period_contrib,delta);
	} else
		load_is_zero_count++;

As we can see, load_is_zero_count is much bigger than
load_is_zero_count, and the gap is gradually widening:

	load_is_zero_count:            6016044 times
	load_is_not_zero_count:         244316 times
	19:50:43 up 1 min,  1 user,  load average: 0.09, 0.06, 0.02

	load_is_zero_count:            7956168 times
	load_is_not_zero_count:         261472 times
	19:51:42 up 2 min,  1 user,  load average: 0.03, 0.05, 0.01

	load_is_zero_count:           10199896 times
	load_is_not_zero_count:         278364 times
	19:52:51 up 3 min,  1 user,  load average: 0.06, 0.05, 0.01

	load_is_zero_count:           14333700 times
	load_is_not_zero_count:         318424 times
	19:54:53 up 5 min,  1 user,  load average: 0.01, 0.03, 0.00

Perhaps we can gain some performance advantage by saving these
unnecessary calculation.

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

