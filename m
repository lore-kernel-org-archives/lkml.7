Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFBCAC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E80F213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552504340;
	bh=WddH+or7KxxhUfkW8V+8x1zLcdH6jgiEi3Y72pPxG8k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Cgpc0F3t2PGZTcYvhcqtHw5dNUUYAy5WYs8hqbqOI6cs9C2wFXHOdgWpXU9H87Pfd
	 B+BngrJuDx3jl5C6ZXqZX8eHrdR0tbOizWES6rexQqyN6IlOO1MWfULb6iqtXUkcK3
	 58nuUn2r3YwbjvdlWeFG6sxE3JDAapbZdwdDujR4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbfCMTMS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 15:12:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:42884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727177AbfCMTMP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 15:12:15 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0480C20693;
        Wed, 13 Mar 2019 19:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552504334;
        bh=WddH+or7KxxhUfkW8V+8x1zLcdH6jgiEi3Y72pPxG8k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IO9zPFFm6sxvkCZ+DrgyFmWMyQIsQlUNG5Q7xUc8cvirM/mOm+xFyWBXNtgnY9shq
         LugGFSZ2XLIMbwJbI0TCZKcKZNQNsZKCdBX65QRSGKbMxP/eiD2oD3Suj2pj+oTSO4
         7Xx4Pte+fDE5mXngoARr6jxzxPKzsxPyrXvLp75U=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jan Sokolowski <jan.sokolowski@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        xdp-newbies@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 47/60] ixgbe: don't do any AF_XDP zero-copy transmit if netif is not OK
Date:   Wed, 13 Mar 2019 15:10:08 -0400
Message-Id: <20190313191021.158171-47-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190313191021.158171-1-sashal@kernel.org>
References: <20190313191021.158171-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Sokolowski <jan.sokolowski@intel.com>

[ Upstream commit c685c69fba71462c3f9f6a1fb6151cded6c74d42 ]

An issue has been found while testing zero-copy XDP that
causes a reset to be triggered. As it takes some time to
turn the carrier on after setting zc, and we already
start trying to transmit some packets, watchdog considers
this as an erroneous state and triggers a reset.

Don't do any work if netif carrier is not OK.

Fixes: 8221c5eba8c13 (ixgbe: add AF_XDP zero-copy Tx support)
Signed-off-by: Jan Sokolowski <jan.sokolowski@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
index 654ae92342ea..36a8879536a4 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
@@ -642,7 +642,8 @@ static bool ixgbe_xmit_zc(struct ixgbe_ring *xdp_ring, unsigned int budget)
 	dma_addr_t dma;
 
 	while (budget-- > 0) {
-		if (unlikely(!ixgbe_desc_unused(xdp_ring))) {
+		if (unlikely(!ixgbe_desc_unused(xdp_ring)) ||
+		    !netif_carrier_ok(xdp_ring->netdev)) {
 			work_done = false;
 			break;
 		}
-- 
2.19.1

