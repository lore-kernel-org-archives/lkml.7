Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5AE3C74A35
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 11:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9D8621019
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 11:54:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728544AbfGKLyM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 07:54:12 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:26458 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728194AbfGKLyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 07:54:12 -0400
X-UUID: adde9b17e666416d966937a19d049ef3-20190711
X-UUID: adde9b17e666416d966937a19d049ef3-20190711
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 315190674; Thu, 11 Jul 2019 19:54:00 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 11 Jul
 2019 19:53:57 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 11 Jul 2019 19:53:56 +0800
Message-ID: <1562846036.31342.10.camel@mhfsdcap03>
Subject: Re: [PATCH v8 07/21] iommu/io-pgtable-arm-v7s: Extend MediaTek 4GB
 Mode
From:   Yong Wu <yong.wu@mediatek.com>
To:     Will Deacon <will@kernel.org>
CC:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        Will Deacon <will.deacon@arm.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <yingjoe.chen@mediatek.com>,
        <youlin.pei@mediatek.com>, Nicolas Boichat <drinkcat@chromium.org>,
        <anan.sun@mediatek.com>, Matthias Kaehlcke <mka@chromium.org>,
        <chao.hao@mediatek.com>, <cui.zhang@mediatek.com>
Date:   Thu, 11 Jul 2019 19:53:56 +0800
In-Reply-To: <20190710143649.w5dplhzdpi3bxp7e@willie-the-truck>
References: <1561774167-24141-1-git-send-email-yong.wu@mediatek.com>
         <1561774167-24141-8-git-send-email-yong.wu@mediatek.com>
         <20190710143649.w5dplhzdpi3bxp7e@willie-the-truck>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: 0C86952889D210679121FAA38297439300932F8917CA01830F3FF75C994BE39B2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-07-10 at 15:36 +0100, Will Deacon wrote:
> On Sat, Jun 29, 2019 at 10:09:13AM +0800, Yong Wu wrote:
> > MediaTek extend the arm v7s descriptor to support the dram over 4GB.
> > 
> > In the mt2712 and mt8173, it's called "4GB mode", the physical address
> > is from 0x4000_0000 to 0x1_3fff_ffff, but from EMI point of view, it
> > is remapped to high address from 0x1_0000_0000 to 0x1_ffff_ffff, the
> > bit32 is always enabled. thus, in the M4U, we always enable the bit9
> > for all PTEs which means to enable bit32 of physical address.
> > 
> > but in mt8183, M4U support the dram from 0x4000_0000 to 0x3_ffff_ffff
> > which isn't remaped. We extend the PTEs: the bit9 represent bit32 of
> > PA and the bit4 represent bit33 of PA. Meanwhile the iova still is
> > 32bits.
> 
> What happens if bit4 is set in the pte for mt2712 or mt8173? Perhaps the

bit4 is ignored in mt2712 and mt8173(No effect).

> io-pgtable backend should be allowing oas > 32 when
> IO_PGTABLE_QUIRK_ARM_MTK_4GB is set, and then enforcing that itself.

About oas, It looks the oas doesn't work in current the v7s. 

How about I add a new simple preparing patch like this(copy from
io-pgtable-arm.c)?

==========================================
--- a/drivers/iommu/io-pgtable-arm-v7s.c
+++ b/drivers/iommu/io-pgtable-arm-v7s.c
@@ -495,7 +495,8 @@ static int arm_v7s_map(struct io_pgtable_ops *ops,
unsigned long iova,
        if (!(prot & (IOMMU_READ | IOMMU_WRITE)))
                return 0;

-       if (WARN_ON(upper_32_bits(iova) || upper_32_bits(paddr)))
+       if (WARN_ON(iova >= (1ULL << data->iop.cfg.ias) ||
+                   paddr >= (1ULL << data->iop.cfg.oas)))
                return -ERANGE;

===============================================

Then, change the oas in MTK 4GB mode, like this:

================================================
--- a/drivers/iommu/io-pgtable-arm-v7s.c
+++ b/drivers/iommu/io-pgtable-arm-v7s.c
@@ -721,7 +721,9 @@ static struct io_pgtable
*arm_v7s_alloc_pgtable(struct io_pgtable_cfg *cfg,
 {
        struct arm_v7s_io_pgtable *data;

-       if (cfg->ias > ARM_V7S_ADDR_BITS || cfg->oas >
ARM_V7S_ADDR_BITS)
+       if (cfg->ias > ARM_V7S_ADDR_BITS ||
+           (cfg->oas > ARM_V7S_ADDR_BITS &&
+            !(cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_4GB)))
                return NULL;

        if (cfg->quirks & ~(IO_PGTABLE_QUIRK_ARM_NS |

--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -274,7 +274,7 @@ static int mtk_iommu_domain_finalise(struct
mtk_iommu_domain *dom)
                        IO_PGTABLE_QUIRK_TLBI_ON_MAP,
                .pgsize_bitmap = mtk_iommu_ops.pgsize_bitmap,
                .ias = 32,
-               .oas = 32,
+               .oas = 34,
                .tlb = &mtk_iommu_gather_ops,
                .iommu_dev = data->dev,
        };
================================================


> 
> > In order to unify code, in the "4GB mode", we add the bit32 for the
> > physical address manually in our driver.
> > 
> > Correspondingly, Adding bit32 and bit33 for the PA in the iova_to_phys
> > has to been moved into v7s.
> > 
> > Regarding whether the pagetable address could be over 4GB, the mt8183
> > support it while the previous mt8173 don't. thus keep it as is.
> > 
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> > Reviewed-by: Evan Green <evgreen@chromium.org>
> > ---
> > Comparing with the previous one:
> > 1). Add a new patch "iommu/mediatek: Fix iova_to_phys PA start for 4GB
> > mode" before this one. Thus rebase it.
> > A little difference: in the 4gb mode, we add bit32 for PA. and the PA got
> > from iova_to_phys always have bit32 here, thus we should adjust it to locate
> > the valid pa.
> > 2). Add this code suggested from Evan.
> >  if (!data->plat_data->has_4gb_mode)
> > 	       data->enable_4GB = false;
> > ---
> >  drivers/iommu/io-pgtable-arm-v7s.c | 31 ++++++++++++++++++++++++-------
> >  drivers/iommu/mtk_iommu.c          | 29 ++++++++++++++++++-----------
> >  drivers/iommu/mtk_iommu.h          |  1 +
> >  3 files changed, 43 insertions(+), 18 deletions(-)
> > 
> > diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
> > index 94c38db..4077822 100644
> > --- a/drivers/iommu/io-pgtable-arm-v7s.c
> > +++ b/drivers/iommu/io-pgtable-arm-v7s.c
> > @@ -123,7 +123,9 @@
> >  #define ARM_V7S_TEX_MASK		0x7
> >  #define ARM_V7S_ATTR_TEX(val)		(((val) & ARM_V7S_TEX_MASK) << ARM_V7S_TEX_SHIFT)
> >  
> > -#define ARM_V7S_ATTR_MTK_4GB		BIT(9) /* MTK extend it for 4GB mode */
> > +/* MediaTek extend the two bits below for over 4GB mode */
> > +#define ARM_V7S_ATTR_MTK_PA_BIT32	BIT(9)
> > +#define ARM_V7S_ATTR_MTK_PA_BIT33	BIT(4)
> >  
> >  /* *well, except for TEX on level 2 large pages, of course :( */
> >  #define ARM_V7S_CONT_PAGE_TEX_SHIFT	6
> > @@ -190,13 +192,22 @@ static dma_addr_t __arm_v7s_dma_addr(void *pages)
> >  static arm_v7s_iopte paddr_to_iopte(phys_addr_t paddr, int lvl,
> >  				    struct io_pgtable_cfg *cfg)
> >  {
> > -	return paddr & ARM_V7S_LVL_MASK(lvl);
> > +	arm_v7s_iopte pte = paddr & ARM_V7S_LVL_MASK(lvl);
> > +
> > +	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_4GB) {
> > +		if (paddr & BIT_ULL(32))
> > +			pte |= ARM_V7S_ATTR_MTK_PA_BIT32;
> > +		if (paddr & BIT_ULL(33))
> > +			pte |= ARM_V7S_ATTR_MTK_PA_BIT33;
> > +	}
> > +	return pte;
> >  }
> >  
> >  static phys_addr_t iopte_to_paddr(arm_v7s_iopte pte, int lvl,
> >  				  struct io_pgtable_cfg *cfg)
> >  {
> >  	arm_v7s_iopte mask;
> > +	phys_addr_t paddr;
> >  
> >  	if (ARM_V7S_PTE_IS_TABLE(pte, lvl))
> >  		mask = ARM_V7S_TABLE_MASK;
> > @@ -205,7 +216,14 @@ static phys_addr_t iopte_to_paddr(arm_v7s_iopte pte, int lvl,
> >  	else
> >  		mask = ARM_V7S_LVL_MASK(lvl);
> >  
> > -	return pte & mask;
> > +	paddr = pte & mask;
> > +	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_4GB) {
> > +		if (pte & ARM_V7S_ATTR_MTK_PA_BIT32)
> > +			paddr |= BIT_ULL(32);
> > +		if (pte & ARM_V7S_ATTR_MTK_PA_BIT33)
> > +			paddr |= BIT_ULL(33);
> > +	}
> > +	return paddr;
> 
> I think this relies on CONFIG_PHYS_ADDR_T_64BIT, which isn't always set on
> 32-bit ARM.

This was discussed at [1]. Robin commented that this is not needed and
build won't complain about this.

[1]
http://lists.infradead.org/pipermail/linux-mediatek/2018-November/015688.html

> 
> Will


