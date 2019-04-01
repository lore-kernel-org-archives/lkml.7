Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF83C4360F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 14:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99524208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 14:37:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kkE+/4D0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728664AbfDAOhv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 10:37:51 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43730 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbfDAOhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 10:37:51 -0400
Received: by mail-qt1-f196.google.com with SMTP id v32so10800269qtc.10;
        Mon, 01 Apr 2019 07:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=PARVC6Esn0ng0MgzKkk8CbB71tIia3GiyvmWBdVRh18=;
        b=kkE+/4D0fxOQt6aZzn/NG4ADZZwkz/5C9RQkNgvsQJ6Q2vVJQM4scHDLwQQ2Pr8pnK
         +X/I1iP8wYWd81SwgkKW+sEfAabcqtwIz1gsuAbU3Go3CAn/OoNLJIYbeOPcdyA/miJe
         BAq2TkRExyVSY37yjpM3xSGYO76Mf3RBw+Q1DHY+sz6qPcr864Nt8bIOKV1mR9DHDrdI
         8FLYVCegNkYpWQ/GrwPRVBm1Z9RY5V0EADJv0osrSfvrGH98FpmaCwraGYzugYqLZ+5B
         fZ/l2Lf2I3e4oNMh/tpTRm5KVnDBMiwCkM+K99yV9CMiE0Y9r0i5ho8QthLvDdkhc7CX
         jvAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=PARVC6Esn0ng0MgzKkk8CbB71tIia3GiyvmWBdVRh18=;
        b=jZKmXyBYwh6QNBwirqaPiMgnLSSvay982/dch2cVI135+FxkoYYv61BwaBF1kdMv5E
         wQWbP+1nG/0cANADUTaT8haLUAaGV1OMB01przIsm+DHtm4vpSMoIh1WxYY2XkXpenXy
         0HgeWGQTidYqmN8ulIqZkR3zEGj8tQGrndbsBc7pXh5fKHCbSNVppScqcovnu5QCFgv/
         RSJ0yQcP0LsvLOWPp3M6CX5WvsgneOfN6MLF8KNxVAaDbbORetP5rLUJDpcm2s/GNuSU
         s2gWahR88gpQ8etGB6RXsoK5U7uhEfe+an3YpL7T/Aq1eUHHR9LlC8i/9OyQe3IQYFN8
         CmLw==
X-Gm-Message-State: APjAAAU3Xot5yNq+NO2ucnJ/WWniLklfGoCotmpnh2ipIpP8Ky6SD1SF
        GjqR+QqWWt6eFPxDCmCqHu9+5tyolgM=
X-Google-Smtp-Source: APXvYqwbWsnIV4jyWaJjwrGtAeeJtjVYTRtG5QLsEU1YEj+rjYUSwcU+0dlkyXeIZtv5TnV8vBj5Cw==
X-Received: by 2002:a0c:99df:: with SMTP id y31mr49524913qve.171.1554129469907;
        Mon, 01 Apr 2019 07:37:49 -0700 (PDT)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id 75sm5611136qke.32.2019.04.01.07.37.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 01 Apr 2019 07:37:49 -0700 (PDT)
Date:   Mon, 1 Apr 2019 11:37:45 -0300
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com,
        stefan.popa@analog.com, jic23@kernel.org, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH 3/4] staging: iio: ad9832: use clock framework for clock
 reference
Message-ID: <20190401143745.ooxttvazrlqe2lcc@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously external clock were set through platform_data struct.
Now device uses clk struct defined in include/linux/clk.h to handle
external clock source.
It also removes mclk from platform_data struct.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
---
 drivers/staging/iio/frequency/ad9832.c | 37 +++++++++++++++++---------
 drivers/staging/iio/frequency/ad9832.h |  1 -
 2 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
index d8d4a7936275..74308a2e72db 100644
--- a/drivers/staging/iio/frequency/ad9832.c
+++ b/drivers/staging/iio/frequency/ad9832.c
@@ -7,6 +7,7 @@
 
 #include <asm/div64.h>
 
+#include <linux/clk.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/kernel.h>
@@ -95,7 +96,7 @@ struct ad9832_state {
 	struct spi_device		*spi;
 	struct regulator		*avdd;
 	struct regulator		*dvdd;
-	unsigned long			mclk;
+	struct clk			*mclk;
 	unsigned short			ctrl_fp;
 	unsigned short			ctrl_ss;
 	unsigned short			ctrl_src;
@@ -130,10 +131,10 @@ static int ad9832_write_frequency(struct ad9832_state *st,
 {
 	unsigned long regval;
 
-	if (fout > (st->mclk / 2))
+	if (fout > (clk_get_rate(st->mclk) / 2))
 		return -EINVAL;
 
-	regval = ad9832_calc_freqreg(st->mclk, fout);
+	regval = ad9832_calc_freqreg(clk_get_rate(st->mclk), fout);
 
 	st->freq_data[0] = cpu_to_be16((AD9832_CMD_FRE8BITSW << CMD_SHIFT) |
 					(addr << ADD_SHIFT) |
@@ -334,7 +335,16 @@ static int ad9832_probe(struct spi_device *spi)
 		goto error_disable_avdd;
 	}
 
-	st->mclk = pdata->mclk;
+	st->mclk = devm_clk_get(&spi->dev, "mclk");
+	if (IS_ERR(st->mclk)) {
+		ret = PTR_ERR(st->mclk);
+		goto error_disable_dvdd;
+	}
+
+	ret = clk_prepare_enable(st->mclk);
+	if (ret < 0)
+		goto error_disable_dvdd;
+
 	st->spi = spi;
 	mutex_init(&st->lock);
 
@@ -385,39 +395,41 @@ static int ad9832_probe(struct spi_device *spi)
 	ret = spi_sync(st->spi, &st->msg);
 	if (ret) {
 		dev_err(&spi->dev, "device init failed\n");
-		goto error_disable_dvdd;
+		goto error_unprepare_mclk;
 	}
 
 	ret = ad9832_write_frequency(st, AD9832_FREQ0HM, pdata->freq0);
 	if (ret)
-		goto error_disable_dvdd;
+		goto error_unprepare_mclk;
 
 	ret = ad9832_write_frequency(st, AD9832_FREQ1HM, pdata->freq1);
 	if (ret)
-		goto error_disable_dvdd;
+		goto error_unprepare_mclk;
 
 	ret = ad9832_write_phase(st, AD9832_PHASE0H, pdata->phase0);
 	if (ret)
-		goto error_disable_dvdd;
+		goto error_unprepare_mclk;
 
 	ret = ad9832_write_phase(st, AD9832_PHASE1H, pdata->phase1);
 	if (ret)
-		goto error_disable_dvdd;
+		goto error_unprepare_mclk;
 
 	ret = ad9832_write_phase(st, AD9832_PHASE2H, pdata->phase2);
 	if (ret)
-		goto error_disable_dvdd;
+		goto error_unprepare_mclk;
 
 	ret = ad9832_write_phase(st, AD9832_PHASE3H, pdata->phase3);
 	if (ret)
-		goto error_disable_dvdd;
+		goto error_unprepare_mclk;
 
 	ret = iio_device_register(indio_dev);
 	if (ret)
-		goto error_disable_dvdd;
+		goto error_unprepare_mclk;
 
 	return 0;
 
+error_unprepare_mclk:
+	clk_disable_unprepare(st->mclk);
 error_disable_dvdd:
 	regulator_disable(st->dvdd);
 error_disable_avdd:
@@ -432,6 +444,7 @@ static int ad9832_remove(struct spi_device *spi)
 	struct ad9832_state *st = iio_priv(indio_dev);
 
 	iio_device_unregister(indio_dev);
+	clk_disable_unprepare(st->mclk);
 	regulator_disable(st->dvdd);
 	regulator_disable(st->avdd);
 
diff --git a/drivers/staging/iio/frequency/ad9832.h b/drivers/staging/iio/frequency/ad9832.h
index 39d326cc1af9..032579a2d539 100644
--- a/drivers/staging/iio/frequency/ad9832.h
+++ b/drivers/staging/iio/frequency/ad9832.h
@@ -24,7 +24,6 @@
  */
 
 struct ad9832_platform_data {
-	unsigned long		mclk;
 	unsigned long		freq0;
 	unsigned long		freq1;
 	unsigned short		phase0;
-- 
2.20.1

