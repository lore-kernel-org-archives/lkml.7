Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55107C2D0BF
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 10:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29A522464D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 10:56:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729381AbfLEK46 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 05:56:58 -0500
Received: from alexa-out-blr-01.qualcomm.com ([103.229.18.197]:52802 "EHLO
        alexa-out-blr-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729048AbfLEK46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 05:56:58 -0500
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by alexa-out-blr-01.qualcomm.com with ESMTP/TLS/AES256-SHA; 05 Dec 2019 16:26:12 +0530
Received: from gkohli-linux.qualcomm.com ([10.204.78.26])
  by ironmsg02-blr.qualcomm.com with ESMTP; 05 Dec 2019 16:26:02 +0530
Received: by gkohli-linux.qualcomm.com (Postfix, from userid 427023)
        id CB079414E; Thu,  5 Dec 2019 16:26:01 +0530 (IST)
From:   Gaurav Kohli <gkohli@codeaurora.org>
To:     tglx@linutronix.de, maz@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Gaurav Kohli <gkohli@codeaurora.org>
Subject: [PATCH v0] irqchip/gic-v3: Avoid check of lpi configuration for non existent cpu
Date:   Thu,  5 Dec 2019 16:25:57 +0530
Message-Id: <1575543357-31892-1-git-send-email-gkohli@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per GIC specification, we can configure gic for more no of cpus
then the available cpus in the soc, But this can cause mem abort
while iterating lpi region for non existent cpu as we don't map
redistrubutor region for non-existent cpu.

To avoid this issue, put one more check of valid mpidr.

Signed-off-by: Gaurav Kohli <gkohli@codeaurora.org>

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 1edc993..adc9186 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -766,6 +766,7 @@ static int gic_iterate_rdists(int (*fn)(struct redist_region *, void __iomem *))
 {
 	int ret = -ENODEV;
 	int i;
+	int cpu = 0;
 
 	for (i = 0; i < gic_data.nr_redist_regions; i++) {
 		void __iomem *ptr = gic_data.redist_regions[i].redist_base;
@@ -780,6 +781,7 @@ static int gic_iterate_rdists(int (*fn)(struct redist_region *, void __iomem *))
 		}
 
 		do {
+			cpu++;
 			typer = gic_read_typer(ptr + GICR_TYPER);
 			ret = fn(gic_data.redist_regions + i, ptr);
 			if (!ret)
@@ -795,7 +797,8 @@ static int gic_iterate_rdists(int (*fn)(struct redist_region *, void __iomem *))
 				if (typer & GICR_TYPER_VLPIS)
 					ptr += SZ_64K * 2; /* Skip VLPI_base + reserved page */
 			}
-		} while (!(typer & GICR_TYPER_LAST));
+		} while (!(typer & GICR_TYPER_LAST) &&
+					cpu_logical_map(cpu) != INVALID_HWID);
 	}
 
 	return ret ? -ENODEV : 0;
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project

