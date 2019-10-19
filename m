Return-Path: <SRS0=/uHP=YM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA05CA9EAB
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 15:17:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 298F5222BD
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 15:17:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725980AbfJSPR3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Oct 2019 11:17:29 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:54695
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725810AbfJSPR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Oct 2019 11:17:29 -0400
X-IronPort-AV: E=Sophos;i="5.67,316,1566856800"; 
   d="scan'208";a="323302512"
Received: from ip-121.net-89-2-166.rev.numericable.fr (HELO hadrien) ([89.2.166.121])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Oct 2019 17:17:25 +0200
Date:   Sat, 19 Oct 2019 17:17:25 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Jules Irenge <jbi.octave@gmail.com>
cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        outreachy-kernel@googlegroups.com, devel@driverdev.osuosl.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] Re: [PATCH v1 1/5] staging: wfx: fix warnings
 of no space is necessary
In-Reply-To: <alpine.LFD.2.21.1910191603520.6740@ninjahub.org>
Message-ID: <alpine.DEB.2.21.1910191713480.3272@hadrien>
References: <20191019140719.2542-1-jbi.octave@gmail.com> <20191019140719.2542-2-jbi.octave@gmail.com> <20191019142443.GH24678@kadam> <alpine.LFD.2.21.1910191603520.6740@ninjahub.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 19 Oct 2019, Jules Irenge wrote:

>
>
> On Sat, 19 Oct 2019, Dan Carpenter wrote:
>
> > On Sat, Oct 19, 2019 at 03:07:15PM +0100, Jules Irenge wrote:
> > > diff --git a/drivers/staging/wfx/bh.c b/drivers/staging/wfx/bh.c
> > > index 3355183fc86c..573216b08042 100644
> > > --- a/drivers/staging/wfx/bh.c
> > > +++ b/drivers/staging/wfx/bh.c
> > > @@ -69,13 +69,13 @@ static int rx_helper(struct wfx_dev *wdev, size_t read_len, int *is_cnf)
> > >  	if (wfx_data_read(wdev, skb->data, alloc_len))
> > >  		goto err;
> > >
> > > -	piggyback = le16_to_cpup((u16 *) (skb->data + alloc_len - 2));
> > > +	piggyback = le16_to_cpup((u16 *)(skb->data + alloc_len - 2));
> > >  	_trace_piggyback(piggyback, false);
> > >
> > > -	hif = (struct hif_msg *) skb->data;
> > > +	hif = (struct hif_msg *)skb->data;
> > >  	WARN(hif->encrypted & 0x1, "unsupported encryption type");
> > >  	if (hif->encrypted == 0x2) {
> > > -		if (wfx_sl_decode(wdev, (void *) hif)) {
> > > +		if (wfx_sl_decode(wdev, (void *)hif)) {
> >
> > In the future you may want to go through and remove the (void *) casts.
> > It's not required here.
> >
> > > diff --git a/drivers/staging/wfx/bus_spi.c b/drivers/staging/wfx/bus_spi.c
> > > index f65f7d75e731..effd07957753 100644
> > > --- a/drivers/staging/wfx/bus_spi.c
> > > +++ b/drivers/staging/wfx/bus_spi.c
> > > @@ -90,7 +90,7 @@ static int wfx_spi_copy_to_io(void *priv, unsigned int addr,
> > >  	struct wfx_spi_priv *bus = priv;
> > >  	u16 regaddr = (addr << 12) | (count / 2);
> > >  	// FIXME: use a bounce buffer
> > > -	u16 *src16 = (void *) src;
> > > +	u16 *src16 = (void *)src;
> >
> > Here we are just getting rid of the constness.  Apparently we are doing
> > that so we can modify it without GCC pointing out the bug!!  I don't
> > know the code but this seems very wrong.
> >
> Checkpatch was complaining about  space between type cast and the
> variable. I just get rid of the space. Well I don't know whether this was
> false positive one.

I think you missed the point.  It would be good to trace through the core
and try to figure out where this src value comes from.  Is it really
const?  Or is the const declaration there just to satisfy the type
checker, and is the actual data provided not const.  This function is
stored in a hwbus_ops structure.  It would be good to see what other
drivers that store a function in the same field of such a structure do,
and to see where the function is actually called (via a function pointer)
and where the argument comes from.

julia
