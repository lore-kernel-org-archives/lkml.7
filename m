Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9085C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 15:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9600E2133D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 15:13:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ZD+cvmOb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728645AbfDAPNl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 11:13:41 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:44660 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbfDAPNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 11:13:38 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x31FDTa5099967;
        Mon, 1 Apr 2019 10:13:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554131609;
        bh=//rTlf5DL065W2q5KyrS2/fUw8PNc9IPnRm8C5ETlJQ=;
        h=From:To:CC:Subject:Date;
        b=ZD+cvmObYZm0sMK17UcHxwoPqmXS3OQAEvcFImIRIGWMkyJMMt0bc1kym/EmjbAxP
         GbRnOLX7gRVMP0ienOkHDutrneZWlIxato6Z8IP/ztzz7NeSOFC7DRVXmhvXy2+zOc
         EG9n5Q2sTbC03UcdnnQan1TysVQF/7Vl7PLFojxk=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x31FDTwS078982
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 1 Apr 2019 10:13:29 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 1 Apr
 2019 10:13:28 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 1 Apr 2019 10:13:28 -0500
Received: from legion.dal.desgin.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x31FDSHx098289;
        Mon, 1 Apr 2019 10:13:28 -0500
Received: from localhost ([10.250.67.168])
        by legion.dal.desgin.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id x31FDSU10483;
        Mon, 1 Apr 2019 10:13:28 -0500 (CDT)
From:   "Andrew F. Davis" <afd@ti.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        "Andrew F . Davis" <afd@ti.com>
Subject: [PATCH v4 1/2] ASoC: tlv320aic31xx: Add headphone/headset detection
Date:   Mon, 1 Apr 2019 10:13:28 -0500
Message-ID: <20190401151329.29075-1-afd@ti.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This device can detect the insertion/removal of headphones and headsets.
Enable reporting this status by enabling this interrupt and forwarding
this to upper-layers if a jack has been defined.

This jack definition and the resulting operation from a jack detection
event must currently be defined by sound card platform code until CODEC
outputs to jack mappings can be defined generically.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---

Changes from v3:
 - Rebase on broonie/for-next

 sound/soc/codecs/tlv320aic31xx.c | 48 +++++++++++++++++++++++++++++++-
 sound/soc/codecs/tlv320aic31xx.h | 11 ++++++++
 2 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tlv320aic31xx.c b/sound/soc/codecs/tlv320aic31xx.c
index c544a1e35f5e..a60cd8c08a14 100644
--- a/sound/soc/codecs/tlv320aic31xx.c
+++ b/sound/soc/codecs/tlv320aic31xx.c
@@ -25,6 +25,7 @@
 #include <linux/of_gpio.h>
 #include <linux/slab.h>
 #include <sound/core.h>
+#include <sound/jack.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
@@ -89,6 +90,7 @@ static bool aic31xx_volatile(struct device *dev, unsigned int reg)
 	case AIC31XX_INTRADCFLAG: /* Sticky interrupt flags */
 	case AIC31XX_INTRDACFLAG2:
 	case AIC31XX_INTRADCFLAG2:
+	case AIC31XX_HSDETECT:
 		return true;
 	}
 	return false;
@@ -163,6 +165,7 @@ struct aic31xx_priv {
 	struct aic31xx_pdata pdata;
 	struct regulator_bulk_data supplies[AIC31XX_NUM_SUPPLIES];
 	struct aic31xx_disable_nb disable_nb[AIC31XX_NUM_SUPPLIES];
+	struct snd_soc_jack *jack;
 	unsigned int sysclk;
 	u8 p_div;
 	int rate_div_line;
@@ -1261,6 +1264,20 @@ static int aic31xx_set_bias_level(struct snd_soc_component *component,
 	return 0;
 }
 
+int aic31xx_set_jack(struct snd_soc_component *component,
+		     struct snd_soc_jack *jack, void *data)
+{
+	struct aic31xx_priv *aic31xx = snd_soc_component_get_drvdata(component);
+
+	aic31xx->jack = jack;
+
+	/* Enable/Disable jack detection */
+	regmap_write(aic31xx->regmap, AIC31XX_HSDETECT,
+		     jack ? AIC31XX_HSD_ENABLE : 0);
+
+	return 0;
+}
+
 static int aic31xx_codec_probe(struct snd_soc_component *component)
 {
 	struct aic31xx_priv *aic31xx = snd_soc_component_get_drvdata(component);
@@ -1301,6 +1318,7 @@ static int aic31xx_codec_probe(struct snd_soc_component *component)
 
 static const struct snd_soc_component_driver soc_codec_driver_aic31xx = {
 	.probe			= aic31xx_codec_probe,
+	.set_jack		= aic31xx_set_jack,
 	.set_bias_level		= aic31xx_set_bias_level,
 	.controls		= common31xx_snd_controls,
 	.num_controls		= ARRAY_SIZE(common31xx_snd_controls),
@@ -1405,8 +1423,35 @@ static irqreturn_t aic31xx_irq(int irq, void *data)
 		dev_err(dev, "Short circuit on Left output is detected\n");
 	if (value & AIC31XX_HPRSCDETECT)
 		dev_err(dev, "Short circuit on Right output is detected\n");
+	if (value & AIC31XX_HSPLUG) {
+		unsigned int val;
+		int status = 0;
+
+		ret = regmap_read(aic31xx->regmap, AIC31XX_HSDETECT, &val);
+		if (ret) {
+			dev_err(dev, "Failed to read headset type: %d\n", ret);
+			goto exit;
+		}
+
+		switch ((val & AIC31XX_HSD_TYPE_MASK) >>
+			AIC31XX_HSD_TYPE_SHIFT) {
+		case AIC31XX_HSD_HP:
+			status |= SND_JACK_HEADPHONE;
+			break;
+		case AIC31XX_HSD_HS:
+			status |= SND_JACK_HEADSET;
+			break;
+		default:
+			break;
+		}
+
+		if (aic31xx->jack)
+			snd_soc_jack_report(aic31xx->jack, status,
+					    AIC31XX_JACK_MASK);
+	}
 	if (value & ~(AIC31XX_HPLSCDETECT |
-		      AIC31XX_HPRSCDETECT))
+		      AIC31XX_HPRSCDETECT |
+		      AIC31XX_HSPLUG))
 		dev_err(dev, "Unknown DAC interrupt flags: 0x%08x\n", value);
 
 read_overflow:
@@ -1518,6 +1563,7 @@ static int aic31xx_i2c_probe(struct i2c_client *i2c,
 				   AIC31XX_GPIO1_FUNC_SHIFT);
 
 		regmap_write(aic31xx->regmap, AIC31XX_INT1CTRL,
+			     AIC31XX_HSPLUGDET |
 			     AIC31XX_SC |
 			     AIC31XX_ENGINE);
 
diff --git a/sound/soc/codecs/tlv320aic31xx.h b/sound/soc/codecs/tlv320aic31xx.h
index 2636f2c6bc79..9985ceed97ae 100644
--- a/sound/soc/codecs/tlv320aic31xx.h
+++ b/sound/soc/codecs/tlv320aic31xx.h
@@ -20,6 +20,9 @@
 #define AIC31XX_MINIDSP_BIT		BIT(2)
 #define DAC31XX_BIT			BIT(3)
 
+#define AIC31XX_JACK_MASK (SND_JACK_HEADPHONE | \
+			   SND_JACK_HEADSET)
+
 enum aic31xx_type {
 	AIC3100	= 0,
 	AIC3110 = AIC31XX_STEREO_CLASS_D_BIT,
@@ -220,6 +223,14 @@ struct aic31xx_pdata {
 /* AIC31XX_DACMUTE */
 #define AIC31XX_DACMUTE_MASK		GENMASK(3, 2)
 
+/* AIC31XX_HSDETECT */
+#define AIC31XX_HSD_ENABLE		BIT(7)
+#define AIC31XX_HSD_TYPE_MASK		GENMASK(6, 5)
+#define AIC31XX_HSD_TYPE_SHIFT		5
+#define AIC31XX_HSD_NONE		0x00
+#define AIC31XX_HSD_HP			0x01
+#define AIC31XX_HSD_HS			0x03
+
 /* AIC31XX_MICBIAS */
 #define AIC31XX_MICBIAS_MASK		GENMASK(1, 0)
 #define AIC31XX_MICBIAS_SHIFT		0
-- 
2.21.0

