Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5657C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 930F22075B
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565010232;
	bh=zmi6DxT3EhLOR5sEtz3wlVtU2AHbkSBARiH7Prqw1qY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ju9LjgLybGf00IZOFp5HvCK4FUYXgMZEBvDuC1Gu9syeCXypRYO/Mq00I5RjnJcKQ
	 WmLzpDpw5oPEr8I01TME9hY9Ex86upgE1vEGD2Zs67AENCvpq6bqUlPXX/ibFiVer5
	 8d1yf/NB6dwYoWjmql2tVwOEk4aDkQiptTqUTnbk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728744AbfHENDv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 09:03:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:39234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726508AbfHENDv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 09:03:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC54C206C1;
        Mon,  5 Aug 2019 13:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565010230;
        bh=zmi6DxT3EhLOR5sEtz3wlVtU2AHbkSBARiH7Prqw1qY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YF3rHnmthCmKUJspnEPG9x3VpFiQr8fDPdWdBEpIQ2hYrP6fgJIItvYYdyo2Xr3U6
         AM+r+v/nXPXJEeVB4iu+xC8vXhpV8iTS+Oc1GxuGhZUBHZgFVICnhzD7dE9BULJlsA
         BwBn1mz5KVn1LqPHN6mMzVQjmJ4lkIHcwbcCqmOQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 01/22] ARM: riscpc: fix DMA
Date:   Mon,  5 Aug 2019 15:02:38 +0200
Message-Id: <20190805124919.055226395@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190805124918.070468681@linuxfoundation.org>
References: <20190805124918.070468681@linuxfoundation.org>
User-Agent: quilt/0.66
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit ffd9a1ba9fdb7f2bd1d1ad9b9243d34e96756ba2 ]

DMA got broken a while back in two different ways:
1) a change in the behaviour of disable_irq() to wait for the interrupt
   to finish executing causes us to deadlock at the end of DMA.
2) a change to avoid modifying the scatterlist left the first transfer
   uninitialised.

DMA is only used with expansion cards, so has gone unnoticed.

Fixes: fa4e99899932 ("[ARM] dma: RiscPC: don't modify DMA SG entries")
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/mach-rpc/dma.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-rpc/dma.c b/arch/arm/mach-rpc/dma.c
index 6d3517dc4772a..82aac38fa2cff 100644
--- a/arch/arm/mach-rpc/dma.c
+++ b/arch/arm/mach-rpc/dma.c
@@ -131,7 +131,7 @@ static irqreturn_t iomd_dma_handle(int irq, void *dev_id)
 	} while (1);
 
 	idma->state = ~DMA_ST_AB;
-	disable_irq(irq);
+	disable_irq_nosync(irq);
 
 	return IRQ_HANDLED;
 }
@@ -174,6 +174,9 @@ static void iomd_enable_dma(unsigned int chan, dma_t *dma)
 				DMA_FROM_DEVICE : DMA_TO_DEVICE);
 		}
 
+		idma->dma_addr = idma->dma.sg->dma_address;
+		idma->dma_len = idma->dma.sg->length;
+
 		iomd_writeb(DMA_CR_C, dma_base + CR);
 		idma->state = DMA_ST_AB;
 	}
-- 
2.20.1



