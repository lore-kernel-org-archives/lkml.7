Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 638AEC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 10:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FAEE2080A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 10:11:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729754AbfGOKLE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 06:11:04 -0400
Received: from mail-sz.amlogic.com ([211.162.65.117]:38479 "EHLO
        mail-sz.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729428AbfGOKLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 06:11:04 -0400
X-Greylist: delayed 901 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Jul 2019 06:11:02 EDT
Received: from localhost.localdomain (10.28.8.29) by mail-sz.amlogic.com
 (10.28.11.5) with Microsoft SMTP Server id 15.1.1591.10; Mon, 15 Jul 2019
 17:56:28 +0800
From:   chunguo feng <chunguo.feng@amlogic.com>
To:     <lgirdwood@gmail.com>
CC:     <broonie@kernel.org>, <perex@perex.cz>, <tiwai@suse.com>,
        <RyanS.Lee@maximintegrated.com>, <bleung@chromium.org>,
        <pierre-louis.bossart@linux.intel.com>, <grundler@chromium.org>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <chunguo.feng@amlogic.com>
Subject: [PATCH] ASoC: max98383: fix i2c probe failure
Date:   Mon, 15 Jul 2019 17:55:56 +0800
Message-ID: <20190715095556.1614-1-chunguo.feng@amlogic.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.28.8.29]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: fengchunguo <chunguo.feng@amlogic.com>

Added reset_gpio configuration for i2c probe successfully.
If not,i2c address can't be found rightly.

Error information:
max98373 3-0031: Failed to read: 0x21FF

Fixed:
[3.761299@3] max98373 3-0031: MAX98373 revisionID: 0x43
[3.828911@3] asoc-aml-card auge_sound: max98373-aif1 <-> TDM-B mapping ok

Signed-off-by: fengchunguo <chunguo.feng@amlogic.com>
---
 sound/soc/codecs/max98373.c | 34 ++++++++++++++++++++++++++++++----
 sound/soc/codecs/max98373.h |  1 +
 2 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/max98373.c b/sound/soc/codecs/max98373.c
index 528695cd6a1c..9a1eb7222357 100644
--- a/sound/soc/codecs/max98373.c
+++ b/sound/soc/codecs/max98373.c
@@ -12,6 +12,7 @@
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 #include <linux/gpio.h>
+#include <linux/of.h>
 #include <linux/of_gpio.h>
 #include <sound/tlv.h>
 #include "max98373.h"
@@ -895,6 +896,17 @@ static void max98373_slot_config(struct i2c_client *i2c,
 	else
 		max98373->i_slot = 1;
 
+	max98373->reset_gpio = of_get_named_gpio(dev->of_node,
+						"maxim,reset-gpio", 0);
+	if (!gpio_is_valid(max98373->reset_gpio)) {
+		dev_err(dev, "Looking up %s property in node %s failed %d\n",
+			"maxim,reset-gpio", dev->of_node->full_name,
+			max98373->reset_gpio);
+	} else {
+		dev_dbg(dev, "maxim,reset-gpio=%d",
+			max98373->reset_gpio);
+	}
+
 	if (!device_property_read_u32(dev, "maxim,spkfb-slot-no", &value))
 		max98373->spkfb_slot = value & 0xF;
 	else
@@ -923,7 +935,6 @@ static int max98373_i2c_probe(struct i2c_client *i2c,
 	else
 		max98373->interleave_mode = false;
 
-
 	/* regmap initialization */
 	max98373->regmap
 		= devm_regmap_init_i2c(i2c, &max98373_regmap);
@@ -934,6 +945,24 @@ static int max98373_i2c_probe(struct i2c_client *i2c,
 		return ret;
 	}
 
+	/* voltage/current slot & gpio configuration */
+	max98373_slot_config(i2c, max98373);
+
+	/* Power on device */
+	if (gpio_is_valid(max98373->reset_gpio)) {
+		ret = gpio_request(max98373->reset_gpio, "MAX98373_RESET");
+		if (ret) {
+			dev_err(&i2c->dev, "%s: Failed to request gpio %d\n",
+				__func__, max98373->reset_gpio);
+			gpio_free(max98373->reset_gpio);
+			return -EINVAL;
+		}
+		gpio_direction_output(max98373->reset_gpio, 0);
+		msleep(50);
+		gpio_direction_output(max98373->reset_gpio, 1);
+		msleep(20);
+	}
+
 	/* Check Revision ID */
 	ret = regmap_read(max98373->regmap,
 		MAX98373_R21FF_REV_ID, &reg);
@@ -944,9 +973,6 @@ static int max98373_i2c_probe(struct i2c_client *i2c,
 	}
 	dev_info(&i2c->dev, "MAX98373 revisionID: 0x%02X\n", reg);
 
-	/* voltage/current slot configuration */
-	max98373_slot_config(i2c, max98373);
-
 	/* codec registeration */
 	ret = devm_snd_soc_register_component(&i2c->dev, &soc_codec_dev_max98373,
 		max98373_dai, ARRAY_SIZE(max98373_dai));
diff --git a/sound/soc/codecs/max98373.h b/sound/soc/codecs/max98373.h
index f6a37aa02f26..533d2053f608 100644
--- a/sound/soc/codecs/max98373.h
+++ b/sound/soc/codecs/max98373.h
@@ -203,6 +203,7 @@
 
 struct max98373_priv {
 	struct regmap *regmap;
+	int reset_gpio;
 	unsigned int v_slot;
 	unsigned int i_slot;
 	unsigned int spkfb_slot;
-- 
2.18.0

