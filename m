Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D53C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 14:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F37E21479
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 14:38:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbfEJOiT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 10:38:19 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7741 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727248AbfEJOiT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 10:38:19 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id F05C7BD70029A2692D3C;
        Fri, 10 May 2019 22:38:04 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Fri, 10 May 2019
 22:37:58 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <linusw@kernel.org>, <kaloz@openwrt.org>, <khalasa@piap.pl>,
        <daniel.lezcano@linaro.org>, <tglx@linutronix.de>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] clocksource/drivers/ixp4xx: Fix build warning
Date:   Fri, 10 May 2019 22:36:09 +0800
Message-ID: <20190510143609.29236-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix gcc build warning:

drivers/clocksource/timer-ixp4xx.c:78:20:
 warning: 'ixp4xx_read_sched_clock' defined but not used [-Wunused-function]

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/clocksource/timer-ixp4xx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clocksource/timer-ixp4xx.c b/drivers/clocksource/timer-ixp4xx.c
index 404445b..96a72e5 100644
--- a/drivers/clocksource/timer-ixp4xx.c
+++ b/drivers/clocksource/timer-ixp4xx.c
@@ -75,10 +75,12 @@ to_ixp4xx_timer(struct clock_event_device *evt)
 	return container_of(evt, struct ixp4xx_timer, clkevt);
 }
 
+#ifdef CONFIG_ARM
 static u64 notrace ixp4xx_read_sched_clock(void)
 {
 	return __raw_readl(local_ixp4xx_timer->base + IXP4XX_OSTS_OFFSET);
 }
+#endif
 
 static u64 ixp4xx_clocksource_read(struct clocksource *c)
 {
-- 
2.7.4


