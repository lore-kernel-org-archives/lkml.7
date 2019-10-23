Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D9ACA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 08:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78E5B2084C
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 08:34:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390378AbfJWIe3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 04:34:29 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42269 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390034AbfJWIe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 04:34:28 -0400
Received: by mail-ot1-f67.google.com with SMTP id b16so5886236otk.9;
        Wed, 23 Oct 2019 01:34:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FNfZmiV67t7QxSHiYI6eywvoRe7virsvD8HG/XQKIYQ=;
        b=ZjaS+ctQs0FIE2upuY3xbezFDK/NEdw8Oa9Gwxa7fJaxB9c46Lb41g7Jcyh/JfE9qd
         EOJz7pDRKwJPMwSN+LUDNatOP/bYbUPllfJ/2kTngt9hxgb40ndr+3FmrsdArEEJ8LMk
         PVsANWjyL8JxY94SvkHegNkzPANAElVG96oVx8MlF/AVljqZ67LV9E2/PgyFycNDXhfh
         6xAsVXaOJjz63Ls+9yeVGurgXC2cNziquEeYxmoqqkNeGHabn/qsM0ZzXuRUi+dWR8dp
         iMUAv+qH+CRht2fLBxJwCXsq4u47k2aV0XQfRY7xo/EwfbuAULd4lzMSEOFagTJ8rtQ5
         GeeQ==
X-Gm-Message-State: APjAAAXCJLHohTxp1MWb9Y43cjP35DzxW0xDx091UCGDxL/L3e4Yt3PC
        gltMyoJJm7yW7fiCrcjEO6cVNdg3SdvaWKDCIFE=
X-Google-Smtp-Source: APXvYqyxat31GKzG8TimxmoYimXPhjqAON+/4Cm5qT3ME8cJ9h9AuagoHxVbrklOyKGum2roni+9cqETTO7yI+3CWuM=
X-Received: by 2002:a9d:422:: with SMTP id 31mr5838689otc.107.1571819667667;
 Wed, 23 Oct 2019 01:34:27 -0700 (PDT)
MIME-Version: 1.0
References: <20191022172922.61232-1-andriy.shevchenko@linux.intel.com>
 <20191022172922.61232-11-andriy.shevchenko@linux.intel.com>
 <CAMuHMdUUvVdg8w0evV4zjrqis9e9Jak_qTnkufYT5wQHUn9j-A@mail.gmail.com> <20191023080109.GK32742@smile.fi.intel.com>
In-Reply-To: <20191023080109.GK32742@smile.fi.intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 23 Oct 2019 10:34:16 +0200
Message-ID: <CAMuHMdVsuo5adFL=oWAeu+=yjdk6DVVLDaB2LMtuFu6g8XqnLg@mail.gmail.com>
Subject: Re: [PATCH v2 10/11] gpio: pca953x: Convert to use bitmap API
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Yury Norov <yury.norov@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Wed, Oct 23, 2019 at 10:01 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Tue, Oct 22, 2019 at 08:03:00PM +0200, Geert Uytterhoeven wrote:
> > On Tue, Oct 22, 2019 at 7:29 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > Instead of customized approach convert the driver to use bitmap API.
>
> > >  #define MAX_BANK 5
> > >  #define BANK_SZ 8
> > > +#define MAX_LINE       (MAX_BANK * BANK_SZ)
> >
> > Given (almost) everything is now bitmap (i.e. long [])-based, you might
> > as well increase MAX_BANK to a multiple of 4 or 8, e.g. 8.
>
> We can do it any time when we will really need it.

True. Especially as there's no real need to do it now.
(sorry, my mind mixed this up with gpio-74x164...)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
