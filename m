Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67FDCC4360F
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 05:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 375B4207E0
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 05:16:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="qpPwEAP5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbfCIFQI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 00:16:08 -0500
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:48306 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725613AbfCIFQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 00:16:08 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id E0DECD1B
        for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2019 05:16:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id yW9uHTYT8-cJ for <linux-kernel@vger.kernel.org>;
        Fri,  8 Mar 2019 23:16:06 -0600 (CST)
Received: from mail-it1-f199.google.com (mail-it1-f199.google.com [209.85.166.199])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id AEA18D44
        for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2019 23:16:06 -0600 (CST)
Received: by mail-it1-f199.google.com with SMTP id a184so8299491itc.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 21:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=RVQnwg/PYtBCBexaiykPWmElOOWGcv0g7rMf9iHb8VI=;
        b=qpPwEAP5EE9PkZsuh52KgNvt3IldLlkqlJVFgAeo7yWn4BMj/Q88CqSsNDPTUK6B1B
         1BQVfwJGCiE0qN1ynQ2MiHCkdj4wfnT5NrpIWTKQ1RTx4b7gP/Xy5Kl12JyznTF66x6T
         YaShylg0UPS2qNep6mNUCddyJ0276SQ+4C1W6hBNsndVMYvSkRlv1IscR6TZJYqt28q2
         axGRi+QpFWPxXTVAscBlBkqZQ3GLIWW/xkovy9tKTrN3ufIfb5VXRwGfXZTeYzvHV25G
         CuxFn1QCQK+OZOO8lbr/LFVJWy/padGO4uepQUJkGiUa3m2LxXj16gRqWUMuU9N0Bf/3
         O7RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RVQnwg/PYtBCBexaiykPWmElOOWGcv0g7rMf9iHb8VI=;
        b=DbR02LkExxFw/2mmsAymzi40ZFhW8f4WAP3qhLXzd6yUxJzLWCcUjYIOwTVkAy6KEB
         BaCUqshHJJCrerIJsQPgHJgfhHdr8X/qd8D8tGj5VE9MTAfc5tuN3drw4PeKdwQQMX8K
         GtwqGiUreQKWQW5JFS776issZpJkiggXaKNznN2WmLLDhzPHUsY4GIWG8qj3AJa6DSfg
         6w/W3Si8qVyOzDxNEEsS6nzFv4mXycB6sQ6fD2+VeNfJDwGP3zZQfXO3noYxH4v2x5nQ
         NC6v3CZlCFDYCxLWBZr5yxP9VqlvwqnLR9aej6ihyRs6ByA+fRRVDflSNfnweS3WeIa8
         t6jQ==
X-Gm-Message-State: APjAAAX26KdHZNAaTcVUwXUHtWHxJtLU/oY3GVwW//pIdYfEI9B5ViDt
        LgNM7id7FMmZmE6VthULNrI4guTtmhGO467LBCMySINSvp9lYXbtE+q+8hxJi5tGKoKqTG5tz5Q
        yHzf5UPbN4ZQu22hm6DwQY7FSeL6u
X-Received: by 2002:a02:c6a9:: with SMTP id o9mr12762532jan.70.1552108566289;
        Fri, 08 Mar 2019 21:16:06 -0800 (PST)
X-Google-Smtp-Source: APXvYqwM/CZ/cXc3NfvPJDsxSmsGykVFf+S4qRMeccMYwDaVjuSW4/gLGjOh6/Iyh1Ywr/Qd9veaKA==
X-Received: by 2002:a02:c6a9:: with SMTP id o9mr12762519jan.70.1552108566009;
        Fri, 08 Mar 2019 21:16:06 -0800 (PST)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id s10sm4180371ioc.21.2019.03.08.21.16.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2019 21:16:05 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: hmc: fix a potential NULL pointer dereference
Date:   Fri,  8 Mar 2019 23:15:32 -0600
Message-Id: <20190309051533.14309-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devm_regmap_init_i2c may fail and return NULL. The fix returns
the error when it fails.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/iio/magnetometer/hmc5843_i2c.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/magnetometer/hmc5843_i2c.c b/drivers/iio/magnetometer/hmc5843_i2c.c
index 3de7f4426ac4..c0cd0823f8d5 100644
--- a/drivers/iio/magnetometer/hmc5843_i2c.c
+++ b/drivers/iio/magnetometer/hmc5843_i2c.c
@@ -58,8 +58,13 @@ static const struct regmap_config hmc5843_i2c_regmap_config = {
 static int hmc5843_i2c_probe(struct i2c_client *cli,
 			     const struct i2c_device_id *id)
 {
+	struct regmap *devm_regmap = devm_regmap_init_i2c(cli,
+			&hmc5843_i2c_regmap_config);
+	if (IS_ERR(devm_regmap))
+		return PTR_ERR(devm_regmap);
+
 	return hmc5843_common_probe(&cli->dev,
-			devm_regmap_init_i2c(cli, &hmc5843_i2c_regmap_config),
+			devm_regmap,
 			id->driver_data, id->name);
 }
 
-- 
2.17.1

