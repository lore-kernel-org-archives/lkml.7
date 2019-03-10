Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C27DC4360F
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 17:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3537220657
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 17:47:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tnKrfpKL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbfCJRrI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 13:47:08 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:38825 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbfCJRrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 13:47:08 -0400
Received: by mail-qk1-f195.google.com with SMTP id z3so1436522qkf.5;
        Sun, 10 Mar 2019 10:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=biGbN1qZKcjEQifkIF3WDWR9XJQqnSG1Zf6I9cTOXp0=;
        b=tnKrfpKLESda8h7QeJDNIhF0qktGsiutkzE9u6NzPr3A7gskNc8g2w2NNkUjOEDTOV
         BySVbbzm2/jRNsb4niOLHDFxi1Vd7hZqRkqEQqNZcqrK+0PKlNlyagvXkv5iytcg0enF
         9ZCq6shSrGm+DruBJspx+aHSOq31HavuwaU94pTctGjjVlEVEIrKEEm4Pt4XwZgJ260r
         AvUfmf0VXTBx7kobZJQoCC3yC09ZUFozKyUCPCUTAn27BkgzAdjDtIXndcRbFAH2rt3d
         b45HxoYAMzKhncl5u64aFvv0K33q8Riv07pHLXmq/xkpTftkBuYT78tRxz0pjzKTZgz2
         iCFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=biGbN1qZKcjEQifkIF3WDWR9XJQqnSG1Zf6I9cTOXp0=;
        b=cl2rHQGmOHG/1jeNX3oKECqx1LK2gz8h9sZZluN8Sr2qMqjnrfwNJrdRRWzrGzdm+l
         cJoalucoSFGlsy2LLnQIyMAF+8iDo9VVwGhvBEgEXvYFTeJGrA+rV+/FMVcPwNw3t2fF
         OOSyLz+nN8LBJVA8xtd151a1IgGOvXrwR1aPWJhAvPPqIUaMcS9THRqpIFbYgDhu1y3f
         uBO5XLb1fNlaSldBMcqb6XMPfRy9EJ/RanrAHHiC0lTLK7Onl7LJn1XN4/8Ak5yaIfGz
         MJK8cj4juVmQpRHrw1rXp2LP/IgVrTRAmq5v9FkQTlV6BdRM46EoX6SeFKNauVzqBcaT
         jnmQ==
X-Gm-Message-State: APjAAAWb3tulmHtMHkLjAUABXYTzZ4W3YO2HtdK1KvbKTMNKUCwdfIKN
        5neKZWQt5bEaMwJnGr4Qz3w=
X-Google-Smtp-Source: APXvYqxMXJ0pDgOKHaIH6ga5oK3sYevhKrt4rJYzyYa8CxP5qtZfepDxvyA810NKcuDXUQzVbu7o5A==
X-Received: by 2002:a37:4f45:: with SMTP id d66mr21671668qkb.81.1552240026919;
        Sun, 10 Mar 2019 10:47:06 -0700 (PDT)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id u13sm2285694qtb.2.2019.03.10.10.47.04
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 10 Mar 2019 10:47:06 -0700 (PDT)
Date:   Sun, 10 Mar 2019 14:47:02 -0300
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com
Subject: [PATCH v3 6/7] staging: iio: ad5933: change attributes' ABI call
Message-ID: <20190310174702.fko4xwrw5pclw6kr@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change device attributes to use more suitable ABI functions when setting
and displaying AC output excitation voltage. It better complies with
device hardware since these attributes are used to manage DDS
peak-to-peak output voltage.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
---
 drivers/staging/iio/impedance-analyzer/ad5933.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index d75bdfbf93de..314cb71b1b5a 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
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
@@ -480,8 +480,8 @@ static IIO_DEVICE_ATTR(out_voltage0_settling_cycles, 0644,
  * don't create dedicated sysfs channel attributes for out0 and in0.
  */
 static struct attribute *ad5933_attributes[] = {
-	&iio_dev_attr_out_voltage0_scale.dev_attr.attr,
-	&iio_dev_attr_out_voltage0_scale_available.dev_attr.attr,
+	&iio_dev_attr_out_altvoltage0_raw.dev_attr.attr,
+	&iio_dev_attr_out_altvoltage0_scale_available.dev_attr.attr,
 	&iio_dev_attr_out_voltage0_freq_start.dev_attr.attr,
 	&iio_dev_attr_out_voltage0_freq_increment.dev_attr.attr,
 	&iio_dev_attr_out_voltage0_freq_points.dev_attr.attr,
-- 
2.20.1

