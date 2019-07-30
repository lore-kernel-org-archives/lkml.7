Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC4BCC0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 07:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 979F62087F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 07:23:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729057AbfG3HXF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 03:23:05 -0400
Received: from inva020.nxp.com ([92.121.34.13]:37796 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727527AbfG3HXE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 03:23:04 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id AF3621A05CF;
        Tue, 30 Jul 2019 09:23:02 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A30DF1A05C0;
        Tue, 30 Jul 2019 09:23:02 +0200 (CEST)
Received: from fsr-ub1664-175.ea.freescale.net (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 2C2EF204D6;
        Tue, 30 Jul 2019 09:23:02 +0200 (CEST)
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Guido Gunther <agx@sigxcpu.org>,
        Anson Huang <anson.huang@nxp.com>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH v3] clk: imx8mq: Mark AHB clock as critical
Date:   Tue, 30 Jul 2019 10:22:55 +0300
Message-Id: <1564471375-6736-1-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initially, the TMU_ROOT clock was marked as critical, which automatically
made the AHB clock to stay always on. Since the TMU_ROOT clock is not
marked as critical anymore, following commit:

431bdd1df48e ("clk: imx8mq: Remove CLK_IS_CRITICAL flag for IMX8MQ_CLK_TMU_ROOT")

all the clocks that derive from ipg_root clock (and implicitly ahb clock)
would also have to enable, along with their own gate, the AHB clock.

But considering that AHB is actually a bus that has to be always on, we mark
it as critical in the clock provider driver and then all the clocks that
derive from it can be controlled through the dedicated per IP gate which
follows after the ipg_root clock.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Tested-by: Daniel Baluta <daniel.baluta@nxp.com>
Fixes: 431bdd1df48e ("clk: imx8mq: Remove CLK_IS_CRITICAL flag for IMX8MQ_CLK_TMU_ROOT")
---

Changes since v2:
 * added a more detailed commit message and mentioned the commit
   that this change is fixing

 drivers/clk/imx/clk-imx8mq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx8mq.c b/drivers/clk/imx/clk-imx8mq.c
index 4328c22..04302f2 100644
--- a/drivers/clk/imx/clk-imx8mq.c
+++ b/drivers/clk/imx/clk-imx8mq.c
@@ -406,7 +406,8 @@ static int imx8mq_clocks_probe(struct platform_device *pdev)
 	clks[IMX8MQ_CLK_NOC_APB] = imx8m_clk_composite_critical("noc_apb", imx8mq_noc_apb_sels, base + 0x8d80);
 
 	/* AHB */
-	clks[IMX8MQ_CLK_AHB] = imx8m_clk_composite("ahb", imx8mq_ahb_sels, base + 0x9000);
+	/* AHB clock is used by the AHB bus therefore marked as critical */
+	clks[IMX8MQ_CLK_AHB] = imx8m_clk_composite_critical("ahb", imx8mq_ahb_sels, base + 0x9000);
 	clks[IMX8MQ_CLK_AUDIO_AHB] = imx8m_clk_composite("audio_ahb", imx8mq_audio_ahb_sels, base + 0x9100);
 
 	/* IPG */
-- 
2.7.4

