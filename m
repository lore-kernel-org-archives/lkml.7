Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0538FC282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB6532072A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:03:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="0n1pscxi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732848AbgAIQDY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 11:03:24 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:41198 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732830AbgAIQDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 11:03:22 -0500
Received: by mail-qv1-f65.google.com with SMTP id x1so3151764qvr.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 08:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=E1MKOCVOwb/QWH9ymW870ivoEvWZNM75twwy+HJECjA=;
        b=0n1pscxioDUMOfwhYFeCu4B4/sz6Dp3ab6Y+ojs3hzylVsi0xi1rlmLZKw6UxOAKiZ
         rWsqDdB7SGavyeR/Y6Njd6sugUJVQJxUhpZOyL2R8IWiS6Tafuovhh6LwZogSd2NQNmy
         nX9hGS7Yfnv3c94pfudRiN/Vfx54sy9RnUFC7FJoCmsQRt5l8LuCzdH4EiO6qNh5w9No
         PZH9sDoycwOjguBIysKCXoGgnULR9lNRtPeRedZX++XSd6JZ6X5Ru9zQGM5j755Bx6f/
         bmITQKZDwMGUlMC79MVrbN+8ac4Fve95GL3ojBKdnoVfDt4UxSUCr3LRYaN/h7Eb8uEc
         Z0GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=E1MKOCVOwb/QWH9ymW870ivoEvWZNM75twwy+HJECjA=;
        b=Z6D6SVsqkCCxlkr2RFTnkDWQ7DKG2epZP8biSv5sUOk74Rm+whV5F0WH9SwWqVwdCC
         cnsXu81f/xBGlAN5ZKwSzzni8BZQVFIkay3NFGq/xLNh8s6q9W0nZeF7TWAX+4Y/IDTt
         GxE21p2ThboagS47g9wsO7rddwWWu+nhgP6P5y2X8gJmxlXG8nJWhX8Gk91slLKzjLtA
         mTFS/FNZ79TZ9gymh2jtk8N8YeFwv6FBkctfgVNcxnwbZAMhLgCkt+ctiw/i75nxtNUP
         WPNNeljqv8zyK9NU4aQWr2B3FVPZ9/2krsB2aq9dcv8CNTC16LPbh5RiG777kegg67Lm
         En7w==
X-Gm-Message-State: APjAAAWZMJ1GgF2Hv1WylBzz+OEV+xJl6GPkY0s9ZuvnZ8vvUXP186Rw
        EXDT7hniNY2ljjlXpxt+6205a2MR1h5Xs2htY7IuJg==
X-Google-Smtp-Source: APXvYqzbUF6yNFe2ouyO8kGx5FzCuF51PjrvdvTJkwb9N22CfxtROz3Puvxf4LMB7y9X2LTr3+aHnzBVhArM11gviRA=
X-Received: by 2002:ad4:55e8:: with SMTP id bu8mr9583043qvb.61.1578585801550;
 Thu, 09 Jan 2020 08:03:21 -0800 (PST)
MIME-Version: 1.0
References: <20200109125627.24654-1-brgl@bgdev.pl> <CAK7LNASBLXzgy2=fGfyrGbbWq2wL7Y9uaSh-MQQcd7tpvUBbMg@mail.gmail.com>
In-Reply-To: <CAK7LNASBLXzgy2=fGfyrGbbWq2wL7Y9uaSh-MQQcd7tpvUBbMg@mail.gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Thu, 9 Jan 2020 17:03:09 +0100
Message-ID: <CAMpxmJX50pBQTDdsy=w1+uNQym+vGnZJiCrWBDmn0ti3igCjvQ@mail.gmail.com>
Subject: Re: [PATCH] kconfig: fix an "implicit declaration of function" warning
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

czw., 9 sty 2020 o 16:59 Masahiro Yamada <masahiroy@kernel.org> napisa=C5=
=82(a):
>
> On Thu, Jan 9, 2020 at 9:56 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> >
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > strncasecmp() & strcasecmp() functions are declared in strings.h, not
> > string.h. On most environments the former is implicitly included by
> > the latter but on some setups, building menuconfig results in the
> > following warning:
> >
> >   HOSTCC  scripts/kconfig/mconf.o
> > scripts/kconfig/mconf.c: In function =E2=80=98search_conf=E2=80=99:
> > scripts/kconfig/mconf.c:423:6: warning: implicit declaration of functio=
n =E2=80=98strncasecmp=E2=80=99 [-Wimplicit-function-declaration]
> >   if (strncasecmp(dialog_input_result, CONFIG_, strlen(CONFIG_)) =3D=3D=
 0)
> >       ^~~~~~~~~~~
> > scripts/kconfig/mconf.c: In function =E2=80=98main=E2=80=99:
> > scripts/kconfig/mconf.c:1021:8: warning: implicit declaration of functi=
on =E2=80=98strcasecmp=E2=80=99 [-Wimplicit-function-declaration]
> >    if (!strcasecmp(mode, "single_menu"))
> >         ^~~~~~~~~~
> >
> > Fix it by explicitly including strings.h.
> >
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> Thanks.
>
> I see strncasecmp() in
> scripts/kconfig/nconf.c too.
>
> Could you fix both in a single patch?
>
> You can try it with "make nconfig".

Sure. It seems gconf needs the same change too.

Bart
