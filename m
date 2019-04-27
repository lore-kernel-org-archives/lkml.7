Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF00C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D50D206A3
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:20:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728084AbfD0PUZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:20:25 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33984 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727599AbfD0PPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:15:35 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP35-0000zK-MI; Sat, 27 Apr 2019 16:15:31 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2k-0004VR-6v; Sat, 27 Apr 2019 16:15:10 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Clive Messer" <clive.m.messer@gmail.com>,
        "Matthias Reichl" <hias@horus.com>,
        "Florian Meier" <florian.meier@koalo.de>,
        "Martin Sperl" <kernel@martin.sperl.org>,
        "Frank Pavlic" <f.pavlic@kunbus.de>,
        "Vinod Koul" <vkoul@kernel.org>, "Lukas Wunner" <lukas@wunner.de>,
        "Stefan Wahren" <stefan.wahren@i2se.com>,
        "Florian Kauer" <florian.kauer@koalo.de>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.698212183@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 088/202] dmaengine: bcm2835: Fix interrupt race on RT
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

commit f7da7782aba92593f7b82f03d2409a1c5f4db91b upstream.

If IRQ handlers are threaded (either because CONFIG_PREEMPT_RT_BASE is
enabled or "threadirqs" was passed on the command line) and if system
load is sufficiently high that wakeup latency of IRQ threads degrades,
SPI DMA transactions on the BCM2835 occasionally break like this:

ks8851 spi0.0: SPI transfer timed out
bcm2835-dma 3f007000.dma: DMA transfer could not be terminated
ks8851 spi0.0 eth2: ks8851_rdfifo: spi_sync() failed

The root cause is an assumption made by the DMA driver which is
documented in a code comment in bcm2835_dma_terminate_all():

/*
 * Stop DMA activity: we assume the callback will not be called
 * after bcm_dma_abort() returns (even if it does, it will see
 * c->desc is NULL and exit.)
 */

That assumption falls apart if the IRQ handler bcm2835_dma_callback() is
threaded: A client may terminate a descriptor and issue a new one
before the IRQ handler had a chance to run. In fact the IRQ handler may
miss an *arbitrary* number of descriptors. The result is the following
race condition:

1. A descriptor finishes, its interrupt is deferred to the IRQ thread.
2. A client calls dma_terminate_async() which sets channel->desc = NULL.
3. The client issues a new descriptor. Because channel->desc is NULL,
   bcm2835_dma_issue_pending() immediately starts the descriptor.
4. Finally the IRQ thread runs and writes BCM2835_DMA_INT to the CS
   register to acknowledge the interrupt. This clears the ACTIVE flag,
   so the newly issued descriptor is paused in the middle of the
   transaction. Because channel->desc is not NULL, the IRQ thread
   finalizes the descriptor and tries to start the next one.

I see two possible solutions: The first is to call synchronize_irq()
in bcm2835_dma_issue_pending() to wait until the IRQ thread has
finished before issuing a new descriptor. The downside of this approach
is unnecessary latency if clients desire rapidly terminating and
re-issuing descriptors and don't have any use for an IRQ callback.
(The SPI TX DMA channel is a case in point.)

A better alternative is to make the IRQ thread recognize that it has
missed descriptors and avoid finalizing the newly issued descriptor.
So first of all, set the ACTIVE flag when acknowledging the interrupt.
This keeps a newly issued descriptor running.

If the descriptor was finished, the channel remains idle despite the
ACTIVE flag being set. However the ACTIVE flag can then no longer be
used to check whether the channel is idle, so instead check whether
the register containing the current control block address is zero
and finalize the current descriptor only if so.

That way, there is no impact on latency and throughput if the client
doesn't care for the interrupt: Only minimal additional overhead is
introduced for non-cyclic descriptors as one further MMIO read is
necessary per interrupt to check for idleness of the channel. Cyclic
descriptors are sped up slightly by removing one MMIO write per
interrupt.

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
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/dma/bcm2835-dma.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

--- a/drivers/dma/bcm2835-dma.c
+++ b/drivers/dma/bcm2835-dma.c
@@ -197,7 +197,12 @@ static int bcm2835_dma_abort(void __iome
 	long int timeout = 10000;
 
 	cs = readl(chan_base + BCM2835_DMA_CS);
-	if (!(cs & BCM2835_DMA_ACTIVE))
+
+	/*
+	 * A zero control block address means the channel is idle.
+	 * (The ACTIVE flag in the CS register is not a reliable indicator.)
+	 */
+	if (!readl(chan_base + BCM2835_DMA_ADDR))
 		return 0;
 
 	/* Write 0 to the active bit - Pause the DMA */
@@ -252,8 +257,15 @@ static irqreturn_t bcm2835_dma_callback(
 
 	spin_lock_irqsave(&c->vc.lock, flags);
 
-	/* Acknowledge interrupt */
-	writel(BCM2835_DMA_INT, c->chan_base + BCM2835_DMA_CS);
+	/*
+	 * Clear the INT flag to receive further interrupts. Keep the channel
+	 * active in case the descriptor is cyclic or in case the client has
+	 * already terminated the descriptor and issued a new one. (May happen
+	 * if this IRQ handler is threaded.) If the channel is finished, it
+	 * will remain idle despite the ACTIVE flag being set.
+	 */
+	writel(BCM2835_DMA_INT | BCM2835_DMA_ACTIVE,
+	       c->chan_base + BCM2835_DMA_CS);
 
 	d = c->desc;
 
@@ -262,9 +274,6 @@ static irqreturn_t bcm2835_dma_callback(
 		vchan_cyclic_callback(&d->vd);
 	}
 
-	/* Keep the DMA engine running */
-	writel(BCM2835_DMA_ACTIVE, c->chan_base + BCM2835_DMA_CS);
-
 	spin_unlock_irqrestore(&c->vc.lock, flags);
 
 	return IRQ_HANDLED;
@@ -507,19 +516,14 @@ static int bcm2835_dma_terminate_all(str
 	list_del_init(&c->node);
 	spin_unlock(&d->lock);
 
-	/*
-	 * Stop DMA activity: we assume the callback will not be called
-	 * after bcm_dma_abort() returns (even if it does, it will see
-	 * c->desc is NULL and exit.)
-	 */
+	/* stop DMA activity */
 	if (c->desc) {
 		c->desc = NULL;
 		bcm2835_dma_abort(c->chan_base);
 
 		/* Wait for stopping */
 		while (--timeout) {
-			if (!(readl(c->chan_base + BCM2835_DMA_CS) &
-						BCM2835_DMA_ACTIVE))
+			if (!readl(c->chan_base + BCM2835_DMA_ADDR))
 				break;
 
 			cpu_relax();

