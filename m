Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A27A3C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 13:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7001B2147C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 13:26:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbfDCN0u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 09:26:50 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:7306 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726882AbfDCN0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 09:26:40 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x33DLSS8019129;
        Wed, 3 Apr 2019 15:23:49 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2rmgev46kd-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 03 Apr 2019 15:23:49 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 981D931;
        Wed,  3 Apr 2019 13:23:48 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas22.st.com [10.75.90.92])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7399629C0;
        Wed,  3 Apr 2019 13:23:48 +0000 (GMT)
Received: from SAFEX1HUBCAS24.st.com (10.75.90.95) by Safex1hubcas22.st.com
 (10.75.90.92) with Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 3 Apr 2019
 15:23:48 +0200
Received: from localhost (10.201.23.16) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.435.0; Wed, 3 Apr 2019 15:23:47
 +0200
From:   Olivier Moysan <olivier.moysan@st.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <alsa-devel@alsa-project.org>,
        <robh@kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>, <olivier.moysan@st.com>,
        <arnaud.pouliquen@st.com>, <benjamin.gaignard@st.com>,
        <apatard@mandriva.com>
Subject: [PATCH 6/7] ASoC: cs42l51: add power management
Date:   Wed, 3 Apr 2019 15:23:36 +0200
Message-ID: <1554297817-14154-7-git-send-email-olivier.moysan@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554297817-14154-1-git-send-email-olivier.moysan@st.com>
References: <1554297817-14154-1-git-send-email-olivier.moysan@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.16]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-03_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add sleep PM callbacks to support system low power modes.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
---
 sound/soc/codecs/cs42l51-i2c.c |   7 ++-
 sound/soc/codecs/cs42l51.c     | 122 +++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/cs42l51.h     |   2 +
 3 files changed, 129 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/cs42l51-i2c.c b/sound/soc/codecs/cs42l51-i2c.c
index 8333dbf18ea2..116221e581ce 100644
--- a/sound/soc/codecs/cs42l51-i2c.c
+++ b/sound/soc/codecs/cs42l51-i2c.c
@@ -29,8 +29,6 @@ static int cs42l51_i2c_probe(struct i2c_client *i2c,
 	struct regmap_config config;
 
 	config = cs42l51_regmap;
-	config.val_bits = 8;
-	config.reg_bits = 8;
 
 	return cs42l51_probe(&i2c->dev, devm_regmap_init_i2c(i2c, &config));
 }
@@ -40,10 +38,15 @@ static int cs42l51_i2c_remove(struct i2c_client *i2c)
 	return cs42l51_remove(&i2c->dev);
 }
 
+static const struct dev_pm_ops cs42l51_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(cs42l51_suspend, cs42l51_resume)
+};
+
 static struct i2c_driver cs42l51_i2c_driver = {
 	.driver = {
 		.name = "cs42l51",
 		.of_match_table = cs42l51_of_match,
+		.pm = &cs42l51_pm_ops,
 	},
 	.probe = cs42l51_i2c_probe,
 	.remove = cs42l51_i2c_remove,
diff --git a/sound/soc/codecs/cs42l51.c b/sound/soc/codecs/cs42l51.c
index 33298a7a8aab..25f17c0051e4 100644
--- a/sound/soc/codecs/cs42l51.c
+++ b/sound/soc/codecs/cs42l51.c
@@ -56,6 +56,7 @@ struct cs42l51_private {
 	enum master_slave_mode func;
 	struct regulator_bulk_data supplies[ARRAY_SIZE(cs42l51_supply_names)];
 	struct gpio_desc *reset_gpio;
+	struct regmap *regmap;
 };
 
 #define CS42L51_FORMATS ( \
@@ -576,7 +577,106 @@ static const struct snd_soc_component_driver soc_component_device_cs42l51 = {
 	.non_legacy_dai_naming	= 1,
 };
 
+static bool cs42l51_writeable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case CS42L51_POWER_CTL1:
+	case CS42L51_MIC_POWER_CTL:
+	case CS42L51_INTF_CTL:
+	case CS42L51_MIC_CTL:
+	case CS42L51_ADC_CTL:
+	case CS42L51_ADC_INPUT:
+	case CS42L51_DAC_OUT_CTL:
+	case CS42L51_DAC_CTL:
+	case CS42L51_ALC_PGA_CTL:
+	case CS42L51_ALC_PGB_CTL:
+	case CS42L51_ADCA_ATT:
+	case CS42L51_ADCB_ATT:
+	case CS42L51_ADCA_VOL:
+	case CS42L51_ADCB_VOL:
+	case CS42L51_PCMA_VOL:
+	case CS42L51_PCMB_VOL:
+	case CS42L51_BEEP_FREQ:
+	case CS42L51_BEEP_VOL:
+	case CS42L51_BEEP_CONF:
+	case CS42L51_TONE_CTL:
+	case CS42L51_AOUTA_VOL:
+	case CS42L51_AOUTB_VOL:
+	case CS42L51_PCM_MIXER:
+	case CS42L51_LIMIT_THRES_DIS:
+	case CS42L51_LIMIT_REL:
+	case CS42L51_LIMIT_ATT:
+	case CS42L51_ALC_EN:
+	case CS42L51_ALC_REL:
+	case CS42L51_ALC_THRES:
+	case CS42L51_NOISE_CONF:
+	case CS42L51_CHARGE_FREQ:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool cs42l51_volatile_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case CS42L51_STATUS:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool cs42l51_readable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case CS42L51_CHIP_REV_ID:
+	case CS42L51_POWER_CTL1:
+	case CS42L51_MIC_POWER_CTL:
+	case CS42L51_INTF_CTL:
+	case CS42L51_MIC_CTL:
+	case CS42L51_ADC_CTL:
+	case CS42L51_ADC_INPUT:
+	case CS42L51_DAC_OUT_CTL:
+	case CS42L51_DAC_CTL:
+	case CS42L51_ALC_PGA_CTL:
+	case CS42L51_ALC_PGB_CTL:
+	case CS42L51_ADCA_ATT:
+	case CS42L51_ADCB_ATT:
+	case CS42L51_ADCA_VOL:
+	case CS42L51_ADCB_VOL:
+	case CS42L51_PCMA_VOL:
+	case CS42L51_PCMB_VOL:
+	case CS42L51_BEEP_FREQ:
+	case CS42L51_BEEP_VOL:
+	case CS42L51_BEEP_CONF:
+	case CS42L51_TONE_CTL:
+	case CS42L51_AOUTA_VOL:
+	case CS42L51_AOUTB_VOL:
+	case CS42L51_PCM_MIXER:
+	case CS42L51_LIMIT_THRES_DIS:
+	case CS42L51_LIMIT_REL:
+	case CS42L51_LIMIT_ATT:
+	case CS42L51_ALC_EN:
+	case CS42L51_ALC_REL:
+	case CS42L51_ALC_THRES:
+	case CS42L51_NOISE_CONF:
+	case CS42L51_STATUS:
+	case CS42L51_CHARGE_FREQ:
+		return true;
+	default:
+		return false;
+	}
+}
+
 const struct regmap_config cs42l51_regmap = {
+	.reg_bits = 8,
+	.reg_stride = 1,
+	.val_bits = 8,
+	.use_single_write = true,
+	.readable_reg = cs42l51_readable_reg,
+	.volatile_reg = cs42l51_volatile_reg,
+	.writeable_reg = cs42l51_writeable_reg,
 	.max_register = CS42L51_CHARGE_FREQ,
 	.cache_type = REGCACHE_RBTREE,
 };
@@ -597,6 +697,7 @@ int cs42l51_probe(struct device *dev, struct regmap *regmap)
 		return -ENOMEM;
 
 	dev_set_drvdata(dev, cs42l51);
+	cs42l51->regmap = regmap;
 
 	cs42l51->mclk_handle = devm_clk_get(dev, "MCLK");
 	if (IS_ERR(cs42l51->mclk_handle)) {
@@ -674,6 +775,27 @@ int cs42l51_remove(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(cs42l51_remove);
 
+int __maybe_unused cs42l51_suspend(struct device *dev)
+{
+	struct cs42l51_private *cs42l51 = dev_get_drvdata(dev);
+
+	regcache_cache_only(cs42l51->regmap, true);
+	regcache_mark_dirty(cs42l51->regmap);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cs42l51_suspend);
+
+int __maybe_unused cs42l51_resume(struct device *dev)
+{
+	struct cs42l51_private *cs42l51 = dev_get_drvdata(dev);
+
+	regcache_cache_only(cs42l51->regmap, false);
+
+	return regcache_sync(cs42l51->regmap);
+}
+EXPORT_SYMBOL_GPL(cs42l51_resume);
+
 const struct of_device_id cs42l51_of_match[] = {
 	{ .compatible = "cirrus,cs42l51", },
 	{ }
diff --git a/sound/soc/codecs/cs42l51.h b/sound/soc/codecs/cs42l51.h
index aef0ede82c7b..79dee01137c8 100644
--- a/sound/soc/codecs/cs42l51.h
+++ b/sound/soc/codecs/cs42l51.h
@@ -23,6 +23,8 @@ struct device;
 extern const struct regmap_config cs42l51_regmap;
 int cs42l51_probe(struct device *dev, struct regmap *regmap);
 int cs42l51_remove(struct device *dev);
+int __maybe_unused cs42l51_suspend(struct device *dev);
+int __maybe_unused cs42l51_resume(struct device *dev);
 extern const struct of_device_id cs42l51_of_match[];
 
 #define CS42L51_CHIP_ID			0x1B
-- 
2.7.4

