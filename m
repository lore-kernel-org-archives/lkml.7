Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97AEFC46470
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71EA32457B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559186045;
	bh=G7/EF0+sycBI1xObFRMuUqqyLtCEWKWSYGWiHh9zcnk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xQO92I1en0Z4QOHTmmpzIGqPVAziKxKCpiKRdyB3mvoVfdt4qdC2bcsH5NdvB2xWc
	 v/iqdSXE4cGTDFViVp8CBHCZmCxhJ0OUqQLJxH6ous6c/dPa0lexsnd/xeXgre5CTG
	 2sFPYdn5+oZwDx0Zd4eVQ0RdGj+9JvIn0C6u2zRo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729704AbfE3DOE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 23:14:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:52128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728696AbfE3DLt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:11:49 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EEC324508;
        Thu, 30 May 2019 03:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559185909;
        bh=G7/EF0+sycBI1xObFRMuUqqyLtCEWKWSYGWiHh9zcnk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xOsgS0C14oJLt/BqXEvbxW5Z4pvpLay5AMbX4m2B4B6wOk75O5C9u3FcxyhN/wy83
         jwCblnHwwqnd+1VB0UU6UPTpdqKKUK1hF5OdU9HNuLe8b7KYb+0Pah70Sbzgy4eOov
         ImFgfXl7uXrPMjm9Xm0GUjsHUegdZBcBV+rNvArM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 241/405] iio: hmc5843: fix potential NULL pointer dereferences
Date:   Wed, 29 May 2019 20:03:59 -0700
Message-Id: <20190530030553.187656356@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030540.291644921@linuxfoundation.org>
References: <20190530030540.291644921@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 536cc27deade8f1ec3c1beefa60d5fbe0f6fcb28 ]

devm_regmap_init_i2c may fail and return NULL. The fix returns
the error when it fails.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/magnetometer/hmc5843_i2c.c | 7 ++++++-
 drivers/iio/magnetometer/hmc5843_spi.c | 7 ++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/magnetometer/hmc5843_i2c.c b/drivers/iio/magnetometer/hmc5843_i2c.c
index 3de7f4426ac40..86abba5827a25 100644
--- a/drivers/iio/magnetometer/hmc5843_i2c.c
+++ b/drivers/iio/magnetometer/hmc5843_i2c.c
@@ -58,8 +58,13 @@ static const struct regmap_config hmc5843_i2c_regmap_config = {
 static int hmc5843_i2c_probe(struct i2c_client *cli,
 			     const struct i2c_device_id *id)
 {
+	struct regmap *regmap = devm_regmap_init_i2c(cli,
+			&hmc5843_i2c_regmap_config);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
 	return hmc5843_common_probe(&cli->dev,
-			devm_regmap_init_i2c(cli, &hmc5843_i2c_regmap_config),
+			regmap,
 			id->driver_data, id->name);
 }
 
diff --git a/drivers/iio/magnetometer/hmc5843_spi.c b/drivers/iio/magnetometer/hmc5843_spi.c
index 535f03a70d630..79b2b707f90e7 100644
--- a/drivers/iio/magnetometer/hmc5843_spi.c
+++ b/drivers/iio/magnetometer/hmc5843_spi.c
@@ -58,6 +58,7 @@ static const struct regmap_config hmc5843_spi_regmap_config = {
 static int hmc5843_spi_probe(struct spi_device *spi)
 {
 	int ret;
+	struct regmap *regmap;
 	const struct spi_device_id *id = spi_get_device_id(spi);
 
 	spi->mode = SPI_MODE_3;
@@ -67,8 +68,12 @@ static int hmc5843_spi_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
+	regmap = devm_regmap_init_spi(spi, &hmc5843_spi_regmap_config);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
 	return hmc5843_common_probe(&spi->dev,
-			devm_regmap_init_spi(spi, &hmc5843_spi_regmap_config),
+			regmap,
 			id->driver_data, id->name);
 }
 
-- 
2.20.1



