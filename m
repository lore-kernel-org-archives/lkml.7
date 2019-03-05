Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 708ABC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 16:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48DE720842
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 16:10:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728688AbfCEQKq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 11:10:46 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:55476 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726190AbfCEQK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 11:10:27 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x25G9U4f025443;
        Tue, 5 Mar 2019 17:10:16 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2qyhkn2f6w-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 05 Mar 2019 17:10:16 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 00FCB34;
        Tue,  5 Mar 2019 16:10:12 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas21.st.com [10.75.90.44])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id CFBD64DF5;
        Tue,  5 Mar 2019 16:10:12 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by SAFEX1HUBCAS21.st.com
 (10.75.90.44) with Microsoft SMTP Server (TLS) id 14.3.361.1; Tue, 5 Mar 2019
 17:10:12 +0100
Received: from lmecxl0923.lme.st.com (10.48.0.237) by webmail-ga.st.com
 (10.75.90.48) with Microsoft SMTP Server (TLS) id 14.3.361.1; Tue, 5 Mar 2019
 17:10:12 +0100
From:   Ludovic Barre <ludovic.Barre@st.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <srinivas.kandagatla@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Ludovic Barre <ludovic.barre@st.com>
Subject: [PATCH  4/4] mmc: mmci: add busy detect for stm32 sdmmc variant
Date:   Tue, 5 Mar 2019 17:10:05 +0100
Message-ID: <1551802205-32188-5-git-send-email-ludovic.Barre@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551802205-32188-1-git-send-email-ludovic.Barre@st.com>
References: <1551802205-32188-1-git-send-email-ludovic.Barre@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.48.0.237]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-05_09:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch enables busy detection for stm32 sdmmc which requires
to set data timer to define the busy timeout.
sdmmc has 2 flags:
-busyd0: inverted value of d0 line.
-busyd0end which indicates only end of busy following a cmd response.
Only one interrupt on busyd0end.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.c | 4 ++++
 drivers/mmc/host/mmci.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index d1b7563..1011c99 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -283,6 +283,10 @@ static struct variant_data variant_stm32_sdmmc = {
 	.datalength_bits	= 25,
 	.datactrl_blocksz	= 14,
 	.stm32_idmabsize_mask	= GENMASK(12, 5),
+	.busy_detect		= true,
+	.busy_timeout		= true,
+	.busy_detect_flag	= MCI_STM32_BUSYD0,
+	.busy_detect_mask	= MCI_STM32_BUSYD0ENDMASK,
 	.init			= sdmmc_variant_init,
 };
 
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index 7d9eb92..9179a6c 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -162,6 +162,7 @@
 #define MCI_ST_CARDBUSY		(1 << 24)
 /* Extended status bits for the STM32 variants */
 #define MCI_STM32_BUSYD0	BIT(20)
+#define MCI_STM32_BUSYD0END	BIT(21)
 
 #define MMCICLEAR		0x038
 #define MCI_CMDCRCFAILCLR	(1 << 0)
-- 
2.7.4

