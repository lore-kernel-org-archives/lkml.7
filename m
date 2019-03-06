Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3375CC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 08:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01D91206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 08:56:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729519AbfCFI4V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 03:56:21 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:58447 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728899AbfCFI4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 03:56:18 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x268p4Wg001186;
        Wed, 6 Mar 2019 09:55:50 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2r0ju8yewt-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 06 Mar 2019 09:55:50 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5AA1841;
        Wed,  6 Mar 2019 08:55:49 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C53772400;
        Wed,  6 Mar 2019 08:55:48 +0000 (GMT)
Received: from localhost (10.75.127.44) by SFHDAG5NODE3.st.com (10.75.127.15)
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
Subject: [PATCH 2/8] iio: adc: stm32-dfsdm: continuous mode depends on current mode
Date:   Wed, 6 Mar 2019 09:55:18 +0100
Message-ID: <1551862524-25098-3-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551862524-25098-1-git-send-email-fabrice.gasnier@st.com>
References: <1551862524-25098-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG5NODE1.st.com (10.75.127.13) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-06_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DFSDM regular continuous mode usage depends on current mode (not DMA):
- for single conversion, RCONT doesn't need to be set.
- for buffer mode, RCONT has to be set (e.g. INDIO_BUFFER_SOFTWARE
  used by audio currently).
This is related to filter configuration, move it to relevant routine.

This is precursor patch to ease support of triggered buffer mode.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 drivers/iio/adc/stm32-dfsdm-adc.c | 54 +++++++++++++++++++--------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
index fcd4a1c..8690672 100644
--- a/drivers/iio/adc/stm32-dfsdm-adc.c
+++ b/drivers/iio/adc/stm32-dfsdm-adc.c
@@ -38,6 +38,10 @@
 #define DFSDM_MAX_RES BIT(31)
 #define DFSDM_DATA_RES BIT(23)
 
+/* Filter configuration */
+#define DFSDM_CR1_CFG_MASK (DFSDM_CR1_RCH_MASK | DFSDM_CR1_RCONT_MASK | \
+			    DFSDM_CR1_RSYNC_MASK)
+
 enum sd_converter_type {
 	DFSDM_AUDIO,
 	DFSDM_IIO,
@@ -262,11 +266,13 @@ static void stm32_dfsdm_stop_filter(struct stm32_dfsdm *dfsdm,
 			   DFSDM_CR1_DFEN_MASK, DFSDM_CR1_DFEN(0));
 }
 
-static int stm32_dfsdm_filter_configure(struct stm32_dfsdm *dfsdm,
+static int stm32_dfsdm_filter_configure(struct stm32_dfsdm_adc *adc,
 					unsigned int fl_id, unsigned int ch_id)
 {
-	struct regmap *regmap = dfsdm->regmap;
-	struct stm32_dfsdm_filter *fl = &dfsdm->fl_list[fl_id];
+	struct iio_dev *indio_dev = iio_priv_to_dev(adc);
+	struct regmap *regmap = adc->dfsdm->regmap;
+	struct stm32_dfsdm_filter *fl = &adc->dfsdm->fl_list[fl_id];
+	u32 cr1;
 	int ret;
 
 	/* Average integrator oversampling */
@@ -287,14 +293,16 @@ static int stm32_dfsdm_filter_configure(struct stm32_dfsdm *dfsdm,
 		return ret;
 
 	/* No scan mode supported for the moment */
-	ret = regmap_update_bits(regmap, DFSDM_CR1(fl_id), DFSDM_CR1_RCH_MASK,
-				 DFSDM_CR1_RCH(ch_id));
-	if (ret)
-		return ret;
+	cr1 = DFSDM_CR1_RCH(ch_id);
+
+	/* Continuous conversions triggered by SPI clock in buffer mode */
+	if (indio_dev->currentmode & INDIO_BUFFER_SOFTWARE)
+		cr1 |= DFSDM_CR1_RCONT(1);
 
-	return regmap_update_bits(regmap, DFSDM_CR1(fl_id),
-				  DFSDM_CR1_RSYNC_MASK,
-				  DFSDM_CR1_RSYNC(fl->sync_mode));
+	cr1 |= DFSDM_CR1_RSYNC(fl->sync_mode);
+
+	return regmap_update_bits(regmap, DFSDM_CR1(fl_id), DFSDM_CR1_CFG_MASK,
+				  cr1);
 }
 
 static int stm32_dfsdm_channel_parse_of(struct stm32_dfsdm *dfsdm,
@@ -426,47 +434,39 @@ static int stm32_dfsdm_start_conv(struct stm32_dfsdm_adc *adc,
 {
 	struct regmap *regmap = adc->dfsdm->regmap;
 	int ret;
-	unsigned int dma_en = 0, cont_en = 0;
+	unsigned int dma_en = 0;
 
 	ret = stm32_dfsdm_start_channel(adc->dfsdm, chan->channel);
 	if (ret < 0)
 		return ret;
 
-	ret = stm32_dfsdm_filter_configure(adc->dfsdm, adc->fl_id,
-					   chan->channel);
+	ret = stm32_dfsdm_filter_configure(adc, adc->fl_id, chan->channel);
 	if (ret < 0)
 		goto stop_channels;
 
 	if (dma) {
 		/* Enable DMA transfer*/
 		dma_en =  DFSDM_CR1_RDMAEN(1);
-		/* Enable conversion triggered by SPI clock*/
-		cont_en = DFSDM_CR1_RCONT(1);
 	}
 	/* Enable DMA transfer*/
 	ret = regmap_update_bits(regmap, DFSDM_CR1(adc->fl_id),
 				 DFSDM_CR1_RDMAEN_MASK, dma_en);
 	if (ret < 0)
-		goto stop_channels;
-
-	/* Enable conversion triggered by SPI clock*/
-	ret = regmap_update_bits(regmap, DFSDM_CR1(adc->fl_id),
-				 DFSDM_CR1_RCONT_MASK, cont_en);
-	if (ret < 0)
-		goto stop_channels;
+		goto filter_unconfigure;
 
 	ret = stm32_dfsdm_start_filter(adc->dfsdm, adc->fl_id);
 	if (ret < 0)
-		goto stop_channels;
+		goto stop_dma;
 
 	return 0;
 
-stop_channels:
+stop_dma:
 	regmap_update_bits(regmap, DFSDM_CR1(adc->fl_id),
 			   DFSDM_CR1_RDMAEN_MASK, 0);
-
+filter_unconfigure:
 	regmap_update_bits(regmap, DFSDM_CR1(adc->fl_id),
-			   DFSDM_CR1_RCONT_MASK, 0);
+			   DFSDM_CR1_CFG_MASK, 0);
+stop_channels:
 	stm32_dfsdm_stop_channel(adc->dfsdm, chan->channel);
 
 	return ret;
@@ -484,7 +484,7 @@ static void stm32_dfsdm_stop_conv(struct stm32_dfsdm_adc *adc,
 			   DFSDM_CR1_RDMAEN_MASK, 0);
 
 	regmap_update_bits(regmap, DFSDM_CR1(adc->fl_id),
-			   DFSDM_CR1_RCONT_MASK, 0);
+			   DFSDM_CR1_CFG_MASK, 0);
 
 	stm32_dfsdm_stop_channel(adc->dfsdm, chan->channel);
 }
-- 
2.7.4

