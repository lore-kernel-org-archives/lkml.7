Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 525E6C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 19:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BDD22183E
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 19:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kf8I+1Jm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbfCWTVv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 15:21:51 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37362 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727544AbfCWTVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 15:21:49 -0400
Received: by mail-wr1-f67.google.com with SMTP id w10so5840940wrm.4;
        Sat, 23 Mar 2019 12:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UNX6DqWrbbVQKs40nVLxu3cNUe9PZN8vCebi9sI0jrE=;
        b=kf8I+1JmVgSyjktuio6doUoGCrZU9wYInsprBtF6Frm4VaDBDaCTJsjgRA1Mbfudry
         S3mJ2O1/nsKq6PDbSOgrLirT+DP4Jxvt2Saug4SQLHrifh9ThFE0rjMaPcslCCylF23x
         eD2AlnYemRT+L0HudujpLed6yaeDvp6GD8wN9/gi2IqilcEXDUOjtUzmZAbmEO12FIKz
         iQnCYCjD5Ji6R//2bgp2e1vT0kHmSCWZKVLLkUnygzRmL8TrjTccdx4yhwQ02WpiPMuc
         JZE1HxWJKkp8C0cV/RoBv83R3a+RN0sM4OAXY1CtiNPijDAf6LLhJ6atMuS3Pxz//3h1
         ysUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UNX6DqWrbbVQKs40nVLxu3cNUe9PZN8vCebi9sI0jrE=;
        b=piZj0HRnKa+FXuyJ9ocjwxGDLj/XhtoXiMnWv56heSS5W7MD+RjH76JTBSaTtofvr9
         ywCMaWxjuP4SjCfGDcbkgT/NSDIH95r3WYsvCprjHmJVr+3h7SkZ6Vo1DULsl2J6LQ6A
         XywMY36BpS7Mkt6JfDC6u4MPLX7AdIibYMHe9CC4vFklxWd33vfMPbe4iy/GSbI5LBnc
         lbhz/wiJZkenX7M4wsfKiR5jgEnGZfJugsEIxOmIET5xcAmXX2v7pVJ2po3ANxZSBZny
         idq9pK3XjU0K5WrJS9W+16QtrN5vH4c2tmE2CVXfznVuBMNBcALIbR7evcHbCADR9vO5
         cnvw==
X-Gm-Message-State: APjAAAXv1JbRLlfkNK7A65GZ2Y/smVqT1aLL0zZteSVb6oUfCjg+vFPw
        rYmj9JKVZnqrSFFmS1u7/a0PjSK9S6E=
X-Google-Smtp-Source: APXvYqzWCk9MZ1O2a1pFpPBgHO3NMJarhnR7GOTWgsYP6DyMRUmYa6ZUYSYTGKCSfvDrcQTtgwWezQ==
X-Received: by 2002:adf:f48d:: with SMTP id l13mr11367355wro.2.1553368907716;
        Sat, 23 Mar 2019 12:21:47 -0700 (PDT)
Received: from peano ([87.19.116.42])
        by smtp.gmail.com with ESMTPSA id b3sm14153024wmj.15.2019.03.23.12.21.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Mar 2019 12:21:47 -0700 (PDT)
Date:   Sat, 23 Mar 2019 20:21:45 +0100
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
Subject: [PATCH v2 4/5] staging: iio: adc: Adding temp var to improve
 readability
Message-ID: <82dd56df8d410ec91061ef51c2653345d7e30aa2.1553366098.git.sicilia.cristian@gmail.com>
References: <cover.1553335775.git.sicilia.cristian@gmail.com>
 <cover.1553366098.git.sicilia.cristian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1553366098.git.sicilia.cristian@gmail.com>
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

