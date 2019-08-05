Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB72CC433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C209E2067D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565011048;
	bh=fampBdmvc6C9LDTjDlqixoNpsemgYuvhH//ZsTqdaO0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lzS9p0U8eUY9Je4VLOXbdUmBQ7KcFh/dEOQWNMxD86KOjm46z/RMUWvrwnNDsUwK2
	 DN2orQxj50UCxBl/CeW7RDUvi7LeZ7J+05UIMKP6IMTz6AJkRWX7c72wuKQwp7/xX3
	 aUKVV4xDyN1iI/mLimi4ZBH9HAFo3efFRnFq7mtY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729272AbfHENFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 09:05:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:41296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729261AbfHENFQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 09:05:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD5E4206C1;
        Mon,  5 Aug 2019 13:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565010315;
        bh=fampBdmvc6C9LDTjDlqixoNpsemgYuvhH//ZsTqdaO0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iHTSgpIyygLDPt0da55WpjTXS6YPXPSu9BQ3yC1bX5VlwjABLFpK5eCPlPmHRwe1W
         hatXpgTTJyMr/1FMtyjs22vjW5+/X1+J4K2+bYZvx4JBoSUxnV5+I2xYWyOWV0obhl
         193u9x0z4t2dmBfn/myTpQjGeiiBkJaVb6XNJs94=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eugeniu Rosca <erosca@de.adit-jv.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH 4.9 08/42] dmaengine: rcar-dmac: Reject zero-length slave DMA requests
Date:   Mon,  5 Aug 2019 15:02:34 +0200
Message-Id: <20190805124925.840128759@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190805124924.788666484@linuxfoundation.org>
References: <20190805124924.788666484@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 78efb76ab4dfb8f74f290ae743f34162cd627f19 ]

While the .device_prep_slave_sg() callback rejects empty scatterlists,
it still accepts single-entry scatterlists with a zero-length segment.
These may happen if a driver calls dmaengine_prep_slave_single() with a
zero len parameter.  The corresponding DMA request will never complete,
leading to messages like:

    rcar-dmac e7300000.dma-controller: Channel Address Error happen

and DMA timeouts.

Although requesting a zero-length DMA request is a driver bug, rejecting
it early eases debugging.  Note that the .device_prep_dma_memcpy()
callback already rejects requests to copy zero bytes.

Reported-by: Eugeniu Rosca <erosca@de.adit-jv.com>
Analyzed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/sh/rcar-dmac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
index f37a6ef4f5441..e4fe24be3d7a4 100644
--- a/drivers/dma/sh/rcar-dmac.c
+++ b/drivers/dma/sh/rcar-dmac.c
@@ -1111,7 +1111,7 @@ rcar_dmac_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 	struct rcar_dmac_chan *rchan = to_rcar_dmac_chan(chan);
 
 	/* Someone calling slave DMA on a generic channel? */
-	if (rchan->mid_rid < 0 || !sg_len) {
+	if (rchan->mid_rid < 0 || !sg_len || !sg_dma_len(sgl)) {
 		dev_warn(chan->device->dev,
 			 "%s: bad parameter: len=%d, id=%d\n",
 			 __func__, sg_len, rchan->mid_rid);
-- 
2.20.1



