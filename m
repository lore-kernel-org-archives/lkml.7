Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB00CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 18:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD90C2087E
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 18:09:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbfJ3SJZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 14:09:25 -0400
Received: from verein.lst.de ([213.95.11.211]:47070 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726259AbfJ3SJZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 14:09:25 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id A18E468B05; Wed, 30 Oct 2019 19:09:21 +0100 (CET)
Date:   Wed, 30 Oct 2019 19:09:21 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>, Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <swboyd@chromium.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Semmle Security Reports <security-reports@semmle.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dma-mapping: Add vmap checks to dma_map_single()
Message-ID: <20191030180921.GB19366@lst.de>
References: <20191029213423.28949-1-keescook@chromium.org> <20191029213423.28949-2-keescook@chromium.org> <20191030091849.GA637042@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191030091849.GA637042@kroah.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2019 at 10:18:49AM +0100, Greg Kroah-Hartman wrote:
> On Tue, Oct 29, 2019 at 02:34:22PM -0700, Kees Cook wrote:
> > As we've seen from USB and other areas[1], we need to always do runtime
> > checks for DMA operating on memory regions that might be remapped. This
> > adds vmap checks (similar to those already in USB but missing in other
> > places) into dma_map_single() so all callers benefit from the checking.
> > 
> > [1] https://git.kernel.org/linus/3840c5b78803b2b6cc1ff820100a74a092c40cbb
> > 
> > Suggested-by: Laura Abbott <labbott@redhat.com>
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  include/linux/dma-mapping.h | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> > index 4a1c4fca475a..54de3c496407 100644
> > --- a/include/linux/dma-mapping.h
> > +++ b/include/linux/dma-mapping.h
> > @@ -583,6 +583,12 @@ static inline unsigned long dma_get_merge_boundary(struct device *dev)
> >  static inline dma_addr_t dma_map_single_attrs(struct device *dev, void *ptr,
> >  		size_t size, enum dma_data_direction dir, unsigned long attrs)
> >  {
> > +	/* DMA must never operate on areas that might be remapped. */
> > +	if (dev_WARN_ONCE(dev, is_vmalloc_addr(ptr),
> > +			  "wanted %zu bytes mapped in vmalloc\n", size)) {
> > +		return DMA_MAPPING_ERROR;
> > +	}
> 
> That's a very odd error string, I know if I saw it for the first time, I
> would have no idea what it meant.  The USB message at least gives you a
> bit more context as to what went wrong and how to fix it.
> 
> How about something like "Memory is not DMA capabable, please fix the
> allocation of it to be correct", or "non-dma-able memory was attempted
> to be mapped, but this is impossible to to" or something else.

I've fixed the message to "rejecting DMA map of vmalloc memory" and
applied the patch.
