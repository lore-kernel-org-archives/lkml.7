Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91502C352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 08:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 613A421920
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 08:58:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="p+4pV1fw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbfJBI6O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 04:58:14 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33986 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbfJBI6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 04:58:11 -0400
Received: by mail-wm1-f68.google.com with SMTP id y135so4415246wmc.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 01:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CmLXG4bPxTjZzTrvXKweoRTqZA7P9PJe9BBobCWifpI=;
        b=p+4pV1fwL5wiRu10JvmsXwhr/fPZowUsi2e2jE3rmHPtsQV4aj9xj+d3SjuDU7Fvj3
         UeqvgHiSgPkvnTx0wdl2yvW1n9E2pxqPBspUq9UgKg/HuJa8brAGnvmMGMXlCXyzXPq2
         ibhkjSJTIovbVPgpyiJLXFmIJ6BTYSt18o5PTdWsmMYXen6HcGmsu/TyeqxWI+YzWT0p
         9uT8GKNqNnpMzXRgdkix+m25G0oQoQAcBqqnq9AEjykbpBSAC3v4qRRXrWXpdbgjMsk3
         om9PZUq/q13ZPnfV6itub6BVD0QQRfTFlnTZiY29+okGv+Y0oGQCarzL+b0I9+NWxUEw
         soYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CmLXG4bPxTjZzTrvXKweoRTqZA7P9PJe9BBobCWifpI=;
        b=qZo8bBhqKcTZ5zU2bzHUGlhDrjVNt5UnGg+2+4XHsDqfy9V0Zflvsz0NKMmrk8WnjZ
         y7u2527N7A8edRBu6oRd10Orbpu8+KmwvcaXpikBQonNokqugRCQUY7FWqUYhb2lAifW
         zeLTRYQvF1b6JqPHJXuQzXpGdGEhA21HgWeUJ1cm4MKrCyGD47OcXgoiBfYl1Q13Z8zn
         cmiwjLzgzSbQujrgE/9VEwEhQ/rFvi7+JJ+btHyb7kUqvUIZw+sutadGbt+HauK6cZiX
         DfJui11SRHvCPzNaLFGr1zRO9VaeVrGDBYeCRsf558pWQMNAuW49EY8PLzFRfj+rrB1C
         XYgA==
X-Gm-Message-State: APjAAAW0O+6OhwzD/8D7e2vAh5fiK/CeM7GmQKYbSjkxzXGb/2IOWHAA
        FdT9hpLcLFsm26kQ2/c3UZWiDw==
X-Google-Smtp-Source: APXvYqyvWkgBIAqgpGtCM4BIOwtAxm0wEMGIwOSwSyOyi3rWQVrxqpgizmhTk9Wt7y7cEa4onq8dmQ==
X-Received: by 2002:a1c:a404:: with SMTP id n4mr1866027wme.137.1570006688761;
        Wed, 02 Oct 2019 01:58:08 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id b186sm10115616wmd.16.2019.10.02.01.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 01:58:08 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 2/4] iio: pressure: bmp280: use devm_iio_device_register()
Date:   Wed,  2 Oct 2019 10:57:57 +0200
Message-Id: <20191002085759.13337-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191002085759.13337-1-brgl@bgdev.pl>
References: <20191002085759.13337-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We can use the managed variant of iio_device_register() and remove
the corresponding unregister operation from the remove callback.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/iio/pressure/bmp280-core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index c21f8ce7b09c..f22400e1e98f 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -1127,7 +1127,7 @@ int bmp280_common_probe(struct device *dev,
 	pm_runtime_use_autosuspend(dev);
 	pm_runtime_put(dev);
 
-	ret = iio_device_register(indio_dev);
+	ret = devm_iio_device_register(dev, indio_dev);
 	if (ret)
 		goto out_runtime_pm_disable;
 
@@ -1149,7 +1149,6 @@ int bmp280_common_remove(struct device *dev)
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct bmp280_data *data = iio_priv(indio_dev);
 
-	iio_device_unregister(indio_dev);
 	pm_runtime_get_sync(data->dev);
 	pm_runtime_put_noidle(data->dev);
 	pm_runtime_disable(data->dev);
-- 
2.23.0

