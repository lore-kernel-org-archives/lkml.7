Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1119EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 13:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFAAE20823
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 13:42:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="cpITTTRU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbfC1Nmh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 09:42:37 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:38782 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfC1Nmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 09:42:37 -0400
Received: by mail-it1-f196.google.com with SMTP id f22so6094262ita.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 06:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=R4P29u6Uz9SuzHLemH5CpW+FoEUA4myY+cAQMUd0kss=;
        b=cpITTTRUiS2tTI9TU1JdphdML3QHpXWabOQGdOfvKgu/R98aSPaZwLIF2lUUnqVSK1
         Ins1ADnFkGtGoBwpG70ULYeU4WOwQw6cNXRoBPXVS8FxbcFuk9aEmNtJckLkc1naHXNd
         nX6Sc1JrZWb5v/j4AOThESiomBTWBdcz5LmqARCOcYLb2W7cMCgRlH49LI1OM7hUqDt2
         UEpH0JiLfb9BhIhWexcvXyr6lolPfGc0TN5wtaQHiDaW6lHaj2wIOtPKj/Hn9ig2R8Od
         /uDMrVJG1fyIKswm59pWOYxp70OnY7RL6S2B8YNUJJjsLcKORKqgWueAobrA6cTSYhIY
         PTag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=R4P29u6Uz9SuzHLemH5CpW+FoEUA4myY+cAQMUd0kss=;
        b=Cxxp/Alw7PbXdcaabiawLdIGe6Ws3cwA+B+ONzVHnTgFicR8S6PcxAcjvKhsDxP/lR
         r+IEV9qX4lM7jrLIdpMM0m9LFgxbt1vpbLfTGeZDLYG01/2eetvaXf8zI0+RT+RnV6ZT
         J2cDMNAUwy4du8tlG/37yXmd2gyd15sJgdjBbb9L977+7cfmtgiDuiEI5zQE9Kbb+pd9
         mO5LjcLC/hEuYbD3aNII9buqJimdI+m2qEP4qmzD2bPJdxrez1Fb4ZwP74RnAhqsZ652
         MGZP89986SWJuhAZ3Yi8ECH9xak6HXiYk+FhpQNWQh1UFAGFj9iP/Ew/ujwoqUTcvlNH
         O0zQ==
X-Gm-Message-State: APjAAAWo95uNrNr/iCgp0OehybfCwI6GAXMwL8B8l8Kqso3+LRQ+zp8k
        qE8X5fry4oZ/jSSIjHPhNBiKy9EW8wlIzE1gbhppCQ==
X-Google-Smtp-Source: APXvYqzV2tXQadH36BuPJNtrfOUike3GUcQkYSV55Sm8ayt9N9HfQWzfu0hRqKlJDWa7pnuOzmibQEms86+dMQ4jpyk=
X-Received: by 2002:a24:3d8f:: with SMTP id n137mr68531itn.96.1553780556404;
 Thu, 28 Mar 2019 06:42:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190328110043.13391-1-brgl@bgdev.pl> <c3ecb2d9-55eb-fc74-a08a-bbd5c5018cb8@codeaurora.org>
In-Reply-To: <c3ecb2d9-55eb-fc74-a08a-bbd5c5018cb8@codeaurora.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 28 Mar 2019 14:42:25 +0100
Message-ID: <CAMRc=Md8EOBf-TjxELGx5PGnuvGF9kR8oe_qHxxQgaN_vKv+Vg@mail.gmail.com>
Subject: Re: [PATCH] gpio: mockup: use simple_read_from_buffer() in debugfs
 read callback
To:     Mukesh Ojha <mojha@codeaurora.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

czw., 28 mar 2019 o 14:11 Mukesh Ojha <mojha@codeaurora.org> napisa=C5=82(a=
):
>
>
> On 3/28/2019 4:30 PM, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > Calling read() for a single byte read will return 2 currently. Use
> > simple_read_from_buffer() which correctly handles all sizes.
> >
> > Fixes: 2a9e27408e12 ("gpio: mockup: rework debugfs interface")
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > ---
> >   drivers/gpio/gpio-mockup.c | 7 +------
> >   1 file changed, 1 insertion(+), 6 deletions(-)
> >
> > diff --git a/drivers/gpio/gpio-mockup.c b/drivers/gpio/gpio-mockup.c
> > index 74ba8b1d71d8..859585dce5c9 100644
> > --- a/drivers/gpio/gpio-mockup.c
> > +++ b/drivers/gpio/gpio-mockup.c
> > @@ -219,12 +219,7 @@ static ssize_t gpio_mockup_debugfs_read(struct fil=
e *file,
> >       val =3D gpio_mockup_get(gc, priv->offset);
> >       cnt =3D snprintf(buf, sizeof(buf), "%d\n", val);
>
>
> why \n is inserted in the buf..
>

Because this is how all the attributes work - you read the value + '\n'.

> rv variable is unused now.
>
> >
> > -     rv =3D copy_to_user(usr_buf, buf, cnt);
> > -     if (rv)
> > -             return rv;
> > -
> > -     *ppos +=3D cnt;
> > -     return cnt;
> > +     return simple_read_from_buffer(usr_buf, size, ppos, buf, cnt);
>
>
>
> Looks good to me.
> Remove the unused variable.
>

Thanks, removed that and a stray newline.

Bart

> Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
>
> -Mukesh
>
> >   }
> >
> >   static ssize_t gpio_mockup_debugfs_write(struct file *file,
