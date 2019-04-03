Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43AC9C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 13:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10DCF2084C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 13:26:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfDCN0J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 09:26:09 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:56034 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726396AbfDCN0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 09:26:06 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x33DL2Un012281;
        Wed, 3 Apr 2019 15:23:44 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2rmgmx44j1-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 03 Apr 2019 15:23:44 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id BE67631;
        Wed,  3 Apr 2019 13:23:43 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas23.st.com [10.75.90.46])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9F19129C0;
        Wed,  3 Apr 2019 13:23:43 +0000 (GMT)
Received: from SAFEX1HUBCAS24.st.com (10.75.90.95) by SAFEX1HUBCAS23.st.com
 (10.75.90.46) with Microsoft SMTP Server (TLS) id 14.3.435.0; Wed, 3 Apr 2019
 15:23:43 +0200
Received: from localhost (10.201.23.16) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.435.0; Wed, 3 Apr 2019 15:23:43
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
Subject: [PATCH 2/7] ASoC: cs42l51: add regulator management
Date:   Wed, 3 Apr 2019 15:23:32 +0200
Message-ID: <1554297817-14154-3-git-send-email-olivier.moysan@st.com>
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

Add cs42l51 audio codec power supply management
through regulator framework.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
---
 sound/soc/codecs/cs42l51-i2c.c |  6 ++++++
 sound/soc/codecs/cs42l51.c     | 44 +++++++++++++++++++++++++++++++++++++++++-
 sound/soc/codecs/cs42l51.h     |  1 +
 3 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs42l51-i2c.c b/sound/soc/codecs/cs42l51-i2c.c
index 4b5731a41876..8333dbf18ea2 100644
--- a/sound/soc/codecs/cs42l51-i2c.c
+++ b/sound/soc/codecs/cs42l51-i2c.c
@@ -35,12 +35,18 @@ static int cs42l51_i2c_probe(struct i2c_client *i2c,
 	return cs42l51_probe(&i2c->dev, devm_regmap_init_i2c(i2c, &config));
 }
 
+static int cs42l51_i2c_remove(struct i2c_client *i2c)
+{
+	return cs42l51_remove(&i2c->dev);
+}
+
 static struct i2c_driver cs42l51_i2c_driver = {
 	.driver = {
 		.name = "cs42l51",
 		.of_match_table = cs42l51_of_match,
 	},
 	.probe = cs42l51_i2c_probe,
+	.remove = cs42l51_i2c_remove,
 	.id_table = cs42l51_i2c_id,
 };
 
diff --git a/sound/soc/codecs/cs42l51.c b/sound/soc/codecs/cs42l51.c
index 80da3cd73e04..f43eb51d2d8d 100644
--- a/sound/soc/codecs/cs42l51.c
+++ b/sound/soc/codecs/cs42l51.c
@@ -31,6 +31,7 @@
 #include <sound/pcm_params.h>
 #include <sound/pcm.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 
 #include "cs42l51.h"
 
@@ -40,11 +41,19 @@ enum master_slave_mode {
 	MODE_MASTER,
 };
 
+static const char * const cs42l51_supply_names[] = {
+	"VL",
+	"VD",
+	"VA",
+	"VAHP",
+};
+
 struct cs42l51_private {
 	unsigned int mclk;
 	struct clk *mclk_handle;
 	unsigned int audio_mode;	/* The mode (I2S or left-justified) */
 	enum master_slave_mode func;
+	struct regulator_bulk_data supplies[ARRAY_SIZE(cs42l51_supply_names)];
 };
 
 #define CS42L51_FORMATS ( \
@@ -550,7 +559,7 @@ int cs42l51_probe(struct device *dev, struct regmap *regmap)
 {
 	struct cs42l51_private *cs42l51;
 	unsigned int val;
-	int ret;
+	int ret, i;
 
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
@@ -569,6 +578,23 @@ int cs42l51_probe(struct device *dev, struct regmap *regmap)
 		cs42l51->mclk_handle = NULL;
 	}
 
+	for (i = 0; i < ARRAY_SIZE(cs42l51->supplies); i++)
+		cs42l51->supplies[i].supply = cs42l51_supply_names[i];
+
+	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(cs42l51->supplies),
+				      cs42l51->supplies);
+	if (ret != 0) {
+		dev_err(dev, "Failed to request supplies: %d\n", ret);
+		return ret;
+	}
+
+	ret = regulator_bulk_enable(ARRAY_SIZE(cs42l51->supplies),
+				    cs42l51->supplies);
+	if (ret != 0) {
+		dev_err(dev, "Failed to enable supplies: %d\n", ret);
+		return ret;
+	}
+
 	/* Verify that we have a CS42L51 */
 	ret = regmap_read(regmap, CS42L51_CHIP_REV_ID, &val);
 	if (ret < 0) {
@@ -587,11 +613,27 @@ int cs42l51_probe(struct device *dev, struct regmap *regmap)
 
 	ret = devm_snd_soc_register_component(dev,
 			&soc_component_device_cs42l51, &cs42l51_dai, 1);
+	if (ret < 0)
+		goto error;
+
+	return 0;
+
 error:
+	regulator_bulk_disable(ARRAY_SIZE(cs42l51->supplies),
+			       cs42l51->supplies);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(cs42l51_probe);
 
+int cs42l51_remove(struct device *dev)
+{
+	struct cs42l51_private *cs42l51 = dev_get_drvdata(dev);
+
+	return regulator_bulk_disable(ARRAY_SIZE(cs42l51->supplies),
+				      cs42l51->supplies);
+}
+EXPORT_SYMBOL_GPL(cs42l51_remove);
+
 const struct of_device_id cs42l51_of_match[] = {
 	{ .compatible = "cirrus,cs42l51", },
 	{ }
diff --git a/sound/soc/codecs/cs42l51.h b/sound/soc/codecs/cs42l51.h
index 0ca805492ac4..aef0ede82c7b 100644
--- a/sound/soc/codecs/cs42l51.h
+++ b/sound/soc/codecs/cs42l51.h
@@ -22,6 +22,7 @@ struct device;
 
 extern const struct regmap_config cs42l51_regmap;
 int cs42l51_probe(struct device *dev, struct regmap *regmap);
+int cs42l51_remove(struct device *dev);
 extern const struct of_device_id cs42l51_of_match[];
 
 #define CS42L51_CHIP_ID			0x1B
-- 
2.7.4

