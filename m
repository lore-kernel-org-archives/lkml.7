Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD097C2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4820208E4
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577640367;
	bh=EdmkhEuQ/FOnFOegYYoZ0ze6bpaMjHBO2oZxRrqV5wg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=g7H68vruZ85jBHlyfeDKaLNy2cXQe3CRWxztVf98vkv6qBBhpLvucU29Fcp0hb2y2
	 23b5Y7cytkeSObvD1BjwjiTWgUIOICqf4L0M0p/gQw0G27zV7DiGIfY9cb2zwDbDPA
	 ncB/MX/f/NwANgxfHx90dH+SAqp5rONA9wI27X5s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbfL2R0G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 12:26:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:46558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728103AbfL2R0B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:26:01 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B17FF22B48;
        Sun, 29 Dec 2019 17:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577640361;
        bh=EdmkhEuQ/FOnFOegYYoZ0ze6bpaMjHBO2oZxRrqV5wg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lgBz6sGPYT2PMdliEOy4DGBhgaZJ7o1Qc8uwV/A5D0hIh4ZVIKaNiQXTttEr+Xdk2
         6NtiP2NgMywrVDg+yaenJLvjo0zzgURPs2N74PLNKdIqM/H/0ZcPNpxKVJz4FMIdPx
         fjygJ/xWDehIxCGOYxpoEw7SXxJ0oO9B4IXFOjmY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Manish Chopra <manishc@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 088/161] bnx2x: Fix PF-VF communication over multi-cos queues.
Date:   Sun, 29 Dec 2019 18:18:56 +0100
Message-Id: <20191229162425.208220935@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191229162355.500086350@linuxfoundation.org>
References: <20191229162355.500086350@linuxfoundation.org>
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
index 9ca994d0bab6..1977e0c552df 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.c
@@ -2389,15 +2389,21 @@ static int bnx2x_set_pf_tx_switching(struct bnx2x *bp, bool enable)
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



