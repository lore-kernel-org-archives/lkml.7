Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 697CBC7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 07:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D06822ADC
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 07:00:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fLHGrJOe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbfGXHAA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 03:00:00 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43726 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbfGXHAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 03:00:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Iel7fa10X1Lb5ApMGEcSQp7sPKev2RbX5/u2NRwHx3k=; b=fLHGrJOeI/ZhfIHGvbawf55je
        gnfcwpRzGzsv0MaMfv0cVZjR2c9d5HXHji9TyC4y8HRwap9A5mSIlX1+k7HOuSPhyEr2SiCw+9XsV
        j/J3ZzHky7ib7eOz49PEitBP2ewRzzyXnuIWGE9NQoNeXPCSzJeAJNJNTL3xpv9ze4OKH52hq8czI
        CCVXJQEECcbRSqTmAIbGEZB90M7z8/foA0MMj9iMZAPrrlw0UtesKbeP7w/SL4hQ8cNJ96M9HTzmO
        tZI7dDsyK/D7H0ZVbQLPSA1Jx+d1fQqLiasVoXgyxhmayk67StgtJqhewQIW9aKtF2NSkKRSxllqD
        +p2ugcoTg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hqBFn-00075Q-L3; Wed, 24 Jul 2019 06:59:59 +0000
Date:   Tue, 23 Jul 2019 23:59:59 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Pratik Patel <pratikp@codeaurora.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Vincent Donnefort <Vincent.Donnefort@arm.com>,
        Sudipto Paul <Sudipto.Paul@arm.com>,
        "Andrew F . Davis" <afd@ti.com>,
        Xu YiPing <xuyiping@hisilicon.com>,
        "Chenfeng (puck)" <puck.chen@hisilicon.com>,
        butao <butao@hisilicon.com>,
        "Xiaqing (A)" <saberlily.xia@hisilicon.com>,
        Yudongbin <yudongbin@hisilicon.com>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        dri-devel <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v6 4/5] dma-buf: heaps: Add CMA heap to dmabuf heaps
Message-ID: <20190724065958.GC16225@infradead.org>
References: <20190624194908.121273-1-john.stultz@linaro.org>
 <20190624194908.121273-5-john.stultz@linaro.org>
 <20190718100840.GB19666@infradead.org>
 <CALAqxLWLx_tHVjZqrSNWfQ_M2RGGqh4qth3hi9GGRdSPov-gcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALAqxLWLx_tHVjZqrSNWfQ_M2RGGqh4qth3hi9GGRdSPov-gcw@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 10:04:06PM -0700, John Stultz wrote:
> Apologies, I'm not sure I'm understanding your suggestion here.
> dma_alloc_contiguous() does have some interesting optimizations
> (avoiding allocating single page from cma), though its focus on
> default area vs specific device area doesn't quite match up the usage
> model for dma heaps.  Instead of allocating memory for a single
> device, we want to be able to allow userland, for a given usage mode,
> to be able to allocate a dmabuf from a specific heap of memory which
> will satisfy the usage mode for that buffer pipeline (across multiple
> devices).
> 
> Now, indeed, the system and cma heaps in this patchset are a bit
> simple/trivial (though useful with my devices that require contiguous
> buffers for the display driver), but more complex ION heaps have
> traditionally stayed out of tree in vendor code, in many cases making
> incompatible tweaks to the ION core dmabuf exporter logic.

So what would the more complicated heaps be?

> That's why
> dmabuf heaps is trying to destage ION in a way that allows heaps to
> implement their exporter logic themselves, so we can start pulling
> those more complicated heaps out of their vendor hidey-holes and get
> some proper upstream review.
> 
> But I suspect I just am confused as to what your suggesting. Maybe
> could you expand a bit? Apologies for being a bit dense.

My suggestion is to merge the system and CMA heaps.  CMA (at least
the system-wide CMA area) is really just an optimization to get
large contigous regions more easily.  We should make use of it as
transparent as possible, just like we do in the DMA code.
