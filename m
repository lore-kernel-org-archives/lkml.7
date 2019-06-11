Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B036FC4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 17:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 909B720866
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 17:49:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406542AbfFKRtt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 13:49:49 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:36904 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405488AbfFKRts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 13:49:48 -0400
Received: from [167.98.27.226] (helo=ct-lt-1124.office.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1haktf-0001PN-FW; Tue, 11 Jun 2019 18:49:23 +0100
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
Subject: [PATCH v1 3/4] ASoC: tda7802: Add enable device attribute
Date:   Tue, 11 Jun 2019 18:49:08 +0100
Message-Id: <20190611174909.12162-4-thomas.preston@codethink.co.uk>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190611174909.12162-1-thomas.preston@codethink.co.uk>
References: <20190611174909.12162-1-thomas.preston@codethink.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a device attribute to control the enable regulator. Write 1 to
enable, 0 to disable (ref-count minus one), or -1 to force disable the
physical pin.

To disable a set of amplifiers wired to the same enable gpio, each
device must be disabled. For example:

	echo 0 > /sys/devices/.../device:00/enable
	echo 0 > /sys/devices/.../device:01/enable

In an emergency, we can force disable from any device:

	echo -1 > /sys/devices/.../device:00/enable

Signed-off-by: Thomas Preston <thomas.preston@codethink.co.uk>
Cc: Patrick Glaser <pglaser@tesla.com>
Cc: Rob Duncan <rduncan@tesla.com>
Cc: Nate Case <ncase@tesla.com>
---
 sound/soc/codecs/tda7802.c | 65 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 64 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tda7802.c b/sound/soc/codecs/tda7802.c
index 38ca52de85f0..62aae011d9f1 100644
--- a/sound/soc/codecs/tda7802.c
+++ b/sound/soc/codecs/tda7802.c
@@ -458,6 +458,42 @@ static struct snd_soc_dai_driver tda7802_dai_driver = {
 	.ops = &tda7802_dai_ops,
 };
 
+static ssize_t enable_show(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	struct tda7802_priv *tda7802 = dev_get_drvdata(dev);
+	int enabled = regulator_is_enabled(tda7802->enable_reg) ? 1 : 0;
+
+	return scnprintf(buf, PAGE_SIZE, "%d\n", enabled);
+}
+
+static ssize_t enable_store(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t count)
+{
+	struct tda7802_priv *tda7802 = dev_get_drvdata(dev);
+	int err;
+
+	if (sysfs_streq(buf, "1")) {
+		err = regulator_enable(tda7802->enable_reg);
+		if (err < 0)
+			dev_err(dev, "Could not enable (sysfs)\n");
+	} else if (sysfs_streq(buf, "0")) {
+		err = regulator_disable(tda7802->enable_reg);
+		if (err < 0)
+			dev_err(dev, "Could not disable (sysfs)\n");
+	} else if (sysfs_streq(buf, "-1")) {
+		err = regulator_force_disable(tda7802->enable_reg);
+		if (err < 0)
+			dev_err(dev, "Could not force disable (sysfs)\n");
+	} else {
+		return -EINVAL;
+	}
+
+	return count;
+}
+
+static DEVICE_ATTR_RW(enable);
+
 /* read device tree or ACPI properties from device */
 static int tda7802_read_properties(struct tda7802_priv *tda7802)
 {
@@ -493,7 +529,34 @@ static int tda7802_read_properties(struct tda7802_priv *tda7802)
 	return err;
 }
 
-static const struct snd_soc_component_driver tda7802_component_driver;
+static int tda7802_probe(struct snd_soc_component *component)
+{
+	struct tda7802_priv *tda7802 = snd_soc_component_get_drvdata(component);
+	struct device *dev = &tda7802->i2c->dev;
+	int err;
+
+	dev_dbg(dev, "%s\n", __func__);
+
+	err = device_create_file(dev, &dev_attr_enable);
+	if (err < 0) {
+		dev_err(dev, "Could not create enable attr\n");
+		return err;
+	}
+
+	return err;
+}
+
+static void tda7802_remove(struct snd_soc_component *component)
+{
+	struct tda7802_priv *tda7802 = snd_soc_component_get_drvdata(component);
+
+	device_remove_file(&tda7802->i2c->dev, &dev_attr_enable);
+}
+
+static const struct snd_soc_component_driver tda7802_component_driver = {
+	.probe = tda7802_probe,
+	.remove = tda7802_remove,
+};
 
 static int tda7802_i2c_probe(struct i2c_client *i2c,
 			     const struct i2c_device_id *id)
-- 
2.11.0

