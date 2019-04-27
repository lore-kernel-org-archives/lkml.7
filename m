Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D947C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB22C206A3
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:30:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728663AbfD0PaU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:30:20 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:60982 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727192AbfD0PPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:15:16 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2m-0000zG-M2; Sat, 27 Apr 2019 16:15:12 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2k-0004VH-68; Sat, 27 Apr 2019 16:15:10 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Vinod Koul" <vinod.koul@intel.com>,
        "Martin Sperl" <kernel@martin.sperl.org>,
        "Eric Anholt" <eric@anholt.net>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.717099809@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 087/202] dmaengine: bcm2835: add additional defines
 for DMA-registers
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

From: Martin Sperl <kernel@martin.sperl.org>

commit e42685d7a7d5afa6278561ffd85c475eae246be3 upstream.

Add additional defines describing the DMA registers
as well as adding some more documentation to those registers.

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
Reviewed-by: Eric Anholt <eric@anholt.net>
Signed-off-by: Eric Anholt <eric@anholt.net>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
[bwh: Backported to 3.16 as dependency of commit 9e528c799d17
 "dmaengine: bcm2835: Fix abort of transactions"]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/dma/bcm2835-dma.c | 57 +++++++++++++++++++++++++++++++++------
 1 file changed, 49 insertions(+), 8 deletions(-)

--- a/drivers/dma/bcm2835-dma.c
+++ b/drivers/dma/bcm2835-dma.c
@@ -91,26 +91,67 @@ struct bcm2835_desc {
 
 #define BCM2835_DMA_CS		0x00
 #define BCM2835_DMA_ADDR	0x04
+#define BCM2835_DMA_TI		0x08
 #define BCM2835_DMA_SOURCE_AD	0x0c
 #define BCM2835_DMA_DEST_AD	0x10
-#define BCM2835_DMA_NEXTCB	0x1C
+#define BCM2835_DMA_LEN		0x14
+#define BCM2835_DMA_STRIDE	0x18
+#define BCM2835_DMA_NEXTCB	0x1c
+#define BCM2835_DMA_DEBUG	0x20
 
 /* DMA CS Control and Status bits */
-#define BCM2835_DMA_ACTIVE	BIT(0)
-#define BCM2835_DMA_INT	BIT(2)
+#define BCM2835_DMA_ACTIVE	BIT(0)  /* activate the DMA */
+#define BCM2835_DMA_END		BIT(1)  /* current CB has ended */
+#define BCM2835_DMA_INT		BIT(2)  /* interrupt status */
+#define BCM2835_DMA_DREQ	BIT(3)  /* DREQ state */
 #define BCM2835_DMA_ISPAUSED	BIT(4)  /* Pause requested or not active */
 #define BCM2835_DMA_ISHELD	BIT(5)  /* Is held by DREQ flow control */
-#define BCM2835_DMA_ERR	BIT(8)
+#define BCM2835_DMA_WAITING_FOR_WRITES BIT(6) /* waiting for last
+					       * AXI-write to ack
+					       */
+#define BCM2835_DMA_ERR		BIT(8)
+#define BCM2835_DMA_PRIORITY(x) ((x & 15) << 16) /* AXI priority */
+#define BCM2835_DMA_PANIC_PRIORITY(x) ((x & 15) << 20) /* panic priority */
+/* current value of TI.BCM2835_DMA_WAIT_RESP */
+#define BCM2835_DMA_WAIT_FOR_WRITES BIT(28)
+#define BCM2835_DMA_DIS_DEBUG	BIT(29) /* disable debug pause signal */
 #define BCM2835_DMA_ABORT	BIT(30) /* Stop current CB, go to next, WO */
 #define BCM2835_DMA_RESET	BIT(31) /* WO, self clearing */
 
+/* Transfer information bits - also bcm2835_cb.info field */
 #define BCM2835_DMA_INT_EN	BIT(0)
+#define BCM2835_DMA_TDMODE	BIT(1) /* 2D-Mode */
+#define BCM2835_DMA_WAIT_RESP	BIT(3) /* wait for AXI-write to be acked */
 #define BCM2835_DMA_D_INC	BIT(4)
-#define BCM2835_DMA_D_DREQ	BIT(6)
+#define BCM2835_DMA_D_WIDTH	BIT(5) /* 128bit writes if set */
+#define BCM2835_DMA_D_DREQ	BIT(6) /* enable DREQ for destination */
+#define BCM2835_DMA_D_IGNORE	BIT(7) /* ignore destination writes */
 #define BCM2835_DMA_S_INC	BIT(8)
-#define BCM2835_DMA_S_DREQ	BIT(10)
+#define BCM2835_DMA_S_WIDTH	BIT(9) /* 128bit writes if set */
+#define BCM2835_DMA_S_DREQ	BIT(10) /* enable SREQ for source */
+#define BCM2835_DMA_S_IGNORE	BIT(11) /* ignore source reads - read 0 */
+#define BCM2835_DMA_BURST_LENGTH(x) ((x & 15) << 12)
+#define BCM2835_DMA_PER_MAP(x)	((x & 31) << 16) /* REQ source */
+#define BCM2835_DMA_WAIT(x)	((x & 31) << 21) /* add DMA-wait cycles */
+#define BCM2835_DMA_NO_WIDE_BURSTS BIT(26) /* no 2 beat write bursts */
 
-#define BCM2835_DMA_PER_MAP(x)	((x) << 16)
+/* debug register bits */
+#define BCM2835_DMA_DEBUG_LAST_NOT_SET_ERR	BIT(0)
+#define BCM2835_DMA_DEBUG_FIFO_ERR		BIT(1)
+#define BCM2835_DMA_DEBUG_READ_ERR		BIT(2)
+#define BCM2835_DMA_DEBUG_OUTSTANDING_WRITES_SHIFT 4
+#define BCM2835_DMA_DEBUG_OUTSTANDING_WRITES_BITS 4
+#define BCM2835_DMA_DEBUG_ID_SHIFT		16
+#define BCM2835_DMA_DEBUG_ID_BITS		9
+#define BCM2835_DMA_DEBUG_STATE_SHIFT		16
+#define BCM2835_DMA_DEBUG_STATE_BITS		9
+#define BCM2835_DMA_DEBUG_VERSION_SHIFT		25
+#define BCM2835_DMA_DEBUG_VERSION_BITS		3
+#define BCM2835_DMA_DEBUG_LITE			BIT(28)
+
+/* shared registers for all dma channels */
+#define BCM2835_DMA_INT_STATUS         0xfe0
+#define BCM2835_DMA_ENABLE             0xff0
 
 #define BCM2835_DMA_DATA_TYPE_S8	1
 #define BCM2835_DMA_DATA_TYPE_S16	2

