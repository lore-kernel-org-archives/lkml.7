Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC359C76191
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 05:37:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD7082173B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 05:37:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbfGRFhg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 01:37:36 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:55784 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726304AbfGRFhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 01:37:35 -0400
X-UUID: 56b8101c485841a88775199fbb1b285b-20190718
X-UUID: 56b8101c485841a88775199fbb1b285b-20190718
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 208262468; Thu, 18 Jul 2019 13:37:29 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS32DR.mediatek.inc
 (172.27.6.104) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 18 Jul
 2019 13:37:24 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 18 Jul 2019 13:37:23 +0800
Message-ID: <1563428243.31342.39.camel@mhfsdcap03>
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
Date:   Thu, 18 Jul 2019 13:37:23 +0800
In-Reply-To: <20190717142339.wltamw6wktwixqqn@willie-the-truck>
References: <1561774167-24141-1-git-send-email-yong.wu@mediatek.com>
         <1561774167-24141-8-git-send-email-yong.wu@mediatek.com>
         <20190710143649.w5dplhzdpi3bxp7e@willie-the-truck>
         <1562846036.31342.10.camel@mhfsdcap03>
         <20190711123129.da4rg35b54u4svfw@willie-the-truck>
         <1563079280.31342.22.camel@mhfsdcap03>
         <20190715095156.xczfkbm6zpjueq32@willie-the-truck>
         <1563367459.31342.34.camel@mhfsdcap03>
         <20190717142339.wltamw6wktwixqqn@willie-the-truck>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: FCC812B93959C45D6AFBE2DE9BA4C64EE9C5BF014909D9D18086284D23A8FC762000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-07-17 at 15:23 +0100, Will Deacon wrote:
> On Wed, Jul 17, 2019 at 08:44:19PM +0800, Yong Wu wrote:
> > On Mon, 2019-07-15 at 10:51 +0100, Will Deacon wrote:
> > > On Sun, Jul 14, 2019 at 12:41:20PM +0800, Yong Wu wrote:
> > > > @@ -742,7 +763,9 @@ static struct io_pgtable
> > > > *arm_v7s_alloc_pgtable(struct io_pgtable_cfg *cfg,
> > > >  {
> > > >  	struct arm_v7s_io_pgtable *data;
> > > >  
> > > > -	if (cfg->ias > ARM_V7S_ADDR_BITS || cfg->oas > ARM_V7S_ADDR_BITS)
> > > > +	if (cfg->ias > ARM_V7S_ADDR_BITS ||
> > > > +	    (cfg->oas > ARM_V7S_ADDR_BITS &&
> > > > +	     !(cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_EXT)))
> > > >  		return NULL;
> > > 
> > > I think you can rework this to do something like:
> > > 
> > > 	if (cfg->ias > ARM_V7S_ADDR_BITS)
> > > 		return NULL;
> > > 
> > > 	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_EXT) {
> > > 		if (!IS_ENABLED(CONFIG_PHYS_ADDR_T_64BIT))
> > > 			cfg->oas = min(cfg->oas, ARM_V7S_ADDR_BITS);
> > > 		else if (cfg->oas > 34)
> > > 			return NULL;
> > > 	} else if (cfg->oas > ARM_V7S_ADDR_BITS) {
> > > 		return NULL;
> > > 	}
> > > 
> > > so that we clamp the oas when phys_addr_t is 32-bit for you. That should
> > > allow you to remove lots of the checking from iopte_to_paddr() too if you
> > > check against oas in the map() function.
> > > 
> > > Does that make sense?
> > 
> > Of course I'm ok for this. I'm only afraid that this function has
> > already 3 checking "if (x) return NULL", Here we add a new one and so
> > many lines... Maybe the user should guarantee the right value of oas.
> > How about move it into mtk_iommu.c?
> > 
> > About the checking of iopte_to_paddr, I can not remove them. I know it
> > may be a bit special and not readable. Hmm, I guess I should use a MACRO
> > instead of the hard code 33 for the special 4GB mode case.
> 
> Why can't you just do something like:
> 
> 	if (!(cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_EXT))
> 		return paddr;
> 
> 	if (pte & ARM_V7S_ATTR_MTK_PA_BIT33)
> 		paddr |= BIT_ULL(33);

OK here.

> 
> 	if (pte & ARM_V&S_ATTR_MTK_PA_BIT32)
> 		paddr |= BIT_ULL(32);

No here, The flow is a bit special for 4GB mode here.

This is the detailed remap relationship for our 4GB mode.
           CPU PA               ->    HW PA
register: 0x0 ~ 0x3fff_ffff
dram 1G:0x4000_0000~0x7fff_ffff ->0x1_4000_0000~0x1_7fff_ffff(Add bit32)
dram 2G:0x8000_0000~0xbfff_ffff ->0x1_8000_0000~0x1_bfff_ffff(Add bit32)
dram 3G:0xc000_0000~0xffff_ffff ->0x1_c000_0000~0x1_ffff_ffff(Add bit32)
dram 4G:0x1_0000_0000~0x1_3fff_ffff->0x1_0000_0000~0x1_3fff_ffff

Thus, in the 4GB mode, we should add always add bit9 in pte(for bit32
PA). But we can not always add bit32 in the iova_to_phys. The valid PA
range should be 0x4000_0000 - 0x1_3fff_ffff. Thus, we can only add bit32
when the PA in pte < 0x4000_0000, keep it as-is if the PA in pte located
from 0x4000_0000 to 0xffff_ffff.

This issue exist all the time after we added 4GB mode for mt8173.

Thus, I have to add a special flow for 4gb mode here:

	/* Workaround for MTK 4GB Mode: Add BIT32 only when PA < 0x4000_0000.*/
	if (cfg->oas == ARM_V7S_MTK_4GB_OAS && paddr < 0x40000000UL)
		paddr |= BIT_ULL(32);
	else if (pte & ARM_V7S_ATTR_MTK_PA_BIT32)
		paddr |= BIT_ULL(32);

> 
> 	return paddr;
> 
> The diff I sent previously sanitises the oas at init time, and then you
> can just enforce it in map().
> 
> Will


