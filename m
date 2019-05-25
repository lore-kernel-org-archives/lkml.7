Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3CB1C282CE
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 11:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF3512175B
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 11:51:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbfEYLvV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 07:51:21 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:37064 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726755AbfEYLvV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 07:51:21 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id CF4CF4CABD714DBE3852;
        Sat, 25 May 2019 19:51:15 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.439.0; Sat, 25 May 2019 19:51:07 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH] pwm: rockchip: Use of_clk_get_parent_count()
Date:   Sat, 25 May 2019 19:59:41 +0800
Message-ID: <20190525115941.108309-1-wangkefeng.wang@huawei.com>
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

Use of_clk_get_parent_count() instead of open coding.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/pwm/pwm-rockchip.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
index 4d99d468df09..a0fbb9a139bd 100644
--- a/drivers/pwm/pwm-rockchip.c
+++ b/drivers/pwm/pwm-rockchip.c
@@ -329,8 +329,8 @@ static int rockchip_pwm_probe(struct platform_device *pdev)
 		}
 	}
 
-	count = of_count_phandle_with_args(pdev->dev.of_node,
-					   "clocks", "#clock-cells");
+	count = of_clk_get_parent_count(pdev->dev.of_node);
+
 	if (count == 2)
 		pc->pclk = devm_clk_get(&pdev->dev, "pclk");
 	else
-- 
2.20.1

