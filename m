Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 905A7C2D0CE
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 18:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69D4021744
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 18:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577470558;
	bh=B/WPZinwqaU3N5CEePyKCWSzXduU7EUxFTX6m0gZr/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NwzYrsXU8CCX199nS44/PeB1e5YzRtiN1ZDpoiDdfzstLDwBqWYROhKz/eLU34ZH3
	 JYZrlCyTVloooNjIw+fXr0EPWciZdvOSgEcoIYP03wH8jPojVbgdF1XxhoHL+ZtHwM
	 Nu3WaDN/ujRShpThUkAaNgcrFH6Q0L1dtIJG6Yn8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbfL0SP4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 13:15:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:40870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727134AbfL0SPy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 13:15:54 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2BD421744;
        Fri, 27 Dec 2019 18:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577470553;
        bh=B/WPZinwqaU3N5CEePyKCWSzXduU7EUxFTX6m0gZr/s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JfXJC/+P+Te4cAnTPKqaUHsFhlHuLP80RocKgWzPr2ZkvMp6OO8fAOY4loBM0Ovcg
         49JWPQig5CwlzN+bm2ltgodj6QU9hV+plgG39Yq3Rg+PFi13mMAqwHON2v/P2YI+rq
         wNq5JWEtlpzn59Hm5acoe9Wee1vtTHSS8y/s+56Y=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 4.4 03/25] ARM: vexpress: Set-up shared OPP table instead of individual for each CPU
Date:   Fri, 27 Dec 2019 13:15:27 -0500
Message-Id: <20191227181549.8040-3-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191227181549.8040-1-sashal@kernel.org>
References: <20191227181549.8040-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sudeep Holla <sudeep.holla@arm.com>

[ Upstream commit 2a76352ad2cc6b78e58f737714879cc860903802 ]

Currently we add individual copy of same OPP table for each CPU within
the cluster. This is redundant and doesn't reflect the reality.

We can't use core cpumask to set policy->cpus in ve_spc_cpufreq_init()
anymore as it gets called via cpuhp_cpufreq_online()->cpufreq_online()
->cpufreq_driver->init() and the cpumask gets updated upon CPU hotplug
operations. It also may cause issues when the vexpress_spc_cpufreq
driver is built as a module.

Since ve_spc_clk_init is built-in device initcall, we should be able to
use the same topology_core_cpumask to set the opp sharing cpumask via
dev_pm_opp_set_sharing_cpus and use the same later in the driver via
dev_pm_opp_get_sharing_cpus.

Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/mach-vexpress/spc.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-vexpress/spc.c b/arch/arm/mach-vexpress/spc.c
index 5766ce2be32b..29eb945075e3 100644
--- a/arch/arm/mach-vexpress/spc.c
+++ b/arch/arm/mach-vexpress/spc.c
@@ -555,8 +555,9 @@ static struct clk *ve_spc_clk_register(struct device *cpu_dev)
 
 static int __init ve_spc_clk_init(void)
 {
-	int cpu;
+	int cpu, cluster;
 	struct clk *clk;
+	bool init_opp_table[MAX_CLUSTERS] = { false };
 
 	if (!info)
 		return 0; /* Continue only if SPC is initialised */
@@ -582,8 +583,17 @@ static int __init ve_spc_clk_init(void)
 			continue;
 		}
 
+		cluster = topology_physical_package_id(cpu_dev->id);
+		if (init_opp_table[cluster])
+			continue;
+
 		if (ve_init_opp_table(cpu_dev))
 			pr_warn("failed to initialise cpu%d opp table\n", cpu);
+		else if (dev_pm_opp_set_sharing_cpus(cpu_dev,
+			 topology_core_cpumask(cpu_dev->id)))
+			pr_warn("failed to mark OPPs shared for cpu%d\n", cpu);
+		else
+			init_opp_table[cluster] = true;
 	}
 
 	platform_device_register_simple("vexpress-spc-cpufreq", -1, NULL, 0);
-- 
2.20.1

