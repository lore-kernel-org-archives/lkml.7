Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD50EC10F00
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 02:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BF04218D9
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 02:13:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mrQH3ss3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbfCPCNs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 22:13:48 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:36310 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbfCPCNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 22:13:48 -0400
Received: by mail-yw1-f67.google.com with SMTP id 189so8791551ywi.3;
        Fri, 15 Mar 2019 19:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KLZPRW9sZ24hszIQNiooOpJkNmFR+cHuvBsoqhX5Hio=;
        b=mrQH3ss3o0+iovsUjQ/eaTz6a679tfYwhAXvM5FylQIcH7HFEGEKjPzZoGy7cVhE2k
         /PONIvjSK2rZA5e68R2u0ZDDLSKqyPjlttyxLZ7U5ZNzGToeEWIGd2EYcynvT5btj6T6
         mby9QqCLmIVnk5/wuACXWu/BJ5p1K+7SHAkIfRCTyBTgGeDaEsKqvxc+xxbg4e0XxS3c
         TNemPBFhFeXV93dlQVAuXsu+np8couaSVlCiycsp9P55PVQ3d6yBrfuH3EH5bLLxsWn7
         ZTb0Mj9qlRtNyUvnADJcOoqyzOVV7X86E3OeJ+9MBhnC5hlIUP1vcE+6zV93aAfTMOt7
         Ty7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KLZPRW9sZ24hszIQNiooOpJkNmFR+cHuvBsoqhX5Hio=;
        b=K0asUc3sgiI4hDrFORim5f1GUanHRUC8rNs4tkBT2ZJvYSOhTjRJytpgfSBCcXzV8u
         x7h6+QHjbuMFqIO5bTveOiwIXbQ8M1hLo8qtkrWcX5Zadl204uIBppbjl+KmGm6wrblZ
         iojNJJBZfNCSCWKYouIxpuQZcWrDllkK8E1Mtevf4bS9/O9UUy1+VuPG8hcS8qdvhyrY
         mKMVw/H/1yVooSPUioD04l6761Qgbn0N3skh0QrPKOuUWX+XJjS9gBnn6VuCxRSWCFz+
         ARaN631QGpd659zjXmLOPypqglxxp6V436uSjLgH8MtZeJz968eVlVHGcSR6tW8vaguY
         z7Zg==
X-Gm-Message-State: APjAAAX4EKSydXsDPCVIe04r28+GnZERzOZGHEqktC9kXgOzru0atSxy
        LLrEpPZHXtkxeS5yHDLzfIc=
X-Google-Smtp-Source: APXvYqxZcpDG9/0VlXAGmLgJUP9mAsAcVwD36uM7Utp6D4f1Tuf0Ck9oFdfN5rUA83MLt5aYVcQyug==
X-Received: by 2002:a81:34a:: with SMTP id 71mr5493588ywd.303.1552702427064;
        Fri, 15 Mar 2019 19:13:47 -0700 (PDT)
Received: from renatolg ([186.220.21.102])
        by smtp.gmail.com with ESMTPSA id v198sm1291657ywv.24.2019.03.15.19.13.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Mar 2019 19:13:46 -0700 (PDT)
Date:   Fri, 15 Mar 2019 23:13:42 -0300
From:   Renato Lui Geh <renatogeh@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        stefan.popa@analog.com, alexandru.Ardelean@analog.com,
        giuliano.belinassi@usp.br, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com,
        devicetree@vger.kernel.org
Subject: [PATCH v5 04/11] staging: iio: ad7780: add filter reading to ad778x
Message-ID: <66a914ed7d1512f5aedfc5a0c6cbae38f5588e35.1552700652.git.renatogeh@gmail.com>
References: <cover.1552700652.git.renatogeh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <cover.1552700652.git.renatogeh@gmail.com>
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
Changes in v5:
 - Moved ad778x_odr_avail declaration from GPIO patch to this one

 drivers/staging/iio/adc/ad7780.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
index fbcc0d3345ca..8ff74427d975 100644
--- a/drivers/staging/iio/adc/ad7780.c
+++ b/drivers/staging/iio/adc/ad7780.c
@@ -42,7 +42,8 @@
 #define AD7780_GAIN_MIDPOINT	64
 #define AD7780_FILTER_MIDPOINT	13350
 
-static const unsigned int ad778x_gain[2] = { 1, 128 };
+static const unsigned int ad778x_gain[2]      = { 1, 128 };
+static const unsigned int ad778x_odr_avail[2] = { 10000, 16700 };
 
 struct ad7780_chip_info {
 	struct iio_chan_spec	channel;
@@ -58,6 +59,7 @@ struct ad7780_state {
 	struct gpio_desc		*gain_gpio;
 	struct gpio_desc		*filter_gpio;
 	unsigned int			gain;
+	unsigned int			odr;
 	unsigned int			int_vref_mv;
 
 	struct ad_sigma_delta sd;
@@ -120,6 +122,9 @@ static int ad7780_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_OFFSET:
 		*val = -(1 << (chan->scan_type.realbits - 1));
 		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*val = st->odr;
+		return IIO_VAL_INT;
 	default:
 		break;
 	}
@@ -162,6 +167,7 @@ static int ad7780_write_raw(struct iio_dev *indio_dev,
 			val = 0;
 		else
 			val = 1;
+		st->odr = ad778x_odr_avail[val];
 		gpiod_set_value(st->filter_gpio, val);
 		break;
 	default:
@@ -181,8 +187,10 @@ static int ad7780_postprocess_sample(struct ad_sigma_delta *sigma_delta,
 	    ((raw_sample & chip_info->pattern_mask) != chip_info->pattern))
 		return -EIO;
 
-	if (chip_info->is_ad778x)
+	if (chip_info->is_ad778x) {
 		st->gain = ad778x_gain[raw_sample & AD7780_GAIN];
+		st->odr = ad778x_odr_avail[raw_sample & AD7780_FILTER];
+	}
 
 	return 0;
 }
@@ -194,17 +202,19 @@ static const struct ad_sigma_delta_info ad7780_sigma_delta_info = {
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

