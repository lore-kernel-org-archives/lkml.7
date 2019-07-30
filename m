Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90999C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 09:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60A7120679
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 09:35:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="uiCpVRG/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731467AbfG3JfQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 05:35:16 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:51472 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731447AbfG3JfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 05:35:15 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x6U9Z97t046288;
        Tue, 30 Jul 2019 04:35:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1564479309;
        bh=l1+HONjf2p2srVPl+q2lau+bAc7cFYjjd944yTl+xYo=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=uiCpVRG/k6x5emdC4KnvD4W18zrgc4qih4Tqpa2+oQep04kaA99wHsa+y4yCqSYDN
         tKnTh65eNwTBaBNMwKUGrGHorv0TrR2WuonMyoJQkFhCEoD4cxlUihUyioWaaQzCfM
         Pa4Do4YIL/lBr6KQ3dsCaeYH2eIa0kaXSKKTE4qc=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x6U9Z9Lt048660
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 30 Jul 2019 04:35:09 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 30
 Jul 2019 04:35:07 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 30 Jul 2019 04:35:07 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x6U9YkU2027547;
        Tue, 30 Jul 2019 04:35:04 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>, <nm@ti.com>,
        <ssantosh@kernel.org>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <grygorii.strashko@ti.com>, <lokeshvutla@ti.com>,
        <t-kristo@ti.com>, <tony@atomide.com>, <j-keerthy@ti.com>
Subject: [PATCH v2 05/14] dmaengine: Add support for reporting DMA cached data amount
Date:   Tue, 30 Jul 2019 12:34:41 +0300
Message-ID: <20190730093450.12664-6-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190730093450.12664-1-peter.ujfalusi@ti.com>
References: <20190730093450.12664-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A DMA hardware can have big cache or FIFO and the amount of data sitting in
the DMA fabric can be an interest for the clients.

For example in audio we want to know the delay in the data flow and in case
the DMA have significantly large FIFO/cache, it can affect the latenc/delay

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/dmaengine.h   | 8 ++++++++
 include/linux/dmaengine.h | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/drivers/dma/dmaengine.h b/drivers/dma/dmaengine.h
index 501c0b063f85..b0b97475707a 100644
--- a/drivers/dma/dmaengine.h
+++ b/drivers/dma/dmaengine.h
@@ -77,6 +77,7 @@ static inline enum dma_status dma_cookie_status(struct dma_chan *chan,
 		state->last = complete;
 		state->used = used;
 		state->residue = 0;
+		state->in_flight_bytes = 0;
 	}
 	return dma_async_is_complete(cookie, complete, used);
 }
@@ -87,6 +88,13 @@ static inline void dma_set_residue(struct dma_tx_state *state, u32 residue)
 		state->residue = residue;
 }
 
+static inline void dma_set_in_flight_bytes(struct dma_tx_state *state,
+					   u32 in_flight_bytes)
+{
+	if (state)
+		state->in_flight_bytes = in_flight_bytes;
+}
+
 struct dmaengine_desc_callback {
 	dma_async_tx_callback callback;
 	dma_async_tx_callback_result callback_result;
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 40d062c3b359..02ceef95340a 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -682,11 +682,13 @@ static inline struct dma_async_tx_descriptor *txd_next(struct dma_async_tx_descr
  * @residue: the remaining number of bytes left to transmit
  *	on the selected transfer for states DMA_IN_PROGRESS and
  *	DMA_PAUSED if this is implemented in the driver, else 0
+ * @in_flight_bytes: amount of data in bytes cached by the DMA.
  */
 struct dma_tx_state {
 	dma_cookie_t last;
 	dma_cookie_t used;
 	u32 residue;
+	u32 in_flight_bytes;
 };
 
 /**
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

