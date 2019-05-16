Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B358EC072A4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 07:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 886222087B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 07:30:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbfEPHaE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 03:30:04 -0400
Received: from regular1.263xmail.com ([211.150.70.195]:50334 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbfEPHaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 03:30:04 -0400
Received: from zhangqing?rock-chips.com (unknown [192.168.167.236])
        by regular1.263xmail.com (Postfix) with ESMTP id 716C0924;
        Thu, 16 May 2019 15:30:01 +0800 (CST)
X-263anti-spam: KSV:0;BIG:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ADDR-CHECKED4: 1
X-ABS-CHECKED: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P6344T140287015487232S1557991797894191_;
        Thu, 16 May 2019 15:30:00 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <a39dff61e996baea3f0bec1f7520f5d4>
X-RL-SENDER: zhangqing@rock-chips.com
X-SENDER: zhangqing@rock-chips.com
X-LOGIN-NAME: zhangqing@rock-chips.com
X-FST-TO: heiko@sntech.de
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From:   Elaine Zhang <zhangqing@rock-chips.com>
To:     heiko@sntech.de
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        xxx@rock-chips.com, xf@rock-chips.com, huangtao@rock-chips.com,
        Elaine Zhang <zhangqing@rock-chips.com>
Subject: [PATCH v2 5/6] clk: rockchip: add pll up and down when change pll freq
Date:   Thu, 16 May 2019 15:29:57 +0800
Message-Id: <1557991797-13652-1-git-send-email-zhangqing@rock-chips.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1557991736-13580-1-git-send-email-zhangqing@rock-chips.com>
References: <1557991736-13580-1-git-send-email-zhangqing@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

set pll sequence:
	->set pll to slow mode or other plls
	->set pll down
	->set pll params
	->set pll up
	->wait pll lock status
	->set pll to normal mode

To slove the system error:
wait_pll_lock: timeout waiting for pll to lock
pll_set_params: pll update unsucessful,
		trying to restore old params

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 drivers/clk/rockchip/clk-pll.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/clk/rockchip/clk-pll.c b/drivers/clk/rockchip/clk-pll.c
index dd0433d4753e..45a64526c78c 100644
--- a/drivers/clk/rockchip/clk-pll.c
+++ b/drivers/clk/rockchip/clk-pll.c
@@ -208,6 +208,11 @@ static int rockchip_rk3036_pll_set_params(struct rockchip_clk_pll *pll,
 		rate_change_remuxed = 1;
 	}
 
+	/* set pll power down */
+	writel(HIWORD_UPDATE(RK3036_PLLCON1_PWRDOWN,
+			     RK3036_PLLCON1_PWRDOWN, 0),
+	       pll->reg_base + RK3036_PLLCON(1));
+
 	/* update pll values */
 	writel_relaxed(HIWORD_UPDATE(rate->fbdiv, RK3036_PLLCON0_FBDIV_MASK,
 					  RK3036_PLLCON0_FBDIV_SHIFT) |
@@ -229,6 +234,11 @@ static int rockchip_rk3036_pll_set_params(struct rockchip_clk_pll *pll,
 	pllcon |= rate->frac << RK3036_PLLCON2_FRAC_SHIFT;
 	writel_relaxed(pllcon, pll->reg_base + RK3036_PLLCON(2));
 
+	/* set pll power up */
+	writel(HIWORD_UPDATE(0, RK3036_PLLCON1_PWRDOWN, 0),
+	       pll->reg_base + RK3036_PLLCON(1));
+	udelay(1);
+
 	/* wait for the pll to lock */
 	ret = rockchip_pll_wait_lock(pll);
 	if (ret) {
@@ -685,6 +695,11 @@ static int rockchip_rk3399_pll_set_params(struct rockchip_clk_pll *pll,
 		rate_change_remuxed = 1;
 	}
 
+	/* set pll power down */
+	writel(HIWORD_UPDATE(RK3399_PLLCON3_PWRDOWN,
+			     RK3399_PLLCON3_PWRDOWN, 0),
+	       pll->reg_base + RK3399_PLLCON(3));
+
 	/* update pll values */
 	writel_relaxed(HIWORD_UPDATE(rate->fbdiv, RK3399_PLLCON0_FBDIV_MASK,
 						  RK3399_PLLCON0_FBDIV_SHIFT),
@@ -708,6 +723,12 @@ static int rockchip_rk3399_pll_set_params(struct rockchip_clk_pll *pll,
 					    RK3399_PLLCON3_DSMPD_SHIFT),
 		       pll->reg_base + RK3399_PLLCON(3));
 
+	/* set pll power up */
+	writel(HIWORD_UPDATE(0,
+			     RK3399_PLLCON3_PWRDOWN, 0),
+	       pll->reg_base + RK3399_PLLCON(3));
+	udelay(1);
+
 	/* wait for the pll to lock */
 	ret = rockchip_rk3399_pll_wait_lock(pll);
 	if (ret) {
-- 
1.9.1



