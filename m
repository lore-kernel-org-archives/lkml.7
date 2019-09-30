Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53798C32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 21:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1972821855
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 21:15:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="rT2pb8LK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731514AbfI3VPB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 17:15:01 -0400
Received: from mx2.ucr.edu ([138.23.62.3]:35745 "EHLO mx2.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727118AbfI3VPA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 17:15:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1569878100; x=1601414100;
  h=from:to:cc:subject:date:message-id;
  bh=6pCT4FCPO1NK+0ZWeQGx+EaJmUPdETidBAplVSBV5bg=;
  b=rT2pb8LK9bDV1r8Vtc2BPrzUzrQtpw1lGJ+Nw/5b9bp+1UeyB+9wKvj2
   tedbl3tAlGcnXdyCP2Tu/5L+XhT7IuEaAgMt9T8OYdmPkG4x9odiSQKV7
   mvOFlbNkMakf2krgr/oka/UEAAvR/J6EYqW8ozVsfjsLr86fe1WmQnMHG
   RyQLPi48G34ZOfNBE4nI2t4wxWI6cp3PniAkdwZiAw6bDrfMWfW7OynLK
   ySiakEJOc0Zykt50/zvlZt5Zv2Zp+bfI2SG9OsRMkU3xbm52cnkkJWGZF
   gebidpV3Z16OwDba7gpd59Xo/qsrSGwFtSQ3H4h3S+WwFENMJhxnd8z/p
   g==;
IronPort-SDR: J+SDWywUzQggeFjkDwjU5SsambK4qlfdrVDaAmhuxuX+IAU/PHMNovdZ5/orFmsgz+H/Oz0cAE
 3dB7iZA091Hmn3KlGAh3NIcWX0cFulh40bQgAwSuMlNGrMzCCmIhxENFstfQuPJLaKY8zAm1a4
 AZBje4fTA1R1TqNmBW5Ig+ix2LRMB9UafHQU7+RpcLsoL1K3Wgs6IAXCf1LYimiqe1WlqKjm47
 DAqF9Sb4++snM2UPgZuJIWH+X/k23tG0sNgsB50sdq2sx5wODEse1gyixnYafAxwwlUaaFxfYr
 NzU=
IronPort-PHdr: =?us-ascii?q?9a23=3AjwzpgBDhVt4LyzC4chbZUyQJP3N1i/DPJgcQr6?=
 =?us-ascii?q?AfoPdwSPvyo8bcNUDSrc9gkEXOFd2Cra4d0KyK6eu5AjNIyK3CmUhKSIZLWR?=
 =?us-ascii?q?4BhJdetC0bK+nBN3fGKuX3ZTcxBsVIWQwt1Xi6NU9IBJS2PAWK8TW94jEIBx?=
 =?us-ascii?q?rwKxd+KPjrFY7OlcS30P2594HObwlSizexfL1/IA+5oAnPucUanIVvJ6QswR?=
 =?us-ascii?q?bVv3VEfPhby3l1LlyJhRb84cmw/J9n8ytOvv8q6tBNX6bncakmVLJUFDspPX?=
 =?us-ascii?q?w7683trhnDUBCA5mAAXWUMkxpHGBbK4RfnVZrsqCT6t+592C6HPc3qSL0/RD?=
 =?us-ascii?q?qv47t3RBLulSwKLCAy/n3JhcNsjaJbuBOhqAJ5w47Ie4GeKf5ycrrAcd8GWW?=
 =?us-ascii?q?ZNW8BcVylAAoOndIsPDuwBPelFpIfjvlUFsBW+BQiyC+Pr1zBDm3v60KMm3+?=
 =?us-ascii?q?gkFwzNwQ4uEM8UsHnMrNv7KrocX+62wqfP1jjPc+9a1C3h5IXSbhwtvfeBVq?=
 =?us-ascii?q?9wf8rLzkkvEhvIgVeRqY3kPzOVy+MNuHWc4utgVOOvi3QoqwBtrjSzyMohkZ?=
 =?us-ascii?q?TJiZ4Pylze6yp23Zs1KMS+RUVmYtCkCINduz+GO4ZyWM8vQGFltDwkxrEbtp?=
 =?us-ascii?q?O3ZjUGxZAlyhLHdvCKcoyF7gj9WOufITp0nmxpdbOlixuw/kWtzPD3WNOu31?=
 =?us-ascii?q?ZQtCVFl8HBtnUK1xPO9MeKUuB9/kK92TaX0ADT9/1ELVg0laXFL54hxaY9lp?=
 =?us-ascii?q?8JvkTCGi/6gV32jKuLekk99Oik9uDqb7f8qp+TMI90jQ7+MqAwlcClHes4NQ?=
 =?us-ascii?q?0OU3Ca+eS6yrLj4VX0TKtWgvAyiKXUs5DXKd4FqqKkDAJZyJsv5hK9Aju+1d?=
 =?us-ascii?q?QXh3gHLFZLeBKdiIjpPknDIfD5DPe/mVuskStny+zIM7D6H5XCMmLDnK3/cr?=
 =?us-ascii?q?lg9k5Q0BAzwsxH55JIFrEBJ+r+WkvwtNzeEx84PBW4w+X5B9Vn0IMRR2aPD7?=
 =?us-ascii?q?SHMKPdr1CI/PgjI+qSa48PvjbyNfwl6+TpjX8jll9ONYez2p5CWXGqHulhax?=
 =?us-ascii?q?GIc3rlg49ZSk8XtRB4QeD33g7RGQVPbmq/CvpvrgowD5irWMKcHo0=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2E5BQA2XJJdh8XWVdFmHgEGEoFcC4N?=
 =?us-ascii?q?eTBCNHoZGAQEGiyaBCYV6iDGBewEIAQEBDAEBLQIBAYRAg0YjNgcOAgMJAQE?=
 =?us-ascii?q?FAQEBAQEFBAEBAhABAQEIDQkIKYVAgjopgzULFhVSgRUBBQE1IjmCRwGBdhS?=
 =?us-ascii?q?iOoEDPIwlM4hdAQkNgUgJAQiBIoc1hFmBEIEHg25zh2WCRASBNwEBAYs4gji?=
 =?us-ascii?q?HK3CVWQEGAoIQFIF4kwcngjeCAok9OYsGAYpVnGsCCgcGDyOBNgOCCE0lgWw?=
 =?us-ascii?q?KgURQEBSBWw4JjkMhM4EIkBoB?=
X-IPAS-Result: =?us-ascii?q?A2E5BQA2XJJdh8XWVdFmHgEGEoFcC4NeTBCNHoZGAQEGi?=
 =?us-ascii?q?yaBCYV6iDGBewEIAQEBDAEBLQIBAYRAg0YjNgcOAgMJAQEFAQEBAQEFBAEBA?=
 =?us-ascii?q?hABAQEIDQkIKYVAgjopgzULFhVSgRUBBQE1IjmCRwGBdhSiOoEDPIwlM4hdA?=
 =?us-ascii?q?QkNgUgJAQiBIoc1hFmBEIEHg25zh2WCRASBNwEBAYs4gjiHK3CVWQEGAoIQF?=
 =?us-ascii?q?IF4kwcngjeCAok9OYsGAYpVnGsCCgcGDyOBNgOCCE0lgWwKgURQEBSBWw4Jj?=
 =?us-ascii?q?kMhM4EIkBoB?=
X-IronPort-AV: E=Sophos;i="5.64,568,1559545200"; 
   d="scan'208";a="11694280"
Received: from mail-pl1-f197.google.com ([209.85.214.197])
  by smtp2.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Sep 2019 12:53:18 -0700
Received: by mail-pl1-f197.google.com with SMTP id g7so5845265plo.5
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 12:53:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mtpDHPmhW0Yh7Xz6JlH7yVqsGjbzLMx+b7ky5TSik5U=;
        b=dFEakEL2EPS6Xmy5/D55w61FVozCJ5WWU5CdTsXqeL55Wvj6JqOuj6zPKUWc9CEr1U
         GXVCA6ZI54+NUA/fbWSkoG8h7xCRXxOe/X4n4S2KVAv7R+E5x/i1hRCVplmyy4mMN/U2
         RCfM58EwQcvlzq2zmO7GvX54c/s1PLG4bzUd0ELmhwyPbct8HXO4+lYLSzq4IILIwqr+
         IOjK+CjCMvNAsHkY9kPkBuoK/AR5f++N02Aib3yDATplwwAqHh+3g3l0jRv3TRvZiNyN
         sD+98C1KdSrK9oVAKh7fAN7t0TxDEoPrRgGPLQkhBahOoOrq3wsyYmrXspMlv0m62gAc
         i2hA==
X-Gm-Message-State: APjAAAUoRaIm3eSzdwWsZahcdr5sXQxv2hEJUxmXfAgECVblBJQ6IE91
        SHrpP37bRwnHqLL6nXES9fZLPhqj1p6MSmi8Gn1e78Gu3OdYibsbMY64zFV5OEiJak0SnStY7K+
        JumHFer5ALa2cPtoD0ZqZhQ6fNg==
X-Received: by 2002:a63:2aca:: with SMTP id q193mr25799140pgq.156.1569873197820;
        Mon, 30 Sep 2019 12:53:17 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxF6lwNas3D/FgEkqSm4zKuRr+Ixd0SEanVYzHGnmwSzt46Z2CHd4yfGTjhZMCMas6tzuHMXg==
X-Received: by 2002:a63:2aca:: with SMTP id q193mr25799110pgq.156.1569873197327;
        Mon, 30 Sep 2019 12:53:17 -0700 (PDT)
Received: from Yizhuo.cs.ucr.edu (yizhuo.cs.ucr.edu. [169.235.26.74])
        by smtp.googlemail.com with ESMTPSA id p17sm12179234pfn.50.2019.09.30.12.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 12:53:16 -0700 (PDT)
From:   Yizhuo <yzhai003@ucr.edu>
Cc:     csong@cs.ucr.edu, zhiyunq@cs.ucr.edu, Yizhuo <yzhai003@ucr.edu>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Enrico Weigelt <info@metux.net>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] iio: adc: imx25-gcq: fix uninitialized variable usage
Date:   Mon, 30 Sep 2019 12:53:54 -0700
Message-Id: <20190930195358.27844-1-yzhai003@ucr.edu>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function mx25_gcq_irq(), local variable "stats" could
be uninitialized if function regmap_read() returns -EINVAL.
However, this value is used in if statement, which is
potentially unsafe. The same case applied to the variable
"data" in function mx25_gcq_get_raw_value() in the same file.

Signed-off-by: Yizhuo <yzhai003@ucr.edu>
---
 drivers/iio/adc/fsl-imx25-gcq.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/fsl-imx25-gcq.c b/drivers/iio/adc/fsl-imx25-gcq.c
index fa71489195c6..3b1e12b7c1ac 100644
--- a/drivers/iio/adc/fsl-imx25-gcq.c
+++ b/drivers/iio/adc/fsl-imx25-gcq.c
@@ -73,8 +73,12 @@ static irqreturn_t mx25_gcq_irq(int irq, void *data)
 {
 	struct mx25_gcq_priv *priv = data;
 	u32 stats;
+	int ret;
 
-	regmap_read(priv->regs, MX25_ADCQ_SR, &stats);
+	ret = regmap_read(priv->regs, MX25_ADCQ_SR, &stats);
+	if (ret) {
+		return ret;
+	}
 
 	if (stats & MX25_ADCQ_SR_EOQ) {
 		regmap_update_bits(priv->regs, MX25_ADCQ_MR,
@@ -100,6 +104,7 @@ static int mx25_gcq_get_raw_value(struct device *dev,
 {
 	long timeout;
 	u32 data;
+	int ret;
 
 	/* Setup the configuration we want to use */
 	regmap_write(priv->regs, MX25_ADCQ_ITEM_7_0,
@@ -121,7 +126,11 @@ static int mx25_gcq_get_raw_value(struct device *dev,
 		return -ETIMEDOUT;
 	}
 
-	regmap_read(priv->regs, MX25_ADCQ_FIFO, &data);
+	ret = regmap_read(priv->regs, MX25_ADCQ_FIFO, &data);
+	if (ret) {
+		dev_err(dev, "Failed to read MX25_ADCQ_FIFO.\n");
+		return ret;
+	}
 
 	*val = MX25_ADCQ_FIFO_DATA(data);
 
-- 
2.17.1

