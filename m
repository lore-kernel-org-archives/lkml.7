Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2059C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 21:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB91E2084B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 21:06:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbfDBVGm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 17:06:42 -0400
Received: from mailoutvs25.siol.net ([185.57.226.216]:37328 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725822AbfDBVGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 17:06:40 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTP id 5A76D521B51;
        Tue,  2 Apr 2019 23:06:37 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta12.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta12.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id rtWZJx-gHcoo; Tue,  2 Apr 2019 23:06:37 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTPS id 15230521B5F;
        Tue,  2 Apr 2019 23:06:37 +0200 (CEST)
Received: from localhost.localdomain (cpe-86-58-52-202.static.triera.net [86.58.52.202])
        (Authenticated sender: 031275009)
        by mail.siol.net (Zimbra) with ESMTPSA id C6117521B51;
        Tue,  2 Apr 2019 23:06:34 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     maxime.ripard@bootlin.com, wens@csie.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, jernej.skrabec@siol.net
Subject: [PATCH 3/3] clk: sunxi-ng: h6: Allow video & vpu clocks to change parent rate
Date:   Tue,  2 Apr 2019 23:06:23 +0200
Message-Id: <20190402210623.14988-4-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190402210623.14988-1-jernej.skrabec@siol.net>
References: <20190402210623.14988-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Video related clocks need to set rate as close as possible to the
requested one, so they should be able to change parent clock rate.

VPU clock sometimes has to be set to higher than default parent clock
rate. This is requ

Add CLK_SET_RATE_PARENT flag to tcon-lcd0, tcon-tv0 and ve.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/clk/sunxi-ng/ccu-sun50i-h6.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c b/drivers/clk/sunxi-ng/=
ccu-sun50i-h6.c
index 33980067b06e..3c32d7798f27 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
@@ -311,7 +311,7 @@ static SUNXI_CCU_M_WITH_MUX_GATE(ve_clk, "ve", ve_par=
ents, 0x690,
 				       0, 3,	/* M */
 				       24, 1,	/* mux */
 				       BIT(31),	/* gate */
-				       0);
+				       CLK_SET_RATE_PARENT);
=20
 static SUNXI_CCU_GATE(bus_ve_clk, "bus-ve", "psi-ahb1-ahb2",
 		      0x69c, BIT(0), 0);
@@ -691,7 +691,7 @@ static SUNXI_CCU_MUX_WITH_GATE(tcon_lcd0_clk, "tcon-l=
cd0",
 			       tcon_lcd0_parents, 0xb60,
 			       24, 3,	/* mux */
 			       BIT(31),	/* gate */
-			       0);
+			       CLK_SET_RATE_PARENT);
=20
 static SUNXI_CCU_GATE(bus_tcon_lcd0_clk, "bus-tcon-lcd0", "ahb3",
 		      0xb7c, BIT(0), 0);
@@ -706,7 +706,7 @@ static SUNXI_CCU_MP_WITH_MUX_GATE(tcon_tv0_clk, "tcon=
-tv0",
 				  8, 2,		/* P */
 				  24, 3,	/* mux */
 				  BIT(31),	/* gate */
-				  0);
+				  CLK_SET_RATE_PARENT);
=20
 static SUNXI_CCU_GATE(bus_tcon_tv0_clk, "bus-tcon-tv0", "ahb3",
 		      0xb9c, BIT(0), 0);
--=20
2.21.0

