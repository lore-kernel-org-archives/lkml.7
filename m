Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D754C48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 15:36:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB19F214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 15:36:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="peRBWqan"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfF0PgG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 11:36:06 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42082 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbfF0PgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 11:36:05 -0400
Received: by mail-qt1-f194.google.com with SMTP id s15so2877590qtk.9;
        Thu, 27 Jun 2019 08:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/typNmvfpo6n2nRWYXCSUtwpwFH0hbL1yifmGXDUXjA=;
        b=peRBWqan6O6qEXFrXMteK+MS/S6EgfTXZknPJIwL1M5qATYKuCAnVnswVGIz0kw/3l
         1eh1hRoMzqQpJPcZzgMzjbgit1Gd+w7m0vxVe6gzt7+gns0LL0Vvsu0FovJBw4qY3jBW
         cVCY/3llpZSz+tCeYEYkKg3W9++z02KrtN9gunaamIdgAVfZUxEDWsXSQbbDurVQ9CY0
         1XxBO8+i3JTX7cf7l9SLAlLSwFGYEWOgy0QMlwzfsSotEfr+dk8uGELV1Tkuf9V7cN0K
         kKVDbFZCz5bPh6NWJOuvrfrdiQSFy3dVPPNG0xmr9lRBFPgyR3pNflPytw8EHZZw4F67
         qPEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/typNmvfpo6n2nRWYXCSUtwpwFH0hbL1yifmGXDUXjA=;
        b=dk/33UOLxaB2yvvEYpEAET1hDquLob4Q5iFpteUpR4HZ1YGZXYwi5bNWBRa7mBAXwM
         VSs3X9UWpTeTEMIDbtyiS1GuL6pgJrmtRD4GH3yjjbMCLrZqCYR4OGmlC7pH3/c7wY7i
         8JQctS/uPNH7nbnU81UTtYHXb8eqN7Dsy4j+rvp9Xxus1HqOm9bWl6P9FhamieKHRLZz
         upOnD/IoFnf33znkyvp0ZMZhr6HXppk0QmQHq/uKOcgEWO1fJIiQssDMtAQVIwHBmRJa
         GBHXZi8uKkNqahiMFrGS6whP+LYSlngj7c9NG1jjul0lIlay0LKaKLOoD4d8LQzNigTt
         WYog==
X-Gm-Message-State: APjAAAWD6wVMLLxZFSbTDz54gVOa0U4Y4k+cC9Wswh6js/Acqw1goY1P
        2cQRwoic8xMWKM70zY9xOUuZAb5KyetXZFPnGHg=
X-Google-Smtp-Source: APXvYqwRhORZGW0V54k9ULDweW2/6DUQ4z65MN7Pekp9eOnYcCEx+B33+W4hd8MKVTFRI3t5MsdqRzBWYOChM2ngRfY=
X-Received: by 2002:ac8:336a:: with SMTP id u39mr3710752qta.178.1561649764161;
 Thu, 27 Jun 2019 08:36:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190624225312.131745-1-gwendal@chromium.org> <20190624225312.131745-3-gwendal@chromium.org>
 <CAD=FV=WYg8d8ZHqcH7LWsSXx5-9kNP+nC+eS84=XNdaZi_7_-w@mail.gmail.com>
In-Reply-To: <CAD=FV=WYg8d8ZHqcH7LWsSXx5-9kNP+nC+eS84=XNdaZi_7_-w@mail.gmail.com>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Thu, 27 Jun 2019 17:35:52 +0200
Message-ID: <CAFqH_52MDbGL+ixpf7bueLcdV_oo3AJ9iDZGfxVyga0W3VK25g@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] iio: cros_ec: Extend legacy support to ARM device
To:     Doug Anderson <dianders@chromium.org>
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Fabien Lahoudere <fabien.lahoudere@collabora.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Missatge de Doug Anderson <dianders@chromium.org> del dia dc., 26 de
juny 2019 a les 23:06:
>
> Hi,
>
> On Mon, Jun 24, 2019 at 3:53 PM Gwendal Grignou <gwendal@chromium.org> wrote:
> >
> > -static int read_ec_accel_data(struct cros_ec_accel_legacy_state *st,
> > -                             unsigned long scan_mask, s16 *data)
> > +int cros_ec_accel_legacy_read_cmd(struct iio_dev *indio_dev,
> > +                                 unsigned long scan_mask, s16 *data)
>
> As found by 0day (see https://crrev.com/c/1678822), the
> cros_ec_accel_legacy_read_cmd() should have been static.
>
> I presume this will cause less confusion if a maintainer just fixes
> this up when landing the patch so Gwendal shouldn't send out a new
> version to fix it.  ...but if this is not the case then yell!  :-)
>

As probably will go through the chrome-platform tree I'll fix this
when I apply the patch. No need to resend.

Gwendal, Doug, to have cros-ec-sensors legacy support for ARM in
upstream, could you spend 5 min reviewing the following patch?

https://lore.kernel.org/patchwork/patch/1094790/

I'll also test it.

Thanks,
~ Enric

> -Doug
