Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C13AC04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 12:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ED0820859
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 12:27:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbfE0M1G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 08:27:06 -0400
Received: from michel.telenet-ops.be ([195.130.137.88]:53162 "EHLO
        michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbfE0M1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 08:27:05 -0400
Received: from ramsan ([84.194.111.163])
        by michel.telenet-ops.be with bizsmtp
        id HQT42000K3XaVaC06QT4Z7; Mon, 27 May 2019 14:27:04 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hVEiW-0001UT-HZ; Mon, 27 May 2019 14:27:04 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hVEiW-0001eQ-GC; Mon, 27 May 2019 14:27:04 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] arch_topology: Remove error messages on out-of-memory conditions
Date:   Mon, 27 May 2019 14:27:03 +0200
Message-Id: <20190527122703.6303-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to print error messages if kcalloc() or
alloc_cpumask_var() fail, as the memory allocation core already takes
care of that.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/base/arch_topology.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 1739d7e1952af6e7..8486c399ddb7bec8 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -137,7 +137,6 @@ bool __init topology_parse_cpu_capacity(struct device_node *cpu_node, int cpu)
 					       sizeof(*raw_capacity),
 					       GFP_KERNEL);
 			if (!raw_capacity) {
-				pr_err("cpu_capacity: failed to allocate memory for raw capacities\n");
 				cap_parsing_failed = true;
 				return false;
 			}
@@ -217,10 +216,8 @@ static int __init register_cpufreq_notifier(void)
 	if (!acpi_disabled || !raw_capacity)
 		return -EINVAL;
 
-	if (!alloc_cpumask_var(&cpus_to_visit, GFP_KERNEL)) {
-		pr_err("cpu_capacity: failed to allocate memory for cpus_to_visit\n");
+	if (!alloc_cpumask_var(&cpus_to_visit, GFP_KERNEL))
 		return -ENOMEM;
-	}
 
 	cpumask_copy(cpus_to_visit, cpu_possible_mask);
 
-- 
2.17.1

