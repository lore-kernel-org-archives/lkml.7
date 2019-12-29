Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45FDFC2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 18:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 166D6206DB
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 18:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577642638;
	bh=ki5lz75lp15VMkWCPZERY0m87G7OQ8uLibNz4VhQzVE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hkadVSFbYycXc6Dp6o+Y0ryIXL96lQhaEPb8YNHr4UHuUadbLf2v0pJ53OzR2Ftz6
	 tYT7JoL2gfvGZEOU6MWAvCK3CLq39swcuIKWFTxtDoORLcjGqiscutx+15c/CSFocX
	 ttnFce++r9vlq/MOmYdTQRXrbZHn+IrsD+L3Sd20=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732997AbfL2SD5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 13:03:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:39356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732353AbfL2Rww (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:52:52 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 172C120718;
        Sun, 29 Dec 2019 17:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577641971;
        bh=ki5lz75lp15VMkWCPZERY0m87G7OQ8uLibNz4VhQzVE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VPhny2qs1drcV2riGeZnPbrWOMgWMNeWzWxLpvOhAlMutIc7WbBEUkEgzzWjze71P
         o3fpWeVKKK/IaDmKPCIqmdvAXOlL6GsLMWsq5NdLj1apdVcpuQrVlKR/ayg80q1HpY
         g+QuAEA0pA4egvKw6cmmPmRzeKIRQMVDCjvbQqbo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefan Popa <stefan.popa@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 289/434] iio: dac: ad5446: Add support for new AD5600 DAC
Date:   Sun, 29 Dec 2019 18:25:42 +0100
Message-Id: <20191229172721.145867540@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191229172702.393141737@linuxfoundation.org>
References: <20191229172702.393141737@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Popa <stefan.popa@analog.com>

[ Upstream commit 6376cbe549fffb378403cee78efd26b8a2c8e450 ]

The AD5600 is a single channel, 16-bit resolution, voltage output digital
to analog converter (DAC). The AD5600 uses a 3-wire SPI interface. It is
part of the AD5541 family of DACs.

The ad5446 IIO driver implements support for some of these DACs (in the
AD5441 family), so the change is a simple entry in this driver.

Link: https://www.analog.com/media/en/technical-documentation/data-sheets/AD5600.pdf

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/dac/Kconfig  | 4 ++--
 drivers/iio/dac/ad5446.c | 6 ++++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index cc42219a64f7..979070196da9 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -60,8 +60,8 @@ config AD5446
 	help
 	  Say yes here to build support for Analog Devices AD5300, AD5301, AD5310,
 	  AD5311, AD5320, AD5321, AD5444, AD5446, AD5450, AD5451, AD5452, AD5453,
-	  AD5512A, AD5541A, AD5542A, AD5543, AD5553, AD5601, AD5602, AD5611, AD5612,
-	  AD5620, AD5621, AD5622, AD5640, AD5641, AD5660, AD5662 DACs
+	  AD5512A, AD5541A, AD5542A, AD5543, AD5553, AD5600, AD5601, AD5602, AD5611,
+	  AD5612, AD5620, AD5621, AD5622, AD5640, AD5641, AD5660, AD5662 DACs
 	  as well as Texas Instruments DAC081S101, DAC101S101, DAC121S101.
 
 	  To compile this driver as a module, choose M here: the
diff --git a/drivers/iio/dac/ad5446.c b/drivers/iio/dac/ad5446.c
index 7df8b4cc295d..61c670f7fc5f 100644
--- a/drivers/iio/dac/ad5446.c
+++ b/drivers/iio/dac/ad5446.c
@@ -327,6 +327,7 @@ enum ad5446_supported_spi_device_ids {
 	ID_AD5541A,
 	ID_AD5512A,
 	ID_AD5553,
+	ID_AD5600,
 	ID_AD5601,
 	ID_AD5611,
 	ID_AD5621,
@@ -381,6 +382,10 @@ static const struct ad5446_chip_info ad5446_spi_chip_info[] = {
 		.channel = AD5446_CHANNEL(14, 16, 0),
 		.write = ad5446_write,
 	},
+	[ID_AD5600] = {
+		.channel = AD5446_CHANNEL(16, 16, 0),
+		.write = ad5446_write,
+	},
 	[ID_AD5601] = {
 		.channel = AD5446_CHANNEL_POWERDOWN(8, 16, 6),
 		.write = ad5446_write,
@@ -448,6 +453,7 @@ static const struct spi_device_id ad5446_spi_ids[] = {
 	{"ad5542a", ID_AD5541A}, /* ad5541a and ad5542a are compatible */
 	{"ad5543", ID_AD5541A}, /* ad5541a and ad5543 are compatible */
 	{"ad5553", ID_AD5553},
+	{"ad5600", ID_AD5600},
 	{"ad5601", ID_AD5601},
 	{"ad5611", ID_AD5611},
 	{"ad5621", ID_AD5621},
-- 
2.20.1



