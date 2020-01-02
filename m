Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B89C32767
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 03:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0ADA20848
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 03:29:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727584AbgABD3B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jan 2020 22:29:01 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:47838 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727525AbgABD3A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 22:29:00 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 00897EE174A26A3A4B6A;
        Thu,  2 Jan 2020 11:28:58 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.439.0; Thu, 2 Jan 2020 11:28:48 +0800
From:   Zeng Tao <prime.zeng@hisilicon.com>
To:     <sudeep.holla@arm.com>
CC:     <linuxarm@huawei.com>, Zeng Tao <prime.zeng@hisilicon.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] cpu-topology: Skip the exist but not possible cpu nodes
Date:   Thu, 2 Jan 2020 11:24:49 +0800
Message-ID: <1577935489-25245-1-git-send-email-prime.zeng@hisilicon.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_NR_CPUS is smaller than the cpu nodes defined in the device
tree, the cpu node parsing will fail. And this is not reasonable for a
legal device tree configs.
In this patch, skip such cpu nodes rather than return an error.

Signed-off-by: Zeng Tao <prime.zeng@hisilicon.com>
---
 drivers/base/arch_topology.c | 35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 5fe44b3..4cddfeb 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -250,20 +250,34 @@ core_initcall(free_raw_capacity);
 #if defined(CONFIG_ARM64) || defined(CONFIG_RISCV)
 static int __init get_cpu_for_node(struct device_node *node)
 {
-	struct device_node *cpu_node;
+	struct device_node *cpu_node, *t;
 	int cpu;
+	bool found = false;
 
 	cpu_node = of_parse_phandle(node, "cpu", 0);
 	if (!cpu_node)
-		return -1;
+		return -EINVAL;
+
+	for_each_of_cpu_node(t)
+		if (t == cpu_node) {
+			found = true;
+			break;
+		}
+
+	if (!found) {
+		pr_crit("Unable to find CPU node for %pOF\n", cpu_node);
+		return -EINVAL;
+	}
 
 	cpu = of_cpu_node_to_id(cpu_node);
 	if (cpu >= 0)
 		topology_parse_cpu_capacity(cpu_node, cpu);
-	else
-		pr_crit("Unable to find CPU node for %pOF\n", cpu_node);
+	else {
+		pr_warn("CPU node for %pOF exist but the possible cpu range is :%*pbl\n",
+			cpu_node, cpumask_pr_args(cpu_possible_mask));
+		cpu = -ENODEV;
+	}
 
-	of_node_put(cpu_node);
 	return cpu;
 }
 
@@ -287,10 +301,13 @@ static int __init parse_core(struct device_node *core, int package_id,
 				cpu_topology[cpu].core_id = core_id;
 				cpu_topology[cpu].thread_id = i;
 			} else {
-				pr_err("%pOF: Can't get CPU for thread\n",
-				       t);
+				if (cpu != -ENODEV)
+					pr_err("%pOF: Can't get CPU for thread\n",
+					       t);
+				else
+					cpu = 0;
 				of_node_put(t);
-				return -EINVAL;
+				return cpu;
 			}
 			of_node_put(t);
 		}
@@ -307,7 +324,7 @@ static int __init parse_core(struct device_node *core, int package_id,
 
 		cpu_topology[cpu].package_id = package_id;
 		cpu_topology[cpu].core_id = core_id;
-	} else if (leaf) {
+	} else if (leaf && cpu != -ENODEV) {
 		pr_err("%pOF: Can't get CPU for leaf core\n", core);
 		return -EINVAL;
 	}
-- 
2.8.1

