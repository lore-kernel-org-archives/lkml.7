Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24CE2C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 10:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBD7524679
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 10:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576837383;
	bh=oXJTDWjAVH/J7yvy36BCAHHmI3aXwzYFQcnv4ilprBo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=h+YqUyBrjyf85uUS+omMP94mblqo60LElVz7st08s37rVrBUTlybDbOZdDzH+wSrz
	 1mWx9tEaPuiL1/jPiN/YFK6MiOErGrVl0vIrUeZPbuLax6T9W5FpYpQdNioxz2CEpM
	 3mOHMGWwaA4n1U0GJK5Kl13LBD2ICQXaiOjfrSNk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbfLTKXC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 05:23:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:54304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727129AbfLTKXB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 05:23:01 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5128424679;
        Fri, 20 Dec 2019 10:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576837378;
        bh=oXJTDWjAVH/J7yvy36BCAHHmI3aXwzYFQcnv4ilprBo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kT6AJVQ6a4RxBqVBlw3D+/mPHEJfdKuIedv0DtMX832DCW9MpGs2YZXUCvJIxDk39
         K5MLGVE8JehAH5bXRrFeWLh+t3rYtgtyLSguJsPKsGXldXM/Ys32Yk5WZ2j5wQHZfe
         ikdLj6XlWcccherIiwm62t57C4eTsiFSN0oPKcvc=
Date:   Fri, 20 Dec 2019 11:22:56 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Tejun Heo <tj@kernel.org>, Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH v1] devres: align devres.data strictly only for
 devm_kmalloc()
Message-ID: <20191220102256.GB2259862@kroah.com>
References: <74ae22cd-08c1-d846-3e1d-cbc38db87442@free.fr>
 <bf020a68-00fd-2bb7-c3b6-00f5befa293a@free.fr>
 <20191220102218.GA2259862@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191220102218.GA2259862@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 20, 2019 at 11:22:18AM +0100, Greg Kroah-Hartman wrote:
> On Fri, Dec 20, 2019 at 11:19:27AM +0100, Marc Gonzalez wrote:
> > On 17/12/2019 16:30, Marc Gonzalez wrote:
> > 
> > > Commit a66d972465d15 ("devres: Align data[] to ARCH_KMALLOC_MINALIGN")
> > > increased the alignment of devres.data unconditionally.
> > > 
> > > Some platforms have very strict alignment requirements for DMA-safe
> > > addresses, e.g. 128 bytes on arm64. There, struct devres amounts to:
> > > 	3 pointers + pad_to_128 + data + pad_to_256
> > > i.e. ~220 bytes of padding.
> > > 
> > > Let's enforce the alignment only for devm_kmalloc().
> > > 
> > > Suggested-by: Robin Murphy <robin.murphy@arm.com>
> > > Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
> > > ---
> > > I had not been aware that dynamic allocation granularity on arm64 was
> > > 128 bytes. This means there's a lot of waste on small allocations.
> > > I suppose there's no easy solution, though.
> > > ---
> > >  drivers/base/devres.c | 23 +++++++++++++----------
> > >  1 file changed, 13 insertions(+), 10 deletions(-)
> > > 
> > > diff --git a/drivers/base/devres.c b/drivers/base/devres.c
> > > index 0bbb328bd17f..bf39188613d9 100644
> > > --- a/drivers/base/devres.c
> > > +++ b/drivers/base/devres.c
> > > @@ -26,14 +26,7 @@ struct devres_node {
> > >  
> > >  struct devres {
> > >  	struct devres_node		node;
> > > -	/*
> > > -	 * Some archs want to perform DMA into kmalloc caches
> > > -	 * and need a guaranteed alignment larger than
> > > -	 * the alignment of a 64-bit integer.
> > > -	 * Thus we use ARCH_KMALLOC_MINALIGN here and get exactly the same
> > > -	 * buffer alignment as if it was allocated by plain kmalloc().
> > > -	 */
> > > -	u8 __aligned(ARCH_KMALLOC_MINALIGN) data[];
> > > +	u8				data[];
> > >  };
> > >  
> > >  struct devres_group {
> > > @@ -789,9 +782,16 @@ static void devm_kmalloc_release(struct device *dev, void *res)
> > >  	/* noop */
> > >  }
> > >  
> > > +#define DEVM_KMALLOC_PADDING_SIZE \
> > > +	(ARCH_KMALLOC_MINALIGN - sizeof(struct devres) % ARCH_KMALLOC_MINALIGN)
> > > +
> > >  static int devm_kmalloc_match(struct device *dev, void *res, void *data)
> > >  {
> > > -	return res == data;
> > > +	/*
> > > +	 * 'res' is dr->data (not DMA-safe)
> > > +	 * 'data' is the hand-aligned address from devm_kmalloc
> > > +	 */
> > > +	return res + DEVM_KMALLOC_PADDING_SIZE == data;
> > >  }
> > >  
> > >  /**
> > > @@ -811,6 +811,9 @@ void * devm_kmalloc(struct device *dev, size_t size, gfp_t gfp)
> > >  {
> > >  	struct devres *dr;
> > >  
> > > +	/* Add enough padding to provide a DMA-safe address */
> > > +	size += DEVM_KMALLOC_PADDING_SIZE;
> > > +
> > >  	/* use raw alloc_dr for kmalloc caller tracing */
> > >  	dr = alloc_dr(devm_kmalloc_release, size, gfp, dev_to_node(dev));
> > >  	if (unlikely(!dr))
> > > @@ -822,7 +825,7 @@ void * devm_kmalloc(struct device *dev, size_t size, gfp_t gfp)
> > >  	 */
> > >  	set_node_dbginfo(&dr->node, "devm_kzalloc_release", size);
> > >  	devres_add(dev, dr->data);
> > > -	return dr->data;
> > > +	return dr->data + DEVM_KMALLOC_PADDING_SIZE;
> > >  }
> > >  EXPORT_SYMBOL_GPL(devm_kmalloc);
> > 
> > Would anyone else have any suggestions, comments, insights, recommendations,
> > improvements, guidance, or wisdom? :-)
> > 
> > I keep thinking about the memory waste caused by the strict alignment requirement
> > on arm64. Is there a way to inspect how much memory has been requested vs how much
> > has been allocated? (Turning on SLAB DEBUG perhaps?)
> > 
> > Couldn't there be a kmalloc flag saying "this alloc will not require strict
> > alignment, so just give me something 8-byte aligned" ?
> 
> Or you can not use the devm interface for lots of tiny allocations :)

Oh nevermind, "normal" kmalloc allocations are all aligned that way
anyway, so that's not going to solve anything, sorry.

greg k-h
