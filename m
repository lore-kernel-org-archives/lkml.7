Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF9AC3A59D
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 08:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A9FB214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 08:56:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732808AbfHVI4m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 04:56:42 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:17849 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731348AbfHVI4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 04:56:42 -0400
X-UUID: 12062e92b4164c44998da9081270e292-20190822
X-UUID: 12062e92b4164c44998da9081270e292-20190822
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 515483021; Thu, 22 Aug 2019 16:56:30 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 22 Aug
 2019 16:56:22 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 22 Aug 2019 16:56:21 +0800
Message-ID: <1566464186.11621.7.camel@mhfsdcap03>
Subject: Re: [PATCH v10 09/23] iommu/io-pgtable-arm-v7s: Extend to support
 PA[33:32] for MediaTek
From:   Yong Wu <yong.wu@mediatek.com>
To:     Will Deacon <will@kernel.org>
CC:     <youlin.pei@mediatek.com>, <devicetree@vger.kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        <cui.zhang@mediatek.com>, <srv_heupstream@mediatek.com>,
        <chao.hao@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        <linux-kernel@vger.kernel.org>, Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        <iommu@lists.linux-foundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <ming-fan.chen@mediatek.com>, <anan.sun@mediatek.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "Matthias Kaehlcke" <mka@chromium.org>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Thu, 22 Aug 2019 16:56:26 +0800
In-Reply-To: <20190821152448.qmoqjh5zznfpdi6n@willie-the-truck>
References: <1566395606-7975-1-git-send-email-yong.wu@mediatek.com>
         <1566395606-7975-10-git-send-email-yong.wu@mediatek.com>
         <20190821152448.qmoqjh5zznfpdi6n@willie-the-truck>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: A53204EC2B24E8ED10E65E7323376A240E74388A8016195038C20EBC411B98902000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-08-21 at 16:24 +0100, Will Deacon wrote:
> On Wed, Aug 21, 2019 at 09:53:12PM +0800, Yong Wu wrote:
> > MediaTek extend the arm v7s descriptor to support up to 34 bits PA where
> > the bit32 and bit33 are encoded in the bit9 and bit4 of the PTE
> > respectively. Meanwhile the iova still is 32bits.
> > 
> > Regarding whether the pagetable address could be over 4GB, the mt8183
> > support it while the previous mt8173 don't, thus keep it as is.
> > 
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> >  drivers/iommu/io-pgtable-arm-v7s.c | 32 +++++++++++++++++++++++++-------
> >  include/linux/io-pgtable.h         |  7 +++----
> >  2 files changed, 28 insertions(+), 11 deletions(-)
> 
> [...]
> 
> > @@ -731,7 +747,9 @@ static struct io_pgtable *arm_v7s_alloc_pgtable(struct io_pgtable_cfg *cfg,
> >  {
> >  	struct arm_v7s_io_pgtable *data;
> >  
> > -	if (cfg->ias > ARM_V7S_ADDR_BITS || cfg->oas > ARM_V7S_ADDR_BITS)
> > +	if (cfg->ias > ARM_V7S_ADDR_BITS ||
> > +	    (cfg->oas > ARM_V7S_ADDR_BITS &&
> > +	     !(cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_EXT)))
> 
> Please can you instead change arm_v7s_alloc_pgtable() so that it allows an
> ias of up to 34 when the IO_PGTABLE_QUIRK_ARM_MTK_EXT is set?

Here I only simply skip the oas checking for our case. then which way do
your prefer?  something like you commented before:?


	if (cfg->ias > ARM_V7S_ADDR_BITS)
		return NULL;

	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_EXT) {
		if (!IS_ENABLED(CONFIG_PHYS_ADDR_T_64BIT))
			cfg->oas = min(cfg->oas, ARM_V7S_ADDR_BITS);
		else if (cfg->oas > 34)
			return NULL;
	} else if (cfg->oas > ARM_V7S_ADDR_BITS) {
		return NULL;
	}


> 
> With that change:
> 
> Acked-by: Will Deacon <will@kernel.org>
> 
> Will
> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek


