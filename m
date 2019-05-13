Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB762C04AB1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 09:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7748120989
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 09:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557741494;
	bh=GugtbO6r1aotk52H6efoJIjxlBpFXEPBZFuINKb0HPQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=h8NBdtMrmPBZZA/g8O6GlZK1wxlZtJQoTya2LgyptlAuUJ6JN0GBKfTWLkRpI1chT
	 nRbAKhzFvrQqfmdt67u+PSqwP9i/V4LfG9GqGCI1kwex1CU99RcnVG/mfLzzvOS0Xi
	 IaIsBM5mGy6sH7+Tir6+tG2HKaMZXoNaN3Ll/Ldo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727997AbfEMJ6N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 05:58:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:32980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727132AbfEMJ6N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 05:58:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD33C20989;
        Mon, 13 May 2019 09:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557741492;
        bh=GugtbO6r1aotk52H6efoJIjxlBpFXEPBZFuINKb0HPQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K/uHhlUMQ7Ked/252+zMeUTP3Q63bKqZpAzERFuR1J591ArsTnhlEuFC+JeAuFwft
         AtPIABtHnBEPoTo2fNKJ+GMn43ZdkAY2Zjj3ttgzlionXqyB0uG8wczb4L2OunK76Y
         hpCcpra4S78cHF2FrNueVDiIzufw3YimcSzIbpT4=
Date:   Mon, 13 May 2019 11:58:09 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Gen Zhang <blackgod016574@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vt: Fix a missing-check bug in drivers/tty/vt/vt.c file
 of Linux 5.0.14
Message-ID: <20190513095809.GA4588@kroah.com>
References: <20190510051415.GA6073@kroah.com>
 <CAAie0ao_O0hcUOuUf67oog+dSswdQRpAtX8NyQvDAr_XQr=xQg@mail.gmail.com>
 <20190510151206.GA31186@kroah.com>
 <CAAie0arnSxFvkNE1KSxD1a19_PQy03Q4RSiLZo9t7C9LeKkA9w@mail.gmail.com>
 <20190511060741.GC18755@kroah.com>
 <20190512032719.GA16296@zhanggen-UX430UQ>
 <20190512062009.GA25153@kroah.com>
 <20190512084916.GA4615@zhanggen-UX430UQ>
 <20190513073619.GA5580@kroah.com>
 <20190513093730.GA4487@zhanggen-UX430UQ>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190513093730.GA4487@zhanggen-UX430UQ>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13, 2019 at 05:37:41PM +0800, Gen Zhang wrote:
> On Mon, May 13, 2019 at 09:36:19AM +0200, Greg KH wrote:
> > > Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
> > > ---
> > > --- drivers/tty/vt/vt.c
> > > +++ drivers/tty/vt/vt.c
> > > @@ -3349,10 +3349,14 @@ static int __init con_init(void)
> > >  
> > >  	for (currcons = 0; currcons < MIN_NR_CONSOLES; currcons++) {
> > >  		vc_cons[currcons].d = vc = kzalloc(sizeof(struct vc_data), GFP_NOWAIT);
> > > +		if (!vc_cons[currcons].d || !vc)
> > > +			goto err_vc;
> > 
> > What about the other memory that was allocated?  You never free that.
> > 
> > >  		INIT_WORK(&vc_cons[currcons].SAK_work, vc_SAK);
> > >  		tty_port_init(&vc->port);
> > >  		visual_init(vc, currcons, 1);
> > >  		vc->vc_screenbuf = kzalloc(vc->vc_screenbuf_size, GFP_NOWAIT);
> > > +		if (!vc->vc_screenbuf)
> > > +			goto err_vc_screenbuf;
> > 
> > Same here, you are now leaking memory.
> > 
> > Did you test this patch out with a kmalloc function that can fail?  If
> > not, please try to do so.
> > 
> > thanks,
> > 
> > greg k-h
> Hi, Greg
> 1. I re-examined the source code.
> For vc_cons[currcons].d and vc allocation fail, we may need to free
> vc->vc_screenbuf from the previous loop. So kfree(vc->vc_screenbuf) 
> need to be added to err_vc;
> As for vc->vc_screenbuf allocation fail, I don't think there is other
> memory need to be freed. Because in function con_init, there's no other 
> allocation operations except this two kzalloc functions. And in
> err_vc_screenbuf, vc_cons[currcons].d and vc is freed in the patch.

You have to unwind the loop and free and uninitialize all of the other
things you just created as well.

> 2. I tried to test this patch with a compiled kernel in QEMU but 
> failed. Testing this is out of my skills. So is there any other ways
> to test this patch?

qemu should work just fine, I don't know what else to suggest.  Run it
on "real hardware" with a kmalloc function modified to fail this
allocation?

good luck!

greg k-h
