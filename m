Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 271BDC4CEC7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 18:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5FCE2089F
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 18:00:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="lrI5FdZB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731186AbfIMSAR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 14:00:17 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:42425 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbfIMSAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 14:00:16 -0400
Received: by mail-io1-f65.google.com with SMTP id n197so64512008iod.9
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 11:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sk6zRwIJkZ2nyuNbu/AWU1hA4NRPSM/+3OMmqohibwM=;
        b=lrI5FdZBZbr1i2i77IO8wCLdCsTcgGeHbG8y41JH7Ws/WAQU7J5fsrqfY12FGrQoTg
         a8xct/3ZzUwV7y27q3/mHMdsQpWSdIbreEVgNft/rQJq/W09w8kV/lcIFru/w6ClWt5d
         C1PlJa10gJXQYJ/xiVhD0+X5tdwlE5YsY4TyP9l7+HL8AOEeq4dt5Srq3JG6hIn3ifEc
         dyYCHNRZCfEqw7ByiqYt6T5PeGSs4k0JJm41MxglB3Y7HRjd1Cl1ek+mQy4TYusGP5GJ
         yuy8bu8vx/IDy7yCiI7XLWON9aqo449Yj5d3ZDLpqYhGaWx/cI7+0gKPWdqOx9s05wzS
         ctRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sk6zRwIJkZ2nyuNbu/AWU1hA4NRPSM/+3OMmqohibwM=;
        b=EA7HzgZ9GFlb6+HzMmu53ZGOP6Y6lB+IsdrUgTOf/jU4KMp52HIC/HQPmOjp4J3VZV
         oiddup91xLsJghqSeIYlVnv9mu8r7bZeUL4FLDj6PDrpMOt/tgEKhFNGf37hVr6deQZo
         ctCnsY7TLZ64uysd12Zza75eu0qi1RBRt0Rwemll9DAY/q9KosFTk6jy+7tvoTRgVzXN
         djozUaLoOn+pVNIehTkj9zSubw8KMcrzisVBI58CaRXGcbeHqfcnNRM9v8b2Li5Kbs47
         eFqVGN78vuDCyRs8ifbEOYwmJsF5Dg+ZCW11wOxF6podnuS3si9YZJYUtwl57xgwMxBM
         zo6Q==
X-Gm-Message-State: APjAAAU7OSOJxZc5hmLza2nOgLmDy8vSTVcbfe7do8n2Im7YUhxLBIr1
        3mE4TnY3sUJkm+tMYdyzZQoVi4coGS7L6IYYwjuBaQ==
X-Google-Smtp-Source: APXvYqwSlwzTZNcbl3yCX0l6je8Y8gPsFxZbFPl9h2VkEqTXGEpwHg+21I17GTvPkbxSq7iF+dim1lFL4xqXx75vtN0=
X-Received: by 2002:a6b:6f0d:: with SMTP id k13mr1175320ioc.277.1568397615643;
 Fri, 13 Sep 2019 11:00:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190729000631.GA24165@embeddedor> <201907290936.F5F486A6F@keescook>
In-Reply-To: <201907290936.F5F486A6F@keescook>
From:   Olof Johansson <olof@lixom.net>
Date:   Fri, 13 Sep 2019 19:00:04 +0100
Message-ID: <CAOesGMh=H8MnZYH7xUFjF4rGWTt+cdkOGfDG4gr=Uaa1mU8A+A@mail.gmail.com>
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

On Mon, Jul 29, 2019 at 5:36 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Sun, Jul 28, 2019 at 07:06:31PM -0500, Gustavo A. R. Silva wrote:
> > Mark switch cases where we are expecting to fall through.
> >
> > This patch fixes the following warnings:
> >
> > drivers/usb/phy/phy-ab8500-usb.c: In function 'ab8500_usb_link_status_update':
> > drivers/usb/phy/phy-ab8500-usb.c:424:9: warning: this statement may fall through [-Wimplicit-fallthrough=]
> >    event = UX500_MUSB_RIDB;
> >    ~~~~~~^~~~~~~~~~~~~~~~~
> > drivers/usb/phy/phy-ab8500-usb.c:425:2: note: here
> >   case USB_LINK_NOT_CONFIGURED_8500:
> >   ^~~~
> > drivers/usb/phy/phy-ab8500-usb.c:440:9: warning: this statement may fall through [-Wimplicit-fallthrough=]
> >    event = UX500_MUSB_RIDC;
> >    ~~~~~~^~~~~~~~~~~~~~~~~
> > drivers/usb/phy/phy-ab8500-usb.c:441:2: note: here
> >   case USB_LINK_STD_HOST_NC_8500:
> >   ^~~~
> > drivers/usb/phy/phy-ab8500-usb.c:459:9: warning: this statement may fall through [-Wimplicit-fallthrough=]
> >    event = UX500_MUSB_RIDA;
> >    ~~~~~~^~~~~~~~~~~~~~~~~
> > drivers/usb/phy/phy-ab8500-usb.c:460:2: note: here
> >   case USB_LINK_HM_IDGND_8500:
> >   ^~~~
> > drivers/usb/phy/phy-ab8500-usb.c: In function 'ab8505_usb_link_status_update':
> > drivers/usb/phy/phy-ab8500-usb.c:332:9: warning: this statement may fall through [-Wimplicit-fallthrough=]
> >    event = UX500_MUSB_RIDB;
> >    ~~~~~~^~~~~~~~~~~~~~~~~
> > drivers/usb/phy/phy-ab8500-usb.c:333:2: note: here
> >   case USB_LINK_NOT_CONFIGURED_8505:
> >   ^~~~
> > drivers/usb/phy/phy-ab8500-usb.c:352:9: warning: this statement may fall through [-Wimplicit-fallthrough=]
> >    event = UX500_MUSB_RIDC;
> >    ~~~~~~^~~~~~~~~~~~~~~~~
> > drivers/usb/phy/phy-ab8500-usb.c:353:2: note: here
> >   case USB_LINK_STD_HOST_NC_8505:
> >   ^~~~
> > drivers/usb/phy/phy-ab8500-usb.c:370:9: warning: this statement may fall through [-Wimplicit-fallthrough=]
> >    event = UX500_MUSB_RIDA;
> >    ~~~~~~^~~~~~~~~~~~~~~~~
> > drivers/usb/phy/phy-ab8500-usb.c:371:2: note: here
> >   case USB_LINK_HM_IDGND_8505:
> >   ^~~~
> >
> > Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>
> Reviewed-by: Kees Cook <keescook@chromium.org>

Acked-by: Olof Johansson <olof@lixom.net>

Felipe, Greg, this is still throwing warnings, several months later --
patch was never applied.

Mind picking it up as a fix to get a quieter build?


Thanks,

-Olof
