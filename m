Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F15B3FA372B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 12:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA8D62168B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 12:53:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TsPMzUgW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391519AbfJPMxw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 08:53:52 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45174 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389781AbfJPMxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 08:53:51 -0400
Received: by mail-qt1-f194.google.com with SMTP id c21so35830207qtj.12
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 05:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P/sRs2+kPjcvwd2trmOBWPVdM0AxawvVsZ+s8sAO7/4=;
        b=TsPMzUgWcdtdkasHhYq577HFiCkshIqaxslChEP+do1RFpTIxW2jQRhCLSPwbd5x8i
         U7niU6BZWK/agFFkyA+6MFgZbwkW60EosnfY+llAQGBocfTcp4KRF8J/zJn8tfy+Xn4R
         ND/tIJ4q5KZ7QKtwldwq2k59a5s7at2G3Hi8BXC6iZm33w3oVf21uxvJWvsoT6eTs4Vn
         WDL+yMSxQwFiUsYSJ7A7I+v43eHl0YHYHoIzhjWanzIpiZ7RpplDgnbKGyR9Qf/+l5dt
         /jBMTe3E/dc+CJIqaHslN4E+fQmzn4yXKprR+7pYhIDJP/ZUFpJZXfCOGoH5zVOCAejO
         Ui3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P/sRs2+kPjcvwd2trmOBWPVdM0AxawvVsZ+s8sAO7/4=;
        b=aiSfGt+PF7ApkASlBqEnWisoc+3TNgT/gdh4iaCYThWPCHdIT2/HbXoGBuWe5lKc3G
         /qdhsc+RWv1VtwaOW9ld6UTI4P+AdM0hD1X+axSMo5uPwBUR3LLJ0cgXgQ5EPnrJhY1k
         pJoHCNCiaVwaGyOPsNmufYP/2ckpHpFp56jThcqsYiPYVGZ5CESkKiFxoN55ODV9vvtS
         zuXnFhYD8jTluLYBWq9onc6roWZ6OUVI8zlqbfxu+PMMs7gyYK85nn3kC9hPz+Gq3sbC
         rUKEFc0mYocP3iYgXVlwLxcLzkdbGjjT+4ixCZCJR5H2uPGHEnE5azmFAxZA74kO4Sth
         hL+w==
X-Gm-Message-State: APjAAAUmjywmR54Taj/hrZiE958tzIj9te79rEBEruwFPLYEmkp+PAq5
        yVQp0ql0e4iWk7Al4D8D77/VnoGiTvJNU5Fs/7wmpg==
X-Google-Smtp-Source: APXvYqxRmpmcyaCxmLmkEi0JWpxgYlv/RpJs/yNT3A1lP3hXCkiugyGea31zdLuV3cm9n/Bm5GfFph4HfEVVYNrBVag=
X-Received: by 2002:ac8:3ac6:: with SMTP id x64mr33736244qte.51.1571230430797;
 Wed, 16 Oct 2019 05:53:50 -0700 (PDT)
MIME-Version: 1.0
References: <20191004012525.26647-1-chris.packham@alliedtelesis.co.nz>
 <20191004012525.26647-3-chris.packham@alliedtelesis.co.nz>
 <CACRpkdYWLTjiSQo_VTeReL1CfEO3h_8ONbdCk=PD1x+oc2ggCg@mail.gmail.com> <628c495994a0648d956bc663ea8fdcfa6f439802.camel@alliedtelesis.co.nz>
In-Reply-To: <628c495994a0648d956bc663ea8fdcfa6f439802.camel@alliedtelesis.co.nz>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 16 Oct 2019 14:53:39 +0200
Message-ID: <CACRpkdb8o9UU0W1FJ4=KYiV3CUEUkXbR4CFY7XKdJG2O8sSJFA@mail.gmail.com>
Subject: Re: [PATCH 2/2] gpio: Add xgs-iproc driver
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "bcm-kernel-feedback-list@broadcom.com" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "rjui@broadcom.com" <rjui@broadcom.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Richard Laing <Richard.Laing@alliedtelesis.co.nz>,
        "sbranden@broadcom.com" <sbranden@broadcom.com>,
        "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2019 at 12:08 AM Chris Packham
<Chris.Packham@alliedtelesis.co.nz> wrote:
Me:

> > I think this should be a chained interrupt handler (see below how to
> > register it).
> >
> > See e.g. drivers/gpio/gpio-ftgpio010.c for an example:
> > change function prototype, no return value, use
> > chained_irq_enter/exit(irqchip, desc); etc.
> >
>
> I don't think a chained interrupt handler can work. The problem is that
> the parent irq on the SoC is shared between the gpio and uart0 (why
> it's this way with two IP blocks in the same SoC I'll never know). When
> a chained interrupt handler is registered I lose the serial interrupts.
> Please correct me if there is some way to make the chained handlers
> deal with sharing interrupts.

Aha I see. Look at:
drivers/gpio/gpio-mt7621.c

And how that driver sets the parent handler to NULL in order
to still exploit the core helpers.

I will refactor this to some more elegant API at some point when
I get there, for now follow the example of mt7621.

Yours,
Linus Walleij
