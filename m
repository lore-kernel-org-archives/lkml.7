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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96AB3C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 15:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6200F218E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 15:08:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WAAydMND"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbfCPPIB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 11:08:01 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39382 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbfCPPIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 11:08:00 -0400
Received: by mail-qt1-f196.google.com with SMTP id t28so13412264qte.6;
        Sat, 16 Mar 2019 08:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=QkDsX000mXzOHA9rU2Q24MGpb1izllLv6AOyp5o6NNk=;
        b=WAAydMNDZnQwzu7/BaYj2bSbl1yQnmurKptfGRP4rj1kR3PKJgwiQ8Yq7eZ9Rg9qtF
         dPypkZ0pogNAUSYUTdgOwnV4RLb8gMvMf3j9zd+c2tX0WVDAhdhf7i0jiwcrS5SgWral
         CgJPu+xvUxuAE8TwOAcOrV4xL9RIV5JMxidD2/yLjQkKB8JfY4EUjHT8v7k3vbL7uoKz
         /0DNUZ763RSkEY/z9ERGDktjDR+ntXInSZxpAFoUHdw/QQziuj25txFai59BZsl7+b+a
         zPg7cPezgrkmKQd/7/Q8RF3p23Yg9PBlaKbku2WA8YI01WZ49SN0vp3k8IHOYsO5M6Oz
         vCKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=QkDsX000mXzOHA9rU2Q24MGpb1izllLv6AOyp5o6NNk=;
        b=iD4GCCaMp+9K5ffFiBkcSmDuK7Y/g+Wm12BPD3mVggYwPDF5GMlWugMAuTqFh2BtLL
         5tCiBwc7dOwy2lc0ORCveoIr0IBDMIef1eBRjNp1N1NclOXYOWfjFfU3Mw7AdrneTpjz
         BsvJN+cy+PC6FPfyVVguARB7kEm8m22vgGJ6P54yY14t9vBVr6rBd6cwrcEg2DwYoO/P
         V7uX6ujkvgVOZkA5DHDtjtMzRqiUJtRb4eq6LldH/1LLDT4RaTfSB9Y1RVh9A4Ojm1L1
         4DylXajQyzWQPnLTvteBAEbrSGQ9kpYSsc9PA8Rk+6mXaw7fvc0QVQq2bi8d37VUfwMj
         HrQw==
X-Gm-Message-State: APjAAAW1ydQMJeOYLhjV9Qvrhn0joOAqpH+6R8DKDADW7NojinAHcw4s
        k1ycEdmfmz2m6cYcWGPfIlA=
X-Google-Smtp-Source: APXvYqzkAqmdb1Wmn2qDMCtKzm0cEsqd6ykyG5ybKjiRUIf927eYm6l8o7h1SD/fdUVlgRZW0B/bIw==
X-Received: by 2002:ac8:28a8:: with SMTP id i37mr7274393qti.215.1552748879200;
        Sat, 16 Mar 2019 08:07:59 -0700 (PDT)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id d17sm358360qtl.43.2019.03.16.08.07.57
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 16 Mar 2019 08:07:58 -0700 (PDT)
Date:   Sat, 16 Mar 2019 12:07:55 -0300
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com
Subject: [PATCH v4 6/7] staging: iio: ad5933: change attributes to match ABI
Message-ID: <20190316150755.ssqh5b2f55ln4fq5@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change device attributes' names to match ABI documentation. Names were
chosen such that they tend to be similar to existing ABI so it should
be easier to standardize them when necessary.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
---
 .../staging/iio/impedance-analyzer/ad5933.c   | 20 +++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index d75bdfbf93de..262415bc659d 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -315,12 +315,12 @@ static ssize_t ad5933_store_frequency(struct device *dev,
 	return ret ? ret : len;
 }
 
-static IIO_DEVICE_ATTR(out_voltage0_freq_start, 0644,
+static IIO_DEVICE_ATTR(out_altvoltage0_frequency_start, 0644,
 			ad5933_show_frequency,
 			ad5933_store_frequency,
 			AD5933_REG_FREQ_START);
 
-static IIO_DEVICE_ATTR(out_voltage0_freq_increment, 0644,
+static IIO_DEVICE_ATTR(out_altvoltage0_frequency_increment, 0644,
 			ad5933_show_frequency,
 			ad5933_store_frequency,
 			AD5933_REG_FREQ_INC);
@@ -463,12 +463,12 @@ static IIO_DEVICE_ATTR(in_voltage0_scale_available, 0444,
 			NULL,
 			AD5933_IN_PGA_GAIN_AVAIL);
 
-static IIO_DEVICE_ATTR(out_voltage0_freq_points, 0644,
+static IIO_DEVICE_ATTR(out_altvoltage0_frequency_points, 0644,
 			ad5933_show,
 			ad5933_store,
 			AD5933_FREQ_POINTS);
 
-static IIO_DEVICE_ATTR(out_voltage0_settling_cycles, 0644,
+static IIO_DEVICE_ATTR(out_altvoltage0_settling_cycles, 0644,
 			ad5933_show,
 			ad5933_store,
 			AD5933_OUT_SETTLING_CYCLES);
@@ -480,12 +480,12 @@ static IIO_DEVICE_ATTR(out_voltage0_settling_cycles, 0644,
  * don't create dedicated sysfs channel attributes for out0 and in0.
  */
 static struct attribute *ad5933_attributes[] = {
-	&iio_dev_attr_out_voltage0_scale.dev_attr.attr,
-	&iio_dev_attr_out_voltage0_scale_available.dev_attr.attr,
-	&iio_dev_attr_out_voltage0_freq_start.dev_attr.attr,
-	&iio_dev_attr_out_voltage0_freq_increment.dev_attr.attr,
-	&iio_dev_attr_out_voltage0_freq_points.dev_attr.attr,
-	&iio_dev_attr_out_voltage0_settling_cycles.dev_attr.attr,
+	&iio_dev_attr_out_altvoltage0_raw.dev_attr.attr,
+	&iio_dev_attr_out_altvoltage0_scale_available.dev_attr.attr,
+	&iio_dev_attr_out_altvoltage0_frequency_start.dev_attr.attr,
+	&iio_dev_attr_out_altvoltage0_frequency_increment.dev_attr.attr,
+	&iio_dev_attr_out_altvoltage0_frequency_points.dev_attr.attr,
+	&iio_dev_attr_out_altvoltage0_settling_cycles.dev_attr.attr,
 	&iio_dev_attr_in_voltage0_scale.dev_attr.attr,
 	&iio_dev_attr_in_voltage0_scale_available.dev_attr.attr,
 	NULL
-- 
2.20.1

