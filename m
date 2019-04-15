Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F188C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 20:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3657220848
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 20:25:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbfDOUZx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 16:25:53 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:47069 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727379AbfDOUZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 16:25:53 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MQNF3-1hTYRh3xMf-00MJcC; Mon, 15 Apr 2019 22:25:25 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Greg Ungerer <gerg@uclinux.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>, arm@kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        YueHaibing <yuehaibing@huawei.com>,
        Yang Wei <yang.wei9@zte.com.cn>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] ARM: ks8695, net: use disable_irq/enable_irq
Date:   Mon, 15 Apr 2019 22:24:14 +0200
Message-Id: <20190415202501.941196-2-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190415202501.941196-1-arnd@arndb.de>
References: <20190415202501.941196-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:8tGLnwpQBE+hy+QbBxx311K8axver6qgKQ4XBwgIDHEvIxWbZM4
 vd9oI7nAvHCsyMhxKLKWHXrUXv3evFP6DANXx52AN/+36n357jJBTuUy6QzBuEOMoy0hnAK
 6MOrDkssOoGVEHIzfdGiiTZd/21OY89EjqJWjWZZ34g5CS38akG01kC6AcKhytK5iYg2UYr
 d+NoNKE+/BuoRwuquvE+A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:r2hNp5L619c=:KZhCizwnOJmaLaN5VInOhb
 6DhVrL3pf2b7fd+jUPk89BkhGPEkeTVviInbb0sljEw+LwCbnCW9ofoaJ/K6Y/3xYNo4Zzz09
 Ph46yL4zCSt5kdKs4hWyPyW1x0IcnkV+wKYcZeauDpZwo3SGycvBrwDkcUxPuh8+aNw96dZzG
 Fe7OqB4/o+/D4h0gkyWkM3Z413+ub6cdVUGBnxszqgEf8ScUCndh1YQ74I4hEG52TybdHLZjJ
 IYwSbM2VIOnQZkm72WwmLfjuHAeDiArDNwhEHngPhrmec6Jx4YvJMws5EKLpYkPVv/BsrzrqX
 l8sptrqOImu94owRKTuvzvl1AFWLXqmEy05wf/3O31P+DvHDeeRv0zNLAcVNYpBpPr8BYes44
 OtldfHfRGz1QuvLbJTNdWZKRT/xiQIwWrrYEeCjBB871+sHsDUJE87okBrqKGfW+n5rqul9Ut
 VOEC8AZHxyMzC9ka16o8idK7G+nSaRReiTk3uyNBthM265RNtunWd6OTp9f4NcdbBICwjlw6Z
 QIRSzhRbSR5fj5n2XI+es519FlQe+tO4JgKu1TLiD8vG7ymSffVtUUZQdYbMUMRWPur1F/ReJ
 gYKormZA7iMqhRaOYLsBLFtyS1pe0gmVmSU1G3lL08y2oKJQzfO2+r5SUj91LU4avmrkD5WWz
 IKY/g4EL1iLoYdn0gJ5hVQtUNH+aecsZJFKxQoLHj4uVi2W8BviS+CuobQVyl0xfgyPxRD4pF
 jfX1w57yAquNwPteUBE3iwgwSObvEnmHY37YvQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rather than poking the registers manually, better use the exported
interfaces for it.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/micrel/ks8695net.c | 30 ++-----------------------
 1 file changed, 2 insertions(+), 28 deletions(-)

diff --git a/drivers/net/ethernet/micrel/ks8695net.c b/drivers/net/ethernet/micrel/ks8695net.c
index 6006d47707cb..3b6375adff08 100644
--- a/drivers/net/ethernet/micrel/ks8695net.c
+++ b/drivers/net/ethernet/micrel/ks8695net.c
@@ -402,25 +402,6 @@ ks8695_tx_irq(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-/**
- *	ks8695_get_rx_enable_bit - Get rx interrupt enable/status bit
- *	@ksp: Private data for the KS8695 Ethernet
- *
- *    For KS8695 document:
- *    Interrupt Enable Register (offset 0xE204)
- *        Bit29 : WAN MAC Receive Interrupt Enable
- *        Bit16 : LAN MAC Receive Interrupt Enable
- *    Interrupt Status Register (Offset 0xF208)
- *        Bit29: WAN MAC Receive Status
- *        Bit16: LAN MAC Receive Status
- *    So, this Rx interrupt enable/status bit number is equal
- *    as Rx IRQ number.
- */
-static inline u32 ks8695_get_rx_enable_bit(struct ks8695_priv *ksp)
-{
-	return ksp->rx_irq;
-}
-
 /**
  *	ks8695_rx_irq - Receive IRQ handler
  *	@irq: The IRQ which went off (ignored)
@@ -438,11 +419,7 @@ ks8695_rx_irq(int irq, void *dev_id)
 	spin_lock(&ksp->rx_lock);
 
 	if (napi_schedule_prep(&ksp->napi)) {
-		unsigned long status = readl(KS8695_IRQ_VA + KS8695_INTEN);
-		unsigned long mask_bit = 1 << ks8695_get_rx_enable_bit(ksp);
-		/*disable rx interrupt*/
-		status &= ~mask_bit;
-		writel(status , KS8695_IRQ_VA + KS8695_INTEN);
+		disable_irq(ksp->rx_irq);
 		__napi_schedule(&ksp->napi);
 	}
 
@@ -561,8 +538,6 @@ static int ks8695_rx(struct ks8695_priv *ksp, int budget)
 static int ks8695_poll(struct napi_struct *napi, int budget)
 {
 	struct ks8695_priv *ksp = container_of(napi, struct ks8695_priv, napi);
-	unsigned long isr = readl(KS8695_IRQ_VA + KS8695_INTEN);
-	unsigned long mask_bit = 1 << ks8695_get_rx_enable_bit(ksp);
 	int work_done;
 
 	work_done = ks8695_rx(ksp, budget);
@@ -571,8 +546,7 @@ static int ks8695_poll(struct napi_struct *napi, int budget)
 		unsigned long flags;
 
 		spin_lock_irqsave(&ksp->rx_lock, flags);
-		/* enable rx interrupt */
-		writel(isr | mask_bit, KS8695_IRQ_VA + KS8695_INTEN);
+		enable_irq(ksp->rx_irq);
 		spin_unlock_irqrestore(&ksp->rx_lock, flags);
 	}
 	return work_done;
-- 
2.20.0

