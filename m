Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A01C31E5E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 07:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D21A121479
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 07:11:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731152AbfFSHLD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 03:11:03 -0400
Received: from inva020.nxp.com ([92.121.34.13]:48558 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725892AbfFSHLC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 03:11:02 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 3FBA61A05A1;
        Wed, 19 Jun 2019 09:10:58 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 2B68A1A05A3;
        Wed, 19 Jun 2019 09:10:52 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 6BD8D402F0;
        Wed, 19 Jun 2019 15:10:44 +0800 (SGT)
From:   Anson.Huang@nxp.com
To:     mturquette@baylibre.com, sboyd@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        abel.vesa@nxp.com, ccaione@baylibre.com, leonard.crestez@nxp.com,
        aisheng.dong@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 1/2] clk: imx: Remove __init for imx_register_uart_clocks() API
Date:   Wed, 19 Jun 2019 15:12:39 +0800
Message-Id: <20190619071240.38503-1-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anson Huang <Anson.Huang@nxp.com>

Some of i.MX SoCs' clock driver use platform driver model,
and they need to call imx_register_uart_clocks() API, so
imx_register_uart_clocks() API should NOT be in .init section.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/clk/imx/clk.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/imx/clk.c b/drivers/clk/imx/clk.c
index f241189..76457b2 100644
--- a/drivers/clk/imx/clk.c
+++ b/drivers/clk/imx/clk.c
@@ -123,8 +123,8 @@ void imx_cscmr1_fixup(u32 *val)
 	return;
 }
 
-static int imx_keep_uart_clocks __initdata;
-static struct clk ** const *imx_uart_clocks __initdata;
+static int imx_keep_uart_clocks;
+static struct clk ** const *imx_uart_clocks;
 
 static int __init imx_keep_uart_clocks_param(char *str)
 {
@@ -137,7 +137,7 @@ __setup_param("earlycon", imx_keep_uart_earlycon,
 __setup_param("earlyprintk", imx_keep_uart_earlyprintk,
 	      imx_keep_uart_clocks_param, 0);
 
-void __init imx_register_uart_clocks(struct clk ** const clks[])
+void imx_register_uart_clocks(struct clk ** const clks[])
 {
 	if (imx_keep_uart_clocks) {
 		int i;
-- 
2.7.4

