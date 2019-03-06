Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13184C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 08:56:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E063720675
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 08:56:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729688AbfCFI44 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 03:56:56 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:27460 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729561AbfCFI4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 03:56:23 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x268sqWU015101;
        Wed, 6 Mar 2019 09:55:50 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2qyhgaxr3b-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 06 Mar 2019 09:55:50 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id AD89634;
        Wed,  6 Mar 2019 08:55:49 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7FCA62407;
        Wed,  6 Mar 2019 08:55:49 +0000 (GMT)
Received: from localhost (10.75.127.45) by SFHDAG5NODE3.st.com (10.75.127.15)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 6 Mar 2019 09:55:48
 +0100
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
To:     <jic23@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <fabrice.gasnier@st.com>,
        <linux-iio@vger.kernel.org>, <lars@metafoo.de>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>, <linux-stm32@st-md-mailman.stormreply.com>,
        <arnaud.pouliquen@st.com>, <olivier.moysan@st.com>
Subject: [PATCH 3/8] iio: adc: stm32-dfsdm: move dma enable from start_conv() to start_dma()
Date:   Wed, 6 Mar 2019 09:55:19 +0100
Message-ID: <1551862524-25098-4-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551862524-25098-1-git-send-email-fabrice.gasnier@st.com>
References: <1551862524-25098-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG3NODE1.st.com (10.75.127.7) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-06_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move DMA enable (e.g. set RDMAEN bit) away from start_conv() that is used
for both buffer and single conversions. Thus, single conv rely on
interrupt, not dma.
Note: take care to prepare all DMA stuff and set RDMAEN before starting
filter (can be set only when DFEN=0).

This is precursor patch to ease support of triggered buffer mode.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 drivers/iio/adc/stm32-dfsdm-adc.c | 77 +++++++++++++++++++--------------------
 1 file changed, 38 insertions(+), 39 deletions(-)

diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
index 8690672..818627f 100644
--- a/drivers/iio/adc/stm32-dfsdm-adc.c
+++ b/drivers/iio/adc/stm32-dfsdm-adc.c
@@ -429,12 +429,10 @@ static ssize_t dfsdm_adc_audio_set_spiclk(struct iio_dev *indio_dev,
 }
 
 static int stm32_dfsdm_start_conv(struct stm32_dfsdm_adc *adc,
-				  const struct iio_chan_spec *chan,
-				  bool dma)
+				  const struct iio_chan_spec *chan)
 {
 	struct regmap *regmap = adc->dfsdm->regmap;
 	int ret;
-	unsigned int dma_en = 0;
 
 	ret = stm32_dfsdm_start_channel(adc->dfsdm, chan->channel);
 	if (ret < 0)
@@ -444,25 +442,12 @@ static int stm32_dfsdm_start_conv(struct stm32_dfsdm_adc *adc,
 	if (ret < 0)
 		goto stop_channels;
 
-	if (dma) {
-		/* Enable DMA transfer*/
-		dma_en =  DFSDM_CR1_RDMAEN(1);
-	}
-	/* Enable DMA transfer*/
-	ret = regmap_update_bits(regmap, DFSDM_CR1(adc->fl_id),
-				 DFSDM_CR1_RDMAEN_MASK, dma_en);
-	if (ret < 0)
-		goto filter_unconfigure;
-
 	ret = stm32_dfsdm_start_filter(adc->dfsdm, adc->fl_id);
 	if (ret < 0)
-		goto stop_dma;
+		goto filter_unconfigure;
 
 	return 0;
 
-stop_dma:
-	regmap_update_bits(regmap, DFSDM_CR1(adc->fl_id),
-			   DFSDM_CR1_RDMAEN_MASK, 0);
 filter_unconfigure:
 	regmap_update_bits(regmap, DFSDM_CR1(adc->fl_id),
 			   DFSDM_CR1_CFG_MASK, 0);
@@ -479,10 +464,6 @@ static void stm32_dfsdm_stop_conv(struct stm32_dfsdm_adc *adc,
 
 	stm32_dfsdm_stop_filter(adc->dfsdm, adc->fl_id);
 
-	/* Clean conversion options */
-	regmap_update_bits(regmap, DFSDM_CR1(adc->fl_id),
-			   DFSDM_CR1_RDMAEN_MASK, 0);
-
 	regmap_update_bits(regmap, DFSDM_CR1(adc->fl_id),
 			   DFSDM_CR1_CFG_MASK, 0);
 
@@ -599,15 +580,36 @@ static int stm32_dfsdm_adc_dma_start(struct iio_dev *indio_dev)
 
 	cookie = dmaengine_submit(desc);
 	ret = dma_submit_error(cookie);
-	if (ret) {
-		dmaengine_terminate_all(adc->dma_chan);
-		return ret;
-	}
+	if (ret)
+		goto err_stop_dma;
 
 	/* Issue pending DMA requests */
 	dma_async_issue_pending(adc->dma_chan);
 
+	/* Enable DMA transfer*/
+	ret = regmap_update_bits(adc->dfsdm->regmap, DFSDM_CR1(adc->fl_id),
+				 DFSDM_CR1_RDMAEN_MASK, DFSDM_CR1_RDMAEN_MASK);
+	if (ret < 0)
+		goto err_stop_dma;
+
 	return 0;
+
+err_stop_dma:
+	dmaengine_terminate_all(adc->dma_chan);
+
+	return ret;
+}
+
+static void stm32_dfsdm_adc_dma_stop(struct iio_dev *indio_dev)
+{
+	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
+
+	if (!adc->dma_chan)
+		return;
+
+	regmap_update_bits(adc->dfsdm->regmap, DFSDM_CR1(adc->fl_id),
+			   DFSDM_CR1_RDMAEN_MASK, 0);
+	dmaengine_terminate_all(adc->dma_chan);
 }
 
 static int stm32_dfsdm_postenable(struct iio_dev *indio_dev)
@@ -623,24 +625,22 @@ static int stm32_dfsdm_postenable(struct iio_dev *indio_dev)
 	if (ret < 0)
 		return ret;
 
-	ret = stm32_dfsdm_start_conv(adc, chan, true);
+	ret = stm32_dfsdm_adc_dma_start(indio_dev);
 	if (ret) {
-		dev_err(&indio_dev->dev, "Can't start conversion\n");
+		dev_err(&indio_dev->dev, "Can't start DMA\n");
 		goto stop_dfsdm;
 	}
 
-	if (adc->dma_chan) {
-		ret = stm32_dfsdm_adc_dma_start(indio_dev);
-		if (ret) {
-			dev_err(&indio_dev->dev, "Can't start DMA\n");
-			goto err_stop_conv;
-		}
+	ret = stm32_dfsdm_start_conv(adc, chan);
+	if (ret) {
+		dev_err(&indio_dev->dev, "Can't start conversion\n");
+		goto err_stop_dma;
 	}
 
 	return 0;
 
-err_stop_conv:
-	stm32_dfsdm_stop_conv(adc, chan);
+err_stop_dma:
+	stm32_dfsdm_adc_dma_stop(indio_dev);
 stop_dfsdm:
 	stm32_dfsdm_stop_dfsdm(adc->dfsdm);
 
@@ -652,11 +652,10 @@ static int stm32_dfsdm_predisable(struct iio_dev *indio_dev)
 	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
 	const struct iio_chan_spec *chan = &indio_dev->channels[0];
 
-	if (adc->dma_chan)
-		dmaengine_terminate_all(adc->dma_chan);
-
 	stm32_dfsdm_stop_conv(adc, chan);
 
+	stm32_dfsdm_adc_dma_stop(indio_dev);
+
 	stm32_dfsdm_stop_dfsdm(adc->dfsdm);
 
 	return 0;
@@ -736,7 +735,7 @@ static int stm32_dfsdm_single_conv(struct iio_dev *indio_dev,
 	if (ret < 0)
 		goto stop_dfsdm;
 
-	ret = stm32_dfsdm_start_conv(adc, chan, false);
+	ret = stm32_dfsdm_start_conv(adc, chan);
 	if (ret < 0) {
 		regmap_update_bits(adc->dfsdm->regmap, DFSDM_CR2(adc->fl_id),
 				   DFSDM_CR2_REOCIE_MASK, DFSDM_CR2_REOCIE(0));
-- 
2.7.4

