Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 367C1CA9EC9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 22:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 078472084D
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 22:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572905414;
	bh=lQk2dCPShHPcrBF0qs2qgGMBx+xyTRvvjgf+a08rBDo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Qusf70gDG6aJN3e8PEY3/U3zMYwf9C16G1225Jx1IPjRRaQ+f3LSivn++hbPLKiO8
	 7cO35kJ0MYJJLIkU7cyrMW/cfCqTTIpdhGD8ykuDtzmeOuEuz9TfeinxIohLgzopx7
	 yVWsMuUJiSNwshuZ7ntdlwjpLuMat6RIuXggnVrw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390509AbfKDWKM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 17:10:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:43300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390131AbfKDWKI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 17:10:08 -0500
Received: from localhost (6.204-14-84.ripe.coltfrance.com [84.14.204.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A497F2084D;
        Mon,  4 Nov 2019 22:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572905407;
        bh=lQk2dCPShHPcrBF0qs2qgGMBx+xyTRvvjgf+a08rBDo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MZvrTpNygJ1WqqwAO1emjMsY0u3m6mXRGknOEsZLoVEGIAznMNV3rIC8YaRc4k73Z
         dx2hoByfk22IMN4Sm9q8Ek4kIa8dqCgj7Cqp2WPS7pnpLhwCnN/Fbb+ZaVnaYMEeoh
         M3h68hTBCFbGnUasY5E9d4zsxMHFqzP+zks8R9c4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 5.3 133/163] dmaengine: qcom: bam_dma: Fix resource leak
Date:   Mon,  4 Nov 2019 22:45:23 +0100
Message-Id: <20191104212149.973116290@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191104212140.046021995@linuxfoundation.org>
References: <20191104212140.046021995@linuxfoundation.org>
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
 drivers/dma/qcom/bam_dma.c |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

--- a/drivers/dma/qcom/bam_dma.c
+++ b/drivers/dma/qcom/bam_dma.c
@@ -694,6 +694,25 @@ static int bam_dma_terminate_all(struct
 
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
+	if (!list_empty(&bchan->desc_list)) {
+		async_desc = list_first_entry(&bchan->desc_list,
+					      struct bam_async_desc, desc_node);
+		bam_chan_init_hw(bchan, async_desc->dir);
+	}
+
 	list_for_each_entry_safe(async_desc, tmp,
 				 &bchan->desc_list, desc_node) {
 		list_add(&async_desc->vd.node, &bchan->vc.desc_issued);


