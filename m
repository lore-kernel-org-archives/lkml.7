Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35211C3A59E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 14:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08BD0214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 14:11:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="T+dL1ssF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730215AbfHTOLx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 10:11:53 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52550 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730029AbfHTOLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 10:11:50 -0400
Received: by mail-wm1-f66.google.com with SMTP id o4so2770769wmh.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 07:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=2gZBRBMoTtxBnUUQUMgmv/Co/uEPvWKvt1ic6Ud7+dk=;
        b=T+dL1ssFUIdUpMoMpCYeZxUeiYq6z0OFcwvolNe82M9FDXIvwx3RQReCIltmCEmMJs
         CWQ9N6YCwiVWz3YuzcWScw0ucrDUqV4yBV/gMjdrs8gCf2vLS0OeL7nqzIaGv1qv4eB5
         CQajQ5HQnoPDQuiHoe6B7FasPlJ7H5Lc4If3L5eF4106Ph7TG23A/82ygoGBcG5QORn6
         XsqIqe9t6bQwW4YQgunnIU6F7lJ9QeDIZAcRCW1/fj1Z3vRHi9blAaA71KxYr/ZNyqIA
         GuVxjecw1ovnLWvKQLffYzgkD36p+LAh8q9218offxYuAK5SnX3u1uElq1vpV0GjTITW
         L8EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:in-reply-to:references;
        bh=2gZBRBMoTtxBnUUQUMgmv/Co/uEPvWKvt1ic6Ud7+dk=;
        b=FkRpbv3U9LkDkmdFJ3keNM+oVDidqNOTlhh29dO9Oy4itloy3N4g8pTHcDnEs4e+Br
         LxSdtG9O0ST/pBEX3E3ykzmTUT0KKw7wwqfNbr8dK2F5ojxqWN0xNI/9AE2uarbw3AzI
         fld2vjsBsCqYoJIeZPosv4HRqyXDeTNVuxn02Yqiqz40CmAas/N0WGcqcCrvsunLQImG
         w1Y+GEaSvBHQXRn8dgjVZ3tmFwcMqiG+bYcVD2BvDTFz8B5u4ZNM2eMPBNuvuQE7xznH
         RVgZXlnObKaDOBniAL1KHBPV6r04RwVpqTcKK6ReJQY+ln79eRmCByzyh90EGS/SnGGj
         /F/g==
X-Gm-Message-State: APjAAAWiHPFcL/k+swGjk70lqCiuqO47+97GbieUyBnXzqHgZQaAE/Vu
        YKJv4Qbvx3nOKUY6oQYwISZxw2GDM/nayA==
X-Google-Smtp-Source: APXvYqwOpXWWfQkrSmxlW+dDzFrwROAmgDH8mO7cWLuxIpOZsMB3v+78Zw7sxK75f9hByv/fW7dNqQ==
X-Received: by 2002:a1c:9ec5:: with SMTP id h188mr221409wme.176.1566310308440;
        Tue, 20 Aug 2019 07:11:48 -0700 (PDT)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id f10sm13960332wrs.22.2019.08.20.07.11.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Aug 2019 07:11:47 -0700 (PDT)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, linux@roeck-us.net
Cc:     Colin Ian King <colin.king@canonical.com>,
        linux-iio@vger.kernel.org,
        =?UTF-8?q?Stefan=20Br=C3=BCns?= <stefan.bruens@rwth-aachen.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>
Subject: [PATCH 1/4] iio: adc: ina2xx: Define *device_node only once
Date:   Tue, 20 Aug 2019 16:11:38 +0200
Message-Id: <c13fb8284b68cf3dbe309941d767aa7701aa4c3a.1566310292.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1566310292.git.michal.simek@xilinx.com>
References: <cover.1566310292.git.michal.simek@xilinx.com>
In-Reply-To: <cover.1566310292.git.michal.simek@xilinx.com>
References: <cover.1566310292.git.michal.simek@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no reason to c&p full client->dev.of_node link when simple
variable can keep it.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/iio/adc/ina2xx-adc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
index bdd7cba6f6b0..37058d9c2054 100644
--- a/drivers/iio/adc/ina2xx-adc.c
+++ b/drivers/iio/adc/ina2xx-adc.c
@@ -951,6 +951,7 @@ static int ina2xx_probe(struct i2c_client *client,
 	struct ina2xx_chip_info *chip;
 	struct iio_dev *indio_dev;
 	struct iio_buffer *buffer;
+	struct device_node *np = client->dev.of_node;
 	unsigned int val;
 	enum ina2xx_ids type;
 	int ret;
@@ -970,7 +971,7 @@ static int ina2xx_probe(struct i2c_client *client,
 		return PTR_ERR(chip->regmap);
 	}
 
-	if (client->dev.of_node)
+	if (np)
 		type = (enum ina2xx_ids)of_device_get_match_data(&client->dev);
 	else
 		type = id->driver_data;
@@ -978,7 +979,7 @@ static int ina2xx_probe(struct i2c_client *client,
 
 	mutex_init(&chip->state_lock);
 
-	if (of_property_read_u32(client->dev.of_node,
+	if (of_property_read_u32(np,
 				 "shunt-resistor", &val) < 0) {
 		struct ina2xx_platform_data *pdata =
 		    dev_get_platdata(&client->dev);
@@ -1016,7 +1017,7 @@ static int ina2xx_probe(struct i2c_client *client,
 
 	indio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_SOFTWARE;
 	indio_dev->dev.parent = &client->dev;
-	indio_dev->dev.of_node = client->dev.of_node;
+	indio_dev->dev.of_node = np;
 	if (id->driver_data == ina226) {
 		indio_dev->channels = ina226_channels;
 		indio_dev->num_channels = ARRAY_SIZE(ina226_channels);
-- 
2.17.1

