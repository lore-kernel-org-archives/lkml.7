Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD72EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:45:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A81020693
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:45:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pYTirofZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfCLPph (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 11:45:37 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40906 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbfCLPph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 11:45:37 -0400
Received: by mail-pg1-f194.google.com with SMTP id u9so2117604pgo.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 08:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/MANG8sTL8cvc7J/j4ubSXiHQx5KGict4pqdm4QN2hs=;
        b=pYTirofZZVPvZ1vmQB43GtYTpAZ68eVnBDjmlehGy7IT4umaCCc26Y/szOfxXTsX9j
         F/OaEFu3mieBNfbX8jNb5gh7fpXhO0642ZxENDipMEpJQuOqUmS8ER62TiCrkrlz8WnT
         Elcux2AgtbQN1xVpP5tm17+plezgsTHHVVE6Pcs/axvrfO2FsBwOJWB0w6eDILRlC7HA
         HgY6b/nA86RiQa1VzvE8fFmCoycO8HFXft8FftliB85ckv8b0QCR57uhivW6ZzrCG7gb
         SbIztl/Xf7YxTkegkQK5V7OAUy5AuWR3XPgh9PBr3ZbdiHMC7L5APOyl135YBud94tXG
         Mbjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/MANG8sTL8cvc7J/j4ubSXiHQx5KGict4pqdm4QN2hs=;
        b=M2rZCf3OAJEZk2XpNIv9Wjhd2tsSwQhsfJb8z/1/xtyLnIJwEbgbOW59HqKovQAbRR
         +T0fJ9ada15HT7PswdDajQdmkBIOzbpACKhYkyafc5frWRGJLuTSQtqRiI886hUuedvI
         0hlfl6SNV5Msg4USGVYum10w/BaAz8JwqQCmnXJO1xWqNBkSkDUjFGqDgn7nQrEinH7m
         JM4hs377+gNW5RyYshA0trMkwMQ+5E2CdaEr169fnwAmnfbqLrWbOZwXNRwU2MW4MA08
         1QWQGMyve0k6H1PCNDzXKLJ3FL8flr4+8CY4bQkloMrHpXy7r9A+OmWd0f4pWbTc3Zzi
         HCeQ==
X-Gm-Message-State: APjAAAUKSbQLD3khxMhEyb0j22Z7QhTD247mo//wqqLV3EofYCc+oha8
        jrZZNBnc54SE88vGK/EUqFSTcNZKV7gD6GNjj38=
X-Google-Smtp-Source: APXvYqyQzCf5H5ENfD2H4xUWMhJHv9duzpqwZg8LF1sepOiba86VuNrwDN5HObMXT19L/svMmjzvSsACnCCgEHyar7Y=
X-Received: by 2002:aa7:854d:: with SMTP id y13mr39131519pfn.175.1552405536124;
 Tue, 12 Mar 2019 08:45:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190301184816.784-1-mans@mansr.com> <20190301184816.784-3-mans@mansr.com>
In-Reply-To: <20190301184816.784-3-mans@mansr.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 12 Mar 2019 17:45:24 +0200
Message-ID: <CAHp75VfZUN0PVwveB9FM6QvyJicVE5WjCX3b5rfCGZOQs9hO8A@mail.gmail.com>
Subject: Re: [PATCH 3/3] auxdisplay: charlcd: make backlight initial state configurable
To:     Mans Rullgard <mans@mansr.com>
Cc:     Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 1, 2019 at 9:14 PM Mans Rullgard <mans@mansr.com> wrote:
>
> The charlcd driver currently flashes the backlight once on init.
> This may not be desirable.  Thus, add options for turning the
> backlight off or on as well.
>
> Signed-off-by: Mans Rullgard <mans@mansr.com>
> ---
>  drivers/auxdisplay/Kconfig   | 21 +++++++++++++++++++++
>  drivers/auxdisplay/charlcd.c | 10 +++++++++-
>  2 files changed, 30 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/auxdisplay/Kconfig b/drivers/auxdisplay/Kconfig
> index 7d3fe27d6868..c52c738e554a 100644
> --- a/drivers/auxdisplay/Kconfig
> +++ b/drivers/auxdisplay/Kconfig
> @@ -445,6 +445,27 @@ config PANEL_BOOT_MESSAGE
>           An empty message will only clear the display at driver init time. Any other
>           printf()-formatted message is valid with newline and escape codes.
>
> +choice
> +       prompt "Backlight initial state"
> +       default CHARLCD_BL_FLASH

LGTM, but I don't agree on this default. I would prefer either on or
off, not flashing for sure.
Though it seems the case before the patch...

> +
> +       config CHARLCD_BL_OFF
> +               bool "Off"
> +               help
> +                 Backlight is initially turned off
> +
> +       config CHARLCD_BL_ON
> +               bool "On"
> +               help
> +                 Backlight is initially turned on
> +
> +       config CHARLCD_BL_FLASH
> +               bool "Flash"
> +               help
> +                 Backlight is flashed briefly on init
> +
> +endchoice
> +
>  endif # AUXDISPLAY
>
>  config PANEL
> diff --git a/drivers/auxdisplay/charlcd.c b/drivers/auxdisplay/charlcd.c
> index db0356dca2d7..ff8c53c082ff 100644
> --- a/drivers/auxdisplay/charlcd.c
> +++ b/drivers/auxdisplay/charlcd.c
> @@ -769,6 +769,14 @@ static void charlcd_puts(struct charlcd *lcd, const char *s)
>  #define LCD_INIT_TEXT "Linux-" UTS_RELEASE "\n"
>  #endif
>
> +#ifdef CONFIG_CHARLCD_BL_ON
> +#define LCD_INIT_BL "\x1b[L+"
> +#elif defined (CONFIG_CHARLCD_BL_FLASH)
> +#define LCD_INIT_BL "\x1b[L*"

> +#else

I would rather put here defined(_OFF)...

> +#define LCD_INIT_BL "\x1b[L-"

...and do

#else
#define LCD_INIT_BL "" // or whatever stands for as-is

> +#endif
> +
>  /* initialize the LCD driver */
>  static int charlcd_init(struct charlcd *lcd)
>  {
> @@ -790,7 +798,7 @@ static int charlcd_init(struct charlcd *lcd)
>                 return ret;
>
>         /* display a short message */
> -       charlcd_puts(lcd, "\x1b[Lc\x1b[Lb\x1b[L*" LCD_INIT_TEXT);
> +       charlcd_puts(lcd, "\x1b[Lc\x1b[Lb" LCD_INIT_BL LCD_INIT_TEXT);
>
>         /* clear the display on the next device opening */
>         priv->must_clear = true;
> --
> 2.20.1
>


-- 
With Best Regards,
Andy Shevchenko
