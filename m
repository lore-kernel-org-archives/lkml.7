Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B42E1C04AB3
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 10:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 826D22086A
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 10:03:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbfELKDp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 06:03:45 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7192 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726027AbfELKDp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 06:03:45 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 9FCC9D4FE40948A7E3FE;
        Sun, 12 May 2019 18:03:40 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Sun, 12 May 2019
 18:03:33 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <t-kristo@ti.com>, <mturquette@baylibre.com>, <sboyd@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] clk: ti: Remove unused function ti_clk_build_component_gate
Date:   Sun, 12 May 2019 18:03:28 +0800
Message-ID: <20190512100328.27136-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no callers in tree, so can be removed.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/clk/ti/gate.c | 30 ------------------------------
 1 file changed, 30 deletions(-)

diff --git a/drivers/clk/ti/gate.c b/drivers/clk/ti/gate.c
index 504c0e9..4238955 100644
--- a/drivers/clk/ti/gate.c
+++ b/drivers/clk/ti/gate.c
@@ -131,36 +131,6 @@ static struct clk *_register_gate(struct device *dev, const char *name,
 	return clk;
 }
 
-struct clk_hw *ti_clk_build_component_gate(struct ti_clk_gate *setup)
-{
-	struct clk_hw_omap *gate;
-	struct clk_omap_reg *reg;
-	const struct clk_hw_omap_ops *ops = &clkhwops_wait;
-
-	if (!setup)
-		return NULL;
-
-	gate = kzalloc(sizeof(*gate), GFP_KERNEL);
-	if (!gate)
-		return ERR_PTR(-ENOMEM);
-
-	reg = (struct clk_omap_reg *)&gate->enable_reg;
-	reg->index = setup->module;
-	reg->offset = setup->reg;
-
-	gate->enable_bit = setup->bit_shift;
-
-	if (setup->flags & CLKF_NO_WAIT)
-		ops = NULL;
-
-	if (setup->flags & CLKF_INTERFACE)
-		ops = &clkhwops_iclk_wait;
-
-	gate->ops = ops;
-
-	return &gate->hw;
-}
-
 static void __init _of_ti_gate_clk_setup(struct device_node *node,
 					 const struct clk_ops *ops,
 					 const struct clk_hw_omap_ops *hw_ops)
-- 
2.7.4


