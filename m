Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F388C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 08:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 022E320675
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 08:56:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729685AbfCFI4p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 03:56:45 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:47806 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729559AbfCFI4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 03:56:23 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x268pqus028239;
        Wed, 6 Mar 2019 09:55:52 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2qygfxpr82-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 06 Mar 2019 09:55:52 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0D72C3A;
        Wed,  6 Mar 2019 08:55:52 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D85E323F7;
        Wed,  6 Mar 2019 08:55:51 +0000 (GMT)
Received: from localhost (10.75.127.45) by SFHDAG5NODE3.st.com (10.75.127.15)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 6 Mar 2019 09:55:51
 +0100
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
To:     <jic23@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <fabrice.gasnier@st.com>,
        <linux-iio@vger.kernel.org>, <lars@metafoo.de>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>, <linux-stm32@st-md-mailman.stormreply.com>,
        <arnaud.pouliquen@st.com>, <olivier.moysan@st.com>
Subject: [PATCH 6/8] iio: adc: stm32-dfsdm: add support for scan mode
Date:   Wed, 6 Mar 2019 09:55:22 +0100
Message-ID: <1551862524-25098-7-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551862524-25098-1-git-send-email-fabrice.gasnier@st.com>
References: <1551862524-25098-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG3NODE3.st.com (10.75.127.9) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-06_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to support multiple channels in buffer mode, add support for scan
mode. This is precursor patch to ease support of triggered buffer mode.
Currently, only audio uses buffer mode: Regular continuous conversions
with a single channel (per filter).
DFSDM hardware supports scan mode (only) with injected conversions.
Conversions can be launched by software (JSWSTART), trigger or
synchronously with filter 0 (e.g. JSYNC). Continuous conversion mode isn't
available for injected.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 drivers/iio/adc/stm32-dfsdm-adc.c | 182 +++++++++++++++++++++++++++++---------
 1 file changed, 142 insertions(+), 40 deletions(-)

diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
index b491424..4ead6bf 100644
--- a/drivers/iio/adc/stm32-dfsdm-adc.c
+++ b/drivers/iio/adc/stm32-dfsdm-adc.c
@@ -40,7 +40,8 @@
 
 /* Filter configuration */
 #define DFSDM_CR1_CFG_MASK (DFSDM_CR1_RCH_MASK | DFSDM_CR1_RCONT_MASK | \
-			    DFSDM_CR1_RSYNC_MASK)
+			    DFSDM_CR1_RSYNC_MASK | DFSDM_CR1_JSYNC_MASK | \
+			    DFSDM_CR1_JSCAN_MASK)
 
 enum sd_converter_type {
 	DFSDM_AUDIO,
@@ -58,6 +59,8 @@ struct stm32_dfsdm_adc {
 	struct stm32_dfsdm *dfsdm;
 	const struct stm32_dfsdm_dev_data *dev_data;
 	unsigned int fl_id;
+	unsigned int nconv;
+	unsigned long smask;
 
 	/* ADC specific */
 	unsigned int oversamp;
@@ -204,19 +207,39 @@ static int stm32_dfsdm_set_osrs(struct stm32_dfsdm_filter *fl,
 	return 0;
 }
 
-static int stm32_dfsdm_start_channel(struct stm32_dfsdm *dfsdm,
-				     unsigned int ch_id)
+static int stm32_dfsdm_start_channel(struct stm32_dfsdm_adc *adc)
 {
-	return regmap_update_bits(dfsdm->regmap, DFSDM_CHCFGR1(ch_id),
-				  DFSDM_CHCFGR1_CHEN_MASK,
-				  DFSDM_CHCFGR1_CHEN(1));
+	struct iio_dev *indio_dev = iio_priv_to_dev(adc);
+	struct regmap *regmap = adc->dfsdm->regmap;
+	const struct iio_chan_spec *chan;
+	unsigned int bit;
+	int ret;
+
+	for_each_set_bit(bit, &adc->smask, sizeof(adc->smask) * BITS_PER_BYTE) {
+		chan = indio_dev->channels + bit;
+		ret = regmap_update_bits(regmap, DFSDM_CHCFGR1(chan->channel),
+					 DFSDM_CHCFGR1_CHEN_MASK,
+					 DFSDM_CHCFGR1_CHEN(1));
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
 }
 
-static void stm32_dfsdm_stop_channel(struct stm32_dfsdm *dfsdm,
-				     unsigned int ch_id)
+static void stm32_dfsdm_stop_channel(struct stm32_dfsdm_adc *adc)
 {
-	regmap_update_bits(dfsdm->regmap, DFSDM_CHCFGR1(ch_id),
-			   DFSDM_CHCFGR1_CHEN_MASK, DFSDM_CHCFGR1_CHEN(0));
+	struct iio_dev *indio_dev = iio_priv_to_dev(adc);
+	struct regmap *regmap = adc->dfsdm->regmap;
+	const struct iio_chan_spec *chan;
+	unsigned int bit;
+
+	for_each_set_bit(bit, &adc->smask, sizeof(adc->smask) * BITS_PER_BYTE) {
+		chan = indio_dev->channels + bit;
+		regmap_update_bits(regmap, DFSDM_CHCFGR1(chan->channel),
+				   DFSDM_CHCFGR1_CHEN_MASK,
+				   DFSDM_CHCFGR1_CHEN(0));
+	}
 }
 
 static int stm32_dfsdm_chan_configure(struct stm32_dfsdm *dfsdm,
@@ -241,9 +264,10 @@ static int stm32_dfsdm_chan_configure(struct stm32_dfsdm *dfsdm,
 				  DFSDM_CHCFGR1_CHINSEL(ch->alt_si));
 }
 
-static int stm32_dfsdm_start_filter(struct stm32_dfsdm *dfsdm,
+static int stm32_dfsdm_start_filter(struct stm32_dfsdm_adc *adc,
 				    unsigned int fl_id)
 {
+	struct stm32_dfsdm *dfsdm = adc->dfsdm;
 	int ret;
 
 	/* Enable filter */
@@ -252,7 +276,11 @@ static int stm32_dfsdm_start_filter(struct stm32_dfsdm *dfsdm,
 	if (ret < 0)
 		return ret;
 
-	/* Start conversion */
+	/* Nothing more to do for injected (scan mode/triggered) conversions */
+	if (adc->nconv > 1)
+		return 0;
+
+	/* Software start (single or continuous) regular conversion */
 	return regmap_update_bits(dfsdm->regmap, DFSDM_CR1(fl_id),
 				  DFSDM_CR1_RSWSTART_MASK,
 				  DFSDM_CR1_RSWSTART(1));
@@ -267,12 +295,14 @@ static void stm32_dfsdm_stop_filter(struct stm32_dfsdm *dfsdm,
 }
 
 static int stm32_dfsdm_filter_configure(struct stm32_dfsdm_adc *adc,
-					unsigned int fl_id, unsigned int ch_id)
+					unsigned int fl_id)
 {
 	struct iio_dev *indio_dev = iio_priv_to_dev(adc);
 	struct regmap *regmap = adc->dfsdm->regmap;
 	struct stm32_dfsdm_filter *fl = &adc->dfsdm->fl_list[fl_id];
 	u32 cr1;
+	const struct iio_chan_spec *chan;
+	unsigned int bit, jchg = 0;
 	int ret;
 
 	/* Average integrator oversampling */
@@ -292,14 +322,59 @@ static int stm32_dfsdm_filter_configure(struct stm32_dfsdm_adc *adc,
 	if (ret)
 		return ret;
 
-	/* No scan mode supported for the moment */
-	cr1 = DFSDM_CR1_RCH(ch_id);
+	/*
+	 * DFSDM modes configuration W.R.T audio/iio type modes
+	 * ----------------------------------------------------------------
+	 * Modes         | regular |  regular     | injected | injected   |
+	 *               |         |  continuous  |          | + scan     |
+	 * --------------|---------|--------------|----------|------------|
+	 * single conv   |    x    |              |          |            |
+	 * (1 chan)      |         |              |          |            |
+	 * --------------|---------|--------------|----------|------------|
+	 * 1 Audio chan	 |         | sample freq  |          |            |
+	 *               |         | or sync_mode |          |            |
+	 * --------------|---------|--------------|----------|------------|
+	 * 1 IIO chan	 |         | sample freq  | trigger  |            |
+	 *               |         | or sync_mode |          |            |
+	 * --------------|---------|--------------|----------|------------|
+	 * 2+ IIO chans  |         |              |          | trigger or |
+	 *               |         |              |          | sync_mode  |
+	 * ----------------------------------------------------------------
+	 */
+	if (adc->nconv == 1) {
+		bit = __ffs(adc->smask);
+		chan = indio_dev->channels + bit;
 
-	/* Continuous conversions triggered by SPI clock in buffer mode */
-	if (indio_dev->currentmode & INDIO_BUFFER_SOFTWARE)
-		cr1 |= DFSDM_CR1_RCONT(1);
+		/* Use regular conversion for single channel without trigger */
+		cr1 = DFSDM_CR1_RCH(chan->channel);
 
-	cr1 |= DFSDM_CR1_RSYNC(fl->sync_mode);
+		/* Continuous conversions triggered by SPI clk in buffer mode */
+		if (indio_dev->currentmode & INDIO_BUFFER_SOFTWARE)
+			cr1 |= DFSDM_CR1_RCONT(1);
+
+		cr1 |= DFSDM_CR1_RSYNC(fl->sync_mode);
+	} else {
+		/* Use injected conversion for multiple channels */
+		for_each_set_bit(bit, &adc->smask,
+				 sizeof(adc->smask) * BITS_PER_BYTE) {
+			chan = indio_dev->channels + bit;
+			jchg |= BIT(chan->channel);
+		}
+		ret = regmap_write(regmap, DFSDM_JCHGR(fl_id), jchg);
+		if (ret < 0)
+			return ret;
+
+		/* Use scan mode for multiple channels */
+		cr1 = DFSDM_CR1_JSCAN(1);
+
+		/*
+		 * Continuous conversions not supported in injected mode:
+		 * - use conversions in sync with filter 0
+		 */
+		if (!fl->sync_mode)
+			return -EINVAL;
+		cr1 |= DFSDM_CR1_JSYNC(fl->sync_mode);
+	}
 
 	return regmap_update_bits(regmap, DFSDM_CR1(fl_id), DFSDM_CR1_CFG_MASK,
 				  cr1);
@@ -428,21 +503,20 @@ static ssize_t dfsdm_adc_audio_set_spiclk(struct iio_dev *indio_dev,
 	return len;
 }
 
-static int stm32_dfsdm_start_conv(struct stm32_dfsdm_adc *adc,
-				  const struct iio_chan_spec *chan)
+static int stm32_dfsdm_start_conv(struct stm32_dfsdm_adc *adc)
 {
 	struct regmap *regmap = adc->dfsdm->regmap;
 	int ret;
 
-	ret = stm32_dfsdm_start_channel(adc->dfsdm, chan->channel);
+	ret = stm32_dfsdm_start_channel(adc);
 	if (ret < 0)
 		return ret;
 
-	ret = stm32_dfsdm_filter_configure(adc, adc->fl_id, chan->channel);
+	ret = stm32_dfsdm_filter_configure(adc, adc->fl_id);
 	if (ret < 0)
 		goto stop_channels;
 
-	ret = stm32_dfsdm_start_filter(adc->dfsdm, adc->fl_id);
+	ret = stm32_dfsdm_start_filter(adc, adc->fl_id);
 	if (ret < 0)
 		goto filter_unconfigure;
 
@@ -452,13 +526,12 @@ static int stm32_dfsdm_start_conv(struct stm32_dfsdm_adc *adc,
 	regmap_update_bits(regmap, DFSDM_CR1(adc->fl_id),
 			   DFSDM_CR1_CFG_MASK, 0);
 stop_channels:
-	stm32_dfsdm_stop_channel(adc->dfsdm, chan->channel);
+	stm32_dfsdm_stop_channel(adc);
 
 	return ret;
 }
 
-static void stm32_dfsdm_stop_conv(struct stm32_dfsdm_adc *adc,
-				  const struct iio_chan_spec *chan)
+static void stm32_dfsdm_stop_conv(struct stm32_dfsdm_adc *adc)
 {
 	struct regmap *regmap = adc->dfsdm->regmap;
 
@@ -467,7 +540,7 @@ static void stm32_dfsdm_stop_conv(struct stm32_dfsdm_adc *adc,
 	regmap_update_bits(regmap, DFSDM_CR1(adc->fl_id),
 			   DFSDM_CR1_CFG_MASK, 0);
 
-	stm32_dfsdm_stop_channel(adc->dfsdm, chan->channel);
+	stm32_dfsdm_stop_channel(adc);
 }
 
 static int stm32_dfsdm_set_watermark(struct iio_dev *indio_dev,
@@ -557,8 +630,7 @@ static int stm32_dfsdm_adc_dma_start(struct iio_dev *indio_dev)
 {
 	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
 	struct dma_slave_config config = {
-		.src_addr = (dma_addr_t)adc->dfsdm->phys_base +
-			DFSDM_RDATAR(adc->fl_id),
+		.src_addr = (dma_addr_t)adc->dfsdm->phys_base,
 		.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES,
 	};
 	struct dma_async_tx_descriptor *desc;
@@ -571,6 +643,10 @@ static int stm32_dfsdm_adc_dma_start(struct iio_dev *indio_dev)
 	dev_dbg(&indio_dev->dev, "%s size=%d watermark=%d\n", __func__,
 		adc->buf_sz, adc->buf_sz / 2);
 
+	if (adc->nconv == 1)
+		config.src_addr += DFSDM_RDATAR(adc->fl_id);
+	else
+		config.src_addr += DFSDM_JDATAR(adc->fl_id);
 	ret = dmaengine_slave_config(adc->dma_chan, &config);
 	if (ret)
 		return ret;
@@ -595,9 +671,20 @@ static int stm32_dfsdm_adc_dma_start(struct iio_dev *indio_dev)
 	/* Issue pending DMA requests */
 	dma_async_issue_pending(adc->dma_chan);
 
-	/* Enable DMA transfer*/
-	ret = regmap_update_bits(adc->dfsdm->regmap, DFSDM_CR1(adc->fl_id),
-				 DFSDM_CR1_RDMAEN_MASK, DFSDM_CR1_RDMAEN_MASK);
+	if (adc->nconv == 1) {
+		/* Enable regular DMA transfer*/
+		ret = regmap_update_bits(adc->dfsdm->regmap,
+					 DFSDM_CR1(adc->fl_id),
+					 DFSDM_CR1_RDMAEN_MASK,
+					 DFSDM_CR1_RDMAEN_MASK);
+	} else {
+		/* Enable injected DMA transfer*/
+		ret = regmap_update_bits(adc->dfsdm->regmap,
+					 DFSDM_CR1(adc->fl_id),
+					 DFSDM_CR1_JDMAEN_MASK,
+					 DFSDM_CR1_JDMAEN_MASK);
+	}
+
 	if (ret < 0)
 		goto err_stop_dma;
 
@@ -617,14 +704,26 @@ static void stm32_dfsdm_adc_dma_stop(struct iio_dev *indio_dev)
 		return;
 
 	regmap_update_bits(adc->dfsdm->regmap, DFSDM_CR1(adc->fl_id),
-			   DFSDM_CR1_RDMAEN_MASK, 0);
+			   DFSDM_CR1_RDMAEN_MASK | DFSDM_CR1_JDMAEN_MASK, 0);
 	dmaengine_terminate_all(adc->dma_chan);
 }
 
+static int stm32_dfsdm_update_scan_mode(struct iio_dev *indio_dev,
+					const unsigned long *scan_mask)
+{
+	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
+
+	adc->nconv = bitmap_weight(scan_mask, indio_dev->masklength);
+	adc->smask = *scan_mask;
+
+	dev_dbg(&indio_dev->dev, "nconv=%d mask=%lx\n", adc->nconv, *scan_mask);
+
+	return 0;
+}
+
 static int stm32_dfsdm_postenable(struct iio_dev *indio_dev)
 {
 	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
-	const struct iio_chan_spec *chan = &indio_dev->channels[0];
 	int ret;
 
 	/* Reset adc buffer index */
@@ -646,7 +745,7 @@ static int stm32_dfsdm_postenable(struct iio_dev *indio_dev)
 		goto stop_dfsdm;
 	}
 
-	ret = stm32_dfsdm_start_conv(adc, chan);
+	ret = stm32_dfsdm_start_conv(adc);
 	if (ret) {
 		dev_err(&indio_dev->dev, "Can't start conversion\n");
 		goto err_stop_dma;
@@ -668,9 +767,8 @@ static int stm32_dfsdm_postenable(struct iio_dev *indio_dev)
 static int stm32_dfsdm_predisable(struct iio_dev *indio_dev)
 {
 	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
-	const struct iio_chan_spec *chan = &indio_dev->channels[0];
 
-	stm32_dfsdm_stop_conv(adc, chan);
+	stm32_dfsdm_stop_conv(adc);
 
 	stm32_dfsdm_adc_dma_stop(indio_dev);
 
@@ -756,7 +854,9 @@ static int stm32_dfsdm_single_conv(struct iio_dev *indio_dev,
 	if (ret < 0)
 		goto stop_dfsdm;
 
-	ret = stm32_dfsdm_start_conv(adc, chan);
+	adc->nconv = 1;
+	adc->smask = BIT(chan->scan_index);
+	ret = stm32_dfsdm_start_conv(adc);
 	if (ret < 0) {
 		regmap_update_bits(adc->dfsdm->regmap, DFSDM_CR2(adc->fl_id),
 				   DFSDM_CR2_REOCIE_MASK, DFSDM_CR2_REOCIE(0));
@@ -777,7 +877,7 @@ static int stm32_dfsdm_single_conv(struct iio_dev *indio_dev,
 	else
 		ret = IIO_VAL_INT;
 
-	stm32_dfsdm_stop_conv(adc, chan);
+	stm32_dfsdm_stop_conv(adc);
 
 stop_dfsdm:
 	stm32_dfsdm_stop_dfsdm(adc->dfsdm);
@@ -882,11 +982,13 @@ static const struct iio_info stm32_dfsdm_info_audio = {
 	.hwfifo_set_watermark = stm32_dfsdm_set_watermark,
 	.read_raw = stm32_dfsdm_read_raw,
 	.write_raw = stm32_dfsdm_write_raw,
+	.update_scan_mode = stm32_dfsdm_update_scan_mode,
 };
 
 static const struct iio_info stm32_dfsdm_info_adc = {
 	.read_raw = stm32_dfsdm_read_raw,
 	.write_raw = stm32_dfsdm_write_raw,
+	.update_scan_mode = stm32_dfsdm_update_scan_mode,
 };
 
 static irqreturn_t stm32_dfsdm_irq(int irq, void *arg)
-- 
2.7.4

