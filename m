Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E6DC48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 15:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9FB520B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 15:54:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfF0PyM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 11:54:12 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:59721 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbfF0PyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 11:54:09 -0400
Received-SPF: Pass (esa5.microchip.iphmx.com: domain of
  Claudiu.Beznea@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="Claudiu.Beznea@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa5.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa5.microchip.iphmx.com; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=Claudiu.Beznea@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
X-IronPort-AV: E=Sophos;i="5.63,424,1557212400"; 
   d="scan'208";a="37623703"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Jun 2019 08:54:08 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex03.mchp-main.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 27 Jun 2019 08:54:08 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.85.251) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Thu, 27 Jun 2019 08:54:05 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 6/7] clk: at91: sckc: improve error path for sama5d4 sck registration
Date:   Thu, 27 Jun 2019 18:53:44 +0300
Message-ID: <1561650825-11213-7-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1561650825-11213-1-git-send-email-claudiu.beznea@microchip.com>
References: <1561650825-11213-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Improve error path for sama5d4 sck registration.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/clk/at91/sckc.c | 43 ++++++++++++++++++++++++++++---------------
 1 file changed, 28 insertions(+), 15 deletions(-)

diff --git a/drivers/clk/at91/sckc.c b/drivers/clk/at91/sckc.c
index c61b6c9ddb94..f7ad3e9414dc 100644
--- a/drivers/clk/at91/sckc.c
+++ b/drivers/clk/at91/sckc.c
@@ -568,7 +568,7 @@ static const struct clk_slow_bits at91sama5d4_bits = {
 static void __init of_sama5d4_sckc_setup(struct device_node *np)
 {
 	void __iomem *regbase = of_iomap(np, 0);
-	struct clk_hw *hw;
+	struct clk_hw *slow_rc, *slowck;
 	struct clk_sama5d4_slow_osc *osc;
 	struct clk_init_data init;
 	const char *xtal_name;
@@ -578,17 +578,18 @@ static void __init of_sama5d4_sckc_setup(struct device_node *np)
 	if (!regbase)
 		return;
 
-	hw = clk_hw_register_fixed_rate_with_accuracy(NULL, parent_names[0],
-						      NULL, 0, 32768,
-						      250000000);
-	if (IS_ERR(hw))
+	slow_rc = clk_hw_register_fixed_rate_with_accuracy(NULL,
+							   parent_names[0],
+							   NULL, 0, 32768,
+							   250000000);
+	if (IS_ERR(slow_rc))
 		return;
 
 	xtal_name = of_clk_get_parent_name(np, 0);
 
 	osc = kzalloc(sizeof(*osc), GFP_KERNEL);
 	if (!osc)
-		return;
+		goto unregister_slow_rc;
 
 	init.name = parent_names[1];
 	init.ops = &sama5d4_slow_osc_ops;
@@ -602,17 +603,29 @@ static void __init of_sama5d4_sckc_setup(struct device_node *np)
 	osc->bits = &at91sama5d4_bits;
 
 	ret = clk_hw_register(NULL, &osc->hw);
-	if (ret) {
-		kfree(osc);
-		return;
-	}
+	if (ret)
+		goto free_slow_osc_data;
 
-	hw = at91_clk_register_sam9x5_slow(regbase, "slowck", parent_names, 2,
-					   &at91sama5d4_bits);
-	if (IS_ERR(hw))
-		return;
+	slowck = at91_clk_register_sam9x5_slow(regbase, "slowck",
+					       parent_names, 2,
+					       &at91sama5d4_bits);
+	if (IS_ERR(slowck))
+		goto unregister_slow_osc;
 
-	of_clk_add_hw_provider(np, of_clk_hw_simple_get, hw);
+	ret = of_clk_add_hw_provider(np, of_clk_hw_simple_get, slowck);
+	if (WARN_ON(ret))
+		goto unregister_slowck;
+
+	return;
+
+unregister_slowck:
+	at91_clk_unregister_sam9x5_slow(slowck);
+unregister_slow_osc:
+	clk_hw_unregister(&osc->hw);
+free_slow_osc_data:
+	kfree(osc);
+unregister_slow_rc:
+	clk_hw_unregister(slow_rc);
 }
 CLK_OF_DECLARE(sama5d4_clk_sckc, "atmel,sama5d4-sckc",
 	       of_sama5d4_sckc_setup);
-- 
2.7.4

