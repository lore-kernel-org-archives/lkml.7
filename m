Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77430C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 06:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BA7A22BF3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 06:58:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aZBHL++K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbfGXG6P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 02:58:15 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41370 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfGXG6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 02:58:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3X59uoIHWkle5151095EWlIhQ1uYulWqiYohiJvGIW0=; b=aZBHL++KElV7HejBz79l9aZpK
        WBi0+MfJWwUOWKC+kfJMHuYt2drkRJJ/IVSu/9T4E34Mg9lLPBX656A/Dtj3Sb3d2VaaMAdhHlRNz
        uCZgBsyiE3rx+f3LDhHCsXrQjn4NxUPdWaJQpa1l0QDJV/9bVb1/S6/IgNpEz9LdnlEioxXympEEX
        HWogf3lxQev2KnAtWlALsqZ5fsJ5YR1HnVc6I8AVM7o3ayY/RVD7tKO1eDsoOrkmIin578HoeQQVo
        sBzga0ZoDchy/8z6hJ5B+oSLxQNIgzOBbjsfhXnWXDKb528plA3SxBuvJB2atPh2HgVzJDS27j+Kh
        CexYiLXfA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hqBE5-0006R9-MH; Wed, 24 Jul 2019 06:58:13 +0000
Date:   Tue, 23 Jul 2019 23:58:13 -0700
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
        dri-devel <dri-devel@lists.freedesktop.org>,
        Hridya Valsaraju <hridya@google.com>,
        Rob Clark <robdclark@gmail.com>
Subject: Re: [PATCH v6 2/5] dma-buf: heaps: Add heap helpers
Message-ID: <20190724065813.GB16225@infradead.org>
References: <20190624194908.121273-1-john.stultz@linaro.org>
 <20190624194908.121273-3-john.stultz@linaro.org>
 <20190718100654.GA19666@infradead.org>
 <CALAqxLX1s4mbitE-_1s1vFPJrbrCKqpyhYoFW0V6hMEqE=eKVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALAqxLX1s4mbitE-_1s1vFPJrbrCKqpyhYoFW0V6hMEqE=eKVw@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 09:09:25PM -0700, John Stultz wrote:
> On Thu, Jul 18, 2019 at 3:06 AM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > > +void INIT_HEAP_HELPER_BUFFER(struct heap_helper_buffer *buffer,
> > > +                          void (*free)(struct heap_helper_buffer *))
> >
> > Please use a lower case naming following the naming scheme for the
> > rest of the file.
> 
> Yes! Apologies as this was a hold-over from when the initialization
> function was an inline function in the style of
> INIT_WORK/INIT_LIST_HEAD. No longer appropriate that its a function.
> I'll change it.
> 
> > > +static void *dma_heap_map_kernel(struct heap_helper_buffer *buffer)
> > > +{
> > > +     void *vaddr;
> > > +
> > > +     vaddr = vmap(buffer->pages, buffer->pagecount, VM_MAP, PAGE_KERNEL);
> > > +     if (!vaddr)
> > > +             return ERR_PTR(-ENOMEM);
> > > +
> > > +     return vaddr;
> > > +}
> >
> > Unless I'm misreading the patches this is used for the same pages that
> > also might be dma mapped.  In this case you need to use
> > flush_kernel_vmap_range and invalidate_kernel_vmap_range in the right
> > places to ensure coherency between the vmap and device view.  Please
> > also document the buffer ownership, as this really can get complicated.
> 
> Forgive me I wasn't familiar with those calls, but this seems like it
> would apply to all dma-buf exporters if so, and I don't see any
> similar flush_kernel_vmap_range calls there (both functions are
> seemingly only used by xfs, md and bio).
> 
> We do have the dma_heap_dma_buf_begin_cpu_access()/dma_heap_dma_buf_end_cpu_access()
> hooks (see more on these below) which sync the buffers for each
> attachment (via dma_sync_sg_for_cpu/device), and are used around cpu
> access to the buffers. Are you suggesting the
> flush_kernel_vmap_range() call be added to those hooks or is the
> dma_sync_sg_for_* calls sufficient there?

dma_sync_sg_for_* only operates on the kernel direct mapping, that
is what you get from page_address/kmap* for the page.  But with vmap
your create another alias in kernel virtual space, which
dma_sync_sg_for_* can't know about.  Now for most CPUs caches are
indexed by physical addresses so this doesn't matter, but a significant
minority of CPUs (parisc, some arm, some mips) index by virtual address,
in which case we need non-empy flush_kernel_vmap_range and
invalidate_kernel_vmap_range helper to deal with that vmap alias.
