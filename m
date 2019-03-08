Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9386BC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 09:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C11320684
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 09:05:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fZesSELg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbfCHJFP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 04:05:15 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37216 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbfCHJFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 04:05:14 -0500
Received: by mail-lf1-f66.google.com with SMTP id u2so6820147lfd.4
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 01:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I8XLCkAQdguZY+t3BmFOlDA8KX8vPy9XQgX5ClXaAAA=;
        b=fZesSELgHscEHPQSIzXtEthnb0NCMwH3MjmgbrqBbDnZrHKK8Pv4D0bvUO1K974ty5
         kNMsnMu5bML0QP5Q13jDbXYXuk6tHmZzhyg2NCjxBO/1xA2PRj0EO0HeH2726Un/1v+x
         vs1iWPFT86kvFHATvLE9QHBXhbNjppISw+0pHvXWBbjgcD/Qm6kbCxke4gwKyq420JaZ
         F0u49/Yei1NZMbspNLmrU4M33zs10ihOHXvR/aPVvFqVgYSvVSEYtytDXe7FQlBmR00f
         tK4kxfeT00OSn32ZHW89JMe0dqIqKf4tZHlJHPIbRz3SlfPoRlbmq6d8ySgOi2GFEOEC
         dYNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I8XLCkAQdguZY+t3BmFOlDA8KX8vPy9XQgX5ClXaAAA=;
        b=a+MUnGseB7zcmyYqm1NIR/dyoiD7u7o/YfQ/1FupEKWu7WYHjaZogj1v/iBUjZ5Jwl
         fjZV6QEqqLQOeNaq2cOBhDoECdtDN2EsGqZ8AlwDkDAN+whQKoBD1tr3Yt4C7UPYG8b5
         HLWQI+caNBhL3i8OjIWn22DeAbuj9SQWwqRfhMX+gnajQyeB9gKw6fUvgfFlMpFIuEjw
         vsD+0IcUwWcLLvyzSGuKrwFXyae8vD3de04ZliTBzvRagZmbF2886BxoHthhoOljueQw
         wGXT945/XOAQQoxMQC+67SwMCRi7kZDVR2rwOgQVlACBFktJgePLNBPuq5E0PSG6yEN6
         Cx+Q==
X-Gm-Message-State: APjAAAVvCOOakP2rZyIYUjp6kmEJialZIar/W56E8La9LN8ZkXSIntbo
        x47FzylMnAxWkCWIDr+fTxw9n6oSsWPxEdLOcIkSknpt
X-Google-Smtp-Source: APXvYqxaEXmr6v3mBc8j0uGNBo0Mp67PRy64+fgiTy5ZOVVQEarG5h8/ZK0+E5wJgNC4BjzPs9y8udAAuC5d2wmm09Q=
X-Received: by 2002:ac2:533b:: with SMTP id f27mr3547596lfh.8.1552035912254;
 Fri, 08 Mar 2019 01:05:12 -0800 (PST)
MIME-Version: 1.0
References: <20190304201930.1622839-1-arnd@arndb.de> <20190304201930.1622839-3-arnd@arndb.de>
 <24c191e1-f607-1320-2474-3db92383e383@metux.net> <e5f1511e-c750-8fb2-0bfe-c73bc7905b22@infradead.org>
In-Reply-To: <e5f1511e-c750-8fb2-0bfe-c73bc7905b22@infradead.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 8 Mar 2019 10:05:00 +0100
Message-ID: <CACRpkdad_HeZ9oKGZXmX2Yn2NcD8V+sAje=ELxSXeFeMGGjr8w@mail.gmail.com>
Subject: Re: [PATCH 3/3] x86: apuv2: select LEDS_CLASS
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Linus Walleij <linusw@kernel.org>,
        Enrico Weigelt <info@metux.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        platform-driver-x86 <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 5, 2019 at 1:09 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> On 3/4/19 4:03 PM, Enrico Weigelt, metux IT consult wrote:
> > On 04.03.19 21:19, Arnd Bergmann wrote:
> >> LEDS_GPIO can only be selected when LEDS_CLASS is already enabled:
> >>
> >> WARNING: unmet direct dependencies detected for LEDS_GPIO
> >>   Depends on [m]: NEW_LEDS [=y] && LEDS_CLASS [=m] && (GPIOLIB [=y] || COMPILE_TEST [=y])
> >>   Selected by [y]:
> >>   - PCENGINES_APU2 [=y] && X86 [=y] && X86_PLATFORM_DEVICES [=y] && INPUT_KEYBOARD [=y]
> >>
> >> Fixes: f8eb0235f659 ("x86: pcengines apuv2 gpio/leds/keys platform driver")
> >> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >> ---
> >>  drivers/platform/x86/Kconfig | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> >> index 4d65d37b0c86..d64529352a9c 100644
> >> --- a/drivers/platform/x86/Kconfig
> >> +++ b/drivers/platform/x86/Kconfig
> >> @@ -1308,6 +1308,7 @@ config PCENGINES_APU2
> >>      depends on INPUT && INPUT_KEYBOARD
> >>      select GPIO_AMD_FCH
> >>      select KEYBOARD_GPIO_POLLED
> >> +    select LEDS_CLASS
> >>      select LEDS_GPIO
> >>      help
> >>        This driver provides support for the front button and LEDs on
> >>
> >
> > ACK. Just was about to post the same :)
> >
> > Reviewed-by: Enrico Weigelt, metux It consult <info@metux.net>
> >
>
> Enrico, you were also cc-ed on this patch on Feb.25, 2019:
>
> https://marc.info/?l=linux-kernel&m=155113875310485&w=2

I applied Randy's more extensive patch.

Yours,
Linus Walleij
