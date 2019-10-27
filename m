Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A83AFCA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A3BC21726
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572210462;
	bh=gv1Y2SUXRrBy9F58HbHm7Oba8NO36ODdouYrlrZSFJM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=moqedkCB9N/oRz4LDdZq9kv517bzAAjblvKtyXFahcwPCJnfo7dcfPOwLAu/IaOVs
	 HXDZE7fZKP8kvzqWoarow4dzx5Fn6vTtsqLgL7PMZSyAsSsWyvzwVZNS4zge39Ho7k
	 cJ3uN3qAG9sObLHGHxKXTnsMCiCMhlERD+i9aC08=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729236AbfJ0VHl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 17:07:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:53678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729211AbfJ0VHi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 17:07:38 -0400
Received: from localhost (100.50.158.77.rev.sfr.net [77.158.50.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D92F4222C9;
        Sun, 27 Oct 2019 21:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572210457;
        bh=gv1Y2SUXRrBy9F58HbHm7Oba8NO36ODdouYrlrZSFJM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cl3vYum6OhFLc3FJeDN9AmSVKE6ILzb0rXfjnT9sxzfkEdXncoe6kSntRtH/fF6On
         3ih7Q3hlZnM2wWS4O4p4WikROA+C4Pqipkg8Y2J9T8nAAY2UJtXxIDnk1kSCWh5e+1
         7jPKX+xPTZ7cLBZyqbAs8ygOlpWm1CvyqZrW0rzk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Thomas Bogendoerfer <tbogendoerfer@suse.de>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 022/119] net: i82596: fix dma_alloc_attr for sni_82596
Date:   Sun, 27 Oct 2019 21:59:59 +0100
Message-Id: <20191027203306.580033772@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191027203259.948006506@linuxfoundation.org>
References: <20191027203259.948006506@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Bogendoerfer <tbogendoerfer@suse.de>

[ Upstream commit 61c1d33daf7b5146f44d4363b3322f8cda6a6c43 ]

Commit 7f683b920479 ("i825xx: switch to switch to dma_alloc_attrs")
switched dma allocation over to dma_alloc_attr, but didn't convert
the SNI part to request consistent DMA memory. This broke sni_82596
since driver doesn't do dma_cache_sync for performance reasons.
Fix this by using different DMA_ATTRs for lasi_82596 and sni_82596.

Fixes: 7f683b920479 ("i825xx: switch to switch to dma_alloc_attrs")
Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/i825xx/lasi_82596.c |    4 +++-
 drivers/net/ethernet/i825xx/lib82596.c   |    4 ++--
 drivers/net/ethernet/i825xx/sni_82596.c  |    4 +++-
 3 files changed, 8 insertions(+), 4 deletions(-)

--- a/drivers/net/ethernet/i825xx/lasi_82596.c
+++ b/drivers/net/ethernet/i825xx/lasi_82596.c
@@ -96,6 +96,8 @@
 
 #define OPT_SWAP_PORT	0x0001	/* Need to wordswp on the MPU port */
 
+#define LIB82596_DMA_ATTR	DMA_ATTR_NON_CONSISTENT
+
 #define DMA_WBACK(ndev, addr, len) \
 	do { dma_cache_sync((ndev)->dev.parent, (void *)addr, len, DMA_TO_DEVICE); } while (0)
 
@@ -199,7 +201,7 @@ static int __exit lan_remove_chip(struct
 
 	unregister_netdev (dev);
 	dma_free_attrs(&pdev->dev, sizeof(struct i596_private), lp->dma,
-		       lp->dma_addr, DMA_ATTR_NON_CONSISTENT);
+		       lp->dma_addr, LIB82596_DMA_ATTR);
 	free_netdev (dev);
 	return 0;
 }
--- a/drivers/net/ethernet/i825xx/lib82596.c
+++ b/drivers/net/ethernet/i825xx/lib82596.c
@@ -1065,7 +1065,7 @@ static int i82596_probe(struct net_devic
 
 	dma = dma_alloc_attrs(dev->dev.parent, sizeof(struct i596_dma),
 			      &lp->dma_addr, GFP_KERNEL,
-			      DMA_ATTR_NON_CONSISTENT);
+			      LIB82596_DMA_ATTR);
 	if (!dma) {
 		printk(KERN_ERR "%s: Couldn't get shared memory\n", __FILE__);
 		return -ENOMEM;
@@ -1087,7 +1087,7 @@ static int i82596_probe(struct net_devic
 	i = register_netdev(dev);
 	if (i) {
 		dma_free_attrs(dev->dev.parent, sizeof(struct i596_dma),
-			       dma, lp->dma_addr, DMA_ATTR_NON_CONSISTENT);
+			       dma, lp->dma_addr, LIB82596_DMA_ATTR);
 		return i;
 	}
 
--- a/drivers/net/ethernet/i825xx/sni_82596.c
+++ b/drivers/net/ethernet/i825xx/sni_82596.c
@@ -23,6 +23,8 @@
 
 static const char sni_82596_string[] = "snirm_82596";
 
+#define LIB82596_DMA_ATTR	0
+
 #define DMA_WBACK(priv, addr, len)     do { } while (0)
 #define DMA_INV(priv, addr, len)       do { } while (0)
 #define DMA_WBACK_INV(priv, addr, len) do { } while (0)
@@ -151,7 +153,7 @@ static int sni_82596_driver_remove(struc
 
 	unregister_netdev(dev);
 	dma_free_attrs(dev->dev.parent, sizeof(struct i596_private), lp->dma,
-		       lp->dma_addr, DMA_ATTR_NON_CONSISTENT);
+		       lp->dma_addr, LIB82596_DMA_ATTR);
 	iounmap(lp->ca);
 	iounmap(lp->mpu_port);
 	free_netdev (dev);


