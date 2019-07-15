Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FAF7C76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 09:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2032214AE
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 09:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563184327;
	bh=Sehveqjg8zwSH5xO1XpEINg8wkrvEYGXw3Z1knB6BbE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=V2VMONzTkZI71I2+i8e8sNBFdcLPmnur/MxWpa6F518rOnmSCC7PsWSIzIGSE8HU6
	 USKZNUTlUI6FnN0bAm9KTBKj6dpSSYujm1ssevtwWT0gY6Grddq/J59jQqiROtMncw
	 6Q+92l5ydcU9QW0M2iHI8I4cs2bxypTF1yjDSLOU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729705AbfGOJwG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 05:52:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:47806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729686AbfGOJwF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 05:52:05 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6F1C20868;
        Mon, 15 Jul 2019 09:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563184324;
        bh=Sehveqjg8zwSH5xO1XpEINg8wkrvEYGXw3Z1knB6BbE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BhsQfTxgg8czwGQZz8JkgGjKDf1ZGfgLfcdEUEeuBK59aMQv0s0KkpWQli8kmNZu+
         PYYQ5VTcRmhQQCSkuwCfjagxTyWoUkGvUbZlEV6y192UxDDiz41REyR9BaplKLTNNE
         jV2NKFA41J30+3Siqmv1Yv+aWyjmNAWRQ8axIH+U=
Date:   Mon, 15 Jul 2019 10:51:57 +0100
From:   Will Deacon <will@kernel.org>
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     youlin.pei@mediatek.com, devicetree@vger.kernel.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        cui.zhang@mediatek.com, srv_heupstream@mediatek.com,
        chao.hao@mediatek.com, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        yingjoe.chen@mediatek.com, anan.sun@mediatek.com,
        Robin Murphy <robin.murphy@arm.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v8 07/21] iommu/io-pgtable-arm-v7s: Extend MediaTek 4GB
 Mode
Message-ID: <20190715095156.xczfkbm6zpjueq32@willie-the-truck>
References: <1561774167-24141-1-git-send-email-yong.wu@mediatek.com>
 <1561774167-24141-8-git-send-email-yong.wu@mediatek.com>
 <20190710143649.w5dplhzdpi3bxp7e@willie-the-truck>
 <1562846036.31342.10.camel@mhfsdcap03>
 <20190711123129.da4rg35b54u4svfw@willie-the-truck>
 <1563079280.31342.22.camel@mhfsdcap03>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1563079280.31342.22.camel@mhfsdcap03>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 14, 2019 at 12:41:20PM +0800, Yong Wu wrote:
> On Thu, 2019-07-11 at 13:31 +0100, Will Deacon wrote:
> > This looks like the right sort of idea. Basically, I was thinking that you
> > can use the oas in conjunction with the quirk to specify whether or not
> > your two magic bits should be set. You could also then cap the oas using
> > the size of phys_addr_t to deal with my other comment.
> > 
> > Finally, I was hoping you could drop the |= BIT_ULL(32) and the &=
> > ~BIT_ULL(32) bits of the mtk driver if the pgtable code now accepts higher
> > addresses. Did that not work out?
> 
> After the current patch, the pgtable has accepted the higher address.
> the " |= BIT_ULL(32)" and "& = ~ BIT_ULL(32)" is for a special case(we
> call it 4GB mode).
> 
> Now MediaTek IOMMU support 2 kind memory:
> 1) normal case: PA is 0x4000_0000 - 0x3_ffff_ffff. the PA won't be
> remapped. mt8183 and the non-4GB mode of mt8173/mt2712 use this mode.
> 
> 2) 4GB Mode: PA is 0x4000_0000 - 0x1_3fff_ffff. But the PA will remapped
> to 0x1_0000_0000 to 0x1_ffff_ffff. This is for the 4GB mode of
> mt8173/mt2712. This case is so special that we should change the PA
> manually(add bit32).
> (mt2712 and mt8173 have both mode: 4GB and non-4GB.)
> 
> If we try to use oas and our quirk to cover this two case. Then I can
> use "oas == 33" only for this 4GB mode. and "oas == 34" for the normal
> case even though the PA mayn't reach 34bit. Also I should add some
> "workaround" for the 4GB mode(oas==33).
> 
> I copy the new patch in the mail below(have dropped the "|= BIT_ULL(32)"
> and the "&= ~BIT_ULL(32)) in mtk iommu". please help have a look if it
> is ok.
> (another thing: Current the PA can support over 4GB. So the quirk name
> "MTK_4GB" looks not suitable, I used a new patch rename to "MTK_EXT").

Makes sense, thanks. One comment below.

> @@ -205,7 +216,20 @@ static phys_addr_t iopte_to_paddr(arm_v7s_iopte
> pte, int lvl,
>  	else
>  		mask = ARM_V7S_LVL_MASK(lvl);
>  
> -	return pte & mask;
> +	paddr = pte & mask;
> +	if (IS_ENABLED(CONFIG_PHYS_ADDR_T_64BIT) &&
> +	    (cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_EXT)) {
> +		/*
> +		 * Workaround for MTK 4GB Mode:
> +		 * Add BIT32 only when PA < 0x4000_0000.
> +		 */
> +		if ((cfg->oas == 33 && paddr < 0x40000000UL) ||
> +		    (cfg->oas > 33 && (pte & ARM_V7S_ATTR_MTK_PA_BIT32)))
> +			paddr |= BIT_ULL(32);
> +		if (pte & ARM_V7S_ATTR_MTK_PA_BIT33)
> +			paddr |= BIT_ULL(33);
> +	}
> +	return paddr;
>  }
>  
>  static arm_v7s_iopte *iopte_deref(arm_v7s_iopte pte, int lvl,
> @@ -326,9 +350,6 @@ static arm_v7s_iopte arm_v7s_prot_to_pte(int prot,
> int lvl,
>  	if (lvl == 1 && (cfg->quirks & IO_PGTABLE_QUIRK_ARM_NS))
>  		pte |= ARM_V7S_ATTR_NS_SECTION;
>  
> -	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_EXT)
> -		pte |= ARM_V7S_ATTR_MTK_4GB;
> -
>  	return pte;
>  }
>  
> @@ -742,7 +763,9 @@ static struct io_pgtable
> *arm_v7s_alloc_pgtable(struct io_pgtable_cfg *cfg,
>  {
>  	struct arm_v7s_io_pgtable *data;
>  
> -	if (cfg->ias > ARM_V7S_ADDR_BITS || cfg->oas > ARM_V7S_ADDR_BITS)
> +	if (cfg->ias > ARM_V7S_ADDR_BITS ||
> +	    (cfg->oas > ARM_V7S_ADDR_BITS &&
> +	     !(cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_EXT)))
>  		return NULL;

I think you can rework this to do something like:

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

so that we clamp the oas when phys_addr_t is 32-bit for you. That should
allow you to remove lots of the checking from iopte_to_paddr() too if you
check against oas in the map() function.

Does that make sense?

Will
