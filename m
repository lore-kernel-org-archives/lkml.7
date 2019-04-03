Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E31B9C10F06
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 12:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A547B20663
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 12:50:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbfDCMuB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 08:50:01 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45246 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfDCMuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 08:50:00 -0400
Received: by mail-lf1-f66.google.com with SMTP id 5so11590244lft.12;
        Wed, 03 Apr 2019 05:49:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iXInLSGQnXbRPiAe9BYNXQa/YkBRfwPpncSIjWztGbQ=;
        b=pCZsxX8sdXobYQ2Xsz7zGGQK9aNHO2zcUN5rGVVNi3EnckYN9z5SmwhMp9OhXfHW8f
         hcNMUPZ4biAC1GIRkDY/ZY9OGzVvQ6BGvFmOY0r0OGAHLOlPw3cyHUSqRkx2gsCenQS4
         Rk7cvFm2jmoMWx8WGC89LlhFswQa1JvmiccCKO1RhdcRXskEiSqYE7inTeQDG8tHAMWJ
         MP3HZwshDyB8PC9mM90OaKv8X6EuhARex2FD/rR+GWRP1WMf6OCjGBcXRbWOV6c446dM
         +gGpbpyclQ4HilChddLDPAcy6B6qB2Hvay0Xb3EtiVY5V6N/ffSvGriOn+GJWr17JqQ1
         frNg==
X-Gm-Message-State: APjAAAUznnXrGVriRmFWWkC44Qx/dn8X4rFqkwFzlnW+fyBZ4kraF2O1
        Es5Q4AcWyIYeB99C5pLPRCc=
X-Google-Smtp-Source: APXvYqxE2/qmIaNwciUGl7VW1WAZy0ducuIxwHC4FWCUf5VeMU3c/EQV7x/Hy3+8ijPQypt2xn1Qdg==
X-Received: by 2002:a19:a401:: with SMTP id q1mr14699495lfc.40.1554295796656;
        Wed, 03 Apr 2019 05:49:56 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 15sm2975318lft.88.2019.04.03.05.49.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 05:49:56 -0700 (PDT)
Date:   Wed, 3 Apr 2019 15:49:46 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        mazziesaccount@gmail.com
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org,
        heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com
Subject: [PATCH v12 8/8] watchdog: bd70528: Initial support for ROHM BD70528
 watchdog block
Message-ID: <c196907c59025477ca705e1d402d72133ae94b06.1554294791.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1554294791.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1554294791.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initial support for watchdog block included in ROHM BD70528
power management IC.

Configurations for low power states are still to be checked.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Acked-by: Guenter Roeck <linux@roeck-us.net>
---
Changelog v12
- No functional changes
- Small styling fixes

 drivers/watchdog/Kconfig       |  12 +++
 drivers/watchdog/Makefile      |   1 +
 drivers/watchdog/bd70528_wdt.c | 188 +++++++++++++++++++++++++++++++++
 3 files changed, 201 insertions(+)
 create mode 100644 drivers/watchdog/bd70528_wdt.c

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 242eea859637..a00bf649d7f0 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -90,6 +90,18 @@ config SOFT_WATCHDOG_PRETIMEOUT
 	  watchdog. Be aware that governors might affect the watchdog because it
 	  is purely software, e.g. the panic governor will stall it!
 
+config BD70528_WATCHDOG
+	tristate "ROHM BD70528 PMIC Watchdog"
+	depends on MFD_ROHM_BD70528
+	select WATCHDOG_CORE
+	help
+	  Support for the watchdog in the ROHM BD70528 PMIC. Watchdog trigger
+	  cause system reset.
+
+	  Say Y here to include support for the ROHM BD70528 watchdog.
+	  Alternatively say M to compile the driver as a module,
+	  which will be called bd70528_wdt.
+
 config DA9052_WATCHDOG
 	tristate "Dialog DA9052 Watchdog"
 	depends on PMIC_DA9052 || COMPILE_TEST
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index ba930e464657..3985922c440a 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -205,6 +205,7 @@ obj-$(CONFIG_WATCHDOG_SUN4V)		+= sun4v_wdt.o
 obj-$(CONFIG_XEN_WDT) += xen_wdt.o
 
 # Architecture Independent
+obj-$(CONFIG_BD70528_WATCHDOG) += bd70528_wdt.o
 obj-$(CONFIG_DA9052_WATCHDOG) += da9052_wdt.o
 obj-$(CONFIG_DA9055_WATCHDOG) += da9055_wdt.o
 obj-$(CONFIG_DA9062_WATCHDOG) += da9062_wdt.o
diff --git a/drivers/watchdog/bd70528_wdt.c b/drivers/watchdog/bd70528_wdt.c
new file mode 100644
index 000000000000..88c60f8f5367
--- /dev/null
+++ b/drivers/watchdog/bd70528_wdt.c
@@ -0,0 +1,188 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 ROHM Semiconductors
+// ROHM BD70528MWV watchdog driver
+
+#include <linux/bcd.h>
+#include <linux/kernel.h>
+#include <linux/mfd/rohm-bd70528.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/watchdog.h>
+
+/*
+ * Max time we can set is 1 hour, 59 minutes and 59 seconds
+ * and Minimum time is 1 second
+ */
+#define WDT_MAX_MS	((2 * 60 * 60 - 1) * 1000)
+#define WDT_MIN_MS	1000
+#define DEFAULT_TIMEOUT	60
+
+struct wdtbd70528 {
+	struct device *dev;
+	struct regmap *regmap;
+	struct rohm_regmap_dev *mfd;
+	struct watchdog_device wdt;
+};
+
+static int bd70528_wdt_set_locked(struct wdtbd70528 *w, int enable)
+{
+	return bd70528_wdt_set(w->mfd, enable, NULL);
+}
+
+static int bd70528_wdt_change(struct wdtbd70528 *w, int enable)
+{
+	int ret;
+
+	bd70528_wdt_lock(w->mfd);
+	ret = bd70528_wdt_set_locked(w, enable);
+	bd70528_wdt_unlock(w->mfd);
+
+	return ret;
+}
+
+static int bd70528_wdt_start(struct watchdog_device *wdt)
+{
+	struct wdtbd70528 *w = watchdog_get_drvdata(wdt);
+
+	dev_dbg(w->dev, "WDT ping...\n");
+	return bd70528_wdt_change(w, 1);
+}
+
+static int bd70528_wdt_stop(struct watchdog_device *wdt)
+{
+	struct wdtbd70528 *w = watchdog_get_drvdata(wdt);
+
+	dev_dbg(w->dev, "WDT stopping...\n");
+	return bd70528_wdt_change(w, 0);
+}
+
+static int bd70528_wdt_set_timeout(struct watchdog_device *wdt,
+				   unsigned int timeout)
+{
+	unsigned int hours;
+	unsigned int minutes;
+	unsigned int seconds;
+	int ret;
+	struct wdtbd70528 *w = watchdog_get_drvdata(wdt);
+
+	seconds = timeout;
+	hours = timeout / (60 * 60);
+	/* Maximum timeout is 1h 59m 59s => hours is 1 or 0 */
+	if (hours)
+		seconds -= (60 * 60);
+	minutes = seconds / 60;
+	seconds = seconds % 60;
+
+	bd70528_wdt_lock(w->mfd);
+
+	ret = bd70528_wdt_set_locked(w, 0);
+	if (ret)
+		goto out_unlock;
+
+	ret = regmap_update_bits(w->regmap, BD70528_REG_WDT_HOUR,
+				 BD70528_MASK_WDT_HOUR, hours);
+	if (ret) {
+		dev_err(w->dev, "Failed to set WDT hours\n");
+		goto out_en_unlock;
+	}
+	ret = regmap_update_bits(w->regmap, BD70528_REG_WDT_MINUTE,
+				 BD70528_MASK_WDT_MINUTE, bin2bcd(minutes));
+	if (ret) {
+		dev_err(w->dev, "Failed to set WDT minutes\n");
+		goto out_en_unlock;
+	}
+	ret = regmap_update_bits(w->regmap, BD70528_REG_WDT_SEC,
+				 BD70528_MASK_WDT_SEC, bin2bcd(seconds));
+	if (ret)
+		dev_err(w->dev, "Failed to set WDT seconds\n");
+	else
+		dev_dbg(w->dev, "WDT tmo set to %u\n", timeout);
+
+out_en_unlock:
+	ret = bd70528_wdt_set_locked(w, 1);
+out_unlock:
+	bd70528_wdt_unlock(w->mfd);
+
+	return ret;
+}
+
+static const struct watchdog_info bd70528_wdt_info = {
+	.identity = "bd70528-wdt",
+	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
+};
+
+static const struct watchdog_ops bd70528_wdt_ops = {
+	.start		= bd70528_wdt_start,
+	.stop		= bd70528_wdt_stop,
+	.set_timeout	= bd70528_wdt_set_timeout,
+};
+
+static int bd70528_wdt_probe(struct platform_device *pdev)
+{
+	struct rohm_regmap_dev *bd70528;
+	struct wdtbd70528 *w;
+	int ret;
+	unsigned int reg;
+
+	bd70528 = dev_get_drvdata(pdev->dev.parent);
+	if (!bd70528) {
+		dev_err(&pdev->dev, "No MFD driver data\n");
+		return -EINVAL;
+	}
+	w = devm_kzalloc(&pdev->dev, sizeof(*w), GFP_KERNEL);
+	if (!w)
+		return -ENOMEM;
+
+	w->regmap = bd70528->regmap;
+	w->mfd = bd70528;
+	w->dev = &pdev->dev;
+
+	w->wdt.info = &bd70528_wdt_info;
+	w->wdt.ops =  &bd70528_wdt_ops;
+	w->wdt.min_hw_heartbeat_ms = WDT_MIN_MS;
+	w->wdt.max_hw_heartbeat_ms = WDT_MAX_MS;
+	w->wdt.parent = pdev->dev.parent;
+	w->wdt.timeout = DEFAULT_TIMEOUT;
+	watchdog_set_drvdata(&w->wdt, w);
+	watchdog_init_timeout(&w->wdt, 0, pdev->dev.parent);
+
+	ret = bd70528_wdt_set_timeout(&w->wdt, w->wdt.timeout);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to set the watchdog timeout\n");
+		return ret;
+	}
+
+	bd70528_wdt_lock(w->mfd);
+	ret = regmap_read(w->regmap, BD70528_REG_WDT_CTRL, &reg);
+	bd70528_wdt_unlock(w->mfd);
+
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to get the watchdog state\n");
+		return ret;
+	}
+	if (reg & BD70528_MASK_WDT_EN) {
+		dev_dbg(&pdev->dev, "watchdog was running during probe\n");
+		set_bit(WDOG_HW_RUNNING, &w->wdt.status);
+	}
+
+	ret = devm_watchdog_register_device(&pdev->dev, &w->wdt);
+	if (ret < 0)
+		dev_err(&pdev->dev, "watchdog registration failed: %d\n", ret);
+
+	return ret;
+}
+
+static struct platform_driver bd70528_wdt = {
+	.driver = {
+		.name = "bd70528-wdt"
+	},
+	.probe = bd70528_wdt_probe,
+};
+
+module_platform_driver(bd70528_wdt);
+
+MODULE_AUTHOR("Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>");
+MODULE_DESCRIPTION("BD70528 watchdog driver");
+MODULE_LICENSE("GPL");
-- 
2.17.2


-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
