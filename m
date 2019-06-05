Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4173CC282DE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 05:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B61B20866
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 05:52:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PIJl5hSe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbfFEFwP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 01:52:15 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52902 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbfFEFwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 01:52:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=mQPnxrhp5YNAxbcRHunQ2loi4lsOMm2nCJapuHt3yu8=; b=PIJl5hSe98LLKx79uZ1dqZsNg
        b2rndQ5ZR8VcWAZeunlR8hh5a5sMcO8TUDiKi+ddHBvHfo49KDV+Wt5b7npFln+CQ6BC8G7/76nmP
        Iorz+ZIr/BBYin/WF+R7snd+9qpPsajI1isSocXkdQ6ed/FKCltCJsufpjfi8FPmir+YW+f15hwjN
        pPyk1fwo3QRljg46ofS8KUKwwHPJPh3TuKYqaWqIkzJrnfPu4XZ2R1VxBXz21NZ9MXdsMDDK8Ohlc
        TmrfGKrzenAu7LFttfAqfYLyTW/947yKE9E2vxqkajbskJ53kpTt/7UILS0lD2aCWUu6vMTLK2d23
        wFmcyw+nw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hYOqK-0005Zc-T9; Wed, 05 Jun 2019 05:52:12 +0000
To:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Miller <davem@davemloft.net>
Cc:     Sean Wang <sean.wang@mediatek.com>,
        John Crispin <blogic@openwrt.org>,
        Felix Fietkau <nbd@openwrt.org>,
        Nelson Chang <nelson.chang@mediatek.com>,
        kbuild test robot <lkp@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH -next] net: ethernet: mediatek: fix mtk_eth_soc build errors &
 warnings
Message-ID: <85d9fdd9-4b7f-6a51-b885-b3a43f199ec9@infradead.org>
Date:   Tue, 4 Jun 2019 22:52:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix build errors in Mediatek mtk_eth_soc driver.

It looks like these 3 source files were meant to be linked together
since 2 of them are library-like functions,
but they are currently being built as 3 loadable modules.

Fixes these build errors:

  WARNING: modpost: missing MODULE_LICENSE() in drivers/net/ethernet/mediatek/mtk_eth_path.o
  WARNING: modpost: missing MODULE_LICENSE() in drivers/net/ethernet/mediatek/mtk_sgmii.o
  ERROR: "mtk_sgmii_init" [drivers/net/ethernet/mediatek/mtk_eth_soc.ko] undefined!
  ERROR: "mtk_setup_hw_path" [drivers/net/ethernet/mediatek/mtk_eth_soc.ko] undefined!
  ERROR: "mtk_sgmii_setup_mode_force" [drivers/net/ethernet/mediatek/mtk_eth_soc.ko] undefined!
  ERROR: "mtk_sgmii_setup_mode_an" [drivers/net/ethernet/mediatek/mtk_eth_soc.ko] undefined!
  ERROR: "mtk_w32" [drivers/net/ethernet/mediatek/mtk_eth_path.ko] undefined!
  ERROR: "mtk_r32" [drivers/net/ethernet/mediatek/mtk_eth_path.ko] undefined!

This changes the loadable module name from mtk_eth_soc to mtk_eth.
I didn't see a way to leave it as mtk_eth_soc.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Sean Wang <sean.wang@mediatek.com>
Cc: John Crispin <blogic@openwrt.org>
Cc: Felix Fietkau <nbd@openwrt.org>
Cc: Nelson Chang <nelson.chang@mediatek.com>
---
 drivers/net/ethernet/mediatek/Makefile |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20190604.orig/drivers/net/ethernet/mediatek/Makefile
+++ linux-next-20190604/drivers/net/ethernet/mediatek/Makefile
@@ -3,5 +3,5 @@
 # Makefile for the Mediatek SoCs built-in ethernet macs
 #
 
-obj-$(CONFIG_NET_MEDIATEK_SOC)                 += mtk_eth_soc.o mtk_sgmii.o \
-						  mtk_eth_path.o
+obj-$(CONFIG_NET_MEDIATEK_SOC)                 += mtk_eth.o
+mtk_eth-y := mtk_eth_soc.o mtk_sgmii.o mtk_eth_path.o


