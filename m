Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 436A4C43215
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 08:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 251EC207FD
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 08:06:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbfKYIGh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 03:06:37 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:42746 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfKYIGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 03:06:37 -0500
Received: by mail-oi1-f195.google.com with SMTP id o12so12251234oic.9;
        Mon, 25 Nov 2019 00:06:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gAuJIv9yn4YXOSzk5PZReQ2dPQGSJ4vZoOY3jPtStjc=;
        b=QWyvj/CFps7CV2EU9tzcrwuhr5T+shDGdnNpPkBnIHKM+J+s84shb5PExAaVokpBzA
         Ekhu7Doqily5QBpaNCZ5cIb2T2Al5ggwTyxyxkOADyIKBLZr4cvEu1jduuuSxKE46QJb
         DwKFStZZRU5z5Alm0f7lrXILu6YcLBXIVdgB7o4l8R8PRdCLZN9LfEtwa/uxtbGUDAFk
         +pS2Ky1jn0oInBAocvzK1bWQFM23Mik1g+/nzoBdUVybx/IdKKGdsYf7ET3GBtMwEBQT
         cNrVppLAvfq+N2NSEbPwkfszD8aEp6WgGwsclImgYIow7eRdjpionZxpTVn/Tuipyr3k
         6pjQ==
X-Gm-Message-State: APjAAAVG7C3oNcQfKnn8Kx3PbaH9X5Aw/vWLI4KCrfoGWb3g7AeSIDuX
        bXqZBEquYhlqdXpA1M0y3uKPSnaYP2goQlS/qhc=
X-Google-Smtp-Source: APXvYqwpeDUhNSpQ/oCrYrAiLsRBMIpwYQpPGW9c/ztktaU9IBlgDfMBbUNbBU4Re6q5x3Nv2eZgOEhw4M2WPaFTbaU=
X-Received: by 2002:aca:3a86:: with SMTP id h128mr20980328oia.131.1574669195789;
 Mon, 25 Nov 2019 00:06:35 -0800 (PST)
MIME-Version: 1.0
References: <20191122101721.7222-1-jslaby@suse.cz>
In-Reply-To: <20191122101721.7222-1-jslaby@suse.cz>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 25 Nov 2019 09:06:24 +0100
Message-ID: <CAMuHMdXETD5azNxPgzzhbx_kNh93EN3a8q6FcEVBV=MvLXzYGw@mail.gmail.com>
Subject: Re: [PATCH] tty: don't crash in tty_init_dev when missing tty_port
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On Fri, Nov 22, 2019 at 11:20 AM Jiri Slaby <jslaby@suse.cz> wrote:
> We currently warn the user when tty->port is not set in tty_init_dev
> yet. The warning says that the kernel will crash later. And it really
> will only few lines below at:
> tty->port->itty = tty;
>
> So be nice and avoid the crash -- return an error instead. And update
> the warning.

As per Greg's comment on another patch in
https://lore.kernel.org/lkml/20191121135743.GA552517@kroah.com/,
that will still cause systems with panic-on-warn to reboot.

> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
> ---
>  drivers/tty/tty_io.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
> index cb6370906a6d..d9f54c7d94f2 100644
> --- a/drivers/tty/tty_io.c
> +++ b/drivers/tty/tty_io.c
> @@ -1345,9 +1345,12 @@ struct tty_struct *tty_init_dev(struct tty_driver *driver, int idx)
>         if (!tty->port)
>                 tty->port = driver->ports[idx];
>
> -       WARN_RATELIMIT(!tty->port,
> -                       "%s: %s driver does not set tty->port. This will crash the kernel later. Fix the driver!\n",
> -                       __func__, tty->driver->name);
> +       if (WARN_RATELIMIT(!tty->port,
> +                       "%s: %s driver does not set tty->port. This would crash the kernel. Fix the driver!\n",
> +                       __func__, tty->driver->name)) {
> +               retval = -EINVAL;
> +               goto err_release_lock;
> +       }
>
>         retval = tty_ldisc_lock(tty, 5 * HZ);
>         if (retval)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
