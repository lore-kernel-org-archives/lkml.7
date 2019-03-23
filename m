Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0615FC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 19:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0ED3218D4
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 19:21:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dfVY3eU5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbfCWTVl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 15:21:41 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33321 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727544AbfCWTVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 15:21:40 -0400
Received: by mail-wr1-f67.google.com with SMTP id q1so5855991wrp.0;
        Sat, 23 Mar 2019 12:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VUDfVjt25B5iuZ8LRf+UQ/eDY99yvTEQdrmA2/dK4O0=;
        b=dfVY3eU5LrTwh7ElvVTG1eYwv6pF2EYNK4m5QW20DYRisY6eMv48Gj4Km1luQb3qYC
         uzatxKFFCltCzVlWb5vuTt4H6TISxx06JmnjPRacznqetQ1+WKn8OcWd9hy6ZhN9zaq/
         udOuRzlqfBeRYYea/ILiOiPb+qXj1NNL2mO2Dq8Rj2midDXWGNJTxy3F7lj5+uu5VHDo
         quAZMlp9strreOWObr7jqRoie1BQdWxZ1vK9AEi9mjZWOxJuJ4fQUIXPS02mxUPRE1mq
         GfKejtByLTvyXLBvmpvDAmCUQOYv9KDUpGCBS1wS1VZQVLNJqtnJFgHYnZyY/jU6mJV5
         HO0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VUDfVjt25B5iuZ8LRf+UQ/eDY99yvTEQdrmA2/dK4O0=;
        b=iWCf1SBl3Tmw8ly1sH4Zi9bBUQeOqarOzbVwiIyCFtBLnc+nkdf25r9vZYhHlxJvOQ
         vljvF3FIbufq+52jzF6va9a+qlXAiY5JTSh7KHzym5RifVqmFzT1El794rQIDS2jJeIh
         StftjyqX1bEpKeomLdJXH9nyxFRER9s7OwurIbG9duevBjfLITbkixLPl5wxpsmpwBrh
         rF/Xv3cb+WFwi+AC+TIgwhm4ALznSAcIBPOV5PHaTw7c7M8CBB2zX7gpDUeZp5LbrwL7
         sAPUlnQXM+XP93tH506gLqv/AGLSraS3p3bfTJLrDFb2ZnA7i4pk9xEzTXg7yuEES4Em
         cZkw==
X-Gm-Message-State: APjAAAUUHctTWS9vZojlYOuRsye9UAbSzUPHhxmaj2NHPUieEA1h5jvL
        Rqgg7mdM6qt4Y9f3R5X1BKk=
X-Google-Smtp-Source: APXvYqwjK18P6DxmBF6I3pUoL4KC56qOiw3dqrrGjTH1J08vTorfnRd8azS5AxFzBkM+PDhU/I/PFw==
X-Received: by 2002:a5d:4606:: with SMTP id t6mr10423932wrq.43.1553368897714;
        Sat, 23 Mar 2019 12:21:37 -0700 (PDT)
Received: from peano ([87.19.116.42])
        by smtp.gmail.com with ESMTPSA id d16sm9944689wru.49.2019.03.23.12.21.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Mar 2019 12:21:37 -0700 (PDT)
Date:   Sat, 23 Mar 2019 20:21:36 +0100
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
Subject: [PATCH v2 1/5] staging: iio: adc: Tab alignment
Message-ID: <70101e0eaa253140218d833223e0862d8851c01d.1553366098.git.sicilia.cristian@gmail.com>
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

