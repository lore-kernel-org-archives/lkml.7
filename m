Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E1CC2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 08:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A74D420CC7
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 08:21:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfLWIVP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 03:21:15 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:35798 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726691AbfLWIVM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 03:21:12 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 76E6D5F1FED0821E5F97;
        Mon, 23 Dec 2019 16:21:06 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.439.0; Mon, 23 Dec 2019 16:20:59 +0800
From:   z00214469 <prime.zeng@hisilicon.com>
To:     <sudeep.holla@arm.com>
CC:     <linuxarm@huawei.com>, z00214469 <prime.zeng@hisilicon.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] cpu-topology: warn if NUMA configurations conflicts with lower layer
Date:   Mon, 23 Dec 2019 16:16:19 +0800
Message-ID: <1577088979-8545-1-git-send-email-prime.zeng@hisilicon.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As we know, from sched domain's perspective, the DIE layer should be
larger than or at least equal to the MC layer, and in some cases, MC
is defined by the arch specified hardware, MPIDR for example, but NUMA
can be defined by users, with the following system configrations:
*************************************
NUMA:      	 0-2,  3-7
core_siblings:   0-3,  4-7
*************************************
Per the current code, for core 3, its MC cpu map fallbacks to 3~7(its
core_sibings is 0~3 while its numa node map is 3~7).

For the sched MC, when we are build sched groups:
step1. core3 's sched groups chain is built like this: 3->4->5->6->7->3
step2. core4's sched groups chain is built like this: 4->5->6->7->4
so after step2, core3's sched groups for MC level is overlapped, more
importantly, it will fall to dead loop if while(sg != sg->groups)

Obviously, the NUMA node with cpu 3-7 conflict with the MC level cpu
map, but unfortunately, there is no way even detect such cases.

In this patch, prompt a warning message to help with the above cases.

Signed-off-by: Zeng Tao <prime.zeng@hisilicon.com>
---
 drivers/base/arch_topology.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 1eb81f11..5fe44b3 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -439,10 +439,18 @@ const struct cpumask *cpu_coregroup_mask(int cpu)
 	if (cpumask_subset(&cpu_topology[cpu].core_sibling, core_mask)) {
 		/* not numa in package, lets use the package siblings */
 		core_mask = &cpu_topology[cpu].core_sibling;
-	}
+	} else
+		pr_warn_once("Warning: suspicous broken topology: cpu:[%d]'s core_sibling:[%*pbl] not a subset of numa node:[%*pbl]\n",
+			cpu, cpumask_pr_args(&cpu_topology[cpu].core_sibling),
+			cpumask_pr_args(core_mask));
+
 	if (cpu_topology[cpu].llc_id != -1) {
 		if (cpumask_subset(&cpu_topology[cpu].llc_sibling, core_mask))
 			core_mask = &cpu_topology[cpu].llc_sibling;
+		else
+			pr_warn_once("Warning: suspicous broken topology: cpu:[%d]'s llc_sibling:[%*pbl] not a subset of numa node:[%*pbl]\n",
+				cpu, cpumask_pr_args(&cpu_topology[cpu].llc_sibling),
+				cpumask_pr_args(core_mask));
 	}
 
 	return core_mask;
-- 
2.8.1

