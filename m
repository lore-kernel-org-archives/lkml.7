Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD4DC43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 02:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61FCC21721
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 02:42:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbfFVCme (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 22:42:34 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:28999 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726049AbfFVCmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 22:42:33 -0400
X-UUID: 46f3b0ab22ef47108b56fa41695c34ec-20190622
X-UUID: 46f3b0ab22ef47108b56fa41695c34ec-20190622
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1842459820; Sat, 22 Jun 2019 10:42:21 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Sat, 22 Jun
 2019 10:42:20 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sat, 22 Jun 2019 10:42:19 +0800
Message-ID: <1561171339.4850.6.camel@mhfsdcap03>
Subject: Re: [PATCH v7 19/21] iommu/mediatek: Rename enable_4GB to
 dram_is_4gb
From:   Yong Wu <yong.wu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        "Tomasz Figa" <tfiga@google.com>,
        Will Deacon <will.deacon@arm.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <yingjoe.chen@mediatek.com>,
        <youlin.pei@mediatek.com>, Nicolas Boichat <drinkcat@chromium.org>,
        <anan.sun@mediatek.com>, Matthias Kaehlcke <mka@chromium.org>
Date:   Sat, 22 Jun 2019 10:42:19 +0800
In-Reply-To: <d932ded6-2e1c-f2d1-d3cf-8cb0cdbdbb0d@gmail.com>
References: <1560169080-27134-1-git-send-email-yong.wu@mediatek.com>
         <1560169080-27134-20-git-send-email-yong.wu@mediatek.com>
         <9bf13c22-0c73-2950-2204-23d577976b03@gmail.com>
         <1561039192.4021.23.camel@mhfsdcap03>
         <d932ded6-2e1c-f2d1-d3cf-8cb0cdbdbb0d@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 2019-06-21 at 12:10 +0200, Matthias Brugger wrote:
> 
> On 20/06/2019 15:59, Yong Wu wrote:
> > On Tue, 2019-06-18 at 18:06 +0200, Matthias Brugger wrote:
> >>
> >> On 10/06/2019 14:17, Yong Wu wrote:
> >>> This patch only rename the variable name from enable_4GB to
> >>> dram_is_4gb for readable.
> >>
> >> From my understanding this is true when available RAM > 4GB so I think the name
> >> should be something like dram_bigger_4gb otherwise it may create confusion again.
> > 
> > Strictly, It is not "dram_bigger_4gb". actually if the dram size is over
> > 3GB (the first 1GB is the register space), the "4GB mode" will be
> > enabled. then how about the name "dram_enable_32bit"?(the PA 32bit will
> > be enabled in the 4GB mode.)
> 
> Ok I think dram_is_4gb is ok then. But I'd suggest to add an explanation above
> the struct mtk_iommu_data to explain exactly what this means.
> 
> >      
> > There is another option, please see the last part in [1] suggested by
> > Evan, something like below:
> > ----
> > data->enable_4GB = !!(max_pfn > (BIT_ULL(32) >> PAGE_SHIFT));
> > if (!data->plat_data->has_4gb_mode)
> >     data->enable_4GB = false;
> > Then mtk_iommu_map would only have:
> >     if (data->enable_4GB)
> >          paddr |= BIT_ULL(32);
> > ----
> 
> I think that's a nicer way to handle it.

Thanks your feedback. then I will use this way.

> 
> Regards,
> Matthias
> 
> > 
> > Which one do you prefer?      
> >       
> > [1] https://lore.kernel.org/patchwork/patch/1028421/
> > 
> >>
> >> Also from my point of view this patch should be done before
> >> "[PATCH 06/21] iommu/io-pgtable-arm-v7s: Extend MediaTek 4GB Mode"
> > 
> > OK.
> > 
> >>
> >> Regards,
> >> Matthias
> >>
> >>>
> >>> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> >>> Reviewed-by: Evan Green <evgreen@chromium.org>
> >>> ---
> >>>  drivers/iommu/mtk_iommu.c | 10 +++++-----
> >>>  drivers/iommu/mtk_iommu.h |  2 +-
> >>>  2 files changed, 6 insertions(+), 6 deletions(-)
> >>>
> >>> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> >>> index 86158d8..67cab2d 100644
> >>> --- a/drivers/iommu/mtk_iommu.c
> >>> +++ b/drivers/iommu/mtk_iommu.c
> >>> @@ -382,7 +382,7 @@ static int mtk_iommu_map(struct iommu_domain *domain, unsigned long iova,
> >>>  	int ret;
> >>>  
> >>>  	/* The "4GB mode" M4U physically can not use the lower remap of Dram. */
> >>> -	if (data->plat_data->has_4gb_mode && data->enable_4GB)
> >>> +	if (data->plat_data->has_4gb_mode && data->dram_is_4gb)
> >>>  		paddr |= BIT_ULL(32);
> >>>  
> >>>  	spin_lock_irqsave(&dom->pgtlock, flags);
> >>> @@ -554,13 +554,13 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
> >>>  	writel_relaxed(regval, data->base + REG_MMU_INT_MAIN_CONTROL);
> >>>  
> >>>  	if (data->plat_data->m4u_plat == M4U_MT8173)
> >>> -		regval = (data->protect_base >> 1) | (data->enable_4GB << 31);
> >>> +		regval = (data->protect_base >> 1) | (data->dram_is_4gb << 31);
> >>>  	else
> >>>  		regval = lower_32_bits(data->protect_base) |
> >>>  			 upper_32_bits(data->protect_base);
> >>>  	writel_relaxed(regval, data->base + REG_MMU_IVRP_PADDR);
> >>>  
> >>> -	if (data->enable_4GB && data->plat_data->has_vld_pa_rng) {
> >>> +	if (data->dram_is_4gb && data->plat_data->has_vld_pa_rng) {
> >>>  		/*
> >>>  		 * If 4GB mode is enabled, the validate PA range is from
> >>>  		 * 0x1_0000_0000 to 0x1_ffff_ffff. here record bit[32:30].
> >>> @@ -611,8 +611,8 @@ static int mtk_iommu_probe(struct platform_device *pdev)
> >>>  		return -ENOMEM;
> >>>  	data->protect_base = ALIGN(virt_to_phys(protect), MTK_PROTECT_PA_ALIGN);
> >>>  
> >>> -	/* Whether the current dram is over 4GB */
> >>> -	data->enable_4GB = !!(max_pfn > (BIT_ULL(32) >> PAGE_SHIFT));
> >>> +	/* Whether the current dram is 4GB. */
> >>> +	data->dram_is_4gb = !!(max_pfn > (BIT_ULL(32) >> PAGE_SHIFT));
> >>>  
> >>>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >>>  	data->base = devm_ioremap_resource(dev, res);
> >>> diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
> >>> index 753266b..e8114b2 100644
> >>> --- a/drivers/iommu/mtk_iommu.h
> >>> +++ b/drivers/iommu/mtk_iommu.h
> >>> @@ -65,7 +65,7 @@ struct mtk_iommu_data {
> >>>  	struct mtk_iommu_domain		*m4u_dom;
> >>>  	struct iommu_group		*m4u_group;
> >>>  	struct mtk_smi_iommu		smi_imu;      /* SMI larb iommu info */
> >>> -	bool                            enable_4GB;
> >>> +	bool                            dram_is_4gb;
> >>>  	bool				tlb_flush_active;
> >>>  
> >>>  	struct iommu_device		iommu;
> >>>
> > 
> > 



