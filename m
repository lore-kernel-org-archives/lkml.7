Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B3EC282E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 037BF218FD
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:28:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730590AbfDXO2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:28:01 -0400
Received: from verein.lst.de ([213.95.11.211]:54173 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726272AbfDXO2A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:28:00 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id EC19267358; Wed, 24 Apr 2019 16:27:43 +0200 (CEST)
Date:   Wed, 24 Apr 2019 16:27:43 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>, Ian Abbott <abbotti@mev.co.uk>,
        Jiri Slaby <jslaby@suse.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org,
        "kernel-janitors@vger.kernel.org H Hartley Sweeten" 
        <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma-mapping: remove an unnecessary NULL check
Message-ID: <20190424142743.GC20974@lst.de>
References: <20190424142437.GA29490@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424142437.GA29490@mwanda>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 05:24:37PM +0300, Dan Carpenter wrote:
> We already dereferenced "dev" when we called get_dma_ops() so this NULL
> check is too late.  We're not supposed to pass NULL "dev" pointers to
> dma_alloc_attrs().

Thanks, applied to the dma-mapping for-next tree.

> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> There are still at least two drivers which do pass a NULL unfortunately.
> 
> drivers/staging/comedi/drivers/comedi_isadma.c:195 comedi_isadma_alloc() error: NULL dereference inside function 'dma_alloc_coherent()'
> drivers/staging/comedi/drivers/comedi_isadma.c:227 comedi_isadma_free() error: NULL dereference inside function 'dma_free_coherent()'

This is staging code.  Per official decree from Linus we can just
ignore it, and I tend to do so to keep my sanity.

> drivers/tty/synclink.c:3667 mgsl_alloc_buffer_list_memory() error: NULL dereference inside function 'dma_alloc_coherent()'
> drivers/tty/synclink.c:3738 mgsl_free_buffer_list_memory() error: NULL dereference inside function 'dma_free_coherent()'
> drivers/tty/synclink.c:3777 mgsl_alloc_frame_memory() error: NULL dereference inside function 'dma_alloc_coherent()'
> drivers/tty/synclink.c:3811 mgsl_free_frame_memory() error: NULL dereference inside function 'dma_free_coherent()'

The !PCI case there is dead since I removed PCI support a while ago.
Looks like it is still too convoluted for static checkers to notice that,
though.
