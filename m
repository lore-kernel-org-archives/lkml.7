Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DE2BC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 10:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2906920748
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 10:51:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbfKOKvY convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 05:51:24 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:40125 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726996AbfKOKvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 05:51:23 -0500
Received: by mail-oi1-f196.google.com with SMTP id d22so1297673oic.7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 02:51:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3Z9bFXw6VxEQy+kWbCkswI7JaUmU2L6uYiQOrW8jGIQ=;
        b=TxOsWm6NvwIn3itpiTeZH5Dzn3+tSFcZI5hCQJ3tZolEJGyjaKuXhQbHCqEBvs7MTC
         K7SH23so2orUWEHej44iF2V/pm3hy9PcLw0wKRhOBope0Pt7VC7CiGsr+oQyAz+92s4r
         MvPQoW05+NoOO4KgC6jDNh2z7oI9b7J7Fx3VrYatJhI+ZCr2ET37ZAg7faa0fVAXN5CJ
         LwuV0ow16Kmm09sA7OsZbktHkrWXEPLjQBYiRmOXOFKXkhIeFwjnrdKbhhy/oorrdAcs
         4oxa7JaEsfskK5mAaxowiNNZ9lecz7U66DBI6nONqrOZjerwcATdreE63+SkW0o5pVBJ
         gDOw==
X-Gm-Message-State: APjAAAVqsMfwFLJ3AZieJ1Hye6GzQQT97TFPQmqvwRardsWbf8h5hGnM
        fE3l0GiqlYTdbYJVWFJIv7nJ9s+OWjwC3OWZfB5aBMbL
X-Google-Smtp-Source: APXvYqwKXvmOjaKrXLIWWv7CKJ5uTjSTzzDToAMeVd6ma3Gy5tOiaTthFT5lnqnlsolzjep16bfWvWl6/itJngTCpp0=
X-Received: by 2002:a05:6808:5d9:: with SMTP id d25mr2413343oij.54.1573815081909;
 Fri, 15 Nov 2019 02:51:21 -0800 (PST)
MIME-Version: 1.0
References: <20191104182107.23568-1-ben.dooks@codethink.co.uk>
In-Reply-To: <20191104182107.23568-1-ben.dooks@codethink.co.uk>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 15 Nov 2019 11:51:09 +0100
Message-ID: <CAMuHMdURebgBTuaPxLZSfnVvMkOeX0vE8LXXj02AQjJQkfy8mw@mail.gmail.com>
Subject: Re: [PATCH] byteorder: fix warning due to type mismatch in be32 array code
To:     "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>
Cc:     linux-kernel@lists.codethink.co.uk,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ben,

CC Arnd.

On Mon, Nov 4, 2019 at 7:25 PM Ben Dooks (Codethink)
<ben.dooks@codethink.co.uk> wrote:
> The loop should use a "size_t" as the len parameter is a size_t which
> should silence the following warning:
>
> ./include/linux/byteorder/generic.h:195:16: warning: comparison of integer expressions of different signedness: ‘int’ and ‘size_t’ {aka ‘unsigned int’} [-Wsign-compare]
> ./include/linux/byteorder/generic.h:203:16: warning: comparison of integer expressions of different signedness: ‘int’ and ‘size_t’ {aka ‘unsigned int’} [-Wsign-compare]
>
> Signed-off-by: Ben Dooks (Codethink) <ben.dooks@codethink.co.uk>

Thanks for your patch!

> --- a/include/linux/byteorder/generic.h
> +++ b/include/linux/byteorder/generic.h
> @@ -190,7 +190,7 @@ static inline void be64_add_cpu(__be64 *var, u64 val)
>
>  static inline void cpu_to_be32_array(__be32 *dst, const u32 *src, size_t len)
>  {
> -       int i;
> +       size_t i;
>
>         for (i = 0; i < len; i++)
>                 dst[i] = cpu_to_be32(src[i]);

Alternatively, you can follow the approach a few lines above:

        while (len--)
                *dst++ = cpu_to_be32(*src++);

Regardless:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
