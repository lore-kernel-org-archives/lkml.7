Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8685AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 08:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5347C2147C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 08:58:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="C70CvSRK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727627AbfCLI6E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 04:58:04 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:51001 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbfCLI6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 04:58:04 -0400
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id x2C8vwFx027608;
        Tue, 12 Mar 2019 17:57:59 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com x2C8vwFx027608
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1552381079;
        bh=PGIGkDw9UbKSM/oVEyNzdkHYBeSIE+rx/yXJyP5zE7E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=C70CvSRKhWN7w2LsjHLnc/egk36lFWReqSwwElYmNr1hmC+o+hXdgRZnMEJRyM9YF
         +ArTNrC+z96L55D8S5pf3LyyOuibPqi2lrLf+uILXl4t3Gp6wkAkOZd6/GhLUuvvzt
         kPJ6QIvUtB1KPQk3twzx8TED8Bh21Fz0o+FQLr3sljN9J0snXn7vVOmd3O4jByV08s
         mnzwgFzqisKHgs0I1OW8Lx4ob3HoS4sq2sDuZH5r4HJPserxBEjxZAPvNSQfiULxOL
         tJr3e8tSbiwtVBCadLcRfLG/xj/wdPXp7B5yLIQ6OuU8JNlnpxkBB4s7fv6QV1W8+G
         lCh69SoPNuefg==
X-Nifty-SrcIP: [209.85.217.45]
Received: by mail-vs1-f45.google.com with SMTP id n14so1086751vsp.12;
        Tue, 12 Mar 2019 01:57:59 -0700 (PDT)
X-Gm-Message-State: APjAAAWfrt6oguXthr0gIihHMXcSxTbGMqa7N7TaG/NwsSqF9dqRL7GP
        Vngf2Ky2p6tPs+p4lAwyQ9gsL7i/SVUIMtREtbQ=
X-Google-Smtp-Source: APXvYqyHo6hgdfQuDNAOhHnWJ93aeY92LrUm8IUfvs3n5M0HLEt1GGKjxrQ+TX9wwbz48ncFuPYDzjvDvqsy8RHL3Ss=
X-Received: by 2002:a67:76d1:: with SMTP id r200mr1000966vsc.54.1552381078195;
 Tue, 12 Mar 2019 01:57:58 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1551598603.git.vilhelm.gray@gmail.com> <0840d55707dacd1121659723246fa9f55737f426.1551598603.git.vilhelm.gray@gmail.com>
 <CAK7LNARRqYb_ovO_ccQ8xTLTzNYyTEK8whT2r0cq_AqpWqeNXg@mail.gmail.com> <CAHp75Vcbi+VeD8xzaB0hSNVhMuiVcwjD8Q9Tt6-H8L9CD32N8Q@mail.gmail.com>
In-Reply-To: <CAHp75Vcbi+VeD8xzaB0hSNVhMuiVcwjD8Q9Tt6-H8L9CD32N8Q@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 12 Mar 2019 17:57:22 +0900
X-Gmail-Original-Message-ID: <CAK7LNATQN5TJkmOq0r1BzxQCk1T4AmsUmhR1zU+gq8e_f5-FQw@mail.gmail.com>
Message-ID: <CAK7LNATQN5TJkmOq0r1BzxQCk1T4AmsUmhR1zU+gq8e_f5-FQw@mail.gmail.com>
Subject: Re: [PATCH v9 9/9] gpio: uniphier: Utilize for_each_set_clump8 macro
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 4:19 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Tue, Mar 12, 2019 at 6:40 AM Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
> > On Sun, Mar 3, 2019 at 4:51 PM William Breathitt Gray
> > <vilhelm.gray@gmail.com> wrote:
> > >
> > > Replace verbose implementation in set_multiple callback with
> > > for_each_set_clump8 macro to simplify code and improve clarity. An
> > > improvement in this case is that banks that are not masked will now be
> > > skipped.
>
> > Please do not do this.
> >
> > Nothing in this driver says the GPIO width is 8-bit.
>
> Huh?
>
> https://elixir.bootlin.com/linux/latest/source/include/dt-bindings/gpio/uniphier-gpio.h#L9
>
> Isn't a hardcoding?


Semi-hardcoding.

I needed to factor out some magic numbers
shared between DT and drivers.

Then, dt-bindings is out of realm of operating system.

If I am doing wrong, I take back my comments, though.



-- 
Best Regards
Masahiro Yamada
