Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83BD0C00319
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 11:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C2EF20842
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 11:32:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbfCELcH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 06:32:07 -0500
Received: from out1.zte.com.cn ([202.103.147.172]:40668 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727305AbfCELcD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 06:32:03 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id D9C21124F1D1AF286AD5;
        Tue,  5 Mar 2019 19:32:01 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id x25BVsMT071196;
        Tue, 5 Mar 2019 19:31:54 +0800 (GMT-8)
        (envelope-from wen.yang99@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019030519321096-3290832 ;
          Tue, 5 Mar 2019 19:32:10 +0800 
From:   Wen Yang <wen.yang99@zte.com.cn>
To:     linux-kernel@vger.kernel.org
Cc:     wang.yi59@zte.com.cn, Wen Yang <wen.yang99@zte.com.cn>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 4/4] ARM: sunxi: fix a leaked reference by adding missing of_node_put
Date:   Tue, 5 Mar 2019 19:32:57 +0800
Message-Id: <1551785577-45896-4-git-send-email-wen.yang99@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1551785577-45896-1-git-send-email-wen.yang99@zte.com.cn>
References: <1551785577-45896-1-git-send-email-wen.yang99@zte.com.cn>
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-03-05 19:32:11,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-03-05 19:31:50,
        Serialize complete at 2019-03-05 19:31:50
X-MAIL: mse01.zte.com.cn x25BVsMT071196
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The call to of_get_next_child returns a node pointer with refcount
incremented thus it must be explicitly decremented after the last
usage.

Detected by coccinelle with the following warnings:
./arch/arm/mach-sunxi/mc_smp.c:110:1-7: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 97, but without a corresponding object release within this functio
./arch/arm/mach-sunxi/platsmp.c:138:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 129, but without a corresponding object release within this function

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org (open list)
---
 arch/arm/mach-sunxi/mc_smp.c  | 5 ++++-
 arch/arm/mach-sunxi/platsmp.c | 2 ++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-sunxi/mc_smp.c b/arch/arm/mach-sunxi/mc_smp.c
index b4037b6..239084c 100644
--- a/arch/arm/mach-sunxi/mc_smp.c
+++ b/arch/arm/mach-sunxi/mc_smp.c
@@ -89,6 +89,7 @@ static bool sunxi_core_is_cortex_a15(unsigned int core, unsigned int cluster)
 {
 	struct device_node *node;
 	int cpu = cluster * SUNXI_CPUS_PER_CLUSTER + core;
+	bool is_compatible;
 
 	node = of_cpu_device_node_get(cpu);
 
@@ -107,7 +108,9 @@ static bool sunxi_core_is_cortex_a15(unsigned int core, unsigned int cluster)
 		return false;
 	}
 
-	return of_device_is_compatible(node, "arm,cortex-a15");
+	is_compatible = of_device_is_compatible(node, "arm,cortex-a15");
+	of_node_put(node);
+	return is_compatible;
 }
 
 static int sunxi_cpu_power_switch_set(unsigned int cpu, unsigned int cluster,
diff --git a/arch/arm/mach-sunxi/platsmp.c b/arch/arm/mach-sunxi/platsmp.c
index c842209..bdde9ef 100644
--- a/arch/arm/mach-sunxi/platsmp.c
+++ b/arch/arm/mach-sunxi/platsmp.c
@@ -135,6 +135,7 @@ static void __init sun8i_smp_prepare_cpus(unsigned int max_cpus)
 	}
 
 	prcm_membase = of_iomap(node, 0);
+	of_node_put(node);
 	if (!prcm_membase) {
 		pr_err("Couldn't map A23 PRCM registers\n");
 		return;
@@ -148,6 +149,7 @@ static void __init sun8i_smp_prepare_cpus(unsigned int max_cpus)
 	}
 
 	cpucfg_membase = of_iomap(node, 0);
+	of_node_put(node);
 	if (!cpucfg_membase)
 		pr_err("Couldn't map A23 CPU config registers\n");
 
-- 
2.9.5

