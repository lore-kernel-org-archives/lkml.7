Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87ED1C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55A542082C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:35:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730547AbfCVLfS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:35:18 -0400
Received: from relmlor1.renesas.com ([210.160.252.171]:34232 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730131AbfCVLfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:35:16 -0400
X-IronPort-AV: E=Sophos;i="5.60,256,1549897200"; 
   d="scan'208";a="11072370"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 22 Mar 2019 20:35:13 +0900
Received: from renesas-VirtualBox.ree.adwin.renesas.com (unknown [10.226.37.56])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id CAD3E439DB6D;
        Fri, 22 Mar 2019 20:35:11 +0900 (JST)
From:   Gareth Williams <gareth.williams.jx@renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Gareth Williams <gareth.williams.jx@renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] clk: renesas: r9a06g032: Add missing PCI USB clock
Date:   Fri, 22 Mar 2019 11:33:04 +0000
Message-Id: <1553254384-8196-1-git-send-email-gareth.williams.jx@renesas.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clock driver is missing support for the clk_pci_usb clock that is
present on the SoC. This is added to allow the clock to be supported.

Signed-off-by: Gareth Williams <gareth.williams.jx@renesas.com>
---
 drivers/clk/renesas/r9a06g032-clocks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/renesas/r9a06g032-clocks.c b/drivers/clk/renesas/r9a06g032-clocks.c
index 5d7f77b1..0b492b5 100644
--- a/drivers/clk/renesas/r9a06g032-clocks.c
+++ b/drivers/clk/renesas/r9a06g032-clocks.c
@@ -198,6 +198,7 @@ static const struct r9a06g032_clkdesc r9a06g032_clocks[] __initconst = {
 	D_GATE(CLK_P6_PG2, "clk_p6_pg2", DIV_P6_PG, 0x8a3, 0x8a4, 0x8a5, 0, 0xb61, 0, 0),
 	D_GATE(CLK_P6_PG3, "clk_p6_pg3", DIV_P6_PG, 0x8a6, 0x8a7, 0x8a8, 0, 0xb62, 0, 0),
 	D_GATE(CLK_P6_PG4, "clk_p6_pg4", DIV_P6_PG, 0x8a9, 0x8aa, 0x8ab, 0, 0xb63, 0, 0),
+	D_GATE(CLK_PCI_USB, "clk_pci_usb", CLKOUT_D40, 0xe6, 0, 0, 0, 0, 0, 0),
 	D_GATE(CLK_QSPI0, "clk_qspi0", DIV_QSPI0, 0x2a4, 0x2a5, 0, 0, 0, 0, 0),
 	D_GATE(CLK_QSPI1, "clk_qspi1", DIV_QSPI1, 0x484, 0x485, 0, 0, 0, 0, 0),
 	D_GATE(CLK_RGMII_REF, "clk_rgmii_ref", CLKOUT_D8, 0x340, 0, 0, 0, 0, 0, 0),
-- 
2.7.4

