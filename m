Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 475EFC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 20:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2287B218CD
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 20:03:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733202AbfB1UDp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 15:03:45 -0500
Received: from mailoutvs40.siol.net ([185.57.226.231]:39877 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728140AbfB1UDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 15:03:43 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id E305D5223FB;
        Thu, 28 Feb 2019 21:03:40 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta11.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta11.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id sag1oejWLRao; Thu, 28 Feb 2019 21:03:40 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 8FFB452222D;
        Thu, 28 Feb 2019 21:03:40 +0100 (CET)
Received: from localhost.localdomain (cpe-86-58-52-202.static.triera.net [86.58.52.202])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id 0BFAA522335;
        Thu, 28 Feb 2019 21:03:38 +0100 (CET)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     maxime.ripard@bootlin.com, wens@csie.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org, airlied@linux.ie,
        daniel@ffwll.ch, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-sunxi@googlegroups.com
Subject: [PATCH 1/3] clk: sunxi-ng: Allow DE clock to set parent rate
Date:   Thu, 28 Feb 2019 21:03:27 +0100
Message-Id: <20190228200329.11128-2-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190228200329.11128-1-jernej.skrabec@siol.net>
References: <20190228200329.11128-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DE2/DE3 mixers have to run at specific frequency in order to work
optimally. This wasn't actually possible for some SoCs because "de"
clock wasn't allowed to adjust parent rate.

Add CLK_SET_RATE_PARENT flag to all "de" clocks which didn't have it
yet.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/clk/sunxi-ng/ccu-sun50i-a64.c | 3 ++-
 drivers/clk/sunxi-ng/ccu-sun50i-h6.c  | 2 +-
 drivers/clk/sunxi-ng/ccu-sun8i-v3s.c  | 3 ++-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c b/drivers/clk/sunxi-ng=
/ccu-sun50i-a64.c
index 932836d26e2b..be0deee70182 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
@@ -531,7 +531,8 @@ static SUNXI_CCU_GATE(dram_ts_clk,	"dram-ts",	"dram",
=20
 static const char * const de_parents[] =3D { "pll-periph0-2x", "pll-de" =
};
 static SUNXI_CCU_M_WITH_MUX_GATE(de_clk, "de", de_parents,
-				 0x104, 0, 4, 24, 3, BIT(31), 0);
+				 0x104, 0, 4, 24, 3, BIT(31),
+				 CLK_SET_RATE_PARENT);
=20
 static const char * const tcon0_parents[] =3D { "pll-mipi", "pll-video0-=
2x" };
 static const u8 tcon0_table[] =3D { 0, 2, };
diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c b/drivers/clk/sunxi-ng/=
ccu-sun50i-h6.c
index 139e8389615c..daf78966555e 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
@@ -266,7 +266,7 @@ static SUNXI_CCU_M_WITH_MUX_GATE(de_clk, "de", de_par=
ents, 0x600,
 				       0, 4,	/* M */
 				       24, 1,	/* mux */
 				       BIT(31),	/* gate */
-				       0);
+				       CLK_SET_RATE_PARENT);
=20
 static SUNXI_CCU_GATE(bus_de_clk, "bus-de", "psi-ahb1-ahb2",
 		      0x60c, BIT(0), 0);
diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c b/drivers/clk/sunxi-ng/=
ccu-sun8i-v3s.c
index ac12f261f8ca..eada0e291859 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c
@@ -325,7 +325,8 @@ static SUNXI_CCU_GATE(dram_ohci_clk,	"dram-ohci",	"dr=
am",
=20
 static const char * const de_parents[] =3D { "pll-video", "pll-periph0" =
};
 static SUNXI_CCU_M_WITH_MUX_GATE(de_clk, "de", de_parents,
-				 0x104, 0, 4, 24, 2, BIT(31), 0);
+				 0x104, 0, 4, 24, 2, BIT(31),
+				 CLK_SET_RATE_PARENT);
=20
 static const char * const tcon_parents[] =3D { "pll-video" };
 static SUNXI_CCU_M_WITH_MUX_GATE(tcon_clk, "tcon", tcon_parents,
--=20
2.20.1

