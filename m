Return-Path: <SRS0=Z/Yg=ZW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF6FC432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 07:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 003012082E
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 07:40:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbfK3HkK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Nov 2019 02:40:10 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:55950 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725298AbfK3HkK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Nov 2019 02:40:10 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 171D3264E0EC660DB655;
        Sat, 30 Nov 2019 15:40:04 +0800 (CST)
Received: from linux-XCyijm.huawei.com (10.175.104.212) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.439.0; Sat, 30 Nov 2019 15:39:54 +0800
From:   Heyi Guo <guoheyi@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <wanghaibin.wang@huawei.com>, Heyi Guo <guoheyi@huawei.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        "Marc Zyngier" <maz@kernel.org>
Subject: [PATCH] irq/gic-its: gicv4: set VPENDING table as inner-shareable
Date:   Sat, 30 Nov 2019 15:38:49 +0800
Message-ID: <20191130073849.38378-1-guoheyi@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.212]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no special reason to set virtual LPI pending table as
non-shareable. If we choose to hard code the shareability without
probing, inner-shareable will be a better choice, for all the other
ITS/GICR tables prefer to be inner-shareable.

What's more, on Hisilicon hip08 it will trigger some kind of bus
warning when mixing use of different shareabilities.

Signed-off-by: Heyi Guo <guoheyi@huawei.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v3-its.c   | 2 +-
 include/linux/irqchip/arm-gic-v3.h | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 787e8eec9a7f..d31e863bc9ef 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -2831,7 +2831,7 @@ static void its_vpe_schedule(struct its_vpe *vpe)
 	val  = virt_to_phys(page_address(vpe->vpt_page)) &
 		GENMASK_ULL(51, 16);
 	val |= GICR_VPENDBASER_RaWaWb;
-	val |= GICR_VPENDBASER_NonShareable;
+	val |= GICR_VPENDBASER_InnerShareable;
 	/*
 	 * There is no good way of finding out if the pending table is
 	 * empty as we can race against the doorbell interrupt very
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index 5cc10cf7cb3e..a184f875e451 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -289,6 +289,9 @@
 #define GICR_VPENDBASER_NonShareable					\
 	GIC_BASER_SHAREABILITY(GICR_VPENDBASER, NonShareable)
 
+#define GICR_VPENDBASER_InnerShareable					\
+	GIC_BASER_SHAREABILITY(GICR_VPENDBASER, InnerShareable)
+
 #define GICR_VPENDBASER_nCnB	GIC_BASER_CACHEABILITY(GICR_VPENDBASER, INNER, nCnB)
 #define GICR_VPENDBASER_nC 	GIC_BASER_CACHEABILITY(GICR_VPENDBASER, INNER, nC)
 #define GICR_VPENDBASER_RaWt	GIC_BASER_CACHEABILITY(GICR_VPENDBASER, INNER, RaWt)
-- 
2.19.1

