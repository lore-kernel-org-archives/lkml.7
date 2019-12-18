Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ADE0C2D0BF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 18:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 800282465E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 18:27:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbfLRS1X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 13:27:23 -0500
Received: from foss.arm.com ([217.140.110.172]:56636 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727395AbfLRS1X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 13:27:23 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9863931B;
        Wed, 18 Dec 2019 10:27:22 -0800 (PST)
Received: from e108754-lin.cambridge.arm.com (unknown [10.1.198.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9DE453F67D;
        Wed, 18 Dec 2019 10:27:20 -0800 (PST)
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        maz@kernel.org, suzuki.poulose@arm.com, sudeep.holla@arm.com,
        dietmar.eggemann@arm.com, ionela.voinescu@arm.com
Cc:     peterz@infradead.org, mingo@redhat.com, ggherdovich@suse.cz,
        vincent.guittot@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH v2 5/6] TEMP: sched: add interface for counter-based frequency invariance
Date:   Wed, 18 Dec 2019 18:26:06 +0000
Message-Id: <20191218182607.21607-6-ionela.voinescu@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191218182607.21607-1-ionela.voinescu@arm.com>
References: <20191218182607.21607-1-ionela.voinescu@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To be noted that this patch is a temporary one. It introduces the
interface added by the patches at [1] to allow update of the frequency
invariance scale factor based on counters. If [1] is merged there is
not need for this patch.

For platforms that support counters (x86 - APERF/MPERF, arm64 - AMU
counters) the frequency invariance correction factor can be obtained
using a core counter and a fixed counter to get information on the
performance (frequency based only) obtained in a period of time. This
will more accurately reflect the actual current frequency of the CPU,
compared with the alternative implementation that reflects the request
of a performance level from the OS through the cpufreq framework
(arch_set_freq_scale).

Therefore, introduce an interface - arch_scale_freq_tick, to be
implemented by each architecture and called for each CPU on the tick
to update the scale factor based on the delta in the counter values,
if counter support is present on the CPU.

Either because reading counters is expensive or because reading
counters from remote CPUs is not possible or is expensive, only
update the counter based frequency scale factor on the tick for
now. A tick based update will definitely be necessary either due to
it being the only point of update for certain architectures or in
order to cache the counter values for a particular CPU, if a
further update from that CPU is not possible.

[1]
https://lore.kernel.org/lkml/20191113124654.18122-1-ggherdovich@suse.cz/

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Suggested-by: Giovanni Gherdovich <ggherdovich@suse.cz>
Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 kernel/sched/core.c  | 1 +
 kernel/sched/sched.h | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 90e4b00ace89..e0b70b9fb5cc 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3594,6 +3594,7 @@ void scheduler_tick(void)
 	struct task_struct *curr = rq->curr;
 	struct rq_flags rf;
 
+	arch_scale_freq_tick();
 	sched_clock_tick();
 
 	rq_lock(rq, &rf);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 280a3c735935..afdafcf7f9da 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1771,6 +1771,13 @@ static inline void set_next_task(struct rq *rq, struct task_struct *next)
 	next->sched_class->set_next_task(rq, next, false);
 }
 
+#ifndef arch_scale_freq_tick
+static __always_inline
+void arch_scale_freq_tick(void)
+{
+}
+#endif
+
 #ifdef CONFIG_SMP
 #define sched_class_highest (&stop_sched_class)
 #else
-- 
2.17.1

