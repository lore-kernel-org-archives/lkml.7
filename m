Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D2C7C28CC2
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 07:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB327241B6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 07:55:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbfEaHzB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 03:55:01 -0400
Received: from inva021.nxp.com ([92.121.34.21]:47488 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbfEaHzA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 03:55:00 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 3E67A200797;
        Fri, 31 May 2019 09:54:55 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id ECBCC2007A8;
        Fri, 31 May 2019 09:54:49 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 310E040307;
        Fri, 31 May 2019 15:54:43 +0800 (SGT)
From:   peng.fan@nxp.com
To:     mturquette@baylibre.com, sboyd@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        stable@vger.kernel.org
Subject: [PATCH RESEND] clk: imx: imx8mm: correct audio_pll2_clk to audio_pll2_out
Date:   Fri, 31 May 2019 15:56:38 +0800
Message-Id: <20190531075638.7892-1-peng.fan@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

There is no audio_pll2_clk registered, it should be audio_pll2_out.

Cc: <stable@vger.kernel.org>
Fixes: ba5625c3e27 ("clk: imx: Add clock driver support for imx8mm")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx8mm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8mm.c b/drivers/clk/imx/clk-imx8mm.c
index 1ef8438e3d6d..3a889846a05c 100644
--- a/drivers/clk/imx/clk-imx8mm.c
+++ b/drivers/clk/imx/clk-imx8mm.c
@@ -325,7 +325,7 @@ static const char *imx8mm_dsi_dbi_sels[] = {"osc_24m", "sys_pll1_266m", "sys_pll
 					    "sys_pll2_1000m", "sys_pll3_out", "audio_pll2_out", "video_pll1_out", };
 
 static const char *imx8mm_usdhc3_sels[] = {"osc_24m", "sys_pll1_400m", "sys_pll1_800m", "sys_pll2_500m",
-					   "sys_pll3_out", "sys_pll1_266m", "audio_pll2_clk", "sys_pll1_100m", };
+					   "sys_pll3_out", "sys_pll1_266m", "audio_pll2_out", "sys_pll1_100m", };
 
 static const char *imx8mm_csi1_core_sels[] = {"osc_24m", "sys_pll1_266m", "sys_pll2_250m", "sys_pll1_800m",
 					      "sys_pll2_1000m", "sys_pll3_out", "audio_pll2_out", "video_pll1_out", };
@@ -361,11 +361,11 @@ static const char *imx8mm_pdm_sels[] = {"osc_24m", "sys_pll2_100m", "audio_pll1_
 					"sys_pll2_1000m", "sys_pll3_out", "clk_ext3", "audio_pll2_out", };
 
 static const char *imx8mm_vpu_h1_sels[] = {"osc_24m", "vpu_pll_out", "sys_pll1_800m", "sys_pll2_1000m",
-					   "audio_pll2_clk", "sys_pll2_125m", "sys_pll3_clk", "audio_pll1_out", };
+					   "audio_pll2_out", "sys_pll2_125m", "sys_pll3_clk", "audio_pll1_out", };
 
 static const char *imx8mm_dram_core_sels[] = {"dram_pll_out", "dram_alt_root", };
 
-static const char *imx8mm_clko1_sels[] = {"osc_24m", "sys_pll1_800m", "osc_27m", "sys_pll1_200m", "audio_pll2_clk",
+static const char *imx8mm_clko1_sels[] = {"osc_24m", "sys_pll1_800m", "osc_27m", "sys_pll1_200m", "audio_pll2_out",
 					 "vpu_pll", "sys_pll1_80m", };
 
 static struct clk *clks[IMX8MM_CLK_END];
-- 
2.16.4

