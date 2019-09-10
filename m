Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D271EC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 08:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF48921479
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 08:00:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730374AbfIJIAD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 04:00:03 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41417 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727205AbfIJIAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 04:00:02 -0400
Received: by mail-ot1-f66.google.com with SMTP id g16so1899804otp.8;
        Tue, 10 Sep 2019 01:00:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7L737Jm0wUHbnu/Pe3llxROQ1ln1ETh1uPMKDGHXXWU=;
        b=pAuKv2uWe68+OrEJZBhOgjxmqrDUBSvzSEwaSkY1o+XBhpoNCU8rrWJ1wwyvjywpYO
         MIztXBiT3XlvB8bB4e0XsglqlbJww1dWL8jSs8Ewln6mSsBdhFtfh/RiSM1GyZy7AL5L
         bcaF6ilFQmRxXkola8ZjuS397fYcGxhtd4/B8NgT8Ng8ws7SK5l18/gfTYYFsDB+ZKhG
         PzRSnnfd2Y8FzByrbMSHbRdkrmaWisX9dxaHKULLwAuu9GSpbvuUvSWjLbaUkTx34vGI
         iSGNAaAzcpHONTRXhdpXn2UcnTXLhbx8Q8c2P3Cyzb7A5unTq1sgXfeOH+i3ZAFEDyRP
         uA0A==
X-Gm-Message-State: APjAAAXXIr4P6qghoItD0Xt4nMsR/ZRa44gtDSBbYSpkfFJvbQaoqcnZ
        bklt7SYly/+c4037voUoMvhm8qNwK0UTHqLDNJhvfF/I
X-Google-Smtp-Source: APXvYqx+ZYhRUi69F2qvCMAq3GzxxBTk+IErSzk0oKplNMkzm1lwOtKf9GkZhd5n8JtQlhUnVL2qrnsx8/SENkFM0f0=
X-Received: by 2002:a9d:32a1:: with SMTP id u30mr19940081otb.107.1568102401646;
 Tue, 10 Sep 2019 01:00:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190909012605.15051-1-srrmvlt@gmail.com> <20190909095625.GB17624@kroah.com>
 <20190909115006.GB3437@sreeram-MS-7B98>
In-Reply-To: <20190909115006.GB3437@sreeram-MS-7B98>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 10 Sep 2019 09:59:50 +0200
Message-ID: <CAMuHMdXz568p=GFJmz6MfuxDxA_QkLMrGcK2hG3C99ReL1fH5A@mail.gmail.com>
Subject: Re: [PATCH] FBTFT: fb_agm1264k: usleep_range is preferred over udelay
To:     Sreeram Veluthakkal <srrmvlt@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        driverdevel <devel@driverdev.osuosl.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        nishadkamdar@gmail.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        payal.s.kshirsagar.98@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sreeram,

On Tue, Sep 10, 2019 at 2:25 AM Sreeram Veluthakkal <srrmvlt@gmail.com> wrote:
> On Mon, Sep 09, 2019 at 10:56:25AM +0100, Greg KH wrote:
> > On Sun, Sep 08, 2019 at 08:26:05PM -0500, Sreeram Veluthakkal wrote:
> > > This patch fixes the issue:
> > > FILE: drivers/staging/fbtft/fb_agm1264k-fl.c:88:
> > > CHECK: usleep_range is preferred over udelay; see Documentation/timers/timers-howto.rst
> > > +       udelay(20);
> > >
> > > Signed-off-by: Sreeram Veluthakkal <srrmvlt@gmail.com>

Thanks for your patch!

> > > --- a/drivers/staging/fbtft/fb_agm1264k-fl.c
> > > +++ b/drivers/staging/fbtft/fb_agm1264k-fl.c
> > > @@ -85,7 +85,7 @@ static void reset(struct fbtft_par *par)
> > >     dev_dbg(par->info->device, "%s()\n", __func__);
> > >
> > >     gpiod_set_value(par->gpio.reset, 0);
> > > -   udelay(20);
> > > +   usleep_range(20, 40);
> >
> > Is it "safe" to wait 40?  This kind of change you can only do if you
> > know this is correct.  Have you tested this with hardware?
> >
> > thanks,
> >
> > greg k-h
>
> Hi Greg, No I haven't tested it, I don't have the hw. I dug depeer in to the usleep_range
>
> https://github.com/torvalds/linux/blob/master/kernel/time/timer.c#L1993
>         u64 delta = (u64)(max - min) * NSEC_PER_USEC;
>
>  * The @delta argument gives the kernel the freedom to schedule the
>  * actual wakeup to a time that is both power and performance friendly.
>  * The kernel give the normal best effort behavior for "@expires+@delta",
>  * but may decide to fire the timer earlier, but no earlier than @expires.
>
> My understanding is that keeping delta 0 (min=max=20) would be equivalent.
> I can revise the patch to usleep_range(20, 20) or usleep_range(20, 21) for a 1 usec delta.
> What do you suggest?

Please read the comment above the line you're referring to:

 * In non-atomic context where the exact wakeup time is flexible, use
 * usleep_range() instead of udelay().  The sleep improves responsiveness
 * by avoiding the CPU-hogging busy-wait of udelay(), and the range reduces
 * power usage by allowing hrtimers to take advantage of an already-
 * scheduled interrupt instead of scheduling a new one just for this sleep.

Is this function always called in non-atomic context?
If it  may be called in atomic context, replacing the udelay() call by a
usleep*() call will break the driver.

See also "the first and most important question" in
Documentation/timers/timers-howto.rst, as referred to by the checkpatch.pl
message.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
