Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD1FEC04AAD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 17:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A098620656
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 17:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557249058;
	bh=t7oPL7+XtQXXNlhx6KWpb7a1UJh20zGUTTFFX28Ujv8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zSqHMjGQFaH/aZD9JpOV+QgCzMb7N/LiDjta2JTVxXI8K3LkT9ngfu1KkEzAjS78w
	 R59hzetBJwH2kexgXVkmQctTfD4+JCy2IoFtzKFPhxT+RxJxNuKW1qD2FfQkm77Lg3
	 +5j5d/MyUrqKQJ2UfXjYEABcjXsuPjT0StNln0pw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbfEGRK5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 13:10:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:33100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726225AbfEGRK5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 13:10:57 -0400
Received: from localhost (unknown [106.200.210.185])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FBCB2053B;
        Tue,  7 May 2019 17:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557249056;
        bh=t7oPL7+XtQXXNlhx6KWpb7a1UJh20zGUTTFFX28Ujv8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GJi99P5EzigoVE+Iz8ZOlxsWyF6MZllOO/ey/RUg/c+WwyhRo5+kqXTPrT6lYC4N1
         VYulctKYesSoazDsetXpUWrhNjPqGI17oZBwQqXGCAzbNOxaOVLphAhL2HUHQo2k2p
         BejCtt5kMOa692Qlr3TG2GX9L7U98vUBaUCUEpZA=
Date:   Tue, 7 May 2019 22:40:43 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Kazuhiro Kasai <kasai.kazuhiro@socionext.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        orito.takao@socionext.com, sugaya.taichi@socionext.com,
        kanematsu.shinji@socionext.com, jaswinder.singh@linaro.org,
        masami.hiramatsu@linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dmaengine: milbeaut: Add Milbeaut AXI DMA controller
Message-ID: <20190507171042.GS16052@vkoul-mobl>
References: <1553487314-9185-1-git-send-email-kasai.kazuhiro@socionext.com>
 <1553487314-9185-3-git-send-email-kasai.kazuhiro@socionext.com>
 <20190426114629.GU28103@vkoul-mobl>
 <20190507053924.GA3359@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190507053924.GA3359@ubuntu>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-05-19, 14:39, Kazuhiro Kasai wrote:
> On Fri, Apr 26, 2019 at 17:16 +0530, Vinod Koul wrote:
> > On 25-03-19, 13:15, Kazuhiro Kasai wrote:

> > > +struct m10v_dma_chan {
> > > +	struct dma_chan chan;
> > > +	struct m10v_dma_device *mdmac;
> > > +	void __iomem *regs;
> > > +	int irq;
> > > +	struct m10v_dma_desc mdesc;
> >
> > So there is a *single* descriptor? Not a list??
> 
> Yes, single descriptor.

And why is that, you can create a list and keep getting descriptors and
issue them to hardware and get better pref!

> > > +static dma_cookie_t m10v_xdmac_tx_submit(struct dma_async_tx_descriptor *txd)
> > > +{
> > > +	struct m10v_dma_chan *mchan = to_m10v_dma_chan(txd->chan);
> > > +	dma_cookie_t cookie;
> > > +	unsigned long flags;
> > > +
> > > +	spin_lock_irqsave(&mchan->lock, flags);
> > > +	cookie = dma_cookie_assign(txd);
> > > +	spin_unlock_irqrestore(&mchan->lock, flags);
> > > +
> > > +	return cookie;
> >
> > sounds like vchan_tx_submit() i think you can use virt-dma layer and then
> > get rid of artificial limit in driver and be able to queue up the txn on
> > dmaengine.
> 
> OK, I will try to use virt-dma layer in next version.

And you will get lists to manage descriptor for free! so you can use
that to support multiple txns as well!

> > > +static struct dma_async_tx_descriptor *
> > > +m10v_xdmac_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dst,
> > > +			   dma_addr_t src, size_t len, unsigned long flags)
> > > +{
> > > +	struct m10v_dma_chan *mchan = to_m10v_dma_chan(chan);
> > > +
> > > +	dma_async_tx_descriptor_init(&mchan->mdesc.txd, chan);
> > > +	mchan->mdesc.txd.tx_submit = m10v_xdmac_tx_submit;
> > > +	mchan->mdesc.txd.callback = NULL;
> > > +	mchan->mdesc.txd.flags = flags;
> > > +	mchan->mdesc.txd.cookie = -EBUSY;
> > > +
> > > +	mchan->mdesc.len = len;
> > > +	mchan->mdesc.src = src;
> > > +	mchan->mdesc.dst = dst;
> > > +
> > > +	return &mchan->mdesc.txd;
> >
> > So you support single descriptor and dont check if this has been already
> > configured. So I guess this has been tested by doing txn one at a time
> > and not submitted bunch of txn and wait for them to complete. Please fix
> > that to really enable dmaengine capabilities.
> 
> Thank you for advice. I want to fix it and I have 2 questions.
> 
> 1. Does virt-dma layer help to fix this?

Yes

> 2. Can dmatest test that dmaengine capabilities?

Yes for memcpy operations, see Documentation/driver-api/dmaengine/dmatest.rst

-- 
~Vinod
