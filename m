Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D07BCC17446
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 13:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A62CA2190F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 13:53:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hnq85HW3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbfKKNxC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 08:53:02 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:56638 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbfKKNw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 08:52:56 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id xABDqb9T090509;
        Mon, 11 Nov 2019 07:52:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1573480357;
        bh=1ejU+vd2T9/FB/A9l3rJiiNfVEy7pyhWG9mzxXGvrc8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=hnq85HW3l4Dpf5ZtpTMz7HnD2F0nuQyoB5bD+lMZRcIrRCCR4W2ViUWkt18ZVViW6
         FdGjIxcvoZnUU0a0WLWE3SdzFIhsYsN/3WYBtyLqjx8DiOfgGIBpidnQrKRhZdE6+i
         LAvIULA3O4cz77jyq899/u7nrqFHplIctwC1ycvw=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xABDqbg6001492
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Nov 2019 07:52:37 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 11
 Nov 2019 07:52:19 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 11 Nov 2019 07:52:20 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id xABDqE8q097668;
        Mon, 11 Nov 2019 07:52:33 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>, <nm@ti.com>,
        <ssantosh@kernel.org>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <grygorii.strashko@ti.com>, <lokeshvutla@ti.com>,
        <t-kristo@ti.com>, <tony@atomide.com>, <j-keerthy@ti.com>
Subject: [PATCH v5 05/15] dmaengine: Add support for reporting DMA cached data amount
Date:   Mon, 11 Nov 2019 15:53:20 +0200
Message-ID: <20191111135330.8235-6-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191111135330.8235-1-peter.ujfalusi@ti.com>
References: <20191111135330.8235-1-peter.ujfalusi@ti.com>
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
Reviewed-by: Tero Kristo <t-kristo@ti.com>
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
index 0e8b426bbde9..c4c5219030a6 100644
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

