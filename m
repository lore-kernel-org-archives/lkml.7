Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A9FDC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ABA520637
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576014214;
	bh=nxiHqEEeAIgzmTb4XBX0ISbTYklaOzPKlV3P7FFHadc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bzN2f2QScznpF/E0m9Xhdz3ktBbpxtRv500vZ8PohPYYqIku5dQgFiYwIdzT13x/i
	 ufGMtFr2LUEV3ukzusIbj95MHyw972c1fQ5pVM4j5XcfNwacazpLO8qbQi23726Wu8
	 Eo110LmcL/8MqOemnJrXR2CosiaUqxj86YbR0EJk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729314AbfLJVnd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 16:43:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:38102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729771AbfLJVdg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 16:33:36 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A4B920836;
        Tue, 10 Dec 2019 21:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576013616;
        bh=nxiHqEEeAIgzmTb4XBX0ISbTYklaOzPKlV3P7FFHadc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nXKnuN9Q9J0urT/DVC6ABW7dwaj2jgDDjfeV5YkjP+qdTIueAgHzX/OaieeqpO5+z
         ycPhjXHfi/hWRwM+VeXI94ZrBFwY+rB6Rd3Oo9pN9MbNIkadpJ2/VF0EgSzbIzcKq+
         JGwnlcsYcp50f4DIPLBkJRCl5NUGPJC7gwqJo9KA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>, linux-iio@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 061/177] iio: dac: ad7303: replace mlock with own lock
Date:   Tue, 10 Dec 2019 16:30:25 -0500
Message-Id: <20191210213221.11921-61-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210213221.11921-1-sashal@kernel.org>
References: <20191210213221.11921-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandru Ardelean <alexandru.ardelean@analog.com>

[ Upstream commit c991bf9b650f39481cf3c1137092d4754a2c75de ]

This change replaces indio_dev's mlock with the driver's own lock. The lock
is mostly needed to protect state when changing the `dac_cache` info.
The lock has been extended to `ad7303_read_raw()`, to make sure that the
cache is updated if an SPI-write is already in progress.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/dac/ad7303.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/dac/ad7303.c b/drivers/iio/dac/ad7303.c
index 8f3bd19b6dc35..dc1aea5b579e4 100644
--- a/drivers/iio/dac/ad7303.c
+++ b/drivers/iio/dac/ad7303.c
@@ -42,6 +42,7 @@ struct ad7303_state {
 	struct regulator *vdd_reg;
 	struct regulator *vref_reg;
 
+	struct mutex lock;
 	/*
 	 * DMA (thus cache coherency maintenance) requires the
 	 * transfer buffers to live in their own cache lines.
@@ -80,7 +81,7 @@ static ssize_t ad7303_write_dac_powerdown(struct iio_dev *indio_dev,
 	if (ret)
 		return ret;
 
-	mutex_lock(&indio_dev->mlock);
+	mutex_lock(&st->lock);
 
 	if (pwr_down)
 		st->config |= AD7303_CFG_POWER_DOWN(chan->channel);
@@ -91,7 +92,7 @@ static ssize_t ad7303_write_dac_powerdown(struct iio_dev *indio_dev,
 	 * mode, so just write one of the DAC channels again */
 	ad7303_write(st, chan->channel, st->dac_cache[chan->channel]);
 
-	mutex_unlock(&indio_dev->mlock);
+	mutex_unlock(&st->lock);
 	return len;
 }
 
@@ -117,7 +118,9 @@ static int ad7303_read_raw(struct iio_dev *indio_dev,
 
 	switch (info) {
 	case IIO_CHAN_INFO_RAW:
+		mutex_lock(&st->lock);
 		*val = st->dac_cache[chan->channel];
+		mutex_unlock(&st->lock);
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
 		vref_uv = ad7303_get_vref(st, chan);
@@ -145,11 +148,11 @@ static int ad7303_write_raw(struct iio_dev *indio_dev,
 		if (val >= (1 << chan->scan_type.realbits) || val < 0)
 			return -EINVAL;
 
-		mutex_lock(&indio_dev->mlock);
+		mutex_lock(&st->lock);
 		ret = ad7303_write(st, chan->address, val);
 		if (ret == 0)
 			st->dac_cache[chan->channel] = val;
-		mutex_unlock(&indio_dev->mlock);
+		mutex_unlock(&st->lock);
 		break;
 	default:
 		ret = -EINVAL;
@@ -212,6 +215,8 @@ static int ad7303_probe(struct spi_device *spi)
 
 	st->spi = spi;
 
+	mutex_init(&st->lock);
+
 	st->vdd_reg = devm_regulator_get(&spi->dev, "Vdd");
 	if (IS_ERR(st->vdd_reg))
 		return PTR_ERR(st->vdd_reg);
-- 
2.20.1

