Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76259C32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 20:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31B8B22509
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 20:44:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="VJQWLFQK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731268AbfI3UoO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 16:44:14 -0400
Received: from mx5.ucr.edu ([138.23.62.67]:55869 "EHLO mx5.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728573AbfI3UoN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 16:44:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1569876253; x=1601412253;
  h=from:to:cc:subject:date:message-id;
  bh=HYGA3/ETQRN0dliOSfTAE61tbuv040Q6WyOvR7/0sbI=;
  b=VJQWLFQK4Mdc2rvHHzHxQfC3ufv4UKvZJzsczkIBF5E9d13abbVNDqXX
   6m7UIxCfTO2Gwo1oGHy0wfwwC0ok/2m0cWFWMKkZC7u0e867gvQyr9Fz+
   d4JOPfTZBl2lGcVHf+6Tf6ZfD6dbMEsUUkBKsCXGY3CdnQNmA8O+l5cPj
   VP54T/UynDr9FpJXbFbULqvLMr/o9SSgABSx0fznVfVrtBHFdbVlxV+7+
   717Lbz0wro5YRNlCG/INtn/arr45TKnUkF+gxZUrz8VdoE3wFZkxlCChX
   +G/nS/6mWnr6dqMOx1nIREJ7+DvU/9W2UAoWjQyveDj6/shQGmh6iUjWl
   w==;
IronPort-SDR: fz/Ps7Wqzmt61e7zf0gVVI814bqYCK747HzNo+uya8MjXHaJjI6UnuUYa58bEwCbNbpoOuf36u
 eSZa8Rt7J6Hzs6BLkz0m+UXJZTxIWnQpYv7/dAihxGgCg6IDeynIz9o4x+OK6ntOdMOFpkQBDi
 +lX1El+XA39m+zYq7yv0V7Bg9m4e/nJj7apRTbjKG+lzjc32VD3VF8nhxKWnykGWynXI2UX7uJ
 YTWHSXbQ6E3AcCN6QNhslSRvr+mbYKKHZFJRfD9E5xPUx5CL45DyaQ5mMy8F2GC4WfTFjP4IBr
 4uM=
IronPort-PHdr: =?us-ascii?q?9a23=3AaRmkahcrqVcz6hWbsposjRHslGMj4u6mDksu8p?=
 =?us-ascii?q?Mizoh2WeGdxcuzYB7h7PlgxGXEQZ/co6odzbaP6Oa8AydZvcnJmUtBWaQEbw?=
 =?us-ascii?q?UCh8QSkl5oK+++Imq/EsTXaTcnFt9JTl5v8iLzG0FUHMHjew+a+SXqvnYdFR?=
 =?us-ascii?q?rlKAV6OPn+FJLMgMSrzeCy/IDYbxlViDanbr5+MRu7oR/eu8UIjoduN6k8xx?=
 =?us-ascii?q?nUqXZUZupawn9lK0iOlBjm/Mew+5Bj8yVUu/0/8sNLTLv3caclQ7FGFToqK2?=
 =?us-ascii?q?866tHluhnFVguP+2ATUn4KnRpSAgjK9w/1U5HsuSbnrOV92S2aPcrrTbAoXD?=
 =?us-ascii?q?mp8qlmRAP0hCoBKjU063/chNBug61HoRKhvx1/zJDSYIGJL/p1Y6fRccoHSW?=
 =?us-ascii?q?ZdQspdUipMAoa9b4sUFOoBPOBYr4bgrFUQtBW1GAesBOLxxT9Mm3D9wKk23u?=
 =?us-ascii?q?o9HQ3D2gErAtAAv2nOrNjtNKkcT/27wqfLwzvEdP5axSvx5ZLUfh07vf2AQb?=
 =?us-ascii?q?R9etfRx0k1EAPFi02dpo7kPzKU1uQNrm+b5PdnWOOvim8nqxt+ojmzysswhI?=
 =?us-ascii?q?TEnZ8VxUze9Slj3ok6OMC4RVd9bNW5E5VQrzmXO5VqTs4mWW1luyY3xqcYtZ?=
 =?us-ascii?q?KmYCQG0okryhrcZvCfboSF4xbuWPyPLTp2hH9pYqyziheo/UWixeDxUNS/3k?=
 =?us-ascii?q?xQoSpfiNbMs2gA1xnU6seaVPRw5lyh2TOT1wDL7eFEPFw0mbLbK5E/xr4wkY?=
 =?us-ascii?q?IesUHZES/3nEX6lbeWdks59uSx5eTrf7Hrq5yGO497jQH+NasumsihDugiLg?=
 =?us-ascii?q?cOWG2b9fy91L3l40L5XK1HguMqnqTdqpzXJsQWqrSnDwNIzoov8QuzAjOl3d?=
 =?us-ascii?q?gAmHkINlNFeBaJj4jzPFHOJej1DPe+glSsijhrxuzKMqHvD5jWM3jMjK3hca?=
 =?us-ascii?q?xj5EFB1Qo/1cpf6I5MCrEdPPLzXVf8tNjZDh8/Lgy1zP/rCNZj2YMEX2KAHK?=
 =?us-ascii?q?uZPbjMsV+H+O0vOfOAZIwLtzbnLfgq+frugWU+mV8Hcqn6lbUNb3XtL/V0I1?=
 =?us-ascii?q?ieKS79kNcIED9S5SIjR/ashVGfB20AL02uVr4xs2loQLmtCp3OE8Xy2LE=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2G+BgBWaJJdf8bSVdFmhXxMEI0ehkU?=
 =?us-ascii?q?BAQEGiyaBCYV6iiwBCAEBAQwBAS0CAQGEQINGIzgTAgMJAQEFAQEBAQEFBAE?=
 =?us-ascii?q?BAhABAQkLCwgnhUKCOimDNQsWFVKBFQEFATUiOYJHAYF2FAWiQYEDPIwlM4h?=
 =?us-ascii?q?gAQkNgUgJAQiBIoc1hFmBEIEHhGGHZYJEBIE3AQEBiz4BgjGHK5ZJAQYCghA?=
 =?us-ascii?q?UgXiTByeCN4ICiT05iwYBilWcawIKBwYPI4FGgXtNJYFsCoFEUBAUgVsXjkM?=
 =?us-ascii?q?hM4EIkBoB?=
X-IPAS-Result: =?us-ascii?q?A2G+BgBWaJJdf8bSVdFmhXxMEI0ehkUBAQEGiyaBCYV6i?=
 =?us-ascii?q?iwBCAEBAQwBAS0CAQGEQINGIzgTAgMJAQEFAQEBAQEFBAEBAhABAQkLCwgnh?=
 =?us-ascii?q?UKCOimDNQsWFVKBFQEFATUiOYJHAYF2FAWiQYEDPIwlM4hgAQkNgUgJAQiBI?=
 =?us-ascii?q?oc1hFmBEIEHhGGHZYJEBIE3AQEBiz4BgjGHK5ZJAQYCghAUgXiTByeCN4ICi?=
 =?us-ascii?q?T05iwYBilWcawIKBwYPI4FGgXtNJYFsCoFEUBAUgVsXjkMhM4EIkBoB?=
X-IronPort-AV: E=Sophos;i="5.64,568,1559545200"; 
   d="scan'208";a="79643063"
Received: from mail-pf1-f198.google.com ([209.85.210.198])
  by smtpmx5.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Sep 2019 13:44:12 -0700
Received: by mail-pf1-f198.google.com with SMTP id x10so8638647pfr.20
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 13:44:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dapQGiPs5+yxjLDl9zMNq1LcsFOAJWQdGyLQ0/gwWhQ=;
        b=m/5envjHj1elUSZV6r4uDLnvdCCVg5Af02zvF8UwVinMwkQ5lDL1Ygu9B2Q3gLvsbW
         bOiVSfTPoIfOS0AW/ur7bRms1Cezpf45OzVbpGG7/M93FQav0U5M13ZjqVJtbR9zqxbK
         k+98Jp6qPGlZtSv2PmUZhUfazdoi5dgGvsePUtMS0ELQM3DheaggZssIRuQBcniP5v2z
         zorzqk13P2/o94dOLXmQ8vmToYiRxIZ5wrfDWvVTTvpW/+UTWz4nXpIGf/VAJ+6qc3M4
         XF4Eyvne88bP2o6MOJwQmMqoCJtCHgoBFTy5Q5w4tvKDfx9yShS3MqQQ9B1kTE+WcI1G
         oXRw==
X-Gm-Message-State: APjAAAWIfkAcnMrPHBUdR3KiocbpvO0AYZ/sKkQQZlCvzznas2nDvSmT
        GcXRf+4VpBKeTDdZu2cr6LyWuj8v3R+hbHf61W57Al6Z1EbExcEwV70UwP0LfVtg+X8EVUW3c5C
        epyONEuZrlkxXCA1agmMXHPd2AQ==
X-Received: by 2002:a63:e001:: with SMTP id e1mr11470039pgh.358.1569876251835;
        Mon, 30 Sep 2019 13:44:11 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx9zg1sf8FzV4vsDfqgG05ZRQlpuE7Jqlj1s/A+Zus03/W2Go073rlg0ow44d+y6lPcxf9YEw==
X-Received: by 2002:a63:e001:: with SMTP id e1mr11469999pgh.358.1569876251280;
        Mon, 30 Sep 2019 13:44:11 -0700 (PDT)
Received: from Yizhuo.cs.ucr.edu (yizhuo.cs.ucr.edu. [169.235.26.74])
        by smtp.googlemail.com with ESMTPSA id s97sm409068pjc.4.2019.09.30.13.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 13:44:10 -0700 (PDT)
From:   Yizhuo <yzhai003@ucr.edu>
Cc:     csong@cs.ucr.edu, zhiyunq@cs.ucr.edu, Yizhuo <yzhai003@ucr.edu>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: trigger: stm32-timer: fix the usage of uninitialized variables
Date:   Mon, 30 Sep 2019 13:44:49 -0700
Message-Id: <20190930204451.28614-1-yzhai003@ucr.edu>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several functions in this file are trying to use regmap_read() to
initialize the specific variable, however, if regmap_read() fails,
the variable could be uninitialized but used directly, which is
potentially unsafe. The return value of regmap_read() should be
checked and handled. This patch fixes most of the uninitialized
variables, but those in function stm32_tt_read_frequency() are
hard to handle and need extra effot.

Signed-off-by: Yizhuo <yzhai003@ucr.edu>
---
 drivers/iio/trigger/stm32-timer-trigger.c | 98 ++++++++++++++++++++---
 1 file changed, 85 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/trigger/stm32-timer-trigger.c b/drivers/iio/trigger/stm32-timer-trigger.c
index a5dfe65cd9b9..f8ea7bcbb739 100644
--- a/drivers/iio/trigger/stm32-timer-trigger.c
+++ b/drivers/iio/trigger/stm32-timer-trigger.c
@@ -107,6 +107,7 @@ static int stm32_timer_start(struct stm32_timer_trigger *priv,
 	unsigned long long prd, div;
 	int prescaler = 0;
 	u32 ccer, cr1;
+	int ret;
 
 	/* Period and prescaler values depends of clock rate */
 	div = (unsigned long long)clk_get_rate(priv->clk);
@@ -132,11 +133,21 @@ static int stm32_timer_start(struct stm32_timer_trigger *priv,
 	}
 
 	/* Check if nobody else use the timer */
-	regmap_read(priv->regmap, TIM_CCER, &ccer);
+	ret = regmap_read(priv->regmap, TIM_CCER, &ccer);
+	if (ret) {
+		dev_err(priv->dev, "fail to read TIM_CCER.\n");
+		return ret;
+	}
+
 	if (ccer & TIM_CCER_CCXE)
 		return -EBUSY;
 
-	regmap_read(priv->regmap, TIM_CR1, &cr1);
+	ret = regmap_read(priv->regmap, TIM_CR1, &cr1);
+	if (ret) {
+		dev_err(priv->dev, "fail to read TIM_CR1.\n");
+		return ret;
+	}
+
 	if (!(cr1 & TIM_CR1_CEN))
 		clk_enable(priv->clk);
 
@@ -164,12 +175,23 @@ static int stm32_timer_start(struct stm32_timer_trigger *priv,
 static void stm32_timer_stop(struct stm32_timer_trigger *priv)
 {
 	u32 ccer, cr1;
+	int ret;
+
+	ret = regmap_read(priv->regmap, TIM_CCER, &ccer);
+	if (ret) {
+		dev_err(priv->dev, "Fail to read TIM_CCER.\n");
+		return;
+	}
 
-	regmap_read(priv->regmap, TIM_CCER, &ccer);
 	if (ccer & TIM_CCER_CCXE)
 		return;
 
-	regmap_read(priv->regmap, TIM_CR1, &cr1);
+	ret = regmap_read(priv->regmap, TIM_CR1, &cr1);
+	if (ret) {
+		dev_err(priv->dev, "Fail to read TIM_CR1.\n");
+		return;
+	}
+
 	if (cr1 & TIM_CR1_CEN)
 		clk_disable(priv->clk);
 
@@ -403,20 +425,36 @@ static int stm32_counter_read_raw(struct iio_dev *indio_dev,
 {
 	struct stm32_timer_trigger *priv = iio_priv(indio_dev);
 	u32 dat;
+	int ret;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		regmap_read(priv->regmap, TIM_CNT, &dat);
+		ret = regmap_read(priv->regmap, TIM_CNT, &dat);
+		if (ret) {
+			dev_err(priv->dev, "fail to read TIM_CNT.\n");
+			return ret;
+		}
+
 		*val = dat;
 		return IIO_VAL_INT;
 
 	case IIO_CHAN_INFO_ENABLE:
-		regmap_read(priv->regmap, TIM_CR1, &dat);
+		ret = regmap_read(priv->regmap, TIM_CR1, &dat);
+		if (ret) {
+			dev_err(priv->dev, "fail to read TIM_CR1.\n");
+			return ret;
+		}
+
 		*val = (dat & TIM_CR1_CEN) ? 1 : 0;
 		return IIO_VAL_INT;
 
 	case IIO_CHAN_INFO_SCALE:
-		regmap_read(priv->regmap, TIM_SMCR, &dat);
+		ret = regmap_read(priv->regmap, TIM_SMCR, &dat);
+		if (ret) {
+			dev_err(priv->dev, "fail to read TIM_SMCR.\n");
+			return ret;
+		}
+
 		dat &= TIM_SMCR_SMS;
 
 		*val = 1;
@@ -438,6 +476,7 @@ static int stm32_counter_write_raw(struct iio_dev *indio_dev,
 {
 	struct stm32_timer_trigger *priv = iio_priv(indio_dev);
 	u32 dat;
+	int ret;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
@@ -449,13 +488,23 @@ static int stm32_counter_write_raw(struct iio_dev *indio_dev,
 
 	case IIO_CHAN_INFO_ENABLE:
 		if (val) {
-			regmap_read(priv->regmap, TIM_CR1, &dat);
+			ret = regmap_read(priv->regmap, TIM_CR1, &dat);
+			if (ret) {
+				dev_err(priv->dev, "fail to read TIM_CR1.\n");
+				return ret;
+			}
+
 			if (!(dat & TIM_CR1_CEN))
 				clk_enable(priv->clk);
 			regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN,
 					   TIM_CR1_CEN);
 		} else {
-			regmap_read(priv->regmap, TIM_CR1, &dat);
+			ret = regmap_read(priv->regmap, TIM_CR1, &dat);
+			if (ret) {
+				dev_err(priv->dev, "fail to read TIM_CR1.\n");
+				return ret;
+			}
+
 			regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN,
 					   0);
 			if (dat & TIM_CR1_CEN)
@@ -517,8 +566,13 @@ static int stm32_get_trigger_mode(struct iio_dev *indio_dev,
 {
 	struct stm32_timer_trigger *priv = iio_priv(indio_dev);
 	u32 smcr;
+	int ret;
 
-	regmap_read(priv->regmap, TIM_SMCR, &smcr);
+	ret = regmap_read(priv->regmap, TIM_SMCR, &smcr);
+	if (ret) {
+		dev_err(priv->dev, "fail to read TIM_SMCR.\n");
+		return ret;
+	}
 
 	return (smcr & TIM_SMCR_SMS) == TIM_SMCR_SMS ? 0 : -EINVAL;
 }
@@ -557,6 +611,7 @@ static int stm32_set_enable_mode(struct iio_dev *indio_dev,
 	struct stm32_timer_trigger *priv = iio_priv(indio_dev);
 	int sms = stm32_enable_mode2sms(mode);
 	u32 val;
+	int ret;
 
 	if (sms < 0)
 		return sms;
@@ -565,7 +620,12 @@ static int stm32_set_enable_mode(struct iio_dev *indio_dev,
 	 * enable counter clock, so it can use it. Keeps it in sync with CEN.
 	 */
 	if (sms == 6) {
-		regmap_read(priv->regmap, TIM_CR1, &val);
+		ret = regmap_read(priv->regmap, TIM_CR1, &val);
+		if (ret) {
+			dev_err(priv->dev, "fail to read TIM_CR1.\n");
+			return ret;
+		}
+
 		if (!(val & TIM_CR1_CEN))
 			clk_enable(priv->clk);
 	}
@@ -594,8 +654,14 @@ static int stm32_get_enable_mode(struct iio_dev *indio_dev,
 {
 	struct stm32_timer_trigger *priv = iio_priv(indio_dev);
 	u32 smcr;
+	int ret;
+
+	ret = regmap_read(priv->regmap, TIM_SMCR, &smcr);
+	if (ret) {
+		dev_err(priv->dev, "fail to read TIM_SMCR.\n");
+		return ret;
+	}
 
-	regmap_read(priv->regmap, TIM_SMCR, &smcr);
 	smcr &= TIM_SMCR_SMS;
 
 	return stm32_sms2enable_mode(smcr);
@@ -706,13 +772,19 @@ EXPORT_SYMBOL(is_stm32_timer_trigger);
 static void stm32_timer_detect_trgo2(struct stm32_timer_trigger *priv)
 {
 	u32 val;
+	int ret;
 
 	/*
 	 * Master mode selection 2 bits can only be written and read back when
 	 * timer supports it.
 	 */
 	regmap_update_bits(priv->regmap, TIM_CR2, TIM_CR2_MMS2, TIM_CR2_MMS2);
-	regmap_read(priv->regmap, TIM_CR2, &val);
+	ret = regmap_read(priv->regmap, TIM_CR2, &val);
+	if (ret) {
+		dev_err(priv->dev, "fail to read TIM_CR2.\n");
+		return;
+	}
+
 	regmap_update_bits(priv->regmap, TIM_CR2, TIM_CR2_MMS2, 0);
 	priv->has_trgo2 = !!val;
 }
-- 
2.17.1

