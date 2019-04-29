Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D89EFC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 18:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A446C20675
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 18:31:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="g1qxiTTj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729054AbfD2SbM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 14:31:12 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:44213 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728844AbfD2SbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 14:31:12 -0400
Received: by mail-oi1-f196.google.com with SMTP id t184so6622391oie.11;
        Mon, 29 Apr 2019 11:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l92bR4EjGt+UpMrQV1OvZjmVnnjEn6tfuZ4aZIg95FI=;
        b=g1qxiTTjNipTpvxUNViX14Quw28skUobZiwTdIp/RwQzsWTCaiSep2uI8Ziay8jfvt
         6XWPHSRYJkAVPfNI0HzhwwBoJn4IOLm+2LXB9515jHSlsRnrexD86oRCA8660V+D1ph5
         oRDCxJ0w5AKpUmCj48u1mGT2/VQAaiereXvCGhECmPVCe+jssBGAE6xOKTsK+cC4JZBJ
         zrO0zG1ZJNb05Ep06O1lzIWfGI0FTXJJRBWDyCaLnKq71za+7Mm6ssBvwdwKVdKZABVu
         j4LQKLrABN+Fq2jwG8uGDhagTspAZT6CtyiH62nNKLaHrS3+w3vogMIWuuyEGppb6jmk
         rf0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l92bR4EjGt+UpMrQV1OvZjmVnnjEn6tfuZ4aZIg95FI=;
        b=atdfH4wzl5fCqScxvmQjDRXwKODoQKMolR8zYyMb1BtHDKtv/kWvwCqDKlcEaGLlg8
         tQ18uBc4SbC5BcXTjkjrZUl7lxGnHwkwQoDNKJX/2ZX9n6mTq+1EQqs//MG7g2O0p5qZ
         LnYULSP992VZuY/SOZC+fXMxBHvm3XlWoPzTT2Fe9SE/qAvLJV6RmjpqURwIl3QzUtsx
         LuTbYBDmArMSmNBjaDANxlDL1j169hwUy1SXAppkGGa+TPl3/2X4lMtD4PyMIRi7isYn
         ab2Fr695qOLF9ebPHl/VxAy4qy3IhQxYD1AzrTPvj1UYIjSGU8f8QuKV4psnozNrkzcS
         St4w==
X-Gm-Message-State: APjAAAW0v1YFzGF2t2qJxqL+c4axO2u03l7S8dK9yAqXtL9RbleGgQct
        Ai6uEjrF39bXncpTaMQ4yrVfrEYn1M+IX/Tb/nA=
X-Google-Smtp-Source: APXvYqzmWJXhhtCOuL3EHow8QQYVzhKBprAiCXPua0uRy7LXD8+lLKd9LD8mgmGiQfZyrfp0mqEvRNThwT8uqcISDRA=
X-Received: by 2002:aca:b68a:: with SMTP id g132mr310479oif.47.1556562671225;
 Mon, 29 Apr 2019 11:31:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190423090235.17244-1-jbrunet@baylibre.com> <20190423090235.17244-5-jbrunet@baylibre.com>
 <CAFBinCCf8fkBPR5aoPMensjhYKpan_UzG+HCEB5yNaYs+mB8OA@mail.gmail.com> <17c5978419c8778eb1f2c2a6e2aee66e864ac53d.camel@baylibre.com>
In-Reply-To: <17c5978419c8778eb1f2c2a6e2aee66e864ac53d.camel@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 29 Apr 2019 20:31:00 +0200
Message-ID: <CAFBinCCus5T7LvH7aTMYmc5gKoFkZFR-MCMGK8bSV_eAsu9Svw@mail.gmail.com>
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

On Mon, Apr 29, 2019 at 10:29 AM Jerome Brunet <jbrunet@baylibre.com> wrote:
>
> On Sat, 2019-04-27 at 22:02 +0200, Martin Blumenstingl wrote:
> > Hi Jerome,
> >
> > On Tue, Apr 23, 2019 at 11:03 AM Jerome Brunet <jbrunet@baylibre.com> wrote:
> > > At the moment, all our attempts to enable HS400 on Amlogic chipsets have
> > > been unsuccessful or unreliable. Until we can figure out how to enable this
> > > mode safely and reliably, let's force it off.
> > last year I have seen issues with HS400 on my Khadas VIM2: [0]
> > have you tested all other patches from this series and HS400 is still
> > not working for you?
>
> Because HS400 was never really stable to begin with.
> It was a mistake to enable it on the VIM2
>
> >
> > I'm curious because this patch is early in the series and all the
> > tuning fixes and improvements are after this patch.
>
> There are several reasons why this new tuning won't solve the HS400 problem:
> - Signal resampling tuning granularity gets worse when rate rises. The resampling
> is done using the input frequency. We can basically resample up to the value of
> internal divider.
>
> In HS200 - Fin is 1GHz, Fout is 200MHz (1/5) so the resample range is [0, 4]
> In HS400 - Fin should be fdiv5 (400MHZ) and in such case, no resampling is
>            possible (internal div = 1)
>            Even if we keep 1GHz, then out is 333MHz max giving a range of [0, 2]
>            that's not enough to tune
this limitation would be great to have in the description of patch 7
from this series

> Going further, tuning the Rx path does not make much sense in HS400 since we
> should be using the data strobe signal to account for the round trip delay of
> the clock and correctly sample Rx. AFAICT, If there is a tuning to be done for
> HS400, it is most likely linked to the data strobe.
it would be great to have a better description as part of the commit
message - with that you can add my:
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

my proposal for an update patch description (apologies I have
incorrectly summarized your findings):
"
At the moment, all our attempts to enable HS400 on Amlogic chipsets have
been unsuccessful or unreliable:
- signal resampling without delay adjustments and phase tuning for the
RX and TX clocks (this caused CRC errors and hangs even without HS400
mode, for example on the Khadas VIM, Khadas VIM2 and libretech-cc
boards)
- signal resampling without delay adjustments and RX clock phase
tuning (some HS200 and HS400 eMMC chips were not recognized, for
example on the Khadas VIM and Khadas VIM2 boards)
- signal resampling tuning with delay adjustments only (works fine for
HS200 and UHS modes but doesn't fix HS400 eMMC chips, for example on
Khadas VIM2)

Further improvements for the HS400 mode are likely to be linked to the
data strobe signal.
Until we can figure out how to enable this mode safely and reliably,
let's force it off.
"

This whole series is a good step forward.
also thank you for this additional explanation!


Regards
Martin
