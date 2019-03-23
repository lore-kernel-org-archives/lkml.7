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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B13FC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 12:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67B152054F
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 12:54:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sx7FEhC8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727597AbfCWMyE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 08:54:04 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37644 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbfCWMyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 08:54:02 -0400
Received: by mail-wr1-f67.google.com with SMTP id w10so5170407wrm.4;
        Sat, 23 Mar 2019 05:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UNX6DqWrbbVQKs40nVLxu3cNUe9PZN8vCebi9sI0jrE=;
        b=Sx7FEhC8P22RmYb9hJeQT3N+7v8btNt5x65Qot2+FRPRkGM9VmY8++jTDcTHTks3/e
         /rMuVpdHf3EXgzHXjE+/hIsN+WiNVyZpKBaMJr9SxapaqvQh7T4YWMGkjpoNUJdAd2hK
         MF4RcDp3R5/36kCghWAF02JjcBvtTmq4UnPAPkE7IL2avrWYkIiK6OUMZ798DeAiIuDg
         qv2qQ/hSrWHix5KEZdIXhx+OO2rYeB4KjmyIywEJTzkKbTOvGcDREA/XhLkAkosAGhGX
         jW+hnu7JcZ+xV+HkEmmROux4cZq1YGRjg+nWsQgaKcgmZLu9CZplmX9ddnyEU8tXe7ry
         vLMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UNX6DqWrbbVQKs40nVLxu3cNUe9PZN8vCebi9sI0jrE=;
        b=l2MUZyfmH+sBrBQzt49hgDA4hIp8iGHqJ5bEOGYP+6y2wxrSlfaN1UxGDTjg2vut4a
         EB7RwhKxo2LWf7gL14Jl5RxBoQp3kUxYaUnjLzVnIEoyJVzC9TEGcafS9cKuIv0YX3QM
         5fw0O3/aIJeNpkqCqIyuIWR4HDKtc+vl2RGWsFIYQvmeMsIUD+Rjej7dhuzCpK7jGxDG
         zzwgrIQtHxO238ga8B6gxlaE9Nd+jOrvfCIKF/H4zuo2NEsfT22cRFccGjrzh+GuB4/P
         H2kF0MYsU0iQdyerHXcAH+qtv+mq4tgCfsFMRSq+6bDu3+Bkpp7wWRyw8MhxbvgrQjgi
         oc9g==
X-Gm-Message-State: APjAAAU7pR9ByD6AXv3PPD89IWLcFHmSLlAX0LUhtdCHv/WoPdBQ9Jm3
        ElWG4CoDN/ocamLuQBLPRxQ=
X-Google-Smtp-Source: APXvYqwucmvO25qvcVWkA59H1DQvFpHTvoQWYmEQvUvJKgXAD3IUQ/TDPYI3uhVc5d66RccJBnwvCg==
X-Received: by 2002:a5d:49c1:: with SMTP id t1mr9358027wrs.220.1553345640410;
        Sat, 23 Mar 2019 05:54:00 -0700 (PDT)
Received: from peano ([87.19.116.42])
        by smtp.gmail.com with ESMTPSA id b134sm22255379wmd.26.2019.03.23.05.53.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Mar 2019 05:53:59 -0700 (PDT)
Date:   Sat, 23 Mar 2019 13:53:58 +0100
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
Subject: [PATCH 4/5] staging: iio: adc: Adding temp var to improve readability
Message-ID: <82dd56df8d410ec91061ef51c2653345d7e30aa2.1553335775.git.sicilia.cristian@gmail.com>
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

Creating a temporary variable to improve readability

Signed-off-by: Cristian Sicilia <sicilia.cristian@gmail.com>
---
 drivers/staging/iio/adc/ad7280a.c | 55 ++++++++++++++++++---------------------
 1 file changed, 25 insertions(+), 30 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
index d81a5bd..5d848aa 100644
--- a/drivers/staging/iio/adc/ad7280a.c
+++ b/drivers/staging/iio/adc/ad7280a.c
@@ -784,43 +784,38 @@ static irqreturn_t ad7280_event_handler(int irq, void *private)
 	for (i = 0; i < st->scan_cnt; i++) {
 		if (((channels[i] >> 23) & 0xF) <= AD7280A_CELL_VOLTAGE_6) {
 			if (((channels[i] >> 11) & 0xFFF) >=
-				st->cell_threshhigh)
-				iio_push_event(indio_dev,
-					       IIO_EVENT_CODE(IIO_VOLTAGE,
-							1,
-							0,
-							IIO_EV_DIR_RISING,
-							IIO_EV_TYPE_THRESH,
-							0, 0, 0),
+			    st->cell_threshhigh) {
+				u64 tmp = IIO_EVENT_CODE(IIO_VOLTAGE, 1, 0,
+							 IIO_EV_DIR_RISING,
+							 IIO_EV_TYPE_THRESH,
+							 0, 0, 0);
+				iio_push_event(indio_dev, tmp,
 					       iio_get_time_ns(indio_dev));
-			else if (((channels[i] >> 11) & 0xFFF) <=
-				st->cell_threshlow)
-				iio_push_event(indio_dev,
-					       IIO_EVENT_CODE(IIO_VOLTAGE,
-							1,
-							0,
-							IIO_EV_DIR_FALLING,
-							IIO_EV_TYPE_THRESH,
-							0, 0, 0),
+			} else if (((channels[i] >> 11) & 0xFFF) <=
+				   st->cell_threshlow) {
+				u64 tmp = IIO_EVENT_CODE(IIO_VOLTAGE, 1, 0,
+							 IIO_EV_DIR_FALLING,
+							 IIO_EV_TYPE_THRESH,
+							 0, 0, 0);
+				iio_push_event(indio_dev, tmp,
 					       iio_get_time_ns(indio_dev));
+			}
 		} else {
-			if (((channels[i] >> 11) & 0xFFF) >= st->aux_threshhigh)
-				iio_push_event(indio_dev,
-					       IIO_UNMOD_EVENT_CODE(
-							IIO_TEMP,
-							0,
+			if (((channels[i] >> 11) & 0xFFF) >=
+			    st->aux_threshhigh) {
+				u64 tmp = IIO_UNMOD_EVENT_CODE(IIO_TEMP, 0,
 							IIO_EV_TYPE_THRESH,
-							IIO_EV_DIR_RISING),
+							IIO_EV_DIR_RISING);
+				iio_push_event(indio_dev, tmp,
 					       iio_get_time_ns(indio_dev));
-			else if (((channels[i] >> 11) & 0xFFF) <=
-				st->aux_threshlow)
-				iio_push_event(indio_dev,
-					       IIO_UNMOD_EVENT_CODE(
-							IIO_TEMP,
-							0,
+			} else if (((channels[i] >> 11) & 0xFFF) <=
+				st->aux_threshlow) {
+				u64 tmp = IIO_UNMOD_EVENT_CODE(IIO_TEMP, 0,
 							IIO_EV_TYPE_THRESH,
-							IIO_EV_DIR_FALLING),
+							IIO_EV_DIR_FALLING);
+				iio_push_event(indio_dev, tmp,
 					       iio_get_time_ns(indio_dev));
+			}
 		}
 	}
 
-- 
2.7.4

