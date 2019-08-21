Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFCCDC3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 16:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8365D2332A
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 16:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566405361;
	bh=523UKRpEYgVnK4n6qoJT/UA2T1eyXvRGlZiSMko8S2I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OGt3TYrFhksDeodxMZSwp2G78KW1A0H4QnOyk+kjWafODtRDv4TUlO/OXrESXiWwR
	 2nsRVBeLxaOzc7iFKOkcrFHzJUp7+xnguGpS8E+WQZH5MgzK+N6dt0PXibQB0oETk5
	 zDYPdzjaUearRVIU4aGRQ5Q8sAYaWs38Pg8u4lHg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729524AbfHUQgA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 12:36:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:55792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729367AbfHUQgA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 12:36:00 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3D2D216F4;
        Wed, 21 Aug 2019 16:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566405360;
        bh=523UKRpEYgVnK4n6qoJT/UA2T1eyXvRGlZiSMko8S2I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=THQSoGVckn9loJO2YK6n0hW8Zr+qYViNc6L7hieM8yM6BUPTRpUCVjjlXy5iJ/abQ
         /8sxz9km+kjRuL5G/1sDfv+VWpOPpsABw8SxC1NN+XfRv9hH04pSbCObu9foGya4yP
         3u+NJzArrkquuRd6l3iLVqK/x7qHKusaX9b/v5io=
Date:   Wed, 21 Aug 2019 17:35:54 +0100
From:   Will Deacon <will@kernel.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
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
Subject: Re: [PATCH v10 09/23] iommu/io-pgtable-arm-v7s: Extend to support
 PA[33:32] for MediaTek
Message-ID: <20190821163553.ymlk5fcgd6ntnpss@willie-the-truck>
References: <1566395606-7975-1-git-send-email-yong.wu@mediatek.com>
 <1566395606-7975-10-git-send-email-yong.wu@mediatek.com>
 <20190821152448.qmoqjh5zznfpdi6n@willie-the-truck>
 <22a79977-5074-7af1-97b8-8a3e549b23c1@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22a79977-5074-7af1-97b8-8a3e549b23c1@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 04:34:27PM +0100, Robin Murphy wrote:
> On 21/08/2019 16:24, Will Deacon wrote:
> > On Wed, Aug 21, 2019 at 09:53:12PM +0800, Yong Wu wrote:
> > > MediaTek extend the arm v7s descriptor to support up to 34 bits PA where
> > > the bit32 and bit33 are encoded in the bit9 and bit4 of the PTE
> > > respectively. Meanwhile the iova still is 32bits.
> > > 
> > > Regarding whether the pagetable address could be over 4GB, the mt8183
> > > support it while the previous mt8173 don't, thus keep it as is.
> > > 
> > > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > > ---
> > >   drivers/iommu/io-pgtable-arm-v7s.c | 32 +++++++++++++++++++++++++-------
> > >   include/linux/io-pgtable.h         |  7 +++----
> > >   2 files changed, 28 insertions(+), 11 deletions(-)
> > 
> > [...]
> > 
> > > @@ -731,7 +747,9 @@ static struct io_pgtable *arm_v7s_alloc_pgtable(struct io_pgtable_cfg *cfg,
> > >   {
> > >   	struct arm_v7s_io_pgtable *data;
> > > -	if (cfg->ias > ARM_V7S_ADDR_BITS || cfg->oas > ARM_V7S_ADDR_BITS)
> > > +	if (cfg->ias > ARM_V7S_ADDR_BITS ||
> > > +	    (cfg->oas > ARM_V7S_ADDR_BITS &&
> > > +	     !(cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_EXT)))
> > 
> > Please can you instead change arm_v7s_alloc_pgtable() so that it allows an
> > ias of up to 34 when the IO_PGTABLE_QUIRK_ARM_MTK_EXT is set?
> 
> You mean oas, right? I believe the hardware *does* actually support a 32-bit
> ias as well, but we shouldn't pretend to support that while
> __arm_v7s_alloc_table() still only knows how to allocate normal-sized
> tables.

Sorry, yes, oas.

Will
