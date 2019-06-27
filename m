Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DFC3C48BD9
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 14:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6021920665
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 14:48:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbfF0OsP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 10:48:15 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:5226 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbfF0OsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 10:48:14 -0400
Received-SPF: Pass (esa1.microchip.iphmx.com: domain of
  Claudiu.Beznea@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="Claudiu.Beznea@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa1.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa1.microchip.iphmx.com; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=Claudiu.Beznea@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
X-IronPort-AV: E=Sophos;i="5.63,424,1557212400"; 
   d="scan'208";a="40662887"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Jun 2019 07:48:12 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex01.mchp-main.com (10.10.87.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 27 Jun 2019 07:48:10 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.85.251) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Thu, 27 Jun 2019 07:48:07 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v5 4/4] clk: at91: sckc: add support for SAM9X60
Date:   Thu, 27 Jun 2019 17:47:21 +0300
Message-ID: <1561646841-7663-5-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1561646841-7663-1-git-send-email-claudiu.beznea@microchip.com>
References: <1561646841-7663-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for SAM9X60's slow clock.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/clk/at91/sckc.c | 74 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/drivers/clk/at91/sckc.c b/drivers/clk/at91/sckc.c
index ab18b1da269f..1f0f1cd06387 100644
--- a/drivers/clk/at91/sckc.c
+++ b/drivers/clk/at91/sckc.c
@@ -410,6 +410,80 @@ static void __init of_sama5d3_sckc_setup(struct device_node *np)
 CLK_OF_DECLARE(sama5d3_clk_sckc, "atmel,sama5d3-sckc",
 	       of_sama5d3_sckc_setup);
 
+static const struct clk_slow_bits at91sam9x60_bits = {
+	.cr_osc32en = BIT(1),
+	.cr_osc32byp = BIT(2),
+	.cr_oscsel = BIT(24),
+};
+
+static void __init of_sam9x60_sckc_setup(struct device_node *np)
+{
+	void __iomem *regbase = of_iomap(np, 0);
+	struct clk_hw_onecell_data *clk_data;
+	struct clk_hw *slow_rc, *slow_osc;
+	const char *xtal_name;
+	const char *parent_names[2] = { "slow_rc_osc", "slow_osc" };
+	bool bypass;
+	int ret;
+
+	if (!regbase)
+		return;
+
+	slow_rc = clk_hw_register_fixed_rate(NULL, parent_names[0], NULL, 0,
+					     32768);
+	if (IS_ERR(slow_rc))
+		return;
+
+	xtal_name = of_clk_get_parent_name(np, 0);
+	if (!xtal_name)
+		goto unregister_slow_rc;
+
+	bypass = of_property_read_bool(np, "atmel,osc-bypass");
+	slow_osc = at91_clk_register_slow_osc(regbase, parent_names[1],
+					      xtal_name, 5000000, bypass,
+					      &at91sam9x60_bits);
+	if (IS_ERR(slow_osc))
+		goto unregister_slow_rc;
+
+	clk_data = kzalloc(sizeof(*clk_data) + (2 * sizeof(struct clk_hw *)),
+			   GFP_KERNEL);
+	if (!clk_data)
+		goto unregister_slow_osc;
+
+	/* MD_SLCK and TD_SLCK. */
+	clk_data->num = 2;
+	clk_data->hws[0] = clk_hw_register_fixed_rate(NULL, "md_slck",
+						      parent_names[0],
+						      0, 32768);
+	if (IS_ERR(clk_data->hws[0]))
+		goto clk_data_free;
+
+	clk_data->hws[1] = at91_clk_register_sam9x5_slow(regbase, "td_slck",
+							 parent_names, 2,
+							 &at91sam9x60_bits);
+	if (IS_ERR(clk_data->hws[1]))
+		goto unregister_md_slck;
+
+	ret = of_clk_add_hw_provider(np, of_clk_hw_onecell_get, clk_data);
+	if (WARN_ON(ret))
+		goto unregister_td_slck;
+
+	return;
+
+unregister_td_slck:
+	clk_hw_unregister(clk_data->hws[1]);
+unregister_md_slck:
+	clk_hw_unregister(clk_data->hws[0]);
+clk_data_free:
+	kfree(clk_data);
+unregister_slow_osc:
+	clk_hw_unregister(slow_osc);
+unregister_slow_rc:
+	clk_hw_unregister(slow_rc);
+}
+CLK_OF_DECLARE(sam9x60_clk_sckc, "microchip,sam9x60-sckc",
+	       of_sam9x60_sckc_setup);
+
 static int clk_sama5d4_slow_osc_prepare(struct clk_hw *hw)
 {
 	struct clk_sama5d4_slow_osc *osc = to_clk_sama5d4_slow_osc(hw);
-- 
2.7.4

