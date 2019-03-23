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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 002B2C4360F
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 12:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEC89218A2
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 12:58:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oFgP7SfO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbfCWM6Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 08:58:25 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34045 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbfCWM6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 08:58:25 -0400
Received: by mail-wr1-f68.google.com with SMTP id p10so5192656wrq.1;
        Sat, 23 Mar 2019 05:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VUDfVjt25B5iuZ8LRf+UQ/eDY99yvTEQdrmA2/dK4O0=;
        b=oFgP7SfO1X8+1TM3kr6Yc6KGNBfuAVRSCYcPHCKXJ/noJbyiyva17iXamZq3Gd5gH1
         4OYVXU0IRDoXmxKMisvWcJ79/XF94kOVRpw4ad0wHoBEACypK7kaM5XDKK6HJTaw8mQR
         6J87l/NTSaSFn20h+p5cb5c6M98QQGgK22U55gQ9NMT4TxkcX8M39ymuCiabLVltaXdt
         vfCdgzMqPM7f55C0TCsWjNJhSDnuOmjsi8wuk8i3COl+ntlP/zY8bHY5bcN+GaySFhkt
         IMV/9YpanVLXSUSEDg2fq5SdZrMvk/jNrWhd0ayu260WkxnGHtvXJJRfViW4T2k9k5bL
         E2gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VUDfVjt25B5iuZ8LRf+UQ/eDY99yvTEQdrmA2/dK4O0=;
        b=e/SILF85bnOgbacx5YFZZNpgt9xdUmtbsvtwyk4VfawdVajIYxfW0DrpOadizktHPf
         sFrmq/G31oYQZx/4OcbA5pPBKfmEyadulmeTWy9gPgRs+WmUqMbpBUMf2mcyGj+xVoQ0
         /sJj976RDMgytNWCjjdSQUdywdmqAypQOMcrbyVBdWq10p9ivb/UcyYFdtcJD3wXrupQ
         cWoXK5vHa75P+s+kVIx0NXdo8dk1I9IS9kyadhsnlpjhM2ceJ6dBWEy1uVe8OGky3W3P
         IL2QUggpi2pQKR4wpfy8bcvQTGeHElKLEL3UNvUfyUQiEP8F5hVHUlzjrksL4JOOO3CN
         yoEg==
X-Gm-Message-State: APjAAAVo5PwQ7K2T+lhAWp61uleoZlFiolhzSShkNy/9hoJTDLeIXQFo
        yHHLe5ME22HBDA6b4geQ4fM=
X-Google-Smtp-Source: APXvYqyaXkVwed/1F72vyi3T6fMrtXlwTftolrOcLFMnydPvj2DIX5Q0+n5q0WAiL6OdlEDJEICL+g==
X-Received: by 2002:adf:ee07:: with SMTP id y7mr9468401wrn.219.1553345903488;
        Sat, 23 Mar 2019 05:58:23 -0700 (PDT)
Received: from peano ([87.19.116.42])
        by smtp.gmail.com with ESMTPSA id z8sm10608970wrh.80.2019.03.23.05.58.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Mar 2019 05:58:22 -0700 (PDT)
Date:   Sat, 23 Mar 2019 13:58:21 +0100
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
Subject: [PATCH 1/5] staging: iio: adc: Tab alignment
Message-ID: <70101e0eaa253140218d833223e0862d8851c01d.1553335775.git.sicilia.cristian@gmail.com>
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

Aligned some parameters.

Signed-off-by: Cristian Sicilia <sicilia.cristian@gmail.com>
---
 drivers/staging/iio/adc/ad7280a.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
index d9df126..55b5879 100644
--- a/drivers/staging/iio/adc/ad7280a.c
+++ b/drivers/staging/iio/adc/ad7280a.c
@@ -830,30 +830,30 @@ static irqreturn_t ad7280_event_handler(int irq, void *private)
 }
 
 static IIO_DEVICE_ATTR_NAMED(in_thresh_low_value,
-		in_voltage-voltage_thresh_low_value,
-		0644,
-		ad7280_read_channel_config,
-		ad7280_write_channel_config,
-		AD7280A_CELL_UNDERVOLTAGE);
+			     in_voltage - voltage_thresh_low_value,
+			     0644,
+			     ad7280_read_channel_config,
+			     ad7280_write_channel_config,
+			     AD7280A_CELL_UNDERVOLTAGE);
 
 static IIO_DEVICE_ATTR_NAMED(in_thresh_high_value,
-		in_voltage-voltage_thresh_high_value,
-		0644,
-		ad7280_read_channel_config,
-		ad7280_write_channel_config,
-		AD7280A_CELL_OVERVOLTAGE);
+			     in_voltage - voltage_thresh_high_value,
+			     0644,
+			     ad7280_read_channel_config,
+			     ad7280_write_channel_config,
+			     AD7280A_CELL_OVERVOLTAGE);
 
 static IIO_DEVICE_ATTR(in_temp_thresh_low_value,
-		0644,
-		ad7280_read_channel_config,
-		ad7280_write_channel_config,
-		AD7280A_AUX_ADC_UNDERVOLTAGE);
+		       0644,
+		       ad7280_read_channel_config,
+		       ad7280_write_channel_config,
+		       AD7280A_AUX_ADC_UNDERVOLTAGE);
 
 static IIO_DEVICE_ATTR(in_temp_thresh_high_value,
-		0644,
-		ad7280_read_channel_config,
-		ad7280_write_channel_config,
-		AD7280A_AUX_ADC_OVERVOLTAGE);
+		       0644,
+		       ad7280_read_channel_config,
+		       ad7280_write_channel_config,
+		       AD7280A_AUX_ADC_OVERVOLTAGE);
 
 static struct attribute *ad7280_event_attributes[] = {
 	&iio_dev_attr_in_thresh_low_value.dev_attr.attr,
-- 
2.7.4

