Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF9CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 14:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B045121904
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 14:40:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728924AbfCVOkP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 10:40:15 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5174 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728114AbfCVOkO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 10:40:14 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 9E144FB82EAEB4EA0EE1;
        Fri, 22 Mar 2019 22:40:10 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.408.0; Fri, 22 Mar 2019
 22:39:55 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <nicolas.ferre@microchip.com>, <daniel.lezcano@linaro.org>,
        <tglx@linutronix.de>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] clocksource: tcb_clksrc: Make tc_clksrc_suspend and tc_clksrc_resume static
Date:   Fri, 22 Mar 2019 22:39:40 +0800
Message-ID: <20190322143940.12396-1-yuehaibing@huawei.com>
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

drivers/clocksource/tcb_clksrc.c:74:6: warning:
 symbol 'tc_clksrc_suspend' was not declared. Should it be static?
drivers/clocksource/tcb_clksrc.c:89:6: warning:
 symbol 'tc_clksrc_resume' was not declared. Should it be static?

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/clocksource/tcb_clksrc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/tcb_clksrc.c b/drivers/clocksource/tcb_clksrc.c
index 43f4d5c..f987027 100644
--- a/drivers/clocksource/tcb_clksrc.c
+++ b/drivers/clocksource/tcb_clksrc.c
@@ -71,7 +71,7 @@ static u64 tc_get_cycles32(struct clocksource *cs)
 	return readl_relaxed(tcaddr + ATMEL_TC_REG(0, CV));
 }
 
-void tc_clksrc_suspend(struct clocksource *cs)
+static void tc_clksrc_suspend(struct clocksource *cs)
 {
 	int i;
 
@@ -86,7 +86,7 @@ void tc_clksrc_suspend(struct clocksource *cs)
 	bmr_cache = readl(tcaddr + ATMEL_TC_BMR);
 }
 
-void tc_clksrc_resume(struct clocksource *cs)
+static void tc_clksrc_resume(struct clocksource *cs)
 {
 	int i;
 
-- 
2.7.0


