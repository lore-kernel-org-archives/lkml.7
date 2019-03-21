Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43ECCC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 16:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ABD12183E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 16:48:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728600AbfCUQr7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 12:47:59 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:52952 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727829AbfCUQr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 12:47:59 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2LGkq7k008000;
        Thu, 21 Mar 2019 17:47:39 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2r8rwkek1p-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 21 Mar 2019 17:47:39 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2BDA53F;
        Thu, 21 Mar 2019 16:47:39 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id F11335672;
        Thu, 21 Mar 2019 16:47:38 +0000 (GMT)
Received: from localhost (10.75.127.47) by SFHDAG5NODE3.st.com (10.75.127.15)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 21 Mar 2019 17:47:38
 +0100
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
To:     <jic23@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <fabrice.gasnier@st.com>,
        <linux-iio@vger.kernel.org>, <lars@metafoo.de>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>, <linux-stm32@st-md-mailman.stormreply.com>,
        <arnaud.pouliquen@st.com>, <olivier.moysan@st.com>
Subject: [PATCH v2 4/8] iio: adc: stm32-dfsdm: move dma slave config to start routine
Date:   Thu, 21 Mar 2019 17:47:25 +0100
Message-ID: <1553186849-6261-5-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1553186849-6261-1-git-send-email-fabrice.gasnier@st.com>
References: <1553186849-6261-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG5NODE3.st.com (10.75.127.15) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-21_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move DMA slave configuration to start routine: depending on regular or
injected mode is in use, DMA needs to read resp. RDATAR or JDATAR.
This is precursor patch to introduce injected mode (used for scan).

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 drivers/iio/adc/stm32-dfsdm-adc.c | 31 +++++++++++--------------------
 1 file changed, 11 insertions(+), 20 deletions(-)

diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
index 818627f..66e2ea0 100644
--- a/drivers/iio/adc/stm32-dfsdm-adc.c
+++ b/drivers/iio/adc/stm32-dfsdm-adc.c
@@ -556,6 +556,11 @@ static void stm32_dfsdm_audio_dma_buffer_done(void *data)
 static int stm32_dfsdm_adc_dma_start(struct iio_dev *indio_dev)
 {
 	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
+	struct dma_slave_config config = {
+		.src_addr = (dma_addr_t)adc->dfsdm->phys_base +
+			DFSDM_RDATAR(adc->fl_id),
+		.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES,
+	};
 	struct dma_async_tx_descriptor *desc;
 	dma_cookie_t cookie;
 	int ret;
@@ -566,6 +571,10 @@ static int stm32_dfsdm_adc_dma_start(struct iio_dev *indio_dev)
 	dev_dbg(&indio_dev->dev, "%s size=%d watermark=%d\n", __func__,
 		adc->buf_sz, adc->buf_sz / 2);
 
+	ret = dmaengine_slave_config(adc->dma_chan, &config);
+	if (ret)
+		return ret;
+
 	/* Prepare a DMA cyclic transaction */
 	desc = dmaengine_prep_dma_cyclic(adc->dma_chan,
 					 adc->dma_buf,
@@ -925,12 +934,6 @@ static void stm32_dfsdm_dma_release(struct iio_dev *indio_dev)
 static int stm32_dfsdm_dma_request(struct iio_dev *indio_dev)
 {
 	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
-	struct dma_slave_config config = {
-		.src_addr = (dma_addr_t)adc->dfsdm->phys_base +
-			DFSDM_RDATAR(adc->fl_id),
-		.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES,
-	};
-	int ret;
 
 	adc->dma_chan = dma_request_slave_channel(&indio_dev->dev, "rx");
 	if (!adc->dma_chan)
@@ -940,23 +943,11 @@ static int stm32_dfsdm_dma_request(struct iio_dev *indio_dev)
 					 DFSDM_DMA_BUFFER_SIZE,
 					 &adc->dma_buf, GFP_KERNEL);
 	if (!adc->rx_buf) {
-		ret = -ENOMEM;
-		goto err_release;
+		dma_release_channel(adc->dma_chan);
+		return -ENOMEM;
 	}
 
-	ret = dmaengine_slave_config(adc->dma_chan, &config);
-	if (ret)
-		goto err_free;
-
 	return 0;
-
-err_free:
-	dma_free_coherent(adc->dma_chan->device->dev, DFSDM_DMA_BUFFER_SIZE,
-			  adc->rx_buf, adc->dma_buf);
-err_release:
-	dma_release_channel(adc->dma_chan);
-
-	return ret;
 }
 
 static int stm32_dfsdm_adc_chan_init_one(struct iio_dev *indio_dev,
-- 
2.7.4

