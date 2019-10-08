Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D74BC10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 09:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36D37206C2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 09:56:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="wWOV9dln"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730520AbfJHJ4h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 05:56:37 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:20524 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730471AbfJHJ4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 05:56:34 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x989oqB2017657;
        Tue, 8 Oct 2019 11:56:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=D1YTtXGlnn9n+wzMgmKua3M6JR/Hf72FY8yVMBQwtWI=;
 b=wWOV9dlnI7b6wCn4MtpVrTkngtTOGrtkV+7uI304jlygQIo0HZnhy2bmoAAC+rDCaAOi
 RnoFi1Z75OPIfdl+J8qwKHXWSMnZHf8SqCECwbDvUITf/bKCNqd+FbnegDoUij9cu4B6
 mf6CJGoLaAA+NqUenNV4QQ/ej5Rd7kkFKW28/ii4HX8tXKcGeBVOiAe1A3UPxT8TjUip
 VwqaGi56ABUH2z47yR/yB+efUHuIo4B/x5iHd5tH9ImE0rBKhbu3pDIywgE/KquKomIk
 1EYE4wuVA1MK4iOKRGcFxngbXaM6sGAdE8K7L9+SKbm2Ewf5EDLYNtZKM6pjqy7n/IBh Ag== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2vegn0qfsd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Oct 2019 11:56:23 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 992D310002A;
        Tue,  8 Oct 2019 11:56:22 +0200 (CEST)
Received: from Webmail-eu.st.com (Safex1hubcas22.st.com [10.75.90.92])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8E79A2B40AF;
        Tue,  8 Oct 2019 11:56:22 +0200 (CEST)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.46) by Safex1hubcas22.st.com
 (10.75.90.92) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 8 Oct 2019
 11:56:22 +0200
Received: from lmecxl0923.lme.st.com (10.48.0.237) by webmail-ga.st.com
 (10.75.90.48) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 8 Oct 2019
 11:56:21 +0200
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
Subject: [PATCH V7 3/3] mmc: mmci: sdmmc: add busy_complete callback
Date:   Tue, 8 Oct 2019 11:56:04 +0200
Message-ID: <20191008095604.20675-4-ludovic.Barre@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191008095604.20675-1-ludovic.Barre@st.com>
References: <20191008095604.20675-1-ludovic.Barre@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.48.0.237]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-08_03:2019-10-07,2019-10-08 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch adds a specific busy_complete callback for sdmmc variant.

sdmmc has 2 status flags:
-busyd0: This is a hardware status flag (inverted value of d0 line).
it does not generate an interrupt.
-busyd0end: This indicates only end of busy following a CMD response.
On busy to Not busy changes, an interrupt is generated (if unmask)
and BUSYD0END status flag is set. Status flag is cleared by writing
corresponding interrupt clear bit in MMCICLEAR.

The legacy busy completion has no dedicated interrupt for the end
of busy, so it's must monitor step by step the busy progression.
On sdmmc variant, this procedure is not needed, it's just need
to wait the busyd0end interrupt.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.c             |  4 +++
 drivers/mmc/host/mmci.h             |  1 +
 drivers/mmc/host/mmci_stm32_sdmmc.c | 42 +++++++++++++++++++++++++++++
 3 files changed, 47 insertions(+)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 5e53f9b6d82a..40e72c30ea84 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -262,6 +262,10 @@ static struct variant_data variant_stm32_sdmmc = {
 	.datalength_bits	= 25,
 	.datactrl_blocksz	= 14,
 	.stm32_idmabsize_mask	= GENMASK(12, 5),
+	.busy_timeout		= true,
+	.busy_detect		= true,
+	.busy_detect_flag	= MCI_STM32_BUSYD0,
+	.busy_detect_mask	= MCI_STM32_BUSYD0ENDMASK,
 	.init			= sdmmc_variant_init,
 };
 
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index 2a0b98f98c36..158e1231aa23 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -164,6 +164,7 @@
 #define MCI_ST_CARDBUSY		(1 << 24)
 /* Extended status bits for the STM32 variants */
 #define MCI_STM32_BUSYD0	BIT(20)
+#define MCI_STM32_BUSYD0END	BIT(21)
 
 #define MMCICLEAR		0x038
 #define MCI_CMDCRCFAILCLR	(1 << 0)
diff --git a/drivers/mmc/host/mmci_stm32_sdmmc.c b/drivers/mmc/host/mmci_stm32_sdmmc.c
index 8e83ae6920ae..1de855d29ad4 100644
--- a/drivers/mmc/host/mmci_stm32_sdmmc.c
+++ b/drivers/mmc/host/mmci_stm32_sdmmc.c
@@ -282,6 +282,47 @@ static u32 sdmmc_get_dctrl_cfg(struct mmci_host *host)
 	return datactrl;
 }
 
+static bool sdmmc_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
+{
+	void __iomem *base = host->base;
+	u32 busy_d0, busy_d0end, mask, sdmmc_status;
+
+	mask = readl_relaxed(base + MMCIMASK0);
+	sdmmc_status = readl_relaxed(base + MMCISTATUS);
+	busy_d0end = sdmmc_status & MCI_STM32_BUSYD0END;
+	busy_d0 = sdmmc_status & MCI_STM32_BUSYD0;
+
+	/* complete if there is an error or busy_d0end */
+	if ((status & err_msk) || busy_d0end)
+		goto complete;
+
+	/*
+	 * On response the busy signaling is reflected in the BUSYD0 flag.
+	 * if busy_d0 is in-progress we must activate busyd0end interrupt
+	 * to wait this completion. Else this request has no busy step.
+	 */
+	if (busy_d0) {
+		if (!host->busy_status) {
+			writel_relaxed(mask | host->variant->busy_detect_mask,
+				       base + MMCIMASK0);
+			host->busy_status = status &
+				(MCI_CMDSENT | MCI_CMDRESPEND);
+		}
+		return false;
+	}
+
+complete:
+	if (host->busy_status) {
+		writel_relaxed(mask & ~host->variant->busy_detect_mask,
+			       base + MMCIMASK0);
+		writel_relaxed(host->variant->busy_detect_mask,
+			       base + MMCICLEAR);
+		host->busy_status = 0;
+	}
+
+	return true;
+}
+
 static struct mmci_host_ops sdmmc_variant_ops = {
 	.validate_data = sdmmc_idma_validate_data,
 	.prep_data = sdmmc_idma_prep_data,
@@ -292,6 +333,7 @@ static struct mmci_host_ops sdmmc_variant_ops = {
 	.dma_finalize = sdmmc_idma_finalize,
 	.set_clkreg = mmci_sdmmc_set_clkreg,
 	.set_pwrreg = mmci_sdmmc_set_pwrreg,
+	.busy_complete = sdmmc_busy_complete,
 };
 
 void sdmmc_variant_init(struct mmci_host *host)
-- 
2.17.1

