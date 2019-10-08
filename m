Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A084ECE58E
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 07:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2912820640
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 07:28:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730359AbfJHH2p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 03:28:45 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:40412 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730180AbfJHH2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 03:28:45 -0400
Received: by mail-oi1-f195.google.com with SMTP id k9so13956354oib.7
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 00:28:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VOUMNagv9P9hJ7NaXTkQ2v/w3B4Id1uEWB1x07kNbxA=;
        b=tWFlAduxW9aAWWyOhGDQ7AO4Gy/uyaidup4lJ8zUULkVO6xCJcqKGO95YhnhLQUC3x
         lDjTxmrFkpqlV48Wk8WPVR4pTQDQHi0uArojbZM32OzVQndlcFAQ60EtJS3Tp3wN55tR
         Ta8sdcneGMdxDQ9qjAH/47HLCNjU2VrCuBSwTg8oHIkOE4hgSKyJU5eYn9AguD/jSqhn
         mk5VTpsU1+1A0VjmTfr9wAptQ/SldoR24soFkc4CSIZJweansPotF9qNTjToqQ2m18Vb
         bwzW+sw4RDPkk/xWXE5DUkYKwbiSaB0d9DW8ey/7k4fbAH/mSqVrnI+QVy29dVBiN6p0
         sVug==
X-Gm-Message-State: APjAAAWXgSllDsUmXwDw3iLQ6c6F1GrFvPUAs+FGl6DC0yDX8wTnG5dW
        EOYJZH0cDxtRLqlBNRRa92zh9vmGmpEAHKjrmNw=
X-Google-Smtp-Source: APXvYqzahe24u4uV7ZzRU6VFPTOTr8MCE69FS3FnSvr4PnpE1JfIIfHjRpwqh2W8B5Jmr9Lz/PffmLo1a/QO2/dytvo=
X-Received: by 2002:a54:4e89:: with SMTP id c9mr2592777oiy.148.1570519724241;
 Tue, 08 Oct 2019 00:28:44 -0700 (PDT)
MIME-Version: 1.0
References: <20191007071829.13325-1-geert@linux-m68k.org> <f0250c51-a653-6cac-9e6b-affa74d8559c@infradead.org>
 <CAMuHMdWSu00nfeQbE6hX7Ok=WZveiZ=i178Uhk3sgpF3k4Ax3Q@mail.gmail.com> <4ce1ecd0-4b90-f4f6-936b-ae2d756b08d5@infradead.org>
In-Reply-To: <4ce1ecd0-4b90-f4f6-936b-ae2d756b08d5@infradead.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 8 Oct 2019 09:28:33 +0200
Message-ID: <CAMuHMdUERaoHLNKi03zCuYi7NevgBFjXrV=pt0Yy=HOeRiL25Q@mail.gmail.com>
Subject: Re: Build regressions/improvements in v5.4-rc2
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Daney <david.daney@cavium.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

On Tue, Oct 8, 2019 at 1:41 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> On 10/7/19 2:04 PM, Geert Uytterhoeven wrote:
> > On Mon, Oct 7, 2019 at 10:48 PM Randy Dunlap <rdunlap@infradead.org> wrote:
> >> On 10/7/19 12:18 AM, Geert Uytterhoeven wrote:
> >>> Below is the list of build error/warning regressions/improvements in
> >>> v5.4-rc2[1] compared to v5.3[2].
> >>>
> >>> Summarized:
> >>>   - build errors: +10/-3
> >>>   - build warnings: +152/-143
> >>>
> >>> JFYI, when comparing v5.4-rc2[1] to v5.4-rc1[3], the summaries are:
> >>>   - build errors: +5/-10
> >>>   - build warnings: +44/-133
> >>>
> >>> Note that there may be false regressions, as some logs are incomplete.
> >>> Still, they're build errors/warnings.
> >>>
> >>> Happy fixing! ;-)
> >>>
> >>> Thanks to the linux-next team for providing the build service.
> >>>
> >>> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/da0c9ea146cbe92b832f1b0f694840ea8eb33cce/ (233 out of 242 configs)
> >>> [2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/4d856f72c10ecb060868ed10ff1b1453943fc6c8/ (all 242 configs)
> >>> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/54ecb8f7028c5eb3d740bb82b0f1d90f2df63c5c/ (233 out of 242 configs)
> >>>
> >>>
> >>> *** ERRORS ***
> >>>
> >>> 10 error regressions:
> >>
> >>>   + error: "__delay" [drivers/net/phy/mdio-cavium.ko] undefined!:  => N/A
> >>
> >> Hi Geert,
> >>
> >> What arch & config is the above build error from?
> >
> > That was a new one in v5.4-rc1 for sh-allmodconfig (blamed on David Daney).
>
> so it seems arch/sh/ needs include/asm/delay.h that at least does
> #include <asm-generic/delay.h>
>
> eh?

__delay() is an internal implementation detail on several architectures.

include/asm-generic/delay.h says:

    /* Undefined functions to get compile-time errors */
    ...
    extern void __delay(unsigned long loops);

drivers/net/phy/mdio-cavium.c calls __delay() directly to wait n "clocks",
which is not portable.  It should use one of [nmu]delay() instead.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
