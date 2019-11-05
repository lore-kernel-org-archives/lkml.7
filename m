Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44156C17460
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 13:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 157C021D7C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 13:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mmSF+IAU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389107AbfKENYa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 08:24:30 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35523 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388992AbfKENY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 08:24:29 -0500
Received: by mail-lf1-f67.google.com with SMTP id y6so15126664lfj.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 05:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OriTvqKjGZz26vq3sX+0nz0hNVWCQx915SM+y16L4zI=;
        b=mmSF+IAUX1udzNA10gxQDs4IVguwwokEurVOW3StfXUANAJNYQv4/+zWORcXWFMJz6
         m8BMOmIIg6IdlyXqx/JOil3Nbe1GQJOjv3TKF4sU9Y8IhkaCAxvvuN9OIs6XmIOXlhaV
         3yDCu8ShhTKAlUTHth4u2KT53qkmJ5SC02XPDZHD1F7NmyWDtGHSU+gmVOKet8p9J0tg
         tOUcealyAZisw9u0YxSTwLwJi9mNZL5v3AiyePab1IAJp9k9ulTtGJUtUmXfCzS/M3vK
         ttjdpKUqRtjmkL88v5AmTh1EY7ErppJQbMgbmt1rENGRy7NzGgSd1ie29VbCA1Ll9hDA
         riGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OriTvqKjGZz26vq3sX+0nz0hNVWCQx915SM+y16L4zI=;
        b=LNL+1JlyvR4mV/vdFszq0Xi+ZS8KIBF32MTUatQ28Z9JQPdGraraJHwln7bv5LpOHK
         VHHmzBR3FYi318hXk4D9uCTshwZ8GdYtlmw/YEzuxb9bkjbRib4fPp/TmnTLQ/XY2scH
         HAqNCG9aE3pNl9Zom+bXemVUxtp+npQcFZZLd9SIrRvKVGvqHA+TV+2GMA6fxcZMrFJ5
         MvA/CSbJlZAmhbEnaHKKB2ihQLJO1GXNmFhbhg2lWpA3zg2KQHpNo2esjM3UjwDOeyEt
         bV00wfUb4Jwl7ujwjj2sTkShl5NHToc9dYbO5LfqqiW8j2nz9zzQahUrO5SS0Y30iuFF
         5/Lw==
X-Gm-Message-State: APjAAAVFNOVwnIzz6k6s835smVkwNErnIJsSbPEl9oU+oU07SghE7UgM
        AQsa5QoFOg5nf9NWPDAsG7e+iXoEHz7tnfAxjhGSlw==
X-Google-Smtp-Source: APXvYqzoypaV1FwIebV/f2TxtU2nRgrE/Ebq2efFlxTgxI/d4F0Qe39na0QD1eDLDWhk898Dgs+NBvY32AC34gSuqMc=
X-Received: by 2002:ac2:5295:: with SMTP id q21mr20306882lfm.93.1572960267714;
 Tue, 05 Nov 2019 05:24:27 -0800 (PST)
MIME-Version: 1.0
References: <cover.1572606437.git.matti.vaittinen@fi.rohmeurope.com>
 <2a8fa03308b08b2a15019d9b457d9bff7aafce94.1572606437.git.matti.vaittinen@fi.rohmeurope.com>
 <CACRpkdZYw3QQcQ4h5y_C0UD6+4Wz9AdmQ0qSrrjfUweuJj8hyQ@mail.gmail.com> <1550472ac1e105bd38da25803358cfbc0404bf38.camel@fi.rohmeurope.com>
In-Reply-To: <1550472ac1e105bd38da25803358cfbc0404bf38.camel@fi.rohmeurope.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 5 Nov 2019 14:24:15 +0100
Message-ID: <CACRpkdYkgEg=4H9tQQrVcvx1xtETYD_cHxhqd-BW6g67jpEeEg@mail.gmail.com>
Subject: Re: [RFC PATCH v3 10/15] regulator: bd71828: Add GPIO based run-level
 control for regulators
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

On Mon, Nov 4, 2019 at 8:05 AM Vaittinen, Matti
<Matti.Vaittinen@fi.rohmeurope.com> wrote:
> On Sun, 2019-11-03 at 23:27 +0100, Linus Walleij wrote:

> > I do not understand the regulator parts of the patch.
>
> I'm sorry. The patch is not clearest one what comes to the regulator
> stuff. I can try splitting it to smaller and more logical changes if
> you, Mark or other interested people hope to get it splitted. Or
> perhaps it would be simplest to review if it was all in one patch?

As long as the regulator experts are happy with the format,
stay with that. I am just a drive-by coder when it comes to regulators.

Yours,
Linus Walleij
