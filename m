Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B196C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 14:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D6E020656
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 14:04:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbfKZOET (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 09:04:19 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:42122 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727719AbfKZOET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 09:04:19 -0500
Received: by mail-oi1-f193.google.com with SMTP id o12so16684224oic.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2019 06:04:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q130w8fypitwDj9gDfuj9In2u11nwddpuk2WOPM7J1s=;
        b=c4GYldik58q/DVuvLl6cFb2M3FjwxTCqcHQ7GEoqy1ZT7FuCymrOjxonulNkkI6RcV
         1LqyRtAws9F34czjtP/Rf4cB3B3jIIfy5luaYtUBulbTZZHfnzX+EgdNqC/nAy3S4GIg
         bQh3wgrdD2sQFKaCqc4TWYI/dWegVNb8F5b3Igx0JxgAd+ImMnz8o2NVq8CT5FLjqVXj
         T64guyn4Rw5x8YJ51dtg0F1H25F2QNDyLtvnXnXCTaD2KTCkuSkWYY52hn2LAuR1UMKz
         6MLU0PR7Ihir35vM/coM7o9zCsKbPYpZ7GNfmZSaKRjZ34KXmxucNu3Slp9XykvLXyJh
         2l/A==
X-Gm-Message-State: APjAAAWmyPST3teEOsSiyfp929M+iRPgj5yvYC18MtdMjNjB9GE048U5
        qKBQiz9s4YZyNyaIBsDkh5OYwEGSINkTteLeWn5OMA==
X-Google-Smtp-Source: APXvYqzOAGYNgOQNoyZv3pVGgYpskOxDaWnUwjAAMzg3qqDEdp//Wpas1uChc6DgMj6Fsv62FUj0MEmTqeuBncyQAhQ=
X-Received: by 2002:a05:6808:5d9:: with SMTP id d25mr3791077oij.54.1574777058146;
 Tue, 26 Nov 2019 06:04:18 -0800 (PST)
MIME-Version: 1.0
References: <20190917065959.5560-1-linux@rasmusvillemoes.dk> <20191011133617.9963-1-linux@rasmusvillemoes.dk>
In-Reply-To: <20191011133617.9963-1-linux@rasmusvillemoes.dk>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 26 Nov 2019 15:04:06 +0100
Message-ID: <CAMuHMdXSt_xtgUz+r9n5_YkJU09HUttbfibOvw8b2zBdXZtT4g@mail.gmail.com>
Subject: Re: [PATCH v4 0/1] printf: add support for printing symbolic error names
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Joe Perches <joe@perches.com>, Petr Mladek <pmladek@suse.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rasmus,

Nice idea!

On Fri, Oct 11, 2019 at 3:38 PM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
> This is a bit much for under the ---, so a separate cover letter for
> this single patch.
>
> v4: Dropped Uwe's ack since it's changed quite a bit. Change
> errcode->errname as suggested by Petr. Make it 'default y if PRINTK'
> so it's available in the common case, while those who have gone to
> great lengths to shave their kernel to the bare minimum are not
> affected.
>
> Also require the caller to use %pe instead of printing all ERR_PTRs
> symbolically. I can see some value in having the call site explicitly
> indicate that they're printing an ERR_PTR (i.e., having the %pe), but
> I also still believe it would make sense to print ordinary %p,
> ERR_PTR() symbolically instead of as a random hash value that's not
> stable across reboots. But in the interest of getting this in, I'll
> leave that for now. It's easy enough to do later by just changing the
> "case 'e'" to do a break (with an updated comment), then do an
> IS_ERR() check after the switch.
>
> Something I've glossed over in previous versions, and nobody has
> commented on, is that I produced "ENOSPC" while the 'fallback' would
> print "-28" (i.e., there's no minus in the symbolic case). I don't
> care much either way, but here I've tried to show how I'd do it if we
> want the minus also in the symbolic case. At first, I tried just using
> the standard idiom
>
>   if (buf < end)
>     *buf = '-';
>   buf++;
>
> followed by string(sym, ...). However, that doesn't work very well if
> one wants to honour field width - for that to work, the whole string
> including - must come from the errname() lookup and be handled by
> string(). The simplest seemed to be to just unconditionally prefix all
> strings with "-" when building the tables, and then change errname()
> back to supporting both positive and negative error numbers.

Still, it looks a bit wasteful to me to include the dash in each and every
string value.

Do you think you can code the +/- logic in string_nocheck() in less than
the gain achieved by dropping the dashes from the tables?
(e.g. by using the SIGN spec.flags? ;-)
Or, do we need it? IS_ERR() doesn't consider positive values errors.

Oh, what about the leading "E"? That one looks harder to get rid of,
though ;-)

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
