Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2048C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 14:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C0A321707
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 14:32:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbfD3OcK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 10:32:10 -0400
Received: from gateway22.websitewelcome.com ([192.185.46.152]:14299 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726916AbfD3OcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 10:32:09 -0400
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway22.websitewelcome.com (Postfix) with ESMTP id BF0BF553F
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 09:32:07 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id LTnjhMl0jYTGMLTnjhRfpK; Tue, 30 Apr 2019 09:32:07 -0500
X-Authority-Reason: nr=8
Received: from [189.250.119.203] (port=51452 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hLTni-001KJq-JX; Tue, 30 Apr 2019 09:32:06 -0500
Date:   Tue, 30 Apr 2019 09:32:06 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] clk: imx: clk-pllv3: mark expected switch fall-throughs
Message-ID: <20190430143206.GA4035@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.119.203
X-Source-L: No
X-Exim-ID: 1hLTni-001KJq-JX
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.119.203]:51452
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 10
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch
cases where we are expecting to fall through.

This patch fixes the following warnings:

drivers/clk/imx/clk-pllv3.c: In function ‘imx_clk_pllv3’:
drivers/clk/imx/clk-pllv3.c:446:18: warning: this statement may fall through [-Wimplicit-fallthrough=]
   pll->div_shift = 1;
   ~~~~~~~~~~~~~~~^~~
drivers/clk/imx/clk-pllv3.c:447:2: note: here
  case IMX_PLLV3_USB:
  ^~~~
drivers/clk/imx/clk-pllv3.c:453:21: warning: this statement may fall through [-Wimplicit-fallthrough=]
   pll->denom_offset = PLL_IMX7_DENOM_OFFSET;
                     ^
drivers/clk/imx/clk-pllv3.c:454:2: note: here
  case IMX_PLLV3_AV:
  ^~~~

Warning level 3 was used: -Wimplicit-fallthrough=3

This patch is part of the ongoing efforts to enable
-Wimplicit-fallthrough.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/clk/imx/clk-pllv3.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/imx/clk-pllv3.c b/drivers/clk/imx/clk-pllv3.c
index e892b9a836e5..4110e713d259 100644
--- a/drivers/clk/imx/clk-pllv3.c
+++ b/drivers/clk/imx/clk-pllv3.c
@@ -444,6 +444,7 @@ struct clk *imx_clk_pllv3(enum imx_pllv3_type type, const char *name,
 		break;
 	case IMX_PLLV3_USB_VF610:
 		pll->div_shift = 1;
+		/* fall through */
 	case IMX_PLLV3_USB:
 		ops = &clk_pllv3_ops;
 		pll->powerup_set = true;
@@ -451,6 +452,7 @@ struct clk *imx_clk_pllv3(enum imx_pllv3_type type, const char *name,
 	case IMX_PLLV3_AV_IMX7:
 		pll->num_offset = PLL_IMX7_NUM_OFFSET;
 		pll->denom_offset = PLL_IMX7_DENOM_OFFSET;
+		/* fall through */
 	case IMX_PLLV3_AV:
 		ops = &clk_pllv3_av_ops;
 		break;
-- 
2.21.0

