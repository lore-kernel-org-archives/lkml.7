Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D74C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 10:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 142E424683
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 10:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576837345;
	bh=7kD4WZpoUBWtlhJGMRIhfgsM4IUYXBLNc4dysvjzAlc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uODSF7a6EvrqEaWSUnMFqOvoIAtSZtSlwD962b7JAyNuEtIBWfIpu3BJFrMJBFRGq
	 /OP7qUiYVkhjzYgk7s/xjZvU+o6gxZVxGbGJaJUs6RAiHFr3dw3XJee/LsYToevMlC
	 U1st1fd9itcu2qoV0GH6ssT+6vdkOkBg3pM+54pI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbfLTKWY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 05:22:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:54118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727184AbfLTKWX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 05:22:23 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ECF7624679;
        Fri, 20 Dec 2019 10:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576837341;
        bh=7kD4WZpoUBWtlhJGMRIhfgsM4IUYXBLNc4dysvjzAlc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X6EMH0O7CJd/JUROxBWz5ymE3x/5G2Zi2sawHAsdgjHX35u+HPFo20A9EzVcW154W
         j6WndDIlMlBqBf7HVbPTgkEsosVBLfuYVqJG1Ctj0MYn6pSCLkp5m2Mz7WnOnzrHY0
         DvfwazLMXiI+1Ab80EW3JE1m6zuV6K9962BlfgAw=
Date:   Fri, 20 Dec 2019 11:22:18 +0100
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
Message-ID: <20191220102218.GA2259862@kroah.com>
References: <74ae22cd-08c1-d846-3e1d-cbc38db87442@free.fr>
 <bf020a68-00fd-2bb7-c3b6-00f5befa293a@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf020a68-00fd-2bb7-c3b6-00f5befa293a@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 20, 2019 at 11:19:27AM +0100, Marc Gonzalez wrote:
> On 17/12/2019 16:30, Marc Gonzalez wrote:
> 
> > Commit a66d972465d15 ("devres: Align data[] to ARCH_KMALLOC_MINALIGN")
> > increased the alignment of devres.data unconditionally.
> > 
> > Some platforms have very strict alignment requirements for DMA-safe
> > addresses, e.g. 128 bytes on arm64. There, struct devres amounts to:
> > 	3 pointers + pad_to_128 + data + pad_to_256
> > i.e. ~220 bytes of padding.
> > 
> > Let's enforce the alignment only for devm_kmalloc().
> > 
> > Suggested-by: Robin Murphy <robin.murphy@arm.com>
> > Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
> > ---
> > I had not been aware that dynamic allocation granularity on arm64 was
> > 128 bytes. This means there's a lot of waste on small allocations.
> > I suppose there's no easy solution, though.
> > ---
> >  drivers/base/devres.c | 23 +++++++++++++----------
> >  1 file changed, 13 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/base/devres.c b/drivers/base/devres.c
> > index 0bbb328bd17f..bf39188613d9 100644
> > --- a/drivers/base/devres.c
> > +++ b/drivers/base/devres.c
> > @@ -26,14 +26,7 @@ struct devres_node {
> >  
> >  struct devres {
> >  	struct devres_node		node;
> > -	/*
> > -	 * Some archs want to perform DMA into kmalloc caches
> > -	 * and need a guaranteed alignment larger than
> > -	 * the alignment of a 64-bit integer.
> > -	 * Thus we use ARCH_KMALLOC_MINALIGN here and get exactly the same
> > -	 * buffer alignment as if it was allocated by plain kmalloc().
> > -	 */
> > -	u8 __aligned(ARCH_KMALLOC_MINALIGN) data[];
> > +	u8				data[];
> >  };
> >  
> >  struct devres_group {
> > @@ -789,9 +782,16 @@ static void devm_kmalloc_release(struct device *dev, void *res)
> >  	/* noop */
> >  }
> >  
> > +#define DEVM_KMALLOC_PADDING_SIZE \
> > +	(ARCH_KMALLOC_MINALIGN - sizeof(struct devres) % ARCH_KMALLOC_MINALIGN)
> > +
> >  static int devm_kmalloc_match(struct device *dev, void *res, void *data)
> >  {
> > -	return res == data;
> > +	/*
> > +	 * 'res' is dr->data (not DMA-safe)
> > +	 * 'data' is the hand-aligned address from devm_kmalloc
> > +	 */
> > +	return res + DEVM_KMALLOC_PADDING_SIZE == data;
> >  }
> >  
> >  /**
> > @@ -811,6 +811,9 @@ void * devm_kmalloc(struct device *dev, size_t size, gfp_t gfp)
> >  {
> >  	struct devres *dr;
> >  
> > +	/* Add enough padding to provide a DMA-safe address */
> > +	size += DEVM_KMALLOC_PADDING_SIZE;
> > +
> >  	/* use raw alloc_dr for kmalloc caller tracing */
> >  	dr = alloc_dr(devm_kmalloc_release, size, gfp, dev_to_node(dev));
> >  	if (unlikely(!dr))
> > @@ -822,7 +825,7 @@ void * devm_kmalloc(struct device *dev, size_t size, gfp_t gfp)
> >  	 */
> >  	set_node_dbginfo(&dr->node, "devm_kzalloc_release", size);
> >  	devres_add(dev, dr->data);
> > -	return dr->data;
> > +	return dr->data + DEVM_KMALLOC_PADDING_SIZE;
> >  }
> >  EXPORT_SYMBOL_GPL(devm_kmalloc);
> 
> Would anyone else have any suggestions, comments, insights, recommendations,
> improvements, guidance, or wisdom? :-)
> 
> I keep thinking about the memory waste caused by the strict alignment requirement
> on arm64. Is there a way to inspect how much memory has been requested vs how much
> has been allocated? (Turning on SLAB DEBUG perhaps?)
> 
> Couldn't there be a kmalloc flag saying "this alloc will not require strict
> alignment, so just give me something 8-byte aligned" ?

Or you can not use the devm interface for lots of tiny allocations :)

thanks,

greg k-h
