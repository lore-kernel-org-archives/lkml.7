Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4958C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 21:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABCED2075E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 21:25:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HuWuDr8v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbfDBVZP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 17:25:15 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:42845 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfDBVZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 17:25:15 -0400
Received: by mail-vk1-f194.google.com with SMTP id 195so3333848vkx.9
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 14:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aiVW2nKhpoR9W5BMDV3Lgo9ydGpTelkEyToedthx5ss=;
        b=HuWuDr8vajXYlKgRPVzZRXxu+rJtp6NKcFxFWUYuuuzRdYQaqHIjUUUyQ7HD5srYfY
         nj+CmGcAMThGvqWmVSvd/hDUW4VIWcv9J891XeUi3h7ph1qzFZ2Me+E4gprrXqupMTh2
         CcRP/Hlo556EM38PzEUHDwZW4CIaIIkvxW+mw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aiVW2nKhpoR9W5BMDV3Lgo9ydGpTelkEyToedthx5ss=;
        b=qyo5p5ZEnGU0dCt0p1AnBy13ZcZbgtrmSwYN4hdCYf+KMlzdXFGgEeUVP7vD7qSdxc
         LIsfajWgJkh8lykAkuZP3sieeswiUAZbbK9Igk0CB9jx1mBM5swCBL2EBKaqXfUxtlN4
         E9Q7QRD2edovKAErDvUsJDAJdlzJuDn+1wyz4vokmWRoOCmzwDTAaCUwfwFiCH6VXUyw
         tkwMwtjcrS+xpkcnCWEM/ey10dblbraV8hR8GMXkkUNPOS+AePaF7296flYC1TATZtRw
         tm6NGNyF11v+vaJn6imnP+sbOqp56R9/w2IzSqNqOPLnkKW0wjoibcWTTUQfWIvxVQaD
         dkIg==
X-Gm-Message-State: APjAAAWCPjxlvqEJ2hpDrU7q4NpT3ZOagWnY6edz+4CmRoA+otdvXp+6
        O34WLrMZcX+GQOn3e1zGstce4N1hlMQ=
X-Google-Smtp-Source: APXvYqz+IELYoHbLzgHM+Hf1Fe/r+5edohkN53TDPKam28VS1LW3P6x3MwQh9OMYgxkZaQTCc8zMjA==
X-Received: by 2002:a1f:8d45:: with SMTP id p66mr6384190vkd.21.1554240313647;
        Tue, 02 Apr 2019 14:25:13 -0700 (PDT)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com. [209.85.222.50])
        by smtp.gmail.com with ESMTPSA id b197sm17085288vkd.9.2019.04.02.14.25.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Apr 2019 14:25:11 -0700 (PDT)
Received: by mail-ua1-f50.google.com with SMTP id d5so4898170uan.6
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 14:25:10 -0700 (PDT)
X-Received: by 2002:ab0:2f8:: with SMTP id 111mr3192990uah.123.1554240310207;
 Tue, 02 Apr 2019 14:25:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190306214226.14598-1-tobin@kernel.org> <20190306214226.14598-2-tobin@kernel.org>
In-Reply-To: <20190306214226.14598-2-tobin@kernel.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 2 Apr 2019 14:24:59 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKs5PZquDwj3B_7P6UH7aahawDkTdf2RWooiuj1uJy4WQ@mail.gmail.com>
Message-ID: <CAGXu5jKs5PZquDwj3B_7P6UH7aahawDkTdf2RWooiuj1uJy4WQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] lib/test_printf: Add empty module_exit function
To:     "Tobin C. Harding" <tobin@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>, Jann Horn <jannh@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andy Lutomirski <luto@amacapital.net>,
        Daniel Micay <danielmicay@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 6, 2019 at 1:43 PM Tobin C. Harding <tobin@kernel.org> wrote:
>
> Currently the test_printf module does not have an exit function, this
> prevents the module from being unloaded.  If we cannot unload the
> module we cannot run the tests a second time.
>
> Add an empty exit function.
>
> Signed-off-by: Tobin C. Harding <tobin@kernel.org>

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  lib/test_printf.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/lib/test_printf.c b/lib/test_printf.c
> index 659b6cc0d483..601e8519319a 100644
> --- a/lib/test_printf.c
> +++ b/lib/test_printf.c
> @@ -615,5 +615,11 @@ test_printf_init(void)
>
>  module_init(test_printf_init);
>
> +static void __exit test_printf_exit(void)
> +{
> +}
> +
> +module_exit(test_printf_exit);
> +
>  MODULE_AUTHOR("Rasmus Villemoes <linux@rasmusvillemoes.dk>");
>  MODULE_LICENSE("GPL");
> --
> 2.20.1
>


-- 
Kees Cook
