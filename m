Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E12C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 848182075E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554371136;
	bh=0lV/CQ5qNxmkH8DCfZXhIk+E4gWOH6stQvUW5x9D2+Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=H65YZJ6uXeCTlDHxGyxyHUR2HVFbrwgMP7foFZPQHrDGFB6V0s3r1xNhMvx6Q1Lce
	 wVGStubdgvgPiXd5CnWc8jkjNHkfMySAdn5BmCPFc3SSR67ziLkbe4hhWK5mQBA9oq
	 kWiB5JkK6Gd1rKoES7Wo33ERW0tjQscffn9VRWbg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731168AbfDDJpe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:45:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:35214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730969AbfDDI7E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:59:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF8772184B;
        Thu,  4 Apr 2019 08:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368343;
        bh=0lV/CQ5qNxmkH8DCfZXhIk+E4gWOH6stQvUW5x9D2+Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ELIHJIRMlgtClDTvDzcn4HEOjUPs6UacTEuXJzQgHF1JJPlwLNh48SiGonCSXDO3e
         Lsnm6bHsb3AtsuQZjpjHvcBTdavVMqe68QIWyKcwlUuMKhga28xIw16lKgHKrLSCKm
         6S40WIlqR/iZvDKfQYSWg4Kk3r5Tk9o0FYPiISdc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        Jon Hunter <jonathanh@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 119/121] dmaengine: tegra: avoid overflow of byte tracking
Date:   Thu,  4 Apr 2019 10:48:27 +0200
Message-Id: <20190404084551.669934154@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084545.245659903@linuxfoundation.org>
References: <20190404084545.245659903@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
index b9d75a54c896..7db2766b5fe9 100644
--- a/drivers/dma/tegra20-apb-dma.c
+++ b/drivers/dma/tegra20-apb-dma.c
@@ -635,7 +635,10 @@ static void handle_cont_sngl_cycle_dma_done(struct tegra_dma_channel *tdc,
 
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



