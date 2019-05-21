Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFDD3C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 10:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8177E217D4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 10:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558433349;
	bh=oRfdWJIlDP6kEIsnAFQfdAWeMdwoyfD2JsdWQrrqlNw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=V/Yg0lf3JbsMnoy5TWRD4UNoOCyS5xgDAwuEB2tiPAw/4mGltJHVzGoLV5KGNWEKy
	 wOVAYg5tM1GYb7mdH1JFxCC6faE6JGBJsHoSXqtvP5LF0IiemWMkWNFxtJHgCod/Lp
	 OKqCX8ungXRIDfQ85DiE3TNyDgA4OK5A01wyQhlA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727375AbfEUKJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 06:09:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:42610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726242AbfEUKJI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 06:09:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AFDC021773;
        Tue, 21 May 2019 10:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558433347;
        bh=oRfdWJIlDP6kEIsnAFQfdAWeMdwoyfD2JsdWQrrqlNw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vMSaNC+XJPJjyaw9XUSRzs+kmsYhpU9z7lVC1j7ydtZS33sy4T2ox51T3xb1BFTJH
         bn6QE3QvL+ezr8qaxlBRcuE6okiI+XDX/2LZkV2eP/tTaetHSPtjcZR6O6qn4uI4xW
         jh+Bg+TO/RKK/gXafDSeKajfkg2bYcM3B60rFRZE=
Date:   Tue, 21 May 2019 12:09:04 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Esben Haabendal <esben@haabendal.dk>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-serial@vger.kernel.org,
        Jiri Slaby <jslaby@suse.com>, Nishanth Menon <nm@ti.com>,
        Vignesh R <vigneshr@ti.com>, Tony Lindgren <tony@atomide.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] serial: 8250: Add support for 8250/16550 as MFD
 function
Message-ID: <20190521100904.GA13612@kroah.com>
References: <20190426084038.6377-1-esben@geanix.com>
 <20190426084038.6377-3-esben@geanix.com>
 <20190507114905.GB29524@dell>
 <87o94ejwrx.fsf@haabendal.dk>
 <20190507133844.GA6194@dell>
 <87bm05mpmx.fsf@haabendal.dk>
 <20190514104741.GO4319@dell>
 <20190514122618.GA18859@kroah.com>
 <87imudky2o.fsf@haabendal.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87imudky2o.fsf@haabendal.dk>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 14, 2019 at 02:41:35PM +0200, Esben Haabendal wrote:
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> 
> > On Tue, May 14, 2019 at 11:47:41AM +0100, Lee Jones wrote:
> >> On Tue, 14 May 2019, Esben Haabendal wrote:
> >> 
> >> > Lee Jones <lee.jones@linaro.org> writes:
> >> > 
> >> > > On Tue, 07 May 2019, Esben Haabendal wrote:
> >> > >
> >> > >> Lee Jones <lee.jones@linaro.org> writes:
> >> > >> 
> >> > >> > On Fri, 26 Apr 2019, Esben Haabendal wrote:
> >> > >> >
> >> > >> >> The serial8250-mfd driver is for adding 8250/16550 UART ports as functions
> >> > >> >> to an MFD driver.
> >> > >> >> 
> >> > >> >> When calling mfd_add_device(), platform_data should be a pointer to a
> >> > >> >> struct plat_serial8250_port, with proper settings like .flags, .type,
> >> > >> >> .iotype, .regshift and .uartclk.  Memory (or ioport) and IRQ should be
> >> > >> >> passed as cell resources.
> >> > >> >
> >> > >> > What?  No, please!
> >> > >> >
> >> > >> > If you *must* create a whole driver just to be able to use
> >> > >> > platform_*() helpers (which I don't think you should), then please
> >> > >> > call it something else.  This doesn't have anything to do with MFD.
> >> > >> 
> >> > >> True.
> >> > >> 
> >> > >> I really don't think it is a good idea to create a whole driver just to
> >> > >> be able to use platform_get_*() helpers.  And if I am forced to do this,
> >> > >> because I am unable to convince Andy to improve the standard serial8250
> >> > >> driver to support that, it should be called MFD.  The driver would be
> >> > >
> >> > > I assume you mean "shouldn't"?
> >> > 
> >> > Of-course.
> >> > 
> >> > >> generally usable for all usecases where platform_get_*() works.
> >> > >> 
> >> > >> I don't have any idea what to call such a driver.  It really would just
> >> > >> be a fork of the current serial8250 driver, just allowing use of
> >> > >> platform_get_*(), supporting exactly the same hardware.
> >> > >> 
> >> > >> I am still hoping that we can find a way to improve serial8250 to be
> >> > >> usable in these cases.
> >> > >
> >> > > Me too.
> >> > 
> >> > Unfortunately, I don't seem to be able to convince Andy to accept
> >> > something like that.
> >> 
> >> Andy is not he Maintainer.
> >> 
> >> What are Greg and Jiri's opinions?
> >
> > I've been ignoring all of this at the moment because of the 5.2-rc merge
> > window.  I'll look at it after -rc1 is out.
> >
> > thanks,
> > greg k-h
> 
> Great, thanks!
> 
> I will try ad hold back with this thread until you get back to it.

Ok, I have no idea what is going on here, sorry.  This is a really long
and meandering thread, and I can't even find the original patches in my
queue.

So can you resend things and we can start over?  :)

But note, using a mfd for a uart seems VERY odd to me...

thanks,

greg k-h
