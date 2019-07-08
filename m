Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2CE9C606BD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7DC4216F4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562599113;
	bh=ChJGXPZW5+ab7V9V6J/vKor5vqH2dXwhMNFmBatqo+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nxVRL1AX6/El6Z9JCrOKoavA/NTSND8kk7hmO4GC2Qnt20KZ8TwrNrztq4aqrLO8R
	 00O4wVzkXFNtBXZrGZRKUEmQoSOCH7o3EsZLErcnWa+kuEQEDm/P9J4Lz0wuocCyz3
	 1JRJKVB6/cSrw+1HmnWSotqFlFpdzpqUCZnXj5dU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728244AbfGHPSc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 11:18:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:42250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733027AbfGHPS1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 11:18:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56F5C216C4;
        Mon,  8 Jul 2019 15:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562599106;
        bh=ChJGXPZW5+ab7V9V6J/vKor5vqH2dXwhMNFmBatqo+k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0S4oy47+JssXQ6i0tuXFgizJVDFbhGOauRpfk2g4jtpeiZWJTdI+pOJ3Hf5lSwDL5
         QgLxGqmDk7Rc1eFH1rBNQ3vuWPEWLZ8uIntPC7sv2p5BUZKDsjYKBsNkchRM69CrW3
         ZvPFV+VXXd/fX0ln2tir3f+RCIe3yD3y/IsIiC24=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Robin Gong <yibin.gong@nxp.com>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Michael Olbrich <m.olbrich@pengutronix.de>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 4.4 73/73] dmaengine: imx-sdma: remove BD_INTR for channel0
Date:   Mon,  8 Jul 2019 17:13:23 +0200
Message-Id: <20190708150525.081783641@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190708150513.136580595@linuxfoundation.org>
References: <20190708150513.136580595@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robin Gong <yibin.gong@nxp.com>

commit 3f93a4f297961c12bb17aa16cb3a4d1291823cae upstream.

It is possible for an irq triggered by channel0 to be received later
after clks are disabled once firmware loaded during sdma probe. If
that happens then clearing them by writing to SDMA_H_INTR won't work
and the kernel will hang processing infinite interrupts. Actually,
don't need interrupt triggered on channel0 since it's pollling
SDMA_H_STATSTOP to know channel0 done rather than interrupt in
current code, just clear BD_INTR to disable channel0 interrupt to
avoid the above case.
This issue was brought by commit 1d069bfa3c78 ("dmaengine: imx-sdma:
ack channel 0 IRQ in the interrupt handler") which didn't take care
the above case.

Fixes: 1d069bfa3c78 ("dmaengine: imx-sdma: ack channel 0 IRQ in the interrupt handler")
Cc: stable@vger.kernel.org #5.0+
Signed-off-by: Robin Gong <yibin.gong@nxp.com>
Reported-by: Sven Van Asbroeck <thesven73@gmail.com>
Tested-by: Sven Van Asbroeck <thesven73@gmail.com>
Reviewed-by: Michael Olbrich <m.olbrich@pengutronix.de>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/dma/imx-sdma.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -614,7 +614,7 @@ static int sdma_load_script(struct sdma_
 	spin_lock_irqsave(&sdma->channel_0_lock, flags);
 
 	bd0->mode.command = C0_SETPM;
-	bd0->mode.status = BD_DONE | BD_INTR | BD_WRAP | BD_EXTD;
+	bd0->mode.status = BD_DONE | BD_WRAP | BD_EXTD;
 	bd0->mode.count = size / 2;
 	bd0->buffer_addr = buf_phys;
 	bd0->ext_buffer_addr = address;
@@ -883,7 +883,7 @@ static int sdma_load_context(struct sdma
 	context->gReg[7] = sdmac->watermark_level;
 
 	bd0->mode.command = C0_SETDM;
-	bd0->mode.status = BD_DONE | BD_INTR | BD_WRAP | BD_EXTD;
+	bd0->mode.status = BD_DONE | BD_WRAP | BD_EXTD;
 	bd0->mode.count = sizeof(*context) / 4;
 	bd0->buffer_addr = sdma->context_phys;
 	bd0->ext_buffer_addr = 2048 + (sizeof(*context) / 4) * channel;


