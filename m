Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5088AC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 15:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EACD2070E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 15:46:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CNEfZPSc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732482AbfKTPqA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 10:46:00 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38618 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732466AbfKTPpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 10:45:55 -0500
Received: by mail-pf1-f195.google.com with SMTP id c13so14411630pfp.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 07:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=v3CJPtWLFIAdj/z5fwUlZLLT5DwATGfWb2hJrMtJGHc=;
        b=CNEfZPSc00pRWoq84G/7TVzpTaMRm4f05LM6FCV1VOsDJFHTamkVpCGFoDhuONbHLF
         fGQ3QFgk9JrPR5QovNQuEOktGYhLYyTUE7QqhttLNJJdgBfd6K9y7RNy2qQC6NTZ6nRK
         GyGT0usaaxjppXXdsYbHxQFzFo9OPWes7B+dx92L2sMB9Vhg1yAPcqyE9s6iUHHmbKYK
         aklatOW98Mb6E08K/ThSluXkneUIGi6JY2HhTal3fJc3GrEpmH7Lik/cfIOPa3HokwwS
         lfBHdgSAEUCuwhZWoNPvdJewIftJz5en5zEsLR1GM8W1VyVpFp5cK9/DVMtFBlsySZ/7
         dKgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=v3CJPtWLFIAdj/z5fwUlZLLT5DwATGfWb2hJrMtJGHc=;
        b=qkDUJ3xkZ0m7+tRYpfA4UA7mJH1NRQn6C9vUQQNHlToxFhva7F8Vwuq4PVgkwX2J5U
         GhXwEFiQbNnpgYSRHFPQLXElvPYwco9tq6SpJAK2xZ1uOWEcJ7BiPWubCnGz88qrxhfW
         j1yUkTup82pSAZR1jkiNtSreLV3BzYajGSmIhnBmqnMAuS7P3neo37ruDOE6MfT1pNNh
         h3eRNjRtu7CEXRX0KUki/rfmQzNBcVVR6/utRu2MVbz00mG0w28k37cYGctyAh4W8DG/
         5XOdZtLwEVeGokXZib6i4cVYNYTDOHT7mb9J3qHiETllYZF8vyo5SoIgGzv5OWwHXxbU
         uvaA==
X-Gm-Message-State: APjAAAV6t+7CIG+AILL62yX4QtpiMogR1+xfIzJqgmxNoSVePEa42slo
        GNMMTqV0SyWgbRPLKM0GEXpayTOXpo+u3Q==
X-Google-Smtp-Source: APXvYqxTZ7gTIsjV9nk438TlBRqYyZMMBLSDJ7P/pE/AYAB1y/QGOt8ZB8aniHR4LsuEnlOE8F3Ukg==
X-Received: by 2002:a63:a804:: with SMTP id o4mr3735957pgf.401.1574264753964;
        Wed, 20 Nov 2019 07:45:53 -0800 (PST)
Received: from localhost ([14.96.110.98])
        by smtp.gmail.com with ESMTPSA id 67sm7938816pjz.27.2019.11.20.07.45.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Nov 2019 07:45:53 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, edubezval@gmail.com,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Guillaume La Roque <glaroque@baylibre.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Javi Merino <javi.merino@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jun Nie <jun.nie@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH v2 07/11] thermal: rockchip: Appease the kernel-doc deity
Date:   Wed, 20 Nov 2019 21:15:16 +0530
Message-Id: <c3cbdb0619fec602668ba7ae703ba49d67e30b33.1574242756.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1574242756.git.amit.kucheria@linaro.org>
References: <cover.1574242756.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1574242756.git.amit.kucheria@linaro.org>
References: <cover.1574242756.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace a comment starting with /** by simply /* to avoid having it
interpreted as a kernel-doc comment. Describe missing function
parameters where needed.

Fixes up the following warnings when compiled with make W=1:

linux.git/drivers/thermal/rockchip_thermal.c:27: warning: cannot
understand function prototype: 'enum tshut_mode '
linux.git/drivers/thermal/rockchip_thermal.c:37: warning: cannot
understand function prototype: 'enum tshut_polarity '
linux.git/drivers/thermal/rockchip_thermal.c:46: warning: cannot
understand function prototype: 'enum sensor_id '
linux.git/drivers/thermal/rockchip_thermal.c:56: warning: cannot
understand function prototype: 'enum adc_sort_mode '
linux.git/drivers/thermal/rockchip_thermal.c:123: warning: Function
parameter or member 'chn_id' not described in 'rockchip_tsadc_chip'
linux.git/drivers/thermal/rockchip_thermal.c:123: warning: Function
parameter or member 'control' not described in 'rockchip_tsadc_chip'
linux.git/drivers/thermal/rockchip_thermal.c:167: warning: Function
parameter or member 'sensors' not described in 'rockchip_thermal_data'
linux.git/drivers/thermal/rockchip_thermal.c:608: warning: Function
parameter or member 'grf' not described in 'rk_tsadcv2_initialize'
linux.git/drivers/thermal/rockchip_thermal.c:608: warning: Function
parameter or member 'regs' not described in 'rk_tsadcv2_initialize'
linux.git/drivers/thermal/rockchip_thermal.c:608: warning: Function
parameter or member 'tshut_polarity' not described in
'rk_tsadcv2_initialize'
linux.git/drivers/thermal/rockchip_thermal.c:644: warning: Function
parameter or member 'grf' not described in 'rk_tsadcv3_initialize'
linux.git/drivers/thermal/rockchip_thermal.c:644: warning: Function
parameter or member 'regs' not described in 'rk_tsadcv3_initialize'
linux.git/drivers/thermal/rockchip_thermal.c:644: warning: Function
parameter or member 'tshut_polarity' not described in
'rk_tsadcv3_initialize'
linux.git/drivers/thermal/rockchip_thermal.c:732: warning: Function
parameter or member 'regs' not described in 'rk_tsadcv3_control'
linux.git/drivers/thermal/rockchip_thermal.c:732: warning: Function
parameter or member 'enable' not described in 'rk_tsadcv3_control'
linux.git/drivers/thermal/rockchip_thermal.c:1211: warning: Function
parameter or member 'reset' not described in
'rockchip_thermal_reset_controller'

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/thermal/rockchip_thermal.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index 343c2f5c5a25..9ed8085bb792 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -19,7 +19,7 @@
 #include <linux/mfd/syscon.h>
 #include <linux/pinctrl/consumer.h>
 
-/**
+/*
  * If the temperature over a period of time High,
  * the resulting TSHUT gave CRU module,let it reset the entire chip,
  * or via GPIO give PMIC.
@@ -29,7 +29,7 @@ enum tshut_mode {
 	TSHUT_MODE_GPIO,
 };
 
-/**
+/*
  * The system Temperature Sensors tshut(tshut) polarity
  * the bit 8 is tshut polarity.
  * 0: low active, 1: high active
@@ -39,7 +39,7 @@ enum tshut_polarity {
 	TSHUT_HIGH_ACTIVE,
 };
 
-/**
+/*
  * The system has two Temperature Sensors.
  * sensor0 is for CPU, and sensor1 is for GPU.
  */
@@ -48,7 +48,7 @@ enum sensor_id {
 	SENSOR_GPU,
 };
 
-/**
+/*
  * The conversion table has the adc value and temperature.
  * ADC_DECREMENT: the adc value is of diminishing.(e.g. rk3288_code_table)
  * ADC_INCREMENT: the adc value is incremental.(e.g. rk3368_code_table)
@@ -80,13 +80,14 @@ struct chip_tsadc_table {
 
 /**
  * struct rockchip_tsadc_chip - hold the private data of tsadc chip
- * @chn_id[SOC_MAX_SENSORS]: the sensor id of chip correspond to the channel
+ * @chn_id: array of sensor ids of chip corresponding to the channel
  * @chn_num: the channel number of tsadc chip
  * @tshut_temp: the hardware-controlled shutdown temperature value
  * @tshut_mode: the hardware-controlled shutdown mode (0:CRU 1:GPIO)
  * @tshut_polarity: the hardware-controlled active polarity (0:LOW 1:HIGH)
  * @initialize: SoC special initialize tsadc controller method
  * @irq_ack: clear the interrupt
+ * @control: enable/disable method for the tsadc controller
  * @get_temp: get the temperature
  * @set_alarm_temp: set the high temperature interrupt
  * @set_tshut_temp: set the hardware-controlled shutdown temperature
@@ -139,7 +140,7 @@ struct rockchip_thermal_sensor {
  * @chip: pointer to the platform/configuration data
  * @pdev: platform device of thermal
  * @reset: the reset controller of tsadc
- * @sensors[SOC_MAX_SENSORS]: the thermal sensor
+ * @sensors: array of thermal sensors
  * @clk: the controller clock is divided by the exteral 24MHz
  * @pclk: the advanced peripherals bus clock
  * @grf: the general register file will be used to do static set by software
@@ -590,6 +591,9 @@ static int rk_tsadcv2_code_to_temp(const struct chip_tsadc_table *table,
 
 /**
  * rk_tsadcv2_initialize - initialize TASDC Controller.
+ * @grf: the general register file will be used to do static set by software
+ * @regs: the base address of tsadc controller
+ * @tshut_polarity: the hardware-controlled active polarity (0:LOW 1:HIGH)
  *
  * (1) Set TSADC_V2_AUTO_PERIOD:
  *     Configure the interleave between every two accessing of
@@ -624,6 +628,9 @@ static void rk_tsadcv2_initialize(struct regmap *grf, void __iomem *regs,
 
 /**
  * rk_tsadcv3_initialize - initialize TASDC Controller.
+ * @grf: the general register file will be used to do static set by software
+ * @regs: the base address of tsadc controller
+ * @tshut_polarity: the hardware-controlled active polarity (0:LOW 1:HIGH)
  *
  * (1) The tsadc control power sequence.
  *
@@ -723,6 +730,8 @@ static void rk_tsadcv2_control(void __iomem *regs, bool enable)
 
 /**
  * rk_tsadcv3_control - the tsadc controller is enabled or disabled.
+ * @regs: the base address of tsadc controller
+ * @enable: boolean flag to enable the controller
  *
  * NOTE: TSADC controller works at auto mode, and some SoCs need set the
  * tsadc_q_sel bit on TSADCV2_AUTO_CON[1]. The (1024 - tsadc_q) as output
@@ -1206,6 +1215,7 @@ rockchip_thermal_register_sensor(struct platform_device *pdev,
 
 /**
  * Reset TSADC Controller, reset all tsadc registers.
+ * @reset: the reset controller of tsadc
  */
 static void rockchip_thermal_reset_controller(struct reset_control *reset)
 {
-- 
2.20.1

