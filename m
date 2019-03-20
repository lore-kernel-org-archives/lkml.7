Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A47C10F05
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 14:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AFE52184E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 14:22:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbfCTOWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 10:22:43 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5720 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726123AbfCTOWn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 10:22:43 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 7255E1888C1C9C4C8477;
        Wed, 20 Mar 2019 22:22:40 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.408.0; Wed, 20 Mar 2019
 22:22:29 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <cernekee@gmail.com>, <f.fainelli@gmail.com>, <tglx@linutronix.de>,
        <jason@lakedaemon.net>, <marc.zyngier@arm.com>,
        <computersforpeace@gmail.com>, <gregory.0xf0@gmail.com>,
        <bcm-kernel-feedback-list@broadcom.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mips@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] irqchip/brcmstb-l2: Make two init functions static
Date:   Wed, 20 Mar 2019 22:22:20 +0800
Message-ID: <20190320142220.3224-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

Fix sparse warnings:

drivers/irqchip/irq-brcmstb-l2.c:278:12: warning:
 symbol 'brcmstb_l2_edge_intc_of_init' was not declared. Should it be static?
drivers/irqchip/irq-brcmstb-l2.c:285:12: warning:
 symbol 'brcmstb_l2_lvl_intc_of_init' was not declared. Should it be static?

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/irqchip/irq-brcmstb-l2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-brcmstb-l2.c b/drivers/irqchip/irq-brcmstb-l2.c
index 83364fe..5e4ca13 100644
--- a/drivers/irqchip/irq-brcmstb-l2.c
+++ b/drivers/irqchip/irq-brcmstb-l2.c
@@ -275,14 +275,14 @@ static int __init brcmstb_l2_intc_of_init(struct device_node *np,
 	return ret;
 }
 
-int __init brcmstb_l2_edge_intc_of_init(struct device_node *np,
+static int __init brcmstb_l2_edge_intc_of_init(struct device_node *np,
 	struct device_node *parent)
 {
 	return brcmstb_l2_intc_of_init(np, parent, &l2_edge_intc_init);
 }
 IRQCHIP_DECLARE(brcmstb_l2_intc, "brcm,l2-intc", brcmstb_l2_edge_intc_of_init);
 
-int __init brcmstb_l2_lvl_intc_of_init(struct device_node *np,
+static int __init brcmstb_l2_lvl_intc_of_init(struct device_node *np,
 	struct device_node *parent)
 {
 	return brcmstb_l2_intc_of_init(np, parent, &l2_lvl_intc_init);
-- 
2.7.0


