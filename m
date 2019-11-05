Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 791A0C5DF69
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 15:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FCA721D71
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 15:05:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kpd/leYt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731122AbfKEPFV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 10:05:21 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35570 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731110AbfKEPFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 10:05:20 -0500
Received: by mail-lj1-f193.google.com with SMTP id r7so13541971ljg.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 07:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tavTtm1Xo4MtMh/aOcywS9fElRJcgy1KkS7iJZf+I0o=;
        b=Kpd/leYtPpqiEDbCJj18CuAu27YXg/BuaSVf6IXKy+NrpoBVTZePZog5GdYjJO9OIi
         lm4PNz+RaMr2Nrhy8ku0aUXAC05hBbP1JME/FecqDMlBqkYlECiTGsIez1dWe0BBadLu
         LIVKVjgIW0dw84EB2IjEb0twsx3ASPulZkaAWUIj7h8A2FrFsvuaKTSpTx53DmZ3nq1U
         QNl8wl6y+nYyPwwlsv+q+D2D2+kZtdPPBtrFK7uj0fyltIejYU1J9AlQptT6e9xIT+GN
         cLdhsevHXm//qojXfBav6e4dmTJYwtN6Khfo7QLgxUZWvK7zFuFqhWgAr3N+IqYgTJYh
         VR7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tavTtm1Xo4MtMh/aOcywS9fElRJcgy1KkS7iJZf+I0o=;
        b=KrMQd5sEI7LZoV4vm9C4IafValuRf6WfQWD72mnPuDMuTtU44oZToV6Bjxeq1SgIsQ
         RZ0UQmZHytIUUdb23+Vg5g3JmYqbqU8qn90ivyS1IcfcUFH8J+yLiTHshozyOlEJFbet
         QVdkyHDkIXMrOY4CRHedSxzOgsTQ8RwGZltXQuWDDK90pUnWdDlnHpBNwPiE/4vsGF9A
         Wjlipp/4IuOidm6Xu6ssHGQuLqAh/dVWUGQ64IerpLMv1Sq/z9jp9j4ZsoHf1dxBZn1s
         ZcZjxY5g9qnWTKlc4KWGisqUT7iMIt9eD0ncA19bOgeA1t2whTkXDF+eHOrju/owy/8k
         NM/A==
X-Gm-Message-State: APjAAAUI9O4N/5MIwFweunUIoFsiaKoM886H0EcdedtqJUVlUcttIIvA
        HSEqzqXg4D1XbY8V/jg3f74aDcXhgvVP99LWotPIHQ==
X-Google-Smtp-Source: APXvYqzg3Toe5ibsBNy4vSKkIj+jEh4yXX7QFUnejT5ioVLHdggVbJujZP6cuxOj2IbLJbzwc/uzWBBvO38pMmBvRbs=
X-Received: by 2002:a05:651c:1202:: with SMTP id i2mr23543161lja.218.1572966318371;
 Tue, 05 Nov 2019 07:05:18 -0800 (PST)
MIME-Version: 1.0
References: <cover.1572606437.git.matti.vaittinen@fi.rohmeurope.com>
 <f08d265c12ebf185c0e1dbbfe0a3f86de4907194.1572606437.git.matti.vaittinen@fi.rohmeurope.com>
 <CACRpkdYhasTEQq2btQ_3GSo=hMJetp128jFo-6hE=JMeX4MJSA@mail.gmail.com> <411ac5e107cd2a6c628d1fb46e7d284c8f594768.camel@fi.rohmeurope.com>
In-Reply-To: <411ac5e107cd2a6c628d1fb46e7d284c8f594768.camel@fi.rohmeurope.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 5 Nov 2019 16:05:05 +0100
Message-ID: <CACRpkdaRt3Du4y_Yhv39d7KoQ=hOkPR-RqXYjPukxb7JG_yymQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 14/15] gpio: Add definition for GPIO direction
To:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Cc:     "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
        "dmurphy@ti.com" <dmurphy@ti.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mazziesaccount@gmail.com" <mazziesaccount@gmail.com>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "jacek.anaszewski@gmail.com" <jacek.anaszewski@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 4, 2019 at 4:48 PM Vaittinen, Matti
<Matti.Vaittinen@fi.rohmeurope.com> wrote:

> > Good initiative (and I will see a ton of janitorial patches as a
> > result of this...)
>
> I have somewhere near 62 patches waiting to be sent =) They're pretty
> small but I'd appreciate thorough review as they're mostly untested...
> Do you mind receiving them all in one go? Or do you think I should send
> the series in smaller chuncks?

I would be fine with one patch introducing the defines and then
one big patch switching everybody and their dog over to using
these definitions.

I usually keep to a patch being "one technical step" and it is
clearly (IMO) one step to introduce the defines and one step
to make use of it in all legacy drivers.

It's late in the kernel cycle but this particular part (the defines
and switching over old driver to use it) I'd be happy
to merge for v5.5.

Yours,
Linus Walleij
