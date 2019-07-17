Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71196C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 12:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01E82205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 12:45:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbfGQMpX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 08:45:23 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:3376 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725906AbfGQMpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 08:45:23 -0400
X-UUID: a615da28752845cda54311e0e09bf035-20190717
X-UUID: a615da28752845cda54311e0e09bf035-20190717
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 328166412; Wed, 17 Jul 2019 20:44:22 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS32N1.mediatek.inc
 (172.27.4.71) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 17 Jul
 2019 20:44:20 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 17 Jul 2019 20:44:19 +0800
Message-ID: <1563367459.31342.34.camel@mhfsdcap03>
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
Date:   Wed, 17 Jul 2019 20:44:19 +0800
In-Reply-To: <20190715095156.xczfkbm6zpjueq32@willie-the-truck>
References: <1561774167-24141-1-git-send-email-yong.wu@mediatek.com>
         <1561774167-24141-8-git-send-email-yong.wu@mediatek.com>
         <20190710143649.w5dplhzdpi3bxp7e@willie-the-truck>
         <1562846036.31342.10.camel@mhfsdcap03>
         <20190711123129.da4rg35b54u4svfw@willie-the-truck>
         <1563079280.31342.22.camel@mhfsdcap03>
         <20190715095156.xczfkbm6zpjueq32@willie-the-truck>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: 517FF8854FED11BA2C61D9E820D360BA1874F27ED39F4A69084A223C5CAC34212000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-07-15 at 10:51 +0100, Will Deacon wrote:
> On Sun, Jul 14, 2019 at 12:41:20PM +0800, Yong Wu wrote:
> > On Thu, 2019-07-11 at 13:31 +0100, Will Deacon wrote:
> > > This looks like the right sort of idea. Basically, I was thinking that you
> > > can use the oas in conjunction with the quirk to specify whether or not
> > > your two magic bits should be set. You could also then cap the oas using
> > > the size of phys_addr_t to deal with my other comment.
> > > 
> > > Finally, I was hoping you could drop the |= BIT_ULL(32) and the &=
> > > ~BIT_ULL(32) bits of the mtk driver if the pgtable code now accepts higher
> > > addresses. Did that not work out?
> > 
> > After the current patch, the pgtable has accepted the higher address.
> > the " |= BIT_ULL(32)" and "& = ~ BIT_ULL(32)" is for a special case(we
> > call it 4GB mode).
> > 
> > Now MediaTek IOMMU support 2 kind memory:
> > 1) normal case: PA is 0x4000_0000 - 0x3_ffff_ffff. the PA won't be
> > remapped. mt8183 and the non-4GB mode of mt8173/mt2712 use this mode.
> > 
> > 2) 4GB Mode: PA is 0x4000_0000 - 0x1_3fff_ffff. But the PA will remapped
> > to 0x1_0000_0000 to 0x1_ffff_ffff. This is for the 4GB mode of
> > mt8173/mt2712. This case is so special that we should change the PA
> > manually(add bit32).
> > (mt2712 and mt8173 have both mode: 4GB and non-4GB.)
> > 
> > If we try to use oas and our quirk to cover this two case. Then I can
> > use "oas == 33" only for this 4GB mode. and "oas == 34" for the normal
> > case even though the PA mayn't reach 34bit. Also I should add some
> > "workaround" for the 4GB mode(oas==33).
> > 
> > I copy the new patch in the mail below(have dropped the "|= BIT_ULL(32)"
> > and the "&= ~BIT_ULL(32)) in mtk iommu". please help have a look if it
> > is ok.
> > (another thing: Current the PA can support over 4GB. So the quirk name
> > "MTK_4GB" looks not suitable, I used a new patch rename to "MTK_EXT").
> 
> Makes sense, thanks. One comment below.
> 
> > @@ -205,7 +216,20 @@ static phys_addr_t iopte_to_paddr(arm_v7s_iopte
> > pte, int lvl,
> >  	else
> >  		mask = ARM_V7S_LVL_MASK(lvl);
> >  
> > -	return pte & mask;
> > +	paddr = pte & mask;
> > +	if (IS_ENABLED(CONFIG_PHYS_ADDR_T_64BIT) &&
> > +	    (cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_EXT)) {
> > +		/*
> > +		 * Workaround for MTK 4GB Mode:
> > +		 * Add BIT32 only when PA < 0x4000_0000.
> > +		 */
> > +		if ((cfg->oas == 33 && paddr < 0x40000000UL) ||
> > +		    (cfg->oas > 33 && (pte & ARM_V7S_ATTR_MTK_PA_BIT32)))
> > +			paddr |= BIT_ULL(32);
> > +		if (pte & ARM_V7S_ATTR_MTK_PA_BIT33)
> > +			paddr |= BIT_ULL(33);
> > +	}
> > +	return paddr;
> >  }
> >  
> >  static arm_v7s_iopte *iopte_deref(arm_v7s_iopte pte, int lvl,
> > @@ -326,9 +350,6 @@ static arm_v7s_iopte arm_v7s_prot_to_pte(int prot,
> > int lvl,
> >  	if (lvl == 1 && (cfg->quirks & IO_PGTABLE_QUIRK_ARM_NS))
> >  		pte |= ARM_V7S_ATTR_NS_SECTION;
> >  
> > -	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_EXT)
> > -		pte |= ARM_V7S_ATTR_MTK_4GB;
> > -
> >  	return pte;
> >  }
> >  
> > @@ -742,7 +763,9 @@ static struct io_pgtable
> > *arm_v7s_alloc_pgtable(struct io_pgtable_cfg *cfg,
> >  {
> >  	struct arm_v7s_io_pgtable *data;
> >  
> > -	if (cfg->ias > ARM_V7S_ADDR_BITS || cfg->oas > ARM_V7S_ADDR_BITS)
> > +	if (cfg->ias > ARM_V7S_ADDR_BITS ||
> > +	    (cfg->oas > ARM_V7S_ADDR_BITS &&
> > +	     !(cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_EXT)))
> >  		return NULL;
> 
> I think you can rework this to do something like:
> 
> 	if (cfg->ias > ARM_V7S_ADDR_BITS)
> 		return NULL;
> 
> 	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_EXT) {
> 		if (!IS_ENABLED(CONFIG_PHYS_ADDR_T_64BIT))
> 			cfg->oas = min(cfg->oas, ARM_V7S_ADDR_BITS);
> 		else if (cfg->oas > 34)
> 			return NULL;
> 	} else if (cfg->oas > ARM_V7S_ADDR_BITS) {
> 		return NULL;
> 	}
> 
> so that we clamp the oas when phys_addr_t is 32-bit for you. That should
> allow you to remove lots of the checking from iopte_to_paddr() too if you
> check against oas in the map() function.
> 
> Does that make sense?

Of course I'm ok for this. I'm only afraid that this function has
already 3 checking "if (x) return NULL", Here we add a new one and so
many lines... Maybe the user should guarantee the right value of oas.
How about move it into mtk_iommu.c?

About the checking of iopte_to_paddr, I can not remove them. I know it
may be a bit special and not readable. Hmm, I guess I should use a MACRO
instead of the hard code 33 for the special 4GB mode case.

Then the patch would be like:

//=========================
static phys_addr_t iopte_to_paddr(arm_v7s_iopte pte, int lvl,
 				  struct io_pgtable_cfg *cfg)
 {
 	arm_v7s_iopte mask;
+	phys_addr_t paddr;
 
 	if (ARM_V7S_PTE_IS_TABLE(pte, lvl))
 		mask = ARM_V7S_TABLE_MASK;
@@ -205,7 +216,21 @@ static phys_addr_t iopte_to_paddr(arm_v7s_iopte
pte, int lvl,
 	else
 		mask = ARM_V7S_LVL_MASK(lvl);
 
-	return pte & mask;
+	paddr = pte & mask;
+	if (cfg->oas > ARM_V7S_ADDR_BITS &&
+	    (cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_EXT)) {
+		/*
+		 * Workaround for MTK 4GB Mode:
+		 * Add BIT32 only when PA < 0x4000_0000.
+		 */
+		if (cfg->oas == ARM_V7S_MTK_4GB_OAS && paddr < 0x40000000UL)
+			paddr |= BIT_ULL(32);
+		else if (pte & ARM_V7S_ATTR_MTK_PA_BIT32)
+			paddr |= BIT_ULL(32);
+		if (pte & ARM_V7S_ATTR_MTK_PA_BIT33)
+			paddr |= BIT_ULL(33);
+	}
+	return paddr;
 } 

@@ -741,8 +763,10 @@ static struct io_pgtable
*arm_v7s_alloc_pgtable(struct io_pgtable_cfg *cfg,
 						void *cookie)
 {
 	struct arm_v7s_io_pgtable *data;
-
-	if (cfg->ias > ARM_V7S_ADDR_BITS || cfg->oas > ARM_V7S_ADDR_BITS)
+ 	
+	if (cfg->ias > ARM_V7S_ADDR_BITS ||
+	    (cfg->oas > ARM_V7S_ADDR_BITS &&
+	     !(cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_EXT)))
 		return NULL;
 
 	if (cfg->quirks & ~(IO_PGTABLE_QUIRK_ARM_NS |
diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 85e71fb..4efc5a3 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -271,16 +271,20 @@ static int mtk_iommu_domain_finalise(struct
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
 
-	if (data->enable_4GB)
-		dom->cfg.quirks |= IO_PGTABLE_QUIRK_ARM_MTK_EXT;
+	if (!IS_ENABLED(CONFIG_PHYS_ADDR_T_64BIT))
+		dom->cfg.oas = 32;
+	else if (data->enable_4GB)
+		dom->cfg.oas = ARM_V7S_MTK_4GB_OAS;
+	else
+		dom->cfg.oas = 34;

--- a/include/linux/io-pgtable.h
+++ b/include/linux/io-pgtable.h
@@ -117,6 +116,8 @@ struct io_pgtable_cfg {
 	};
 };
 
+#define ARM_V7S_MTK_4GB_OAS			33
+
 /**
  * struct io_pgtable_ops - Page table manipulation API for IOMMU
drivers.
  *
=====================================
> 
> Will


