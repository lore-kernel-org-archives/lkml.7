Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2C01C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 17:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A07E20830
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 17:11:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbfDCRLC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 13:11:02 -0400
Received: from foss.arm.com ([217.140.101.70]:45296 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726097AbfDCRLB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 13:11:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 09D8C80D;
        Wed,  3 Apr 2019 10:11:01 -0700 (PDT)
Received: from e110467-lin.cambridge.arm.com (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3D6393F68F;
        Wed,  3 Apr 2019 10:10:59 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     will.deacon@arm.com
Cc:     mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        suzuki.poulose@arm.com, bigeasy@linutronix.de,
        peterz@infradead.org, clabbe.montjoie@gmail.com,
        Meng.Li@windriver.com
Subject: [PATCH v2 1/2] perf/arm-cci: Remove broken race mitigation
Date:   Wed,  3 Apr 2019 18:10:53 +0100
Message-Id: <cf67c49058e3913540df1ebbb765c006f5205ec1.1554310292.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.21.0.dirty
In-Reply-To: <cover.1554310292.git.robin.murphy@arm.com>
References: <cover.1554310292.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Uncore PMU drivers face an awkward cyclic dependency wherein:

 - They have to pick a valid online CPU to associate with before
   registering the PMU device, since it will get exposed to userspace
   immediately.
 - The PMU registration has to be be at least partly complete before
   hotplug events can be handled, since trying to migrate an
   uninitialised context would be bad.
 - The hotplug handler has to be ready as soon as a CPU is chosen, lest
   it go offline without the user-visible cpumask value getting updated.

The arm-cci driver has tried to solve this by using get_cpu() to pick
the current CPU and prevent it from disappearing while both
registrations are performed, but that results in taking mutexes with
preemption disabled, which makes certain configurations very unhappy:

[ 1.983337] BUG: sleeping function called from invalid context at kernel/locking/rtmutex.c:2004
[ 1.983340] in_atomic(): 1, irqs_disabled(): 0, pid: 1, name: swapper/0
[ 1.983342] Preemption disabled at:
[ 1.983353] [<ffffff80089801f4>] cci_pmu_probe+0x1dc/0x488
[ 1.983360] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.18.20-rt8-yocto-preempt-rt #1
[ 1.983362] Hardware name: ZynqMP ZCU102 Rev1.0 (DT)
[ 1.983364] Call trace:
[ 1.983369] dump_backtrace+0x0/0x158
[ 1.983372] show_stack+0x24/0x30
[ 1.983378] dump_stack+0x80/0xa4
[ 1.983383] ___might_sleep+0x138/0x160
[ 1.983386] __might_sleep+0x58/0x90
[ 1.983391] __rt_mutex_lock_state+0x30/0xc0
[ 1.983395] _mutex_lock+0x24/0x30
[ 1.983400] perf_pmu_register+0x2c/0x388
[ 1.983404] cci_pmu_probe+0x2bc/0x488
[ 1.983409] platform_drv_probe+0x58/0xa8

It is not feasible to resolve all the possible races outside of the perf
core itself, so address the immediate bug by following the example of
nearly every other PMU driver and not even trying to do so. Registering
the hotplug notifier first should minimise the window in which things
can go wrong, so that's about as much as we can reasonably do here. This
also revealed an additional race in assigning the global pointer too
late relative to the hotplug notifier, which gets fixed in the process.

Reported-by: "Li, Meng" <Meng.Li@windriver.com>
Reported-by: Corentin Labbe <clabbe.montjoie@gmail.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/perf/arm-cci.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/perf/arm-cci.c b/drivers/perf/arm-cci.c
index bfd03e023308..7a29ed88bd4f 100644
--- a/drivers/perf/arm-cci.c
+++ b/drivers/perf/arm-cci.c
@@ -1684,19 +1684,17 @@ static int cci_pmu_probe(struct platform_device *pdev)
 	raw_spin_lock_init(&cci_pmu->hw_events.pmu_lock);
 	mutex_init(&cci_pmu->reserve_mutex);
 	atomic_set(&cci_pmu->active_events, 0);
-	cci_pmu->cpu = get_cpu();
-
-	ret = cci_pmu_init(cci_pmu, pdev);
-	if (ret) {
-		put_cpu();
-		return ret;
-	}
 
+	cci_pmu->cpu = raw_smp_processor_id();
+	g_cci_pmu = cci_pmu;
 	cpuhp_setup_state_nocalls(CPUHP_AP_PERF_ARM_CCI_ONLINE,
 				  "perf/arm/cci:online", NULL,
 				  cci_pmu_offline_cpu);
-	put_cpu();
-	g_cci_pmu = cci_pmu;
+
+	ret = cci_pmu_init(cci_pmu, pdev);
+	if (ret)
+		return ret;
+
 	pr_info("ARM %s PMU driver probed", cci_pmu->model->name);
 	return 0;
 }
-- 
2.21.0.dirty

