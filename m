Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A2DC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 12:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8F60208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 12:10:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730222AbfG3MKL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 08:10:11 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:44310 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbfG3MKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 08:10:09 -0400
Received: from [167.98.27.226] (helo=ct-lt-1124.office.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1hsQwr-0003E4-LE; Tue, 30 Jul 2019 13:09:45 +0100
From:   Thomas Preston <thomas.preston@codethink.co.uk>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Kirill Marinushkin <kmarinushkin@birdec.tech>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Vinod Koul <vkoul@kernel.org>,
        Annaliese McDermond <nh6z@nh6z.net>,
        Thomas Preston <thomas.preston@codethink.co.uk>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] ASoC: TDA7802: Add turn-on diagnostic routine
Date:   Tue, 30 Jul 2019 13:09:37 +0100
Message-Id: <20190730120937.16271-4-thomas.preston@codethink.co.uk>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190730120937.16271-1-thomas.preston@codethink.co.uk>
References: <20190730120937.16271-1-thomas.preston@codethink.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a debugfs device node which initiates the turn-on diagnostic routine
feature of the TDA7802 amplifier. The four status registers (one per
channel) are returned.

Signed-off-by: Thomas Preston <thomas.preston@codethink.co.uk>
---
Changes since v1:
- Rename speaker-test to (turn-on) diagnostics
- Move turn-on diagnostic to debugfs as there is no standard ALSA
  interface for this kind of routine.

 sound/soc/codecs/tda7802.c | 186 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 185 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tda7802.c b/sound/soc/codecs/tda7802.c
index 0f82a88bc1a4..74436212241d 100644
--- a/sound/soc/codecs/tda7802.c
+++ b/sound/soc/codecs/tda7802.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2016-2019 Tesla Motors, Inc.
  */
 
+#include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
@@ -26,6 +27,7 @@
 #define TDA7802_IB5			0x05
 
 #define TDA7802_DB0			0x10
+#define TDA7802_DB1			0x11
 #define TDA7802_DB5			0x15
 
 #define IB2_DIGITAL_MUTE_DISABLED	(1 << 2)
@@ -47,6 +49,17 @@
 #define IB3_FORMAT_TDM16_DEV3		(6 << IB3_FORMAT_SHIFT)
 #define IB3_FORMAT_TDM16_DEV4		(7 << IB3_FORMAT_SHIFT)
 
+#define IB4_DIAG_MODE_ENABLE		(1 << 0)
+
+#define IB5_AMPLIFIER_ON		(1 << 0)
+
+#define DB0_STARTUP_DIAG_STATUS		(1 << 6)
+
+#define DIAGNOSTIC_POLL_PERIOD_US	5000
+#define DIAGNOSTIC_TIMEOUT_US		5000000
+#define DIAGNOSTIC_SETTLE_MS		20
+#define NUM_IB				6
+
 enum tda7802_type {
 	tda7802_base,
 };
@@ -55,6 +68,12 @@ struct tda7802_priv {
 	struct i2c_client *i2c;
 	struct regmap *regmap;
 	struct regulator *enable_reg;
+	struct dentry *debugfs;
+	struct mutex diagnostic_mutex;
+};
+
+struct reg_update {
+	unsigned int reg, mask, val;
 };
 
 static const struct reg_default tda7802_reg[] = {
@@ -113,6 +132,19 @@ static const struct regmap_config tda7802_regmap_config = {
 	.cache_type = REGCACHE_RBTREE,
 };
 
+/* The following bits need to be updated before diagnostics mode is set. */
+static const struct reg_update diagnostic_state[NUM_IB] = {
+	{ TDA7802_IB0, 0, 0 },
+	{ TDA7802_IB1, 0, 0 },
+	{ TDA7802_IB2,
+		IB2_CH13_UNMUTED | IB2_CH24_UNMUTED | IB2_DIGITAL_MUTE_DISABLED,
+		IB2_CH13_UNMUTED | IB2_CH24_UNMUTED | IB2_DIGITAL_MUTE_DISABLED,
+	},
+	{ TDA7802_IB3, 0, 0 },
+	{ TDA7802_IB4, IB4_DIAG_MODE_ENABLE, 0 },
+	{ TDA7802_IB5, IB5_AMPLIFIER_ON, 0 },
+};
+
 static int tda7802_digital_mute(struct snd_soc_dai *dai, int mute)
 {
 	const u8 mute_disabled = mute ? 0 : IB2_DIGITAL_MUTE_DISABLED;
@@ -414,7 +446,6 @@ static const struct snd_kcontrol_new tda7802_snd_controls[] = {
 	SOC_SINGLE("AC diag enable", TDA7802_IB4, 3, 1, 0),
 	SOC_ENUM("Diag mode channels 1 & 3", diag_mode_ch13),
 	SOC_ENUM("Diag mode channels 2 & 4", diag_mode_ch24),
-	SOC_SINGLE("Diag mode enable", TDA7802_IB4, 0, 1, 0),
 
 	SOC_ENUM("Clipping detect channels 1 & 3", clip_detect_ch13),
 	SOC_ENUM("Clipping detect channels 2 & 4", clip_detect_ch24),
@@ -432,7 +463,160 @@ static const struct snd_soc_dapm_route tda7802_dapm_routes[] = {
 	{ "SPK", NULL, "DAC" },
 };
 
+static int tda7802_bulk_update(struct regmap *map, struct reg_update *update,
+		size_t update_count)
+{
+	int i, err;
+
+	for (i = 0; i < update_count; i++) {
+		err = regmap_update_bits(map, update[i].reg, update[i].mask,
+				update[i].val);
+		if (err < 0)
+			return err;
+	}
+
+	return i;
+}
+
+static int run_turn_on_diagnostic(struct tda7802_priv *tda7802, u8 *status)
+{
+	struct device *dev = &tda7802->i2c->dev;
+	int err_status, err;
+	unsigned int val;
+	u8 state[NUM_IB];
+
+	dev_dbg(dev, "%s\n", __func__);
+
+	/* Save state and prepare for diagnostic */
+	err = regmap_bulk_read(tda7802->regmap, TDA7802_IB0, state,
+			ARRAY_SIZE(state));
+	if (err < 0) {
+		dev_err(dev, "Could not save device state, %d\n", err);
+		return err;
+	}
+
+	err = tda7802_bulk_update(tda7802->regmap, diagnostic_state,
+			ARRAY_SIZE(diagnostic_state));
+	if (err < 0) {
+		dev_err(dev, "Could not prepare for diagnostics, %d\n", err);
+		goto diagnostic_restore;
+	}
+
+	/* We must wait 20ms for device to settle, otherwise diagnostics will
+	 * not start and regmap poll will timeout.
+	 */
+	msleep(DIAGNOSTIC_SETTLE_MS);
+
+	/* Turn on diagnostic */
+	err = regmap_update_bits(tda7802->regmap, TDA7802_IB4,
+			IB4_DIAG_MODE_ENABLE, IB4_DIAG_MODE_ENABLE);
+	if (err < 0) {
+		dev_err(dev, "Could not enable diagnostic mode, %d\n", err);
+		goto diagnostic_restore;
+	}
+
+	/* Wait until DB0_STARTUP_DIAG_STATUS is set, then read status */
+	err_status = regmap_read_poll_timeout(tda7802->regmap, TDA7802_DB0, val,
+			val & DB0_STARTUP_DIAG_STATUS,
+			DIAGNOSTIC_POLL_PERIOD_US,
+			DIAGNOSTIC_TIMEOUT_US);
+	if (err_status < 0) {
+		dev_err(dev, "Diagnostic did not complete, err %d, reg %x",
+				err_status, val);
+		goto diagnostic_restore;
+	}
+
+	err = regmap_bulk_read(tda7802->regmap, TDA7802_DB1, status, 4);
+	if (err < 0) {
+		dev_err(dev, "Could not read channel status, %d\n", err);
+		goto diagnostic_restore;
+	}
+
+diagnostic_restore:
+	err = regmap_bulk_write(tda7802->regmap, TDA7802_IB0, state,
+			ARRAY_SIZE(state));
+	if (err < 0)
+		dev_err(dev, "Could not restore state, %d\n", err);
+
+	if (err_status < 0)
+		return err_status;
+	else
+		return err;
+}
+
+static int tda7802_diagnostic_show(struct seq_file *f, void *p)
+{
+	char *buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
+	struct tda7802_priv *tda7802 = f->private;
+	u8 status[4] = { 0 };
+	int i, err;
+
+	mutex_lock(&tda7802->diagnostic_mutex);
+	err = run_turn_on_diagnostic(tda7802, status);
+	mutex_unlock(&tda7802->diagnostic_mutex);
+	if (err < 0)
+		return err;
+
+	for (i = 0; i < ARRAY_SIZE(status); i++)
+		seq_printf(f, "%02x: %02x\n", TDA7802_DB1+i, status[i]);
+
+	return 0;
+}
+
+static int tda7802_diagnostic_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, tda7802_diagnostic_show, inode->i_private);
+}
+
+static const struct file_operations tda7802_diagnostic_fops = {
+	.open = tda7802_diagnostic_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = single_release,
+};
+
+static int tda7802_probe(struct snd_soc_component *component)
+{
+	struct tda7802_priv *tda7802 = snd_soc_component_get_drvdata(component);
+	struct device *dev = &tda7802->i2c->dev;
+	int err;
+
+	tda7802->debugfs = debugfs_create_dir(dev_name(dev), NULL);
+	if (IS_ERR_OR_NULL(tda7802->debugfs)) {
+		dev_info(dev,
+			"Failed to create debugfs node, err %ld\n",
+			PTR_ERR(tda7802->debugfs));
+		return 0;
+	}
+
+	mutex_init(&tda7802->diagnostic_mutex);
+	err = debugfs_create_file("diagnostic", 0444, tda7802->debugfs, tda7802,
+			&tda7802_diagnostic_fops);
+	if (err < 0) {
+		dev_err(dev,
+			"debugfs: Failed to create diagnostic node, err %d\n",
+			err);
+		goto cleanup_diagnostic;
+	}
+
+	return 0;
+
+cleanup_diagnostic:
+	mutex_destroy(&tda7802->diagnostic_mutex);
+	return err;
+}
+
+static void tda7802_remove(struct snd_soc_component *component)
+{
+	struct tda7802_priv *tda7802 = snd_soc_component_get_drvdata(component);
+
+	debugfs_remove_recursive(tda7802->debugfs);
+	mutex_destroy(&tda7802->diagnostic_mutex);
+}
+
 static const struct snd_soc_component_driver tda7802_component_driver = {
+	.probe = tda7802_probe,
+	.remove = tda7802_remove,
 	.set_bias_level = tda7802_set_bias_level,
 	.idle_bias_on = 1,
 	.suspend_bias_off = 1,
-- 
2.21.0

