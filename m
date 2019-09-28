Return-Path: <SRS0=c662=XX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 381D8C388F4
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Sep 2019 00:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 104FF20863
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Sep 2019 00:46:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="r4fcNMNe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728355AbfI1AqC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 20:46:02 -0400
Received: from mx5.ucr.edu ([138.23.62.67]:46797 "EHLO mx5.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725306AbfI1AqC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 20:46:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1569631561; x=1601167561;
  h=from:to:cc:subject:date:message-id;
  bh=Gyih0+ys/dsZuk6p5tTk9jxHvhG3+TejPRIPLUcLycQ=;
  b=r4fcNMNelVKQz6Ykpc2XLK+N5160eGKs8qfNIHumoGr5+jc8p3Xd0yv3
   BSwq5gjXZw8sgw/ql2L4tWUD4XIFAz64XHct932t/+EPeny0x946YVNCJ
   Obt8GvnRmI06fs9RXoRqakOmS/AWbuxZsODrkfmpN255giprJT1z8/+IL
   NmfGLyyUpZ1fGxoWT8HIjM9SEfI8JBM96XLekB821zM69wooJVZLIQLdQ
   AZBc6elqiYPh38n9iiyDF91xH9GBi2KRxscl1sd0pdwOY8x6VhIGaxuNJ
   AyJV89cML5K17E94xweLfty+OTK+Zjq0N9JMc005F1C5J8dPtoS+3Isj5
   A==;
IronPort-SDR: 5VC74JGaosMXjQToRRM8IvHvCuvg8oE8m6rwTlADGzhdhydxao80fm4CmlOOu+/RElzjtp6gh2
 r8bcyWgOCepIH1FcpvVbVMwEVAcvhXP2av7IS1VR14ZkIrjTQFbaaIZgswRquNFUCRFXKFtpAp
 y6M64jRUBQTF5EwoX1PStH9r7Sn4im33w7M3ubfmmwnylSJwXNhTkjpurmBW2F8fB4hqchACGS
 CzbPiE8+RnrSYiB/OALPJwT18HpBheQbFA1nR39tqbySqpgCjgSASgTbzQzovR9q68bf8Tgc0A
 j68=
IronPort-PHdr: =?us-ascii?q?9a23=3A/wB38xWDq9vUxEdys7+mCjyQ8SnV8LGtZVwlr6?=
 =?us-ascii?q?E/grcLSJyIuqrYYx2Gt8tkgFKBZ4jH8fUM07OQ7/m7Hzdfqs3d+Fk5M7V0Hy?=
 =?us-ascii?q?cfjssXmwFySOWkMmbcaMDQUiohAc5ZX0Vk9XzoeWJcGcL5ekGA6ibqtW1aFR?=
 =?us-ascii?q?rwLxd6KfroEYDOkcu3y/qy+5rOaAlUmTaxe7x/IAi4oAnLuMQbg4RuJ6g+xx?=
 =?us-ascii?q?DUvnZGZuNayH9yK1mOhRj8/MCw/JBi8yRUpf0s8tNLXLv5caolU7FWFSwqPG?=
 =?us-ascii?q?8p6sLlsxnDVhaP6WAHUmoKiBpIAhPK4w/8U5zsryb1rOt92C2dPc3rUbA5XC?=
 =?us-ascii?q?mp4ql3RBP0jioMKiU0+3/LhMNukK1boQqhpx1hzI7SfIGVL+d1cqfEcd8HWW?=
 =?us-ascii?q?ZNQsNdWipEAoO9dIsPFOsBPeBXr4LguVUAtAa1BQetBOzxzj9Hm2L90ak03u?=
 =?us-ascii?q?g9FA3L2hErEdATv3TOtNj7NLkcX/27wqfLyjvOdO9a1Svn5YTUaB0tve2AUL?=
 =?us-ascii?q?RtesTR00kvEAbFg02SpozkPjKV1vkNs2+G5OdnVeOuim4npBtwojSz2sshhJ?=
 =?us-ascii?q?LEhp8JxVDe7yl23ps6JcChRUN9fNWqE4NQujmEO4dqRs4uWWJltSYgxrEYpJ?=
 =?us-ascii?q?K2czIGxIo7yxLDc/CLbomF7xb5WOqPLzp1hGhpdKy+ihqo80WtxevxXdSu3l?=
 =?us-ascii?q?lQtCpKiNzMu2gI1xzU98eIVONw/lyk2TaTzwDT7fxEIVwsmarbNZEhxrkwm4?=
 =?us-ascii?q?IWsUvZHy/2nFz6jLeSdkk54+So5frrbqn6qpOGOI90jQb+MqsqmsOhG+g3Lg?=
 =?us-ascii?q?8OX22D9eS90r3s41H5Ta1UgvEqlqTVqpPXKMQBqqKnHgNY3Zwv5wijAzu6yN?=
 =?us-ascii?q?gYmGMILFNBeBKJlYjpPFTOLej4DPa+g1SjijZry+zaMrDvGZjNM2TMkK37cb?=
 =?us-ascii?q?lj9kFc1RI/zcpD6JJMFrEBPPXzV1f1tNzZCB85LgO1z//kCNpjzIMeX3yAAq?=
 =?us-ascii?q?uCPaPMvl+H+PgvL/OPZIALojb9LeYq5/r0gX8+g18dcvrh84EQbSWJH+ZmPk?=
 =?us-ascii?q?LRNWv+gt4AST9Rlhc1VqrnhEDUAm0bXGq7Q69pvmJzM4mhF4qWA9/1jQ=3D?=
 =?us-ascii?q?=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2FFCgDkq45dgMjWVdFmHgEGEoFcC4N?=
 =?us-ascii?q?eTBCNHoVyUAMGiyaBCYV6iDGBewEIAQEBDAEBLQIBAYRAgzojNAkOAgMJAQE?=
 =?us-ascii?q?FAQEBAQEFBAEBAhABAQkNCQgnhUKCOimDNQsWFVKBFQEFATUiOYJHAYF2FAW?=
 =?us-ascii?q?hLoEDPIwlM4hxAQkNgUgJAQiBIoc1hFmBEIEHgRGDUIdjgkQEgS8BAQGLP4I?=
 =?us-ascii?q?xhyuWSQEGAoIQFIF4kwcnhDmJPYs/AS2KKJxqAgoHBg8jgS+CEU0lgWwKgUR?=
 =?us-ascii?q?QEBSBWhcVji0hM4EIjj0B?=
X-IPAS-Result: =?us-ascii?q?A2FFCgDkq45dgMjWVdFmHgEGEoFcC4NeTBCNHoVyUAMGi?=
 =?us-ascii?q?yaBCYV6iDGBewEIAQEBDAEBLQIBAYRAgzojNAkOAgMJAQEFAQEBAQEFBAEBA?=
 =?us-ascii?q?hABAQkNCQgnhUKCOimDNQsWFVKBFQEFATUiOYJHAYF2FAWhLoEDPIwlM4hxA?=
 =?us-ascii?q?QkNgUgJAQiBIoc1hFmBEIEHgRGDUIdjgkQEgS8BAQGLP4IxhyuWSQEGAoIQF?=
 =?us-ascii?q?IF4kwcnhDmJPYs/AS2KKJxqAgoHBg8jgS+CEU0lgWwKgURQEBSBWhcVji0hM?=
 =?us-ascii?q?4EIjj0B?=
X-IronPort-AV: E=Sophos;i="5.64,557,1559545200"; 
   d="scan'208";a="79205498"
Received: from mail-pl1-f200.google.com ([209.85.214.200])
  by smtpmx5.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Sep 2019 17:46:00 -0700
Received: by mail-pl1-f200.google.com with SMTP id g11so2601313plm.22
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 17:46:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WVXKJFPAYYP31lJ6IlM5/o8x5LjKeBVij0jUlLnOB1Y=;
        b=NCEwi9D9Q4u+MjmFiH39LZZJ/IeF36SZoCfi40RbhQxPkivAAe+lCf4J3R/SR/qUee
         q9p1IX6HUDj4QzOsopN1RB0XfB5ECcAkNt5lcBnRdZK60ljQDfgRx350KmkfYuc9REPe
         rqnnNNVGENNIfD7xXJzBJMxMvzIjvBpYprX8kJw1NQt2LxRWX/Sx5aExCpGlERG3xROS
         xXyJyADWRpeqNjTOJOIGj1cJYdTJR9fx0oy3q1yE5HMDsNctkG7Cu2FmplJDu1jZXLXx
         khC+g++JcerPrOsyscsLcBNG3RMSMx7nM1gn9Gbjioxgi3OflrmlHA8sA5KzHWePyFQf
         sL2w==
X-Gm-Message-State: APjAAAXW71bDSCNUJSwQtifNTS+r4RbSF4XlBUzTdD4x1bKPtaEEtoRe
        3KWdSbUxU0TY4zUzYaljWNLkLtaE027HFOLhohBK4L7W8TU5PmyC490/3ehImQqEJF1snwFQHxf
        m9+bcNSkClF57vO/wkYOd2PgQ6w==
X-Received: by 2002:a17:90a:3301:: with SMTP id m1mr13556470pjb.27.1569631560294;
        Fri, 27 Sep 2019 17:46:00 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx/7cnNYMLx9aWgtGrOZYcIU8PemYtXquLbvog1tYQtmk61OBe75ni/14YXREFeG7CW3SRlDg==
X-Received: by 2002:a17:90a:3301:: with SMTP id m1mr13556446pjb.27.1569631560014;
        Fri, 27 Sep 2019 17:46:00 -0700 (PDT)
Received: from Yizhuo.cs.ucr.edu (yizhuo.cs.ucr.edu. [169.235.26.74])
        by smtp.googlemail.com with ESMTPSA id r2sm4136689pfq.60.2019.09.27.17.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2019 17:45:59 -0700 (PDT)
From:   Yizhuo <yzhai003@ucr.edu>
Cc:     csong@cs.ucr.edu, zhiyunq@cs.ucr.edu, Yizhuo <yzhai003@ucr.edu>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nicholas Mc Guire <hofrat@osadl.org>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: adc: meson-saradc: Variables could be uninitalized if regmap_read() fails
Date:   Fri, 27 Sep 2019 17:46:41 -0700
Message-Id: <20190928004642.28932-1-yzhai003@ucr.edu>
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
checked and handled.

Signed-off-by: Yizhuo <yzhai003@ucr.edu>
---
 drivers/iio/adc/meson_saradc.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
index 7b28d045d271..c032a64108b4 100644
--- a/drivers/iio/adc/meson_saradc.c
+++ b/drivers/iio/adc/meson_saradc.c
@@ -323,6 +323,7 @@ static int meson_sar_adc_wait_busy_clear(struct iio_dev *indio_dev)
 {
 	struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
 	int regval, timeout = 10000;
+	int ret;
 
 	/*
 	 * NOTE: we need a small delay before reading the status, otherwise
@@ -331,7 +332,9 @@ static int meson_sar_adc_wait_busy_clear(struct iio_dev *indio_dev)
 	 */
 	do {
 		udelay(1);
-		regmap_read(priv->regmap, MESON_SAR_ADC_REG0, &regval);
+		ret = regmap_read(priv->regmap, MESON_SAR_ADC_REG0, &regval);
+		if (ret)
+			return ret;
 	} while (FIELD_GET(MESON_SAR_ADC_REG0_BUSY_MASK, regval) && timeout--);
 
 	if (timeout < 0)
@@ -358,7 +361,11 @@ static int meson_sar_adc_read_raw_sample(struct iio_dev *indio_dev,
 		return -EINVAL;
 	}
 
-	regmap_read(priv->regmap, MESON_SAR_ADC_FIFO_RD, &regval);
+	int ret = regmap_read(priv->regmap, MESON_SAR_ADC_FIFO_RD, &regval);
+
+	if (ret)
+		return ret;
+
 	fifo_chan = FIELD_GET(MESON_SAR_ADC_FIFO_RD_CHAN_ID_MASK, regval);
 	if (fifo_chan != chan->address) {
 		dev_err(&indio_dev->dev,
@@ -491,6 +498,7 @@ static int meson_sar_adc_lock(struct iio_dev *indio_dev)
 {
 	struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
 	int val, timeout = 10000;
+	int ret;
 
 	mutex_lock(&indio_dev->mlock);
 
@@ -506,7 +514,10 @@ static int meson_sar_adc_lock(struct iio_dev *indio_dev)
 		 */
 		do {
 			udelay(1);
-			regmap_read(priv->regmap, MESON_SAR_ADC_DELAY, &val);
+			ret = regmap_read(priv->regmap,
+					MESON_SAR_ADC_DELAY, &val);
+			if (ret)
+				return ret;
 		} while (val & MESON_SAR_ADC_DELAY_BL30_BUSY && timeout--);
 
 		if (timeout < 0) {
@@ -784,7 +795,10 @@ static int meson_sar_adc_init(struct iio_dev *indio_dev)
 		 * BL30 to make sure BL30 gets the values it expects when
 		 * reading the temperature sensor.
 		 */
-		regmap_read(priv->regmap, MESON_SAR_ADC_REG3, &regval);
+		ret = regmap_read(priv->regmap, MESON_SAR_ADC_REG3, &regval);
+		if (ret)
+			return ret;
+
 		if (regval & MESON_SAR_ADC_REG3_BL30_INITIALIZED)
 			return 0;
 	}
@@ -1014,7 +1028,11 @@ static irqreturn_t meson_sar_adc_irq(int irq, void *data)
 	unsigned int cnt, threshold;
 	u32 regval;
 
-	regmap_read(priv->regmap, MESON_SAR_ADC_REG0, &regval);
+	int ret = regmap_read(priv->regmap, MESON_SAR_ADC_REG0, &regval);
+
+	if (ret)
+		return ret;
+
 	cnt = FIELD_GET(MESON_SAR_ADC_REG0_FIFO_COUNT_MASK, regval);
 	threshold = FIELD_GET(MESON_SAR_ADC_REG0_FIFO_CNT_IRQ_MASK, regval);
 
-- 
2.17.1

