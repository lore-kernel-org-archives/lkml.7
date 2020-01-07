Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14FD7C3F68F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 12:31:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE9902072A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 12:31:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FlGvyvi2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbgAGMbT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 07:31:19 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35604 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727806AbgAGMbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 07:31:18 -0500
Received: by mail-lf1-f67.google.com with SMTP id 15so38764609lfr.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 04:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9EebLSaihLU2tARTr8IPQ7uxTqO1LTm4gAhmzGy3UgE=;
        b=FlGvyvi2QPBrqo2r4Jue30+UaktwLcp+KLUSPcvRGN/2BaMLLxQCzspsz8Eq3GmLzd
         Nrv0IdyDSVVeZeRJza4UCzrDBLsJO3WK4lS8sWpZsaGTKZYL+exCo2xkiSf4lMrGxS3V
         O/HXc2S8gz3bmtLmHzxaW/sJdAR+nUuSDVQSB2asPTwuEA0IbNHvqBPIchofCxdcHcKS
         OEEy/3pGWuFBbaL7Ok/BcVMSr/M6v3ePO5J4A8TwSB4RBOQCo4bFWBIWtLcYJ9N6M89O
         Dyi019Lv6vQkQdGdoa8pwBQzbkx7n8LfuHI9rALcG/Fr6NzydOKxKMgMB7a4JajaCs9Y
         ydvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9EebLSaihLU2tARTr8IPQ7uxTqO1LTm4gAhmzGy3UgE=;
        b=JQX3e0YOmkdAD7Zkkh5J2jAGYXjaCGBys/dGlGbOU06K7EvFhdvuM/aYdn7c/g2mhs
         9vOK8mqSbYRFKrUGzpuIAmsZwbU5+zkosPWdsj0V4LNP04vTEJCRCZPvQpxBlw8aMxO1
         G/Rj6gr6TkU7wlC3azS18qnG7yDTZy0xzErBHj18CnfUMlW7svhjHmtM5Y4Z6aJ1zOPO
         dJekI9wjfio3GCoMHyLlC6pUdU+YsAqBBUWHWDJzRo1L4GgSlTqVNFaxAk7KyE/MCW+4
         pK/xlxtG9GHFt1WGclvuj4WZZtPm1biQ1LhFSwrZsT/YDW3bbhHv6TmyLxbvk8c+7EQb
         j/Zw==
X-Gm-Message-State: APjAAAXJXTycsFXzNhlixMXkw6qnMZbJ85ZXyn6jJdqFVWJhQ2p3m43H
        HPn6SrQ+iXjObO/kP++6/dcp09c4RNsKaGPBQr4Qhg==
X-Google-Smtp-Source: APXvYqyBuRwxF96vFYNvlrUvjUjmWThDAJPetB+s1J0E1Mz7v2ejmMMutsemtESFHjYL7jQnTSsmSoWiKAwaDs6P7Qs=
X-Received: by 2002:ac2:4945:: with SMTP id o5mr58501816lfi.93.1578400276043;
 Tue, 07 Jan 2020 04:31:16 -0800 (PST)
MIME-Version: 1.0
References: <20191129191023.2209-1-miquel.raynal@bootlin.com> <CAHp75VeJNZWz_Cv=dozAwt74OBu8TgyYe5bNU3sHreRMdqxR8A@mail.gmail.com>
In-Reply-To: <CAHp75VeJNZWz_Cv=dozAwt74OBu8TgyYe5bNU3sHreRMdqxR8A@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 7 Jan 2020 13:31:04 +0100
Message-ID: <CACRpkdYsE8e4LfYkiaYyqdcPsgg6r4pqzHKwqUBveoLou_hSnw@mail.gmail.com>
Subject: Re: [PATCH v4] gpio: pca953x: Add Maxim MAX7313 PWM support
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-pwm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2019 at 10:51 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Fri, Nov 29, 2019 at 9:13 PM Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> > The MAX7313 chip is fully compatible with the PCA9535 on its basic
> > functions but can also manage the intensity on each of its ports with
> > PWM. Each output is independent and may be tuned with 16 values (4
> > bits per output). The period is always 32kHz, only the duty-cycle may
> > be changed. One can use any output as GPIO or PWM.
>
> Thanks for an update!
>
> Still I think it's wrong approach. What should be done is:
>  - adding a pin configuration type of PWM (when, for example, argument
> defines duty cycle and period)
>  - conversion to pin control of this driver
>  - enabling pin configuration PWM for it.
>
> For now it looks like a custom way of doing it.
> If GPIO maintainers are okay with it, I'll not object, just want to
> have than something like TODO updated for the matter.

Yeah well that is a possible way, it pretty much lies with the PWM
maintainer, I have one guiding stanza "rough consensus and running
code". Making big upfront code conversions just to get a small piece
of hardware going is just too much from me as subsystem maintainer,
a dual sub-system driver is perfectly fine in my opinion.

That said contributors are encouraged to extend scope and be
ambitious and set precedents for others to follow by going the extra
mile.

(That sounds like corporate management!)

But that must be voluntary work outside the scope of just hardware
enablement.

Yours,
Linus Walleij
