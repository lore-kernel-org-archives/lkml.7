Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C12C282DE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 09:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D30C20866
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 09:19:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbfFEJTq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 05:19:46 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:36082 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726862AbfFEJTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 05:19:46 -0400
X-UUID: cc3ab885d0cd4c82959726a3cc53dfe9-20190605
X-UUID: cc3ab885d0cd4c82959726a3cc53dfe9-20190605
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 476848323; Wed, 05 Jun 2019 17:19:30 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 5 Jun 2019 17:19:29 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 5 Jun 2019 17:19:29 +0800
Message-ID: <1559726369.9003.4.camel@mtkswgap22>
Subject: Re: [PATCH -next] net: ethernet: mediatek: fix mtk_eth_soc build
 errors & warnings
From:   Sean Wang <sean.wang@mediatek.com>
To:     Randy Dunlap <rdunlap@infradead.org>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        "John Crispin" <blogic@openwrt.org>,
        Felix Fietkau <nbd@openwrt.org>,
        Nelson Chang <nelson.chang@mediatek.com>,
        kbuild test robot <lkp@intel.com>
Date:   Wed, 5 Jun 2019 17:19:29 +0800
In-Reply-To: <85d9fdd9-4b7f-6a51-b885-b3a43f199ec9@infradead.org>
References: <85d9fdd9-4b7f-6a51-b885-b3a43f199ec9@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy, 

Thanks for your help.  But it seems I've already made the same fixup for the problem in http://lists.infradead.org/pipermail/linux-mediatek/2019-June/020301.html
as soon as the kbuild test robot reported this.

	Sean

On Tue, 2019-06-04 at 22:52 -0700, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix build errors in Mediatek mtk_eth_soc driver.
> 
> It looks like these 3 source files were meant to be linked together
> since 2 of them are library-like functions,
> but they are currently being built as 3 loadable modules.
> 
> Fixes these build errors:
> 
>   WARNING: modpost: missing MODULE_LICENSE() in drivers/net/ethernet/mediatek/mtk_eth_path.o
>   WARNING: modpost: missing MODULE_LICENSE() in drivers/net/ethernet/mediatek/mtk_sgmii.o
>   ERROR: "mtk_sgmii_init" [drivers/net/ethernet/mediatek/mtk_eth_soc.ko] undefined!
>   ERROR: "mtk_setup_hw_path" [drivers/net/ethernet/mediatek/mtk_eth_soc.ko] undefined!
>   ERROR: "mtk_sgmii_setup_mode_force" [drivers/net/ethernet/mediatek/mtk_eth_soc.ko] undefined!
>   ERROR: "mtk_sgmii_setup_mode_an" [drivers/net/ethernet/mediatek/mtk_eth_soc.ko] undefined!
>   ERROR: "mtk_w32" [drivers/net/ethernet/mediatek/mtk_eth_path.ko] undefined!
>   ERROR: "mtk_r32" [drivers/net/ethernet/mediatek/mtk_eth_path.ko] undefined!
> 
> This changes the loadable module name from mtk_eth_soc to mtk_eth.
> I didn't see a way to leave it as mtk_eth_soc.
> 
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Sean Wang <sean.wang@mediatek.com>
> Cc: John Crispin <blogic@openwrt.org>
> Cc: Felix Fietkau <nbd@openwrt.org>
> Cc: Nelson Chang <nelson.chang@mediatek.com>
> ---
>  drivers/net/ethernet/mediatek/Makefile |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> --- linux-next-20190604.orig/drivers/net/ethernet/mediatek/Makefile
> +++ linux-next-20190604/drivers/net/ethernet/mediatek/Makefile
> @@ -3,5 +3,5 @@
>  # Makefile for the Mediatek SoCs built-in ethernet macs
>  #
>  
> -obj-$(CONFIG_NET_MEDIATEK_SOC)                 += mtk_eth_soc.o mtk_sgmii.o \
> -						  mtk_eth_path.o
> +obj-$(CONFIG_NET_MEDIATEK_SOC)                 += mtk_eth.o
> +mtk_eth-y := mtk_eth_soc.o mtk_sgmii.o mtk_eth_path.o
> 
> 


