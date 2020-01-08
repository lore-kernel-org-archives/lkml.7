Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DBDEC47409
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 01:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F35A2075A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 01:57:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgAHB5u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 20:57:50 -0500
Received: from inva021.nxp.com ([92.121.34.21]:52374 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725601AbgAHB5u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 20:57:50 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id BD1402002C6;
        Wed,  8 Jan 2020 02:57:47 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 70EFC2001C3;
        Wed,  8 Jan 2020 02:57:32 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 2478840285;
        Wed,  8 Jan 2020 09:57:18 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, catalin.marinas@arm.com,
        will@kernel.org, bjorn.andersson@linaro.org, olof@lixom.net,
        maxime@cerno.tech, leonard.crestez@nxp.com, dinguyen@kernel.org,
        marcin.juszkiewicz@linaro.org, ping.bai@nxp.com, abel.vesa@nxp.com,
        nsekhar@ti.com, t-kristo@ti.com, peng.fan@nxp.com,
        yuehaibing@huawei.com, aisheng.dong@nxp.com, sfr@canb.auug.org.au,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V3 1/4] clk: imx: gate4: Switch imx_clk_gate4_flags() to clk_hw based API
Date:   Wed,  8 Jan 2020 09:53:34 +0800
Message-Id: <1578448417-17760-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch the imx_clk_gate4_flags() function to clk_hw based API, rename
accordingly and add a macro for clk based legacy. This allows us to
move closer to a clear split between consumer and provider clk APIs.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
Changes since V2:
	- Switch to latest i.MX clock driver base to redo the patch.
---
 drivers/clk/imx/clk.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 65d80c6..b05213b 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -390,15 +390,18 @@ static inline struct clk_hw *imx_clk_hw_gate4(const char *name, const char *pare
 			reg, shift, 0x3, 0, &imx_ccm_lock, NULL);
 }
 
-static inline struct clk *imx_clk_gate4_flags(const char *name,
+static inline struct clk_hw *imx_clk_hw_gate4_flags(const char *name,
 		const char *parent, void __iomem *reg, u8 shift,
 		unsigned long flags)
 {
-	return clk_register_gate2(NULL, name, parent,
+	return clk_hw_register_gate2(NULL, name, parent,
 			flags | CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
 			reg, shift, 0x3, 0, &imx_ccm_lock, NULL);
 }
 
+#define imx_clk_gate4_flags(name, parent, reg, shift, flags) \
+	to_clk(imx_clk_hw_gate4_flags(name, parent, reg, shift, flags))
+
 static inline struct clk_hw *imx_clk_hw_mux(const char *name, void __iomem *reg,
 			u8 shift, u8 width, const char * const *parents,
 			int num_parents)
-- 
2.7.4

