Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2BCFC4321A
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B08FE212F5
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:20:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbfD0PU2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:20:28 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33978 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727598AbfD0PPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:15:35 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP35-0000zB-NP; Sat, 27 Apr 2019 16:15:31 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2k-0004VY-8N; Sat, 27 Apr 2019 16:15:10 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Stefan Wahren" <stefan.wahren@i2se.com>,
        "Lukas Wunner" <lukas@wunner.de>, "Vinod Koul" <vkoul@kernel.org>,
        "Florian Kauer" <florian.kauer@koalo.de>,
        "Florian Meier" <florian.meier@koalo.de>,
        "Matthias Reichl" <hias@horus.com>,
        "Clive Messer" <clive.m.messer@gmail.com>,
        "Frank Pavlic" <f.pavlic@kunbus.de>,
        "Martin Sperl" <kernel@martin.sperl.org>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.116745014@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 089/202] dmaengine: bcm2835: Fix abort of transactions
In-Reply-To: <lsq.1556377988.384060557@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.66-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Lukas Wunner <lukas@wunner.de>

commit 9e528c799d17a4ac37d788c81440b50377dd592d upstream.

There are multiple issues with bcm2835_dma_abort() (which is called on
termination of a transaction):

* The algorithm to abort the transaction first pauses the channel by
  clearing the ACTIVE flag in the CS register, then waits for the PAUSED
  flag to clear.  Page 49 of the spec documents the latter as follows:

  "Indicates if the DMA is currently paused and not transferring data.
   This will occur if the active bit has been cleared [...]"
   https://www.raspberrypi.org/app/uploads/2012/02/BCM2835-ARM-Peripherals.pdf

  So the function is entering an infinite loop because it is waiting for
  PAUSED to clear which is always set due to the function having cleared
  the ACTIVE flag.  The only thing that's saving it from itself is the
  upper bound of 10000 loop iterations.

  The code comment says that the intention is to "wait for any current
  AXI transfer to complete", so the author probably wanted to check the
  WAITING_FOR_OUTSTANDING_WRITES flag instead.  Amend the function
  accordingly.

* The CS register is only read at the beginning of the function.  It
  needs to be read again after pausing the channel and before checking
  for outstanding writes, otherwise writes which were issued between
  the register read at the beginning of the function and pausing the
  channel may not be waited for.

* The function seeks to abort the transfer by writing 0 to the NEXTCONBK
  register and setting the ABORT and ACTIVE flags.  Thereby, the 0 in
  NEXTCONBK is sought to be loaded into the CONBLK_AD register.  However
  experimentation has shown this approach to not work:  The CONBLK_AD
  register remains the same as before and the CS register contains
  0x00000030 (PAUSED | DREQ_STOPS_DMA).  In other words, the control
  block is not aborted but merely paused and it will be resumed once the
  next DMA transaction is started.  That is absolutely not the desired
  behavior.

  A simpler approach is to set the channel's RESET flag instead.  This
  reliably zeroes the NEXTCONBK as well as the CS register.  It requires
  less code and only a single MMIO write.  This is also what popular
  user space DMA drivers do, e.g.:
  https://github.com/metachris/RPIO/blob/master/source/c_pwm/pwm.c

  Note that the spec is contradictory whether the NEXTCONBK register
  is writeable at all.  On the one hand, page 41 claims:

  "The value loaded into the NEXTCONBK register can be overwritten so
  that the linked list of Control Block data structures can be
  dynamically altered. However it is only safe to do this when the DMA
  is paused."

  On the other hand, page 40 specifies:

  "Only three registers in each channel's register set are directly
  writeable (CS, CONBLK_AD and DEBUG). The other registers (TI,
  SOURCE_AD, DEST_AD, TXFR_LEN, STRIDE & NEXTCONBK), are automatically
  loaded from a Control Block data structure held in external memory."

Fixes: 96286b576690 ("dmaengine: Add support for BCM2835")
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: Frank Pavlic <f.pavlic@kunbus.de>
Cc: Martin Sperl <kernel@martin.sperl.org>
Cc: Florian Meier <florian.meier@koalo.de>
Cc: Clive Messer <clive.m.messer@gmail.com>
Cc: Matthias Reichl <hias@horus.com>
Tested-by: Stefan Wahren <stefan.wahren@i2se.com>
Acked-by: Florian Kauer <florian.kauer@koalo.de>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/dma/bcm2835-dma.c | 41 +++++++++------------------------------
 1 file changed, 9 insertions(+), 32 deletions(-)

--- a/drivers/dma/bcm2835-dma.c
+++ b/drivers/dma/bcm2835-dma.c
@@ -191,13 +191,11 @@ static void bcm2835_dma_desc_free(struct
 	kfree(desc);
 }
 
-static int bcm2835_dma_abort(void __iomem *chan_base)
+static int bcm2835_dma_abort(struct bcm2835_chan *c)
 {
-	unsigned long cs;
+	void __iomem *chan_base = c->chan_base;
 	long int timeout = 10000;
 
-	cs = readl(chan_base + BCM2835_DMA_CS);
-
 	/*
 	 * A zero control block address means the channel is idle.
 	 * (The ACTIVE flag in the CS register is not a reliable indicator.)
@@ -209,25 +207,16 @@ static int bcm2835_dma_abort(void __iome
 	writel(0, chan_base + BCM2835_DMA_CS);
 
 	/* Wait for any current AXI transfer to complete */
-	while ((cs & BCM2835_DMA_ISPAUSED) && --timeout) {
+	while ((readl(chan_base + BCM2835_DMA_CS) &
+		BCM2835_DMA_WAITING_FOR_WRITES) && --timeout)
 		cpu_relax();
-		cs = readl(chan_base + BCM2835_DMA_CS);
-	}
 
-	/* We'll un-pause when we set of our next DMA */
+	/* Peripheral might be stuck and fail to signal AXI write responses */
 	if (!timeout)
-		return -ETIMEDOUT;
-
-	if (!(cs & BCM2835_DMA_ACTIVE))
-		return 0;
-
-	/* Terminate the control block chain */
-	writel(0, chan_base + BCM2835_DMA_NEXTCB);
-
-	/* Abort the whole DMA */
-	writel(BCM2835_DMA_ABORT | BCM2835_DMA_ACTIVE,
-	       chan_base + BCM2835_DMA_CS);
+		dev_err(c->vc.chan.device->dev,
+			"failed to complete outstanding writes\n");
 
+	writel(BCM2835_DMA_RESET, chan_base + BCM2835_DMA_CS);
 	return 0;
 }
 
@@ -506,7 +495,6 @@ static int bcm2835_dma_terminate_all(str
 {
 	struct bcm2835_dmadev *d = to_bcm2835_dma_dev(c->vc.chan.device);
 	unsigned long flags;
-	int timeout = 10000;
 	LIST_HEAD(head);
 
 	spin_lock_irqsave(&c->vc.lock, flags);
@@ -519,18 +507,7 @@ static int bcm2835_dma_terminate_all(str
 	/* stop DMA activity */
 	if (c->desc) {
 		c->desc = NULL;
-		bcm2835_dma_abort(c->chan_base);
-
-		/* Wait for stopping */
-		while (--timeout) {
-			if (!readl(c->chan_base + BCM2835_DMA_ADDR))
-				break;
-
-			cpu_relax();
-		}
-
-		if (!timeout)
-			dev_err(d->ddev.dev, "DMA transfer could not be terminated\n");
+		bcm2835_dma_abort(c);
 	}
 
 	vchan_get_all_descriptors(&c->vc, &head);

