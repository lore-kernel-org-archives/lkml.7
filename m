Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F0DC48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 11:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EF7220644
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 11:00:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729268AbfFYLAK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 07:00:10 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46134 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728130AbfFYLAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 07:00:10 -0400
Received: by mail-ot1-f68.google.com with SMTP id z23so16735311ote.13
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 04:00:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4T8Ue09/YBaZV9OMI7Iu/NCrm7AAnilSZ7c3PFJqM6E=;
        b=saQfZNxMqGZ/vPadtuu3egIIt03ajl1G0waH2Xg6gFebIS25+lD8ULWC5uQnihd/rD
         v1kRk58uB4F2+sSDMAM+4WvW4VTfIc/b3S/Z6QMMdyWwM9QwvFftUyZ/p4AuQQjHhyes
         FvQoyRtPKpo1VCWjMQLpWcc6Ygcpq+dwxyjKTEoQoCKEg6UyyUjTB+vdqhzA/EnxxEoe
         JT+yYKwGfkVEQFq5emVbd40pbahPh25rfY3R+Cg4gRQl8z7+mc+ZUzYIX+UHDz8WQ5//
         CVyDKtqtDLhbc+5MMXQEl1z4TeIXnQK4FlBEmmF/2thcxgpV2Hr2+iZWd7xQL342L0a2
         fgGg==
X-Gm-Message-State: APjAAAWhJqn6nX1F0vLF1j9RFHCXMEmdy7vm15ASEn3+C7qqgYLh/2W9
        B+c3+TnJk7T7jD6R0XPEc3NdusJC9PwhyA4ArGs=
X-Google-Smtp-Source: APXvYqxoLV0kE1qB/GZV8MBMhh1sscli9FjXXh+G0tdJA5b1yhIoGCxqRPPDdyKSc1WXwYLj5/FPHLCKrqTwuuPT7Q0=
X-Received: by 2002:a9d:69ce:: with SMTP id v14mr21206830oto.39.1561460409920;
 Tue, 25 Jun 2019 04:00:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190417115350.20479-1-pmladek@suse.com> <20190417115350.20479-8-pmladek@suse.com>
In-Reply-To: <20190417115350.20479-8-pmladek@suse.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 25 Jun 2019 12:59:57 +0200
Message-ID: <CAMuHMdVX+2tRjCabqVNR9HcnWE+EU0bR55KAW9bbD=GBEoE-=w@mail.gmail.com>
Subject: Re: [PATCH v7 07/10] vsprintf: Consolidate handling of unknown
 pointer specifiers
To:     Petr Mladek <pmladek@suse.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Tobin C . Harding" <me@tobin.cc>, Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Petr,

On Wed, Apr 17, 2019 at 1:56 PM Petr Mladek <pmladek@suse.com> wrote:
> There are few printk formats that make sense only with two or more
> specifiers. Also some specifiers make sense only when a kernel feature
> is enabled.
>
> The handling of unknown specifiers is inconsistent and not helpful.
> Using WARN() looks like an overkill for this type of error. pr_warn()
> is not good either. It would by handled via printk_safe buffer and
> it might be hard to match it with the problematic string.
>
> A reasonable compromise seems to be writing the unknown format specifier
> into the original string with a question mark, for example (%pC?).
> It should be self-explaining enough. Note that it is in brackets
> to follow the (null) style.
>
> Note that it introduces a warning about that test_hashed() function
> is unused. It is going to be used again by a later patch.
>
> Signed-off-by: Petr Mladek <pmladek@suse.com>

> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -1697,7 +1700,10 @@ static noinline_for_stack
>  char *clock(char *buf, char *end, struct clk *clk, struct printf_spec spec,
>             const char *fmt)
>  {
> -       if (!IS_ENABLED(CONFIG_HAVE_CLK) || !clk)
> +       if (!IS_ENABLED(CONFIG_HAVE_CLK))
> +               return string_nocheck(buf, end, "(%pC?)", spec);

This one is OK, as there is no clock support compiled in.

> +
> +       if (!clk)
>                 return string(buf, end, NULL, spec);
>
>         switch (fmt[1]) {
> @@ -1706,7 +1712,7 @@ char *clock(char *buf, char *end, struct clk *clk, struct printf_spec spec,
>  #ifdef CONFIG_COMMON_CLK
>                 return string(buf, end, __clk_get_name(clk), spec);
>  #else
> -               return ptr_to_id(buf, end, clk, spec);
> +               return string_nocheck(buf, end, "(%pC?)", spec);

What's the reason behind this change? This is not an error case,
but for printing the clock pointer as a distinguishable ID when using
the legacy clock framework, which does not store names with clocks.

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
