Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81A20C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 14:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56298218A5
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 14:37:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729076AbfCVOhg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 10:37:36 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5732 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728114AbfCVOhf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 10:37:35 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id D050F46EA5DC4700DC55;
        Fri, 22 Mar 2019 22:37:33 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.408.0; Fri, 22 Mar 2019
 22:37:24 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <daniel.lezcano@linaro.org>, <tglx@linutronix.de>,
        <shc_work@mail.ru>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] clocksource: clps711x: Make clps711x_clksrc_init static
Date:   Fri, 22 Mar 2019 22:37:08 +0800
Message-ID: <20190322143708.12716-1-yuehaibing@huawei.com>
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

Fix sparse warning:

drivers/clocksource/clps711x-timer.c:96:13: warning:
 symbol 'clps711x_clksrc_init' was not declared. Should it be static?

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/clocksource/clps711x-timer.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/clps711x-timer.c b/drivers/clocksource/clps711x-timer.c
index a8dd805..cdc2515 100644
--- a/drivers/clocksource/clps711x-timer.c
+++ b/drivers/clocksource/clps711x-timer.c
@@ -93,8 +93,9 @@ static int __init _clps711x_clkevt_init(struct clk *clock, void __iomem *base,
 			   "clps711x-timer", clkevt);
 }
 
-void __init clps711x_clksrc_init(void __iomem *tc1_base, void __iomem *tc2_base,
-				 unsigned int irq)
+static void __init clps711x_clksrc_init(void __iomem *tc1_base,
+					void __iomem *tc2_base,
+					unsigned int irq)
 {
 	struct clk *tc1 = clk_get_sys("clps711x-timer.0", NULL);
 	struct clk *tc2 = clk_get_sys("clps711x-timer.1", NULL);
-- 
2.7.0


