Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A834AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 14:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 825EA2084D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 14:25:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729568AbfCYOZI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 10:25:08 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:14221 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726194AbfCYOZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 10:25:06 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2PEL0C4019417;
        Mon, 25 Mar 2019 15:24:20 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2rddhbbr65-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 25 Mar 2019 15:24:20 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6A4AC31;
        Mon, 25 Mar 2019 14:24:19 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3C6CAA493;
        Mon, 25 Mar 2019 14:24:19 +0000 (GMT)
Received: from localhost (10.75.127.45) by SFHDAG5NODE3.st.com (10.75.127.15)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 25 Mar 2019 15:24:18
 +0100
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
To:     <jic23@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <fabrice.gasnier@st.com>,
        <linux-iio@vger.kernel.org>, <lars@metafoo.de>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>, <linux-stm32@st-md-mailman.stormreply.com>,
        <arnaud.pouliquen@st.com>, <olivier.moysan@st.com>
Subject: [PATCH] iio: adc: stm32-dfsdm: improve sampling frequency accuracy
Date:   Mon, 25 Mar 2019 15:24:01 +0100
Message-ID: <1553523841-16315-1-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG8NODE2.st.com (10.75.127.23) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-25_09:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sample frequency is driven using the oversampling ratio depending
on the SPI bus frequency.
Currently, oversampling ratio is computed by an entire division:
- spi_freq / sample_freq. This may result in inaccurate value.
Using DIV_ROUND_CLOSEST improves resulting sample frequency, which is
useful for audio that requests fixed rates (such as: 8, 16 or 32 kHz).
BTW, introduce new routine to re-factor sample frequency setting, and
move frequency accuracy message from warning to debug level.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 drivers/iio/adc/stm32-dfsdm-adc.c | 56 +++++++++++++++++++++------------------
 1 file changed, 30 insertions(+), 26 deletions(-)

diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
index 531ca7e..051561c 100644
--- a/drivers/iio/adc/stm32-dfsdm-adc.c
+++ b/drivers/iio/adc/stm32-dfsdm-adc.c
@@ -558,13 +558,38 @@ static ssize_t dfsdm_adc_audio_get_spiclk(struct iio_dev *indio_dev,
 	return snprintf(buf, PAGE_SIZE, "%d\n", adc->spi_freq);
 }
 
+static int dfsdm_adc_set_samp_freq(struct iio_dev *indio_dev,
+				   unsigned int sample_freq,
+				   unsigned int spi_freq)
+{
+	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
+	struct stm32_dfsdm_filter *fl = &adc->dfsdm->fl_list[adc->fl_id];
+	unsigned int oversamp;
+	int ret;
+
+	oversamp = DIV_ROUND_CLOSEST(spi_freq, sample_freq);
+	if (spi_freq % sample_freq)
+		dev_dbg(&indio_dev->dev,
+			"Rate not accurate. requested (%u), actual (%u)\n",
+			sample_freq, spi_freq / oversamp);
+
+	ret = stm32_dfsdm_set_osrs(fl, 0, oversamp);
+	if (ret < 0) {
+		dev_err(&indio_dev->dev, "No filter parameters that match!\n");
+		return ret;
+	}
+	adc->sample_freq = spi_freq / oversamp;
+	adc->oversamp = oversamp;
+
+	return 0;
+}
+
 static ssize_t dfsdm_adc_audio_set_spiclk(struct iio_dev *indio_dev,
 					  uintptr_t priv,
 					  const struct iio_chan_spec *chan,
 					  const char *buf, size_t len)
 {
 	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
-	struct stm32_dfsdm_filter *fl = &adc->dfsdm->fl_list[adc->fl_id];
 	struct stm32_dfsdm_channel *ch = &adc->dfsdm->ch_list[chan->channel];
 	unsigned int sample_freq = adc->sample_freq;
 	unsigned int spi_freq;
@@ -583,17 +608,9 @@ static ssize_t dfsdm_adc_audio_set_spiclk(struct iio_dev *indio_dev,
 		return -EINVAL;
 
 	if (sample_freq) {
-		if (spi_freq % sample_freq)
-			dev_warn(&indio_dev->dev,
-				 "Sampling rate not accurate (%d)\n",
-				 spi_freq / (spi_freq / sample_freq));
-
-		ret = stm32_dfsdm_set_osrs(fl, 0, (spi_freq / sample_freq));
-		if (ret < 0) {
-			dev_err(&indio_dev->dev,
-				"No filter parameters that match!\n");
+		ret = dfsdm_adc_set_samp_freq(indio_dev, sample_freq, spi_freq);
+		if (ret < 0)
 			return ret;
-		}
 	}
 	adc->spi_freq = spi_freq;
 
@@ -1068,22 +1085,9 @@ static int stm32_dfsdm_write_raw(struct iio_dev *indio_dev,
 			spi_freq = adc->spi_freq;
 		}
 
-		if (spi_freq % val)
-			dev_warn(&indio_dev->dev,
-				 "Sampling rate not accurate (%d)\n",
-				 spi_freq / (spi_freq / val));
-
-		ret = stm32_dfsdm_set_osrs(fl, 0, (spi_freq / val));
-		if (ret < 0) {
-			dev_err(&indio_dev->dev,
-				"Not able to find parameter that match!\n");
-			iio_device_release_direct_mode(indio_dev);
-			return ret;
-		}
-		adc->sample_freq = val;
+		ret = dfsdm_adc_set_samp_freq(indio_dev, val, spi_freq);
 		iio_device_release_direct_mode(indio_dev);
-
-		return 0;
+		return ret;
 	}
 
 	return -EINVAL;
-- 
2.7.4

