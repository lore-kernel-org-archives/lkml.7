Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C901C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 21:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65D8520856
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 21:06:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbfDBVGk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 17:06:40 -0400
Received: from mailoutvs58.siol.net ([185.57.226.249]:37305 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726584AbfDBVGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 17:06:38 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTP id 1D8B3521AA0;
        Tue,  2 Apr 2019 23:06:35 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta12.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta12.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 7aHKU8lrfJUg; Tue,  2 Apr 2019 23:06:34 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTPS id BF215521A6C;
        Tue,  2 Apr 2019 23:06:34 +0200 (CEST)
Received: from localhost.localdomain (cpe-86-58-52-202.static.triera.net [86.58.52.202])
        (Authenticated sender: 031275009)
        by mail.siol.net (Zimbra) with ESMTPSA id 7BB10521AA0;
        Tue,  2 Apr 2019 23:06:32 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     maxime.ripard@bootlin.com, wens@csie.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, jernej.skrabec@siol.net
Subject: [PATCH 2/3] clk: sunxi-ng: h6: Preset hdmi-cec clock parent
Date:   Tue,  2 Apr 2019 23:06:22 +0200
Message-Id: <20190402210623.14988-3-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190402210623.14988-1-jernej.skrabec@siol.net>
References: <20190402210623.14988-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

H6 manual and BSP clock driver both states that hdmi-cec clock has two
possible parents, osc32k and pll-periph0-2x with 36621 predivider.
Because pll-periph0-2x is always 1.2 GHz, both parents give same
hdmi-cec rate - 32768 Hz, which is exactly the rate needed for HDMI CEC
controller to operate correctly.

However, for some reason, HDMI CEC controller doesn't work if default
parent (osc32k) is used. BSP HDMI driver also always use pll-periph0-2x
as hdmi-cec clock parent.

In order to solve the issue, preset hdmi-cec clock parent to
pll-periph0-2x.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/clk/sunxi-ng/ccu-sun50i-h6.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c b/drivers/clk/sunxi-ng/=
ccu-sun50i-h6.c
index daf78966555e..33980067b06e 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
@@ -656,6 +656,8 @@ static const char * const hdmi_cec_parents[] =3D { "o=
sc32k", "pll-periph0-2x" };
 static const struct ccu_mux_fixed_prediv hdmi_cec_predivs[] =3D {
 	{ .index =3D 1, .div =3D 36621 },
 };
+
+#define SUN50I_H6_HDMI_CEC_CLK_REG		0xb10
 static struct ccu_mux hdmi_cec_clk =3D {
 	.enable		=3D BIT(31),
=20
@@ -1200,6 +1202,15 @@ static int sun50i_h6_ccu_probe(struct platform_dev=
ice *pdev)
 	val &=3D ~(GENMASK(21, 16) | BIT(0));
 	writel(val | (7 << 16), reg + SUN50I_H6_PLL_AUDIO_REG);
=20
+	/*
+	 * First clock parent (osc32K) is unusable for CEC. But since there
+	 * is no good way to force parent switch (both run with same frequency)=
,
+	 * just set second clock parent here.
+	 */
+	val =3D readl(reg + SUN50I_H6_HDMI_CEC_CLK_REG);
+	val |=3D BIT(24);
+	writel(val, reg + SUN50I_H6_HDMI_CEC_CLK_REG);
+
 	return sunxi_ccu_probe(pdev->dev.of_node, reg, &sun50i_h6_ccu_desc);
 }
=20
--=20
2.21.0

