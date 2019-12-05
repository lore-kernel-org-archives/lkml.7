Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 351E1C2D0BF
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 09:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BB6724651
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 09:28:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="On51OQFW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729232AbfLEJ2q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 04:28:46 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40138 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbfLEJ2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 04:28:45 -0500
Received: by mail-ot1-f68.google.com with SMTP id i15so1993937oto.7
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 01:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jvkGwJO9wpwmWzb9yFYF8g0IZb78yl4JdpgD9iqbzYo=;
        b=On51OQFWdvIjn8Q3J7N+Tq3YSiDkfSP1sBhnb0QIuJfAxFuDJab1AxvkR2BocBCgDP
         dHZqvUqVxKaUnabdCFbiFQBB1Lp1/nntWzS19cPHJj3zIt6epATT9q8EfZVqVvn1eGPT
         ziWJu3cwExxojl3nIbXHdilO6R5IMkujgFB+h9/y+VHUXpeLjAdT4OPU25bQHA9cXKQp
         iJ448kofN9nG9IzMawFJcHJCjxTdPyfRv1sqE6NDxL+proHg+TNDcD3K/iZetFEjVPs3
         gJyKX/M99cccEcKlgPw5zt/VGH8fuHw9SzVXs/lgLePyYUdmY9Ar7DlJigfjzo46/G6H
         9ZZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jvkGwJO9wpwmWzb9yFYF8g0IZb78yl4JdpgD9iqbzYo=;
        b=Sd2mVkLtQyyVmv+TY3SjeqWiuAryGKFZeMmL15aLzKG5AftceDUZG+jUG0Rep8Q4Ky
         iRhnivbXcozyeL504kgIsoD95JpH+sOb+st7vpVfV2eD97Lu/HdxDNWHYMM/Db/G32OB
         0I/S+TSoL6aFzRNiqHSyP1ioRJg4zftZPzKP9Yh55t9x4GiDxhKWDfi7QrM9kbTtN60a
         nt55lqGoCMdEXMLu8KHPkMjQpOMNe3RUI9/Ay/Fm62FFR25cPrswVUy1kxitm9chsUbO
         MPH4oHDXOtl1Zx+TaubgMxRFOV4zZ8fYwc8+SmX+FQ/UE/CjOTtIvcgq49cTq/omZp9B
         nRsg==
X-Gm-Message-State: APjAAAVMSYe6TzqjP7SaAD1uIMtduoSPbijkKpe808NetanvYKX8g4ea
        um+OMlym9fJL2wdoewdKj4yk+7qyFnrVb9RJNev4fYJh
X-Google-Smtp-Source: APXvYqy+ubC6Uu8h10Qw5Xuv8D18unDenLazP4DmK9vEKViVQ+Vn1OUMHxSxWBMT+ffH7P1Gv0jQeXmObl9sJkKHjWk=
X-Received: by 2002:a9d:7a46:: with SMTP id z6mr5944040otm.194.1575538124736;
 Thu, 05 Dec 2019 01:28:44 -0800 (PST)
MIME-Version: 1.0
References: <20191204155912.17590-1-brgl@bgdev.pl> <20191204155912.17590-10-brgl@bgdev.pl>
 <CAHp75VfbwwDyxoZU2vHo7qo8E0rQdT3czC+Wpe7cqr5uoJVUwQ@mail.gmail.com>
In-Reply-To: <CAHp75VfbwwDyxoZU2vHo7qo8E0rQdT3czC+Wpe7cqr5uoJVUwQ@mail.gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Thu, 5 Dec 2019 10:28:33 +0100
Message-ID: <CAMpxmJXhEK3Whh8vGfW-TewT7uRgipBOd3hhmSGHYkH=PD_Nfw@mail.gmail.com>
Subject: Re: [PATCH v2 09/11] gpiolib: provide a dedicated function for
 setting lineinfo
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C5=9Br., 4 gru 2019 o 23:30 Andy Shevchenko <andy.shevchenko@gmail.com> na=
pisa=C5=82(a):
>
> On Wed, Dec 4, 2019 at 6:02 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> >
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > We'll soon be filling out the gpioline_info structure in multiple
> > places. Add a separate function that given a gpio_desc sets all relevan=
t
> > fields.
>
> > +       if (desc->name) {
> > +               strncpy(info->name, desc->name, sizeof(info->name));
> > +               info->name[sizeof(info->name) - 1] =3D '\0';
> > +       } else {
> > +               info->name[0] =3D '\0';
> > +       }
> > +
> > +       if (desc->label) {
> > +               strncpy(info->consumer, desc->label, sizeof(info->consu=
mer));
> > +               info->consumer[sizeof(info->consumer) - 1] =3D '\0';
> > +       } else {
> > +               info->consumer[0] =3D '\0';
> > +       }
>
> I think we have to fix GCC warnings first and then do whatever this patch=
 does.
>

What GCC warnings are you referring to exactly?

Bart

> --
> With Best Regards,
> Andy Shevchenko
