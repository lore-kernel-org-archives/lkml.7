Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD56C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 09:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 153FE2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 09:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732871AbfC0JGc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 05:06:32 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:2963 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725786AbfC0JGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 05:06:30 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2R96Aen011051;
        Wed, 27 Mar 2019 10:06:18 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2rddhtfcax-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 27 Mar 2019 10:06:18 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 532C93A;
        Wed, 27 Mar 2019 09:05:42 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas22.st.com [10.75.90.92])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2F0892B66;
        Wed, 27 Mar 2019 09:05:42 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by Safex1hubcas22.st.com
 (10.75.90.92) with Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 27 Mar
 2019 10:05:42 +0100
Received: from lmecxl0923.lme.st.com (10.48.0.237) by webmail-ga.st.com
 (10.75.90.48) with Microsoft SMTP Server (TLS) id 14.3.435.0; Wed, 27 Mar
 2019 10:05:40 +0100
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
Subject: [PATCH V4 1/5] mmc: mmci: add get_datactrl_cfg callback and helper functions
Date:   Wed, 27 Mar 2019 10:05:28 +0100
Message-ID: <1553677532-3539-2-git-send-email-ludovic.Barre@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1553677532-3539-1-git-send-email-ludovic.Barre@st.com>
References: <1553677532-3539-1-git-send-email-ludovic.Barre@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.48.0.237]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-27_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch adds get_datactrl_cfg callback in mmci_host_ops
to allow to get datactrl configuration specific at variant.
Common helper function is defined and could be call by variant.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index 6bde28c..35c91d0 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -362,6 +362,7 @@ struct mmci_host_ops {
 			 bool next);
 	void (*unprep_data)(struct mmci_host *host, struct mmc_data *data,
 			    int err);
+	u32 (*get_datactrl_cfg)(struct mmci_host *host);
 	void (*get_next_data)(struct mmci_host *host, struct mmc_data *data);
 	int (*dma_setup)(struct mmci_host *host);
 	void (*dma_release)(struct mmci_host *host);
@@ -429,6 +430,11 @@ struct mmci_host {
 void mmci_write_clkreg(struct mmci_host *host, u32 clk);
 void mmci_write_pwrreg(struct mmci_host *host, u32 pwr);
 
+static inline u32 mmci_dctrl_blksz(struct mmci_host *host)
+{
+	return (ffs(host->data->blksz) - 1) << 4;
+}
+
 #ifdef CONFIG_DMA_ENGINE
 int mmci_dmae_prep_data(struct mmci_host *host, struct mmc_data *data,
 			bool next);
-- 
2.7.4

