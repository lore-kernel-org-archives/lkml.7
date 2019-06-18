Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 443C9C31E5C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 03:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 201362084B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 03:15:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbfFRDPA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 23:15:00 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:18630 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725829AbfFRDPA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 23:15:00 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 9751D2C74042B8FD4C4D;
        Tue, 18 Jun 2019 11:14:57 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.439.0; Tue, 18 Jun 2019 11:14:50 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        <linux-kernel@vger.kernel.org>
CC:     <guohanjun@huawei.com>, Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH] irqchip/mbigen: stop printing kernel addresses
Date:   Tue, 18 Jun 2019 11:22:02 +0800
Message-ID: <20190618032202.11087-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit ad67b74d2469d9b8 ("printk: hash addresses printed with %p"),
it will print "____ptrval____" instead of actual addresses when mbigen
create domain fails,

  Hisilicon MBIGEN-V2 HISI0152:00: Failed to create mbi-gen@(____ptrval____) irqdomain
  Hisilicon MBIGEN-V2: probe of HISI0152:00 failed with error -12

Instead of changing the print to "%px", and leaking kernel addresses,
just remove the print completely.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/irqchip/irq-mbigen.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-mbigen.c b/drivers/irqchip/irq-mbigen.c
index 98b6e1d4b1a6..d0cf596c801b 100644
--- a/drivers/irqchip/irq-mbigen.c
+++ b/drivers/irqchip/irq-mbigen.c
@@ -355,8 +355,7 @@ static int mbigen_device_probe(struct platform_device *pdev)
 		err = -EINVAL;
 
 	if (err) {
-		dev_err(&pdev->dev, "Failed to create mbi-gen@%p irqdomain",
-			mgn_chip->base);
+		dev_err(&pdev->dev, "Failed to create mbi-gen irqdomain");
 		return err;
 	}
 
-- 
2.20.1

