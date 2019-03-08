Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54810C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 09:14:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FCFF20811
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 09:14:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbfCHJOM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 04:14:12 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:44687 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbfCHJOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 04:14:12 -0500
Received: by mail-vs1-f67.google.com with SMTP id r201so6246481vsc.11;
        Fri, 08 Mar 2019 01:14:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9eTzoH/V7S05omP1ya/3X36AlsCFukZZfmqHw92DzTU=;
        b=oiQBcPFZaQkbwUqjAdFT1LRYksLVAJRZ/JsxozA5VbyVEwBdH/8WbAaen0khKMFDD+
         k4RPZz9X6XfZTPONz61TLbgi8arEvu1l6zRYDrH/2xdT2utnZnLtAYsapVjHRuDYc9L5
         N+bcMBehxM0FFdWmLlzHLTWkd4HDApp9OFNXNEM4BGeEcldGAu7mYEUwKWGMEIVAGUQe
         sSzWT5F1gf5Qoo86zvvdiXGAX8CTVZVO1mT3OBQuifEqh0KCdLSX761uX0wvAS0lRz4U
         nfF7GEFpmisKjFHj36RijjWstrh2QuYv4xsDuA1uWdW+sQemL3vUZcTLrl+3ZstPLbnz
         Z+Qg==
X-Gm-Message-State: APjAAAU5bH8NC0UO86DjeL8wlUnU+Z5FaLv9EczoeXcex8KgslGyDpvz
        lwUR3hkK7Ukq8aOD3DrYiMMJZMNFp/grlIOSUGI=
X-Google-Smtp-Source: APXvYqwJnUpk+Uhpc+EE1StLOcSwn1nikpkgegnb37/QH3Ice+aRM/tcJfJhvUkh9hf562dcG2MamxaVQuC1pO3IFCU=
X-Received: by 2002:a67:fc9a:: with SMTP id x26mr9373095vsp.166.1552036451298;
 Fri, 08 Mar 2019 01:14:11 -0800 (PST)
MIME-Version: 1.0
References: <20190307051641.GA7012@localhost.localdomain> <871s3jm532.fsf@intel.com>
 <CAMuHMdU_+4_T4B67Z-Y-wgHQs6o1yuh9H4m82Lym+_Jno5Mgzg@mail.gmail.com> <20190307213759.GA14798@localhost.localdomain>
In-Reply-To: <20190307213759.GA14798@localhost.localdomain>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 8 Mar 2019 10:13:58 +0100
Message-ID: <CAMuHMdVnkdrUTL_3UaoaOondGxCB_FpEYOTDmLeh1C0W5j0-Hw@mail.gmail.com>
Subject: Re: Is it possible to reset graphics controller on reboot in a
 framebuffer driver?
To:     Tom Li <tomli@tomli.me>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tom,

On Thu, Mar 7, 2019 at 10:38 PM Tom Li <tomli@tomli.me> wrote:
> On Thu, Mar 07, 2019 at 10:39:23AM +0100, Geert Uytterhoeven wrote:
> > On Thu, Mar 7, 2019 at 10:00 AM Jani Nikula <jani.nikula@linux.intel.com> wrote:
> > > It's possible to do this using a reboot notifier. I am not sure if there
> > > are better ways to achieve the same, but there's at least one example of
> > > using reboot notifiers to achieve the exact same goal.
> > >
> > > See drivers/video/fbdev/aty/atyfb_base.c, look for
> > > register_reboot_notifier().
> >
> > Or a shutdown handler, which is more device-centric?
> > (cfr. "[3/4] fbdev: atafb: Fix broken frame buffer after kexec",
> >  https://patchwork.kernel.org/patch/10814381/).
> >
> > Gr{oetje,eeting}s,
>
> Thanks, I knew reboot_notifier but I thought it feels "hacky" to use it in a
> device driver, shutdown() handler looks better.
>
> Nevertheless, does it mean there's no way to prevent it from happening if the
> user issues a emergency reboot? Like an automatic reboot after a kernel panic,
> or a SysRq-B reboot.

If Linux performs a reboot, it calls the shutdown handlers.
I think that includes reboot on panic, or SysRq-B, but I'd have to check to
be 100% sure.

If the kernel just crashes, of course all of that doesn't happen.
Is your graphics card reset when the reset button is pressed, or only on
cold power on?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
