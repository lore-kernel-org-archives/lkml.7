Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C84C32771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 08:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6523A2072A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 08:00:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728379AbgAIIAK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 03:00:10 -0500
Received: from lucky1.263xmail.com ([211.157.147.131]:42950 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728273AbgAIIAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 03:00:09 -0500
X-Greylist: delayed 455 seconds by postgrey-1.27 at vger.kernel.org; Thu, 09 Jan 2020 03:00:05 EST
Received: from localhost (unknown [192.168.167.209])
        by lucky1.263xmail.com (Postfix) with ESMTP id 46B1475D62;
        Thu,  9 Jan 2020 15:52:24 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost (unknown [103.29.142.67])
        by smtp.263.net (postfix) whith ESMTP id P29239T139675372660480S1578556336005763_;
        Thu, 09 Jan 2020 15:52:23 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <877b7a582fe9b2689e9e99cd31e091f7>
X-RL-SENDER: jeffy.chen@rock-chips.com
X-SENDER: cjf@rock-chips.com
X-LOGIN-NAME: jeffy.chen@rock-chips.com
X-FST-TO: linux-kernel@vger.kernel.org
X-SENDER-IP: 103.29.142.67
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From:   Jeffy Chen <jeffy.chen@rock-chips.com>
To:     linux-kernel@vger.kernel.org
Cc:     Brian Norris <briannorris@chromium.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Douglas Anderson <dianders@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v1] arch_topology: Adjust initial CPU capacities with current freq
Date:   Thu,  9 Jan 2020 15:52:14 +0800
Message-Id: <20200109075214.31943-1-jeffy.chen@rock-chips.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CPU freqs are not supposed to change before cpufreq policies
properly registered, meaning that they should be used to calculate the
initial CPU capacities.

Doing this helps choosing the best CPU during early boot, especially
for the initramfs decompressing.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---
When testing the rk3399-evb(arm64 big.LITTLE platform), i saw a noticable
slow-down in early boot:
[    0.280176] hw-breakpoint: found 6 breakpoint and 4 watchpoint registers.
[    3.564412] vcc_sys: supplied by dc_12v
[    3.637176] iommu: Default domain type: Translated
[    3.830721] SCSI subsystem initialized

That is because the big cores are running at a low freq(from bootrom), but
been chosen based on the larger initial cpu capacity.

 drivers/base/arch_topology.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 1eb81f113786..d62fe1d4dda9 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -94,7 +94,7 @@ static void update_topology_flags_workfn(struct work_struct *work)
 	update_topology = 0;
 }
 
-static u32 capacity_scale;
+static DEFINE_PER_CPU(u32, max_freq);
 static u32 *raw_capacity;
 
 static int free_raw_capacity(void)
@@ -108,16 +108,22 @@ static int free_raw_capacity(void)
 void topology_normalize_cpu_scale(void)
 {
 	u64 capacity;
+	u64 capacity_scale;
 	int cpu;
 
 	if (!raw_capacity)
 		return;
 
-	pr_debug("cpu_capacity: capacity_scale=%u\n", capacity_scale);
+	capacity_scale = 1;
 	for_each_possible_cpu(cpu) {
-		pr_debug("cpu_capacity: cpu=%d raw_capacity=%u\n",
-			 cpu, raw_capacity[cpu]);
-		capacity = (raw_capacity[cpu] << SCHED_CAPACITY_SHIFT)
+		capacity = raw_capacity[cpu] * per_cpu(max_freq, cpu);
+		capacity_scale = max(capacity, capacity_scale);
+	}
+
+	pr_debug("cpu_capacity: capacity_scale=%llu\n", capacity_scale);
+	for_each_possible_cpu(cpu) {
+		capacity = raw_capacity[cpu] * per_cpu(max_freq, cpu);
+		capacity = (capacity << SCHED_CAPACITY_SHIFT)
 			/ capacity_scale;
 		topology_set_cpu_scale(cpu, capacity);
 		pr_debug("cpu_capacity: CPU%d cpu_capacity=%lu\n",
@@ -127,6 +133,7 @@ void topology_normalize_cpu_scale(void)
 
 bool __init topology_parse_cpu_capacity(struct device_node *cpu_node, int cpu)
 {
+	struct clk *cpu_clk;
 	static bool cap_parsing_failed;
 	int ret;
 	u32 cpu_capacity;
@@ -146,10 +153,15 @@ bool __init topology_parse_cpu_capacity(struct device_node *cpu_node, int cpu)
 				return false;
 			}
 		}
-		capacity_scale = max(cpu_capacity, capacity_scale);
 		raw_capacity[cpu] = cpu_capacity;
 		pr_debug("cpu_capacity: %pOF cpu_capacity=%u (raw)\n",
 			cpu_node, raw_capacity[cpu]);
+
+		cpu_clk = of_clk_get(cpu_node, 0);
+		if (!PTR_ERR_OR_ZERO(cpu_clk))
+			per_cpu(max_freq, cpu) = clk_get_rate(cpu_clk) / 1000;
+
+		clk_put(cpu_clk);
 	} else {
 		if (raw_capacity) {
 			pr_err("cpu_capacity: missing %pOF raw capacity\n",
@@ -188,11 +200,8 @@ init_cpu_capacity_callback(struct notifier_block *nb,
 
 	cpumask_andnot(cpus_to_visit, cpus_to_visit, policy->related_cpus);
 
-	for_each_cpu(cpu, policy->related_cpus) {
-		raw_capacity[cpu] = topology_get_cpu_scale(cpu) *
-				    policy->cpuinfo.max_freq / 1000UL;
-		capacity_scale = max(raw_capacity[cpu], capacity_scale);
-	}
+	for_each_cpu(cpu, policy->related_cpus)
+		per_cpu(max_freq, cpu) = policy->cpuinfo.max_freq / 1000;
 
 	if (cpumask_empty(cpus_to_visit)) {
 		topology_normalize_cpu_scale();
-- 
2.11.0



