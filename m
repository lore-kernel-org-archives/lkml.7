Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C88C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 16:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C65A02064A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 16:47:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Z45Bm+cQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729869AbfHEQrJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 12:47:09 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.47.102]:39948 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728917AbfHEQpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 12:45:30 -0400
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 33464C01C4;
        Mon,  5 Aug 2019 16:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1565023529; bh=NrkjBg6jc1K2ARfPhxACOi8SqSjENTAt9JXKPTjf/tU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=Z45Bm+cQEJYQ+jdohaynKGXmOYfosf5mALndcBsGfg15iqK27mqK5LF+0UffUxqlJ
         wglGHKD0Qz6AzaiQmHFpmd3xv6mWzAUIloMF4bNOnHQ5PIjBkYjpr+KXas8rQ8SCIt
         7+OSVcLpXVqGuf5RH7ZDQDZbKab2Zf/c8xVzE57+8fW5mY0WF8QGZm62jw143MFrcP
         tyzYNo2Nfm+bjfVujK3fh88AMxyjS+maqf1tHR7SxYaMY8LrAepNdRsjENeyagOWwr
         f8CM3dsZwSWeXQNKXfsMydiA//qDu8Aq94OdQUUF2nmD3nmWHQN2haLKToG+b4FaBn
         d/J23R1L9fvZw==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id ED1F8A008D;
        Mon,  5 Aug 2019 16:45:27 +0000 (UTC)
From:   Jose Abreu <Jose.Abreu@synopsys.com>
To:     netdev@vger.kernel.org
Cc:     Joao Pinto <Joao.Pinto@synopsys.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        "David S. Miller" <davem@davemloft.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 16/26] net: stmmac: xgmac: Correctly return that RX descriptor is not last one
Date:   Mon,  5 Aug 2019 18:44:43 +0200
Message-Id: <acf41d185ca9d8ff03a09ef7c4b11dff1f9fac9f.1565022597.git.joabreu@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1565022597.git.joabreu@synopsys.com>
References: <cover.1565022597.git.joabreu@synopsys.com>
In-Reply-To: <cover.1565022597.git.joabreu@synopsys.com>
References: <cover.1565022597.git.joabreu@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return the correct value when RX descriptor is not the last one.

Signed-off-by: Jose Abreu <joabreu@synopsys.com>
---
Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: Alexandre Torgue <alexandre.torgue@st.com>
Cc: Jose Abreu <joabreu@synopsys.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: netdev@vger.kernel.org
Cc: linux-stm32@st-md-mailman.stormreply.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c
index d70a90c12dbc..bae8bd41a769 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c
@@ -26,16 +26,15 @@ static int dwxgmac2_get_rx_status(void *data, struct stmmac_extra_stats *x,
 				  struct dma_desc *p)
 {
 	unsigned int rdes3 = le32_to_cpu(p->des3);
-	int ret = good_frame;
 
 	if (unlikely(rdes3 & XGMAC_RDES3_OWN))
 		return dma_own;
 	if (likely(!(rdes3 & XGMAC_RDES3_LD)))
+		return rx_not_ls;
+	if (unlikely((rdes3 & XGMAC_RDES3_ES) && (rdes3 & XGMAC_RDES3_LD)))
 		return discard_frame;
-	if (unlikely(rdes3 & XGMAC_RDES3_ES))
-		ret = discard_frame;
 
-	return ret;
+	return good_frame;
 }
 
 static int dwxgmac2_get_tx_len(struct dma_desc *p)
-- 
2.7.4

