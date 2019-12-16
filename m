Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8491AC2D0C3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:22:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D27124650
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576520577;
	bh=2s/lii9loPIvNFFMVcmr1yl2tE5CR8+63mR1DUuogzc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cpNjeiND6ovz77W2xqGFxaRsxXWWgIcVw/95Pt/L3bQCMPpEEUkdEMQcwIJ8ejY/z
	 T2vQyKWOFeb+DQSvfzhUKU4IDfEnaneu+lQIWtl6/MkP1CtH0/mz89PhH18m+Tu+Rl
	 h/ozzhWN0ex2Ev20u3Iw+YFKteZx7rKjLdYzP+J0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732157AbfLPSUy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:20:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:52196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727576AbfLPSUt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 13:20:49 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10E2D207FF;
        Mon, 16 Dec 2019 18:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576520448;
        bh=2s/lii9loPIvNFFMVcmr1yl2tE5CR8+63mR1DUuogzc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M6epByWs6gkzAXvtEu2/IobYSOeK53UsMdC9WlQeVsr6yxlfmytDG/FdNy+KNtQ8f
         qOrS7WMo9oUvVpePU1DUPAlJ+j0MOu02oc0OQkLjauL/P0mudc+oeuZZUsqGlX5yap
         1DINUEgfmdiphRamNQrpsIFYHjrEQxSrNJUQORwA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrea Merello <andrea.merello@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 158/177] iio: ad7949: kill pointless "readback"-handling code
Date:   Mon, 16 Dec 2019 18:50:14 +0100
Message-Id: <20191216174848.840189167@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174811.158424118@linuxfoundation.org>
References: <20191216174811.158424118@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrea Merello <andrea.merello@gmail.com>

[ Upstream commit c270bbf7bb9ddc4e2a51b3c56557c377c9ac79bc ]

The device could be configured to spit out also the configuration word
while reading the AD result value (in the same SPI xfer) - this is called
"readback" in the device datasheet.

The driver checks if readback is enabled and it eventually adjusts the SPI
xfer length and it applies proper shifts to still get the data, discarding
the configuration word.

The readback option is actually never enabled (the driver disables it), so
the said checks do not serve for any purpose.

Since enabling the readback option seems not to provide any advantage (the
driver entirely sets the configuration word without relying on any default
value), just kill the said, unused, code.

Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
Reviewed-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/adc/ad7949.c | 27 +++------------------------
 1 file changed, 3 insertions(+), 24 deletions(-)

diff --git a/drivers/iio/adc/ad7949.c b/drivers/iio/adc/ad7949.c
index ac0ffff6c5ae1..518044c31a73b 100644
--- a/drivers/iio/adc/ad7949.c
+++ b/drivers/iio/adc/ad7949.c
@@ -57,29 +57,11 @@ struct ad7949_adc_chip {
 	u32 buffer ____cacheline_aligned;
 };
 
-static bool ad7949_spi_cfg_is_read_back(struct ad7949_adc_chip *ad7949_adc)
-{
-	if (!(ad7949_adc->cfg & AD7949_CFG_READ_BACK))
-		return true;
-
-	return false;
-}
-
-static int ad7949_spi_bits_per_word(struct ad7949_adc_chip *ad7949_adc)
-{
-	int ret = ad7949_adc->resolution;
-
-	if (ad7949_spi_cfg_is_read_back(ad7949_adc))
-		ret += AD7949_CFG_REG_SIZE_BITS;
-
-	return ret;
-}
-
 static int ad7949_spi_write_cfg(struct ad7949_adc_chip *ad7949_adc, u16 val,
 				u16 mask)
 {
 	int ret;
-	int bits_per_word = ad7949_spi_bits_per_word(ad7949_adc);
+	int bits_per_word = ad7949_adc->resolution;
 	int shift = bits_per_word - AD7949_CFG_REG_SIZE_BITS;
 	struct spi_message msg;
 	struct spi_transfer tx[] = {
@@ -107,7 +89,7 @@ static int ad7949_spi_read_channel(struct ad7949_adc_chip *ad7949_adc, int *val,
 				   unsigned int channel)
 {
 	int ret;
-	int bits_per_word = ad7949_spi_bits_per_word(ad7949_adc);
+	int bits_per_word = ad7949_adc->resolution;
 	int mask = GENMASK(ad7949_adc->resolution, 0);
 	struct spi_message msg;
 	struct spi_transfer tx[] = {
@@ -138,10 +120,7 @@ static int ad7949_spi_read_channel(struct ad7949_adc_chip *ad7949_adc, int *val,
 
 	ad7949_adc->current_channel = channel;
 
-	if (ad7949_spi_cfg_is_read_back(ad7949_adc))
-		*val = (ad7949_adc->buffer >> AD7949_CFG_REG_SIZE_BITS) & mask;
-	else
-		*val = ad7949_adc->buffer & mask;
+	*val = ad7949_adc->buffer & mask;
 
 	return 0;
 }
-- 
2.20.1



