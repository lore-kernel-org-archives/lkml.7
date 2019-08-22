Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A27C3A59E
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 02:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6DAE216F4
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 02:18:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731182AbfHVCSq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 22:18:46 -0400
Received: from shelob.surriel.com ([96.67.55.147]:34204 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730886AbfHVCSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 22:18:13 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <riel@shelob.surriel.com>)
        id 1i0cfX-0001S6-LO; Wed, 21 Aug 2019 22:17:43 -0400
From:   Rik van Riel <riel@surriel.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@fb.com, pjt@google.com, dietmar.eggemann@arm.com,
        peterz@infradead.org, mingo@redhat.com, morten.rasmussen@arm.com,
        tglx@linutronix.de, mgorman@techsingularity.net,
        vincent.guittot@linaro.org, Rik van Riel <riel@surriel.com>
Subject: [PATCH 15/15] sched,fair: scale vdiff in wakeup_preempt_entity
Date:   Wed, 21 Aug 2019 22:17:40 -0400
Message-Id: <20190822021740.15554-16-riel@surriel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190822021740.15554-1-riel@surriel.com>
References: <20190822021740.15554-1-riel@surriel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a task wakes back up after having gone to sleep, place_entity
will limit the vruntime difference between min_vruntime and the
woken up task to half of sysctl_sched_latency.

The code in wakeup_preempt_entity calculates how much vruntime a
time slice for the woken up task represents, in wakeup_gran.

It then assumes that all the vruntime used since the task went to
sleep was used by the currently running task (which has its vruntime
scaled by calc_delta_fair, as well).

However, that assumption is not necessarily true, and the vruntime
may have advanced at different rates, pushed ahead by different tasks
on the CPU. This becomes more visible when the CPU controller is enabled.

This leads to the symptom that a high priority woken up task is likely to
preempt whatever is running, even if the currently running task is of equal
or higher priority than the woken up task!

Scaling the vdiff down if the currently running task is also high priority
solves that symptom.

This is not the correct thing to do if all of the vruntime was accumulated
by the current task, or other tasks at similar priority, and already scaled
by the same priority, but I do not have any better ideas on how to tackle
the "task X got preempted by task Y of the same priority" issue that system
administrators try to resolve by setting the sched_wakeup_granularity
sysctl variable to a larger value than half of sysctl_sched_latency...

Signed-off-by: Rik van Riel <riel@surriel.com>
---
 kernel/sched/fair.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3df5d60b245f..ef7629bdf41d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6774,6 +6774,7 @@ wakeup_preempt_entity(struct sched_entity *curr, struct sched_entity *se)
 	if (vdiff <= 0)
 		return -1;
 
+	vdiff = min((u64)vdiff, calc_delta_fair(vdiff, curr));
 	gran = wakeup_gran(se);
 	if (vdiff > gran)
 		return 1;
-- 
2.20.1

