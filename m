Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0156FC43215
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 20:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6F2120678
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 20:43:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbfKYUnq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 15:43:46 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33304 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbfKYUnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 15:43:46 -0500
Received: by mail-ot1-f68.google.com with SMTP id q23so8037064otn.0;
        Mon, 25 Nov 2019 12:43:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vkN17VKr1QonsL4KEkyHopuTh41vqxivJMdU6x1c6F8=;
        b=GxUPmvnOdIrCVOqOXI7sKzFlR8k8HZ0jF/9lZnTG+ut8Kk3KScfJdQXLtOph022tDn
         JXx1pxKm9XCQMS+vOnbVCWD4fuW42QE7oAmGRx+Ic2dnZiiGKxkbSYpiUySJKJX4f1JD
         1AG6Iv/12Cs9nq1ZRVtanIV0xLaXJFnbCilTRWjeF1Oo50vQMqTboidjVMnopRlMBDrL
         oaBVnEX/Y+02VsMkvWoJxqC3VRlmPnV/RiP/xCyp7KLZYERERakk5UkeDUjuitg0Tc/j
         0JzKAsP7RwNC3dxegaxfMOlowLdI6Jbi1h/YFg+Le/+oB3e76qDANCI3359av6i9eLkS
         UxTg==
X-Gm-Message-State: APjAAAXEDZSsSTGurLYr2zb7LQF0Efs/FflDZZWcV81jO9ZNxs112WqO
        kzT+BF9HVCWHb5QmLlr03tsT//3l/T8Oyshx+k/qLqCX
X-Google-Smtp-Source: APXvYqx7zhO+FIeXSjEth0eVOFf+CJ3kUYyafgplkB8JwQg5X9n0L7sXm2e57q/4uZZvCl18+4TpKc3rWwdbo7y/G4k=
X-Received: by 2002:a9d:2073:: with SMTP id n106mr11207489ota.145.1574714625036;
 Mon, 25 Nov 2019 12:43:45 -0800 (PST)
MIME-Version: 1.0
References: <1d7a1b3b-e9bf-1d80-609d-a9c0c932b15a@free.fr> <34e32662-c909-9eb3-e561-3274ad0bf3cc@free.fr>
 <20191125125530.GP25745@shell.armlinux.org.uk> <c7414301-da0d-cd4d-237d-34277f5ee1d2@free.fr>
 <20191125133752.GS25745@shell.armlinux.org.uk> <21c242a9-3599-3288-79bf-a8889fad2a73@free.fr>
In-Reply-To: <21c242a9-3599-3288-79bf-a8889fad2a73@free.fr>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 25 Nov 2019 21:43:33 +0100
Message-ID: <CAMuHMdXtnm25RFuLjnko0mYijgH-8J6KnQ+f1xo1PjBCKUvznQ@mail.gmail.com>
Subject: Re: [PATCH v1] clk: Add devm_clk_{prepare,enable,prepare_enable}
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On Mon, Nov 25, 2019 at 3:11 PM Marc Gonzalez <marc.w.gonzalez@free.fr> wrote:
> On 25/11/2019 14:37, Russell King - ARM Linux admin wrote:
> > On Mon, Nov 25, 2019 at 02:10:21PM +0100, Marc Gonzalez wrote:
> >> On 25/11/2019 13:55, Russell King - ARM Linux admin wrote:
> >>> It's also worth reading https://lore.kernel.org/patchwork/patch/755667/
> >>> and considering whether you really are using the clk_prepare() and
> >>> clk_enable() APIs correctly.  Wanting these devm functions suggests
> >>> you aren't...
> >>
> >> In that older thread, you wrote:
> >>
> >>> If you take the view that trying to keep clocks disabled is a good way
> >>> to save power, then you'd have the clk_prepare() or maybe
> >>> clk_prepare_enable() in your run-time PM resume handler, or maybe even
> >>> deeper in the driver... the original design goal of the clk API was to
> >>> allow power saving and clock control.
> >>>
> >>> With that in mind, getting and enabling the clock together in the
> >>> probe function didn't make sense.
> >>>
> >>> I feel that aspect has been somewhat lost, and people now regard much
> >>> of the clk API as a bit of a probe-time nuisance.
> >>
> >> In the few drivers I've written, I call clk_prepare_enable() at probe.
> >
> > Right, so the clocks are enabled as soon as the device is probed,
> > in other words at boot time. It remains enabled for as long as the
> > device is bound to its driver, whether or not the device is actually
> > being used. Every switching edge causes heat to be generated. Every
> > switching edge causes energy to be wasted.
> >
> > That's fine if you have an infinite energy supply. That hasn't been
> > discovered yet.
> >
> > Given the prevalence of technology, don't you think we should be
> > doing as much as we possibly can to reduce the energy consumption
> > of the devices we use? It may be peanuts per device, but at scale
> > it all adds up.
>
> OK, I'm starting to see the bigger picture.
>
> (To provide some rationale for the patch, I think devm is a huge
> improvement for probe error-handling, and I did not understand
> why every driver must do manual error-handling when dealing with
> clocks in probe.)
>
> I did envision kernel modules being loaded on an as-needed basis,
> somewhat side-stepping the energy-waste issue you point out.
> But I realize that such a use-case may be uncommon. (Especially
> due to module auto-loading.)
>
> A few months ago, I was discussing a similar issue with GKH:
> Consider a device with a "START" register. Basically, if we write 0,
> the device turns itself off; if we write 1, it runs as configured.
>
> I was trying to start the device only when at least one user had
> it "open". So I used reference counting, and started the device
> on 0->1 open transitions, and stopped the device on 1->0 close
> transitions. GKH told me that was the wrong way to do it, and IIRC
> suggested to start the device in probe.
>
> I probably misunderstood Greg's suggestion. Where is the right place
> to start/stop a device (or gate its clocks)?

In the device driver's Runtime PM callbacks?
In the Power/Clock Domain Controller driver?

See drivers/base/power/domain.c:genpd_{start,stop}_dev(), and how/when
it's called.

Embedded device driver writers typically care.
Server device driver writes typically don't.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
