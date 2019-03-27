Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10736C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 12:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE4212087C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 12:22:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728883AbfC0MWd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 08:22:33 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:5043 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726233AbfC0MWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 08:22:33 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2RC8XTr021122;
        Wed, 27 Mar 2019 13:22:24 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2rddhtga81-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 27 Mar 2019 13:22:24 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 447BA31;
        Wed, 27 Mar 2019 12:22:23 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas23.st.com [10.75.90.46])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DD3CD5363;
        Wed, 27 Mar 2019 12:22:22 +0000 (GMT)
Received: from SAFEX1HUBCAS22.st.com (10.75.90.93) by SAFEX1HUBCAS23.st.com
 (10.75.90.46) with Microsoft SMTP Server (TLS) id 14.3.435.0; Wed, 27 Mar
 2019 13:22:22 +0100
Received: from localhost (10.48.0.131) by Webmail-ga.st.com (10.75.90.48) with
 Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 27 Mar 2019 13:22:22 +0100
From:   Arnaud Pouliquen <arnaud.pouliquen@st.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     Dan Williams <dan.j.williams@intel.com>, <arnaud.pouliquen@st.com>,
        Pierre-Yves MORDRET <pierre-yves.mordret@st.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>, <dmaengine@vger.kernel.org>
Subject: [PATCH] dmaengine: stm32-dma: fix residue calculation in stm32-dma
Date:   Wed, 27 Mar 2019 13:21:56 +0100
Message-ID: <1553689316-6231-1-git-send-email-arnaud.pouliquen@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.48.0.131]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-27_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During residue calculation. the DMA can switch to the next sg. When
this race condition occurs, the residue returned value is not valid.
Indeed the position in the sg returned by the hardware is the position
of the next sg, not the current sg.
Solution is to check the sg after the calculation to verify it.
If a transition is detected we consider that the DMA has switched to
the beginning of next sg.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
---
 drivers/dma/stm32-dma.c | 70 ++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 57 insertions(+), 13 deletions(-)

diff --git a/drivers/dma/stm32-dma.c b/drivers/dma/stm32-dma.c
index 4903a40..30309d2 100644
--- a/drivers/dma/stm32-dma.c
+++ b/drivers/dma/stm32-dma.c
@@ -1038,33 +1038,77 @@ static u32 stm32_dma_get_remaining_bytes(struct stm32_dma_chan *chan)
 	return ndtr << width;
 }
 
+static bool stm32_dma_is_current_sg(struct stm32_dma_chan *chan)
+{
+	struct stm32_dma_device *dmadev = stm32_dma_get_dev(chan);
+	struct stm32_dma_sg_req *sg_req;
+	u32 dma_scr, dma_smar, id;
+
+	id = chan->id;
+	dma_scr = stm32_dma_read(dmadev, STM32_DMA_SCR(id));
+
+	if (!(dma_scr & STM32_DMA_SCR_DBM))
+		return true;
+
+	sg_req = &chan->desc->sg_req[chan->next_sg];
+
+	if (dma_scr & STM32_DMA_SCR_CT) {
+		dma_smar = stm32_dma_read(dmadev, STM32_DMA_SM0AR(id));
+		return (dma_smar == sg_req->chan_reg.dma_sm0ar);
+	}
+
+	dma_smar = stm32_dma_read(dmadev, STM32_DMA_SM1AR(id));
+
+	return (dma_smar == sg_req->chan_reg.dma_sm1ar);
+}
+
 static size_t stm32_dma_desc_residue(struct stm32_dma_chan *chan,
 				     struct stm32_dma_desc *desc,
 				     u32 next_sg)
 {
 	u32 modulo, burst_size;
-	u32 residue = 0;
+	u32 residue;
+	u32 n_sg = next_sg;
+	struct stm32_dma_sg_req *sg_req = &chan->desc->sg_req[chan->next_sg];
 	int i;
 
+	residue = stm32_dma_get_remaining_bytes(chan);
+
 	/*
-	 * In cyclic mode, for the last period, residue = remaining bytes from
-	 * NDTR
+	 * Calculate the residue means compute the descriptors
+	 * information:
+	 * - the sg currently transferred
+	 * - the remaining position in this sg (NDTR).
+	 *
+	 * The issue is that a race condition can occur if DMA is
+	 * running. DMA can have started to transfer the next sg before
+	 * the position in sg is read. In this case the remaing position
+	 * can correspond to the new sg position.
+	 * The strategy implemented in the stm32 driver is to check the
+	 * sg transition. If detected we can not trust the SxNDTR register
+	 * value, this register can not be up to date during the transition.
+	 * In this case we can assume that the dma is at the beginning of next
+	 * sg so we calculate the residue in consequence.
 	 */
-	if (chan->desc->cyclic && next_sg == 0) {
-		residue = stm32_dma_get_remaining_bytes(chan);
-		goto end;
+
+	if (!stm32_dma_is_current_sg(chan)) {
+		n_sg++;
+		if (n_sg == chan->desc->num_sgs)
+			n_sg = 0;
+		residue = sg_req->len;
 	}
 
 	/*
-	 * For all other periods in cyclic mode, and in sg mode,
-	 * residue = remaining bytes from NDTR + remaining periods/sg to be
-	 * transferred
+	 * In cyclic mode, for the last period, residue = remaining bytes
+	 * from NDTR,
+	 * else for all other periods in cyclic mode, and in sg mode,
+	 * residue = remaining bytes from NDTR + remaining
+	 * periods/sg to be transferred
 	 */
-	for (i = next_sg; i < desc->num_sgs; i++)
-		residue += desc->sg_req[i].len;
-	residue += stm32_dma_get_remaining_bytes(chan);
+	if (!chan->desc->cyclic || n_sg != 0)
+		for (i = n_sg; i < desc->num_sgs; i++)
+			residue += desc->sg_req[i].len;
 
-end:
 	if (!chan->mem_burst)
 		return residue;
 
-- 
2.7.4

