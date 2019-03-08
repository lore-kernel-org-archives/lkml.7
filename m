Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD5BCC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 22:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB6902081B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 22:04:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="jXm9uSN1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbfCHWER (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 17:04:17 -0500
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:45378 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726286AbfCHWEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 17:04:15 -0500
Received: from nis-sj1-27.broadcom.com (nis-sj1-27.lvn.broadcom.net [10.75.144.136])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id F331030C053;
        Fri,  8 Mar 2019 14:04:11 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com F331030C053
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1552082652;
        bh=6v8rWmKbm19cPG30ujMQBqdZv3fhMujqMeaEXG+Iib8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jXm9uSN1kC8rty64c9WCfQEMXacgLcs8Z9A31zlXUTpKKklWUlTI/7sjkiJXFNcxk
         qPjlxooN4JK1R1JeFNBlNwzFTBGoZzA+nCRXGm+5N7YM5EOCr87MIdC8zPZMpRufgh
         QdLm/lziTpe/tSgbB7yL3rCm1ElB6/N4uqB7v5So=
Received: from stbirv-lnx-2.igp.broadcom.net (stbirv-lnx-2.igp.broadcom.net [10.67.48.34])
        by nis-sj1-27.broadcom.com (Postfix) with ESMTP id 12BF9AC07B4;
        Fri,  8 Mar 2019 14:04:12 -0800 (PST)
Received: by stbirv-lnx-2.igp.broadcom.net (Postfix, from userid 47169)
        id 044DE27FECD; Fri,  8 Mar 2019 14:04:12 -0800 (PST)
From:   justinpopo6@gmail.com
To:     linux-iio@vger.kernel.org
Cc:     linux-gpio@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        f.fainelli@gmail.com, bgolaszewski@baylibre.com,
        linus.walleij@linaro.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, linux-kernel@vger.kernel.org,
        Justin Chen <justinpopo6@gmail.com>
Subject: [PATCH v5 1/2] iio: adc: ti-ads7950: Fix improper use of mlock
Date:   Fri,  8 Mar 2019 14:03:27 -0800
Message-Id: <1552082608-42603-2-git-send-email-justinpopo6@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1552082608-42603-1-git-send-email-justinpopo6@gmail.com>
References: <1552082608-42603-1-git-send-email-justinpopo6@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Justin Chen <justinpopo6@gmail.com>

Indio->mlock is used for protecting the different iio device modes.
It is currently not being used in this way. Replace the lock with
an internal lock specifically used for protecting the SPI transfer
buffer.

Signed-off-by: Justin Chen <justinpopo6@gmail.com>
---
 drivers/iio/adc/ti-ads7950.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ti-ads7950.c b/drivers/iio/adc/ti-ads7950.c
index 0ad6359..1e47bef 100644
--- a/drivers/iio/adc/ti-ads7950.c
+++ b/drivers/iio/adc/ti-ads7950.c
@@ -56,6 +56,9 @@ struct ti_ads7950_state {
 	struct spi_message	ring_msg;
 	struct spi_message	scan_single_msg;
 
+	/* Lock to protect the spi xfer buffers */
+	struct mutex		slock;
+
 	struct regulator	*reg;
 	unsigned int		vref_mv;
 
@@ -268,6 +271,7 @@ static irqreturn_t ti_ads7950_trigger_handler(int irq, void *p)
 	struct ti_ads7950_state *st = iio_priv(indio_dev);
 	int ret;
 
+	mutex_lock(&st->slock);
 	ret = spi_sync(st->spi, &st->ring_msg);
 	if (ret < 0)
 		goto out;
@@ -276,6 +280,7 @@ static irqreturn_t ti_ads7950_trigger_handler(int irq, void *p)
 					   iio_get_time_ns(indio_dev));
 
 out:
+	mutex_unlock(&st->slock);
 	iio_trigger_notify_done(indio_dev->trig);
 
 	return IRQ_HANDLED;
@@ -286,7 +291,7 @@ static int ti_ads7950_scan_direct(struct iio_dev *indio_dev, unsigned int ch)
 	struct ti_ads7950_state *st = iio_priv(indio_dev);
 	int ret, cmd;
 
-	mutex_lock(&indio_dev->mlock);
+	mutex_lock(&st->slock);
 
 	cmd = TI_ADS7950_CR_WRITE | TI_ADS7950_CR_CHAN(ch) | st->settings;
 	st->single_tx = cmd;
@@ -298,7 +303,7 @@ static int ti_ads7950_scan_direct(struct iio_dev *indio_dev, unsigned int ch)
 	ret = st->single_rx;
 
 out:
-	mutex_unlock(&indio_dev->mlock);
+	mutex_unlock(&st->slock);
 
 	return ret;
 }
@@ -432,16 +437,19 @@ static int ti_ads7950_probe(struct spi_device *spi)
 	if (ACPI_COMPANION(&spi->dev))
 		st->vref_mv = TI_ADS7950_VA_MV_ACPI_DEFAULT;
 
+	mutex_init(&st->slock);
+
 	st->reg = devm_regulator_get(&spi->dev, "vref");
 	if (IS_ERR(st->reg)) {
 		dev_err(&spi->dev, "Failed get get regulator \"vref\"\n");
-		return PTR_ERR(st->reg);
+		ret = PTR_ERR(st->reg);
+		goto error_destroy_mutex;
 	}
 
 	ret = regulator_enable(st->reg);
 	if (ret) {
 		dev_err(&spi->dev, "Failed to enable regulator \"vref\"\n");
-		return ret;
+		goto error_destroy_mutex;
 	}
 
 	ret = iio_triggered_buffer_setup(indio_dev, NULL,
@@ -463,6 +471,8 @@ static int ti_ads7950_probe(struct spi_device *spi)
 	iio_triggered_buffer_cleanup(indio_dev);
 error_disable_reg:
 	regulator_disable(st->reg);
+error_destroy_mutex:
+	mutex_destroy(&st->slock);
 
 	return ret;
 }
@@ -475,6 +485,7 @@ static int ti_ads7950_remove(struct spi_device *spi)
 	iio_device_unregister(indio_dev);
 	iio_triggered_buffer_cleanup(indio_dev);
 	regulator_disable(st->reg);
+	mutex_destroy(&st->slock);
 
 	return 0;
 }
-- 
2.7.4

