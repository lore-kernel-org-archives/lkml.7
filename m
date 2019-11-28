Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33585C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 10:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1567C21741
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 10:16:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbfK1KQD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 05:16:03 -0500
Received: from foss.arm.com ([217.140.110.172]:33202 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726133AbfK1KQB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 05:16:01 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 308F61042;
        Thu, 28 Nov 2019 02:16:01 -0800 (PST)
Received: from usa.arm.com (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AC69D3F6C4;
        Thu, 28 Nov 2019 02:15:59 -0800 (PST)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>
Subject: [PATCH 2/2] cpufreq: vexpress-spc: Switch cpumask from topology core to OPP sharing
Date:   Thu, 28 Nov 2019 10:15:47 +0000
Message-Id: <20191128101547.519-2-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191128101547.519-1-sudeep.holla@arm.com>
References: <20191128101547.519-1-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit ca74b316df96 ("arm: Use common cpu_topology structure and
functions.") the core cpumask has to be modified during cpu hotplug
operations. So using them to set up cpufreq policy cpumask may be
incorrect as it may contain only cpus that are online at that instance.

Instead, we can use the cpumask setup by OPP library that contains all
the cpus sharing OPP table using dev_pm_opp_get_sharing_cpus.

Cc: Viresh Kumar <viresh.kumar@linaro.org>
Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/cpufreq/vexpress-spc-cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/vexpress-spc-cpufreq.c b/drivers/cpufreq/vexpress-spc-cpufreq.c
index 506e3f2bf53a..83c85d3d67e3 100644
--- a/drivers/cpufreq/vexpress-spc-cpufreq.c
+++ b/drivers/cpufreq/vexpress-spc-cpufreq.c
@@ -434,7 +434,7 @@ static int ve_spc_cpufreq_init(struct cpufreq_policy *policy)
 	if (cur_cluster < MAX_CLUSTERS) {
 		int cpu;
 
-		cpumask_copy(policy->cpus, topology_core_cpumask(policy->cpu));
+		dev_pm_opp_get_sharing_cpus(cpu_dev, policy->cpus);
 
 		for_each_cpu(cpu, policy->cpus)
 			per_cpu(physical_cluster, cpu) = cur_cluster;
-- 
2.17.1

