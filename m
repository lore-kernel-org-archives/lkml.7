Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 031EAC33CA1
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 21:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC7A2206DB
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 21:08:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="olAzvIXs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbgAHVH5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 16:07:57 -0500
Received: from o1.b.az.sendgrid.net ([208.117.55.133]:29680 "EHLO
        o1.b.az.sendgrid.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727261AbgAHVHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 16:07:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
        h=from:subject:in-reply-to:references:to:cc:content-type:
        content-transfer-encoding;
        s=001; bh=nAJZakghzr7JwdXt31dydBHC6AGXJnAIYTAyCKaQf5U=;
        b=olAzvIXs+468+uJpM5hc9UydRh8zXgV6l5BJ4Pu4pnK0qL8HTi7bwAV/YQ5/SYgrU7If
        dKnjrsmOOl0+OpQeFTGvu5RKryBjI3l4wLZ7D5dO9g9zH10LNcUmD6kEs1H+6S5/0wbmOo
        RPQUEcWbTxMC0Q2BRp2gq6JrANlf+CzXQ=
Received: by filterdrecv-p3mdw1-56c97568b5-bbmbb with SMTP id filterdrecv-p3mdw1-56c97568b5-bbmbb-18-5E1644A5-10
        2020-01-08 21:07:49.289120385 +0000 UTC m=+1974277.925691392
Received: from bionic.localdomain (unknown [98.128.173.80])
        by ismtpd0005p1lon1.sendgrid.net (SG) with ESMTP id QpQFtE6kTYGCgtswu4iudQ
        Wed, 08 Jan 2020 21:07:49.090 +0000 (UTC)
From:   Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 05/14] phy/rockchip: inno-hdmi: force set_rate on power_on
Date:   Wed, 08 Jan 2020 21:07:49 +0000 (UTC)
Message-Id: <20200108210740.28769-6-jonas@kwiboo.se>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200108210740.28769-1-jonas@kwiboo.se>
References: <20200108210740.28769-1-jonas@kwiboo.se>
X-SG-EID: =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0h=2F7F4adz3wm6ffQRT?=
 =?us-ascii?Q?CTgb+AFqFhunflnZfCfUag8AxDjwfbQB0Wd5dom?=
 =?us-ascii?Q?N1gIXRXtJdfpmpEbksvt+sFcrrxsghs3WuHKyhk?=
 =?us-ascii?Q?LhNzFW7sPbApc2W3EKPZXMTGnvYT34I=2FSX76aqp?=
 =?us-ascii?Q?NnIJt4NNDjQWuZGK3U+j5bZN+X3Vctyx5SLoUv6?=
 =?us-ascii?Q?wFwyfBrk20V4TDwWstJsw=3D=3D?=
To:     Heiko Stuebner <heiko@sntech.de>, Sandy Huang <hjc@rock-chips.com>
Cc:     Jonas Karlman <jonas@kwiboo.se>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Zheng Yang <zhengyang@rock-chips.com>,
        linux-rockchip@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Huicong Xu <xhc@rock-chips.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huicong Xu <xhc@rock-chips.com>

Regular 8-bit and Deep Color video formats mainly differ in TMDS rate and
not in pixel clock rate.
When the hdmiphy clock is configured with the same pixel clock rate using
clk_set_rate() the clock framework do not signal the hdmi phy driver
to set_rate when switching between 8-bit and Deep Color.
This result in pre/post pll not being re-configured when switching between
regular 8-bit and Deep Color video formats.

Fix this by calling set_rate in power_on to force pre pll re-configuration.

Signed-off-by: Huicong Xu <xhc@rock-chips.com>
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/phy/rockchip/phy-rockchip-inno-hdmi.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-hdmi.c b/drivers/phy/rockchip/phy-rockchip-inno-hdmi.c
index 3a59a6da0440..3719309ad0d0 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-hdmi.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-hdmi.c
@@ -245,6 +245,7 @@ struct inno_hdmi_phy {
 	struct clk_hw hw;
 	struct clk *phyclk;
 	unsigned long pixclock;
+	unsigned long tmdsclock;
 };
 
 struct pre_pll_config {
@@ -485,6 +486,8 @@ static int inno_hdmi_phy_power_on(struct phy *phy)
 
 	dev_dbg(inno->dev, "Inno HDMI PHY Power On\n");
 
+	inno->plat_data->clk_ops->set_rate(&inno->hw, inno->pixclock, 24000000);
+
 	ret = clk_prepare_enable(inno->phyclk);
 	if (ret)
 		return ret;
@@ -509,6 +512,8 @@ static int inno_hdmi_phy_power_off(struct phy *phy)
 
 	clk_disable_unprepare(inno->phyclk);
 
+	inno->tmdsclock = 0;
+
 	dev_dbg(inno->dev, "Inno HDMI PHY Power Off\n");
 
 	return 0;
@@ -628,6 +633,9 @@ static int inno_hdmi_phy_rk3228_clk_set_rate(struct clk_hw *hw,
 	dev_dbg(inno->dev, "%s rate %lu tmdsclk %lu\n",
 		__func__, rate, tmdsclock);
 
+	if (inno->pixclock == rate && inno->tmdsclock == tmdsclock)
+		return 0;
+
 	cfg = inno_hdmi_phy_get_pre_pll_cfg(inno, rate);
 	if (IS_ERR(cfg))
 		return PTR_ERR(cfg);
@@ -670,6 +678,7 @@ static int inno_hdmi_phy_rk3228_clk_set_rate(struct clk_hw *hw,
 	}
 
 	inno->pixclock = rate;
+	inno->tmdsclock = tmdsclock;
 
 	return 0;
 }
@@ -781,6 +790,9 @@ static int inno_hdmi_phy_rk3328_clk_set_rate(struct clk_hw *hw,
 	dev_dbg(inno->dev, "%s rate %lu tmdsclk %lu\n",
 		__func__, rate, tmdsclock);
 
+	if (inno->pixclock == rate && inno->tmdsclock == tmdsclock)
+		return 0;
+
 	cfg = inno_hdmi_phy_get_pre_pll_cfg(inno, rate);
 	if (IS_ERR(cfg))
 		return PTR_ERR(cfg);
@@ -820,6 +832,7 @@ static int inno_hdmi_phy_rk3328_clk_set_rate(struct clk_hw *hw,
 	}
 
 	inno->pixclock = rate;
+	inno->tmdsclock = tmdsclock;
 
 	return 0;
 }
-- 
2.17.1

