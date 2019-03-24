Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C654FC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 17:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 905E82147C
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 17:23:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="usrzeBtE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729065AbfCXRX1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 13:23:27 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33575 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728976AbfCXRXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 13:23:18 -0400
Received: by mail-wr1-f67.google.com with SMTP id q1so7536397wrp.0;
        Sun, 24 Mar 2019 10:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VSrWlhZI5rKomQQ2LMNh0b/eN6lWObzzLNIGhl6mBdY=;
        b=usrzeBtEFYphwm2m2tNvl8jkv3CTRw7+cTNT/ZYsWfdLjFA28wojeyU4Upn62GBj5T
         /ENX8IUU/9wncLuJGoTgTqregDbaWiUmfSW0pt7Smhv5GyhKRP/RleNVQPIJaqTtM2qz
         SFRpITBkcky/BgdyTmxm6DpDYf6tG2ZL/oxnZot83zNTNBVoCnwGjlm4McZ4vZxjgV7i
         Ce8L2vsCpygow8++ZxRq/mCN+ZsWlXRUv5Y/O9A9+pCHmPJcXCwexP+4toeG1NbB3BU/
         m9HMmzlkZZvxZtuN3ATNijDHTZV0FyoUuWyqx1CwByQwChe8+QpzEMQlJupHHNE3B9Cd
         fdNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VSrWlhZI5rKomQQ2LMNh0b/eN6lWObzzLNIGhl6mBdY=;
        b=mX4it2YTtIBBn2xkUh1O84SaH0lXgL2Wy+ZIUcXHCi5FjTx6QZ5VER1UG4wPi1o7hj
         X3qPtNDJ9J8PqabFD5SaE+5uciwubPX3GO2EBguBNkgqeNv68fS/PFg/eAWJ3pBDOcVL
         JBuP8pfdWcUtcX3NxGBNPBvTTDzrCErgzbo4JsUNChW4fBb5n5SWVEE41RGTc/FMFq8M
         iuOWIaaozH/iB5nXDUJJ/kXY9VplSTKvAi3Tnz2i6lTKIRZltZpBQKfuW/ixwm1/MUH8
         eweTVee2LREOvGiT3hH17fHnyTm1McyeaCto7OQYNxx1F0D1w0Uz/v7OakmELfGzeUpw
         AF3g==
X-Gm-Message-State: APjAAAUy7tqwThxKGcMnMbKiH2L6cG484Sl9hpWeJ6fQoqc10wcDNSJ1
        gnhM5vdfnTHmVt9SxtGz/Ow=
X-Google-Smtp-Source: APXvYqyJYBwwz8JbSOWTXjP/oViCd3jMdQAVUXtSfOOSt4bBz4uwlHpDkURuuRH8jAl7VFLeC0aA0A==
X-Received: by 2002:a5d:6101:: with SMTP id v1mr4561767wrt.222.1553448196531;
        Sun, 24 Mar 2019 10:23:16 -0700 (PDT)
Received: from peano ([87.19.116.42])
        by smtp.gmail.com with ESMTPSA id c18sm11005276wmk.47.2019.03.24.10.23.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2019 10:23:16 -0700 (PDT)
Date:   Sun, 24 Mar 2019 18:23:14 +0100
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
Subject: [PATCH v3 4/5] staging: iio: adc: ad7280a: Adding temp var to
 improve readability
Message-ID: <1d398f3efc0191776b3329f30742b07b6baaa530.1553447138.git.sicilia.cristian@gmail.com>
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

Creating a temporary variable to improve readability

Signed-off-by: Cristian Sicilia <sicilia.cristian@gmail.com>
---
 drivers/staging/iio/adc/ad7280a.c | 55 ++++++++++++++++++---------------------
 1 file changed, 25 insertions(+), 30 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
index c2391f6..4ff28f1 100644
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

