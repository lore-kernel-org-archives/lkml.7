Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE156C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B81E20818
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:24:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PoryDmHw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732756AbfB1OYT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 09:24:19 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38178 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727789AbfB1OYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 09:24:18 -0500
Received: by mail-qk1-f194.google.com with SMTP id p15so12150813qkl.5;
        Thu, 28 Feb 2019 06:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=s2xJk5kuw9HzXyjOYa9ht3wKQWc0/gmfp6f0SF77AbQ=;
        b=PoryDmHwTvBgL6wqXaBkxyEHWXpwVAFtQE2cJwM/Ev7UWc5YNZ1LXUu52pw9IW9dYM
         p45vKrFuhDGFUHc9kX8Tboe0FSqeQbyOrqPFyEPCzet0gPNHmB32gm3ty6/VOUkRLp25
         43MKyAGwes0baq2nCpBsykZPAoBOALDWj5OmaHjb1ddl+YWKiOTLOGrLISoqm0aPEhhr
         YP7L7nYvwZPeqIKmCUkWFTPCDJQzJFLmYf8jXj8XTgls5cgmuJC6QAFMEIN4HsU8eHJf
         7S4mQAxIvZRBaolxCKWwyDdB4i5utuRKCMZAYzs7Y1wxh11Qb7XkWCJusqlYpaiE+mg6
         nlAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=s2xJk5kuw9HzXyjOYa9ht3wKQWc0/gmfp6f0SF77AbQ=;
        b=Fst573rbJOit1Tqd0s04DCyiwgvh5zyyCBAQZwKQaWnCvrsc4fjPoNP8fAQL59aTEr
         GwLpXFjEr7/8+ff6K4kb9jMmitEI4oRX8feVTZcqHipGUbYVUzC6yG59Vtb6kmnqy673
         SkXH0lFTrPIHNZbLm9l5bh44FjdUjudIGQ4KxiBy6ZaYa4Ox0xXTcobQHzdF2bfDBJ5s
         YxPCnMfVv2GRKPq0Ov/15E9A3qiXqiQef/JZZNChLoRFo5flWAIBJgMWkK8G2GtCtVmj
         2Rk8f1CcI8s8w6WZPLwFV0nGM9+L9KrjuTe5xng5kqXbQujDcHmzReT9mkD8KOHo7See
         WODA==
X-Gm-Message-State: AHQUAuaAHvZO1d9hWY0nZXXalf/PWEt5dMk5K32sGePl81CKFiuYX6zz
        19MMNH6JhDX9Ljm6hbGN7Po=
X-Google-Smtp-Source: AHgI3Iby+xRWdyi1Udkr4G521b/6JPimbQBCpy0Nmu3wtyHHwxQfaLPtZAPFvLXM9oiwRtCOqUF1Fg==
X-Received: by 2002:ae9:f112:: with SMTP id k18mr6600576qkg.231.1551363857085;
        Thu, 28 Feb 2019 06:24:17 -0800 (PST)
Received: from renatolg ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id g24sm13418021qtc.61.2019.02.28.06.24.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Feb 2019 06:24:16 -0800 (PST)
Date:   Thu, 28 Feb 2019 11:24:10 -0300
From:   Renato Lui Geh <renatogeh@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        stefan.popa@analog.com, alexandru.Ardelean@analog.com,
        giuliano.belinassi@usp.br, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com,
        devicetree@vger.kernel.org
Subject: [PATCH v4 2/9] staging: iio: ad7780: add filter reading to ad778x
Message-ID: <a44c3316553c3cab4378d7e31c2d1914bf558c62.1551358569.git.renatogeh@gmail.com>
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

This patch adds the new feature of reading the filter odr value for
ad778x chips. This value is stored in the chip's state struct whenever a
read or write call is performed on the chip's driver.

This feature requires sharing SAMP_FREQ. Since the ad717x does not have
a filter option, the driver only shares the relevant info mask for the
ad778x family.

Signed-off-by: Renato Lui Geh <renatogeh@gmail.com>
---
Changes in v4:
 - As mentioned in the previous patch, this was originally as part of
   the 'add gain & filter gpio support' patch

 drivers/staging/iio/adc/ad7780.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
index 87fbcf510d45..7a68e90ddf14 100644
--- a/drivers/staging/iio/adc/ad7780.c
+++ b/drivers/staging/iio/adc/ad7780.c
@@ -59,6 +59,7 @@ struct ad7780_state {
 	struct gpio_desc		*gain_gpio;
 	struct gpio_desc		*filter_gpio;
 	unsigned int			gain;
+	unsigned int			odr;
 	unsigned int			int_vref_mv;
 
 	struct ad_sigma_delta sd;
@@ -121,6 +122,9 @@ static int ad7780_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_OFFSET:
 		*val = -(1 << (chan->scan_type.realbits - 1));
 		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*val = st->odr;
+		return IIO_VAL_INT;
 	default:
 	break;
 	}
@@ -163,6 +167,7 @@ static int ad7780_write_raw(struct iio_dev *indio_dev,
 			val = 0;
 		else
 			val = 1;
+		st->odr = ad778x_odr_avail[val];
 		gpiod_set_value(st->filter_gpio, val);
 		break;
 	default:
@@ -184,6 +189,7 @@ static int ad7780_postprocess_sample(struct ad_sigma_delta *sigma_delta,
 
 	if (chip_info->is_ad778x) {
 		st->gain = ad778x_gain[raw_sample & AD7780_GAIN];
+		st->odr = ad778x_odr_avail[raw_sample & AD7780_FILTER];
 	}
 
 	return 0;
@@ -196,17 +202,19 @@ static const struct ad_sigma_delta_info ad7780_sigma_delta_info = {
 };
 
 #define AD7780_CHANNEL(bits, wordsize) \
+	AD_SD_CHANNEL(1, 0, 0, bits, 32, wordsize - bits)
+#define AD7170_CHANNEL(bits, wordsize) \
 	AD_SD_CHANNEL_NO_SAMP_FREQ(1, 0, 0, bits, 32, wordsize - bits)
 
 static const struct ad7780_chip_info ad7780_chip_info_tbl[] = {
 	[ID_AD7170] = {
-		.channel = AD7780_CHANNEL(12, 24),
+		.channel = AD7170_CHANNEL(12, 24),
 		.pattern = AD7170_PATTERN,
 		.pattern_mask = AD7170_PATTERN_MASK,
 		.is_ad778x = false,
 	},
 	[ID_AD7171] = {
-		.channel = AD7780_CHANNEL(16, 24),
+		.channel = AD7170_CHANNEL(16, 24),
 		.pattern = AD7170_PATTERN,
 		.pattern_mask = AD7170_PATTERN_MASK,
 		.is_ad778x = false,
-- 
2.21.0

