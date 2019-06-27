Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88E1FC48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 12:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AD3920656
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 12:03:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbfF0MDu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 08:03:50 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:61179 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726816AbfF0MDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 08:03:48 -0400
Received-SPF: Pass (esa1.microchip.iphmx.com: domain of
  Codrin.Ciubotariu@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Codrin.Ciubotariu@microchip.com";
  x-sender="Codrin.Ciubotariu@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa1.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Codrin.Ciubotariu@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa1.microchip.iphmx.com; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=Codrin.Ciubotariu@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
X-IronPort-AV: E=Sophos;i="5.63,423,1557212400"; 
   d="scan'208";a="40642956"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Jun 2019 05:03:47 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex03.mchp-main.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 27 Jun 2019 05:03:47 -0700
Received: from rob-ult-m19940.microchip.com (10.10.85.251) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Thu, 27 Jun 2019 05:03:44 -0700
From:   Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
To:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
CC:     <lars@metafoo.de>, <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <perex@perex.cz>, <tiwai@suse.com>,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Subject: [PATCH 1/2] ASoC: codecs: ad193x: Group register initialization at probe
Date:   Thu, 27 Jun 2019 15:02:07 +0300
Message-ID: <20190627120208.4661-1-codrin.ciubotariu@microchip.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create a structure with the register initialization values at probe and
use it to initialize all the registers at once.

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---

The order of the initialization is changed, but it doesn't seem to
matter.
There is one checkpatch warning, let me know if you want to remove it:
WARNING: line over 80 characters
#32: FILE: sound/soc/codecs/ad193x.c:425:
+		{  0, 0x99 },	/* PLL_CLK_CTRL0: pll input: mclki/xi 12.288Mhz */

 sound/soc/codecs/ad193x.c | 52 +++++++++++++++++++++++++--------------
 1 file changed, 33 insertions(+), 19 deletions(-)

diff --git a/sound/soc/codecs/ad193x.c b/sound/soc/codecs/ad193x.c
index 3ebc0524f4b2..f944228f014e 100644
--- a/sound/soc/codecs/ad193x.c
+++ b/sound/soc/codecs/ad193x.c
@@ -413,6 +413,38 @@ static struct snd_soc_dai_driver ad193x_no_adc_dai = {
 	.ops = &ad193x_dai_ops,
 };
 
+struct ad193x_reg_default {
+	unsigned int reg;
+	unsigned int val;
+};
+
+/* codec register values to set after reset */
+static void ad193x_reg_default_init(struct ad193x_priv *ad193x)
+{
+	const struct ad193x_reg_default reg_init[] = {
+		{  0, 0x99 },	/* PLL_CLK_CTRL0: pll input: mclki/xi 12.288Mhz */
+		{  1, 0x04 },	/* PLL_CLK_CTRL1: no on-chip Vref */
+		{  2, 0x40 },	/* DAC_CTRL0: TDM mode */
+		{  4, 0x1A },	/* DAC_CTRL2: 48kHz de-emphasis, unmute dac */
+		{  5, 0x00 },	/* DAC_CHNL_MUTE: unmute DAC channels */
+	};
+	const struct ad193x_reg_default reg_adc_init[] = {
+		{ 14, 0x03 },	/* ADC_CTRL0: high-pass filter enable */
+		{ 15, 0x43 },	/* ADC_CTRL1: sata delay=1, adc aux mode */
+	};
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(reg_init); i++)
+		regmap_write(ad193x->regmap, reg_init[i].reg, reg_init[i].val);
+
+	if (ad193x_has_adc(ad193x)) {
+		for (i = 0; i < ARRAY_SIZE(reg_adc_init); i++) {
+			regmap_write(ad193x->regmap, reg_adc_init[i].reg,
+				     reg_adc_init[i].val);
+		}
+	}
+}
+
 static int ad193x_component_probe(struct snd_soc_component *component)
 {
 	struct ad193x_priv *ad193x = snd_soc_component_get_drvdata(component);
@@ -420,25 +452,7 @@ static int ad193x_component_probe(struct snd_soc_component *component)
 	int num, ret;
 
 	/* default setting for ad193x */
-
-	/* unmute dac channels */
-	regmap_write(ad193x->regmap, AD193X_DAC_CHNL_MUTE, 0x0);
-	/* de-emphasis: 48kHz, powedown dac */
-	regmap_write(ad193x->regmap, AD193X_DAC_CTRL2, 0x1A);
-	/* dac in tdm mode */
-	regmap_write(ad193x->regmap, AD193X_DAC_CTRL0, 0x40);
-
-	/* adc only */
-	if (ad193x_has_adc(ad193x)) {
-		/* high-pass filter enable */
-		regmap_write(ad193x->regmap, AD193X_ADC_CTRL0, 0x3);
-		/* sata delay=1, adc aux mode */
-		regmap_write(ad193x->regmap, AD193X_ADC_CTRL1, 0x43);
-	}
-
-	/* pll input: mclki/xi */
-	regmap_write(ad193x->regmap, AD193X_PLL_CLK_CTRL0, 0x99); /* mclk=24.576Mhz: 0x9D; mclk=12.288Mhz: 0x99 */
-	regmap_write(ad193x->regmap, AD193X_PLL_CLK_CTRL1, 0x04);
+	ad193x_reg_default_init(ad193x);
 
 	/* adc only */
 	if (ad193x_has_adc(ad193x)) {
-- 
2.20.1

