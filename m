Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 116D2CA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 21:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D305A2087F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 21:54:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MlVKvzEK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729206AbfJaVyT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 17:54:19 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36060 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729018AbfJaVyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 17:54:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=9BM+3AEpbkEyaVJFAB613unJ+Y8pJb9+MdJLqEvari0=; b=MlVKvzEKlh2LW4/LLwZY1S17tB
        kWdgcYiidURkGdNnmILSAk8nMTOCppIja8R9N9kBeHC/MU00qGqYRasi2vIsf+mrXaOfiZIQM9LoS
        QLffyK+RnmOGlboEn00rUU86Yc7Rgt6mMEMTkXp1xtKrFSPGb8GBKKuSk6ozPl1jArExSwPOmpMdD
        6hyNU6Nf7rBggPqPtZd20sOd3VfNCp7dRNy5G8MQLtHtjJeq6x1ldPPIFi28O1RZpo/jSF8RyCT8U
        5vsowCrj5dpLv97agvRZG6ah0p7YLYu/c7EvZg5iM9ATSNZev5ylA9FFnT6nWb/yueo91YzatjXY6
        MMuWgk0g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iQIOV-0007AR-Uj; Thu, 31 Oct 2019 21:54:15 +0000
Date:   Thu, 31 Oct 2019 14:54:15 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Thomas =?iso-8859-1?Q?Hellstr=F6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: dma coherent memory user-space maps
Message-ID: <20191031215415.GA9809@infradead.org>
References: <b811f66d-2353-23c6-c9fa-e279cdb0f832@shipmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b811f66d-2353-23c6-c9fa-e279cdb0f832@shipmail.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

sorry for the delay.  I've been travelling way to much laterly and had
a hard time keeping up.

On Tue, Oct 08, 2019 at 02:34:17PM +0200, Thomas Hellström (VMware) wrote:
> /* Obtain struct dma_pfn pointers from a dma coherent allocation */
> int dma_get_dpfns(struct device *dev, void *cpu_addr, dma_addr_t dma_addr,
>           pgoff_t offset, pgoff_t num, dma_pfn_t dpfns[]);
> 
> I figure, for most if not all architectures we could use an ordinary pfn as
> dma_pfn_t, but the dma layer would still have control over how those pfns
> are obtained and how they are used in the kernel's mapping APIs.
> 
> If so, I could start looking at this, time permitting,  for the cases where
> the pfn can be obtained from the kernel address or from
> arch_dma_coherent_to_pfn(), and also the needed work to have a tailored
> vmap_pfn().

I'm not sure that infrastructure is all that helpful unfortunately, even
if it ended up working.  The problem with the 'coherent' DMA mappings
is that we they have a few different backends.  For architectures that
are DMA coherent everything is easy and we use the normal page
allocator, and your above is trivially doable as wrappers around the
existing functionality.  Other remap ptes to be uncached, either
in-place or using vmap, and the remaining ones use weird special
allocators for which almost everything we can mormally do in the VM
will fail.

I promised Christian an uncached DMA allocator a while ago, and still
haven't finished that either unfortunately.  But based on looking at
the x86 pageattr code I'm now firmly down the road of using the
set_memory_* helpers that change the pte attributes in place, as
everything else can't actually work on x86 which doesn't allow
aliasing of PTEs with different caching attributes.  The arm64 folks
also would prefer in-place remapping even if they don't support it
yet, and that is something the i915 code already does in a somewhat
hacky way, and something the msm drm driver wants.  So I decided to
come up with an API that gives back 'coherent' pages on the
architectures that support it and otherwise just fail.

Do you care about architectures other than x86 and arm64?  If not I'll
hopefully have something for you soon.
