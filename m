Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86BC2C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 17:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03E7320830
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 17:10:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbfDCRKi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 13:10:38 -0400
Received: from foss.arm.com ([217.140.101.70]:45264 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726097AbfDCRKi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 13:10:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D19FA80D;
        Wed,  3 Apr 2019 10:10:37 -0700 (PDT)
Received: from e110467-lin.cambridge.arm.com (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 10F0D3F68F;
        Wed,  3 Apr 2019 10:10:35 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     will.deacon@arm.com
Cc:     mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        suzuki.poulose@arm.com, bigeasy@linutronix.de,
        peterz@infradead.org, clabbe.montjoie@gmail.com,
        Meng.Li@windriver.com
Subject: [PATCH v2 2/2] perf/arm-ccn: Remove broken race mitigation
Date:   Wed,  3 Apr 2019 18:10:32 +0100
Message-Id: <49087b08f2685bed112dfc90b97ae59b8de8f6cf.1554310292.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.21.0.dirty
In-Reply-To: <cover.1554310292.git.robin.murphy@arm.com>
References: <cover.1554310292.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like arm-cci, arm-ccn has the same issue of disabling preemption around
operations which can take mutexes. Again, remove the definite bug by
simply not trying to fight the theoretical races. And since we are
touching the hotplug handling code, take the opportunity to streamline
it, as there's really no need to store a full-sized cpumask to keep
track of a single CPU ID.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/perf/arm-ccn.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/perf/arm-ccn.c b/drivers/perf/arm-ccn.c
index 2ae76026e947..a0214308b0cd 100644
--- a/drivers/perf/arm-ccn.c
+++ b/drivers/perf/arm-ccn.c
@@ -167,7 +167,7 @@ struct arm_ccn_dt {
 
 	struct hrtimer hrtimer;
 
-	cpumask_t cpu;
+	unsigned int cpu;
 	struct hlist_node node;
 
 	struct pmu pmu;
@@ -559,7 +559,7 @@ static ssize_t arm_ccn_pmu_cpumask_show(struct device *dev,
 {
 	struct arm_ccn *ccn = pmu_to_arm_ccn(dev_get_drvdata(dev));
 
-	return cpumap_print_to_pagebuf(true, buf, &ccn->dt.cpu);
+	return cpumap_print_to_pagebuf(true, buf, cpumask_of(ccn->dt.cpu));
 }
 
 static struct device_attribute arm_ccn_pmu_cpumask_attr =
@@ -759,7 +759,7 @@ static int arm_ccn_pmu_event_init(struct perf_event *event)
 	 * mitigate this, we enforce CPU assignment to one, selected
 	 * processor (the one described in the "cpumask" attribute).
 	 */
-	event->cpu = cpumask_first(&ccn->dt.cpu);
+	event->cpu = ccn->dt.cpu;
 
 	node_xp = CCN_CONFIG_NODE(event->attr.config);
 	type = CCN_CONFIG_TYPE(event->attr.config);
@@ -1215,15 +1215,15 @@ static int arm_ccn_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
 	struct arm_ccn *ccn = container_of(dt, struct arm_ccn, dt);
 	unsigned int target;
 
-	if (!cpumask_test_and_clear_cpu(cpu, &dt->cpu))
+	if (cpu != dt->cpu)
 		return 0;
 	target = cpumask_any_but(cpu_online_mask, cpu);
 	if (target >= nr_cpu_ids)
 		return 0;
 	perf_pmu_migrate_context(&dt->pmu, cpu, target);
-	cpumask_set_cpu(target, &dt->cpu);
+	dt->cpu = target;
 	if (ccn->irq)
-		WARN_ON(irq_set_affinity_hint(ccn->irq, &dt->cpu) != 0);
+		WARN_ON(irq_set_affinity_hint(ccn->irq, cpumask_of(dt->cpu)));
 	return 0;
 }
 
@@ -1299,29 +1299,28 @@ static int arm_ccn_pmu_init(struct arm_ccn *ccn)
 	}
 
 	/* Pick one CPU which we will use to collect data from CCN... */
-	cpumask_set_cpu(get_cpu(), &ccn->dt.cpu);
+	ccn->dt.cpu = raw_smp_processor_id();
 
 	/* Also make sure that the overflow interrupt is handled by this CPU */
 	if (ccn->irq) {
-		err = irq_set_affinity_hint(ccn->irq, &ccn->dt.cpu);
+		err = irq_set_affinity_hint(ccn->irq, cpumask_of(ccn->dt.cpu));
 		if (err) {
 			dev_err(ccn->dev, "Failed to set interrupt affinity!\n");
 			goto error_set_affinity;
 		}
 	}
 
+	cpuhp_state_add_instance_nocalls(CPUHP_AP_PERF_ARM_CCN_ONLINE,
+					 &ccn->dt.node);
+
 	err = perf_pmu_register(&ccn->dt.pmu, name, -1);
 	if (err)
 		goto error_pmu_register;
 
-	cpuhp_state_add_instance_nocalls(CPUHP_AP_PERF_ARM_CCN_ONLINE,
-					 &ccn->dt.node);
-	put_cpu();
 	return 0;
 
 error_pmu_register:
 error_set_affinity:
-	put_cpu();
 error_choose_name:
 	ida_simple_remove(&arm_ccn_pmu_ida, ccn->dt.id);
 	for (i = 0; i < ccn->num_xps; i++)
-- 
2.21.0.dirty

