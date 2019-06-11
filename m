Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D34B6C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 17:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC3B620866
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 17:49:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406637AbfFKRt5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 13:49:57 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:36927 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406592AbfFKRtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 13:49:55 -0400
Received: from [167.98.27.226] (helo=ct-lt-1124.office.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1haktg-0001PN-4P; Tue, 11 Jun 2019 18:49:24 +0100
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
Subject: [PATCH v1 4/4] ASoC: tda7802: Add speaker-test sysfs
Date:   Tue, 11 Jun 2019 18:49:09 +0100
Message-Id: <20190611174909.12162-5-thomas.preston@codethink.co.uk>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190611174909.12162-1-thomas.preston@codethink.co.uk>
References: <20190611174909.12162-1-thomas.preston@codethink.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add speaker_test device attribute. When the speaker-test node is read
the hardware speaker test is started.

	$ cat /sys/devices/.../device:00/speaker_test
	04 04 04 04

Signed-off-by: Thomas Preston <thomas.preston@codethink.co.uk>
Cc: Patrick Glaser <pglaser@tesla.com>
Cc: Rob Duncan <rduncan@tesla.com>
Cc: Nate Case <ncase@tesla.com>
---
 sound/soc/codecs/tda7802.c | 172 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 172 insertions(+)

diff --git a/sound/soc/codecs/tda7802.c b/sound/soc/codecs/tda7802.c
index 62aae011d9f1..edfa752c0c9f 100644
--- a/sound/soc/codecs/tda7802.c
+++ b/sound/soc/codecs/tda7802.c
@@ -157,6 +157,7 @@ static const u8 IB3_FORMAT[4][4] = {
 #define DUMP_NUM_REGS			   (DUMP_NUM_BLOCK * 2)
 
 struct tda7802_priv {
+	struct mutex mutex;
 	struct i2c_client *i2c;
 	struct regmap *regmap;
 	struct regulator *enable_reg;
@@ -458,6 +459,159 @@ static struct snd_soc_dai_driver tda7802_dai_driver = {
 	.ops = &tda7802_dai_ops,
 };
 
+/* The speaker test is triggered by reading a sysfs attribute file attached to
+ * the I2C device. The user space thread that's doing the reading is blocked
+ * until the test completes (or times out). We only permit one test to be in
+ * progress at a time.
+ */
+
+static int speaker_test_start(struct regmap *regmap)
+{
+	int err;
+
+	err = regmap_update_bits(regmap, TDA7802_IB5, IB5_AMPLIFIER_ON, 0);
+	if (err < 0) {
+		dev_err(regmap_get_device(regmap),
+			"Cannot disable amp for speaker test (%d)\n", err);
+		return err;
+	}
+
+	err = regmap_update_bits(regmap, TDA7802_IB4, IB4_DIAG_MODE_ENABLE, 0);
+	if (err < 0) {
+		dev_err(regmap_get_device(regmap),
+			"Cannot disable diag mode before speaker test (%d)\n",
+			err);
+		return err;
+	}
+
+	/* Seem to need at least a 15 ms delay here before the rising
+	 * edge. Otherwise the diagnostics never complete (perhaps
+	 * they never start).
+	 */
+	msleep(20);
+
+	err = regmap_update_bits(regmap, TDA7802_IB4,
+				 IB4_DIAG_MODE_ENABLE, IB4_DIAG_MODE_ENABLE);
+	if (err < 0) {
+		dev_err(regmap_get_device(regmap),
+			"Cannot enable diag mode for speaker test (%d)\n", err);
+		return err;
+	}
+
+	return 0;
+}
+
+static int speaker_test_stop(struct regmap *regmap)
+{
+	int err;
+
+	err = regmap_update_bits(regmap, TDA7802_IB4, IB4_DIAG_MODE_ENABLE, 0);
+	if (err < 0)
+		dev_err(regmap_get_device(regmap),
+			"Cannot disable diag mode after speaker test (%d)\n",
+			err);
+	return err;
+}
+
+/* We poll the test completion bit, letting the current thread sleep
+ * until we're done. These values are not critical.
+ */
+#define SPEAKER_TEST_DONE_POLL_PERIOD_US 5000
+#define SPEAKER_TEST_DONE_TIMEOUT_US	 5000000
+
+static int speaker_test_check(struct tda7802_priv *tda7802,
+		unsigned int *status)
+{
+	struct regmap *regmap = tda7802->regmap;
+	struct device *dev = &tda7802->i2c->dev;
+	int reg_err = 0, err = 0, i, amp_on;
+	unsigned int val;
+
+	reg_err = regulator_enable(tda7802->enable_reg);
+	if (reg_err < 0) {
+		dev_err(dev, "Could not enable (speaker-test).\n");
+		return reg_err;
+	}
+	msleep(ENABLE_DELAY_MS);
+
+	/* we should return amp on state when speaker-test is done */
+	err = regmap_read(regmap, TDA7802_IB5, &amp_on);
+	if (err < 0) {
+		dev_err(dev, "Could not read amp on state (speaker-test)\n");
+		goto speaker_test_disable;
+	}
+
+	for (i = 0; i < CHANNELS_PER_AMP; ++i)
+		status[i] = 0xff;
+
+	err = speaker_test_start(regmap);
+	if (err < 0)
+		goto speaker_test_restore;
+
+	/* Wait until DB0_STARTUP_DIAG_STATUS is set */
+	err = regmap_read_poll_timeout(regmap, TDA7802_DB0, val,
+			val & DB0_STARTUP_DIAG_STATUS,
+			SPEAKER_TEST_DONE_POLL_PERIOD_US,
+			SPEAKER_TEST_DONE_TIMEOUT_US);
+	if (err < 0) {
+		if (err == -ENODATA)
+			dev_err(dev,
+				"Speaker diagnostic test did not complete\n");
+		speaker_test_stop(regmap);
+		goto speaker_test_restore;
+	}
+
+	err = speaker_test_stop(regmap);
+	if (err < 0)
+		goto speaker_test_restore;
+
+	for (i = 0; i < CHANNELS_PER_AMP; ++i) {
+		err = regmap_read(regmap, TDA7802_DB1 + i, status + i);
+		if (err < 0) {
+			dev_err(dev,
+				"Cannot get speaker %d status (%d)\n", i, err);
+			goto speaker_test_restore;
+		}
+	}
+
+speaker_test_restore:
+	err = regmap_update_bits(regmap, TDA7802_IB5, IB5_AMPLIFIER_ON,
+			amp_on);
+	if (err < 0)
+		dev_err(dev, "Could not restore amp on state (speaker-test)\n");
+
+speaker_test_disable:
+	reg_err = regulator_disable(tda7802->enable_reg);
+	if (reg_err < 0) {
+		dev_err(dev, "Could not disable (speaker-test).\n");
+		return reg_err;
+	}
+	return err;
+}
+
+static ssize_t speaker_test_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct tda7802_priv *tda7802 = dev_get_drvdata(dev);
+	unsigned int channel_status[CHANNELS_PER_AMP];
+	char *str = buf;
+	int ret, i;
+
+	mutex_lock(&tda7802->mutex);
+	ret = speaker_test_check(tda7802, channel_status);
+	mutex_unlock(&tda7802->mutex);
+	if (ret < 0)
+		return ret;
+
+	for (i = 0; i < CHANNELS_PER_AMP; i++)
+		str += sprintf(str, "%02x ", channel_status[i]);
+	str += sprintf(str, "\n");
+
+	return str - buf;
+}
+
+static DEVICE_ATTR_RO(speaker_test);
+
 static ssize_t enable_show(struct device *dev, struct device_attribute *attr,
 		char *buf)
 {
@@ -537,12 +691,28 @@ static int tda7802_probe(struct snd_soc_component *component)
 
 	dev_dbg(dev, "%s\n", __func__);
 
+	/* Device is ready, now we should create sysfs attributes.
+	 * Rememer to cleanup
+	 */
 	err = device_create_file(dev, &dev_attr_enable);
 	if (err < 0) {
 		dev_err(dev, "Could not create enable attr\n");
 		return err;
 	}
 
+	mutex_init(&tda7802->mutex);
+	err = device_create_file(dev, &dev_attr_speaker_test);
+	if (err < 0) {
+		dev_err(dev, "Could not create speaker_test attr\n");
+		goto cleanup_speaker_test;
+	}
+
+	return 0;
+
+cleanup_speaker_test:
+	mutex_destroy(&tda7802->mutex);
+	device_remove_file(&tda7802->i2c->dev, &dev_attr_enable);
+
 	return err;
 }
 
@@ -550,6 +720,8 @@ static void tda7802_remove(struct snd_soc_component *component)
 {
 	struct tda7802_priv *tda7802 = snd_soc_component_get_drvdata(component);
 
+	device_remove_file(&tda7802->i2c->dev, &dev_attr_speaker_test);
+	mutex_destroy(&tda7802->mutex);
 	device_remove_file(&tda7802->i2c->dev, &dev_attr_enable);
 }
 
-- 
2.11.0

