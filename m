Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A6DCC2BD09
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 09:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3B9A2464D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 09:45:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="wxq0JeTd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729188AbfLEJpO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 04:45:14 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:38914 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728794AbfLEJpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 04:45:13 -0500
Received: by mail-il1-f194.google.com with SMTP id a7so2409420ild.6
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 01:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=34Yk9HvNolRmgsb9MDvApAfPhu7Lhp8WnNzDK/K5sLM=;
        b=wxq0JeTdLlkZsEjds2AQo/g8aqwpimef519Av/sCVEoKd93d2HrVpQyKKD02PoBA4+
         tlPhtxvom0uOuTlwTemb/AW0zsGDJGaCW0I+w0lLR6hcb55py8BbfWpL0v/4qHuA0NNq
         o/POPudLz0f8ODl4f6gjOF0VhY7mO44FgW5LF+LbftyeEOGduIF9XvBTgWmkvKsRi+ek
         opgsy2xpiI6wCiWGLemCgKCjiXXOqXZFFMAwVsLbDmPC70N1hIKEK7pzE/hN7F7LbRAO
         plhgywgA/iXQDicQR7I6m/DZqvy5xaCjUELo4CaSgxAJsXhFlw0Aezw7wPyOzwrOx5IW
         +KfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=34Yk9HvNolRmgsb9MDvApAfPhu7Lhp8WnNzDK/K5sLM=;
        b=fVEg0H8XWh7Gv0DIUWFuItSwVahBsepukCB+shCp8UURxmCgokiF2lfe94ftbE78+k
         FsXdMG7qglEU9arXN6GwYbXDt2mRG1rre5xStNgIUl1PoL8pnWq8FlcMnss9Buj0THsb
         r5xGabnMDfVALILfS2ufJAarxTiMGEJHnund4VLzKPoruQ6Vvxm7CNob0AdxKLSQJtQQ
         DqgoaPr9KVuIgVW81XftgYG/Kfwdje8IuM1B4YiTKI2LsqBNfozQdYZ89gLZHtWyJf1s
         WfWlu3qsmMaBJTekMOEVOYaik4kR1Zv7H6rhu4/lpHuMhZlsBxho7Ep1neYAB5qPa6tz
         E4jQ==
X-Gm-Message-State: APjAAAWSYGGBuouLd/iZSBUir25x314IRnOZGEU1ElGHmKzBymju5s7+
        XhNS7sVFbN6ii6PID9ie+/LUtaJw0XJkP8TN1OPcRg==
X-Google-Smtp-Source: APXvYqyaJs62qNDeDkAC++osN7qLymM6+eyNKpBZ68p+WvUJktR3CLR5aziZSSRxcB4H/o4IDDoTaElsld+EuC7Zrx8=
X-Received: by 2002:a92:49d1:: with SMTP id k78mr8373692ilg.6.1575539112879;
 Thu, 05 Dec 2019 01:45:12 -0800 (PST)
MIME-Version: 1.0
References: <20191204155941.17814-1-brgl@bgdev.pl> <20191204155941.17814-2-brgl@bgdev.pl>
 <CAHp75VcqYsKUzxGUhn8aHg_u-B=FkqmTU2YS+yyVNfAPu+715w@mail.gmail.com>
In-Reply-To: <CAHp75VcqYsKUzxGUhn8aHg_u-B=FkqmTU2YS+yyVNfAPu+715w@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 5 Dec 2019 10:45:01 +0100
Message-ID: <CAMRc=MfFLPJQ6zqSPEymzK0jbdMBNRZjD-PEjrs0G5Jy2f5skw@mail.gmail.com>
Subject: Re: [PATCH v2 11/11] tools: gpio: implement gpio-watch
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C5=9Br., 4 gru 2019 o 23:42 Andy Shevchenko <andy.shevchenko@gmail.com> na=
pisa=C5=82(a):
>
> On Wed, Dec 4, 2019 at 7:19 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> > Add a simple program that allows to test the new LINECHANGED_FD ioctl()=
.
>
> > --- a/tools/gpio/.gitignore
> > +++ b/tools/gpio/.gitignore
> > @@ -1,4 +1,5 @@
> >  gpio-event-mon
> >  gpio-hammer
> >  lsgpio
> > +gpio-watch
>
> Perhaps keep it sorted?
>

Sure I can do this.

> > +++ b/tools/gpio/gpio-watch.c
> > @@ -0,0 +1,112 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * gpio-watch - monitor unrequested lines for property changes using t=
he
> > + *              character device
> > + *
> > + * Copyright (C) 2019 BayLibre SAS
> > + * Author: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > + */
> > +
> > +#include <ctype.h>
> > +#include <errno.h>
> > +#include <fcntl.h>
> > +#include <linux/gpio.h>
> > +#include <poll.h>
> > +#include <stdbool.h>
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <string.h>
> > +#include <sys/ioctl.h>
> > +#include <unistd.h>
> > +
> > +static bool isnumber(const char *str)
> > +{
> > +       size_t sz =3D strlen(str);
> > +       int i;
> > +
> > +       for (i =3D 0; i < sz; i++) {
> > +               if (!isdigit(str[i]))
> > +                       return false;
> > +       }
> > +
> > +       return true;
> > +}
>
> strtoul() will do the same.
>
> char *p;
> unsigned long dummy; // do we need it?
> dummy =3D strtoul(..., &p);
> return *p =3D=3D '\0';

Yeah strtoul does allow for error checking. I'll change this in v3.

>
> > +int main(int argc, char **argv)
> > +{
> > +       struct gpioline_info_changed chg;
> > +       struct gpioline_info req;
> > +       struct pollfd pfd;
> > +       int fd, i, j, ret;
> > +       char *event;
> > +       ssize_t rd;
> > +
> > +       if (argc < 3)
> > +               goto err_usage;
> > +
> > +       fd =3D open(argv[1], O_RDWR | O_CLOEXEC);
> > +       if (fd < 0) {
> > +               perror("unable to open gpiochip");
> > +               return EXIT_FAILURE;
> > +       }
> > +
> > +       for (i =3D 0, j =3D 2; i < argc - 2; i++, j++) {
> > +               if (!isnumber(argv[j]))
> > +                       goto err_usage;
> > +
> > +               memset(&req, 0, sizeof(req));
> > +               req.line_offset =3D atoi(argv[j]);
>
> Oh, why not to call strtoul() directly?
>
> > +
> > +               ret =3D ioctl(fd, GPIO_GET_LINEINFO_WATCH_IOCTL, &req);
> > +               if (ret) {
> > +                       perror("unable to set up line watch");
>
> Don't you need to unwatch previously added ones?

Nah, we're exiting anyway, the fd will be released.

>
> > +                       return EXIT_FAILURE;
> > +               }
> > +       }
>
> > +       for (;;) {
> > +               ret =3D poll(&pfd, 1, 5000);
> > +               if (ret < 0) {
> > +                       perror("error polling the linechanged fd");
> > +                       return EXIT_FAILURE;
> > +               } else if (ret > 0) {
> > +                       memset(&chg, 0, sizeof(chg));
>
> > +                       rd =3D read(pfd.fd, &chg, sizeof(chg));
> > +                       if (rd < 0 || rd !=3D sizeof(chg)) {
> > +                               if (rd !=3D sizeof(chg))
> > +                                       errno =3D EIO;
> > +
> > +                               perror("error reading line change event=
");
> > +                               return EXIT_FAILURE;
> > +                       }
>
> Shouldn't we handle the -EINTR?

Indeed we should. Will fix.

Bart

>
> > +               }
> > +       }
> > +
> > +       return 0;
>
>
> --
> With Best Regards,
> Andy Shevchenko
