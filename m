Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41DEBC10F06
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 12:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 097982147C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 12:48:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbfDCMsO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 08:48:14 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46999 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfDCMsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 08:48:13 -0400
Received: by mail-lj1-f195.google.com with SMTP id h21so14691367ljk.13;
        Wed, 03 Apr 2019 05:48:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zc8iIrinwDaE/iD69MnJKN0+/krVQcwHpE15TDqWuns=;
        b=TcQW3QU0wpT/Uqxt6ld/WldxR/1XsXt5aNsrDKqKRcHibheXzZE1IwqNOQMiRP5UnN
         82eZtHxoJjIMCSsiDQ6B0plgM58xfoDuW4y61opaSq+Dz38/fC98YbiebOUm2i+knV98
         BfhkmibI3mWQWnb/qTrAvNYYKfcdRhj692rfqvxXovPn8sbD2Go1JxM/+S5vZYTzpbZ6
         l6c6Z8yCAs7PbI1sh90oBvP4JwiotXKF3iqZAlkn7fjKmUpu8ZhD+AtSRb6WR3D54CL2
         Azkvd/L13aU820IHmTxT4e1xXxj2cpxfUxwX4sTAG3DXUwFgCptDeZsN2bvvzb6e5bPF
         M9Eg==
X-Gm-Message-State: APjAAAW2Buf4T7YN8dqB1VTLMtzcUlW47hzNbLdtPkn6FqYDtT9Q5y4l
        P0Y0g1CHH7gUAHsgvcIfWac=
X-Google-Smtp-Source: APXvYqwUh9ahXb2/V4iGSyJ9yHwO6URhSC6a6ixqsBu33ko9S4OaJMTO6dTximhjBeu5fD5BRLz8HA==
X-Received: by 2002:a2e:5b5c:: with SMTP id p89mr41720313ljb.177.1554295689390;
        Wed, 03 Apr 2019 05:48:09 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 15sm2974667lft.88.2019.04.03.05.48.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 05:48:08 -0700 (PDT)
Date:   Wed, 3 Apr 2019 15:48:01 +0300
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
Subject: [PATCH v12 6/8] rtc: bd70528: Initial support for ROHM bd70528 RTC
Message-ID: <ca4bad6d146cd94cbc6bd4213c80592262792d63.1554294791.git.matti.vaittinen@fi.rohmeurope.com>
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

Support RTC block in ROHM bd70528 power management IC. Support
getting and setting the time and date as well as arming an alarm
which can also be used to wake the PMIC from standby state.

HW supports wake interrupt only for the next 24 hours (sec, minute
and hour information only) so we limit also the alarm interrupt to
this 24 hours for the sake of consistency.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
Changelog v12:
- No functional changes
- Few styling fixes

 drivers/rtc/Kconfig       |   8 +
 drivers/rtc/Makefile      |   1 +
 drivers/rtc/rtc-bd70528.c | 500 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 509 insertions(+)
 create mode 100644 drivers/rtc/rtc-bd70528.c

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index a71734c41693..7976c8a96be4 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -497,6 +497,14 @@ config RTC_DRV_M41T80_WDT
 	help
 	  If you say Y here you will get support for the
 	  watchdog timer in the ST M41T60 and M41T80 RTC chips series.
+config RTC_DRV_BD70528
+	tristate "ROHM BD70528 PMIC RTC"
+	help
+	  If you say Y here you will get support for the RTC
+	  on ROHM BD70528 Power Management IC.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called rtc-bd70528.
 
 config RTC_DRV_BQ32K
 	tristate "TI BQ32000"
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index fe3962496685..59a8e606c071 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -37,6 +37,7 @@ obj-$(CONFIG_RTC_DRV_ASM9260)	+= rtc-asm9260.o
 obj-$(CONFIG_RTC_DRV_AT91RM9200)+= rtc-at91rm9200.o
 obj-$(CONFIG_RTC_DRV_AT91SAM9)	+= rtc-at91sam9.o
 obj-$(CONFIG_RTC_DRV_AU1XXX)	+= rtc-au1xxx.o
+obj-$(CONFIG_RTC_DRV_BD70528)	+= rtc-bd70528.o
 obj-$(CONFIG_RTC_DRV_BQ32K)	+= rtc-bq32k.o
 obj-$(CONFIG_RTC_DRV_BQ4802)	+= rtc-bq4802.o
 obj-$(CONFIG_RTC_DRV_BRCMSTB)	+= rtc-brcmstb-waketimer.o
diff --git a/drivers/rtc/rtc-bd70528.c b/drivers/rtc/rtc-bd70528.c
new file mode 100644
index 000000000000..f9bdd555e1a2
--- /dev/null
+++ b/drivers/rtc/rtc-bd70528.c
@@ -0,0 +1,500 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+//
+// Copyright (C) 2018 ROHM Semiconductors
+//
+// RTC driver for ROHM BD70528 PMIC
+
+#include <linux/bcd.h>
+#include <linux/mfd/rohm-bd70528.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/rtc.h>
+
+/*
+ * We read regs RTC_SEC => RTC_YEAR
+ * this struct is ordered according to chip registers.
+ * Keep it u8 only to avoid padding issues.
+ */
+struct bd70528_rtc_day {
+	u8 sec;
+	u8 min;
+	u8 hour;
+} __packed;
+
+struct bd70528_rtc_data {
+	struct bd70528_rtc_day time;
+	u8 week;
+	u8 day;
+	u8 month;
+	u8 year;
+} __packed;
+
+struct bd70528_rtc_wake {
+	struct bd70528_rtc_day time;
+	u8 ctrl;
+} __packed;
+
+struct bd70528_rtc_alm {
+	struct bd70528_rtc_data data;
+	u8 alm_mask;
+	u8 alm_repeat;
+} __packed;
+
+struct bd70528_rtc {
+	struct rohm_regmap_dev *mfd;
+	struct device *dev;
+};
+
+static int bd70528_set_wake(struct rohm_regmap_dev *bd70528,
+			    int enable, int *old_state)
+{
+	int ret;
+	unsigned int ctrl_reg;
+
+	ret = regmap_read(bd70528->regmap, BD70528_REG_WAKE_EN, &ctrl_reg);
+	if (ret)
+		return ret;
+
+	if (old_state) {
+		if (ctrl_reg & BD70528_MASK_WAKE_EN)
+			*old_state |= BD70528_WAKE_STATE_BIT;
+		else
+			*old_state &= ~BD70528_WAKE_STATE_BIT;
+
+		if (!enable == !(*old_state & BD70528_WAKE_STATE_BIT))
+			return 0;
+	}
+
+	if (enable)
+		ctrl_reg |= BD70528_MASK_WAKE_EN;
+	else
+		ctrl_reg &= ~BD70528_MASK_WAKE_EN;
+
+	return regmap_write(bd70528->regmap, BD70528_REG_WAKE_EN,
+			    ctrl_reg);
+}
+
+static int bd70528_set_elapsed_tmr(struct rohm_regmap_dev *bd70528,
+				   int enable, int *old_state)
+{
+	int ret;
+	unsigned int ctrl_reg;
+
+	/*
+	 * TBD
+	 * What is the purpose of elapsed timer ?
+	 * Is the timeout registers counting down, or is the disable - re-enable
+	 * going to restart the elapsed-time counting? If counting is restarted
+	 * the timeout should be decreased by the amount of time that has
+	 * elapsed since starting the timer. Maybe we should store the monotonic
+	 * clock value when timer is started so that if RTC is set while timer
+	 * is armed we could do the compensation. This is a hack if RTC/system
+	 * clk are drifting. OTOH, RTC controlled via I2C is in any case
+	 * inaccurate...
+	 */
+	ret = regmap_read(bd70528->regmap, BD70528_REG_ELAPSED_TIMER_EN,
+			  &ctrl_reg);
+	if (ret)
+		return ret;
+
+	if (old_state) {
+		if (ctrl_reg & BD70528_MASK_ELAPSED_TIMER_EN)
+			*old_state |= BD70528_ELAPSED_STATE_BIT;
+		else
+			*old_state &= ~BD70528_ELAPSED_STATE_BIT;
+
+		if ((!enable) == (!(*old_state & BD70528_ELAPSED_STATE_BIT)))
+			return 0;
+	}
+
+	if (enable)
+		ctrl_reg |= BD70528_MASK_ELAPSED_TIMER_EN;
+	else
+		ctrl_reg &= ~BD70528_MASK_ELAPSED_TIMER_EN;
+
+	return regmap_write(bd70528->regmap, BD70528_REG_ELAPSED_TIMER_EN,
+			    ctrl_reg);
+}
+
+static int bd70528_set_rtc_based_timers(struct bd70528_rtc *r, int new_state,
+					int *old_state)
+{
+	int ret;
+
+	ret = bd70528_wdt_set(r->mfd, new_state & BD70528_WDT_STATE_BIT,
+			      old_state);
+	if (ret) {
+		dev_err(r->dev,
+			"Failed to disable WDG for RTC setting (%d)\n", ret);
+		return ret;
+	}
+	ret = bd70528_set_elapsed_tmr(r->mfd,
+				      new_state & BD70528_ELAPSED_STATE_BIT,
+				      old_state);
+	if (ret) {
+		dev_err(r->dev,
+			"Failed to disable 'elapsed timer' for RTC setting\n");
+		return ret;
+	}
+	ret = bd70528_set_wake(r->mfd, new_state & BD70528_WAKE_STATE_BIT,
+			       old_state);
+	if (ret) {
+		dev_err(r->dev,
+			"Failed to disable 'wake timer' for RTC setting\n");
+		return ret;
+	}
+
+	return ret;
+}
+
+static int bd70528_re_enable_rtc_based_timers(struct bd70528_rtc *r,
+					      int old_state)
+{
+	return bd70528_set_rtc_based_timers(r, old_state, NULL);
+}
+
+static int bd70528_disable_rtc_based_timers(struct bd70528_rtc *r,
+					    int *old_state)
+{
+	return bd70528_set_rtc_based_timers(r, 0, old_state);
+}
+
+static inline void tmday2rtc(struct rtc_time *t, struct bd70528_rtc_day *d)
+{
+	d->sec &= ~BD70528_MASK_RTC_SEC;
+	d->min &= ~BD70528_MASK_RTC_MINUTE;
+	d->hour &= ~BD70528_MASK_RTC_HOUR;
+	d->sec |= bin2bcd(t->tm_sec);
+	d->min |= bin2bcd(t->tm_min);
+	d->hour |= bin2bcd(t->tm_hour);
+}
+
+static inline void tm2rtc(struct rtc_time *t, struct bd70528_rtc_data *r)
+{
+	r->day &= ~BD70528_MASK_RTC_DAY;
+	r->week &= ~BD70528_MASK_RTC_WEEK;
+	r->month &= ~BD70528_MASK_RTC_MONTH;
+	/*
+	 * PM and 24H bits are not used by Wake - thus we clear them
+	 * here and not in tmday2rtc() which is also used by wake.
+	 */
+	r->time.hour &= ~(BD70528_MASK_RTC_HOUR_PM | BD70528_MASK_RTC_HOUR_24H);
+
+	tmday2rtc(t, &r->time);
+	/*
+	 * We do always set time in 24H mode.
+	 */
+	r->time.hour |= BD70528_MASK_RTC_HOUR_24H;
+	r->day |= bin2bcd(t->tm_mday);
+	r->week |= bin2bcd(t->tm_wday);
+	r->month |= bin2bcd(t->tm_mon + 1);
+	r->year = bin2bcd(t->tm_year - 100);
+}
+
+static inline void rtc2tm(struct bd70528_rtc_data *r, struct rtc_time *t)
+{
+	t->tm_sec = bcd2bin(r->time.sec & BD70528_MASK_RTC_SEC);
+	t->tm_min = bcd2bin(r->time.min & BD70528_MASK_RTC_MINUTE);
+	t->tm_hour = bcd2bin(r->time.hour & BD70528_MASK_RTC_HOUR);
+	/*
+	 * If RTC is in 12H mode, then bit BD70528_MASK_RTC_HOUR_PM
+	 * is not BCD value but tells whether it is AM or PM
+	 */
+	if (!(r->time.hour & BD70528_MASK_RTC_HOUR_24H)) {
+		t->tm_hour %= 12;
+		if (r->time.hour & BD70528_MASK_RTC_HOUR_PM)
+			t->tm_hour += 12;
+	}
+	t->tm_mday = bcd2bin(r->day & BD70528_MASK_RTC_DAY);
+	t->tm_mon = bcd2bin(r->month & BD70528_MASK_RTC_MONTH) - 1;
+	t->tm_year = 100 + bcd2bin(r->year & BD70528_MASK_RTC_YEAR);
+	t->tm_wday = bcd2bin(r->week & BD70528_MASK_RTC_WEEK);
+}
+
+static int bd70528_set_alarm(struct device *dev, struct rtc_wkalrm *a)
+{
+	struct bd70528_rtc_wake wake;
+	struct bd70528_rtc_alm alm;
+	int ret;
+	struct bd70528_rtc *r = dev_get_drvdata(dev);
+	struct rohm_regmap_dev *bd70528 = r->mfd;
+
+	ret = regmap_bulk_read(bd70528->regmap, BD70528_REG_RTC_WAKE_START,
+			       &wake, sizeof(wake));
+	if (ret) {
+		dev_err(dev, "Failed to read wake regs\n");
+		return ret;
+	}
+
+	ret = regmap_bulk_read(bd70528->regmap, BD70528_REG_RTC_ALM_START,
+			       &alm, sizeof(alm));
+	if (ret) {
+		dev_err(dev, "Failed to read alarm regs\n");
+		return ret;
+	}
+
+	tm2rtc(&a->time, &alm.data);
+	tmday2rtc(&a->time, &wake.time);
+
+	if (a->enabled) {
+		alm.alm_mask &= ~BD70528_MASK_ALM_EN;
+		wake.ctrl |= BD70528_MASK_WAKE_EN;
+	} else {
+		alm.alm_mask |= BD70528_MASK_ALM_EN;
+		wake.ctrl &= ~BD70528_MASK_WAKE_EN;
+	}
+
+	ret = regmap_bulk_write(bd70528->regmap,
+				BD70528_REG_RTC_WAKE_START, &wake,
+				sizeof(wake));
+	if (ret) {
+		dev_err(dev, "Failed to set wake time\n");
+		return ret;
+	}
+	ret = regmap_bulk_write(bd70528->regmap, BD70528_REG_RTC_ALM_START,
+				&alm, sizeof(alm));
+	if (ret)
+		dev_err(dev, "Failed to set alarm time\n");
+
+	return ret;
+}
+
+static int bd70528_read_alarm(struct device *dev, struct rtc_wkalrm *a)
+{
+	struct bd70528_rtc_alm alm;
+	int ret;
+	struct bd70528_rtc *r = dev_get_drvdata(dev);
+	struct rohm_regmap_dev *bd70528 = r->mfd;
+
+	ret = regmap_bulk_read(bd70528->regmap, BD70528_REG_RTC_ALM_START,
+			       &alm, sizeof(alm));
+	if (ret) {
+		dev_err(dev, "Failed to read alarm regs\n");
+		return ret;
+	}
+
+	rtc2tm(&alm.data, &a->time);
+	a->time.tm_mday = -1;
+	a->time.tm_mon = -1;
+	a->time.tm_year = -1;
+	a->enabled = !(alm.alm_mask & BD70528_MASK_ALM_EN);
+	a->pending = 0;
+
+	return 0;
+}
+
+static int bd70528_set_time_locked(struct device *dev, struct rtc_time *t)
+{
+	int ret, tmpret, old_states;
+	struct bd70528_rtc_data rtc_data;
+	struct bd70528_rtc *r = dev_get_drvdata(dev);
+	struct rohm_regmap_dev *bd70528 = r->mfd;
+
+	ret = bd70528_disable_rtc_based_timers(r, &old_states);
+	if (ret)
+		return ret;
+
+	tmpret = regmap_bulk_read(bd70528->regmap,
+				  BD70528_REG_RTC_START, &rtc_data,
+				  sizeof(rtc_data));
+	if (tmpret) {
+		dev_err(dev, "Failed to read RTC time registers\n");
+		goto renable_out;
+	}
+	tm2rtc(t, &rtc_data);
+
+	tmpret = regmap_bulk_write(bd70528->regmap,
+				   BD70528_REG_RTC_START, &rtc_data,
+				   sizeof(rtc_data));
+	if (tmpret) {
+		dev_err(dev, "Failed to set RTC time\n");
+		goto renable_out;
+	}
+
+renable_out:
+	ret = bd70528_re_enable_rtc_based_timers(r, old_states);
+	if (tmpret)
+		ret = tmpret;
+
+	return ret;
+}
+
+static int bd70528_set_time(struct device *dev, struct rtc_time *t)
+{
+	int ret;
+	struct bd70528_rtc *r = dev_get_drvdata(dev);
+
+	bd70528_wdt_lock(r->mfd);
+	ret = bd70528_set_time_locked(dev, t);
+	bd70528_wdt_unlock(r->mfd);
+	return ret;
+}
+
+static int bd70528_get_time(struct device *dev, struct rtc_time *t)
+{
+	struct bd70528_rtc *r = dev_get_drvdata(dev);
+	struct rohm_regmap_dev *bd70528 = r->mfd;
+	struct bd70528_rtc_data rtc_data;
+	int ret;
+
+	/* read the RTC date and time registers all at once */
+	ret = regmap_bulk_read(bd70528->regmap,
+			       BD70528_REG_RTC_START, &rtc_data,
+			       sizeof(rtc_data));
+	if (ret) {
+		dev_err(dev, "Failed to read RTC time (err %d)\n", ret);
+		return ret;
+	}
+
+	rtc2tm(&rtc_data, t);
+
+	return 0;
+}
+
+static int bd70528_alm_enable(struct device *dev, unsigned int enabled)
+{
+	int ret;
+	unsigned int enableval = BD70528_MASK_ALM_EN;
+	struct bd70528_rtc *r = dev_get_drvdata(dev);
+
+	if (enabled)
+		enableval = 0;
+
+	bd70528_wdt_lock(r->mfd);
+	ret = bd70528_set_wake(r->mfd, enabled, NULL);
+	if (ret) {
+		dev_err(dev, "Failed to change wake state\n");
+		goto out_unlock;
+	}
+	ret = regmap_update_bits(r->mfd->regmap, BD70528_REG_RTC_ALM_MASK,
+				 BD70528_MASK_ALM_EN, enableval);
+	if (ret)
+		dev_err(dev, "Failed to change alarm state\n");
+
+out_unlock:
+	bd70528_wdt_unlock(r->mfd);
+	return ret;
+}
+
+static const struct rtc_class_ops bd70528_rtc_ops = {
+	.read_time		= bd70528_get_time,
+	.set_time		= bd70528_set_time,
+	.read_alarm		= bd70528_read_alarm,
+	.set_alarm		= bd70528_set_alarm,
+	.alarm_irq_enable	= bd70528_alm_enable,
+};
+
+static irqreturn_t alm_hndlr(int irq, void *data)
+{
+	struct rtc_device *rtc = data;
+
+	rtc_update_irq(rtc, 1, RTC_IRQF | RTC_AF | RTC_PF);
+	return IRQ_HANDLED;
+}
+
+static int bd70528_probe(struct platform_device *pdev)
+{
+	struct bd70528_rtc *bd_rtc;
+	struct rohm_regmap_dev *mfd;
+	int ret;
+	struct rtc_device *rtc;
+	int irq;
+	unsigned int hr;
+
+	mfd = dev_get_drvdata(pdev->dev.parent);
+	if (!mfd) {
+		dev_err(&pdev->dev, "No MFD driver data\n");
+		return -EINVAL;
+	}
+	bd_rtc = devm_kzalloc(&pdev->dev, sizeof(*bd_rtc), GFP_KERNEL);
+	if (!bd_rtc)
+		return -ENOMEM;
+
+	bd_rtc->mfd = mfd;
+	bd_rtc->dev = &pdev->dev;
+
+	irq = platform_get_irq_byname(pdev, "bd70528-rtc-alm");
+
+	if (irq < 0) {
+		dev_err(&pdev->dev, "Failed to get irq\n");
+		return irq;
+	}
+
+	platform_set_drvdata(pdev, bd_rtc);
+
+	ret = regmap_read(mfd->regmap, BD70528_REG_RTC_HOUR, &hr);
+
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to reag RTC clock\n");
+		return ret;
+	}
+
+	if (!(hr & BD70528_MASK_RTC_HOUR_24H)) {
+		struct rtc_time t;
+
+		ret = bd70528_get_time(&pdev->dev, &t);
+
+		if (!ret)
+			ret = bd70528_set_time(&pdev->dev, &t);
+
+		if (ret) {
+			dev_err(&pdev->dev,
+				"Setting 24H clock for RTC failed\n");
+			return ret;
+		}
+	}
+
+	device_set_wakeup_capable(&pdev->dev, true);
+	device_wakeup_enable(&pdev->dev);
+
+	rtc = devm_rtc_allocate_device(&pdev->dev);
+	if (IS_ERR(rtc)) {
+		dev_err(&pdev->dev, "RTC device creation failed\n");
+		return PTR_ERR(rtc);
+	}
+
+	rtc->range_min = RTC_TIMESTAMP_BEGIN_2000;
+	rtc->range_max = RTC_TIMESTAMP_END_2099;
+	rtc->ops = &bd70528_rtc_ops;
+
+	/* Request alarm IRQ prior to registerig the RTC */
+	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL, &alm_hndlr,
+					IRQF_ONESHOT, "bd70528-rtc", rtc);
+	if (ret)
+		return ret;
+
+	/*
+	 *  BD70528 irq controller is not touching the main mask register.
+	 *  So enable the RTC block interrupts at main level. We can just
+	 *  leave them enabled as irq-controller should disable irqs
+	 *  from sub-registers when IRQ is disabled or freed.
+	 */
+	ret = regmap_update_bits(mfd->regmap,
+				 BD70528_REG_INT_MAIN_MASK,
+				 BD70528_INT_RTC_MASK, 0);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to enable RTC interrupts\n");
+		return ret;
+	}
+
+	ret = rtc_register_device(rtc);
+	if (ret)
+		dev_err(&pdev->dev, "Registering RTC failed\n");
+
+	return ret;
+}
+
+static struct platform_driver bd70528_rtc = {
+	.driver = {
+		.name = "bd70528-rtc"
+	},
+	.probe = bd70528_probe,
+};
+
+module_platform_driver(bd70528_rtc);
+
+MODULE_AUTHOR("Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>");
+MODULE_DESCRIPTION("BD70528 RTC driver");
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
