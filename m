Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6102CC282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 19:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 413412072A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 19:48:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729317AbgAHTsc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 14:48:32 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:43696 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730457AbgAHTqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 14:46:04 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1ipHHD-0006ov-Tc; Wed, 08 Jan 2020 19:45:59 +0000
Received: from ben by deadeye with local (Exim 4.93)
        (envelope-from <ben@decadent.org.uk>)
        id 1ipHHD-007doY-4M; Wed, 08 Jan 2020 19:45:59 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Vinod Koul" <vkoul@kernel.org>,
        "Jeffrey Hugo" <jeffrey.l.hugo@gmail.com>
Date:   Wed, 08 Jan 2020 19:43:49 +0000
Message-ID: <lsq.1578512578.711401705@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 51/63] dmaengine: qcom: bam_dma: Fix resource leak
In-Reply-To: <lsq.1578512578.117275639@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.81-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>

commit 7667819385457b4aeb5fac94f67f52ab52cc10d5 upstream.

bam_dma_terminate_all() will leak resources if any of the transactions are
committed to the hardware (present in the desc fifo), and not complete.
Since bam_dma_terminate_all() does not cause the hardware to be updated,
the hardware will still operate on any previously committed transactions.
This can cause memory corruption if the memory for the transaction has been
reassigned, and will cause a sync issue between the BAM and its client(s).

Fix this by properly updating the hardware in bam_dma_terminate_all().

Fixes: e7c0fe2a5c84 ("dmaengine: add Qualcomm BAM dma driver")
Signed-off-by: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Link: https://lore.kernel.org/r/20191017152606.34120-1-jeffrey.l.hugo@gmail.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
[Jeffrey Hugo: Backported to 4.4 which is lacking 6b4faeac05bc
 ("dmaengine: qcom-bam: Process multiple pending descriptors")]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/dma/qcom_bam_dma.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

--- a/drivers/dma/qcom_bam_dma.c
+++ b/drivers/dma/qcom_bam_dma.c
@@ -539,7 +539,21 @@ static void bam_dma_terminate_all(struct
 
 	/* remove all transactions, including active transaction */
 	spin_lock_irqsave(&bchan->vc.lock, flag);
+	/*
+	 * If we have transactions queued, then some might be committed to the
+	 * hardware in the desc fifo.  The only way to reset the desc fifo is
+	 * to do a hardware reset (either by pipe or the entire block).
+	 * bam_chan_init_hw() will trigger a pipe reset, and also reinit the
+	 * pipe.  If the pipe is left disabled (default state after pipe reset)
+	 * and is accessed by a connected hardware engine, a fatal error in
+	 * the BAM will occur.  There is a small window where this could happen
+	 * with bam_chan_init_hw(), but it is assumed that the caller has
+	 * stopped activity on any attached hardware engine.  Make sure to do
+	 * this first so that the BAM hardware doesn't cause memory corruption
+	 * by accessing freed resources.
+	 */
 	if (bchan->curr_txd) {
+		bam_chan_init_hw(bchan, bchan->curr_txd->dir);
 		list_add(&bchan->curr_txd->vd.node, &bchan->vc.desc_issued);
 		bchan->curr_txd = NULL;
 	}

