Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12878C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D879420657
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554369595;
	bh=DrQJXkpVrW4dZ29PIH8fHDknVTau9TTwxIDz9sCEYzg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IZdcjo3B9oqZYLgF+f7uugeTH8wqsHwZVjZGdGwY8U0YelkJQVafBCriBUVaoeLQ4
	 6C1W27i32qoeqkOojFJJanqCv05+VhX85L5Wig7QGNhd8Y3gT+ovS9ROKdKs5M7wvT
	 yNG5WfMa6xiIo2NmYG/Jt1mrmAFFLN+DR66XzZWI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388392AbfDDJTy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:19:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:59730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388300AbfDDJRu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:17:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0AFB20820;
        Thu,  4 Apr 2019 09:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554369470;
        bh=DrQJXkpVrW4dZ29PIH8fHDknVTau9TTwxIDz9sCEYzg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xysiK8x4BXa4Md21lfUtxPwOT+io0Jj0OOU4EY6UDPdAkyKtdvqr8ByZrykA+e9fp
         YAET0hqZJGx/Mh5A9ogsl0b+e5isALpsaHJz3rIRTQhj8MpHgLgH32o7Yo7txiHJ4A
         ULMlI3OmQ3/Tk+TRFMbNDGaMCZUm6ik9irDOqplc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        Jon Hunter <jonathanh@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 236/246] dmaengine: tegra: avoid overflow of byte tracking
Date:   Thu,  4 Apr 2019 10:48:56 +0200
Message-Id: <20190404084627.551985183@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084619.236418459@linuxfoundation.org>
References: <20190404084619.236418459@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

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



