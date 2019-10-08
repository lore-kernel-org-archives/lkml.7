Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B5DBC10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 07:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B737206C2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 07:32:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730326AbfJHHcO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 03:32:14 -0400
Received: from verein.lst.de ([213.95.11.211]:44494 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730279AbfJHHcO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 03:32:14 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id C809A68B20; Tue,  8 Oct 2019 09:32:10 +0200 (CEST)
Date:   Tue, 8 Oct 2019 09:32:10 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Christoph Hellwig <hch@lst.de>,
        Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: ehci-pci breakage with dma-mapping changes in 5.4-rc2
Message-ID: <20191008073210.GB9452@lst.de>
References: <20191007022454.GA5270@rani.riverdale.lan> <20191007073448.GA882@lst.de> <20191007175430.GA32537@rani.riverdale.lan> <20191007175528.GA21857@lst.de> <20191007175630.GA28861@infradead.org> <20191007175856.GA42018@rani.riverdale.lan> <20191007183206.GA13589@rani.riverdale.lan> <20191007184754.GB31345@lst.de> <20191007221054.GA409402@rani.riverdale.lan> <20191007235401.GA608824@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191007235401.GA608824@rani.riverdale.lan>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2019 at 07:54:02PM -0400, Arvind Sankar wrote:
> > Do you want me to resend the patch as its own mail, or do you just take
> > it with a Tested-by: from me? If the former, I assume you're ok with me
> > adding your Signed-off-by?
> > 
> > Thanks
> 
> A question on the original change though -- what happens if a single
> device (or a single IOMMU domain really) does want >4G DMA address
> space? Was that not previously allowed either?

Your EHCI device actually supports the larger addressing.  Without an
IOMMU (or with accidentally enabled passthrough mode as in your report)
that will use bounce buffers for physical address that are too large.
With an iommu we can just remap, and by default those remap addresses
are under 32-bit just to make everyones life easier.

The dma_get_required_mask function is misnamed unfortunately, what it
really means is the optimal mask, that is one that avoids bounce
buffering or other complications.
