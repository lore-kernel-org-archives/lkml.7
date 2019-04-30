Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A45C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 20:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED1F42080C
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 20:02:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Yd6dh8YO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbfD3UCk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 16:02:40 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:41434 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbfD3UCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 16:02:40 -0400
Received: by mail-oi1-f194.google.com with SMTP id v23so12159825oif.8;
        Tue, 30 Apr 2019 13:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3r147tIwezgftcMqyv0BTWw1GGds2ZC5ylXTysMayJ0=;
        b=Yd6dh8YODaH840dtnqB8JIV0ku0Zs+HUzPE4xdGMwqhIyvdVx0ZwwoCz/cYZK4bZY7
         xTu677WYvvlU6yyq40DjghNCsKGr9UrNi6tynsVXL/IteW3aeOJVSxUg9c7SIRP0JC6K
         EGhqpYHFIFXbqdLC+YA9bR3PG2CdFwFEbAaKD0BNVNXjLlINmwyn8uC8kzQ0YIlqmlmb
         bm/sPNemBW7unwnpv37VGvMzXN+AAIEQUYj0hd4ekUmLEpS6erbEeVlfDKV/pCSwRVZQ
         mApszl2ASCmOfR0VkUK4+TLYr2DjvYnzzU9zFF+iPtYcHf+BK8v02E1kbrOEQZxuVOK/
         q8eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3r147tIwezgftcMqyv0BTWw1GGds2ZC5ylXTysMayJ0=;
        b=Yz68I+Qv/ADaZ5mtpoKxTtI+DRJ6TWO33pfuIKLyLBRyKUtHQ/cEtOxmaCP1HZRGYu
         lMJFanOslnZl/t4+xVKumZ3PSwu0MgwCttcyNhBOoMLE+tCdQwE6dG2kE7fLKq93CNjv
         dNJ0DI7UQO/l3EIAfd1VquZRsHvc2jgu8CzgcUIn3rA/KSV/D313/YQNdO4lNXHzgumJ
         AG/mii1wzsdPPmND4TyD1YUmfKnOsHxM0MOYtDKOUud6gfLGdGG01Jel2CWn9tVorqcV
         bWnG2MY6K35aJ3ftcQZ8K0xptFn5870my7DmWXLaMrMJECFdqqIHtFmKgl0H/Xt1aMbx
         PR+A==
X-Gm-Message-State: APjAAAWT9UTxwlD2U3kSITUC4ycGZRahO/qrqH4rmTi7ZZZDKX1AXBFX
        Axm4BodwK2BvKmKeaBqcdFB/+xGZK6tCvd+88G4=
X-Google-Smtp-Source: APXvYqwDdmSQ1hWlPEYCDngS4jp/HbPyU07MOy4Ce9TcozyHCzgare4Eydcg5I08aewFi4Jb4cXyXvgfpEdZ63bO/j4=
X-Received: by 2002:aca:4482:: with SMTP id r124mr4474985oia.39.1556654558796;
 Tue, 30 Apr 2019 13:02:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190423090235.17244-1-jbrunet@baylibre.com> <20190423090235.17244-5-jbrunet@baylibre.com>
 <CAFBinCCf8fkBPR5aoPMensjhYKpan_UzG+HCEB5yNaYs+mB8OA@mail.gmail.com>
 <17c5978419c8778eb1f2c2a6e2aee66e864ac53d.camel@baylibre.com>
 <CAFBinCCus5T7LvH7aTMYmc5gKoFkZFR-MCMGK8bSV_eAsu9Svw@mail.gmail.com> <936229765eac2bcdacf9a53925bb17c38ea18e3a.camel@baylibre.com>
In-Reply-To: <936229765eac2bcdacf9a53925bb17c38ea18e3a.camel@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 30 Apr 2019 22:02:27 +0200
Message-ID: <CAFBinCBpujeLJHr0x9DxqLtRiLt0WLkkOoKcJuh3baWeg_bFeA@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] mmc: meson-gx: disable HS400
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerome,

On Mon, Apr 29, 2019 at 8:50 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
>
> On Mon, 2019-04-29 at 20:31 +0200, Martin Blumenstingl wrote:
> > Hi Jerome,
> >
> > On Mon, Apr 29, 2019 at 10:29 AM Jerome Brunet <jbrunet@baylibre.com> wrote:
> > > On Sat, 2019-04-27 at 22:02 +0200, Martin Blumenstingl wrote:
> > > > Hi Jerome,
> > > >
> > > > On Tue, Apr 23, 2019 at 11:03 AM Jerome Brunet <jbrunet@baylibre.com> wrote:
> > > > > At the moment, all our attempts to enable HS400 on Amlogic chipsets have
> > > > > been unsuccessful or unreliable. Until we can figure out how to enable this
> > > > > mode safely and reliably, let's force it off.
> > > > last year I have seen issues with HS400 on my Khadas VIM2: [0]
> > > > have you tested all other patches from this series and HS400 is still
> > > > not working for you?
> > >
> > > Because HS400 was never really stable to begin with.
> > > It was a mistake to enable it on the VIM2
> > >
> > > > I'm curious because this patch is early in the series and all the
> > > > tuning fixes and improvements are after this patch.
> > >
> > > There are several reasons why this new tuning won't solve the HS400 problem:
> > > - Signal resampling tuning granularity gets worse when rate rises. The resampling
> > > is done using the input frequency. We can basically resample up to the value of
> > > internal divider.
> > >
> > > In HS200 - Fin is 1GHz, Fout is 200MHz (1/5) so the resample range is [0, 4]
> > > In HS400 - Fin should be fdiv5 (400MHZ) and in such case, no resampling is
> > >            possible (internal div = 1)
> > >            Even if we keep 1GHz, then out is 333MHz max giving a range of [0, 2]
> > >            that's not enough to tune
> > this limitation would be great to have in the description of patch 7
> > from this series
>
> That's not really a limitation. I should probably not have mentioned as it it seems to
> have made things even more unclear. I disabled HS400 before introducing the new tuning on
> purpose. Any comment regarding hs400 does not belong in patch 7 IHMO. If you want
> to add comment regarding hs400, I think it belongs here
>
> >
> > > Going further, tuning the Rx path does not make much sense in HS400 since we
> > > should be using the data strobe signal to account for the round trip delay of
> > > the clock and correctly sample Rx. AFAICT, If there is a tuning to be done for
> > > HS400, it is most likely linked to the data strobe.
> > it would be great to have a better description as part of the commit
> > message - with that you can add my:
> > Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> >
> > my proposal for an update patch description (apologies I have
> > incorrectly summarized your findings):
> > "
> > At the moment, all our attempts to enable HS400 on Amlogic chipsets have
> > been unsuccessful or unreliable:
> > - signal resampling without delay adjustments and phase tuning for the
> > RX and TX clocks (this caused CRC errors and hangs even without HS400
> > mode, for example on the Khadas VIM, Khadas VIM2 and libretech-cc
> > boards)
> > - signal resampling without delay adjustments and RX clock phase
> > tuning (some HS200 and HS400 eMMC chips were not recognized, for
> > example on the Khadas VIM and Khadas VIM2 boards)
> > - signal resampling tuning with delay adjustments only (works fine for
> > HS200 and UHS modes but doesn't fix HS400 eMMC chips, for example on
> > Khadas VIM2)
> >
> > Further improvements for the HS400 mode are likely to be linked to the
> > data strobe signal.
> > Until we can figure out how to enable this mode safely and reliably,
> > let's force it off.
> > "
>
> Thanks for effort but all this just maintain the blur around HS400 on amlogic.
>
> Let me rephrase it:
> Tuning (phase or resampling) is meant to compensate the clock round trip in UHS
> and HS200 modes. In HS400, this should be taken care of by the data strobe.
> But we have not been to enable this reliably enable this on amlogic chipset ...
I wasn't aware of this: so far I assumed that we're not setting the
phase correctly, end of the story.
thank you again for taking your time to explain this!

> ... and I believe we are back to the original commit message.
no need to update the description just to explain how HS400 works in
general, so feel free to use my:
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>


Martin
