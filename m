Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 669CAC31E4D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 18:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2935F2184C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 18:43:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EYQsSb5m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbfFNSns (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 14:43:48 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:46044 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbfFNSno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 14:43:44 -0400
Received: by mail-io1-f67.google.com with SMTP id e3so7832162ioc.12
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 11:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vi8wiyJqYbAXjxvzYNEGOh/JyqWII/XYxgVecFPWfWU=;
        b=EYQsSb5mEdAAtd3CjnKIlONCD5H11UEU6lKw0w0FbwfZPEWoMbxUanen8LH+vB1hQb
         QxHcYZR4tp+yBoCESu/1eZndVi2jPdjDa/RL4HwptizIbLiNiTQbI5rfx9WK/YsJORqP
         bOipKTBe+Y7YK2zvjsv6a7RjT/fOx0en4H4m4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vi8wiyJqYbAXjxvzYNEGOh/JyqWII/XYxgVecFPWfWU=;
        b=aknEtmqj1x1Vnb7vMwny8KMC+ydhsftWCNNO9E89P0CyXAss/zK6KMfTjMBpMtTFRm
         /SP95gnAiQhNYRTjDGKkp8O1x2vw/ApaaaoH7QxgTebZJlCn69Qm/p8woanw198Zj4t1
         gjl2q4DNXct/fCNfawL9tjGtGZydhNaTfjqw+oM5X+rK/c9yqE0emZ+yG88mLetbpnHL
         R9N/R7SgOdNpqWLkY41plMmn65tAI48n9+vVu0hIHjaZ9glkLT3JWN/yRaZKPoTMbHdU
         7R8OsjcCbii02x4MgQIfdvdlCxlk5t3APzaDKI2osqZGtJAGNOQB0aTRJj6KEBCYqfi7
         n15A==
X-Gm-Message-State: APjAAAW7WGseayY5eOwZ+rAgASckHQ95yF/9UrSgj4NBj5ErxaswMWRf
        QTHeouKHR/y0yJ5zi5brGuCJPWxRhkyJQg==
X-Google-Smtp-Source: APXvYqxR3djTRg09eRuMgYRxE6cqGPQPEtZJeTbPIVOQ/+2BrC6KvaV97WSOmZTpPuaozbOOufv2Nw==
X-Received: by 2002:a02:1006:: with SMTP id 6mr69717352jay.47.1560537823707;
        Fri, 14 Jun 2019 11:43:43 -0700 (PDT)
Received: from localhost ([2620:15c:183:200:33ce:f5cf:f863:d3a6])
        by smtp.gmail.com with ESMTPSA id b8sm5095755ioj.16.2019.06.14.11.43.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jun 2019 11:43:43 -0700 (PDT)
From:   Fletcher Woodruff <fletcherw@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ben Zhang <benzh@chromium.org>, Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Oder Chiou <oder_chiou@realtek.com>,
        Takashi Iwai <tiwai@suse.com>,
        Curtis Malainey <cujomalainey@chromium.org>,
        Ross Zwisler <zwisler@chromium.org>,
        alsa-devel@alsa-project.org,
        Fletcher Woodruff <fletcherw@chromium.org>
Subject: [PATCH v6 3/4] ASoC: rt5677: clear interrupts by polarity flip
Date:   Fri, 14 Jun 2019 12:43:14 -0600
Message-Id: <20190614184315.252945-4-fletcherw@chromium.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
In-Reply-To: <20190614184315.252945-1-fletcherw@chromium.org>
References: <20190614184315.252945-1-fletcherw@chromium.org>
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
 sound/soc/codecs/rt5677.c | 170 ++++++++++++++++++++++++++++++--------
 sound/soc/codecs/rt5677.h |   7 +-
 2 files changed, 143 insertions(+), 34 deletions(-)

diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index b508fd9b7d4536..a136ed0d82e36b 100644
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
@@ -5041,30 +5044,130 @@ static void rt5677_read_device_properties(struct rt5677_priv *rt5677,
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
-	.name = "rt5677",
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
+		pr_err("rt5677: failed reading IRQ status: %d\n", ret);
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
+		pr_err("rt5677: failed updating IRQ status: %d\n", ret);
+		goto exit;
+	}
+exit:
+	mutex_unlock(&rt5677->irq_lock);
+	if (irq_fired)
+		return IRQ_HANDLED;
+	else
+		return IRQ_NONE;
+}
 
-	.num_regs = 1,
-	.status_base = RT5677_IRQ_CTRL1,
-	.mask_base = RT5677_IRQ_CTRL1,
-	.mask_invert = 1,
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
+
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
@@ -5083,6 +5186,8 @@ static int rt5677_init_irq(struct i2c_client *i2c)
 		return -EINVAL;
 	}
 
+	mutex_init(&rt5677->irq_lock);
+
 	/*
 	 * Select RC as the debounce clock so that GPIO works even when
 	 * MCLK is gated which happens when there is no audio stream
@@ -5091,7 +5196,6 @@ static int rt5677_init_irq(struct i2c_client *i2c)
 	regmap_update_bits(rt5677->regmap, RT5677_DIG_MISC,
 			RT5677_IRQ_DEBOUNCE_SEL_MASK,
 			RT5677_IRQ_DEBOUNCE_SEL_RC);
-
 	/* Enable auto power on RC when GPIO states are changed */
 	regmap_update_bits(rt5677->regmap, RT5677_GEN_CTRL1, 0xff, 0xff);
 
@@ -5114,26 +5218,25 @@ static int rt5677_init_irq(struct i2c_client *i2c)
 	regmap_update_bits(rt5677->regmap, RT5677_GPIO_CTRL1,
 			RT5677_GPIO1_PIN_MASK, RT5677_GPIO1_PIN_IRQ);
 
-	ret = regmap_add_irq_chip(rt5677->regmap, i2c->irq,
-		IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING | IRQF_ONESHOT, 0,
-		&rt5677_irq_chip, &rt5677->irq_data);
+	/* Ready to listen for interrupts */
+	rt5677->domain = irq_domain_add_linear(i2c->dev.of_node,
+			RT5677_IRQ_NUM, &rt5677_domain_ops, rt5677);
+	if (!rt5677->domain) {
+		dev_err(&i2c->dev, "Failed to create IRQ domain\n");
+		return -ENOMEM;
+	}
 
-	if (ret != 0) {
-		dev_err(&i2c->dev, "Failed to register IRQ chip: %d\n", ret);
+	ret = devm_request_threaded_irq(&i2c->dev, i2c->irq, NULL, rt5677_irq,
+			IRQF_TRIGGER_RISING | IRQF_ONESHOT,
+			"rt5677", rt5677);
+	if (ret) {
+		dev_err(&i2c->dev, "Failed to request IRQ: %d\n", ret);
 		return ret;
 	}
 
 	return 0;
 }
 
-static void rt5677_free_irq(struct i2c_client *i2c)
-{
-	struct rt5677_priv *rt5677 = i2c_get_clientdata(i2c);
-
-	if (rt5677->irq_data)
-		regmap_del_irq_chip(i2c->irq, rt5677->irq_data);
-}
-
 static int rt5677_i2c_probe(struct i2c_client *i2c)
 {
 	struct rt5677_priv *rt5677;
@@ -5258,7 +5361,9 @@ static int rt5677_i2c_probe(struct i2c_client *i2c)
 			RT5677_MICBIAS1_CTRL_VDD_3_3V);
 
 	rt5677_init_gpio(i2c);
-	rt5677_init_irq(i2c);
+	ret = rt5677_init_irq(i2c);
+	if (ret)
+		dev_err(&i2c->dev, "Failed to initialize irq: %d\n", ret);
 
 	return devm_snd_soc_register_component(&i2c->dev,
 				      &soc_component_dev_rt5677,
@@ -5267,7 +5372,6 @@ static int rt5677_i2c_probe(struct i2c_client *i2c)
 
 static int rt5677_i2c_remove(struct i2c_client *i2c)
 {
-	rt5677_free_irq(i2c);
 	rt5677_free_gpio(i2c);
 
 	return 0;
diff --git a/sound/soc/codecs/rt5677.h b/sound/soc/codecs/rt5677.h
index 7a89bfa95dc0bf..a891a9b9eba3e6 100644
--- a/sound/soc/codecs/rt5677.h
+++ b/sound/soc/codecs/rt5677.h
@@ -1719,6 +1719,7 @@ enum {
 	RT5677_IRQ_JD1,
 	RT5677_IRQ_JD2,
 	RT5677_IRQ_JD3,
+	RT5677_IRQ_NUM,
 };
 
 enum rt5677_type {
@@ -1817,9 +1818,13 @@ struct rt5677_priv {
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

