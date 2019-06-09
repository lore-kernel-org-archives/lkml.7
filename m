Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B85D7C28CC5
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 00:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73442214AE
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 00:15:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="GMgccx4I";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="RlScfWzD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbfFIAPy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 20:15:54 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56699 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbfFIAPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 20:15:54 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C465E5C8FF;
        Sat,  8 Jun 2019 20:15:51 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:in-reply-to:message-id:references:mime-version
        :content-type; s=sasl; bh=bd142Ou0olyyhQXEUfvxQXeeF6g=; b=GMgccx
        4I3F1VrOghv9H9D8lzc7LPCuoOIlryTo43cDuCOF75GDERlIYxcCjOSVgX6jW7kR
        VLax+TR9NXYFT6h31uvWE67QokTo61PZk1dXv4+fK2BRUeqselThdd7DD862u3gw
        GqK5bL4vPfN+XieQXqbNBHSwF92Kd06ukhzX8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BC7B75C8FE;
        Sat,  8 Jun 2019 20:15:51 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=7zuctmsW7EpJgtHD/eoEiJtcUTAjwVvVHUiIgul0tD4=; b=RlScfWzD+tc27aWDfIK8TapB268mkVWGGbDFrLwh7bAoCp1ams0kA9NUySVkqcA6dDcAt4/qDT27e/wSEILo5Cg9bYPAxx+GPgmcxZNNYfa5Sv39NIVkEucPZ1rOZK98IYpgdMOg1qod7mtG0AwjPDL6JDxQpFVUS0lIMymivkM=
Received: from yoda.home (unknown [70.82.130.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AEE805C8FD;
        Sat,  8 Jun 2019 20:15:48 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id E472F2DA03AA;
        Sat,  8 Jun 2019 20:15:46 -0400 (EDT)
Date:   Sat, 8 Jun 2019 20:15:46 -0400 (EDT)
From:   Nicolas Pitre <nico@fluxnic.net>
To:     Greg KH <gregkh@linuxfoundation.org>
cc:     Gen Zhang <blackgod016574@gmail.com>, jslaby@suse.com,
        kilobyte@angband.pl, textshell@uchuujin.de, mpatocka@redhat.com,
        daniel.vetter@ffwll.ch, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] vt: Fix a missing-check bug in con_init()
In-Reply-To: <20190608162219.GB11699@kroah.com>
Message-ID: <nycvar.YSQ.7.76.1906082010430.1558@knanqh.ubzr>
References: <20190528004529.GA12388@zhanggen-UX430UQ> <20190608160138.GA3840@zhanggen-UX430UQ> <20190608162219.GB11699@kroah.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: BBAC4D20-8A4B-11E9-AE4A-8D86F504CC47-78420484!pb-smtp21.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Jun 2019, Greg KH wrote:

> On Sun, Jun 09, 2019 at 12:01:38AM +0800, Gen Zhang wrote:
> > On Tue, May 28, 2019 at 08:45:29AM +0800, Gen Zhang wrote:
> > > In function con_init(), the pointer variable vc_cons[currcons].d, vc and
> > > vc->vc_screenbuf is allocated by kzalloc(). And they are used in the 
> > > following codes. However, kzalloc() returns NULL when fails, and null 
> > > pointer dereference may happen. And it will cause the kernel to crash. 
> > > Therefore, we should check the return value and handle the error.
> > > 
> > > Further, since the allcoation is in a loop, we should free all the 
> > > allocated memory in a loop.
> > > 
> > > Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
> > > Reviewed-by: Nicolas Pitre <nico@fluxnic.net>
> > > ---
> > > diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> > > index fdd12f8..d50f68f 100644
> > > --- a/drivers/tty/vt/vt.c
> > > +++ b/drivers/tty/vt/vt.c
> > > @@ -3350,10 +3350,14 @@ static int __init con_init(void)
> > >  
> > >  	for (currcons = 0; currcons < MIN_NR_CONSOLES; currcons++) {
> > >  		vc_cons[currcons].d = vc = kzalloc(sizeof(struct vc_data), GFP_NOWAIT);
> > > +		if (!vc)
> > > +			goto fail1;
> > >  		INIT_WORK(&vc_cons[currcons].SAK_work, vc_SAK);
> > >  		tty_port_init(&vc->port);
> > >  		visual_init(vc, currcons, 1);
> > >  		vc->vc_screenbuf = kzalloc(vc->vc_screenbuf_size, GFP_NOWAIT);
> > > +		if (!vc->vc_screenbuf)
> > > +			goto fail2;
> > >  		vc_init(vc, vc->vc_rows, vc->vc_cols,
> > >  			currcons || !vc->vc_sw->con_save_screen);
> > >  	}
> > > @@ -3375,6 +3379,16 @@ static int __init con_init(void)
> > >  	register_console(&vt_console_driver);
> > >  #endif
> > >  	return 0;
> > > +fail1:
> > > +	while (currcons > 0) {
> > > +		currcons--;
> > > +		kfree(vc_cons[currcons].d->vc_screenbuf);
> > > +fail2:
> > > +		kfree(vc_cons[currcons].d);
> > > +		vc_cons[currcons].d = NULL;
> > > +	}
> 
> Wait, will that even work?  You can jump into the middle of a while
> loop?

Absolutely.

> Ugh, that's beyond ugly.

That was me who suggested to do it like that. To me, this is nicer than 
the proposed alternatives. For an error path that is rather unlikely to 
happen, I think this is a very concise and eleguant way to do it.

> And please provide "real" names for the
> labels, "fail1" and "fail2" do not tell anything here.

That I agree with.


Nicolas
