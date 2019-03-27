Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25285C10F00
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC16D2147C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553710585;
	bh=UZYtGBwLlAtlVhpWS6zCDUYUv2qfEbVZk7YavJ5pYPE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=glrlEtMwtbiWw7UiA464aIBKpgI6kazwsm18JRF7b9Mp7ReMvZVDKwk5hhIQx3B4U
	 I2rWChfDG7shoElStvsFO5kVZbIOTl6hHGULZDwVwXOjdCq67pPdn1UaNmF0izjWs1
	 llHIcRMem91q98lwyeXvy96wOaNeOiZlFIzp8AF8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390035AbfC0SQX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:16:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:60348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389485AbfC0SQS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:16:18 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3CC5A2082F;
        Wed, 27 Mar 2019 18:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710578;
        bh=UZYtGBwLlAtlVhpWS6zCDUYUv2qfEbVZk7YavJ5pYPE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W4zAihwK80Zx/DM4+HpjgmN+G+MFgokmvBnZxpxHWK1ODX4cRLrzEbXxsnpoXnuYr
         lVqpNmKLz3dFP3lKoBTcoMrSt20hYYm8V0j3GcD7P3mcpIql7cdXM3O75qyeGpQAPI
         7BIPck7cM0jpzfkH/EyFWKkm3/ySRcXmWFLjW59o=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>,
        dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 186/192] dmaengine: tegra: avoid overflow of byte tracking
Date:   Wed, 27 Mar 2019 14:10:18 -0400
Message-Id: <20190327181025.13507-186-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327181025.13507-1-sashal@kernel.org>
References: <20190327181025.13507-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Dooks <ben.dooks@codethink.co.uk>

[ Upstream commit e486df39305864604b7e25f2a95d51039517ac57 ]

The dma_desc->bytes_transferred counter tracks the number of bytes
moved by the DMA channel. This is then used to calculate the information
passed back in the in the tegra_dma_tx_status callback, which is usually
fine.

When the DMA channel is configured as continous, then the bytes_transferred
counter will increase over time and eventually overflow to become negative
so the residue count will become invalid and the ALSA sound-dma code will
report invalid hardware pointer values to the application. This results in
some users becoming confused about the playout position and putting audio
data in the wrong place.

To fix this issue, always ensure the bytes_transferred field is modulo the
size of the request. We only do this for the case of the cyclic transfer
done ISR as anyone attempting to move 2GiB of DMA data in one transfer
is unlikely.

Note, we don't fix the issue that we should /never/ transfer a negative
number of bytes so we could make those fields unsigned.

Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
Acked-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/tegra20-apb-dma.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
index 9a558e30c461..8219ab88a507 100644
--- a/drivers/dma/tegra20-apb-dma.c
+++ b/drivers/dma/tegra20-apb-dma.c
@@ -636,7 +636,10 @@ static void handle_cont_sngl_cycle_dma_done(struct tegra_dma_channel *tdc,
 
 	sgreq = list_first_entry(&tdc->pending_sg_req, typeof(*sgreq), node);
 	dma_desc = sgreq->dma_desc;
-	dma_desc->bytes_transferred += sgreq->req_len;
+	/* if we dma for long enough the transfer count will wrap */
+	dma_desc->bytes_transferred =
+		(dma_desc->bytes_transferred + sgreq->req_len) %
+		dma_desc->bytes_requested;
 
 	/* Callback need to be call */
 	if (!dma_desc->cb_count)
-- 
2.19.1

