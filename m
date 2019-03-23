Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F23EC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 12:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E28F21902
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 12:54:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WBz/0PDl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbfCWMyN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 08:54:13 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38832 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727611AbfCWMyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 08:54:09 -0400
Received: by mail-wm1-f65.google.com with SMTP id a188so4574960wmf.3;
        Sat, 23 Mar 2019 05:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ny71xhOGKsck3wpcdPBhP3pC5AeNrCyXceAXSaqpWV8=;
        b=WBz/0PDlUgA2ECXOSSHZXIPUaWwVtFzg0myjIblAWt2Golzknk3QteHBMMX7TcFSK7
         9hE7VqzsX5MbfFnBUvGKcOEkiZWSFK3jn4U7bo9+rqNmMHGEa1i5k9XCwzBdyDYnY2QE
         gBpeGAzFctz4LeXd5dl+SJiuns5ZL0DvN3ia1ADhOkdDPlDIqMSBhDvrjkpxb+OJKxFk
         1YS/T/YZKd0AYtwdU2bW9oF8cvZK9GAYcrN3xRC3gKRocgGoZ5V7ByERJe5k6bJZd9Es
         Oxnreofp61hIy609tRjDhMK7AveOn6l83Pp3S/Icp71/qjlpoq38hN8mXEHoglmKFBKU
         HPFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ny71xhOGKsck3wpcdPBhP3pC5AeNrCyXceAXSaqpWV8=;
        b=iXZTPvN0Ac65pYCHgqNM16M/WTBrmj9MDh1W6LgcLCbalZjMjAm0ZMxHjdMPzHLF9C
         VLb+bOi7nnFIOi1L+ypO11QICV+9g9L3J1tRpQ4s4ooXBOijqOPlq93hjGBci/uufshB
         phKaVyc9kVBnV4/DjtvzBcWUV11gRcGAaOp842/vPKXwYjKa1jJjOQR05++FZEI0xauy
         yZl6wiS3LFDXb4oTi+SG8Z7iRIqtMsbsHE2k3Rr13DHBeqyTPCtLZayRAteYEb4Ix1ac
         Od4Csx5w/8z3tIkWhC8NPL0Hst5UdvJ7AWjcSFF+8xvQqwFhdOp9wVLgj1koyBAZwI9D
         rUCg==
X-Gm-Message-State: APjAAAW2DKJCicQLbaiH6dpVFwoLGG1ShmE0NamEpZRMKR1umQDxa8Cl
        ncDuP87HaCT6xfkBH4LcWZ8=
X-Google-Smtp-Source: APXvYqwVkAPBd1qBtMr+LfOAAJ8T7C5UMV7lcvUnd5ecz9x21hmsdORO8nd2bp5XjRV8QLgthjZYZg==
X-Received: by 2002:a1c:3543:: with SMTP id c64mr1922wma.75.1553345646908;
        Sat, 23 Mar 2019 05:54:06 -0700 (PDT)
Received: from peano ([87.19.116.42])
        by smtp.gmail.com with ESMTPSA id r6sm10582987wrx.48.2019.03.23.05.54.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Mar 2019 05:54:06 -0700 (PDT)
Date:   Sat, 23 Mar 2019 13:54:05 +0100
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
Subject: [PATCH 5/5] staging: iio: adc: Remove CamelCase notation
Message-ID: <e1a9e28d72babe4781c577c68e6508e01367943f.1553335775.git.sicilia.cristian@gmail.com>
References: <cover.1553335775.git.sicilia.cristian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1553335775.git.sicilia.cristian@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Cristian Sicilia <sicilia.cristian@gmail.com>
---
 drivers/staging/iio/adc/ad7280a.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
index 5d848aa..c02454c 100644
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

