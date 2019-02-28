Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45D5DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 133A42171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:24:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KkaLNZlL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732801AbfB1OYk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 09:24:40 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40216 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbfB1OYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 09:24:40 -0500
Received: by mail-qt1-f193.google.com with SMTP id j36so23629840qta.7;
        Thu, 28 Feb 2019 06:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=T7e+fs7V+yeM3EHke7E+9+CDMITg0TvBzaawUe6DGE8=;
        b=KkaLNZlLNvaSNKFwYsREkTpos9mfrvRMlZpcoK7BV/ChTlT31olFWCOpqY43KizRq0
         fZhqUXszAgPEw0iuH74ETCL5vPtAPT1wZMteBnPJ7oWvHaHGu+vGjCos6gtYZg25n6Eh
         xfkPDxFcJi5Ve+aTE/U7Kr4kCaFvt06xm/KS9ntn+qroRHgmQBtREbhSAG05BdZEMptI
         eE0bQwXkB7lc0cGvBKj4JY+6O/uZtkLtbfIbsKYxWUmCA5lsND3Tm7/VEMyy8+SQ4HM8
         NC4gMd/qq+/Ed7qQuFiJTdtKcClchkghHj9CnzGKw+geuENpPAsABD4ouoNsRc+Ve7e+
         Vzjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=T7e+fs7V+yeM3EHke7E+9+CDMITg0TvBzaawUe6DGE8=;
        b=Q6j1iO4LfpI1wcTGqUWQxMla21td0GG0XPIeYfdq/dN/52O3AihkrQ7naZAbjTV/wi
         0WEcGIwSXnoU5IU0kjV+O99zY6+MBKjbiuXkWeMt9b8qJlu3jk2jVFTu85IWjjeEW6ov
         n+Zu1ZpW6b4vmCNZfixbm9NpiHA7dDwYWTYSKwqP7fGwUXLd0Qyy5fLNHeak9vndq3rT
         m3Kc4rOctqzrPgcoxrkmK8rRYoZSkpbCLEy/CbmnOspDmYuJhdyKKvQRYvtA9JI5x++P
         DWyJoKS10H3PYeC7pKt2Xbv+oK6Wm02Sj+XdvB+wPrKJc6ydwkufzd33FKBundNAw1UM
         3AbA==
X-Gm-Message-State: APjAAAU4H5D670xUXlII+i1+2YCE6KcQTYLamw8Wvl98sLysnFCa5su8
        1XGQc56LprdT10LI/UdW4eE=
X-Google-Smtp-Source: AHgI3IaEUOjl1HQHYg19WGwPEwf84thp23Dc/vDhd5NkTB59jmMBCkiGGE54D4qNH2ztfZkR0Z9X1Q==
X-Received: by 2002:ac8:734a:: with SMTP id q10mr6509687qtp.106.1551363878724;
        Thu, 28 Feb 2019 06:24:38 -0800 (PST)
Received: from renatolg ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id 24sm14133433qtu.17.2019.02.28.06.24.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Feb 2019 06:24:38 -0800 (PST)
Date:   Thu, 28 Feb 2019 11:24:32 -0300
From:   Renato Lui Geh <renatogeh@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        stefan.popa@analog.com, alexandru.Ardelean@analog.com,
        giuliano.belinassi@usp.br, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com,
        devicetree@vger.kernel.org
Subject: [PATCH v4 3/9] staging: iio: ad7780: set pattern values and masks
 directly
Message-ID: <9c8331166124ec2bd52794a9c9f844bfb70d1cd9.1551358569.git.renatogeh@gmail.com>
References: <cover.1551358569.git.renatogeh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <cover.1551358569.git.renatogeh@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AD7780 driver contains status pattern bits designed for checking
whether serial transfers have been correctly performed. Pattern macros
were previously generated through bit fields. This patch sets good
pattern values directly and masks through GENMASK.

Signed-off-by: Renato Lui Geh <renatogeh@gmail.com>
---
 drivers/staging/iio/adc/ad7780.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
index 7a68e90ddf14..56c49e28f432 100644
--- a/drivers/staging/iio/adc/ad7780.c
+++ b/drivers/staging/iio/adc/ad7780.c
@@ -17,6 +17,7 @@
 #include <linux/sched.h>
 #include <linux/gpio/consumer.h>
 #include <linux/module.h>
+#include <linux/bits.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -28,16 +29,13 @@
 #define AD7780_ID1		BIT(4)
 #define AD7780_ID0		BIT(3)
 #define AD7780_GAIN		BIT(2)
-#define AD7780_PAT1		BIT(1)
-#define AD7780_PAT0		BIT(0)
 
-#define AD7780_PATTERN		(AD7780_PAT0)
-#define AD7780_PATTERN_MASK	(AD7780_PAT0 | AD7780_PAT1)
 
-#define AD7170_PAT2		BIT(2)
+#define AD7780_PATTERN_GOOD	1
+#define AD7780_PATTERN_MASK	GENMASK(1, 0)
 
-#define AD7170_PATTERN		(AD7780_PAT0 | AD7170_PAT2)
-#define AD7170_PATTERN_MASK	(AD7780_PAT0 | AD7780_PAT1 | AD7170_PAT2)
+#define AD7170_PATTERN_GOOD	5
+#define AD7170_PATTERN_MASK	GENMASK(2, 0)
 
 #define AD7780_GAIN_MIDPOINT	64
 #define AD7780_FILTER_MIDPOINT	13350
@@ -209,25 +207,25 @@ static const struct ad_sigma_delta_info ad7780_sigma_delta_info = {
 static const struct ad7780_chip_info ad7780_chip_info_tbl[] = {
 	[ID_AD7170] = {
 		.channel = AD7170_CHANNEL(12, 24),
-		.pattern = AD7170_PATTERN,
+		.pattern = AD7170_PATTERN_GOOD,
 		.pattern_mask = AD7170_PATTERN_MASK,
 		.is_ad778x = false,
 	},
 	[ID_AD7171] = {
 		.channel = AD7170_CHANNEL(16, 24),
-		.pattern = AD7170_PATTERN,
+		.pattern = AD7170_PATTERN_GOOD,
 		.pattern_mask = AD7170_PATTERN_MASK,
 		.is_ad778x = false,
 	},
 	[ID_AD7780] = {
 		.channel = AD7780_CHANNEL(24, 32),
-		.pattern = AD7780_PATTERN,
+		.pattern = AD7780_PATTERN_GOOD,
 		.pattern_mask = AD7780_PATTERN_MASK,
 		.is_ad778x = true,
 	},
 	[ID_AD7781] = {
 		.channel = AD7780_CHANNEL(20, 32),
-		.pattern = AD7780_PATTERN,
+		.pattern = AD7780_PATTERN_GOOD,
 		.pattern_mask = AD7780_PATTERN_MASK,
 		.is_ad778x = true,
 	},
-- 
2.21.0

