Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BFE3C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 03:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4D0120663
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 03:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="k8jJUyVS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbfLIDsB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Dec 2019 22:48:01 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:37508 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727073AbfLIDsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 22:48:00 -0500
Received: by mail-ua1-f68.google.com with SMTP id f9so4707618ual.4
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2019 19:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y+vxa3qCisuYX81ZvQKh/06NrXG6iSdwdH4Sz/s9g3g=;
        b=k8jJUyVSl6cE4W+fWhINdIPhwRBP5gNyjYOHsG6BtSo72KlCvh7X4RDiFph7rJprIi
         XyazImi+bK0wINFqmmHwu03wtt5n94j9ydqfRE1VwIEqu6u4HXz3sipGT/0IrBaoGQFT
         OcGMO3nxsp+5D+E0hapuUO37q/Xcf3Z0IImYE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y+vxa3qCisuYX81ZvQKh/06NrXG6iSdwdH4Sz/s9g3g=;
        b=iUDi9PMglo1SOloiyGIYVrI5qdqjzfXQwcAeH3c03AhhiJgaJNUDYw2tM2AORB0spz
         mMgNe5i+BSu2y7cEKI8XqIk7VF3aEcnmb/eWJYlh/Cn2JOlqYN2VHO4PwZrfFXq0GMTb
         UXL3XDsitHZhw/UzduYu14M1+i+M+LHXpoKEG3W46F6IfVKLRG4bn4sjBdSKSsiKMY26
         BahtlqbjlbZ0CBnwqgNQ4SZEL5NJKkQrrmmMHdjj3sDzPhBJyZa9O+9lTnOJsrQ3PUWp
         T2qdHzry+dqA467Ucv4SAh/sfg/SfLASBoK3bqlkWeGTlN9tp6HgxpPk2aV3kCGVTAd/
         zRpQ==
X-Gm-Message-State: APjAAAW1KVXPcrVcgs4DnWzAxEWTL4Y5zfOWLp9vtXEiLno/v3ph8Xd9
        eARyxhwqyn9hbPVwhVcuj4GV5s5tmlrM2Pc3QFxIiQ==
X-Google-Smtp-Source: APXvYqw2Y9m8C3sZpyxjV87zZFwVpnaCBxRbzi4DdUd8/DIvSJj/1SrjcwuU7XlgujbYOE7ZR3vziSReJMhZOUXDYC0=
X-Received: by 2002:ab0:3487:: with SMTP id c7mr20535526uar.25.1575863278400;
 Sun, 08 Dec 2019 19:47:58 -0800 (PST)
MIME-Version: 1.0
References: <CAATdQgBK4gWvR06YJ3Z_y5NeqLKYY7Ajc0KG78rG2deR3Ga11A@mail.gmail.com>
 <Pine.LNX.4.44L0.1912060958550.1618-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1912060958550.1618-100000@iolanthe.rowland.org>
From:   Ikjoon Jang <ikjn@chromium.org>
Date:   Mon, 9 Dec 2019 11:47:47 +0800
Message-ID: <CAATdQgAxCja9L33QFQOEfPjOrGc5-pTGXifsYnxAZ+LOLkcuxA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] usb: overridable hub bInterval by device node
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org,
        GregKroah-Hartman <gregkh@linuxfoundation.org>,
        RobHerring <robh+dt@kernel.org>,
        MarkRutland <mark.rutland@arm.com>,
        SuwanKim <suwan.kim027@gmail.com>,
        "GustavoA . R . Silva" <gustavo@embeddedor.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nicolas Boichat <drinkcat@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 6, 2019 at 11:00 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Fri, 6 Dec 2019, Ikjoon Jang wrote:
>
> > On Thu, Dec 5, 2019 at 10:26 PM Johan Hovold <johan@kernel.org> wrote:
> > >
> > > On Thu, Dec 05, 2019 at 03:32:38PM +0800, Ikjoon Jang wrote:
> > > > On Wed, Dec 4, 2019 at 3:55 PM Johan Hovold <johan@kernel.org> wrote:
> > >
> > > > > But related to my question above, why do you need to do this during
> > > > > enumeration? Why not just set the lower interval value in the hub
> > > > > driver?
> > > >
> > > > Because I want device tree's bInterval to be checked against the same rules
> > > > defined in usb_parse_endpoint(). e.g. although hardware says its maximum
> > > > is 255, but the practical limit is still 0 to 16, so the code can
> > > > print warnings when bInterval from device node is too weird.
> > >
> > > But that could be handled refactoring the code in question or similar.
> > >
> >
> > Yes, that should be worked. I can't exactly figure out how to refactor
> > the code for now, but maybe parsed endpoint descriptors are being
> > checked with default hard wired bInterval value and after that
> > an overridden value should be checked again.
> >
> > Actually I don't care about the details of software policies. I just want
> > all devices to be handled in the same manner without any further
> > special treatments.
> >
> > > The fundamental problem here is that you're using devicetree, which is
> > > supposed to only describe the hardware, to encode policy which should be
> > > deferred to user space.
> >
> > The hub hardware has a default bInterval inside which is actually
> > adjustable. So I can think setting bInterval is to describe the hardware
> > rather than policy.
>
> If the hardware is adjustable, why don't you adjust the hardware
> instead of changing the software?

sorry, I meant "hardware has a default value but it's actually
adjustable (by software)". Adjusting hardware is the best option but
our hub doesn't allow to do that, so the current approach is patching
a hardware descriptor on enumeration stage.

>
> > > So I think you need to figure out an interface that allows user space to
> > > set the polling interval for any hub at runtime instead.
> >
> > Changing the interval at runtime is an another way to solve the
> > power consumption problem, but it's not so easy. At least xhci needs
> > to restart an endpoint and no devices are changing the interval after
> > enumeration stage.
>
> Restarting endpoints is easy; just call usb_set_interface().

I thought just changing urb->interval at runtime will be more acceptable.
Maybe I'll need an another approach if this patch is unacceptable.

Thank you!

>
> Alan Stern
>
