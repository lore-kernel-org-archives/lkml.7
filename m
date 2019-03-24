Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C0CDC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 17:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38DAA2171F
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 17:23:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EZ2p5iRE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729046AbfCXRXW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 13:23:22 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36954 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729021AbfCXRXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 13:23:20 -0400
Received: by mail-wm1-f67.google.com with SMTP id v14so6666453wmf.2;
        Sun, 24 Mar 2019 10:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fonDLlUdPKo0ydLHxZzaMjKAd7fvMqbYiYkKPyuQhkM=;
        b=EZ2p5iREB4YKYVhGy3eJX7CgB7yK4ACnDIoucOSCDmf5I4CxvJifsrMRlZjDGFVi4A
         X1gxg15tswFyy+aIS2NQZH9jy3vffcblP4Y3/roA1fbDiiEfv1N+0uXHbQ3lqTGYKF69
         2lkjSO7eVYB0UF6HZRZ1cEqf+rFPq2bPa9FyB38N0HX7cVEwNx1pEYeILKjN6Q5OC004
         XsEFNaV3gBYz7ZHO092kxppf67kVL/ThaKSzJ/pIiC+QrHZgHdxoCrsUSldiQPIUZ/7d
         4hd8LyXfWIzQK0KNoyIj2gy84VgdK0RiiunmNdJtG8xPRVsWVhzU8sqvONpEzpN1wvCO
         Smsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fonDLlUdPKo0ydLHxZzaMjKAd7fvMqbYiYkKPyuQhkM=;
        b=UxoIqj8f85nLO5jl2oSKepAHiiVhtt1Pyl/Qn7Y5DcTfOtilMVr0pyi8F/1SbzkCWP
         Vw6GlubsCQrA89plaPTDXM3iGQxvzHzb+aWae9n4meEMh2Zud5c/ugwrMbN2k+S5PlAo
         sETpa5D20rRNkIWYa6FWdeZntZK5J7Ig2yrM9e5OetxxVg05JxceP4dN2oM76gvyrnqW
         BpNCLX6Z3pVKjaUbF276jEPLuXJBcxyRSTTvV58uOZsDkKUW5ABZWpCASkHBS5LpujC1
         9/4DevjGPJbTAaEdqtj3nNZ+ADO7UiouHdGR6IxUs1d7jOx6u56s3JGS39+pfTKQkhGx
         p1Zg==
X-Gm-Message-State: APjAAAV6K5wyVBuMwphydOaUJ63uvEIW5zlKgsx5/ai/1lShV+GtrKKs
        sUoO9zzmzYSw1EaFJ9NQSDs=
X-Google-Smtp-Source: APXvYqx1JRHeWENbo2k+QPUqD1A+5T1/uhJYNd5PCv2Jny0Vdb0lycUFO6FkakUrWuKgpSY9VFct1g==
X-Received: by 2002:a7b:cd9a:: with SMTP id y26mr3185149wmj.31.1553448198232;
        Sun, 24 Mar 2019 10:23:18 -0700 (PDT)
Received: from peano ([87.19.116.42])
        by smtp.gmail.com with ESMTPSA id 61sm15784692wre.50.2019.03.24.10.23.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2019 10:23:17 -0700 (PDT)
Date:   Sun, 24 Mar 2019 18:23:16 +0100
From:   Cristian Sicilia <sicilia.cristian@gmail.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/5] staging: iio: adc: ad7280a: Remove CamelCase notation
Message-ID: <e1f26b39dd421d848d5579bd5540644e71416edb.1553447138.git.sicilia.cristian@gmail.com>
References: <cover.1553366098.git.sicilia.cristian@gmail.com>
 <cover.1553447138.git.sicilia.cristian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1553447138.git.sicilia.cristian@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix CamelCase naming.

Signed-off-by: Cristian Sicilia <sicilia.cristian@gmail.com>
---
 drivers/staging/iio/adc/ad7280a.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
index 4ff28f1..229dcad 100644
--- a/drivers/staging/iio/adc/ad7280a.c
+++ b/drivers/staging/iio/adc/ad7280a.c
@@ -917,8 +917,8 @@ static int ad7280_probe(struct spi_device *spi)
 	const struct ad7280_platform_data *pdata = dev_get_platdata(&spi->dev);
 	struct ad7280_state *st;
 	int ret;
-	const unsigned short tACQ_ns[4] = {465, 1010, 1460, 1890};
-	const unsigned short nAVG[4] = {1, 2, 4, 8};
+	const unsigned short t_acq_ns[4] = {465, 1010, 1460, 1890};
+	const unsigned short n_avg[4] = {1, 2, 4, 8};
 	struct iio_dev *indio_dev;
 
 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
@@ -966,10 +966,9 @@ static int ad7280_probe(struct spi_device *spi)
 	 */
 
 	st->readback_delay_us =
-		((tACQ_ns[pdata->acquisition_time & 0x3] + 695) *
-		(AD7280A_NUM_CH * nAVG[pdata->conversion_averaging & 0x3]))
-		- tACQ_ns[pdata->acquisition_time & 0x3] +
-		st->slave_num * 250;
+		((t_acq_ns[pdata->acquisition_time & 0x3] + 695) *
+		 (AD7280A_NUM_CH * n_avg[pdata->conversion_averaging & 0x3])) -
+		t_acq_ns[pdata->acquisition_time & 0x3] + st->slave_num * 250;
 
 	/* Convert to usecs */
 	st->readback_delay_us = DIV_ROUND_UP(st->readback_delay_us, 1000);
-- 
2.7.4

