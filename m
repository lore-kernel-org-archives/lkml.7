Return-Path: <SRS0=2uMJ=VL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A014C73C66
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 04:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58BFF2064A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 04:41:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbfGNEld (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 00:41:33 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:36412 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725768AbfGNEld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 00:41:33 -0400
X-UUID: 22e665ec24c24f6190113e98266cbf8f-20190714
X-UUID: 22e665ec24c24f6190113e98266cbf8f-20190714
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 680624087; Sun, 14 Jul 2019 12:41:23 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Sun, 14 Jul
 2019 12:41:20 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sun, 14 Jul 2019 12:41:20 +0800
Message-ID: <1563079280.31342.22.camel@mhfsdcap03>
Subject: Re: [PATCH v8 07/21] iommu/io-pgtable-arm-v7s: Extend MediaTek 4GB
 Mode
From:   Yong Wu <yong.wu@mediatek.com>
To:     Will Deacon <will@kernel.org>
CC:     <youlin.pei@mediatek.com>, <devicetree@vger.kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        <cui.zhang@mediatek.com>, <srv_heupstream@mediatek.com>,
        <chao.hao@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will.deacon@arm.com>,
        <linux-kernel@vger.kernel.org>, Evan Green <evgreen@chromium.org>,
        "Tomasz Figa" <tfiga@google.com>,
        <iommu@lists.linux-foundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <yingjoe.chen@mediatek.com>, <anan.sun@mediatek.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "Matthias Kaehlcke" <mka@chromium.org>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Sun, 14 Jul 2019 12:41:20 +0800
In-Reply-To: <20190711123129.da4rg35b54u4svfw@willie-the-truck>
References: <1561774167-24141-1-git-send-email-yong.wu@mediatek.com>
         <1561774167-24141-8-git-send-email-yong.wu@mediatek.com>
         <20190710143649.w5dplhzdpi3bxp7e@willie-the-truck>
         <1562846036.31342.10.camel@mhfsdcap03>
         <20190711123129.da4rg35b54u4svfw@willie-the-truck>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: 16016B8C39E8C8323B91B297DC1E8F01EBC1C5F2037E0D4703AEB5C5B962155C2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-07-11 at 13:31 +0100, Will Deacon wrote:
> On Thu, Jul 11, 2019 at 07:53:56PM +0800, Yong Wu wrote:
> > On Wed, 2019-07-10 at 15:36 +0100, Will Deacon wrote:
> > > On Sat, Jun 29, 2019 at 10:09:13AM +0800, Yong Wu wrote:
> > > > MediaTek extend the arm v7s descriptor to support the dram over 4GB.
> > > > 
> > > > In the mt2712 and mt8173, it's called "4GB mode", the physical address
> > > > is from 0x4000_0000 to 0x1_3fff_ffff, but from EMI point of view, it
> > > > is remapped to high address from 0x1_0000_0000 to 0x1_ffff_ffff, the
> > > > bit32 is always enabled. thus, in the M4U, we always enable the bit9
> > > > for all PTEs which means to enable bit32 of physical address.
> > > > 
> > > > but in mt8183, M4U support the dram from 0x4000_0000 to 0x3_ffff_ffff
> > > > which isn't remaped. We extend the PTEs: the bit9 represent bit32 of
> > > > PA and the bit4 represent bit33 of PA. Meanwhile the iova still is
> > > > 32bits.
> > > 
> > > What happens if bit4 is set in the pte for mt2712 or mt8173? Perhaps the
> > 
> > bit4 is ignored in mt2712 and mt8173(No effect).
> > 
> > > io-pgtable backend should be allowing oas > 32 when
> > > IO_PGTABLE_QUIRK_ARM_MTK_4GB is set, and then enforcing that itself.
> > 
> > About oas, It looks the oas doesn't work in current the v7s. 
> > 
> > How about I add a new simple preparing patch like this(copy from
> > io-pgtable-arm.c)?
> 
> This looks like the right sort of idea. Basically, I was thinking that you
> can use the oas in conjunction with the quirk to specify whether or not
> your two magic bits should be set. You could also then cap the oas using
> the size of phys_addr_t to deal with my other comment.
> 
> Finally, I was hoping you could drop the |= BIT_ULL(32) and the &=
> ~BIT_ULL(32) bits of the mtk driver if the pgtable code now accepts higher
> addresses. Did that not work out?


After the current patch, the pgtable has accepted the higher address.
the " |= BIT_ULL(32)" and "& = ~ BIT_ULL(32)" is for a special case(we
call it 4GB mode).

Now MediaTek IOMMU support 2 kind memory:
1) normal case: PA is 0x4000_0000 - 0x3_ffff_ffff. the PA won't be
remapped. mt8183 and the non-4GB mode of mt8173/mt2712 use this mode.

2) 4GB Mode: PA is 0x4000_0000 - 0x1_3fff_ffff. But the PA will remapped
to 0x1_0000_0000 to 0x1_ffff_ffff. This is for the 4GB mode of
mt8173/mt2712. This case is so special that we should change the PA
manually(add bit32).
(mt2712 and mt8173 have both mode: 4GB and non-4GB.)

If we try to use oas and our quirk to cover this two case. Then I can
use "oas == 33" only for this 4GB mode. and "oas == 34" for the normal
case even though the PA mayn't reach 34bit. Also I should add some
"workaround" for the 4GB mode(oas==33).

I copy the new patch in the mail below(have dropped the "|= BIT_ULL(32)"
and the "&= ~BIT_ULL(32)) in mtk iommu". please help have a look if it
is ok.
(another thing: Current the PA can support over 4GB. So the quirk name
"MTK_4GB" looks not suitable, I used a new patch rename to "MTK_EXT").

> > 
> > ==========================================
> > --- a/drivers/iommu/io-pgtable-arm-v7s.c
> > +++ b/drivers/iommu/io-pgtable-arm-v7s.c
> > @@ -495,7 +495,8 @@ static int arm_v7s_map(struct io_pgtable_ops *ops,
> > unsigned long iova,
> >         if (!(prot & (IOMMU_READ | IOMMU_WRITE)))
> >                 return 0;
> > 
> > -       if (WARN_ON(upper_32_bits(iova) || upper_32_bits(paddr)))
> > +       if (WARN_ON(iova >= (1ULL << data->iop.cfg.ias) ||
> > +                   paddr >= (1ULL << data->iop.cfg.oas)))
> >                 return -ERANGE;
> > 
> > ===============================================
> > 
> > Then, change the oas in MTK 4GB mode, like this:
> > 
> > ================================================
> > --- a/drivers/iommu/io-pgtable-arm-v7s.c
> > +++ b/drivers/iommu/io-pgtable-arm-v7s.c
> > @@ -721,7 +721,9 @@ static struct io_pgtable
> > *arm_v7s_alloc_pgtable(struct io_pgtable_cfg *cfg,
> >  {
> >         struct arm_v7s_io_pgtable *data;
> > 
> > -       if (cfg->ias > ARM_V7S_ADDR_BITS || cfg->oas >
> > ARM_V7S_ADDR_BITS)
> > +       if (cfg->ias > ARM_V7S_ADDR_BITS ||
> > +           (cfg->oas > ARM_V7S_ADDR_BITS &&
> > +            !(cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_4GB)))
> 
> This should probably still be capped at 34 bits.

Don't get here. This is only a simple checking (if (oas > 32) return
NULL). I should avoid this checking for our case.

> 
> > > > +	paddr = pte & mask;
> > > > +	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_4GB) {
> > > > +		if (pte & ARM_V7S_ATTR_MTK_PA_BIT32)
> > > > +			paddr |= BIT_ULL(32);
> > > > +		if (pte & ARM_V7S_ATTR_MTK_PA_BIT33)
> > > > +			paddr |= BIT_ULL(33);
> > > > +	}
> > > > +	return paddr;
> > > 
> > > I think this relies on CONFIG_PHYS_ADDR_T_64BIT, which isn't always set on
> > > 32-bit ARM.
> > 
> > This was discussed at [1]. Robin commented that this is not needed and
> > build won't complain about this.
> 
> It's not so much the build I was worried about, but more that we'd silently
> be doing the wrong thing and I think we can fix that as I mentioned above.

OK. see below.

> 
> Will
> 

===================================
-#define ARM_V7S_ATTR_MTK_4GB  BIT(9) /* MTK extend it for 4GB mode */
+/* MediaTek extend the two bits for PA 32bit/33bit */
+#define ARM_V7S_ATTR_MTK_PA_BIT32  BIT(9)
+#define ARM_V7S_ATTR_MTK_PA_BIT33  BIT(4)
 
 /* *well, except for TEX on level 2 large pages, of course :( */
 #define ARM_V7S_CONT_PAGE_TEX_SHIFT 6
@@ -190,13 +192,22 @@ static dma_addr_t __arm_v7s_dma_addr(void *pages)
 static arm_v7s_iopte paddr_to_iopte(phys_addr_t paddr, int lvl,
 				    struct io_pgtable_cfg *cfg)
 {
-	return paddr & ARM_V7S_LVL_MASK(lvl);
+	arm_v7s_iopte pte = paddr & ARM_V7S_LVL_MASK(lvl);
+
+	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_EXT) {
+		if ((paddr & BIT_ULL(32)) || cfg->oas == 33 /* 4GB mode */)
+			pte |= ARM_V7S_ATTR_MTK_PA_BIT32;
+		if (paddr & BIT_ULL(33))
+			pte |= ARM_V7S_ATTR_MTK_PA_BIT33;
+	}
+	return pte;
 }
 
 static phys_addr_t iopte_to_paddr(arm_v7s_iopte pte, int lvl,
 				  struct io_pgtable_cfg *cfg)
 {
 	arm_v7s_iopte mask;
+	phys_addr_t paddr;
 
 	if (ARM_V7S_PTE_IS_TABLE(pte, lvl))
 		mask = ARM_V7S_TABLE_MASK;
@@ -205,7 +216,20 @@ static phys_addr_t iopte_to_paddr(arm_v7s_iopte
pte, int lvl,
 	else
 		mask = ARM_V7S_LVL_MASK(lvl);
 
-	return pte & mask;
+	paddr = pte & mask;
+	if (IS_ENABLED(CONFIG_PHYS_ADDR_T_64BIT) &&
+	    (cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_EXT)) {
+		/*
+		 * Workaround for MTK 4GB Mode:
+		 * Add BIT32 only when PA < 0x4000_0000.
+		 */
+		if ((cfg->oas == 33 && paddr < 0x40000000UL) ||
+		    (cfg->oas > 33 && (pte & ARM_V7S_ATTR_MTK_PA_BIT32)))
+			paddr |= BIT_ULL(32);
+		if (pte & ARM_V7S_ATTR_MTK_PA_BIT33)
+			paddr |= BIT_ULL(33);
+	}
+	return paddr;
 }
 
 static arm_v7s_iopte *iopte_deref(arm_v7s_iopte pte, int lvl,
@@ -326,9 +350,6 @@ static arm_v7s_iopte arm_v7s_prot_to_pte(int prot,
int lvl,
 	if (lvl == 1 && (cfg->quirks & IO_PGTABLE_QUIRK_ARM_NS))
 		pte |= ARM_V7S_ATTR_NS_SECTION;
 
-	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_EXT)
-		pte |= ARM_V7S_ATTR_MTK_4GB;
-
 	return pte;
 }
 
@@ -742,7 +763,9 @@ static struct io_pgtable
*arm_v7s_alloc_pgtable(struct io_pgtable_cfg *cfg,
 {
 	struct arm_v7s_io_pgtable *data;
 
-	if (cfg->ias > ARM_V7S_ADDR_BITS || cfg->oas > ARM_V7S_ADDR_BITS)
+	if (cfg->ias > ARM_V7S_ADDR_BITS ||
+	    (cfg->oas > ARM_V7S_ADDR_BITS &&
+	     !(cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_EXT)))
 		return NULL;
 
 	if (cfg->quirks & ~(IO_PGTABLE_QUIRK_ARM_NS |
diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 85e71fb..1a141ea 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -271,16 +271,18 @@ static int mtk_iommu_domain_finalise(struct
mtk_iommu_domain *dom)
 	dom->cfg = (struct io_pgtable_cfg) {
 		.quirks = IO_PGTABLE_QUIRK_ARM_NS |
 			IO_PGTABLE_QUIRK_NO_PERMS |
-			IO_PGTABLE_QUIRK_TLBI_ON_MAP,
+			IO_PGTABLE_QUIRK_TLBI_ON_MAP |
+			IO_PGTABLE_QUIRK_ARM_MTK_EXT,
 		.pgsize_bitmap = mtk_iommu_ops.pgsize_bitmap,
 		.ias = 32,
-		.oas = 32,
 		.tlb = &mtk_iommu_gather_ops,
 		.iommu_dev = data->dev,
 	};
 
 	if (data->enable_4GB)
-		dom->cfg.quirks |= IO_PGTABLE_QUIRK_ARM_MTK_EXT;
+		dom->cfg.oas = 33; /* Only for 4GB mode */
+	else
+		dom->cfg.oas = 34;
 
 	dom->iop = alloc_io_pgtable_ops(ARM_V7S, &dom->cfg, data);
 	if (!dom->iop) {
@@ -371,8 +373,7 @@ static int mtk_iommu_map(struct iommu_domain
*domain, unsigned long iova,
 	int ret;
 
 	spin_lock_irqsave(&dom->pgtlock, flags);
-	ret = dom->iop->map(dom->iop, iova, paddr & DMA_BIT_MASK(32),
-			    size, prot);
+	ret = dom->iop->map(dom->iop, iova, paddr, size, prot);
 	spin_unlock_irqrestore(&dom->pgtlock, flags);
 
 	return ret;
@@ -401,7 +402,6 @@ static phys_addr_t mtk_iommu_iova_to_phys(struct
iommu_domain *domain,
 					  dma_addr_t iova)
 {
 	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
-	struct mtk_iommu_data *data = mtk_iommu_get_m4u_data();
 	unsigned long flags;
 	phys_addr_t pa;
 
@@ -409,9 +409,6 @@ static phys_addr_t mtk_iommu_iova_to_phys(struct
iommu_domain *domain,
 	pa = dom->iop->iova_to_phys(dom->iop, iova);
 	spin_unlock_irqrestore(&dom->pgtlock, flags);
 
-	if (data->enable_4GB)
-		pa |= BIT_ULL(32);
-
 	return pa;
 } 
===================================
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek


