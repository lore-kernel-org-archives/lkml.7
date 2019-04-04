Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F42C10F05
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF5B72075E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554370720;
	bh=35ge5w841acp8+JRmN+X9YBoaDbgbR1EPQSpzo3v18g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EN6ROpbhj8SEyaxh3qmruWTtHrDWc9bAOL9Pgy1e1oLe8N+hEtLK5xGtv0tmwqd16
	 UNg2mvusbfJaNueIbvrb/y0cyW2z6s+Vwz8TyTt+pRnwUhUgWXEZOWxmabZzPkRtTQ
	 aiTKoQuXAC+Y4C+uIwjpC4SIRbuYsJ87s6SM4cvU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731906AbfDDJEL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:04:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:41832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727489AbfDDJEG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:04:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF2F2214AF;
        Thu,  4 Apr 2019 09:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368645;
        bh=35ge5w841acp8+JRmN+X9YBoaDbgbR1EPQSpzo3v18g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GoTMokSUObsO0t3IW1cQ7/AtqOvsftjYGBjpDFVUAT6RQUAxAv3WHOvg8aQkGt1Lq
         tEhB6l59sP67S70v8YGj8QYj0b9xZ5xq80eiLVYMJbd9Qv9nMS7LrBaZme4++lyxg+
         xuGW5Qt3u2IJ9DI4makJ713Qv1u98v+efx4zFZG0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Rakesh Pillai <pillair@codeaurora.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 108/187] ath10k: fix shadow register implementation for WCN3990
Date:   Thu,  4 Apr 2019 10:47:25 +0200
Message-Id: <20190404084608.345843636@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084603.119654039@linuxfoundation.org>
References: <20190404084603.119654039@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 1863008369ae0407508033b4b00f98b985adeb15 ]

WCN3990 supports shadow registers write operation support
for copy engine for regular operation in powersave mode.

Since WCN3990 is a 64-bit target, the shadow register
implementation needs to be done in the copy engine handlers
for 64-bit target. Currently the shadow register implementation
is present in the 32-bit target handlers of copy engine.

Fix the shadow register copy engine write operation
implementation for 64-bit target(WCN3990).

Tested HW: WCN3990
Tested FW: WLAN.HL.2.0-01188-QCAHLSWMTPLZ-1

Fixes: b7ba83f7c414 ("ath10k: add support for shadow register for WNC3990")
Signed-off-by: Rakesh Pillai <pillair@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath10k/ce.c | 26 +++++++++++++-------------
 drivers/net/wireless/ath/ath10k/ce.h |  2 +-
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/ce.c b/drivers/net/wireless/ath/ath10k/ce.c
index 18c709c484e7..f761d651c16e 100644
--- a/drivers/net/wireless/ath/ath10k/ce.c
+++ b/drivers/net/wireless/ath/ath10k/ce.c
@@ -500,14 +500,8 @@ static int _ath10k_ce_send_nolock(struct ath10k_ce_pipe *ce_state,
 	write_index = CE_RING_IDX_INCR(nentries_mask, write_index);
 
 	/* WORKAROUND */
-	if (!(flags & CE_SEND_FLAG_GATHER)) {
-		if (ar->hw_params.shadow_reg_support)
-			ath10k_ce_shadow_src_ring_write_index_set(ar, ce_state,
-								  write_index);
-		else
-			ath10k_ce_src_ring_write_index_set(ar, ctrl_addr,
-							   write_index);
-	}
+	if (!(flags & CE_SEND_FLAG_GATHER))
+		ath10k_ce_src_ring_write_index_set(ar, ctrl_addr, write_index);
 
 	src_ring->write_index = write_index;
 exit:
@@ -581,8 +575,14 @@ static int _ath10k_ce_send_nolock_64(struct ath10k_ce_pipe *ce_state,
 	/* Update Source Ring Write Index */
 	write_index = CE_RING_IDX_INCR(nentries_mask, write_index);
 
-	if (!(flags & CE_SEND_FLAG_GATHER))
-		ath10k_ce_src_ring_write_index_set(ar, ctrl_addr, write_index);
+	if (!(flags & CE_SEND_FLAG_GATHER)) {
+		if (ar->hw_params.shadow_reg_support)
+			ath10k_ce_shadow_src_ring_write_index_set(ar, ce_state,
+								  write_index);
+		else
+			ath10k_ce_src_ring_write_index_set(ar, ctrl_addr,
+							   write_index);
+	}
 
 	src_ring->write_index = write_index;
 exit:
@@ -1394,12 +1394,12 @@ static int ath10k_ce_alloc_shadow_base(struct ath10k *ar,
 				       u32 nentries)
 {
 	src_ring->shadow_base_unaligned = kcalloc(nentries,
-						  sizeof(struct ce_desc),
+						  sizeof(struct ce_desc_64),
 						  GFP_KERNEL);
 	if (!src_ring->shadow_base_unaligned)
 		return -ENOMEM;
 
-	src_ring->shadow_base = (struct ce_desc *)
+	src_ring->shadow_base = (struct ce_desc_64 *)
 			PTR_ALIGN(src_ring->shadow_base_unaligned,
 				  CE_DESC_RING_ALIGN);
 	return 0;
@@ -1453,7 +1453,7 @@ ath10k_ce_alloc_src_ring(struct ath10k *ar, unsigned int ce_id,
 		ret = ath10k_ce_alloc_shadow_base(ar, src_ring, nentries);
 		if (ret) {
 			dma_free_coherent(ar->dev,
-					  (nentries * sizeof(struct ce_desc) +
+					  (nentries * sizeof(struct ce_desc_64) +
 					   CE_DESC_RING_ALIGN),
 					  src_ring->base_addr_owner_space_unaligned,
 					  base_addr);
diff --git a/drivers/net/wireless/ath/ath10k/ce.h b/drivers/net/wireless/ath/ath10k/ce.h
index b8fb5382dede..8088f7a66426 100644
--- a/drivers/net/wireless/ath/ath10k/ce.h
+++ b/drivers/net/wireless/ath/ath10k/ce.h
@@ -118,7 +118,7 @@ struct ath10k_ce_ring {
 	u32 base_addr_ce_space;
 
 	char *shadow_base_unaligned;
-	struct ce_desc *shadow_base;
+	struct ce_desc_64 *shadow_base;
 
 	/* keep last */
 	void *per_transfer_context[0];
-- 
2.19.1



