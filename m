Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D3BC28CC5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 16:21:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A03242089E
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 16:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560010917;
	bh=P7J7wCkGbdCVpd8rhVmHJj60h1hBJqwwaY1Op60Tc1E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rZzlJ/WhEe67hQqYJRY1f8YNaBeUHEwiFizcBQddZeR8snczvNEdtD+JwWv0QPrlD
	 37gX8s8wFb/DY1u1yj3IeP0yWmBHKBv+jpuNVeCu4zF8rFgjtvUfk0c55AiIoDj8+6
	 kWgxlryj7U19S8ADkXcC3PsyDNNa4iPE1jsTzkeQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727248AbfFHQVb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 12:21:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:50468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727160AbfFHQVa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 12:21:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B7C52089E;
        Sat,  8 Jun 2019 16:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560010890;
        bh=P7J7wCkGbdCVpd8rhVmHJj60h1hBJqwwaY1Op60Tc1E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fCIfTap4OH1+SNuDtGA0Amdtpp+emh5QnyhaZTsuLVaCVFuX9dcQ3phO2y5uxaOMH
         ZXj0Uaviuh9KMgBgy7brPmCgGXZlruLSf4X4VPFNeaaiom6Qioqxyg8fF7cv5mHH3e
         r5Dr7SNqw3opUu0Rvca+611Q2U21DYhR1NTqGafs=
Date:   Sat, 8 Jun 2019 18:21:27 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Gen Zhang <blackgod016574@gmail.com>
Cc:     jslaby@suse.com, nico@fluxnic.net, kilobyte@angband.pl,
        textshell@uchuujin.de, mpatocka@redhat.com, daniel.vetter@ffwll.ch,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] vt: Fix a missing-check bug in con_init()
Message-ID: <20190608162127.GA11699@kroah.com>
References: <20190528004529.GA12388@zhanggen-UX430UQ>
 <20190608160138.GA3840@zhanggen-UX430UQ>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190608160138.GA3840@zhanggen-UX430UQ>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 09, 2019 at 12:01:38AM +0800, Gen Zhang wrote:
> On Tue, May 28, 2019 at 08:45:29AM +0800, Gen Zhang wrote:
> > In function con_init(), the pointer variable vc_cons[currcons].d, vc and
> > vc->vc_screenbuf is allocated by kzalloc(). And they are used in the 
> > following codes. However, kzalloc() returns NULL when fails, and null 
> > pointer dereference may happen. And it will cause the kernel to crash. 
> > Therefore, we should check the return value and handle the error.
> > 
> > Further, since the allcoation is in a loop, we should free all the 
> > allocated memory in a loop.
> > 
> > Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
> > Reviewed-by: Nicolas Pitre <nico@fluxnic.net>
> > ---
> > diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> > index fdd12f8..d50f68f 100644
> > --- a/drivers/tty/vt/vt.c
> > +++ b/drivers/tty/vt/vt.c
> > @@ -3350,10 +3350,14 @@ static int __init con_init(void)
> >  
> >  	for (currcons = 0; currcons < MIN_NR_CONSOLES; currcons++) {
> >  		vc_cons[currcons].d = vc = kzalloc(sizeof(struct vc_data), GFP_NOWAIT);
> > +		if (!vc)
> > +			goto fail1;
> >  		INIT_WORK(&vc_cons[currcons].SAK_work, vc_SAK);
> >  		tty_port_init(&vc->port);
> >  		visual_init(vc, currcons, 1);
> >  		vc->vc_screenbuf = kzalloc(vc->vc_screenbuf_size, GFP_NOWAIT);
> > +		if (!vc->vc_screenbuf)
> > +			goto fail2;
> >  		vc_init(vc, vc->vc_rows, vc->vc_cols,
> >  			currcons || !vc->vc_sw->con_save_screen);
> >  	}
> > @@ -3375,6 +3379,16 @@ static int __init con_init(void)
> >  	register_console(&vt_console_driver);
> >  #endif
> >  	return 0;
> > +fail1:
> > +	while (currcons > 0) {
> > +		currcons--;
> > +		kfree(vc_cons[currcons].d->vc_screenbuf);
> > +fail2:
> > +		kfree(vc_cons[currcons].d);
> > +		vc_cons[currcons].d = NULL;
> > +	}
> > +	console_unlock();
> > +	return -ENOMEM;
> >  }
> >  console_initcall(con_init);
> >  
> > ---
> Can anyone look into this patch? It's already reviewed by Nicolas Pitre
> <nico@fluxnic.net>.

It's in my queue.  But note, given the previous history of your patches,
it's really low on my piority list at the moment :(

greg k-h
