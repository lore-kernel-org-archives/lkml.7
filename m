Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE4FC49ED9
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 02:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D66F92171F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 02:43:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbfIKCnH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 22:43:07 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:51194 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726579AbfIKCnG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 22:43:06 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 7AFF71699A46C51D7781;
        Wed, 11 Sep 2019 10:43:05 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.439.0; Wed, 11 Sep 2019 10:42:59 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, <jakub.kicinski@netronome.com>
Subject: [PATCH V2 net-next 3/7] net: hns3: fix shaper parameter algorithm
Date:   Wed, 11 Sep 2019 10:40:35 +0800
Message-ID: <1568169639-43658-4-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1568169639-43658-1-git-send-email-tanhuazhong@huawei.com>
References: <1568169639-43658-1-git-send-email-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.132]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yonglong Liu <liuyonglong@huawei.com>

Currently when hns3 driver configures the tm shaper to limit
bandwidth below 20Mbit using the parameters calculated by
hclge_shaper_para_calc(), the actual bandwidth limited by tm
hardware module is not accurate enough, for example, 1.28 Mbit
when the user is configuring 1 Mbit.

This patch adjusts the ir_calc to be closer to ir, and
always calculate the ir_b parameter when user is configuring
a small bandwidth. Also, removes an unnecessary parenthesis
when calculating denominator.

Fixes: 848440544b41 ("net: hns3: Add support of TX Scheduler & Shaper to HNS3 driver")
Signed-off-by: Yonglong Liu <liuyonglong@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
index e829101..9f0e35f 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
@@ -81,16 +81,13 @@ static int hclge_shaper_para_calc(u32 ir, u8 shaper_level,
 		return 0;
 	} else if (ir_calc > ir) {
 		/* Increasing the denominator to select ir_s value */
-		while (ir_calc > ir) {
+		while (ir_calc >= ir && ir) {
 			ir_s_calc++;
 			ir_calc = DIVISOR_IR_B_126 / (tick * (1 << ir_s_calc));
 		}
 
-		if (ir_calc == ir)
-			*ir_b = 126;
-		else
-			*ir_b = (ir * tick * (1 << ir_s_calc) +
-				 (DIVISOR_CLK >> 1)) / DIVISOR_CLK;
+		*ir_b = (ir * tick * (1 << ir_s_calc) + (DIVISOR_CLK >> 1)) /
+			DIVISOR_CLK;
 	} else {
 		/* Increasing the numerator to select ir_u value */
 		u32 numerator;
@@ -104,7 +101,7 @@ static int hclge_shaper_para_calc(u32 ir, u8 shaper_level,
 		if (ir_calc == ir) {
 			*ir_b = 126;
 		} else {
-			u32 denominator = (DIVISOR_CLK * (1 << --ir_u_calc));
+			u32 denominator = DIVISOR_CLK * (1 << --ir_u_calc);
 			*ir_b = (ir * tick + (denominator >> 1)) / denominator;
 		}
 	}
-- 
2.7.4

