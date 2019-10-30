Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7ABBC47E49
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 19:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B6C120650
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 19:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572463605;
	bh=oZdsRq9DtlyqOY59UsuqYnw0hffYd6itQ5//OM9N0yo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kEvHo+CMhK1TAdAycdG7NHbfnHMBXnqcvhOShJaAxLtRd3Azt9+ZsZMv8zpWie40m
	 xfqwuFVSLpgrK0LVczAPh9DyJ9w4PzK91qfYB34hRDCrgmWLsbiUFuedtvSpp9QVA3
	 MexLqnzV09C4mWtxFbEyl5uHF16LrJdkCFubQeAk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbfJ3T0o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 15:26:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:53904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726769AbfJ3T0n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 15:26:43 -0400
Received: from localhost (unknown [84.241.198.167])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5714820717;
        Wed, 30 Oct 2019 19:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572463603;
        bh=oZdsRq9DtlyqOY59UsuqYnw0hffYd6itQ5//OM9N0yo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EQphk4FxmCMxFxHG/5TYKSPi7YAgBs5IqWJDk/FAOpM+ZRPDtLpBZImpp4DiuE+Wb
         tzFvBrKBH0SaoI+5McjbOfZ6aDH8VO7HN+u3LOdtTMoGaywUTGTHn+o64hcAY6+Gdi
         ++vTdUeKWYBxIh31wAgLOz3E1h5el+0NtcEWvm1A=
Date:   Wed, 30 Oct 2019 20:26:40 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Kees Cook <keescook@chromium.org>,
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
Message-ID: <20191030192640.GC709410@kroah.com>
References: <20191029213423.28949-1-keescook@chromium.org>
 <20191029213423.28949-2-keescook@chromium.org>
 <20191030091849.GA637042@kroah.com>
 <20191030180921.GB19366@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191030180921.GB19366@lst.de>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2019 at 07:09:21PM +0100, Christoph Hellwig wrote:
> On Wed, Oct 30, 2019 at 10:18:49AM +0100, Greg Kroah-Hartman wrote:
> > On Tue, Oct 29, 2019 at 02:34:22PM -0700, Kees Cook wrote:
> > > As we've seen from USB and other areas[1], we need to always do runtime
> > > checks for DMA operating on memory regions that might be remapped. This
> > > adds vmap checks (similar to those already in USB but missing in other
> > > places) into dma_map_single() so all callers benefit from the checking.
> > > 
> > > [1] https://git.kernel.org/linus/3840c5b78803b2b6cc1ff820100a74a092c40cbb
> > > 
> > > Suggested-by: Laura Abbott <labbott@redhat.com>
> > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > > ---
> > >  include/linux/dma-mapping.h | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > > 
> > > diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> > > index 4a1c4fca475a..54de3c496407 100644
> > > --- a/include/linux/dma-mapping.h
> > > +++ b/include/linux/dma-mapping.h
> > > @@ -583,6 +583,12 @@ static inline unsigned long dma_get_merge_boundary(struct device *dev)
> > >  static inline dma_addr_t dma_map_single_attrs(struct device *dev, void *ptr,
> > >  		size_t size, enum dma_data_direction dir, unsigned long attrs)
> > >  {
> > > +	/* DMA must never operate on areas that might be remapped. */
> > > +	if (dev_WARN_ONCE(dev, is_vmalloc_addr(ptr),
> > > +			  "wanted %zu bytes mapped in vmalloc\n", size)) {
> > > +		return DMA_MAPPING_ERROR;
> > > +	}
> > 
> > That's a very odd error string, I know if I saw it for the first time, I
> > would have no idea what it meant.  The USB message at least gives you a
> > bit more context as to what went wrong and how to fix it.
> > 
> > How about something like "Memory is not DMA capabable, please fix the
> > allocation of it to be correct", or "non-dma-able memory was attempted
> > to be mapped, but this is impossible to to" or something else.
> 
> I've fixed the message to "rejecting DMA map of vmalloc memory" and
> applied the patch.

Looks good!  You can apply patch 2/2 as well if you want to take that
through your tree too.

thanks,

greg k-h
