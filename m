Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F6B0CA9EC9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 22:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20E46205C9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 22:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572905031;
	bh=rEw6/0ngp8Wp6WGOhAm91Smw+MfbABi+s3SIPmYgjGY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yDzXXrTuJ2PAhWQDjHY1nvlCCw0jGN/GHKthjXcnoDwe8dDOS60/afaJhK1d7Ylwg
	 RxqtyI1aWbxWKyOD0TPTT/CZCzNQQZAmC4jEgyWHL7vgzku4ijb7oGSCDVGOhk52YG
	 6be2Tcc93izOdzORwVSflv9J/0RoJozDzxrvV0JM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389123AbfKDWDt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 17:03:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:34176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389562AbfKDWDp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 17:03:45 -0500
Received: from localhost (6.204-14-84.ripe.coltfrance.com [84.14.204.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8F95205C9;
        Mon,  4 Nov 2019 22:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572905024;
        bh=rEw6/0ngp8Wp6WGOhAm91Smw+MfbABi+s3SIPmYgjGY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1fg5Z2VeGF+kxQJMIqKov6UqG4Sf06p+bii+cPBwOVIz+oH9S5fbGr8i1k+z+re8N
         eH2Drdnh1EW1/oIMYGsjDZCPBrsjUHVfGW3SWw7RsLsHIVG+6CzNTfu4a90qThBMG+
         SKHYhdiqY869hHRFVOnpb9pcIei6cOCB19NYqL+g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Yegor Yefremov <yegorslists@googlemail.com>,
        Tony Lindgren <tony@atomide.com>, Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 4.19 132/149] dmaengine: cppi41: Fix cppi41_dma_prep_slave_sg() when idle
Date:   Mon,  4 Nov 2019 22:45:25 +0100
Message-Id: <20191104212146.038294606@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191104212126.090054740@linuxfoundation.org>
References: <20191104212126.090054740@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Lindgren <tony@atomide.com>

commit bacdcb6675e170bb2e8d3824da220e10274f42a7 upstream.

Yegor Yefremov <yegorslists@googlemail.com> reported that musb and ftdi
uart can fail for the first open of the uart unless connected using
a hub.

This is because the first dma call done by musb_ep_program() must wait
if cppi41 is PM runtime suspended. Otherwise musb_ep_program() continues
with other non-dma packets before the DMA transfer is started causing at
least ftdi uarts to fail to receive data.

Let's fix the issue by waking up cppi41 with PM runtime calls added to
cppi41_dma_prep_slave_sg() and return NULL if still idled. This way we
have musb_ep_program() continue with PIO until cppi41 is awake.

Fixes: fdea2d09b997 ("dmaengine: cppi41: Add basic PM runtime support")
Reported-by: Yegor Yefremov <yegorslists@googlemail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Cc: stable@vger.kernel.org # v4.9+
Link: https://lore.kernel.org/r/20191023153138.23442-1-tony@atomide.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/dma/ti/cppi41.c |   21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

--- a/drivers/dma/ti/cppi41.c
+++ b/drivers/dma/ti/cppi41.c
@@ -585,9 +585,22 @@ static struct dma_async_tx_descriptor *c
 	enum dma_transfer_direction dir, unsigned long tx_flags, void *context)
 {
 	struct cppi41_channel *c = to_cpp41_chan(chan);
+	struct dma_async_tx_descriptor *txd = NULL;
+	struct cppi41_dd *cdd = c->cdd;
 	struct cppi41_desc *d;
 	struct scatterlist *sg;
 	unsigned int i;
+	int error;
+
+	error = pm_runtime_get(cdd->ddev.dev);
+	if (error < 0) {
+		pm_runtime_put_noidle(cdd->ddev.dev);
+
+		return NULL;
+	}
+
+	if (cdd->is_suspended)
+		goto err_out_not_ready;
 
 	d = c->desc;
 	for_each_sg(sgl, sg, sg_len, i) {
@@ -610,7 +623,13 @@ static struct dma_async_tx_descriptor *c
 		d++;
 	}
 
-	return &c->txd;
+	txd = &c->txd;
+
+err_out_not_ready:
+	pm_runtime_mark_last_busy(cdd->ddev.dev);
+	pm_runtime_put_autosuspend(cdd->ddev.dev);
+
+	return txd;
 }
 
 static void cppi41_compute_td_desc(struct cppi41_desc *d)


