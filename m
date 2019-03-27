Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E0E3C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1129C2063F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553711231;
	bh=x46UM5UzuTPb7WPdimqjcL8CDD8b14rPKln8z0xx/24=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fafn6/Par7sl29i21Nb3qPWtwZCKHE50+u4QZeINmwf2/3dqOZY2jJTmbrQzhL9QR
	 5jctX2pG+85WpSR0kit0iHmO2WghwFiPF0Ymig+5Mi7QwTLO+qgNbVf4n4ANr75SnE
	 zHW363qiFZi2kl2eqHXFpSut0bSRJYo9g2TiOOUQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391770AbfC0S0w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:26:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:46374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391719AbfC0S0e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:26:34 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D25020449;
        Wed, 27 Mar 2019 18:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553711193;
        bh=x46UM5UzuTPb7WPdimqjcL8CDD8b14rPKln8z0xx/24=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fC3gDLcsNJAkHuYutrVzl53DIA7ZjLtOl+zHuxWy3J1KbFOfmYN/mYHsSrkgZjkG3
         LYYDZ3/U+FsAg4jMp8W7ETxtD09tOPAelB22qWj6I5i3wxlqVwije2mpeq9qNkJihM
         soavPSA2zjlxhuJMBxk2rqkDFPfFvZEZxUgj/Yhw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>,
        dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH AUTOSEL 3.18 40/41] dmaengine: tegra: avoid overflow of byte tracking
Date:   Wed, 27 Mar 2019 14:25:17 -0400
Message-Id: <20190327182518.19394-40-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327182518.19394-1-sashal@kernel.org>
References: <20190327182518.19394-1-sashal@kernel.org>
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
index 16efa603ff65..8ebc43dbda3c 100644
--- a/drivers/dma/tegra20-apb-dma.c
+++ b/drivers/dma/tegra20-apb-dma.c
@@ -613,7 +613,10 @@ static void handle_cont_sngl_cycle_dma_done(struct tegra_dma_channel *tdc,
 
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

