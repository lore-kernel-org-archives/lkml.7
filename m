Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DFAEC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 07:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B1BF214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 07:18:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B8EKQTpG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbfCLHR6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 03:17:58 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34589 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbfCLHR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 03:17:57 -0400
Received: by mail-pg1-f194.google.com with SMTP id v12so1156724pgq.1;
        Tue, 12 Mar 2019 00:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qNQpguhyRnMbrzI92caoHlRZ09jfujw5oCsCLJF/TaM=;
        b=B8EKQTpGPk+w848JeuDsV5WddtLEuUIpzTVTMvL5R40kNUn5UBJln20xee5EqZE6t2
         pwhilxseGRf3RogELyHvTUo0atfdONL4F4jatr2aB/YygCiMm106qjsxV3FOFQIlq9OF
         uprt8RR5cESfrmpTxdAI5dLH5x/OlHsUo/Mb7/ZKwI/889Y9trBNPRBqRMu6KhzwZzf6
         WyPQIbhbwfyFvHcCuE+yo/d70Sw4HjD/Ap7J+pbsGyomOmV68Sa07TH9R9zEONVjUkPg
         ywoDuN00QB8wtxcfZ0emfbuWhEGOLC8+Cb+1ZfCADjGcTdUb1XQ50tYecBpFllpp4rPG
         TQuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qNQpguhyRnMbrzI92caoHlRZ09jfujw5oCsCLJF/TaM=;
        b=QHr7p1pcSqUU6PIntGM1dz3r4tahi3H/YDJ6RFYY8dQNwCy08fjpMikYRLgIcgThAr
         e/41SlHQOG/UcER4Df3fNDyjXpQf3e4ilwBaSLIe1jiEsSUs/AyXGqa8Hxq+79zZCFwM
         1i4IwHXo7sWJtNWVBkrqqssahGis9Bdu2DAy8O9CMnLEPSuSTyO9AtrB8YVWieQ+t+V0
         3wIqdRgBq+DK/oZyWMY+uZ70sad1B9PARZWa7LmJC+pxOI8YiVIU4thi1oEiouQbxR86
         es9UKKS7AGSZh+/IciERDZeP4Caia98+WgrWlx0SVioaN7wExZdhLDJL93okdUCUo5Eq
         cpxw==
X-Gm-Message-State: APjAAAVfyCfRCTy4H4Qh08/IczxGlNdI09t5qI/J27jo97ZKEtdQC449
        UxdKtIPWm4zcywX6VHrekrJmhTYnSsO0BtL0B+IYLJme18Q=
X-Google-Smtp-Source: APXvYqyE7FfJafzD+9yrJ7vlqHnKfn+hvYvuPrSvSp8zRIQYKHK+GWyjJB0fzdXudG4Hz6kA61U7vkbhVBYwwZ7dRWQ=
X-Received: by 2002:a62:1d90:: with SMTP id d138mr31092733pfd.232.1552375076973;
 Tue, 12 Mar 2019 00:17:56 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1551598603.git.vilhelm.gray@gmail.com> <0840d55707dacd1121659723246fa9f55737f426.1551598603.git.vilhelm.gray@gmail.com>
 <CAK7LNARRqYb_ovO_ccQ8xTLTzNYyTEK8whT2r0cq_AqpWqeNXg@mail.gmail.com>
In-Reply-To: <CAK7LNARRqYb_ovO_ccQ8xTLTzNYyTEK8whT2r0cq_AqpWqeNXg@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 12 Mar 2019 09:17:46 +0200
Message-ID: <CAHp75Vcbi+VeD8xzaB0hSNVhMuiVcwjD8Q9Tt6-H8L9CD32N8Q@mail.gmail.com>
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

On Tue, Mar 12, 2019 at 6:40 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> On Sun, Mar 3, 2019 at 4:51 PM William Breathitt Gray
> <vilhelm.gray@gmail.com> wrote:
> >
> > Replace verbose implementation in set_multiple callback with
> > for_each_set_clump8 macro to simplify code and improve clarity. An
> > improvement in this case is that banks that are not masked will now be
> > skipped.

> Please do not do this.
>
> Nothing in this driver says the GPIO width is 8-bit.

Huh?

https://elixir.bootlin.com/linux/latest/source/include/dt-bindings/gpio/uniphier-gpio.h#L9

Isn't a hardcoding?

-- 
With Best Regards,
Andy Shevchenko
