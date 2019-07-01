Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D8AC0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 18:04:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE769206A3
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 18:04:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbfGASEH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 14:04:07 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46351 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727073AbfGASEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 14:04:06 -0400
Received: by mail-lj1-f194.google.com with SMTP id v24so14140271ljg.13
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 11:04:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MjE0XPXG5+SObe6nqWe6b+FvEpLg7LFAzR1ek564VrQ=;
        b=G8XM9ImcUlDrCDRdpfKDGU5Js/hl7OBc6tjghE9Azel+TScycndsKqT9zVt74PiI6X
         1Go0EyD8+T7USiVxOuwhOuA8upyY7YXfWZkMsc61UYT9ZGzDpZN7x1y1S7cLUWTF+tez
         EEg1KCvvyXTrW65q4aZV8jaw0GwbVvXWatNFwoDLFN1vyiYN/pQH7CBfEqaITtrnreJi
         0e08BSm4mBnfb72//OXmrNKtFVP1/FKotkjNCxEwt5MnCDTej2iFD8k89cQzvhQOmuka
         d3OEHiwPtTyQ5Y8zGnndxnYm+JbiEp8y9taaJBx8AtMxMJlOoRt0ZOdrppvunyq/cCaD
         goDw==
X-Gm-Message-State: APjAAAUkRNrd5+YvRRXTTZ5/5gn/V2IIW2jsbWcRoSgyLkfKZLZfjOu3
        QbsmQE0I6W/yAz9HX+raIh/jSYXOVLFYUil+E0Pfnw==
X-Google-Smtp-Source: APXvYqy5r5OT42DRG2NbZwsc835EZTVSfBwGNLB92WmyLwpvtAd32KmT+/XF0hM1qrPb8gWOqnkclNXq0AvolqMLUEE=
X-Received: by 2002:a2e:9117:: with SMTP id m23mr1503697ljg.134.1562004244498;
 Mon, 01 Jul 2019 11:04:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAGnkfhxxw9keiNj_Qm=2GBYpY38HAq28cOROMRqXfbqq8wNbWQ@mail.gmail.com>
 <20190628225533.GJ11506@sasha-vm> <1560226F-F2C0-440D-9C58-D664DE3C7322@appneta.com>
 <20190629074553.GA28708@kroah.com> <CAGnkfhzmGbeQe7L55nEv575XyubWqCLz=7NQPpH+TajDkkDiXg@mail.gmail.com>
 <20190701175241.GB9081@kroah.com>
In-Reply-To: <20190701175241.GB9081@kroah.com>
From:   Matteo Croce <mcroce@redhat.com>
Date:   Mon, 1 Jul 2019 20:03:28 +0200
Message-ID: <CAGnkfhx3ykbEsW+=FtpMFWU=_Vnie7RpPYWpWqa1S1HPMXj9kw@mail.gmail.com>
Subject: Re: net: check before dereferencing netdev_ops during busy poll
To:     Josh Elsasser <jelsasser@appneta.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Miller <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 1, 2019 at 7:53 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Sat, Jun 29, 2019 at 09:39:39PM +0200, Matteo Croce wrote:
> > On Sat, Jun 29, 2019 at 9:45 AM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Fri, Jun 28, 2019 at 07:03:01PM -0700, Josh Elsasser wrote:
> > > > On Jun 28, 2019, at 3:55 PM, Sasha Levin <sashal@kernel.org> wrote:
> > > >
> > > > > What's the upstream commit id?
> > > >
> > > > The commit wasn't needed upstream, as I only sent the original patch after
> > > > 79e7fff47b7b ("net: remove support for per driver ndo_busy_poll()") had
> > > > made the fix unnecessary in Linus' tree.
> > > >
> > > > May've gotten lost in the shuffle due to my poor Fixes tags. The patch in
> > > > question applied only on top of the 4.9 stable release at the time, but the
> > > > actual NPE had been around in some form since 3.11 / 0602129286705 ("net: add
> > > > low latency socket poll").
> > >
> > > Ok, can people then resend this and be very explicit as to why this is
> > > needed only in a stable kernel tree and get reviews from people agreeing
> > > that this really is the correct fix?
> > >
> > > thanks,
> > >
> > > greg k-h
> >
> > Hi Greg,
> >
> > I think that David alredy reviewed the patch here:
> >
> > https://lore.kernel.org/netdev/20180313.105115.682846171057663636.davem@davemloft.net/
> >
> > Anyway, I tested the patch and it fixes the panic, at least on my
> > iwlwifi card, so:
> >
> > Tested-by: Matteo Croce <mcroce@redhat.com>
>
> Ok, but what can I do with this?  I need a real patch, in mail form,
> that I can apply.  Not a web link to an email archive.
>
> You have read the stable kernel rules, right?  :)
>
> greg k-h

Understood.

Josh, as you are the original author, can you please resend it to -stable?
Feel free to add this tag:

Tested-by: Matteo Croce <mcroce@redhat.com>

Regards,
-- 
Matteo Croce
per aspera ad upstream
