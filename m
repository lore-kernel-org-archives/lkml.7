Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 728EAC04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 13:47:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C4862146F
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 13:47:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbfE0NrD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 09:47:03 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:59116 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726452AbfE0NrD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 09:47:03 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6849A2532AFB42FAC215;
        Mon, 27 May 2019 21:46:53 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.439.0; Mon, 27 May 2019 21:46:44 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH v2] pwm: rockchip: Use of_clk_get_parent_count()
Date:   Mon, 27 May 2019 21:55:09 +0800
Message-ID: <20190527135509.184544-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190525115941.108309-1-wangkefeng.wang@huawei.com>
References: <20190525115941.108309-1-wangkefeng.wang@huawei.com>
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

Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
v2:
- add include <linux/of_clk.h>
 drivers/pwm/pwm-rockchip.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
index 4d99d468df09..d8f23daca290 100644
--- a/drivers/pwm/pwm-rockchip.c
+++ b/drivers/pwm/pwm-rockchip.c
@@ -13,6 +13,7 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_clk.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pwm.h>
@@ -329,8 +330,8 @@ static int rockchip_pwm_probe(struct platform_device *pdev)
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

