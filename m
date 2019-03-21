Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB22C10F00
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 659E2218A2
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:42:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="twy3554f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728710AbfCUSmU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 14:42:20 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33995 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728057AbfCUSmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 14:42:20 -0400
Received: by mail-qt1-f196.google.com with SMTP id k2so7835159qtm.1;
        Thu, 21 Mar 2019 11:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ltjl7E72+nNQVwJY+fki1b6GYqXLv0mNiGTh0otxJDQ=;
        b=twy3554fQqQHbILaqZTRW0eyX2R5FODLxHKQ8P84Dn83xot69soDJ3i0IDcBkjEsce
         q8ur/C626AcXUyPcW95xC3U8E2V/1z1qh8BCHBl1XUOZnKEpZmKQp1uV8C5SkLe0285q
         8jg4/notB9NGNs4aKfXBMLSfyPejoRpj9Xv9JNtgFfV32DZdlBMJgDQu4VrDXbmK7/cI
         Qz0aVomR6OeuA/ojbzsvMTJ/BRv1TAcTthWPZ1AHi3BJARUsYs18bCLraIqMOeQOTi/r
         TeyruWDCAzVvIxzNnfy4fx/nFrLw4SOYErVmrFVE5+g/SXkH1qnLQvrbshAIQx0tz7qz
         GxsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ltjl7E72+nNQVwJY+fki1b6GYqXLv0mNiGTh0otxJDQ=;
        b=jhRnhOEwuBsAXQeh9sJ2AL7AoR0C9igMlJOdYWU5AZBMODcb3yF+ge1BwFWoTWKZXQ
         csfaqCmyGl/Z9dYfaRKSLjWp7GMllX7y8beZnZuGqnYIMvTaCgXR9xIDlvci8DcdecT2
         2sy7BQhpiWfcr4xWNCe9CnErNCytd053iKLWSSaXczuElxWohFTHT84JvLeEN+gj2cqr
         RJgYN6JGBTEFTKrdPH2mKqp7Ml81Zc1vEZbmmHtPP0VR1zD5v7fh3uoH/aMElwKapBbs
         hyXzbVbUQT0RKqPlRL0aAnOJ99FvNZMyQWlbwItRJoytlUQ6/OQhILs1nglPkKQ79ZSV
         jurw==
X-Gm-Message-State: APjAAAVeFFO6U22qEa8Wf1iqQEbyChSpqMOUiAD866D1EfmFm7oCeqGS
        5BQ0oYsq93XS8GDW1sxwLDQ=
X-Google-Smtp-Source: APXvYqyZUWsuR0Oov/4cAEPZ/TipT4RYynwRmRrze75rOIFdkj2wiUEOa2mjVxRGWhmtIUkkKcl2fg==
X-Received: by 2002:ac8:1481:: with SMTP id l1mr4436538qtj.226.1553193737977;
        Thu, 21 Mar 2019 11:42:17 -0700 (PDT)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id d21sm1341838qtc.91.2019.03.21.11.42.14
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 21 Mar 2019 11:42:17 -0700 (PDT)
Date:   Thu, 21 Mar 2019 15:42:13 -0300
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     lars@metafoo.de, jic23@kernel.org, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        michael.hennerich@analog.com, stefan.popa@analog.com,
        alexandru.Ardelean@analog.com
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH v5 1/2] staging: iio: ad5933: change attributes to match ABI
Message-ID: <9a40e23e3eff477dc93c01b33a0e36751a44c0ea.1553192834.git.marcelo.schmitt1@gmail.com>
References: <cover.1553192834.git.marcelo.schmitt1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1553192834.git.marcelo.schmitt1@gmail.com>
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
 .../staging/iio/impedance-analyzer/ad5933.c   | 24 +++++++++----------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index d75bdfbf93de..2b0f8f899e3f 100644
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
@@ -443,12 +443,12 @@ static ssize_t ad5933_store(struct device *dev,
 	return ret ? ret : len;
 }
 
-static IIO_DEVICE_ATTR(out_voltage0_scale, 0644,
+static IIO_DEVICE_ATTR(out_altvoltage0_raw, 0644,
 			ad5933_show,
 			ad5933_store,
 			AD5933_OUT_RANGE);
 
-static IIO_DEVICE_ATTR(out_voltage0_scale_available, 0444,
+static IIO_DEVICE_ATTR(out_altvoltage0_scale_available, 0444,
 			ad5933_show,
 			NULL,
 			AD5933_OUT_RANGE_AVAIL);
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

