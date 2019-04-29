Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9171C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 08:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 829C420578
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 08:34:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bV+A2rvc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727637AbfD2IeF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 04:34:05 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34729 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727480AbfD2IeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 04:34:02 -0400
Received: by mail-pf1-f193.google.com with SMTP id b3so4972751pfd.1;
        Mon, 29 Apr 2019 01:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OPcDt9d30P2DrWihwMD5KzyLdiEc+hDV0Ch16pAIVx8=;
        b=bV+A2rvcF3dA7spUDvQeVqaw2j2wj1Em7g8BVD/QBu58K3ZrFGsOZx/8WDXwt7BhkN
         Yk//y77bc6jXfg4ab7OQmXf5/9vThJ7i5VVaedHG8Wl1N7CbX6PtqQCr7dTvAymynUWf
         c0ev+ZvvetNTtlylD8F7bLsIN14xdK0wcZaOYWjcNB4l+6wx7x19B1gr35emJvEpapMI
         OjNHvJS0hBXZqV2DRc3oPeRrVbwFxYYRAnOYSHn/WFVTzHD35qF6uOTKbtB6Z2zUBHgq
         r/qIkVXnxZVNOa5+0dxNZCi75oblwyvoLU3gm9W0+F5RL8/2PpHWt5IGwZ10Vu3ZJPQm
         c8Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OPcDt9d30P2DrWihwMD5KzyLdiEc+hDV0Ch16pAIVx8=;
        b=BzBPcg6t7sZclssP1eva8ZrB0EyNlO2l1+JslaVfg4jPwx1dWYHGhcmemlXK/9g9KJ
         AvLwk8gKLSHs7a96sCn/Ac+3BXbKw6NPlmPkOwDtryoKoBcaIpo8qPZhaZGElAKueGOo
         EodStK3nzfyaZOVIC3kn3CA57NXk+2Q1QSBTV4YpRjO5g/GfzL2mefgfrpMm+4zTf9iD
         xApasdWuZEVK3nHKyV81QGWrzLyaq6R6Ls+wOnBlCEBjn1QHd+hQ8WTNfpQqg48BXpKA
         Eyk7X/skPTeL68mcd1OZtcVYZkKRLsd+Aqz83ywNBiXPtkiojHPXk7AEsryXIs8NGnPs
         DvVg==
X-Gm-Message-State: APjAAAUybhZDHmwHNKfquLfzCKO1PDgTcBXAyaiIR3Rz3bVeZzj8ygRT
        vn/0+Vnp5swyBG7gCszXJRAVJDzNr4Z9p/RRXaM=
X-Google-Smtp-Source: APXvYqzFn3/GrqRKNZvkx00c1IEVkavMQqVD3bsmosVh/pAKMxYWQGpWeG4KJBIjvx2zfhLykgaYfTgfx+KbKTMD1T4=
X-Received: by 2002:a63:dd58:: with SMTP id g24mr28476366pgj.161.1556526841661;
 Mon, 29 Apr 2019 01:34:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190426084038.6377-1-esben@geanix.com> <20190426084038.6377-2-esben@geanix.com>
 <20190426143946.GX9224@smile.fi.intel.com> <871s1og11u.fsf@haabendal.dk>
 <20190426215103.GD9224@smile.fi.intel.com> <87tvejakot.fsf@haabendal.dk>
 <CAHp75VfZMuQ3xagGSt6dXv1tZbSfanUdaw0SgjTqq3YET5YBKQ@mail.gmail.com> <87y33tz5oz.fsf@haabendal.dk>
In-Reply-To: <87y33tz5oz.fsf@haabendal.dk>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 29 Apr 2019 11:33:50 +0300
Message-ID: <CAHp75Vc6cLnLztXtvTcWisjAqDUTEWBBgv20CA34ZQmBEAvpbA@mail.gmail.com>
Subject: Re: [PATCH 1/2] serial: 8250: Allow port registration without UPF_BOOT_AUTOCONF
To:     Esben Haabendal <esben@haabendal.dk>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Darwin Dingel <darwin.dingel@alliedtelesis.co.nz>,
        He Zhe <zhe.he@windriver.com>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 29, 2019 at 9:27 AM Esben Haabendal <esben@haabendal.dk> wrote:
> Andy Shevchenko <andy.shevchenko@gmail.com> writes:
> > On Sat, Apr 27, 2019 at 12:01 PM Esben Haabendal <esben@haabendal.dk> wrote:
> >> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
> >> > On Fri, Apr 26, 2019 at 06:54:05PM +0200, Esben Haabendal wrote:
> >> >> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
> >> >> The reason for this patch is to be able to do exactly that (set port
> >> >> type and UPF_FIXED_TYPE) without having UPF_BOOT_AUTOCONF added.
> >> >>
> >> >> In the current serial8250_register_8250_port() there is:
> >> >>
> >> >>     uart->port.flags        = up->port.flags | UPF_BOOT_AUTOCONF;
> >> >>
> >> >> So, even though I set UPF_FIXED_TYPE, I get
> >> >> UPF_FIXED_TYPE|UPF_BOOT_AUTOCONF.
> >> >
> >> > Yes.
> >> >
> >> >> So I need this patch.
> >> >
> >> > Why? I don't see any problems to have these flags set.
> >>
> >> The problem with having UPF_BOOT_AUTOCONF is the call to
> >> serial8250_request_std_resource().  It calls request_mem_region(), which
> >> fails if the MFD driver already have requested the memory region for the
> >> MFD device.
> >
> > If it's MFD, why it requested the region for its child?
> > Isn't it a bug in MFD driver?
>
> It is a PCI driver, which calls pci_request_regions().  The PCI device
> carries a lot of different functions, which uses small slices of the PCI
> memory region(s).  With the resources being a tree structure, I don't
> think it is a bug when a parent driver requests the entire memory
> region.

If it's MFD driver, it's not its business to do something
child-related on child behalf.
In any case, Linux device resource model uses exclusive region
slicing. If you do like above, you call for a problems.

Btw, we have PCI MFD driver which enumerates 8250 (more precisely
8250_dw) w/o any issues.

> It would be nice if child drivers requesting memory would pass the
> parent memory resource.  Maybe 8250 driver could be changed to accept a
> struct resource pointer instead of a simple mapbase value, allowing to
> setup the resource with parent pointing to the MFD memory resource.

I don't see the problem in certain driver, I guess you are trying to
workaround existin Linux device resource model.

-- 
With Best Regards,
Andy Shevchenko
