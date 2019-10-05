Return-Path: <SRS0=6Pxm=X6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C130C4740A
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 08:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00788222C0
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 08:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727651AbfJEI2A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 04:28:00 -0400
Received: from verein.lst.de ([213.95.11.211]:49291 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725927AbfJEI2A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 04:28:00 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id A75D7227A81; Sat,  5 Oct 2019 10:27:54 +0200 (CEST)
Date:   Sat, 5 Oct 2019 10:27:54 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Kees Cook <keescook@chromium.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Laura Abbott <labbott@redhat.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <swboyd@chromium.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Semmle Security Reports <security-reports@semmle.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma-mapping: Lift address space checks out of debug
 code
Message-ID: <20191005082754.GB12308@lst.de>
References: <201910021341.7819A660@keescook> <7a5dc7aa-66ec-0249-e73f-285b8807cb73@arm.com> <201910021643.75E856C@keescook> <fc9fffc8-3cff-4a6f-d426-4a4cc895ebb1@arm.com> <201910031438.A67C40B97C@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201910031438.A67C40B97C@keescook>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2019 at 02:38:43PM -0700, Kees Cook wrote:
> > I think it would be reasonable to pull the is_vmalloc_addr() check inline,
> > as that probably covers 90+% of badness (especially given vmapped stacks),
> > and as you say should be reliably cheap everywhere. Callers are certainly
> > expected to use dma_mapping_error() and handle failure, so refusing to do a
> > bogus mapping operation should be OK API-wise - ultimately if a driver goes
> > ahead and uses DMA_MAPPING_ERROR as an address anyway, that's not likely to
> > be any *more* catastrophic than if it did the same with whatever nonsense
> > virt_to_phys() of a vmalloc address had returned.
> 
> What do you think about the object_is_on_stack() check? That does a
> dereference through "current" to find the stack bounds...

I can be persuaded about just the vmalloc check as people tend to get
a lot of vmalloc alloctions without knowing these days.  But what I'd
really like to see is a new config option that enables relatively
cheap checks without the full dma debugging infrastructure.  That way
you can turn those on at least for all development builds, and can
easily benchmark having the checks vs not.
