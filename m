Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B71BC48BE7
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 06:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BC1C20844
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 06:21:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729070AbfGHGVO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 02:21:14 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:65136 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727218AbfGHGVN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 02:21:13 -0400
Received: from mse-fl1.zte.com.cn (unknown [10.30.14.238])
        by Forcepoint Email with ESMTPS id 2FF41269E9930AADFF56;
        Mon,  8 Jul 2019 14:21:11 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse-fl1.zte.com.cn with ESMTP id x686Kqld015540;
        Mon, 8 Jul 2019 14:20:52 +0800 (GMT-8)
        (envelope-from wen.yang99@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019070814205323-2164429 ;
          Mon, 8 Jul 2019 14:20:53 +0800 
From:   Wen Yang <wen.yang99@zte.com.cn>
To:     linux-kernel@vger.kernel.org
Cc:     xue.zhihong@zte.com.cn, wang.yi59@zte.com.cn,
        cheng.shengyu@zte.com.cn, Wen Yang <wen.yang99@zte.com.cn>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Roger Quadros <rogerq@ti.com>
Subject: [PATCH] phy: ti: am654-serdes: fix an use-after-free in serdes_am654_clk_register()
Date:   Mon, 8 Jul 2019 14:19:05 +0800
Message-Id: <1562566745-7447-4-git-send-email-wen.yang99@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1562566745-7447-1-git-send-email-wen.yang99@zte.com.cn>
References: <1562566745-7447-1-git-send-email-wen.yang99@zte.com.cn>
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-07-08 14:20:53,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-07-08 14:20:53,
        Serialize complete at 2019-07-08 14:20:53
X-MAIL: mse-fl1.zte.com.cn x686Kqld015540
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The regmap_node variable is still being used in the syscon_node_to_regmap()
call after the of_node_put() call, which may result in use-after-free.

Fixes: 71e2f5c5c224 ("phy: ti: Add a new SERDES driver for TI's AM654x SoC")
Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Roger Quadros <rogerq@ti.com>
Cc: linux-kernel@vger.kernel.org
---
 drivers/phy/ti/phy-am654-serdes.c | 33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/drivers/phy/ti/phy-am654-serdes.c b/drivers/phy/ti/phy-am654-serdes.c
index f8edd08..f14f1f0 100644
--- a/drivers/phy/ti/phy-am654-serdes.c
+++ b/drivers/phy/ti/phy-am654-serdes.c
@@ -405,6 +405,7 @@ static int serdes_am654_clk_register(struct serdes_am654 *am654_phy,
 	const __be32 *addr;
 	unsigned int reg;
 	struct clk *clk;
+	int ret = 0;
 
 	mux = devm_kzalloc(dev, sizeof(*mux), GFP_KERNEL);
 	if (!mux)
@@ -413,34 +414,40 @@ static int serdes_am654_clk_register(struct serdes_am654 *am654_phy,
 	init = &mux->clk_data;
 
 	regmap_node = of_parse_phandle(node, "ti,serdes-clk", 0);
-	of_node_put(regmap_node);
 	if (!regmap_node) {
 		dev_err(dev, "Fail to get serdes-clk node\n");
-		return -ENODEV;
+		ret = -ENODEV;
+		goto out_put_node;
 	}
 
 	regmap = syscon_node_to_regmap(regmap_node->parent);
 	if (IS_ERR(regmap)) {
 		dev_err(dev, "Fail to get Syscon regmap\n");
-		return PTR_ERR(regmap);
+		ret = PTR_ERR(regmap);
+		goto out_put_node;
 	}
 
 	num_parents = of_clk_get_parent_count(node);
 	if (num_parents < 2) {
 		dev_err(dev, "SERDES clock must have parents\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto out_put_node;
 	}
 
 	parent_names = devm_kzalloc(dev, (sizeof(char *) * num_parents),
 				    GFP_KERNEL);
-	if (!parent_names)
-		return -ENOMEM;
+	if (!parent_names) {
+		ret = -ENOMEM;
+		goto out_put_node;
+	}
 
 	of_clk_parent_fill(node, parent_names, num_parents);
 
 	addr = of_get_address(regmap_node, 0, NULL, NULL);
-	if (!addr)
-		return -EINVAL;
+	if (!addr) {
+		ret = -EINVAL;
+		goto out_put_node;
+	}
 
 	reg = be32_to_cpu(*addr);
 
@@ -456,12 +463,16 @@ static int serdes_am654_clk_register(struct serdes_am654 *am654_phy,
 	mux->hw.init = init;
 
 	clk = devm_clk_register(dev, &mux->hw);
-	if (IS_ERR(clk))
-		return PTR_ERR(clk);
+	if (IS_ERR(clk)) {
+		ret = PTR_ERR(clk);
+		goto out_put_node;
+	}
 
 	am654_phy->clks[clock_num] = clk;
 
-	return 0;
+out_put_node:
+	of_node_put(regmap_node);
+	return ret;
 }
 
 static const struct of_device_id serdes_am654_id_table[] = {
-- 
2.9.5

