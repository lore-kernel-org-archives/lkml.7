Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A22FC31E40
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 10:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D516A21743
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 10:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565863492;
	bh=yxI0sYzxm56wWHyuBuXXRIR2MAoWLEH8I3NLqvWNi6c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bNppFdGdzHFyfJ/43Dhlj+N7Z1kFEb09xqWjTQJ+vUeujFccvVF1u5Fw2iEgw4scu
	 KSDnvaiHIJ3VpXxiq3aZyZi9cQ1Inu5xudKQ9ONBpjK/7AwhEEyvpmo7ye2qtMc2j3
	 5RafRVca8OpPbmBJadBJM9MhUYNF+21b44bztXTA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731394AbfHOKEw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 06:04:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:56666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730204AbfHOKEv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 06:04:51 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B62E2171F;
        Thu, 15 Aug 2019 10:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565863490;
        bh=yxI0sYzxm56wWHyuBuXXRIR2MAoWLEH8I3NLqvWNi6c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jSRJrhTBXaa2Ojwuw6biSSRTaiPSPdLZ4P6G1Im3nT25iX6kFOhv4Sxvr1c+jYiNo
         X2LX255IKefPOK5ysGmm+uVom+NtdoJJbnIfqwbRKDfp6Jry7pjou8JfgaZy6/mMyL
         chjfxGXwHBTx93zFvqtLS6DSo225hcIakmX+rTYY=
Date:   Thu, 15 Aug 2019 11:04:44 +0100
From:   Will Deacon <will@kernel.org>
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, youlin.pei@mediatek.com,
        Nicolas Boichat <drinkcat@chromium.org>, anan.sun@mediatek.com,
        Matthias Kaehlcke <mka@chromium.org>, cui.zhang@mediatek.com,
        chao.hao@mediatek.com, ming-fan.chen@mediatek.com
Subject: Re: [PATCH v9 08/21] iommu/io-pgtable-arm-v7s: Extend MediaTek 4GB
 Mode
Message-ID: <20190815100443.5oobqjivyosurwzn@willie-the-truck>
References: <1565423901-17008-1-git-send-email-yong.wu@mediatek.com>
 <1565423901-17008-9-git-send-email-yong.wu@mediatek.com>
 <20190814144059.ruyc45yoqkwpbuga@willie-the-truck>
 <1565858869.12818.51.camel@mhfsdcap03>
 <20190815095123.rzgtpklvhtjlqir4@willie-the-truck>
 <1565863410.12818.56.camel@mhfsdcap03>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1565863410.12818.56.camel@mhfsdcap03>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2019 at 06:03:30PM +0800, Yong Wu wrote:
> On Thu, 2019-08-15 at 10:51 +0100, Will Deacon wrote:
> > On Thu, Aug 15, 2019 at 04:47:49PM +0800, Yong Wu wrote:
> > > On Wed, 2019-08-14 at 15:41 +0100, Will Deacon wrote:
> > > > On Sat, Aug 10, 2019 at 03:58:08PM +0800, Yong Wu wrote:
> > > > > MediaTek extend the arm v7s descriptor to support the dram over 4GB.
> > > > > 
> > > > > In the mt2712 and mt8173, it's called "4GB mode", the physical address
> > > > > is from 0x4000_0000 to 0x1_3fff_ffff, but from EMI point of view, it
> > > > > is remapped to high address from 0x1_0000_0000 to 0x1_ffff_ffff, the
> > > > > bit32 is always enabled. thus, in the M4U, we always enable the bit9
> > > > > for all PTEs which means to enable bit32 of physical address. Here is
> > > > > the detailed remap relationship in the "4GB mode":
> > > > > CPU PA         ->    HW PA
> > > > > 0x4000_0000          0x1_4000_0000 (Add bit32)
> > > > > 0x8000_0000          0x1_8000_0000 ...
> > > > > 0xc000_0000          0x1_c000_0000 ...
> > > > > 0x1_0000_0000        0x1_0000_0000 (No change)
> > > > 
> > > > So in this example, there are no PAs below 0x4000_0000 yet you later
> > > > add code to deal with that:
> > > > 
> > > > > +	/* Workaround for MTK 4GB Mode: Add BIT32 only when PA < 0x4000_0000.*/
> > > > > +	if (cfg->oas == ARM_V7S_MTK_4GB_OAS && paddr < 0x40000000UL)
> > > > > +		paddr |= BIT_ULL(32);
> > > > 
> > > > Why? Mainline currently doesn't do anything like this for the "4gb mode"
> > > > support as far as I can tell. In fact, we currently unconditionally set
> > > > bit 32 in the physical address returned by iova_to_phys() which wouldn't
> > > > match your CPU PAs listed above, so I'm confused about how this is supposed
> > > > to work.
> > > 
> > > Actually current mainline have a bug for this. So I tried to use another
> > > special patch[1] for it in v8.
> > 
> > If you're fixing a bug in mainline, I'd prefer to see that as a separate
> > patch.
> > 
> > > But the issue is not critical since MediaTek multimedia consumer(v4l2
> > > and drm) don't call iommu_iova_to_phys currently.
> > > 
> > > > 
> > > > The way I would like this quirk to work is that the io-pgtable code
> > > > basically sets bit 9 in the pte when bit 32 is set in the physical address,
> > > > and sets bit 4 in the pte when bit 33 is set in the physical address. It
> > > > would then do the opposite when converting a pte to a physical address.
> > > > 
> > > > That way, your driver can call the page table code directly with the high
> > > > addresses and we don't have to do any manual offsetting or range checking
> > > > in the page table code.
> > > 
> > > In this case, the mt8183 can work successfully while the "4gb
> > > mode"(mt8173/mt2712) can not.
> > > 
> > > In the "4gb mode", As the remap relationship above, we should always add
> > > bit32 in pte as we did in [2]. and need add bit32 in the
> > > "iova_to_phys"(Not always add.). That means the "4gb mode" has a special
> > > flow:
> > > a. Always add bit32 in paddr_to_iopte.
> > > b. Add bit32 only when PA < 0x40000000 in iopte_to_paddr.
> > 
> > I think this is probably at the heart of my misunderstanding. What is so
> > special about PAs (is this HW PA or CPU PA?) below 0x40000000? Is this RAM
> > or something else?
> 
> SRAM and the HW registers.

Do we actually need to be able to map those in the IOMMU?

Will
