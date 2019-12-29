Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A6B8C2D0DA
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 18:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE03221744
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 18:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577642663;
	bh=ZeHTMdhH/o3SLrhCZyqU8VkRPO6te8Z/BTNs+A7H9eY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NslAzAPwWdcxGKl2aCVK2AeB2LObt2JqxgpmK9wUhiu7HPoiuXKL+4jBCBXXjGCxP
	 tVSfgExcLaAzHmqsTOOHkr/6eQq0yOxbaIyi7OcOc6PBQ/jFxZh98nOS+nC9agFBK7
	 rZoOM1QHz+pOfsIcbBC/sRzLNHD1NAA8gjJpYQvc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732268AbfL2RwZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 12:52:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:38432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731948AbfL2RwS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:52:18 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6584E22B48;
        Sun, 29 Dec 2019 17:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577641937;
        bh=ZeHTMdhH/o3SLrhCZyqU8VkRPO6te8Z/BTNs+A7H9eY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oCPWFv2pIEPOid54Iuh221DMhZdazRoLZ4JQj+blfz+5V3tl3E3lfM2gx0UIJ7c2i
         +VXDMPO1HxkGZGDLtFY+z8/OovIldfIWX2TsBWhcUC8EyyyR3MD6vRkQoFBBQzV2XY
         cBGaWjF2yy2XW4MpyfjN29f9UMU6TeLE/F/2eN0Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Manish Chopra <manishc@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 237/434] bnx2x: Fix PF-VF communication over multi-cos queues.
Date:   Sun, 29 Dec 2019 18:24:50 +0100
Message-Id: <20191229172717.624952378@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191229172702.393141737@linuxfoundation.org>
References: <20191229172702.393141737@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Manish Chopra <manishc@marvell.com>

[ Upstream commit dc5a3d79c345871439ffe72550b604fcde9770e1 ]

PF driver doesn't enable tx-switching for all cos queues/clients,
which causes packets drop from PF to VF. Fix this by enabling
tx-switching on all cos queues/clients.

Signed-off-by: Manish Chopra <manishc@marvell.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/broadcom/bnx2x/bnx2x_sriov.c    | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.c
index 0edbb0a76847..5097a44686b3 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.c
@@ -2397,15 +2397,21 @@ static int bnx2x_set_pf_tx_switching(struct bnx2x *bp, bool enable)
 	/* send the ramrod on all the queues of the PF */
 	for_each_eth_queue(bp, i) {
 		struct bnx2x_fastpath *fp = &bp->fp[i];
+		int tx_idx;
 
 		/* Set the appropriate Queue object */
 		q_params.q_obj = &bnx2x_sp_obj(bp, fp).q_obj;
 
-		/* Update the Queue state */
-		rc = bnx2x_queue_state_change(bp, &q_params);
-		if (rc) {
-			BNX2X_ERR("Failed to configure Tx switching\n");
-			return rc;
+		for (tx_idx = FIRST_TX_COS_INDEX;
+		     tx_idx < fp->max_cos; tx_idx++) {
+			q_params.params.update.cid_index = tx_idx;
+
+			/* Update the Queue state */
+			rc = bnx2x_queue_state_change(bp, &q_params);
+			if (rc) {
+				BNX2X_ERR("Failed to configure Tx switching\n");
+				return rc;
+			}
 		}
 	}
 
-- 
2.20.1



