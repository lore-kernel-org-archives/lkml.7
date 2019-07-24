Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E34FC7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 06:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0001722BF3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 06:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SRZc6fvQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbfGXGzd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 02:55:33 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41128 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfGXGzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 02:55:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=FeQ44avxjhNKGvclmL+IaW/brdwZd48AYHsy5z6HFTA=; b=SRZc6fvQkH2Cx6BKrVs1zG1pG
        HdVl1GhjX6GW6pHtPOfTP4qzncVkK2k3hGyRQTPK7uTqj4k/v8rlT1OWZCMUsTh+m03nEou75xUL6
        d4wm73OlcqIqyEn0gXCeqXht0OdExcVR+P9cg8w4yAxVZcAvS2A9wYUs056gY8LM0pQ69uGSnrvyx
        pdL4AQ/ltJ0Ud6+XTSN2QiBVljMoIq5n16UvtwAhwZS5ruZPx2kmSv0dfmyYsNon2mqUiZHp2h8V6
        xiQaZm9snI9m+RdBQ0bg9XTDmynrNCE4/ejLCnx309RG/et+4PZjYTHppyDiDhverokz5FMeIUSxv
        D2kKI3Owg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hqBBS-0006A4-Vh; Wed, 24 Jul 2019 06:55:31 +0000
Date:   Tue, 23 Jul 2019 23:55:30 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Rob Clark <robdclark@gmail.com>
Cc:     John Stultz <john.stultz@linaro.org>,
        Christoph Hellwig <hch@infradead.org>,
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
        dri-devel <dri-devel@lists.freedesktop.org>,
        Hridya Valsaraju <hridya@google.com>
Subject: Re: [PATCH v6 2/5] dma-buf: heaps: Add heap helpers
Message-ID: <20190724065530.GA16225@infradead.org>
References: <20190624194908.121273-1-john.stultz@linaro.org>
 <20190624194908.121273-3-john.stultz@linaro.org>
 <20190718100654.GA19666@infradead.org>
 <CALAqxLX1s4mbitE-_1s1vFPJrbrCKqpyhYoFW0V6hMEqE=eKVw@mail.gmail.com>
 <CAF6AEGuM1+pimGNhyKHbYR0BdH=hH+Sai0es8RjGHE9jKHjngw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF6AEGuM1+pimGNhyKHbYR0BdH=hH+Sai0es8RjGHE9jKHjngw@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 01:09:55PM -0700, Rob Clark wrote:
> On Mon, Jul 22, 2019 at 9:09 PM John Stultz <john.stultz@linaro.org> wrote:
> >
> > On Thu, Jul 18, 2019 at 3:06 AM Christoph Hellwig <hch@infradead.org> wrote:
> > >
> > > Is there any exlusion between mmap / vmap and the device accessing
> > > the data?  Without that you are going to run into a lot of coherency
> > > problems.
> 
> dma_fence is basically the way to handle exclusion between different
> device access (since device access tends to be asynchronous).  For
> device<->device access, each driver is expected to take care of any
> cache(s) that the device might have.  (Ie. device writing to buffer
> should flush it's caches if needed before signalling fence to let
> reading device know that it is safe to read, etc.)
> 
> _begin/end_cpu_access() is intended to be the exclusion for CPU access
> (which is synchronous)

What I mean is that we need a clear state machine (preferably including
ownership tracking ala dma-debug) where a piece of memory has one
owner at a time that can access it.  Only the owner can access is at
that time, and at any owner switch we need to flush/invalidate all
relevant caches.  And with memory that is vmaped and mapped to userspace
that can get really complicated.

The above sounds like you have some of that in place, but we'll really
need clear rules to make sure we don't have holes in the scheme.
