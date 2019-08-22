Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 210C5C3A59D
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 10:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3392233FD
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 10:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566469079;
	bh=D5zRVu+USg1+RS1lEwQnNpD4UWyIvPicvP8SU5txo7M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hqFKdTALHB4CADp0nnrSplLpT0dHlB7IJx7VvmWsGX4juR27Vvgjp3IDp/vEFdaIf
	 UzXeTQ8vVwMUXiq4RXWnmTN9qtEi7RhZBwl0y6uIcdjvrOZDgMkE3hVEuPRQAarkDG
	 HZ+8t20YWnM6KDiJMUufvW1K9JVXNrVsD/ZpEqv0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387517AbfHVKR6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 06:17:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:57338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731865AbfHVKR5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 06:17:57 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2EA0A206BB;
        Thu, 22 Aug 2019 10:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566469076;
        bh=D5zRVu+USg1+RS1lEwQnNpD4UWyIvPicvP8SU5txo7M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U+kQlDk/quo+7he7VCs7KWCgcPH6jsj+XqyXsFL1nkatram4CncWOWeCdSKn/rY/g
         +iRxXCIDdDiMiWHQcq6VRQ1qG5uB7ctPdIy7P/MENCTB0Hu4QpP11xguJp+ZhYENWW
         9LXMLpxz8xM/2PO8Erokk4mm7xsc+uOJrVaKRsdI=
Date:   Thu, 22 Aug 2019 11:17:50 +0100
From:   Will Deacon <will@kernel.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Yong Wu <yong.wu@mediatek.com>, youlin.pei@mediatek.com,
        devicetree@vger.kernel.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        cui.zhang@mediatek.com, srv_heupstream@mediatek.com,
        chao.hao@mediatek.com, Joerg Roedel <joro@8bytes.org>,
        linux-kernel@vger.kernel.org, Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        ming-fan.chen@mediatek.com, anan.sun@mediatek.com,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v10 09/23] iommu/io-pgtable-arm-v7s: Extend to support
 PA[33:32] for MediaTek
Message-ID: <20190822101749.3kwzd5lb7zinsord@willie-the-truck>
References: <1566395606-7975-1-git-send-email-yong.wu@mediatek.com>
 <1566395606-7975-10-git-send-email-yong.wu@mediatek.com>
 <20190821152448.qmoqjh5zznfpdi6n@willie-the-truck>
 <1566464186.11621.7.camel@mhfsdcap03>
 <10d5122d-3375-161b-9356-2ddfc1c835bd@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10d5122d-3375-161b-9356-2ddfc1c835bd@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 22, 2019 at 11:08:58AM +0100, Robin Murphy wrote:
> On 2019-08-22 9:56 am, Yong Wu wrote:
> > On Wed, 2019-08-21 at 16:24 +0100, Will Deacon wrote:
> > > On Wed, Aug 21, 2019 at 09:53:12PM +0800, Yong Wu wrote:
> > > > MediaTek extend the arm v7s descriptor to support up to 34 bits PA where
> > > > the bit32 and bit33 are encoded in the bit9 and bit4 of the PTE
> > > > respectively. Meanwhile the iova still is 32bits.
> > > > 
> > > > Regarding whether the pagetable address could be over 4GB, the mt8183
> > > > support it while the previous mt8173 don't, thus keep it as is.
> > > > 
> > > > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > > > ---
> > > >   drivers/iommu/io-pgtable-arm-v7s.c | 32 +++++++++++++++++++++++++-------
> > > >   include/linux/io-pgtable.h         |  7 +++----
> > > >   2 files changed, 28 insertions(+), 11 deletions(-)
> > > 
> > > [...]
> > > 
> > > > @@ -731,7 +747,9 @@ static struct io_pgtable *arm_v7s_alloc_pgtable(struct io_pgtable_cfg *cfg,
> > > >   {
> > > >   	struct arm_v7s_io_pgtable *data;
> > > > -	if (cfg->ias > ARM_V7S_ADDR_BITS || cfg->oas > ARM_V7S_ADDR_BITS)
> > > > +	if (cfg->ias > ARM_V7S_ADDR_BITS ||
> > > > +	    (cfg->oas > ARM_V7S_ADDR_BITS &&
> > > > +	     !(cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_EXT)))
> > > 
> > > Please can you instead change arm_v7s_alloc_pgtable() so that it allows an
> > > ias of up to 34 when the IO_PGTABLE_QUIRK_ARM_MTK_EXT is set?
> > 
> > Here I only simply skip the oas checking for our case. then which way do
> > your prefer?  something like you commented before:?
> > 
> > 
> > 	if (cfg->ias > ARM_V7S_ADDR_BITS)
> > 		return NULL;
> > 
> > 	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_EXT) {
> > 		if (!IS_ENABLED(CONFIG_PHYS_ADDR_T_64BIT))
> > 			cfg->oas = min(cfg->oas, ARM_V7S_ADDR_BITS);
> > 		else if (cfg->oas > 34)
> > 			return NULL;
> > 	} else if (cfg->oas > ARM_V7S_ADDR_BITS) {
> > 		return NULL;
> > 	}
> 
> All it should take is something like:
> 
> 	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_EXT)
> 		max_oas = 34;
> 	else
> 		max_oas = 32;
> 	if (cfg->oas > max_oas)
> 		return NULL;
> 
> or even just:
> 
> 	if (cfg->oas > 32 ||
> 	    (cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_EXT && cfg->oas > 34))
> 		return NULL;
> 
> (and if we prefer the latter style, perhaps we could introduce some kind of
> "is_mtk_4gb()" helper to save on verbosity)

I wondered the same thing, but another place we'd want the check is in
iopte_to_paddr() which probably needs the PHYS_ADDR_T check to avoid GCC
warnings, although I didn't try it.

So if we did:

static bool cfg_mtk_ext_enabled(struct io_pgtable_cfg *cfg)
{
	return IS_ENABLED(CONFIG_PHYS_ADDR_T_64BIT) &&
	       cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_EXT;
}

Then I suppose we could do this in _alloc():

	if (cfg->oas > cfg_mtk_ext_enabled(cfg) ? 34 : ARM_V7S_ADDR_BITS)
		return NULL;

and then this in iopte_to_paddr():

	[...]

	paddr = pte & mask;
	if (!cfg_mtk_ext_enabled(cfg))
		return paddr;

	if (pte & ARM_V7S_ATTR_MTK_PA_BIT32)
		paddr |= ...

	[...]

What do you reckon?

Will
