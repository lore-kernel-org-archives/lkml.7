Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D58D6FC6195
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 18:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD0542067B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 18:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573239424;
	bh=qnofULetIF8eFnl8QYSI9VeNuk/L/SfVJZm/J9vSS+E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dpNthtPmSwl+i8BL+4EzAmMRZfoAWsl2Eaj0z7pxPQVv65buDkUIDs7tf1iMLEb2s
	 KgmiG0La5gTyke+w2963X67kwOCjIuD4G2HvxcoRQbtCI4emOSw4txwUQ+9NZ/2fwz
	 CduzZNVZJHAoBNXsjWHu+2pT5TLr6QRyJtsn1oZI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388644AbfKHS5D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 13:57:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:54746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388596AbfKHS5C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 13:57:02 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B2D021D7E;
        Fri,  8 Nov 2019 18:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573239420;
        bh=qnofULetIF8eFnl8QYSI9VeNuk/L/SfVJZm/J9vSS+E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0DcqJwfZT9yBp8wyFoDL9onbKc0H08XhmSAll59B/NXwDIclahsNFQVWg9Tc7h0xE
         O//EouLVCnBiyevKkBNA4mUFc/KtavwihDPjPDJWT208B28XbaoyLSzxvmAjjCmJJu
         rl7qlF7P5ZIdxnW8Pz90caJ1YyiRT0f/31eY/ipY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 4.9 33/34] dmaengine: qcom: bam_dma: Fix resource leak
Date:   Fri,  8 Nov 2019 19:50:40 +0100
Message-Id: <20191108174656.942093520@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191108174618.266472504@linuxfoundation.org>
References: <20191108174618.266472504@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20191017152606.34120-1-jeffrey.l.hugo@gmail.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/dma/qcom/bam_dma.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

--- a/drivers/dma/qcom/bam_dma.c
+++ b/drivers/dma/qcom/bam_dma.c
@@ -686,7 +686,21 @@ static int bam_dma_terminate_all(struct
 
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


