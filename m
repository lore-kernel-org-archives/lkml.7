Return-Path: <SRS0=tgXE=2S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98CFBC2D0C3
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 02:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73C0520882
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 02:49:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbfL1CtG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 21:49:06 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:39142 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725957AbfL1CtG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 21:49:06 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 06223672C37A95790DCF;
        Sat, 28 Dec 2019 10:49:03 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.439.0; Sat, 28 Dec 2019 10:48:55 +0800
From:   Chen Zhou <chenzhou10@huawei.com>
To:     <qiang.zhao@nxp.com>, <leoyang.li@nxp.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <chenzhou10@huawei.com>
Subject: [PATCH next] soc/fsl/qe: remove set but not used variables 'mm_gc'
Date:   Sat, 28 Dec 2019 10:45:20 +0800
Message-ID: <20191228024520.151558-1-chenzhou10@huawei.com>
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

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/soc/fsl/qe/gpio.c: In function qe_pin_request:
drivers/soc/fsl/qe/gpio.c:163:26: warning:
	variable mm_gc set but not used [-Wunused-but-set-variable]

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
---
 drivers/soc/fsl/qe/gpio.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/soc/fsl/qe/gpio.c b/drivers/soc/fsl/qe/gpio.c
index 12bdfd9..ed75198 100644
--- a/drivers/soc/fsl/qe/gpio.c
+++ b/drivers/soc/fsl/qe/gpio.c
@@ -160,7 +160,6 @@ struct qe_pin *qe_pin_request(struct device_node *np, int index)
 {
 	struct qe_pin *qe_pin;
 	struct gpio_chip *gc;
-	struct of_mm_gpio_chip *mm_gc;
 	struct qe_gpio_chip *qe_gc;
 	int err;
 	unsigned long flags;
@@ -186,7 +185,6 @@ struct qe_pin *qe_pin_request(struct device_node *np, int index)
 		goto err0;
 	}
 
-	mm_gc = to_of_mm_gpio_chip(gc);
 	qe_gc = gpiochip_get_data(gc);
 
 	spin_lock_irqsave(&qe_gc->lock, flags);
-- 
2.7.4

