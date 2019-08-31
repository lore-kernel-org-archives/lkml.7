Return-Path: <SRS0=k4ck=W3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C22C3A5A4
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 03:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D051223717
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 03:10:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=typeblog-net.20150623.gappssmtp.com header.i=@typeblog-net.20150623.gappssmtp.com header.b="KlKjRfva"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728408AbfHaDKk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 23:10:40 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45643 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbfHaDKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 23:10:39 -0400
Received: by mail-pg1-f194.google.com with SMTP id 4so896778pgm.12
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 20:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=typeblog-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SXbglKvD0SQmCRxcZtB9WBlJczTPMt6e3pZqM3DgZ18=;
        b=KlKjRfvad7u6uFblyFqzf8FnNcX/HdKZa8Ou7elxmC+GPWRiGv+M/RH//EOe2nn4WN
         kTz+vJODFike6WQUKh1X9zklhP/gQSg7k7yme0uYvo3xoTNXSWWdukoFtziz0ugRRCJk
         t48o7jdirGq7ZMKPb/rUguEBC2sL/3AOcRGxLv3vrocVmgly3k6DzImNxELKh3fZpHA8
         ShSM0+CW3qBBi8sQZ4RUv7/ZQVA0Tra/QbupG06R2cMpu3WfNpJjwG489pxusCqsYlZp
         HPW9iZpwXScQT0SuB1dKoi7Rqi2Kk9KpVOfTEkhsSU0RX2Rwhj+cUdkFV9fH7Xi1PWmn
         ZTsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SXbglKvD0SQmCRxcZtB9WBlJczTPMt6e3pZqM3DgZ18=;
        b=uIE5Gff0cu8Ce0lvXNaLATguIIB9xDtpS30HOCapF422TA0yy3GKMyMyos6JbSSJIB
         btTYmMh1encvf2qhq/Vq8rwDLRQJtXutGQJCDHwiG/853s4ZSIuT3+ykefTU803CIaRZ
         lQ3omurDYP5ZUcj5sjPFgCyQlgFb5acome7CataN0Awlkg8qz0nhTFuF5FoZFe/CnFjn
         ZaAQSnpWH4qEypE0KT8IO2zpLx40kEVCWhPFnUOk/zykrmWhhYM7TWYHku88lSz8LMmH
         uUVKHFLUB+6HeiMg3s3iAvrflDCPkXVDWKLp/+d9vDqsQghoEMcRXNTWO/mRihH/5ddQ
         3bAQ==
X-Gm-Message-State: APjAAAVCooduMECPY8ccwXP6B1KnUjJpk+VjtWiHYs7ZrsvfMMpO8IMs
        BX5yk9GRIXMOBHC5TfNLSLwQOA==
X-Google-Smtp-Source: APXvYqy3AvEy6GfXGMsBVelFOUgqliOk3kGp0ODR2dCYzbwoReny6L9IgY3VfEzMVZ4Htgn0gs/zcw==
X-Received: by 2002:a17:90a:a00b:: with SMTP id q11mr1783420pjp.91.1567221039116;
        Fri, 30 Aug 2019 20:10:39 -0700 (PDT)
Received: from peter-pc.home ([91.207.174.229])
        by smtp.gmail.com with ESMTPSA id 185sm10961454pff.54.2019.08.30.20.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2019 20:10:38 -0700 (PDT)
From:   Peter Cai <peter@typeblog.net>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Peter Cai <peter@typeblog.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Bastien Nocera <hadess@hadess.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: [PATCH v2 2/2] touchscreen: goodix: define GPIO mapping for GPD P2 Max
Date:   Sat, 31 Aug 2019 11:09:15 +0800
Message-Id: <20190831030916.13172-2-peter@typeblog.net>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190831030916.13172-1-peter@typeblog.net>
References: <20190831030916.13172-1-peter@typeblog.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The firmware of GPD P2 Max could not handle panel resets although code
is present in DSDT. The kernel needs to take on this job instead, but
the DSDT does not provide _DSD, rendering kernel helpless when trying to
find the respective GPIO pins.

Fortunately, this time GPD has proper DMI vendor / product strings that
we could match against. We simply apply an acpi_gpio_mapping table when
GPD P2 Max is matched.

Additionally, the DSDT definition of the irq pin specifies a wrong
polarity. The new quirk introduced in the previous patch
(ACPI_GPIO_QUIRK_OVERRIDE_POLARITY) is applied to correct this.

Signed-off-by: Peter Cai <peter@typeblog.net>
---

v2: removed '#ifdef CONFIG_ACPI' as per suggestion. The #ifdef guards
for CONFIG_DMI is kept for consistency with the other dmi_system_id
definition in the same file.
---
 drivers/input/touchscreen/goodix.c | 31 ++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
index 5178ea8b5f30..df476f7dcd95 100644
--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -144,6 +144,31 @@ static const struct dmi_system_id rotated_screen[] = {
 	{}
 };
 
+static const struct acpi_gpio_params irq_gpios_default = { 0, 0, false };
+static const struct acpi_gpio_params reset_gpios_default = { 1, 0, false };
+static const struct acpi_gpio_mapping gpio_mapping_force_irq_active_high[] = {
+	{ "irq-gpios", &irq_gpios_default, 1, ACPI_GPIO_QUIRK_OVERRIDE_POLARITY },
+	{ "reset-gpios", &reset_gpios_default, 1 },
+	{}
+};
+
+/*
+ * Devices that need acpi_gpio_mapping to function correctly
+ */
+static const struct dmi_system_id need_gpio_mapping[] = {
+#if defined(CONFIG_DMI) && defined(CONFIG_X86)
+	{
+		.ident = "GPD P2 Max",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "GPD"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "P2 MAX")
+		},
+		.driver_data = &gpio_mapping_force_irq_active_high
+	},
+#endif
+	{}
+};
+
 /**
  * goodix_i2c_read - read data from a register of the i2c slave device.
  *
@@ -795,6 +820,12 @@ static int goodix_ts_probe(struct i2c_client *client,
 {
 	struct goodix_ts_data *ts;
 	int error;
+	struct dmi_system_id *dmi_match;
+
+	dmi_match = dmi_first_match(need_gpio_mapping);
+	if (dmi_match)
+		devm_acpi_dev_add_driver_gpios(&client->dev,
+					       dmi_match->driver_data);
 
 	dev_dbg(&client->dev, "I2C Address: 0x%02x\n", client->addr);
 
-- 
2.23.0

