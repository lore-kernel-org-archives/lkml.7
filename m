Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B95BC4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 17:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53D8D20823
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 17:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p4YvEa0n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729973AbfCYRqV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 13:46:21 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33538 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729548AbfCYRqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 13:46:20 -0400
Received: by mail-pg1-f194.google.com with SMTP id b12so6960244pgk.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 10:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kotx3JpfQwJdbdIZ+VEivD1Jn7i50+L9ykmxgVe65Ac=;
        b=p4YvEa0nVVJnRXGH6HWrhsYlDOk0YPkBGlbmRrZA0DR9VlzhtVxow0NNptxP7mS6MB
         QxG0Q3D2EhHKTp2eEOH308gX6ytMf0ewk8d8VCXJ0vDUD/8GR4R2knYVBSEl6z+k08/K
         vMBjTwuxNEcKu+TN2gofpV+63TVCA9Bt4VBoZkLkctSwpXFACmmuuxkPSWJghS4d4qqo
         BCCzQYifiMigqy2IbTfqmFGHCsDHzXWnH1tQRSCKKzIWZelX/jvdOdwcP6sO0zPbI1Tp
         5vDPt8CKMdlupTwARU2ln+MM9dyi8W16dj+A70KhlgUohIjkxGQns6ksEPI5kyIuUz7R
         5rjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kotx3JpfQwJdbdIZ+VEivD1Jn7i50+L9ykmxgVe65Ac=;
        b=m+hvPQjA6b9QID0NmllXTfeRcDAE0nJ/c6zvqIYQlYT0/3UcIBTeL/NM8O9VzFiPSa
         od0LB+m/FUvfYqQh+pwcJicmsnlLpeBcC4Tt4qGZCiqGGdRjw3GXFft0o/w6bXeZbLlv
         0AVD8upIW6LZpsmDDQmMjweRGET7aSHQmE0aJH6AX2AhzoyiZJqzP6mdl80Z0JwOms0P
         u/I16p+Sj5BI49dFFzJZLBMgk3qa55Wd445BLAoDuHCRf3GHTCexC6c2YfSVpf6grGKd
         zVG1RSSXHdtzCQ6dVkhmEeJSsh56ingzKDUyXughpzzKKjpAHhX4YgBERFliygB2Gphh
         4CQA==
X-Gm-Message-State: APjAAAU0/deK5/Rj96UMZR6Y3GeP9ERfHibSqHuMu8FnU7twkAuu8ttd
        NEvnpqoT5uOl13AZVC1QAWSo4iqy8nLyYucw2W9PpA==
X-Google-Smtp-Source: APXvYqxb7MetvyykLnAAyL8XA9NT4vWkq3+321BDw1z/JQauYtbOHp9eP0CWSIMtt8kxWjJIbQgooWdb0XBTf9Gg4hI=
X-Received: by 2002:a62:209c:: with SMTP id m28mr12404429pfj.94.1553535979413;
 Mon, 25 Mar 2019 10:46:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190322140503.123580-1-arnd@arndb.de>
In-Reply-To: <20190322140503.123580-1-arnd@arndb.de>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 25 Mar 2019 10:46:08 -0700
Message-ID: <CAKwvOd=9wtPP-vhLknpc7cjMrV=NZWQJFmqxOvGEyzRc2FrnCw@mail.gmail.com>
Subject: Re: [PATCH] bitrev: fix constant bitrev
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>,
        Zhao Qiang <qiang.zhao@nxp.com>,
        Yalin Wang <yalin.wang@sonymobile.com>,
        "# 3.4.x" <stable@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 7:05 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> clang points out with hundreds of warnings that the bitrev macros
> have a problem with constant input:
>
> drivers/hwmon/sht15.c:187:11: error: variable '__x' is uninitialized when used within its own initialization
>       [-Werror,-Wuninitialized]
>         u8 crc = bitrev8(data->val_status & 0x0F);
>                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> include/linux/bitrev.h:102:21: note: expanded from macro 'bitrev8'
>         __constant_bitrev8(__x) :                       \
>         ~~~~~~~~~~~~~~~~~~~^~~~
> include/linux/bitrev.h:67:11: note: expanded from macro '__constant_bitrev8'
>         u8 __x = x;                     \
>            ~~~   ^
>
> Both the bitrev and the __constant_bitrev macros use an internal variable
> named __x, which goes horribly wrong when passing one to the other.

Oh man, so if you have a macro that expands another macro, you can run
into this issue.  To see how this expands:
https://godbolt.org/z/-khHN3

>
> The obvious fix is to rename one of the variables, so this adds an
> extra '_'.
>
> It seems we got away with this because
> - there are only a few drivers using bitrev macros
> - usually there are no constant arguments to those
> - when they are constant, they tend to be either 0 or (unsigned)-1
>   (drivers/isdn/i4l/isdnhdlc.o, drivers/iio/amplifiers/ad8366.c)
>   and give the correct result by pure chance.
>
> In fact, the only driver that I could find that gets different results
> with this is drivers/net/wan/slic_ds26522.c, which in turn is a driver
> for fairly rare hardware (adding the maintainer to Cc for testing).
>
> Cc: Zhao Qiang <qiang.zhao@nxp.com>
> Cc: Yalin Wang <yalin.wang@sonymobile.com>
> Cc: stable@vger.kernel.org
> Fixes: 556d2f055bf6 ("ARM: 8187/1: add CONFIG_HAVE_ARCH_BITREVERSE to support rbit instruction")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

I would have preferred to just name it `y` rather than keep tacking on
underscores, but it doesn't matter what color the bikeshed is.  Thanks
for the patch.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  include/linux/bitrev.h | 46 +++++++++++++++++++++---------------------
>  1 file changed, 23 insertions(+), 23 deletions(-)
>
> diff --git a/include/linux/bitrev.h b/include/linux/bitrev.h
> index 50fb0dee23e8..d35b8ec1c485 100644
> --- a/include/linux/bitrev.h
> +++ b/include/linux/bitrev.h
> @@ -34,41 +34,41 @@ static inline u32 __bitrev32(u32 x)
>
>  #define __constant_bitrev32(x) \
>  ({                                     \
> -       u32 __x = x;                    \
> -       __x = (__x >> 16) | (__x << 16);        \
> -       __x = ((__x & (u32)0xFF00FF00UL) >> 8) | ((__x & (u32)0x00FF00FFUL) << 8);      \
> -       __x = ((__x & (u32)0xF0F0F0F0UL) >> 4) | ((__x & (u32)0x0F0F0F0FUL) << 4);      \
> -       __x = ((__x & (u32)0xCCCCCCCCUL) >> 2) | ((__x & (u32)0x33333333UL) << 2);      \
> -       __x = ((__x & (u32)0xAAAAAAAAUL) >> 1) | ((__x & (u32)0x55555555UL) << 1);      \
> -       __x;                                                            \
> +       u32 ___x = x;                   \
> +       ___x = (___x >> 16) | (___x << 16);     \
> +       ___x = ((___x & (u32)0xFF00FF00UL) >> 8) | ((___x & (u32)0x00FF00FFUL) << 8);   \
> +       ___x = ((___x & (u32)0xF0F0F0F0UL) >> 4) | ((___x & (u32)0x0F0F0F0FUL) << 4);   \
> +       ___x = ((___x & (u32)0xCCCCCCCCUL) >> 2) | ((___x & (u32)0x33333333UL) << 2);   \
> +       ___x = ((___x & (u32)0xAAAAAAAAUL) >> 1) | ((___x & (u32)0x55555555UL) << 1);   \
> +       ___x;                                                           \
>  })
>
>  #define __constant_bitrev16(x) \
>  ({                                     \
> -       u16 __x = x;                    \
> -       __x = (__x >> 8) | (__x << 8);  \
> -       __x = ((__x & (u16)0xF0F0U) >> 4) | ((__x & (u16)0x0F0FU) << 4);        \
> -       __x = ((__x & (u16)0xCCCCU) >> 2) | ((__x & (u16)0x3333U) << 2);        \
> -       __x = ((__x & (u16)0xAAAAU) >> 1) | ((__x & (u16)0x5555U) << 1);        \
> -       __x;                                                            \
> +       u16 ___x = x;                   \
> +       ___x = (___x >> 8) | (___x << 8);       \
> +       ___x = ((___x & (u16)0xF0F0U) >> 4) | ((___x & (u16)0x0F0FU) << 4);     \
> +       ___x = ((___x & (u16)0xCCCCU) >> 2) | ((___x & (u16)0x3333U) << 2);     \
> +       ___x = ((___x & (u16)0xAAAAU) >> 1) | ((___x & (u16)0x5555U) << 1);     \
> +       ___x;                                                           \
>  })
>
>  #define __constant_bitrev8x4(x) \
>  ({                     \
> -       u32 __x = x;    \
> -       __x = ((__x & (u32)0xF0F0F0F0UL) >> 4) | ((__x & (u32)0x0F0F0F0FUL) << 4);      \
> -       __x = ((__x & (u32)0xCCCCCCCCUL) >> 2) | ((__x & (u32)0x33333333UL) << 2);      \
> -       __x = ((__x & (u32)0xAAAAAAAAUL) >> 1) | ((__x & (u32)0x55555555UL) << 1);      \
> -       __x;                                                            \
> +       u32 ___x = x;   \
> +       ___x = ((___x & (u32)0xF0F0F0F0UL) >> 4) | ((___x & (u32)0x0F0F0F0FUL) << 4);   \
> +       ___x = ((___x & (u32)0xCCCCCCCCUL) >> 2) | ((___x & (u32)0x33333333UL) << 2);   \
> +       ___x = ((___x & (u32)0xAAAAAAAAUL) >> 1) | ((___x & (u32)0x55555555UL) << 1);   \
> +       ___x;                                                           \
>  })
>
>  #define __constant_bitrev8(x)  \
>  ({                                     \
> -       u8 __x = x;                     \
> -       __x = (__x >> 4) | (__x << 4);  \
> -       __x = ((__x & (u8)0xCCU) >> 2) | ((__x & (u8)0x33U) << 2);      \
> -       __x = ((__x & (u8)0xAAU) >> 1) | ((__x & (u8)0x55U) << 1);      \
> -       __x;                                                            \
> +       u8 ___x = x;                    \
> +       ___x = (___x >> 4) | (___x << 4);       \
> +       ___x = ((___x & (u8)0xCCU) >> 2) | ((___x & (u8)0x33U) << 2);   \
> +       ___x = ((___x & (u8)0xAAU) >> 1) | ((___x & (u8)0x55U) << 1);   \
> +       ___x;                                                           \
>  })
>
>  #define bitrev32(x) \
> --
> 2.20.0
>


-- 
Thanks,
~Nick Desaulniers
