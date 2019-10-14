Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B49C4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 21:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B31E21835
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 21:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571087499;
	bh=JgFZzVhxDxKCkbGmPDJ8Nrc3QpdnihzJLD4tr532a8U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RTz4HfKcpN+9JTysnDiRj9HDbyhebKCmcF2ahVflP8OR6/vQ0Gcd4K/wjemHiu2BY
	 JQJKbAtd+G1Nen4NyCqX9TEFC5Aen0nBmJSc04Kt/7tqpTxqSvXTl7OgrOZz7Aw4jd
	 0jQc2nkJHstqaH0EH3gMrYmDLFzFRsDckauoUNG8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732440AbfJNVLW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 17:11:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:59526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726304AbfJNVLV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 17:11:21 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC78421835;
        Mon, 14 Oct 2019 21:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571087480;
        bh=JgFZzVhxDxKCkbGmPDJ8Nrc3QpdnihzJLD4tr532a8U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=msRqZ/oggpCbPZDM2Tpesp6lTEm+uQxjNWlJ242zMDjrXfeJ00daTlfKGBgKoFTkM
         A+H3h/i6o2FcH9H8FXOzYHLkBfp5gGPo1cuUY8sQHD6llRwnlv3FFRuTeiU2//dBnz
         5k8Yimuf7yQuul1dB+h/BgTF8xIG3JWeT6skUOxc=
Date:   Mon, 14 Oct 2019 22:11:14 +0100
From:   Will Deacon <will@kernel.org>
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will.deacon@arm.com>,
        Evan Green <evgreen@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Tomasz Figa <tfiga@google.com>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, youlin.pei@mediatek.com,
        Nicolas Boichat <drinkcat@chromium.org>, anan.sun@mediatek.com,
        cui.zhang@mediatek.com, chao.hao@mediatek.com
Subject: Re: [PATCH v2 3/4] iommu/mediatek: Use writel for TLB range
 invalidation
Message-ID: <20191014211113.jq5qwe5pfonyocr3@willie-the-truck>
References: <1570627143-29441-1-git-send-email-yong.wu@mediatek.com>
 <1570627143-29441-3-git-send-email-yong.wu@mediatek.com>
 <20191011162950.yg4o77mlaicacne5@willie-the-truck>
 <1570861427.19130.65.camel@mhfsdcap03>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1570861427.19130.65.camel@mhfsdcap03>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 12, 2019 at 02:23:47PM +0800, Yong Wu wrote:
> On Fri, 2019-10-11 at 17:29 +0100, Will Deacon wrote:
> > On Wed, Oct 09, 2019 at 09:19:02PM +0800, Yong Wu wrote:
> > > Use writel for the register F_MMU_INV_RANGE which is for triggering the
> > > HW work. We expect all the setting(iova_start/iova_end...) have already
> > > been finished before F_MMU_INV_RANGE.
> > > 
> > > Signed-off-by: Anan.Sun <anan.sun@mediatek.com>
> > > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > > ---
> > > This is a improvement rather than fixing a issue.
> > > ---
> > >  drivers/iommu/mtk_iommu.c | 3 +--
> > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> > > index 24a13a6..607f92c 100644
> > > --- a/drivers/iommu/mtk_iommu.c
> > > +++ b/drivers/iommu/mtk_iommu.c
> > > @@ -187,8 +187,7 @@ static void mtk_iommu_tlb_add_flush(unsigned long iova, size_t size,
> > >  		writel_relaxed(iova, data->base + REG_MMU_INVLD_START_A);
> > >  		writel_relaxed(iova + size - 1,
> > >  			       data->base + REG_MMU_INVLD_END_A);
> > > -		writel_relaxed(F_MMU_INV_RANGE,
> > > -			       data->base + REG_MMU_INVALIDATE);
> > > +		writel(F_MMU_INV_RANGE, data->base + REG_MMU_INVALIDATE);
> > 
> > I don't understand this change.
> > 
> > Why is it an "improvement" and which accesses are you ordering with the
> > writel?
> 
> The register(F_MMU_INV_RANGE) will trigger HW to begin flush range. HW
> expect the other register iova_start/end/flush_type always is ready
> before trigger. thus I'd like use writel to guarantee the previous
> register has been finished.

Given that these are all MMIO writes to the same device, then
writel_relaxed() should give you the ordering you need. If you look at
memory_barriers.txt, it says:

  | they [readX_relaxed() and writeX_relaxed()] are still guaranteed to
  | be ordered with respect to other accesses from the same CPU thread
  | to the same peripheral when operating on __iomem pointers mapped
  | with the default I/O attributes.

> I didn't see the writel_relaxed cause some error in practice, we only
> think writel is necessary here in theory. so call it "improvement".

Ok, but I don't think it's needed in this case.

Will
