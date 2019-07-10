Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77305C73C7C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 10:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5353B2064A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 10:51:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbfGJKvq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 06:51:46 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:20018 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbfGJKvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 06:51:45 -0400
Received-SPF: Pass (esa6.microchip.iphmx.com: domain of
  Codrin.Ciubotariu@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Codrin.Ciubotariu@microchip.com";
  x-sender="Codrin.Ciubotariu@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa6.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Codrin.Ciubotariu@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa6.microchip.iphmx.com; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=Codrin.Ciubotariu@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: ykMk+mAJO8ioHV8LJM8Fq6OabviCLQQPIWM+wFtiZOyTHASTsqQvDQ4UHJ1jD325ogv0nZjctL
 4a7XCno7CNOUkOfei/SLl418omfbWsxRbiPmYC1/mTovnbSV8l/lyhtph8SWS2DxIxhFLLjtF2
 QjlpUih/0Jaza8fpyy6xgJsTOHoy0UzbTMaU+WmwjD0RCKUTTB5yLJaaWTwXsjX//z0e0bmglq
 qTM3sUukGF1VxAqTrtfq9/x8FoLrhNt1oi+AAr1929UjvlqD3bjdvXyqMtvQlI6dWFsZZg+8gW
 w/s=
X-IronPort-AV: E=Sophos;i="5.63,474,1557212400"; 
   d="scan'208";a="37641144"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Jul 2019 03:51:44 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 10 Jul 2019 03:51:43 -0700
Received: from rob-ult-m19940.microchip.com (10.10.85.251) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Wed, 10 Jul 2019 03:51:41 -0700
From:   Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
To:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
CC:     <lars@metafoo.de>, <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <perex@perex.cz>, <tiwai@suse.com>,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        Tzung-Bi Shih <tzungbi@google.com>
Subject: [PATCH] ASoC: codecs: ad193x: Use regmap_multi_reg_write() when initializing
Date:   Wed, 10 Jul 2019 13:51:19 +0300
Message-ID: <20190710105119.22987-1-codrin.ciubotariu@microchip.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using regmap_multi_reg_write() when we set the default values for our
registers makes the code smaller and easier to read.

Suggested-by: Tzung-Bi Shih <tzungbi@google.com>
Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---
 sound/soc/codecs/ad193x.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/sound/soc/codecs/ad193x.c b/sound/soc/codecs/ad193x.c
index 80dab5df9633..fb04c9379b71 100644
--- a/sound/soc/codecs/ad193x.c
+++ b/sound/soc/codecs/ad193x.c
@@ -413,15 +413,10 @@ static struct snd_soc_dai_driver ad193x_no_adc_dai = {
 	.ops = &ad193x_dai_ops,
 };
 
-struct ad193x_reg_default {
-	unsigned int reg;
-	unsigned int val;
-};
-
 /* codec register values to set after reset */
 static void ad193x_reg_default_init(struct ad193x_priv *ad193x)
 {
-	const struct ad193x_reg_default reg_init[] = {
+	const struct reg_sequence reg_init[] = {
 		{  0, 0x99 },	/* PLL_CLK_CTRL0: pll input: mclki/xi 12.288Mhz */
 		{  1, 0x04 },	/* PLL_CLK_CTRL1: no on-chip Vref */
 		{  2, 0x40 },	/* DAC_CTRL0: TDM mode */
@@ -437,21 +432,17 @@ static void ad193x_reg_default_init(struct ad193x_priv *ad193x)
 		{ 12, 0x00 },	/* DAC_L4_VOL: no attenuation */
 		{ 13, 0x00 },	/* DAC_R4_VOL: no attenuation */
 	};
-	const struct ad193x_reg_default reg_adc_init[] = {
+	const struct reg_sequence reg_adc_init[] = {
 		{ 14, 0x03 },	/* ADC_CTRL0: high-pass filter enable */
 		{ 15, 0x43 },	/* ADC_CTRL1: sata delay=1, adc aux mode */
 		{ 16, 0x00 },	/* ADC_CTRL2: reset */
 	};
-	int i;
 
-	for (i = 0; i < ARRAY_SIZE(reg_init); i++)
-		regmap_write(ad193x->regmap, reg_init[i].reg, reg_init[i].val);
+	regmap_multi_reg_write(ad193x->regmap, reg_init, ARRAY_SIZE(reg_init));
 
 	if (ad193x_has_adc(ad193x)) {
-		for (i = 0; i < ARRAY_SIZE(reg_adc_init); i++) {
-			regmap_write(ad193x->regmap, reg_adc_init[i].reg,
-				     reg_adc_init[i].val);
-		}
+		regmap_multi_reg_write(ad193x->regmap, reg_adc_init,
+				       ARRAY_SIZE(reg_adc_init));
 	}
 }
 
-- 
2.20.1

