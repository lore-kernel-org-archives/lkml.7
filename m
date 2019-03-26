Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EB0EC10F05
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 09:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37FA6205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 09:57:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730594AbfCZJ51 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 05:57:27 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42378 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbfCZJ51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 05:57:27 -0400
Received: by mail-qt1-f196.google.com with SMTP id p20so13748254qtc.9;
        Tue, 26 Mar 2019 02:57:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8KvjqeSSqbC04C3LIgDbyYxPpt5HK6VT6BIsK2ZdRys=;
        b=bPg0b3jpQs7vnCY5XjgkT3G3lIDO+ol9TK/6kVhcSJ8W5QhbiXdkDceAgEi3pIb2uJ
         i+HeTOCaXMqfgbAe6w76ME+RB7cA3Lw1MuidwvqKMwJhWDumWUZQl0ne5gqNL29boJ5/
         UfS9znz785lhTiwLr7/35+hSFbLbVqIG+cW6LEre2ypx6IADhYbcXvKaB085uJ1qG9AU
         bTVckOPui8Yb31mQ6b6/h8wcjHQYoAc41ScTHUI/hnkifdyJnsUZCpgmTdxsPZY1Ts8j
         gI9+iG7BgbBOvmSfzx3V48hKJffMB7ZpN+gotWIJyr/vrA2oQ5SK7BphsG6AMPwrzONj
         odSQ==
X-Gm-Message-State: APjAAAVk/w0CrhoLWAKlqWKOtZH1y6YlOsqeLELqyOTgmbLtf1Oybduf
        W1Ajp5Lqg+r8Z+6+VuyFu0jrbz+uthw94gunAe0=
X-Google-Smtp-Source: APXvYqwZHnQM/uyPTZOW8HWKmtu5qhFOHGRK8ewONmKQpTvIvyLra8xT3kYAaOdqsVimlDivWJu16UdFiZNxH+9mOv0=
X-Received: by 2002:ac8:276b:: with SMTP id h40mr24715280qth.319.1553594246052;
 Tue, 26 Mar 2019 02:57:26 -0700 (PDT)
MIME-Version: 1.0
References: <1553591536-3760-1-git-send-email-sugaya.taichi@socionext.com>
In-Reply-To: <1553591536-3760-1-git-send-email-sugaya.taichi@socionext.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 26 Mar 2019 10:57:08 +0100
Message-ID: <CAK8P3a0Sx5vxbserW27KMPYnpLabPkGJZ_2iuW9y082oHiO+aQ@mail.gmail.com>
Subject: Re: [PATCH] serial: Add Milbeaut serial control
To:     Sugaya Taichi <sugaya.taichi@socionext.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Takao Orito <orito.takao@socionext.com>,
        Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
        Shinji Kanematsu <kanematsu.shinji@socionext.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 10:13 AM Sugaya Taichi
<sugaya.taichi@socionext.com> wrote:

>
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index 72966bc..961519b 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -1582,6 +1582,32 @@ config SERIAL_RDA_CONSOLE
>           Say 'Y' here if you wish to use the RDA8810PL UART as the system
>           console. Only earlycon is implemented currently.
>
> +config SERIAL_MILBEAUT_USIO
> +       tristate "Milbeaut USIO/UART serial port support"
> +       depends on ARCH_MILBEAUT
> +       default y
> +       select SERIAL_CORE
> +       help
> +         This selects the USIO/UART IP found in Socionext Milbeaut SoCs.

In general, it would be good to make it possible to build this on
other architectures for better compile test coverage, e.g. like

config SERIAL_MILBEAUT_USIO
     tristate "Milbeaut USIO/UART serial port support"
     depends on ARCH_MILBEAUT || COMPILE_TEST
     default ARCH_MILBEAUT

You might need additional dependencies like 'depends on OF'
to make this work reliably.

        Arnd
