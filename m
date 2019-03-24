Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56AF4C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 12:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21AE3222D0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 12:31:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HX862r8o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728725AbfCXMbX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 08:31:23 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44779 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbfCXMbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 08:31:23 -0400
Received: by mail-pf1-f194.google.com with SMTP id a3so4475293pff.11;
        Sun, 24 Mar 2019 05:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7iF0xLcGisMhpuy7zuhkEz0Y0tZ4OqFlr4oj1gxhfIM=;
        b=HX862r8ofo+FGxQm+h8Mf+AyTKJi0iMtasDOO+MUm0RpsRB5pce/61loHvN2dDarLY
         8SkqAU2LCJeKw55u1hEU8HXEpTPX7WkbB1sl/8O+HzuOre4URm91hDriKRvkkgUDbetL
         N3KBgPiqkl9Q7AitXhRscz42P+P8tPH5mK8Kk2mPCC2r6r5AA2f++t5M7Cf0in5i44ad
         pg+s5T4taW4AKy3uG1LFEjqHvJd8+lbhdcTLSfz5aQbilTHqe1YpvTLvzo487yayR/l7
         bhuQZjMmdsbjyMF9WmRB2KFdXYzBNOPmlGKWHdDSBTsPKqnNH17Zy+rQU9CLW3yOUV5b
         Y2nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7iF0xLcGisMhpuy7zuhkEz0Y0tZ4OqFlr4oj1gxhfIM=;
        b=Kf3mliVjLSs5fV/rMGrPaKeDU18qIoOiSiBvrlSKrcI6nYDqw2HiAcgQdreAf5WPby
         7gkENARJoxHDW3p5ixdX5TWH+5iHfCnm99RREF9A9Enbh2KSXtd6aJs9d5KHzhNhh1fe
         Ta61ZnaDVKBS01dXQBeOKHidrUHO5GOX2i5J7TJfrTOQGS6khOlaaxxty+bTD/4JHrFA
         aLtkyKLA60KjCH5gAEefArF25ucmYbiXpqNK019AeO1NIwxY0T0LZtLEkjegxRFzrzX0
         p7iGTnm16YhVBC/bflYJo5AdZEpAJCrkeHlCh0+cDo3TQKq2cCVYktY6GkMLkop1Xp36
         gNlA==
X-Gm-Message-State: APjAAAX9a5rhzFbbUXf2WToXjUtRdXU/VYfLELeYvawZIigbPvW7aGWM
        4KvTjqBPXENgEIk/oBmZmBWWvuyTu2ah0Qf21SI=
X-Google-Smtp-Source: APXvYqzqsjYzIB8Gue+ueZHBIzTQIolaysO+oTYKVzbMpirhD4Z0uVF1wMoInK/S6++H4s8WvAw7alwQzQOX/HVdb64=
X-Received: by 2002:a63:b902:: with SMTP id z2mr18850693pge.428.1553430682297;
 Sun, 24 Mar 2019 05:31:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190323225313.12325-1-pakki001@umn.edu> <CAHp75VdeB=jPaqY_VNDA7YeCiEdyVFJAmOmC4sDvZLBv-7KQ0w@mail.gmail.com>
 <CAHp75VfbPue803w06GdJwU_JYcFKEcShLpyGRMhOg9xi4ZwpAA@mail.gmail.com>
In-Reply-To: <CAHp75VfbPue803w06GdJwU_JYcFKEcShLpyGRMhOg9xi4ZwpAA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 24 Mar 2019 14:31:11 +0200
Message-ID: <CAHp75VeyL-G9i=ABg8r6R7+oBBYRDM82L2-jFEm1uK0-136aMw@mail.gmail.com>
Subject: Re: [PATCH v2] tty: 8250: fix a missing check for pci_ioremap_bar
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     Kangjie Lu <kjlu@umn.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Vinod Koul <vkoul@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 24, 2019 at 2:26 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Sun, Mar 24, 2019 at 2:05 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Sun, Mar 24, 2019 at 12:55 AM Aditya Pakki <pakki001@umn.edu> wrote:
> > >
> > > pci_ioremap_bar could fail. The fix captures the failure and
> > > pass an error code upstream. This can avoid potential NULL
> > > pointer dereferences in the future.
> > >
> >
> > NAK.
> > This will break non-DMA case.
>
> > > @@ -172,12 +172,14 @@ static void qrk_serial_setup_dma(struct lpss8250 *lpss, struct uart_port *port)
>
> Just to clarify, what you need is simple
>

> void __iomem *regs;

Sorry for leftover.

> chip->pdata = ... //move it here for better looking code
> chip->irq = ...

> chip->regs = pci_ioremap_bar(...);

And looking into the code it needs pci_iounmap() on exit one.

> if (!chip->regs)
>   return;
>
> and thank you for pointing to this.

-- 
With Best Regards,
Andy Shevchenko
