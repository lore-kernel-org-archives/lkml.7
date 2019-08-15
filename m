Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF1DEC31E40
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 08:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96C9321952
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 08:48:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730472AbfHOIsw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 04:48:52 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:8176 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726027AbfHOIsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 04:48:52 -0400
X-UUID: 75f2b3f6954d4fbc9a95ac3b96d6119f-20190815
X-UUID: 75f2b3f6954d4fbc9a95ac3b96d6119f-20190815
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1118993526; Thu, 15 Aug 2019 16:47:56 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 15 Aug
 2019 16:47:53 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 15 Aug 2019 16:47:50 +0800
Message-ID: <1565858869.12818.51.camel@mhfsdcap03>
Subject: Re: [PATCH v9 08/21] iommu/io-pgtable-arm-v7s: Extend MediaTek 4GB
 Mode
From:   Yong Wu <yong.wu@mediatek.com>
To:     Will Deacon <will@kernel.org>
CC:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <youlin.pei@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        <anan.sun@mediatek.com>, Matthias Kaehlcke <mka@chromium.org>,
        <cui.zhang@mediatek.com>, <chao.hao@mediatek.com>,
        <ming-fan.chen@mediatek.com>
Date:   Thu, 15 Aug 2019 16:47:49 +0800
In-Reply-To: <20190814144059.ruyc45yoqkwpbuga@willie-the-truck>
References: <1565423901-17008-1-git-send-email-yong.wu@mediatek.com>
         <1565423901-17008-9-git-send-email-yong.wu@mediatek.com>
         <20190814144059.ruyc45yoqkwpbuga@willie-the-truck>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: 5D5FC90C041DBBD20C3DCD33A1B62E596CBBC6711A0F58C204785566B9B413132000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-08-14 at 15:41 +0100, Will Deacon wrote:
> Hi Yong Wu,
> 
> Sorry, but I'm still deeply confused by this patch.

Sorry for this. the "4GB mode" really is a bit odd...

> 
> On Sat, Aug 10, 2019 at 03:58:08PM +0800, Yong Wu wrote:
> > MediaTek extend the arm v7s descriptor to support the dram over 4GB.
> > 
> > In the mt2712 and mt8173, it's called "4GB mode", the physical address
> > is from 0x4000_0000 to 0x1_3fff_ffff, but from EMI point of view, it
> > is remapped to high address from 0x1_0000_0000 to 0x1_ffff_ffff, the
> > bit32 is always enabled. thus, in the M4U, we always enable the bit9
> > for all PTEs which means to enable bit32 of physical address. Here is
> > the detailed remap relationship in the "4GB mode":
> > CPU PA         ->    HW PA
> > 0x4000_0000          0x1_4000_0000 (Add bit32)
> > 0x8000_0000          0x1_8000_0000 ...
> > 0xc000_0000          0x1_c000_0000 ...
> > 0x1_0000_0000        0x1_0000_0000 (No change)
> 
> So in this example, there are no PAs below 0x4000_0000 yet you later
> add code to deal with that:
> 
> > +	/* Workaround for MTK 4GB Mode: Add BIT32 only when PA < 0x4000_0000.*/
> > +	if (cfg->oas == ARM_V7S_MTK_4GB_OAS && paddr < 0x40000000UL)
> > +		paddr |= BIT_ULL(32);
> 
> Why? Mainline currently doesn't do anything like this for the "4gb mode"
> support as far as I can tell. In fact, we currently unconditionally set
> bit 32 in the physical address returned by iova_to_phys() which wouldn't
> match your CPU PAs listed above, so I'm confused about how this is supposed
> to work.

Actually current mainline have a bug for this. So I tried to use another
special patch[1] for it in v8.

But the issue is not critical since MediaTek multimedia consumer(v4l2
and drm) don't call iommu_iova_to_phys currently.

> 
> The way I would like this quirk to work is that the io-pgtable code
> basically sets bit 9 in the pte when bit 32 is set in the physical address,
> and sets bit 4 in the pte when bit 33 is set in the physical address. It
> would then do the opposite when converting a pte to a physical address.
> 
> That way, your driver can call the page table code directly with the high
> addresses and we don't have to do any manual offsetting or range checking
> in the page table code.

In this case, the mt8183 can work successfully while the "4gb
mode"(mt8173/mt2712) can not.

In the "4gb mode", As the remap relationship above, we should always add
bit32 in pte as we did in [2]. and need add bit32 in the
"iova_to_phys"(Not always add.). That means the "4gb mode" has a special
flow:
a. Always add bit32 in paddr_to_iopte.
b. Add bit32 only when PA < 0x40000000 in iopte_to_paddr.

> 
> Please can you explain to me why the diff below doesn't work on top of
> this series?

The diff below is just I did in v8[3]. The different is that I move the
"4gb mode" special flow in the mtk_iommu.c in v8, the code is like
[4]below. When I sent v9, I found that I can distinguish the "4gb mode"
with "oas == 33" in v7s. then I can "simply" add the 4gb special flow[5]
based on your diff.


>  I'm happy to chat on IRC if you think it would be easier,
> because I have a horrible feeling that we've been talking past each other
> and I'd like to see this support merged for 5.4.

Thanks very much for your view, I'm sorry that I don't have IRC. I will
send the next version quickly if we have a conclusion here. Then Which
way is better? If you'd like keep the pagetable code clean, I will add
the "4gb mode" special flow into mtk_iommu.c.

Thanks.


[1]http://lists.infradead.org/pipermail/linux-mediatek/2019-June/020988.html
[2]
https://elixir.bootlin.com/linux/v5.3-rc4/source/drivers/iommu/io-pgtable-arm-v7s.c#L299
[3]http://lists.infradead.org/pipermail/linux-mediatek/2019-June/020991.html

[4]======4gb mode special flow in mtk_iommu.c======================

+#define MTK_IOMMU_4GB_MODE_REMAP_BASE	 0x140000000UL

@@ -380,12 +379,16 @@ static int mtk_iommu_map(struct iommu_domain
*domain, unsigned long iova,
 			 phys_addr_t paddr, size_t size, int prot)
 {
 	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
+	struct mtk_iommu_data *data = mtk_iommu_get_m4u_data();
 	unsigned long flags;
 	int ret;
 
+	/* The "4GB mode" M4U physically can not use the lower remap of Dram.
*/
+	if (data->enable_4GB)
+		paddr |= BIT_ULL(32);
+
 	spin_lock_irqsave(&dom->pgtlock, flags);
-	ret = dom->iop->map(dom->iop, iova, paddr & DMA_BIT_MASK(32),
-			    size, prot);
+	ret = dom->iop->map(dom->iop, iova, paddr, size, prot);
 	spin_unlock_irqrestore(&dom->pgtlock, flags);
 
 	return ret;
@@ -422,8 +425,8 @@ static phys_addr_t mtk_iommu_iova_to_phys(struct
iommu_domain *domain,
 	pa = dom->iop->iova_to_phys(dom->iop, iova);
 	spin_unlock_irqrestore(&dom->pgtlock, flags);
 
-	if (data->enable_4GB && pa < MTK_IOMMU_4GB_MODE_REMAP_BASE)
-		pa |= BIT_ULL(32);
+	if (data->enable_4GB && pa >= MTK_IOMMU_4GB_MODE_REMAP_BASE)
+		pa &= ~BIT_ULL(32);
 
 	return pa;
 }
=============================================================

[5]:
=========================================================
diff --git a/drivers/iommu/io-pgtable-arm-v7s.c
b/drivers/iommu/io-pgtable-arm-v7s.c
index 78fd11e..8e974a5 100644
--- a/drivers/iommu/io-pgtable-arm-v7s.c
+++ b/drivers/iommu/io-pgtable-arm-v7s.c
@@ -184,7 +184,7 @@ static arm_v7s_iopte paddr_to_iopte(phys_addr_t
paddr, int lvl,
 	arm_v7s_iopte pte = paddr & ARM_V7S_LVL_MASK(lvl);
 
 	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_4GB) {
-		if (paddr & BIT_ULL(32))
+		if (paddr & BIT_ULL(32) || cfg->oas == 33)
 			pte |= ARM_V7S_ATTR_MTK_PA_BIT32;
 		if (paddr & BIT_ULL(33))
 			pte |= ARM_V7S_ATTR_MTK_PA_BIT33;
@@ -207,7 +207,9 @@ static phys_addr_t iopte_to_paddr(arm_v7s_iopte pte,
int lvl,
 
 	paddr = pte & mask;
 	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_4GB) {
-		if (pte & ARM_V7S_ATTR_MTK_PA_BIT32)
+		if (cfg->oas == 33 && paddr < 0x40000000UL)
+			paddr |= BIT_ULL(32);
+		else if (pte & ARM_V7S_ATTR_MTK_PA_BIT32)
 			paddr |= BIT_ULL(32);
 		if (pte & ARM_V7S_ATTR_MTK_PA_BIT33)
 			paddr |= BIT_ULL(33);
============================================================

> 
> Will
> 
> --->8
> 
> diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
> index ab12ef5f8b03..d8d84617c822 100644
> --- a/drivers/iommu/io-pgtable-arm-v7s.c
> +++ b/drivers/iommu/io-pgtable-arm-v7s.c
> @@ -184,7 +184,7 @@ static arm_v7s_iopte paddr_to_iopte(phys_addr_t paddr, int lvl,
>  	arm_v7s_iopte pte = paddr & ARM_V7S_LVL_MASK(lvl);
>  
>  	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_EXT) {
> -		if ((paddr & BIT_ULL(32)) || cfg->oas == ARM_V7S_MTK_4GB_OAS)
> +		if (paddr & BIT_ULL(32))
>  			pte |= ARM_V7S_ATTR_MTK_PA_BIT32;
>  		if (paddr & BIT_ULL(33))
>  			pte |= ARM_V7S_ATTR_MTK_PA_BIT33;
> @@ -206,17 +206,14 @@ static phys_addr_t iopte_to_paddr(arm_v7s_iopte pte, int lvl,
>  		mask = ARM_V7S_LVL_MASK(lvl);
>  
>  	paddr = pte & mask;
> -	if (cfg->oas == 32 || !(cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_EXT))
> -		return paddr;
>  
> -	if (pte & ARM_V7S_ATTR_MTK_PA_BIT33)
> -		paddr |= BIT_ULL(33);
> +	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_EXT) {
> +		if (pte & ARM_V7S_ATTR_MTK_PA_BIT32)
> +			paddr |= BIT_ULL(32);
> +		if (pte & ARM_V7S_ATTR_MTK_PA_BIT33)
> +			paddr |= BIT_ULL(33);
> +	}
>  
> -	/* Workaround for MTK 4GB Mode: Add BIT32 only when PA < 0x4000_0000.*/
> -	if (cfg->oas == ARM_V7S_MTK_4GB_OAS && paddr < 0x40000000UL)
> -		paddr |= BIT_ULL(32);
> -	else if (pte & ARM_V7S_ATTR_MTK_PA_BIT32)
> -		paddr |= BIT_ULL(32);
>  	return paddr;
>  }
>  
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index d5b9454352fd..3ae54dedede0 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -286,7 +286,7 @@ static int mtk_iommu_domain_finalise(struct mtk_iommu_domain *dom)
>  	if (!IS_ENABLED(CONFIG_PHYS_ADDR_T_64BIT))
>  		dom->cfg.oas = 32;
>  	else if (data->enable_4GB)
> -		dom->cfg.oas = ARM_V7S_MTK_4GB_OAS;
> +		dom->cfg.oas = 33;
>  	else
>  		dom->cfg.oas = 34;
>  
> diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
> index 27337395bd42..a2a52c349fe4 100644
> --- a/include/linux/io-pgtable.h
> +++ b/include/linux/io-pgtable.h
> @@ -113,8 +113,6 @@ struct io_pgtable_cfg {
>  	};
>  };
>  
> -#define ARM_V7S_MTK_4GB_OAS			33
> -
>  /**
>   * struct io_pgtable_ops - Page table manipulation API for IOMMU drivers.
>   *


