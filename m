Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6827DC04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 10:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 453B421743
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 10:29:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbfEUK3B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 06:29:01 -0400
Received: from verein.lst.de ([213.95.11.211]:59141 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726466AbfEUK26 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 06:28:58 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 7C5EB68AFE; Tue, 21 May 2019 12:28:35 +0200 (CEST)
Date:   Tue, 21 May 2019 12:28:35 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     laurentiu.tudor@nxp.com, hch@lst.de, stern@rowland.harvard.edu,
        linux-usb@vger.kernel.org, marex@denx.de, leoyang.li@nxp.com,
        linux-kernel@vger.kernel.org, robin.murphy@arm.com,
        noring@nocrew.org, JuergenUrban@gmx.de
Subject: Re: [PATCH v4 1/3] USB: use genalloc for USB HCs with local memory
Message-ID: <20190521102835.GA1973@lst.de>
References: <20190516114721.27694-1-laurentiu.tudor@nxp.com> <20190516114721.27694-2-laurentiu.tudor@nxp.com> <20190521081657.GA10639@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521081657.GA10639@kroah.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 10:16:57AM +0200, Greg KH wrote:
> > +	if (hcd->driver->flags & HCD_LOCAL_MEM)
> > +		return gen_pool_dma_alloc(hcd->localmem_pool, size, dma);
> 
> Does this patch now break things?  hcd->localmem_pool at this point in
> time is NULL, so this call will fail.  There's no chance for any host
> controller driver to actually set up this pool in this patch, so is
> bisection broken?
> 
> I think you fix this up in later patches, right?
> 
> And if so, why do we even need HCD_LOCAL_MEM anymore?  Can't we just
> test for the presence of hcd->localmem_pool in order to determine which
> allocation method to use?

True.  And that also sound like a good bisectability strategy:

 - first add hcd->localmem_pool and test for it
 - convert drivers over to it
 - remove HCD_LOCAL_MEM
