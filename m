Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A30C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 12:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F3CB20883
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 12:41:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730630AbfDBMk0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 08:40:26 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:35827 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfDBMkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 08:40:25 -0400
Received: from localhost (alyon-652-1-60-19.w109-213.abo.wanadoo.fr [109.213.83.19])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 3DF18100002;
        Tue,  2 Apr 2019 12:40:22 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/10] clk: at91: sckc: add support for SAM9X60
Date:   Tue,  2 Apr 2019 14:40:08 +0200
Message-Id: <20190402124016.20558-3-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190402124016.20558-1-alexandre.belloni@bootlin.com>
References: <20190402124016.20558-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

Add support for SAM9X60.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/clk/at91/sckc.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/clk/at91/sckc.c b/drivers/clk/at91/sckc.c
index b7163d3a2269..b3075c51d260 100644
--- a/drivers/clk/at91/sckc.c
+++ b/drivers/clk/at91/sckc.c
@@ -459,6 +459,36 @@ static void __init of_at91sam9x5_sckc_setup(struct device_node *np)
 CLK_OF_DECLARE(at91sam9x5_clk_sckc, "atmel,at91sam9x5-sckc",
 	       of_at91sam9x5_sckc_setup);
 
+static const struct clk_slow_offsets at91sam9x60_offsets = {
+	.cr_rcen = AT91_SCKC_OFFSET_INVALID,
+	.cr_osc32en = 1,
+	.cr_osc32byp = 2,
+	.cr_oscsel = 24,
+};
+
+static void __init of_at91sam9x60_sckc_setup(struct device_node *np)
+{
+	struct device_node *childnp;
+	void (*clk_setup)(struct device_node *np, void __iomem *io,
+			  const struct clk_slow_offsets *offsets);
+	const struct of_device_id *clk_id;
+	void __iomem *regbase = of_iomap(np, 0);
+
+	if (!regbase)
+		return;
+
+	for_each_child_of_node(np, childnp) {
+		clk_id = of_match_node(sckc_clk_ids, childnp);
+		if (!clk_id)
+			continue;
+		clk_setup = clk_id->data;
+		clk_setup(childnp, regbase, &at91sam9x60_offsets);
+	}
+}
+
+CLK_OF_DECLARE(at91sam9x60_clk_sckc, "microchip,sam9x60-sckc",
+	       of_at91sam9x60_sckc_setup);
+
 static int clk_sama5d4_slow_osc_prepare(struct clk_hw *hw)
 {
 	struct clk_sama5d4_slow_osc *osc = to_clk_sama5d4_slow_osc(hw);
-- 
2.20.1

