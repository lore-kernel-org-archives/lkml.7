Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB919C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 09:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A17D2147C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 09:09:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jtc/Oq/w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbfCLJJU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 05:09:20 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46758 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbfCLJJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 05:09:19 -0400
Received: by mail-pg1-f193.google.com with SMTP id a22so1302365pgg.13;
        Tue, 12 Mar 2019 02:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uESbAd7eRXMtsVpdmmaP/lysiuv/xe62ER6tRfhGMXQ=;
        b=Jtc/Oq/wSxjL/ni8zkezreuwSif3heNAGlbaNXkHj9wnRsGseGXxQtaZfPKtF6OLvQ
         pBv+Ev6o4n2t4Lo8c1OTSX1uCOtTFXWWnxlzpP8B+JcTx8h806hE0bz9OFFYI8jlBkAi
         qwJdvvmJGXDr0AVukYPG98Skh1UEJfkbKAnaZVa/deWLZMSIRqypdDYOiaBEx8sTnb6E
         y0oBosMTKOSVxCu8SoYK2TmWyzRXUJN4r5YhGGV9gPN4EgsR9KAmLlAHziHQhDGi+kNH
         bWkXFzuar2j/aja0ym8F25LuRpYPX+N014Fp3Lcby+3Id4NqWLuIjRhp4B1sPDS7kLDS
         F7WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uESbAd7eRXMtsVpdmmaP/lysiuv/xe62ER6tRfhGMXQ=;
        b=AZZznHSo4NhHd6It318dWwNlJyKheHwgfkZJYOhwB4dbDwPqxVDkbwPOJA8ktCL+wH
         +MuKxen4mUekhYgGg45HtzK72k0/SCILNgdbf/b+wk0T0Kea2hGCVUO5TBOzaVy8uJ9D
         5FqOADjsTscTrXtLAwCthj9muYVrPqv/p8d/gb/avrnr71dF3Z6qNcSUFV25J/bwW93Z
         jWyHkk5Znczq/gafIyb8M5acgDaOzN2g+np9bFlulfQTfXNMDGXJJ+dcw5CtwMLXRb2I
         IjYNfKqdFSwvGADMIsk1xymc+MhqvIINRFOARS22d8xoJHMAR9YJOkAACZ77+eKo7/Xd
         v1Ew==
X-Gm-Message-State: APjAAAW4KDvNkPOV8j0iU/6oqH4ZEGTOr/JbvO0RtX3VKz/k3Xo/WGVr
        6yyM2VdKCfHhR8CmLee4kKrXfqd/n/vFI2W7XAA=
X-Google-Smtp-Source: APXvYqzOeL1RHvJ9i7HPpc4u1b0sXOpUn4nAdsz0WJ8BmEpgrCNJ1R99thQbQ0mmu7+jyrFSgl2v9TS3SmTRxFSYmiY=
X-Received: by 2002:a63:ed45:: with SMTP id m5mr12443882pgk.265.1552381758611;
 Tue, 12 Mar 2019 02:09:18 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1551598603.git.vilhelm.gray@gmail.com> <0840d55707dacd1121659723246fa9f55737f426.1551598603.git.vilhelm.gray@gmail.com>
 <CAK7LNARRqYb_ovO_ccQ8xTLTzNYyTEK8whT2r0cq_AqpWqeNXg@mail.gmail.com>
 <CAHp75Vcbi+VeD8xzaB0hSNVhMuiVcwjD8Q9Tt6-H8L9CD32N8Q@mail.gmail.com> <CAK7LNATQN5TJkmOq0r1BzxQCk1T4AmsUmhR1zU+gq8e_f5-FQw@mail.gmail.com>
In-Reply-To: <CAK7LNATQN5TJkmOq0r1BzxQCk1T4AmsUmhR1zU+gq8e_f5-FQw@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 12 Mar 2019 11:09:06 +0200
Message-ID: <CAHp75VfMvReunZgtBbA42Xw6GtzTO8Xfr2V9nZyV8xYjPnBm4w@mail.gmail.com>
Subject: Re: [PATCH v9 9/9] gpio: uniphier: Utilize for_each_set_clump8 macro
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
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

On Tue, Mar 12, 2019 at 10:58 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> On Tue, Mar 12, 2019 at 4:19 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Tue, Mar 12, 2019 at 6:40 AM Masahiro Yamada
> > <yamada.masahiro@socionext.com> wrote:
> > > On Sun, Mar 3, 2019 at 4:51 PM William Breathitt Gray
> > > <vilhelm.gray@gmail.com> wrote:
> > > >
> > > > Replace verbose implementation in set_multiple callback with
> > > > for_each_set_clump8 macro to simplify code and improve clarity. An
> > > > improvement in this case is that banks that are not masked will now be
> > > > skipped.
> >
> > > Please do not do this.
> > >
> > > Nothing in this driver says the GPIO width is 8-bit.
> >
> > Huh?
> >
> > https://elixir.bootlin.com/linux/latest/source/include/dt-bindings/gpio/uniphier-gpio.h#L9
> >
> > Isn't a hardcoding?
>
>
> Semi-hardcoding.
>
> I needed to factor out some magic numbers
> shared between DT and drivers.

Effectively means you introduced an ABI, which we are not supposed to
change, where the number is carved in stone for all hardware covered
by this driver + DT pair.
If you would ever need another one it would require extending existing
bindings without dropping them away.

> Then, dt-bindings is out of realm of operating system.

Exactly!

> If I am doing wrong, I take back my comments, though.

-- 
With Best Regards,
Andy Shevchenko
