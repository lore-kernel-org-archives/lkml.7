Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89CFCC10F00
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 07:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 655EB21871
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 07:39:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728494AbfCOHj3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 03:39:29 -0400
Received: from cmccmta3.chinamobile.com ([221.176.66.81]:10939 "EHLO
        cmccmta3.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727250AbfCOHj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 03:39:29 -0400
X-Greylist: delayed 562 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 Mar 2019 03:39:22 EDT
Received: from spf.mail.chinamobile.com (unknown[172.16.121.3]) by rmmx-syy-dmz-app11-12011 (RichMail) with SMTP id 2eeb5c8b5474f7d-21837; Fri, 15 Mar 2019 15:29:57 +0800 (CST)
X-RM-TRANSID: 2eeb5c8b5474f7d-21837
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.105.0.243])
        by rmsmtp-syy-appsvr02-12002 (RichMail) with SMTP id 2ee25c8b5474f84-757aa;
        Fri, 15 Mar 2019 15:29:57 +0800 (CST)
X-RM-TRANSID: 2ee25c8b5474f84-757aa
From:   Ding Xiang <dingxiang@cmss.chinamobile.com>
To:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] clk: davinci: cfgchip: use PTR_ERR_OR_ZERO in da8xx_cfgchip_register_div4p5
Date:   Fri, 15 Mar 2019 15:29:24 +0800
Message-Id: <1552634964-11049-1-git-send-email-dingxiang@cmss.chinamobile.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

use PTR_ERR_OR_ZERO inetead of return code

Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
---
 drivers/clk/davinci/da8xx-cfgchip.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/clk/davinci/da8xx-cfgchip.c b/drivers/clk/davinci/da8xx-cfgchip.c
index d1bbee1..bdc5236 100644
--- a/drivers/clk/davinci/da8xx-cfgchip.c
+++ b/drivers/clk/davinci/da8xx-cfgchip.c
@@ -160,10 +160,8 @@ static int __init da8xx_cfgchip_register_div4p5(struct device *dev,
 	struct da8xx_cfgchip_gate_clk *gate;
 
 	gate = da8xx_cfgchip_gate_clk_register(dev, &da8xx_div4p5ena_info, regmap);
-	if (IS_ERR(gate))
-		return PTR_ERR(gate);
 
-	return 0;
+	return PTR_ERR_OR_ZERO(gate);
 }
 
 static int __init
-- 
1.9.1



