Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A60C31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 23:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87E472085A
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 23:46:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nhCjMwuO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729189AbfFRXqQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 19:46:16 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:43738 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfFRXqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 19:46:15 -0400
Received: by mail-io1-f65.google.com with SMTP id k20so33863766ios.10
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 16:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nWhkjxqFipTNO68H5+iRgW59377UJQqp4/F673C7jf8=;
        b=nhCjMwuO7fVP3/ETNKyenHmXlf9fD7eFi36GM4QM9SCCYTXjc3b6ElpKPZafSSRQuW
         D0UAKxzILo2xN3yLDA/wL3IBe2vdJuKWlidpTe5QmPZ8cYBqSrmn3iZIOEna11w76a1T
         pRkTUuC2IJv3F6Axt6k4nyiPS+JC+CR6kINDM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nWhkjxqFipTNO68H5+iRgW59377UJQqp4/F673C7jf8=;
        b=My1URQODv7iUnyjYR18OOEtAcPuXhWYVT8eTL8AzrNbqCIQCW1HpRWfBIkszF7hNAA
         CQE8TF2ZMnW9ePRvuljFzCLtk871cmmjkvXGeqCOb4D9u4SnccLmUdvlC6ZXsKm2RN9Y
         mgN3EN3easPcicfYOiEKmeVIk3K3swh3iSDfbi9cAiV9OID1hnP0lTUPGPTJ7NSaCMHw
         FvJ+8EuMA8LBO7gnIXKSxUQSAGLZTyCaFY6tGi5vwjnn05EkBQmR3gylAfE4JFj3HX22
         cnrbhPyta29chKGQeAi1d3qBmaYZIdikanfkbAhpOCKqH73xQM0d2sHFfZZ3LzhPOMFw
         bZWg==
X-Gm-Message-State: APjAAAWQok0C2cGpML80mKDO3gvdviNlPbxs4bG9CndztTBhdvqHY5hx
        ryYwYDIbozkENdfMFEKTHbFcxXQZum2B4w==
X-Google-Smtp-Source: APXvYqwNz05VsAyVFNBd6yDRgHKuWDU1N+9n7YJqqlvF1QyBExbrf4eupLue6wzaw3T0ALxt+6gqwA==
X-Received: by 2002:a5d:968b:: with SMTP id m11mr5496756ion.16.1560901574129;
        Tue, 18 Jun 2019 16:46:14 -0700 (PDT)
Received: from localhost ([2620:15c:183:200:33ce:f5cf:f863:d3a6])
        by smtp.gmail.com with ESMTPSA id t5sm11950191iol.55.2019.06.18.16.46.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 16:46:13 -0700 (PDT)
From:   Fletcher Woodruff <fletcherw@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ben Zhang <benzh@chromium.org>,
        Fletcher Woodruff <fletcherw@chromium.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Oder Chiou <oder_chiou@realtek.com>,
        Takashi Iwai <tiwai@suse.com>,
        Curtis Malainey <cujomalainey@chromium.org>,
        Ross Zwisler <zwisler@chromium.org>,
        alsa-devel@alsa-project.org
Subject: [PATCH v8 1/2] ASoC: rt5677: clear interrupts by polarity flip
Date:   Tue, 18 Jun 2019 17:45:54 -0600
Message-Id: <20190618234555.188955-2-fletcherw@chromium.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
In-Reply-To: <20190618234555.188955-1-fletcherw@chromium.org>
References: <20190618234555.188955-1-fletcherw@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Zhang <benzh@chromium.org>

The rt5677 jack detection function has a requirement that the polarity
of an interrupt be flipped after it fires in order to clear the
interrupt.

This patch implements an irq_chip with irq_domain directly instead of
using regmap-irq, so that interrupt source line polarities can be
flipped in the irq handler.

The reason that this patch does not add this feature within regmap-irq
is that future patches will add hotword detection support to this irq
handler. Those patches will require adding additional logic that would
not make sense to have in regmap-irq.

Signed-off-by: Ben Zhang <benzh@chromium.org>
Signed-off-by: Fletcher Woodruff <fletcherw@chromium.org>
---
 sound/soc/codecs/rt5677.c | 173 ++++++++++++++++++++++++++++++--------
 sound/soc/codecs/rt5677.h |   8 +-
 2 files changed, 145 insertions(+), 36 deletions(-)

diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index 87a92ba0d040b7..b5ae61ff87af13 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -23,6 +23,10 @@
 #include <linux/firmware.h>
 #include <linux/of_device.h>
 #include <linux/property.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+#include <linux/irqdomain.h>
+#include <linux/workqueue.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -4620,7 +4624,6 @@ static void rt5677_gpio_config(struct rt5677_priv *rt5677, unsigned offset,
 static int rt5677_to_irq(struct gpio_chip *chip, unsigned offset)
 {
 	struct rt5677_priv *rt5677 = gpiochip_get_data(chip);
-	struct regmap_irq_chip_data *data = rt5677->irq_data;
 	int irq;
 
 	if ((rt5677->pdata.jd1_gpio == 1 && offset == RT5677_GPIO1) ||
@@ -4646,7 +4649,7 @@ static int rt5677_to_irq(struct gpio_chip *chip, unsigned offset)
 		return -ENXIO;
 	}
 
-	return regmap_irq_get_virq(data, irq);
+	return irq_create_mapping(rt5677->domain, irq);
 }
 
 static const struct gpio_chip rt5677_template_chip = {
@@ -5042,30 +5045,130 @@ static void rt5677_read_device_properties(struct rt5677_priv *rt5677,
 		rt5677->pdata.jd3_gpio = val;
 }
 
-static struct regmap_irq rt5677_irqs[] = {
+struct rt5677_irq_desc {
+	unsigned int enable_mask;
+	unsigned int status_mask;
+	unsigned int polarity_mask;
+};
+
+static const struct rt5677_irq_desc rt5677_irq_descs[] = {
 	[RT5677_IRQ_JD1] = {
-		.reg_offset = 0,
-		.mask = RT5677_EN_IRQ_GPIO_JD1,
+		.enable_mask = RT5677_EN_IRQ_GPIO_JD1,
+		.status_mask = RT5677_STA_GPIO_JD1,
+		.polarity_mask = RT5677_INV_GPIO_JD1,
 	},
 	[RT5677_IRQ_JD2] = {
-		.reg_offset = 0,
-		.mask = RT5677_EN_IRQ_GPIO_JD2,
+		.enable_mask = RT5677_EN_IRQ_GPIO_JD2,
+		.status_mask = RT5677_STA_GPIO_JD2,
+		.polarity_mask = RT5677_INV_GPIO_JD2,
 	},
 	[RT5677_IRQ_JD3] = {
-		.reg_offset = 0,
-		.mask = RT5677_EN_IRQ_GPIO_JD3,
+		.enable_mask = RT5677_EN_IRQ_GPIO_JD3,
+		.status_mask = RT5677_STA_GPIO_JD3,
+		.polarity_mask = RT5677_INV_GPIO_JD3,
 	},
 };
 
-static struct regmap_irq_chip rt5677_irq_chip = {
-	.name = RT5677_DRV_NAME,
-	.irqs = rt5677_irqs,
-	.num_irqs = ARRAY_SIZE(rt5677_irqs),
+static irqreturn_t rt5677_irq(int unused, void *data)
+{
+	struct rt5677_priv *rt5677 = data;
+	int ret = 0, i, reg_irq, virq;
+	bool irq_fired = false;
+
+	mutex_lock(&rt5677->irq_lock);
+	/* Read interrupt status */
+	ret = regmap_read(rt5677->regmap, RT5677_IRQ_CTRL1, &reg_irq);
+	if (ret) {
+		dev_err(rt5677->dev, "failed reading IRQ status: %d\n", ret);
+		goto exit;
+	}
+
+	for (i = 0; i < RT5677_IRQ_NUM; i++) {
+		if (reg_irq & rt5677_irq_descs[i].status_mask) {
+			irq_fired = true;
+			virq = irq_find_mapping(rt5677->domain, i);
+			if (virq)
+				handle_nested_irq(virq);
+
+			/* Clear the interrupt by flipping the polarity of the
+			 * interrupt source line that fired
+			 */
+			reg_irq ^= rt5677_irq_descs[i].polarity_mask;
+		}
+	}
+
+	if (!irq_fired)
+		goto exit;
+
+	ret = regmap_write(rt5677->regmap, RT5677_IRQ_CTRL1, reg_irq);
+	if (ret) {
+		dev_err(rt5677->dev, "failed updating IRQ status: %d\n", ret);
+		goto exit;
+	}
+exit:
+	mutex_unlock(&rt5677->irq_lock);
+	if (irq_fired)
+		return IRQ_HANDLED;
+	else
+		return IRQ_NONE;
+}
+
+static void rt5677_irq_bus_lock(struct irq_data *data)
+{
+	struct rt5677_priv *rt5677 = irq_data_get_irq_chip_data(data);
+
+	mutex_lock(&rt5677->irq_lock);
+}
+
+static void rt5677_irq_bus_sync_unlock(struct irq_data *data)
+{
+	struct rt5677_priv *rt5677 = irq_data_get_irq_chip_data(data);
+
+	// Set the enable/disable bits for the jack detect IRQs.
+	regmap_update_bits(rt5677->regmap, RT5677_IRQ_CTRL1,
+			RT5677_EN_IRQ_GPIO_JD1 | RT5677_EN_IRQ_GPIO_JD2 |
+			RT5677_EN_IRQ_GPIO_JD3, rt5677->irq_en);
+	mutex_unlock(&rt5677->irq_lock);
+}
+
+static void rt5677_irq_enable(struct irq_data *data)
+{
+	struct rt5677_priv *rt5677 = irq_data_get_irq_chip_data(data);
+
+	rt5677->irq_en |= rt5677_irq_descs[data->hwirq].enable_mask;
+}
 
-	.num_regs = 1,
-	.status_base = RT5677_IRQ_CTRL1,
-	.mask_base = RT5677_IRQ_CTRL1,
-	.mask_invert = 1,
+static void rt5677_irq_disable(struct irq_data *data)
+{
+	struct rt5677_priv *rt5677 = irq_data_get_irq_chip_data(data);
+
+	rt5677->irq_en &= ~rt5677_irq_descs[data->hwirq].enable_mask;
+}
+
+static struct irq_chip rt5677_irq_chip = {
+	.name			= "rt5677_irq_chip",
+	.irq_bus_lock		= rt5677_irq_bus_lock,
+	.irq_bus_sync_unlock	= rt5677_irq_bus_sync_unlock,
+	.irq_disable		= rt5677_irq_disable,
+	.irq_enable		= rt5677_irq_enable,
+};
+
+static int rt5677_irq_map(struct irq_domain *h, unsigned int virq,
+			  irq_hw_number_t hw)
+{
+	struct rt5677_priv *rt5677 = h->host_data;
+
+	irq_set_chip_data(virq, rt5677);
+	irq_set_chip(virq, &rt5677_irq_chip);
+	irq_set_nested_thread(virq, 1);
+	irq_set_noprobe(virq);
+	return 0;
+}
+
+
+static const struct irq_domain_ops rt5677_domain_ops = {
+	.map	= rt5677_irq_map,
+	.xlate	= irq_domain_xlate_twocell,
 };
 
 static int rt5677_init_irq(struct i2c_client *i2c)
@@ -5084,6 +5187,8 @@ static int rt5677_init_irq(struct i2c_client *i2c)
 		return -EINVAL;
 	}
 
+	mutex_init(&rt5677->irq_lock);
+
 	/*
 	 * Select RC as the debounce clock so that GPIO works even when
 	 * MCLK is gated which happens when there is no audio stream
@@ -5092,7 +5197,6 @@ static int rt5677_init_irq(struct i2c_client *i2c)
 	regmap_update_bits(rt5677->regmap, RT5677_DIG_MISC,
 			RT5677_IRQ_DEBOUNCE_SEL_MASK,
 			RT5677_IRQ_DEBOUNCE_SEL_RC);
-
 	/* Enable auto power on RC when GPIO states are changed */
 	regmap_update_bits(rt5677->regmap, RT5677_GEN_CTRL1, 0xff, 0xff);
 
@@ -5115,24 +5219,21 @@ static int rt5677_init_irq(struct i2c_client *i2c)
 	regmap_update_bits(rt5677->regmap, RT5677_GPIO_CTRL1,
 			RT5677_GPIO1_PIN_MASK, RT5677_GPIO1_PIN_IRQ);
 
-	ret = regmap_add_irq_chip(rt5677->regmap, i2c->irq,
-		IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING | IRQF_ONESHOT, 0,
-		&rt5677_irq_chip, &rt5677->irq_data);
-
-	if (ret != 0) {
-		dev_err(&i2c->dev, "Failed to register IRQ chip: %d\n", ret);
-		return ret;
+	/* Ready to listen for interrupts */
+	rt5677->domain = irq_domain_add_linear(i2c->dev.of_node,
+			RT5677_IRQ_NUM, &rt5677_domain_ops, rt5677);
+	if (!rt5677->domain) {
+		dev_err(&i2c->dev, "Failed to create IRQ domain\n");
+		return -ENOMEM;
 	}
 
-	return 0;
-}
+	ret = devm_request_threaded_irq(&i2c->dev, i2c->irq, NULL, rt5677_irq,
+			IRQF_TRIGGER_RISING | IRQF_ONESHOT,
+			"rt5677", rt5677);
+	if (ret)
+		dev_err(&i2c->dev, "Failed to request IRQ: %d\n", ret);
 
-static void rt5677_free_irq(struct i2c_client *i2c)
-{
-	struct rt5677_priv *rt5677 = i2c_get_clientdata(i2c);
-
-	if (rt5677->irq_data)
-		regmap_del_irq_chip(i2c->irq, rt5677->irq_data);
+	return ret;
 }
 
 static int rt5677_i2c_probe(struct i2c_client *i2c)
@@ -5146,6 +5247,7 @@ static int rt5677_i2c_probe(struct i2c_client *i2c)
 	if (rt5677 == NULL)
 		return -ENOMEM;
 
+	rt5677->dev = &i2c->dev;
 	i2c_set_clientdata(i2c, rt5677);
 
 	if (i2c->dev.of_node) {
@@ -5259,7 +5361,9 @@ static int rt5677_i2c_probe(struct i2c_client *i2c)
 			RT5677_MICBIAS1_CTRL_VDD_3_3V);
 
 	rt5677_init_gpio(i2c);
-	rt5677_init_irq(i2c);
+	ret = rt5677_init_irq(i2c);
+	if (ret)
+		dev_err(&i2c->dev, "Failed to initialize irq: %d\n", ret);
 
 	return devm_snd_soc_register_component(&i2c->dev,
 				      &soc_component_dev_rt5677,
@@ -5268,7 +5372,6 @@ static int rt5677_i2c_probe(struct i2c_client *i2c)
 
 static int rt5677_i2c_remove(struct i2c_client *i2c)
 {
-	rt5677_free_irq(i2c);
 	rt5677_free_gpio(i2c);
 
 	return 0;
diff --git a/sound/soc/codecs/rt5677.h b/sound/soc/codecs/rt5677.h
index c26edd387e340b..45633d8b6a199c 100644
--- a/sound/soc/codecs/rt5677.h
+++ b/sound/soc/codecs/rt5677.h
@@ -1749,6 +1749,7 @@ enum {
 	RT5677_IRQ_JD1,
 	RT5677_IRQ_JD2,
 	RT5677_IRQ_JD3,
+	RT5677_IRQ_NUM,
 };
 
 enum rt5677_type {
@@ -1827,6 +1828,7 @@ struct rt5677_platform_data {
 
 struct rt5677_priv {
 	struct snd_soc_component *component;
+	struct device *dev;
 	struct rt5677_platform_data pdata;
 	struct regmap *regmap, *regmap_physical;
 	const struct firmware *fw1, *fw2;
@@ -1847,9 +1849,13 @@ struct rt5677_priv {
 	struct gpio_chip gpio_chip;
 #endif
 	bool dsp_vad_en;
-	struct regmap_irq_chip_data *irq_data;
 	bool is_dsp_mode;
 	bool is_vref_slow;
+
+	/* Interrupt handling */
+	struct irq_domain *domain;
+	struct mutex irq_lock;
+	unsigned int irq_en;
 };
 
 int rt5677_sel_asrc_clk_src(struct snd_soc_component *component,
-- 
2.22.0.410.gd8fdbe21b5-goog

