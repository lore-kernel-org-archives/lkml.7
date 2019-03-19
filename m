Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B31C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 14:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23E40213F2
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 14:05:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="E5U4NF0Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbfCSOFt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 10:05:49 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:56128 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbfCSOFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 10:05:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1553004343; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=K2DuZSlRgI37YBReVuYGgH+blU/a23MRqR6iMw4YDeY=;
        b=E5U4NF0ZPZ9X1E5MmxNsfFHlBdK6fVZa2jlYePy5sRMS2JluDNRp3Hx1mddG+ZYNeTEhpv
        ubhwDyiITNfFOtSlNqDcrMK3DAb1nzteezxBf/qe7GF5UfvPFOZgg/P2I3npIfIL8Ky4pv
        ZdcTuT13lYb0UY6torbDZMBkOzGK2mg=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 2/2] clk: ingenic: jz4725b: Add UDC PHY clock
Date:   Tue, 19 Mar 2019 15:05:36 +0100
Message-Id: <20190319140536.27945-2-paul@crapouillou.net>
In-Reply-To: <20190319140536.27945-1-paul@crapouillou.net>
References: <20190319140536.27945-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add clock for the USB Device Controller PHY.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/clk/ingenic/jz4725b-cgu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/clk/ingenic/jz4725b-cgu.c b/drivers/clk/ingenic/jz4725b-cgu.c
index 584ff4ff81c7..8901ea0295b7 100644
--- a/drivers/clk/ingenic/jz4725b-cgu.c
+++ b/drivers/clk/ingenic/jz4725b-cgu.c
@@ -205,6 +205,12 @@ static const struct ingenic_cgu_clk_info jz4725b_cgu_clocks[] = {
 		.parents = { JZ4725B_CLK_EXT512, JZ4725B_CLK_OSC32K, -1, -1 },
 		.mux = { CGU_REG_OPCR, 2, 1},
 	},
+
+	[JZ4725B_CLK_UDC_PHY] = {
+		"udc_phy", CGU_CLK_GATE,
+		.parents = { JZ4725B_CLK_EXT, -1, -1, -1 },
+		.gate = { CGU_REG_OPCR, 6, true },
+	},
 };
 
 static void __init jz4725b_cgu_init(struct device_node *np)
-- 
2.11.0

