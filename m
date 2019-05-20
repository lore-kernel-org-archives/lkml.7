Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D53C8C04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB6D620856
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558339590;
	bh=LW/pWzTHteG1srJqdSrJNeHIhFKP8tfLaLHrFixHZoc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lcxBWfhHDDZ2HUWCZgJokRDtoTDWWZvWrsK0RD5YhjJxCDT32hKfcyDsz0VDbDFc6
	 K1hi79DFagfGZcplPfsnbE22+fOHemwrJu6/+0XbRaNVrD45bUNAd3FnAjhQJhgSAN
	 JZ1ZEs7ZX1C3Hb0vlPCG9LW1GaTyzjKbaCPWNv9Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731154AbfETIG3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 04:06:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:36612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730927AbfETIFk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 04:05:40 -0400
Received: from wens.tw (mirror2.csie.ntu.edu.tw [140.112.30.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63DBB2171F;
        Mon, 20 May 2019 08:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558339539;
        bh=LW/pWzTHteG1srJqdSrJNeHIhFKP8tfLaLHrFixHZoc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aDNa+2yO0r6VZpx63XvWxIE0sbUtGbAaJ415x8skKyNEjR1BKNr4f7o0JzzKu9mD1
         6HSutSptN05V+nK7JU7gzYF4fJXAT8EO/OpyIdmBa4oqLzEwCzjBQvYIJsNRtdDQC5
         G8dGSpzt44C7BoDgXNVseaZxaF1B+5QQG1qz7l0s=
Received: by wens.tw (Postfix, from userid 1000)
        id EC63F65864; Mon, 20 May 2019 16:05:32 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 24/25] clk: sunxi-ng: a80-usb: Use local parent references for SUNXI_CCU_GATE
Date:   Mon, 20 May 2019 16:04:20 +0800
Message-Id: <20190520080421.12575-25-wens@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190520080421.12575-1-wens@kernel.org>
References: <20190520080421.12575-1-wens@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

With the new clk parenting code and SUNXI_CCU_GATE macros, we can
reference parents locally via pointers to struct clk_hw or DT
clock-names.

Convert existing SUNXI_CCU_GATE definitions to SUNXI_CCU_GATE_DATA to
specify the parent clock.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/clk/sunxi-ng/ccu-sun9i-a80-usb.c | 32 +++++++++++++++---------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun9i-a80-usb.c b/drivers/clk/sunxi-ng/ccu-sun9i-a80-usb.c
index 1d76f24f7df3..23bc11e65539 100644
--- a/drivers/clk/sunxi-ng/ccu-sun9i-a80-usb.c
+++ b/drivers/clk/sunxi-ng/ccu-sun9i-a80-usb.c
@@ -22,18 +22,26 @@
 
 #include "ccu-sun9i-a80-usb.h"
 
-static SUNXI_CCU_GATE(bus_hci0_clk, "bus-hci0", "bus-usb", 0x0, BIT(1), 0);
-static SUNXI_CCU_GATE(usb_ohci0_clk, "usb-ohci0", "osc24M", 0x0, BIT(2), 0);
-static SUNXI_CCU_GATE(bus_hci1_clk, "bus-hci1", "bus-usb", 0x0, BIT(3), 0);
-static SUNXI_CCU_GATE(bus_hci2_clk, "bus-hci2", "bus-usb", 0x0, BIT(5), 0);
-static SUNXI_CCU_GATE(usb_ohci2_clk, "usb-ohci2", "osc24M", 0x0, BIT(6), 0);
-
-static SUNXI_CCU_GATE(usb0_phy_clk, "usb0-phy", "osc24M", 0x4, BIT(1), 0);
-static SUNXI_CCU_GATE(usb1_hsic_clk, "usb1-hsic", "osc24M", 0x4, BIT(2), 0);
-static SUNXI_CCU_GATE(usb1_phy_clk, "usb1-phy", "osc24M", 0x4, BIT(3), 0);
-static SUNXI_CCU_GATE(usb2_hsic_clk, "usb2-hsic", "osc24M", 0x4, BIT(4), 0);
-static SUNXI_CCU_GATE(usb2_phy_clk, "usb2-phy", "osc24M", 0x4, BIT(5), 0);
-static SUNXI_CCU_GATE(usb_hsic_clk, "usb-hsic", "osc24M", 0x4, BIT(10), 0);
+static const struct clk_parent_data clk_parent_hosc[] = {
+	{ .fw_name = "hosc" },
+};
+
+static const struct clk_parent_data clk_parent_bus[] = {
+	{ .fw_name = "bus" },
+};
+
+static SUNXI_CCU_GATE_DATA(bus_hci0_clk, "bus-hci0", clk_parent_bus, 0x0, BIT(1), 0);
+static SUNXI_CCU_GATE_DATA(usb_ohci0_clk, "usb-ohci0", clk_parent_hosc, 0x0, BIT(2), 0);
+static SUNXI_CCU_GATE_DATA(bus_hci1_clk, "bus-hci1", clk_parent_bus, 0x0, BIT(3), 0);
+static SUNXI_CCU_GATE_DATA(bus_hci2_clk, "bus-hci2", clk_parent_bus, 0x0, BIT(5), 0);
+static SUNXI_CCU_GATE_DATA(usb_ohci2_clk, "usb-ohci2", clk_parent_hosc, 0x0, BIT(6), 0);
+
+static SUNXI_CCU_GATE_DATA(usb0_phy_clk, "usb0-phy", clk_parent_hosc, 0x4, BIT(1), 0);
+static SUNXI_CCU_GATE_DATA(usb1_hsic_clk, "usb1-hsic", clk_parent_hosc, 0x4, BIT(2), 0);
+static SUNXI_CCU_GATE_DATA(usb1_phy_clk, "usb1-phy", clk_parent_hosc, 0x4, BIT(3), 0);
+static SUNXI_CCU_GATE_DATA(usb2_hsic_clk, "usb2-hsic", clk_parent_hosc, 0x4, BIT(4), 0);
+static SUNXI_CCU_GATE_DATA(usb2_phy_clk, "usb2-phy", clk_parent_hosc, 0x4, BIT(5), 0);
+static SUNXI_CCU_GATE_DATA(usb_hsic_clk, "usb-hsic", clk_parent_hosc, 0x4, BIT(10), 0);
 
 static struct ccu_common *sun9i_a80_usb_clks[] = {
 	&bus_hci0_clk.common,
-- 
2.20.1

