Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E280CC7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 14:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B872A21848
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 14:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563373429;
	bh=GlgM6Flb7U5FvLBrim3MfffxSY9Cf03irtwOwK4KS08=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Jlrm5lAUjhiMIllWsd4ZQPrUUZDGKu4F7YoccBTMW6hAKAnXVjHOi7bWiAqE5soLh
	 AnJJrTTJjbn1l5mLgVtnD0DNCY57r4WJSg8uFYV3NFsl0aneLmylhVoYWGUVSr5m8w
	 iv+2YcU8xL7IcRfwcEtdvH9GxS2+WhnqkrQ3L6cI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727465AbfGQOXs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 10:23:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:50898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726452AbfGQOXs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 10:23:48 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8568E21743;
        Wed, 17 Jul 2019 14:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563373426;
        bh=GlgM6Flb7U5FvLBrim3MfffxSY9Cf03irtwOwK4KS08=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nEGGSoDItNpMBm7fRxdhPxrr5B8dn0+K1xshnV+ZF9QLHM9kqfyNzbDovXpkWgi6k
         L1J4PtnDOWbmj7aboaApmgn03y0Svo7KOZS+F8Ko1wo7KUVWvLev86ahSBecZnjw41
         6fwNTWZl/I9y305D5xAlquohPhYf8EeD99abhAPI=
Date:   Wed, 17 Jul 2019 15:23:40 +0100
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
Message-ID: <20190717142339.wltamw6wktwixqqn@willie-the-truck>
References: <1561774167-24141-1-git-send-email-yong.wu@mediatek.com>
 <1561774167-24141-8-git-send-email-yong.wu@mediatek.com>
 <20190710143649.w5dplhzdpi3bxp7e@willie-the-truck>
 <1562846036.31342.10.camel@mhfsdcap03>
 <20190711123129.da4rg35b54u4svfw@willie-the-truck>
 <1563079280.31342.22.camel@mhfsdcap03>
 <20190715095156.xczfkbm6zpjueq32@willie-the-truck>
 <1563367459.31342.34.camel@mhfsdcap03>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1563367459.31342.34.camel@mhfsdcap03>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2019 at 08:44:19PM +0800, Yong Wu wrote:
> On Mon, 2019-07-15 at 10:51 +0100, Will Deacon wrote:
> > On Sun, Jul 14, 2019 at 12:41:20PM +0800, Yong Wu wrote:
> > > @@ -742,7 +763,9 @@ static struct io_pgtable
> > > *arm_v7s_alloc_pgtable(struct io_pgtable_cfg *cfg,
> > >  {
> > >  	struct arm_v7s_io_pgtable *data;
> > >  
> > > -	if (cfg->ias > ARM_V7S_ADDR_BITS || cfg->oas > ARM_V7S_ADDR_BITS)
> > > +	if (cfg->ias > ARM_V7S_ADDR_BITS ||
> > > +	    (cfg->oas > ARM_V7S_ADDR_BITS &&
> > > +	     !(cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_EXT)))
> > >  		return NULL;
> > 
> > I think you can rework this to do something like:
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
> > 
> > so that we clamp the oas when phys_addr_t is 32-bit for you. That should
> > allow you to remove lots of the checking from iopte_to_paddr() too if you
> > check against oas in the map() function.
> > 
> > Does that make sense?
> 
> Of course I'm ok for this. I'm only afraid that this function has
> already 3 checking "if (x) return NULL", Here we add a new one and so
> many lines... Maybe the user should guarantee the right value of oas.
> How about move it into mtk_iommu.c?
> 
> About the checking of iopte_to_paddr, I can not remove them. I know it
> may be a bit special and not readable. Hmm, I guess I should use a MACRO
> instead of the hard code 33 for the special 4GB mode case.

Why can't you just do something like:

	if (!(cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_EXT))
		return paddr;

	if (pte & ARM_V7S_ATTR_MTK_PA_BIT33)
		paddr |= BIT_ULL(33);

	if (pte & ARM_V&S_ATTR_MTK_PA_BIT32)
		paddr |= BIT_ULL(32);

	return paddr;

The diff I sent previously sanitises the oas at init time, and then you
can just enforce it in map().

Will
