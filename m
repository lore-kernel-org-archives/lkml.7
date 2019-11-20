Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1CB0C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 15:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78C512070E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 15:45:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E3AnSLk8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732467AbfKTPpz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 10:45:55 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34451 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731113AbfKTPpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 10:45:52 -0500
Received: by mail-pg1-f194.google.com with SMTP id z188so13525609pgb.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 07:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=e/+C0/U/7T8ETxCupoulTe1zya9/ISeKYAztNAzb164=;
        b=E3AnSLk8a93bsgWxr4fcB/GPFvJ4Rxo5soxyRn5bqg6l49xuRK6YcbzlIUUW+u31d/
         JA22kRY/pMbbK6pIyxFgfeLHI+IcM3+2nwmI0qvXJDZabbmDuqUiVLRhLr/SlgQh51oV
         UsRDODil4tFnA/SKcLzQnQ+fH8TLmKtJQuaXjNyammLFz8sJfJUN/4NBihEftSt/l1LP
         x+sqw0txJaK5+awwGSe60/jM8OFzrCCRY2WBzh7ui94S3wFWodQ+jtN2oCBeDML5mYft
         gGYXdwx2NpSBdm09KeHKgUEzj1qYlvdnhYlD26aXvxQF6VchwF5Zd1bpM9qETPcn/vAF
         N3Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=e/+C0/U/7T8ETxCupoulTe1zya9/ISeKYAztNAzb164=;
        b=kK1X49wlGj1V4p+mIGFHIVBRidxGTljinuD2droNL4WlJmz4u3apcbYljJI4S1proo
         Y2u/NbIHN0KT2WrBNbUp+YylqSQ0dN+0UaXC5tV4Oy8mluq5eTHUbvRFJPYtCeJk8B5r
         3z5eJuX0/SFAWTi4wm0KiQWm3O7H3EpEXvdxbhKg1EG/D4UaoNKCYXGMjuyG5xdJE0VI
         a4euAB68I39wtTtTtmIOUcNurI9ErLpZOrVL8STNjmEyW9rA0JgFzrLvg9GTrcmPUORW
         yregpTfS6eDRT8Z2h9sKFy0SxkYHvOkc1CqAmrkLm/ZFuOS1LSE5EWv2VTZP0lC15cNc
         p6/g==
X-Gm-Message-State: APjAAAUEVDG9sfU5npKG0jsQK46AArknCXSN7NWI9X/OFBWoVHNyRwq2
        uQCpT2sBO6FEfT13bsD/Y1LTxzVXFjq8nA==
X-Google-Smtp-Source: APXvYqzj7lopeOEFvFadHOn4FAisXgAAfQF8EcvPp5oAfbvhy/8a9sOXfobTdg947a+fRpG3+UQUCw==
X-Received: by 2002:a63:d20f:: with SMTP id a15mr4164989pgg.268.1574264750264;
        Wed, 20 Nov 2019 07:45:50 -0800 (PST)
Received: from localhost ([14.96.110.98])
        by smtp.gmail.com with ESMTPSA id u20sm30558372pgo.50.2019.11.20.07.45.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Nov 2019 07:45:49 -0800 (PST)
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
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2 06/11] thermal: mediatek: Appease the kernel-doc deity
Date:   Wed, 20 Nov 2019 21:15:15 +0530
Message-Id: <ba10b886705879fd1b7d529fec50503d6696df20.1574242756.git.amit.kucheria@linaro.org>
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

linux.git/drivers/thermal/mtk_thermal.c:374: warning: cannot understand
function prototype: 'const struct mtk_thermal_data mt8173_thermal_data =
'
linux.git/drivers/thermal/mtk_thermal.c:413: warning: cannot understand
function prototype: 'const struct mtk_thermal_data mt2701_thermal_data =
'
linux.git/drivers/thermal/mtk_thermal.c:443: warning: cannot understand
function prototype: 'const struct mtk_thermal_data mt2712_thermal_data =
'
linux.git/drivers/thermal/mtk_thermal.c:499: warning: cannot understand
function prototype: 'const struct mtk_thermal_data mt8183_thermal_data =
'
linux.git/drivers/thermal/mtk_thermal.c:529: warning: Function parameter
or member 'sensno' not described in 'raw_to_mcelsius'

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/thermal/mtk_thermal.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
index acf4854cbb8b..76e30603d4d5 100644
--- a/drivers/thermal/mtk_thermal.c
+++ b/drivers/thermal/mtk_thermal.c
@@ -358,7 +358,7 @@ static const int mt7622_mux_values[MT7622_NUM_SENSORS] = { 0, };
 static const int mt7622_vts_index[MT7622_NUM_SENSORS] = { VTS1 };
 static const int mt7622_tc_offset[MT7622_NUM_CONTROLLER] = { 0x0, };
 
-/**
+/*
  * The MT8173 thermal controller has four banks. Each bank can read up to
  * four temperature sensors simultaneously. The MT8173 has a total of 5
  * temperature sensors. We use each bank to measure a certain area of the
@@ -400,7 +400,7 @@ static const struct mtk_thermal_data mt8173_thermal_data = {
 	.sensor_mux_values = mt8173_mux_values,
 };
 
-/**
+/*
  * The MT2701 thermal controller has one bank, which can read up to
  * three temperature sensors simultaneously. The MT2701 has a total of 3
  * temperature sensors.
@@ -430,7 +430,7 @@ static const struct mtk_thermal_data mt2701_thermal_data = {
 	.sensor_mux_values = mt2701_mux_values,
 };
 
-/**
+/*
  * The MT2712 thermal controller has one bank, which can read up to
  * four temperature sensors simultaneously. The MT2712 has a total of 4
  * temperature sensors.
@@ -484,7 +484,7 @@ static const struct mtk_thermal_data mt7622_thermal_data = {
 	.sensor_mux_values = mt7622_mux_values,
 };
 
-/**
+/*
  * The MT8183 thermal controller has one bank for the current SW framework.
  * The MT8183 has a total of 6 temperature sensors.
  * There are two thermal controller to control the six sensor.
@@ -495,7 +495,6 @@ static const struct mtk_thermal_data mt7622_thermal_data = {
  * data, and this indeed needs the temperatures of the individual banks
  * for making better decisions.
  */
-
 static const struct mtk_thermal_data mt8183_thermal_data = {
 	.auxadc_channel = MT8183_TEMP_AUXADC_CHANNEL,
 	.num_banks = MT8183_NUM_SENSORS_PER_ZONE,
@@ -519,7 +518,8 @@ static const struct mtk_thermal_data mt8183_thermal_data = {
 
 /**
  * raw_to_mcelsius - convert a raw ADC value to mcelsius
- * @mt:		The thermal controller
+ * @mt:	The thermal controller
+ * @sensno:	sensor number
  * @raw:	raw ADC value
  *
  * This converts the raw ADC value to mcelsius using the SoC specific
-- 
2.20.1

