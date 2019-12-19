Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD5EC3F68F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 13:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04A53218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 13:17:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="LFUH1vdr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbfLSNR2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 08:17:28 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:46294 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbfLSNR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 08:17:27 -0500
Received: by mail-io1-f68.google.com with SMTP id t26so5667736ioi.13
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 05:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jw4pmutuy+Vq97iclaQ8+r0oYbBvDyG4Nv1qzyzsrWU=;
        b=LFUH1vdr/zB8R4iQUX1VdCJ5DJbOKe7GdTOH3PkFeydwmE7naIinE52ec+tOae3k/x
         kSQS/nO31+WMKhPzYbamyaOj0rObU6yFQ7ODCYON+v2cBs5M0vgSeL3NFDTgmoZS660p
         UXyaIiQkMBm6ssxqh9nlTRlHsu4WQwZHPQK11HTs5GxXnFZofQcFBQLpZpSi6uyqamu/
         DZtEFUYLWUbb1RCtYp0ZG9XbbY+m4H5Rs/BMfCWQoKOdH7ZBGMhpaSbJzWJW2rOp3lE8
         3cyR6LWuVLfGIfEnXWYG0dLqFHSo79RbSftItp1+9DGtTXVoeQgp9W5xjlqaoKOd650E
         WVVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jw4pmutuy+Vq97iclaQ8+r0oYbBvDyG4Nv1qzyzsrWU=;
        b=EnlIqn0LN4G/dcUAEuaBRmHJIMcCKjVWQgEUrt+IouNqq3dsXCWGvzgGODFWAbTFmP
         MGv8Rhx4d+64l9k4CwuCiUeYYnjMb149vA9uUqSO9w1o54RmJfpwSGlCH+spx8hj9VyD
         Zx/zHJYA2Wu4NQhsUM10RaWeZYwtnSMQ6Fz1Gp9sXW/SJgfIlg19RVobTODDdV29p5gj
         Qbz2X5tAQiW+d0nSGdxpFXqX3og9GyFpb6PdS+0zKL2GK/g/7pphc7PvusBXMcaf7KPZ
         eR2XkdKwOUumMJGx162OW/VggbQJ3zhs1YqE/RplC5BYt5BMlZr6p2E3MQh0EGLxh4v/
         UxGQ==
X-Gm-Message-State: APjAAAVw5jUB+tnVNnxmcK/xP9qseoMtoc5kIKZJW6lNJmJ8uRMwXTdj
        ZTtNodI+Sa/G4FTcFQMhVTSvExQljLrslw6KJZFo7fto
X-Google-Smtp-Source: APXvYqwvNyyAhHwXAbfyd3QPNsoCzCD1REk3C8Va6CVWCncIMlprP/hrEm3OHy84MRRJ8VpUBzSY/wXGzh0D6GLiUfY=
X-Received: by 2002:a02:c85b:: with SMTP id r27mr6964167jao.57.1576761446932;
 Thu, 19 Dec 2019 05:17:26 -0800 (PST)
MIME-Version: 1.0
References: <20191204155941.17814-1-brgl@bgdev.pl> <CAHp75VdiAtHtdrUP2EmLULh86oO37ha8si10gFKYRavXCEwRRQ@mail.gmail.com>
 <CAMpxmJVXVVVMPA_hRbs3mUsFs=s_VtQK9SvvYK3Xc5X27NPTKw@mail.gmail.com>
 <CAHp75VfXc88Fa6=zs=9iToz27QdXHqRCDPQwBPs2P-rsBF8nHw@mail.gmail.com>
 <CAMRc=Me4xWsQggmr=BvJrA9-FnPkxFkOYsRTsSXCtyNwFnsHNw@mail.gmail.com>
 <CAHp75VfzP8-0wKmPTTKYe+fc6=r_4sVcJPyOsM8YTuH=i4rxmA@mail.gmail.com>
 <CAMRc=MfxteQDmeZn_Et0uFs2cPvLGpJ5BTeBOn37o=2Oo_eU=Q@mail.gmail.com>
 <CAHp75VfeEB5RudwMaoiMTMMY3zW-kz-h=rJ3Cu5_tyRL6ZuF1w@mail.gmail.com>
 <CAMRc=Mcy=Q+9Eb6mb5JEq+CCbxgBY1CfTDsYj1Rt9bcLXgeY=g@mail.gmail.com> <20191219131249.GA12008@firefly>
In-Reply-To: <20191219131249.GA12008@firefly>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 19 Dec 2019 14:17:16 +0100
Message-ID: <CAMRc=MfS49ENPS=ousx0EY-_-HM7QGtevknb9PBkewcbk7YJ4Q@mail.gmail.com>
Subject: Re: [PATCH v2 10/11] gpiolib: add new ioctl() for monitoring changes
 in line info
To:     Kent Gibson <warthog618@gmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

czw., 19 gru 2019 o 14:13 Kent Gibson <warthog618@gmail.com> napisa=C5=82(a=
):
>
> On Thu, Dec 19, 2019 at 02:05:19PM +0100, Bartosz Golaszewski wrote:
> > wt., 10 gru 2019 o 18:00 Andy Shevchenko <andy.shevchenko@gmail.com> na=
pisa=C5=82(a):
> > >
> > > > On a different note: why would endianness be an issue here? 32-bit
> > > > variables with 64-bit alignment should still be in the same place i=
n
> > > > memory, right?
> > >
> > > With explicit padding, yes.
> > >
> > > > Any reason not to use __packed for this structure and not deal with
> > > > this whole compat mess?
> > >
> > > Have been suggested that explicit padding is better approach.
> > > (See my answer to Kent)
> > >
> > > > I also noticed that my change will only allow user-space to read on=
e
> > > > event at a time which seems to be a regression with regard to the
> > > > current implementation. I probably need to address this too.
> > >
> > > Yes, but we have to have ABI v2 in place.
> >
> > Hi Andy,
> >
> > I was playing with some ideas for the new ABI and noticed that on
> > 64-bit architecture the size of struct gpiochip_info is reported to be
> > 68 bytes, not 72 as I would expect. Is implicit alignment padding not
> > applied to a struct if there's a non-64bit-aligned 32-bit field at the
> > end of it? Is there something I'm missing here?
> >
>
> Struct alignment is based on the size of the largest element.
> The largest element of struct gpiopchip_info is a __u32, so the struct
> gets 32-bit alignment, even on 64-bit.
>
> The structs with the problems all contain a __u64, and so get padded out
> to a 64-bit boundary.
>

Thanks for the clarification, now it makes sense. I assumed memory
alignment depends on the architecture. I need to educate myself more
on this subject I guess.

Bart
