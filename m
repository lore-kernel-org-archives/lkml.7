Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6157EC4CEC9
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 18:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 359B820CC7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 18:01:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="WYkiuNst"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388316AbfIMSBi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 14:01:38 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:39252 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387935AbfIMSBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 14:01:37 -0400
Received: by mail-io1-f66.google.com with SMTP id a1so6336146ioc.6
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 11:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rrqyBJXWUQ16PunrNF8zt8vFNM7dGzrn1uN2ZDTIc38=;
        b=WYkiuNstUL4C1A6/IQCqTzer03XR1ChqSC4kgR1OcSkJQFGlbYACPK2h8EdfA/qqBd
         GoGsmX94Xxf3i8gIrwfafayJsVgMePf/V6ebIWmVWX9cZ5GaZ7745S7FAUFZPgYnO0Ft
         TDuX0vamwNxc3AUvtkUyfhcNm7b17L0B+o1LcV5fU+IZS8ZUiQMPJKcOeR+RFXx8sEog
         Q0jKrDzrhTfTe/MIFcg05mmu0EY/afa7vNV1MOaXHmyHrMNDIhNfT3QRldyMdScWxegG
         f7oGGpQvDt2+fD7qeLy2jTMmEnnsi0/BRfS3qvOhWT6FOZtwcVLiHn+18kU5pBdEkDvP
         LY4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rrqyBJXWUQ16PunrNF8zt8vFNM7dGzrn1uN2ZDTIc38=;
        b=mfsJeoYSbnI+oRVe3X3dnwakCy/dmtKempohB/mQG4p3yJVVkdLCLZvK8AaRBPt9jX
         N1zDhe6pQg4K5oReLu86rMJ4NDgw9Ha2X5ec/qJF0tfRFeOnnijFvUGoMloPmv9zbULy
         zuyKvw+ZuILD+xCM3jHvs3S+JojgiHvipYO9UrbeWUx5RdOa6SEgBJRySOj4H5p9TQKd
         z7xhAQsnIlA6WnI5jKm946xPKLsR6LfogRGAKDlHhQJT9jSXatceU8sfOPL1iLTSywGU
         FFh4dMO/v+3ZLrRopeZCbl2G30ag4CrjPH/l//TEgm7v1SBFv2H7q6ewrK3gQWiU+6N8
         rNAQ==
X-Gm-Message-State: APjAAAU2WbL3blQB6fVrajssHe4zCttitHayD82C3OkESFK3b5PxaF0I
        mZpVfI+4kUrCHS5SSRNK9gj4WRsGU5swme7nVTzfFw==
X-Google-Smtp-Source: APXvYqwFJEEJhwuv81cn6FabGiVO1hPcxr4bxgTgHkH/tJbTRcpvohUfBiXg5ikABnrWbtWlawep4p0jt1X3QUb1Dfg=
X-Received: by 2002:a6b:b291:: with SMTP id b139mr1195741iof.281.1568397697093;
 Fri, 13 Sep 2019 11:01:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190729000631.GA24165@embeddedor> <201907290936.F5F486A6F@keescook>
 <CAOesGMh=H8MnZYH7xUFjF4rGWTt+cdkOGfDG4gr=Uaa1mU8A+A@mail.gmail.com>
In-Reply-To: <CAOesGMh=H8MnZYH7xUFjF4rGWTt+cdkOGfDG4gr=Uaa1mU8A+A@mail.gmail.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Fri, 13 Sep 2019 19:01:25 +0100
Message-ID: <CAOesGMinkG6gdQ-UZqtBooFrWXH_nB6uOovwZNcbqyJyHxd_Xg@mail.gmail.com>
Subject: Re: [PATCH] usb: phy: ab8500-usb: Mark expected switch fall-throughs
To:     Kees Cook <keescook@chromium.org>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 13, 2019 at 7:00 PM Olof Johansson <olof@lixom.net> wrote:
>
> On Mon, Jul 29, 2019 at 5:36 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Sun, Jul 28, 2019 at 07:06:31PM -0500, Gustavo A. R. Silva wrote:
> > > Mark switch cases where we are expecting to fall through.
> > >
> > > This patch fixes the following warnings:
> > >
> > > drivers/usb/phy/phy-ab8500-usb.c: In function 'ab8500_usb_link_status_update':
> > > drivers/usb/phy/phy-ab8500-usb.c:424:9: warning: this statement may fall through [-Wimplicit-fallthrough=]
> > >    event = UX500_MUSB_RIDB;
> > >    ~~~~~~^~~~~~~~~~~~~~~~~
> > > drivers/usb/phy/phy-ab8500-usb.c:425:2: note: here
> > >   case USB_LINK_NOT_CONFIGURED_8500:
> > >   ^~~~
> > > drivers/usb/phy/phy-ab8500-usb.c:440:9: warning: this statement may fall through [-Wimplicit-fallthrough=]
> > >    event = UX500_MUSB_RIDC;
> > >    ~~~~~~^~~~~~~~~~~~~~~~~
> > > drivers/usb/phy/phy-ab8500-usb.c:441:2: note: here
> > >   case USB_LINK_STD_HOST_NC_8500:
> > >   ^~~~
> > > drivers/usb/phy/phy-ab8500-usb.c:459:9: warning: this statement may fall through [-Wimplicit-fallthrough=]
> > >    event = UX500_MUSB_RIDA;
> > >    ~~~~~~^~~~~~~~~~~~~~~~~
> > > drivers/usb/phy/phy-ab8500-usb.c:460:2: note: here
> > >   case USB_LINK_HM_IDGND_8500:
> > >   ^~~~
> > > drivers/usb/phy/phy-ab8500-usb.c: In function 'ab8505_usb_link_status_update':
> > > drivers/usb/phy/phy-ab8500-usb.c:332:9: warning: this statement may fall through [-Wimplicit-fallthrough=]
> > >    event = UX500_MUSB_RIDB;
> > >    ~~~~~~^~~~~~~~~~~~~~~~~
> > > drivers/usb/phy/phy-ab8500-usb.c:333:2: note: here
> > >   case USB_LINK_NOT_CONFIGURED_8505:
> > >   ^~~~
> > > drivers/usb/phy/phy-ab8500-usb.c:352:9: warning: this statement may fall through [-Wimplicit-fallthrough=]
> > >    event = UX500_MUSB_RIDC;
> > >    ~~~~~~^~~~~~~~~~~~~~~~~
> > > drivers/usb/phy/phy-ab8500-usb.c:353:2: note: here
> > >   case USB_LINK_STD_HOST_NC_8505:
> > >   ^~~~
> > > drivers/usb/phy/phy-ab8500-usb.c:370:9: warning: this statement may fall through [-Wimplicit-fallthrough=]
> > >    event = UX500_MUSB_RIDA;
> > >    ~~~~~~^~~~~~~~~~~~~~~~~
> > > drivers/usb/phy/phy-ab8500-usb.c:371:2: note: here
> > >   case USB_LINK_HM_IDGND_8505:
> > >   ^~~~
> > >
> > > Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > > Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> >
> > Reviewed-by: Kees Cook <keescook@chromium.org>
>
> Acked-by: Olof Johansson <olof@lixom.net>
>
> Felipe, Greg, this is still throwing warnings, several months later --
> patch was never applied.
>
> Mind picking it up as a fix to get a quieter build?

Nevermind, I see they're gone from -next, so at least it's queued for
next merge window. Sorry for the noise.


-Olof
