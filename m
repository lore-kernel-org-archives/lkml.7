Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF942ECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 18:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C1EC206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 18:47:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728429AbfJGSr5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 14:47:57 -0400
Received: from verein.lst.de ([213.95.11.211]:40176 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728079AbfJGSr4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 14:47:56 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6422568B20; Mon,  7 Oct 2019 20:47:54 +0200 (CEST)
Date:   Mon, 7 Oct 2019 20:47:54 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
Subject: Re: ehci-pci breakage with dma-mapping changes in 5.4-rc2
Message-ID: <20191007184754.GB31345@lst.de>
References: <20191007022454.GA5270@rani.riverdale.lan> <20191007073448.GA882@lst.de> <20191007175430.GA32537@rani.riverdale.lan> <20191007175528.GA21857@lst.de> <20191007175630.GA28861@infradead.org> <20191007175856.GA42018@rani.riverdale.lan> <20191007183206.GA13589@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191007183206.GA13589@rani.riverdale.lan>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2019 at 02:32:07PM -0400, Arvind Sankar wrote:
> On Mon, Oct 07, 2019 at 01:58:57PM -0400, Arvind Sankar wrote:
> > On Mon, Oct 07, 2019 at 10:56:30AM -0700, Christoph Hellwig wrote:
> > > On Mon, Oct 07, 2019 at 07:55:28PM +0200, Christoph Hellwig wrote:
> > > > On Mon, Oct 07, 2019 at 01:54:32PM -0400, Arvind Sankar wrote:
> > > > > It doesn't boot with the patch. Won't it go
> > > > > 	dma_get_required_mask
> > > > > 	-> intel_get_required_mask
> > > > > 	-> iommu_need_mapping
> > > > > 	-> dma_get_required_mask
> > > > > ?
> > > > > 
> > > > > Should the call to dma_get_required_mask in iommu_need_mapping be
> > > > > replaced with dma_direct_get_required_mask on top of your patch?
> > > > 
> > > > Yes, sorry.
> > > 
> > > Actually my patch already calls dma_direct_get_required_mask.
> > > How did you get the loop?
> > 
> > The function iommu_need_mapping (not changed by your patch) calls
> > dma_get_required_mask internally, to check whether the device's dma_mask
> > is big enough or not. That's the call I was asking whether it needs to
> > be changed.
> 
> Yeah the attached patch seems to fix it.

That looks fine to me:

Acked-by: Christoph Hellwig <hch@lst.de>
