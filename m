Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31523C2D0B1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 22:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA81420661
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 22:30:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hEz2cc1O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728477AbfLDWa1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 17:30:27 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42707 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728071AbfLDWa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 17:30:27 -0500
Received: by mail-pf1-f194.google.com with SMTP id 4so538804pfz.9;
        Wed, 04 Dec 2019 14:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VBLNFoYH92TCdemsAO1idBbzBiJrRygvmZ7BuKbQYOk=;
        b=hEz2cc1OzGElGCqF71IPxvuQ/Dp5NDujl9DXvfTc3l1VUlaBVTVt6xbcaXBQHEq2Ta
         04JsDOSM55IY4V8ZMSa+3b3XokW+U3NNSJPYZGRIZfNq7qFBUYcCkVGykg/IXeIg+f58
         AhxGoFA79YWBaaabUdQp9a3mBuL2+Gx1AQWCVUxtYIMthXx9eUpZshoNNhf0hApK7Mma
         /KoIm/eYe+oMc0FHjnTR5ZCQ3h57by0blGzU+V0D07VEC3duxz2BA1/JA4CQ5aGjEPBD
         7o3ppQKKOHgx+6IxqLEbHhfVgphUBKZDQfStGS5hkZnPtZafuHiGfX9syT8KJ/+r3tJb
         y+HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VBLNFoYH92TCdemsAO1idBbzBiJrRygvmZ7BuKbQYOk=;
        b=JylNhTNrRfEdTbO7FVRxUOYo6oEpCDnBGFdgw2gBGLmUgKedCefKp3t7XfDFtNoAzo
         riNQYitCcO1L2ZE6su42TtJv+Jjr0LT04xTN33ysRtDZAvKRewaUG1gT0BLY9yHzxeq5
         oUPXC6QNfO47Fpy0dXyCNMFwu+GolnLQqGL/sE3u0FDVUiGYV8/jAavmR5036x0Dqz4G
         Vg32M304XbYK3gnJU/UDnw/nMb7OBfDHvpmo3k0Ry96sHWl+Ke0ZmAdgd3bpn6io06Ef
         aTelihyz5PgVn8pkrYL4piJ1gRzaxMk2U/Q72ysLfkh6BBtD1MXcNNGTFAqRrfIL7sQU
         zQCA==
X-Gm-Message-State: APjAAAUv2sCxE6mK/yWynuo+Wp//CpEjtJL/NrzV102mcHujpKGnDiC5
        u1qhM4j8NPtgHnDyx87CdXShnr3A7G77ZpirQOQ=
X-Google-Smtp-Source: APXvYqyVhtP3+84lphisUzErWEXcMjFh889IPlSJ0rTOlbcSxURNqrHEITAZOMgrIBA9loeffDTjsrWFJvNYDXBNfDE=
X-Received: by 2002:a62:1944:: with SMTP id 65mr5970627pfz.151.1575498626804;
 Wed, 04 Dec 2019 14:30:26 -0800 (PST)
MIME-Version: 1.0
References: <20191204155912.17590-1-brgl@bgdev.pl> <20191204155912.17590-10-brgl@bgdev.pl>
In-Reply-To: <20191204155912.17590-10-brgl@bgdev.pl>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 5 Dec 2019 00:30:15 +0200
Message-ID: <CAHp75VfbwwDyxoZU2vHo7qo8E0rQdT3czC+Wpe7cqr5uoJVUwQ@mail.gmail.com>
Subject: Re: [PATCH v2 09/11] gpiolib: provide a dedicated function for
 setting lineinfo
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 4, 2019 at 6:02 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> We'll soon be filling out the gpioline_info structure in multiple
> places. Add a separate function that given a gpio_desc sets all relevant
> fields.

> +       if (desc->name) {
> +               strncpy(info->name, desc->name, sizeof(info->name));
> +               info->name[sizeof(info->name) - 1] = '\0';
> +       } else {
> +               info->name[0] = '\0';
> +       }
> +
> +       if (desc->label) {
> +               strncpy(info->consumer, desc->label, sizeof(info->consumer));
> +               info->consumer[sizeof(info->consumer) - 1] = '\0';
> +       } else {
> +               info->consumer[0] = '\0';
> +       }

I think we have to fix GCC warnings first and then do whatever this patch does.

-- 
With Best Regards,
Andy Shevchenko
