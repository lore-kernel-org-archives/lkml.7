Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2062AC43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 09:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5AC02072D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 09:09:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QxrcLPRw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbfLIJJL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 04:09:11 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40103 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbfLIJJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 04:09:11 -0500
Received: by mail-ed1-f67.google.com with SMTP id c93so11998921edf.7
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 01:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aCP8xBJNYpnf/1dnrNzIPwstnt7b+cav5lYl114Has8=;
        b=QxrcLPRwutgSkdxFZcVhw/H+pmf15454jhen7PwHu4adM2JzRwyRCL+hDj/1Pa8ElO
         BjuPZdBMeLKwxH1CzU7cnx06SyVh3Ef0kPtri3UjJbjwcBns5U26jwtYLmY7s7IHUkBq
         z5uzAtjccTNr6wKa45ON6PC+loJsuyLu1EEganFUEpN23pY0Dh7odVLl/uJYudxov5Fd
         f/J1Ao6RSNV1jFmGA6THZQaroOyHPwEE43z/D0PYrxZEJvMlGHxQTb31kJLbwRwzDENa
         b8u4X4ygTcgr5xzH0iZyJvH9C6oz7pM/tgWc3YXecvifpXpeb1dxHLN5EUpGqih1HV9s
         YjIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aCP8xBJNYpnf/1dnrNzIPwstnt7b+cav5lYl114Has8=;
        b=KEwjD1L6gMEU4zUzNE9PW06M3b2cyR145Q8va0larxB0XihQjRYsK8NfvRsXfyjijD
         8uv/hxOg99lXspDIAjJsSvg6lvHlorbk2pJ/QT6MS6C5DApbt9QArJ2z9YxjQoFWTT+p
         zHSIFHX5qc2UnAk9cDq/QgUDoUjR6hWHt0GRAa4AxIULdBc/3vUhu3xklEkb8tygU5OU
         2gxN/LN4h/HQ1lzIE67W1YxpafPH8QvXQQNkFj3aCrPBVELqnV8C2KvDvLOuNzlINCC9
         SwcqprvH9np6WysypxLrk4pT+ZW4ghp0g2jnpNo/6GoFN2wm7iCFI28GLlrv7rwwQjQL
         s33A==
X-Gm-Message-State: APjAAAUtozDPL+fGeT+sdoOHerA2xVvVSETCMbkegvINBnzLo+eQg3BU
        RIvb+j2F2y4Q0/WlhVMDbCCiwG+8aCbd068t+wNrz5hErkg=
X-Google-Smtp-Source: APXvYqwIifXO3dcemjWp4SowjBSW0nR3WId3LsF2WbWmMqyzZtsf1qfL6GCtN0CU/ATK25v2S/R70O6SQEWZ8y0SnBw=
X-Received: by 2002:aa7:d897:: with SMTP id u23mr31341542edq.50.1575882549444;
 Mon, 09 Dec 2019 01:09:09 -0800 (PST)
MIME-Version: 1.0
References: <20191116151308.17817-1-hslester96@gmail.com> <20191209090020.GG3468@dell>
In-Reply-To: <20191209090020.GG3468@dell>
From:   Chuhong Yuan <hslester96@gmail.com>
Date:   Mon, 9 Dec 2019 17:09:01 +0800
Message-ID: <CANhBUQ2+ogNxA7OGM87igDrCSfbhvCzV5HEzQUWgDqwuMHBE3Q@mail.gmail.com>
Subject: Re: [PATCH] mfd: sm501: fix mismatches of request_mem_region
To:     Lee Jones <lee.jones@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 9, 2019 at 5:00 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Sat, 16 Nov 2019, Chuhong Yuan wrote:
>
> > This driver misuses release_resource + kfree to match request_mem_regio=
n,
> > which is incorrect.
> > The right way is to use release_mem_region.
> > Replace the mismatched calls with the right ones to fix it.
> >
> > Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> > ---
> >  drivers/mfd/sm501.c | 19 +++++++------------
> >  1 file changed, 7 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/mfd/sm501.c b/drivers/mfd/sm501.c
> > index 154270f8d8d7..e49787e6bb93 100644
> > --- a/drivers/mfd/sm501.c
> > +++ b/drivers/mfd/sm501.c
> > @@ -1086,8 +1086,7 @@ static int sm501_register_gpio(struct sm501_devda=
ta *sm)
> >       iounmap(gpio->regs);
> >
> >   err_claimed:
> > -     release_resource(gpio->regs_res);
> > -     kfree(gpio->regs_res);
> > +     release_mem_region(iobase, 0x20);
> >
> >       return ret;
> >  }
> > @@ -1095,6 +1094,7 @@ static int sm501_register_gpio(struct sm501_devda=
ta *sm)
> >  static void sm501_gpio_remove(struct sm501_devdata *sm)
> >  {
> >       struct sm501_gpio *gpio =3D &sm->gpio;
> > +     resource_size_t iobase =3D sm->io_res->start + SM501_GPIO;
>
> Shouldn't this be 'struct resource *'?
>

sm501_register_gpio() uses resource_size_t, so I use the same type in remov=
e.

> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> Linaro Services Technical Lead
> Linaro.org =E2=94=82 Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
