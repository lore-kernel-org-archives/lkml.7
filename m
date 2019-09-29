Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B4F8C4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 16:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4A342086A
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 16:48:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="PXClWSP/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729024AbfI2QsK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Sep 2019 12:48:10 -0400
Received: from mx6.ucr.edu ([138.23.62.71]:58840 "EHLO mx6.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbfI2QsJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 12:48:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1569775689; x=1601311689;
  h=from:to:cc:subject:date:message-id;
  bh=UNKIGMa4Eg+l+IVQcMpLQFIdcsa8oCD4s9qyVCpjIUE=;
  b=PXClWSP/1DOHyidKRvWshHDwqEeyyakwhqJwS4TToXaiXWTijGyLGnek
   ttzYWjcFdixk0J0ey6zib8ZzUHWKP2v4gIqRcFi5ECVBkxOGYhNikrNaq
   PsedSVjsz0+lvijmlI+D470YIjgxKA76UusGs1aDawgaaLfbkjr0u1bXy
   /RET3rgi+DK2bSWrvkhEQVwuMPFQIsTZ9fAY0S4pifsBqS8sxvDBJumfy
   LqJJxhrn0Ca/z+1gmNCHiLQJBs6eQHc1PmvSAT+WfDb0CCpZ/a9lUMuwC
   7N5yJ1hN9/yJLK8p2w5VOXA/MmYveWbwCG1+jKWTcc8PLlzO0Qi+M1Cbr
   Q==;
IronPort-SDR: fWI58rZa77aNxwRN+S8a30QnVNpF2FDnO5pNf/tZKuaOmmqHKco460vflMb0WSOBP0cVtkPeI7
 nwciB4Kj4YXU8OXPEffWorWcCOT4E1U6sZTrMbUkWkw4TM4pA+VwV4YGtD1avvHm4lFKY7rT+1
 +xWLvC1aGDdEHEjyLxbFebEdIgTbW2qnRWZ4jjMn4me+QdDkQ5hig2x/LoCZpJE7JFfMlQxKe0
 5+A87hVbaTcc27eDp25mwon2O08wCB0+l5pOqDlH38S3RVrJ1Sv4FZCx5F6CaFnpOEpzqiZdYO
 G7Q=
IronPort-PHdr: =?us-ascii?q?9a23=3AdAyiRBAbjqvNPN4ROVwAUyQJP3N1i/DPJgcQr6?=
 =?us-ascii?q?AfoPdwSPvyo8bcNUDSrc9gkEXOFd2Cra4d0KyK6+u5ATJIyK3CmUhKSIZLWR?=
 =?us-ascii?q?4BhJdetC0bK+nBN3fGKuX3ZTcxBsVIWQwt1Xi6NU9IBJS2PAWK8TW94jEIBx?=
 =?us-ascii?q?rwKxd+KPjrFY7OlcS30P2594HObwlSizexfL1/IA+5oAnNucUanJduJ6cswR?=
 =?us-ascii?q?bVv3VEfPhby3l1LlyJhRb84cmw/J9n8ytOvv8q6tBNX6bncakmVLJUFDspPX?=
 =?us-ascii?q?w7683trhnDUBCA5mAAXWUMkxpHGBbK4RfnVZrsqCT6t+592C6HPc3qSL0/RD?=
 =?us-ascii?q?qv47t3RBLulSwKLCAy/n3JhcNsjaJbuBOhqAJ5w47Ie4GeKf5ycrrAcd8GWW?=
 =?us-ascii?q?ZNW8BcVylAAoOndIsPDuwBPelFpIfjvlUFsBW+BQiyC+Pr1zBDm3v60KMm3+?=
 =?us-ascii?q?gkFwzNwQ4uEM8UsHnMrNv7KrocX+62wqfP1jjPc+9a1C3h5IXSbhwtvfeBVq?=
 =?us-ascii?q?9wf8rLzkkvEhvIgVeRqY3kPzOVy+MNuHWc4utgVOOvi3QoqwBtrjSzyMohkZ?=
 =?us-ascii?q?TJiZ4Pylze6yp23Zs1KMS+RUVmYtCkCINduz+GO4ZyWM8vQGFltDwkxrEbpZ?=
 =?us-ascii?q?K3ZjUGxZAlyhLHdvCKcoyF7gj9WOufITp0nmxpdbOlixuw/kWtzPD3WNOu31?=
 =?us-ascii?q?ZQtCVFl8HBtnUK1xPO9MeKUuB9/kK92TaX0ADT9/1ELVg0laXFL54hxaY9lp?=
 =?us-ascii?q?8JvkTCGi/6gV32jKGLekk99Oik9uDqb7f8qp+TMI90jQ7+MqAwlcClHes4NQ?=
 =?us-ascii?q?0OU3Ca+eS6yrLj4VX0TKtWgvAyiKXUs5DXKd4FqqKkHwNZyJsv5hK9Aju+1d?=
 =?us-ascii?q?QXh3gHLFZLeBKdiIjpPknDIfD5DPe/mVuskStny+zIM7D6H5XCMmLDnK3/cr?=
 =?us-ascii?q?lg9k5Q0BAzwsxH55JIFrEBJ+r+WkvwtNzeEx84PBW4w+X5B9Vn0IMRR2aPD7?=
 =?us-ascii?q?SHMKPdr1CI/PgjI+qSa48PvjbyNfwl6+TpjX8jll9ONYez2p5CWXGqHulhax?=
 =?us-ascii?q?GIc3rlg49ZSk8XtRB4QeD33g7RGQVPbmq/CvpvrgowD5irWMKcHo0=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2EZBQC035BdgMXSVdFmHgEGEoFcC4N?=
 =?us-ascii?q?eTBCNHoVyUQEBBosmgQmFeogxgXsBCAEBAQwBAS0CAQGEQIM6IzQJDgIDCQE?=
 =?us-ascii?q?BBQEBAQEBBQQBAQIQAQEJDQkIJ4VCgjopgzULFhVSgRUBBQE1IjmCRwGBdhQ?=
 =?us-ascii?q?FnzaBAzyMJTOIagEJDYFICQEIgSKHNYRZgRCBB4ERg1CHY4JEBIEvAQEBiz+?=
 =?us-ascii?q?CMYcrlkkBBgKCEBSBeJMHJ4Q5iT2LPwEtiiicawIKBwYPI4EvghFNJYFsCoF?=
 =?us-ascii?q?EUBAUgVoXFY4tITOBCJAPAQ?=
X-IPAS-Result: =?us-ascii?q?A2EZBQC035BdgMXSVdFmHgEGEoFcC4NeTBCNHoVyUQEBB?=
 =?us-ascii?q?osmgQmFeogxgXsBCAEBAQwBAS0CAQGEQIM6IzQJDgIDCQEBBQEBAQEBBQQBA?=
 =?us-ascii?q?QIQAQEJDQkIJ4VCgjopgzULFhVSgRUBBQE1IjmCRwGBdhQFnzaBAzyMJTOIa?=
 =?us-ascii?q?gEJDYFICQEIgSKHNYRZgRCBB4ERg1CHY4JEBIEvAQEBiz+CMYcrlkkBBgKCE?=
 =?us-ascii?q?BSBeJMHJ4Q5iT2LPwEtiiicawIKBwYPI4EvghFNJYFsCoFEUBAUgVoXFY4tI?=
 =?us-ascii?q?TOBCJAPAQ?=
X-IronPort-AV: E=Sophos;i="5.64,563,1559545200"; 
   d="scan'208";a="79013434"
Received: from mail-pf1-f197.google.com ([209.85.210.197])
  by smtpmx6.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Sep 2019 09:48:09 -0700
Received: by mail-pf1-f197.google.com with SMTP id s139so5988550pfc.21
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2019 09:48:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=utdaQ4jWHTttFql8WKqbnsQdQq9GY1vzrMBpLN2a9NQ=;
        b=MrgTJ8twF4Yy9q6KttjYq2FsqY1iP0pr386IS+flpmklPiOEQx99PYXWOMvL6VcJHP
         Lsb3sMElw4ubqaOk7evW2sLhTD3tbVdfQvWGxd00JDOErk8+w6ZoK3udweYrX27zMNd7
         B5Mxe4QGEc7In/Ig7dNyf7NZ6nRzYBzKYcSDkD4oC+VAWU8noVpUR7FwKvrbwKVb8JNS
         epsWtBQ2b5T0Zgxql/6lAiQaDakZRQ4t1bhX21r4l2Sg2u9cgaVXXZGgmdOtrNMv2Dm1
         lAULiNBUw/aWYYg70DsDctffVAKcFUQA9t7AbDTEhRNAX1Adu7zX3X9RySGjC9MvzcXx
         6/2g==
X-Gm-Message-State: APjAAAWlY8s/Kus0fzkujh5+Bx0y1mPID6W1k4sQZH7H3uIy7hAaHfAD
        nu4CSrLybfRt4JZ9peyJTfJWfDR1Kl756VpRPJi87aeZLnS0QAFREp30krCehNUQHEa61wQl+1l
        7PGj2bSM4WPBqViwUys824DOv9w==
X-Received: by 2002:a17:90a:3090:: with SMTP id h16mr22224056pjb.46.1569775687369;
        Sun, 29 Sep 2019 09:48:07 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxJjjuQpguiCEE+oT8FZ21bOrlaI5ek77fAN6CJVVTks05KOo47tYsfxvPiCR9IDOpmjYNCew==
X-Received: by 2002:a17:90a:3090:: with SMTP id h16mr22224024pjb.46.1569775687030;
        Sun, 29 Sep 2019 09:48:07 -0700 (PDT)
Received: from Yizhuo.cs.ucr.edu (yizhuo.cs.ucr.edu. [169.235.26.74])
        by smtp.googlemail.com with ESMTPSA id ep10sm26814605pjb.2.2019.09.29.09.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2019 09:48:05 -0700 (PDT)
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
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicholas Mc Guire <hofrat@osadl.org>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: adc: meson-saradc: Variables could be uninitalized if regmap_read() fails
Date:   Sun, 29 Sep 2019 09:48:43 -0700
Message-Id: <20190929164848.13930-1-yzhai003@ucr.edu>
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
 drivers/iio/adc/meson_saradc.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
index 7b28d045d271..4b6c2983ef39 100644
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
@@ -346,6 +349,7 @@ static int meson_sar_adc_read_raw_sample(struct iio_dev *indio_dev,
 {
 	struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
 	int regval, fifo_chan, fifo_val, count;
+	int ret;
 
 	if(!wait_for_completion_timeout(&priv->done,
 				msecs_to_jiffies(MESON_SAR_ADC_TIMEOUT)))
@@ -358,7 +362,10 @@ static int meson_sar_adc_read_raw_sample(struct iio_dev *indio_dev,
 		return -EINVAL;
 	}
 
-	regmap_read(priv->regmap, MESON_SAR_ADC_FIFO_RD, &regval);
+	ret = regmap_read(priv->regmap, MESON_SAR_ADC_FIFO_RD, &regval);
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
+						MESON_SAR_ADC_DELAY, &val);
+			if (ret)
+				return ret;
 		} while (val & MESON_SAR_ADC_DELAY_BL30_BUSY && timeout--);
 
 		if (timeout < 0) {
@@ -771,7 +782,7 @@ static int meson_sar_adc_init(struct iio_dev *indio_dev)
 {
 	struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
 	int regval, i, ret;
-
+	int ret;
 	/*
 	 * make sure we start at CH7 input since the other muxes are only used
 	 * for internal calibration.
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
@@ -1013,8 +1027,12 @@ static irqreturn_t meson_sar_adc_irq(int irq, void *data)
 	struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
 	unsigned int cnt, threshold;
 	u32 regval;
+	int ret;
+
+	ret = regmap_read(priv->regmap, MESON_SAR_ADC_REG0, &regval);
+	if (ret)
+		return ret;
 
-	regmap_read(priv->regmap, MESON_SAR_ADC_REG0, &regval);
 	cnt = FIELD_GET(MESON_SAR_ADC_REG0_FIFO_COUNT_MASK, regval);
 	threshold = FIELD_GET(MESON_SAR_ADC_REG0_FIFO_CNT_IRQ_MASK, regval);
 
-- 
2.17.1

