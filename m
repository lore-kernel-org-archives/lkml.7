Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87AE1C33CBB
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 11:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 601B120880
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 11:01:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jUjkHp5J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbfK1LBN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 06:01:13 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:36362 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726987AbfK1LAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 06:00:15 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id xASB03G9123044;
        Thu, 28 Nov 2019 05:00:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1574938804;
        bh=1ejU+vd2T9/FB/A9l3rJiiNfVEy7pyhWG9mzxXGvrc8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=jUjkHp5JVl4RZhs8XuRgm28QRAzeaplL59MTXfgTHWnIG2x4Iv6aJYqhw8Skuxv+l
         MV+3jQ03NjH6/1OOopjZ8t8HL0EWO8EmgOenSy6HNNV7jl2s0aDB5/+gvV2Ye6yudX
         r5HQ7sLVo+F2n6s2TkdURqxNnGiGYnaGjiTkvBwY=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xASB03WN045705
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 28 Nov 2019 05:00:03 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 28
 Nov 2019 05:00:03 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 28 Nov 2019 05:00:03 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xASAxgJJ073287;
        Thu, 28 Nov 2019 05:00:00 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>, <nm@ti.com>,
        <ssantosh@kernel.org>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <grygorii.strashko@ti.com>, <lokeshvutla@ti.com>,
        <t-kristo@ti.com>, <tony@atomide.com>, <j-keerthy@ti.com>
Subject: [PATCH v6 05/17] dmaengine: Add support for reporting DMA cached data amount
Date:   Thu, 28 Nov 2019 12:59:33 +0200
Message-ID: <20191128105945.13071-6-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191128105945.13071-1-peter.ujfalusi@ti.com>
References: <20191128105945.13071-1-peter.ujfalusi@ti.com>
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

