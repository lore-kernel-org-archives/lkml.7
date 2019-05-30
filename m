Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EE13C072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA4222566C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559190684;
	bh=F60ovf0n5l2kPM8Qyh6dLDCgATr4YEityKsVWQ5te1o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lP+44LXguAkBK4KZrYGfk7EPrNuupNwWmoe8inJtnI1P1rpm0nFBWPcw+fSzhNRnD
	 +orJg5n04RjvhsiIJLSI9eTIwpH7Qe5UPck42/n/1Po2vD8sHmT7PsueVMNC35KANH
	 At32rrL/LEzUG/d8WCSoBep3jMRwkcewCclMhqIs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729663AbfE3EbS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 00:31:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:60160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729592AbfE3DNs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:13:48 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F19C24526;
        Thu, 30 May 2019 03:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559186028;
        bh=F60ovf0n5l2kPM8Qyh6dLDCgATr4YEityKsVWQ5te1o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qnCDeBP9z1BSy4tS38gy6ubafZYmvneyodWB1KSBxwiLk+aS2rbtHWiFySscksJsj
         5jfJ3AGVxpAiZmz8DJdt5aRcb5V1fNn32LpnIcXH1IBCFBYFtdshwiMyIZjykRKbQB
         D6m7ap74yAGB1hnpZ4vaHEDE+kOCvvHd6f0bSvFc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sugar Zhang <sugar.zhang@rock-chips.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 103/346] dmaengine: pl330: _stop: clear interrupt status
Date:   Wed, 29 May 2019 20:02:56 -0700
Message-Id: <20190530030546.355562064@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030540.363386121@linuxfoundation.org>
References: <20190530030540.363386121@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 2da254cc7908105a60a6bb219d18e8dced03dcb9 ]

This patch kill instructs the DMAC to immediately terminate
execution of a thread. and then clear the interrupt status,
at last, stop generating interrupts for DMA_SEV. to guarantee
the next dma start is clean. otherwise, one interrupt maybe leave
to next start and make some mistake.

we can reporduce the problem as follows:

DMASEV: modify the event-interrupt resource, and if the INTEN sets
function as interrupt, the DMAC will set irq<event_num> HIGH to
generate interrupt. write INTCLR to clear interrupt.

	DMA EXECUTING INSTRUCTS		DMA TERMINATE
		|				|
		|				|
	       ...			      _stop
		|				|
		|			spin_lock_irqsave
	     DMASEV				|
		|				|
		|			    mask INTEN
		|				|
		|			     DMAKILL
		|				|
		|			spin_unlock_irqrestore

in above case, a interrupt was left, and if we unmask INTEN, the DMAC
will set irq<event_num> HIGH to generate interrupt.

to fix this, do as follows:

	DMA EXECUTING INSTRUCTS		DMA TERMINATE
		|				|
		|				|
	       ...			      _stop
		|				|
		|			spin_lock_irqsave
	     DMASEV				|
		|				|
		|			     DMAKILL
		|				|
		|			   clear INTCLR
		|			    mask INTEN
		|				|
		|			spin_unlock_irqrestore

Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/pl330.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index cff1b143fff5d..9b7a49fc76971 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -966,6 +966,7 @@ static void _stop(struct pl330_thread *thrd)
 {
 	void __iomem *regs = thrd->dmac->base;
 	u8 insn[6] = {0, 0, 0, 0, 0, 0};
+	u32 inten = readl(regs + INTEN);
 
 	if (_state(thrd) == PL330_STATE_FAULT_COMPLETING)
 		UNTIL(thrd, PL330_STATE_FAULTING | PL330_STATE_KILLING);
@@ -978,10 +979,13 @@ static void _stop(struct pl330_thread *thrd)
 
 	_emit_KILL(0, insn);
 
-	/* Stop generating interrupts for SEV */
-	writel(readl(regs + INTEN) & ~(1 << thrd->ev), regs + INTEN);
-
 	_execute_DBGINSN(thrd, insn, is_manager(thrd));
+
+	/* clear the event */
+	if (inten & (1 << thrd->ev))
+		writel(1 << thrd->ev, regs + INTCLR);
+	/* Stop generating interrupts for SEV */
+	writel(inten & ~(1 << thrd->ev), regs + INTEN);
 }
 
 /* Start doing req 'idx' of thread 'thrd' */
-- 
2.20.1



