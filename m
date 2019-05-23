Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A65ECC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E6E620881
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:42:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ElJnN4SI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390057AbfEWTmm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 15:42:42 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:32928 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389690AbfEWTSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 15:18:51 -0400
Received: by mail-lf1-f66.google.com with SMTP id x132so5247281lfd.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 12:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7Xq8hDRQty0iPHxqWBmFMiHP5/NEYwgv6qrN0Vc4nP8=;
        b=ElJnN4SIqyVX33y7h7nGUs3agYvp1XeedQRemgpNbRIk5YlpyMiZcdC55lWgxLgh11
         KGA9kvQoiXXYs/58eF04FaDku2dDlD83wtRBSt+M6G1ZAh4arkTz+KAL9TD9eCPYRb/s
         Ml/yCA3Aye5kHbDL64GQjMNXaH7xxCsjKFKk57fS61mAwZZbM5zYQIgvTjCECVGeIZvS
         Vu8BchtkGC9SqVmc9zM+HUOnm3qts+3oDP4vc86hWfjkeMINYmjeEB+owqaNfIjKGnt1
         gaT8dQa9c8myhvRDjgnSpTJpspt1aTRyCZ621kdINUkw1wzbTQr7dwLOXa4U8fvDlT2D
         Gyvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7Xq8hDRQty0iPHxqWBmFMiHP5/NEYwgv6qrN0Vc4nP8=;
        b=QXrYLeaTU3fmuYLUhlUSOyrxHsaMSrkZoPxhmbjwOjNN7iqvlLqRjnMkZRud/++f+j
         Wj/+knWDCibAwlV7l2Ldb57JpBr7AjXTzOG35NxgqtXFpYs9Yf8KGtsvW2KfYzMhLRwu
         hXN19G5bzV0ohNKrK0ewFDnoe3W875I0200znJJjjBYWQUEghn+MGb6sZo2N/kHEh7jT
         aMjdhKNHLOY96xIJvUSx7B5eiWQ2MY6rz9/CIW/BfWZWC11IB11fiOEgEWacAhQiwZ/o
         PIoN4WpfCjt2C+XNfc4SorkUSt34XtoGxJ/npMtLWRyAUScMGwNZbX6YdazvP0N3sOHm
         Kaqw==
X-Gm-Message-State: APjAAAWXBd8NJR+r40HkpYVeUgTQ1UrGSiUodXmmJWRsRaGpcoUykZOy
        XxPavAFDsc2j3jfwaUu1WVq522psobZI0CUTnsAAAw==
X-Google-Smtp-Source: APXvYqw1XbYiFz5hQUalCxrVjKiO6TIO71hT0hyMX6W3pIGmpBG9+vju9MG+sHieuLq/jz7BZlnOc90KWMXZK2Bxibs=
X-Received: by 2002:a19:189:: with SMTP id 131mr46796309lfb.74.1558639129364;
 Thu, 23 May 2019 12:18:49 -0700 (PDT)
MIME-Version: 1.0
References: <1558338735-8444-1-git-send-email-amelie.delaunay@st.com>
 <20190522054833.GB4574@dell> <eb8425ec-989a-9701-7fee-61bd1d2b93c1@st.com>
 <20190522084133.GF4574@dell> <bc1b5f1d-23b0-141d-f58f-b54ac303fe20@st.com>
 <CACRpkdYmdpwEvCBrL6i1V+Zxd0OSpZmD8BJPSZu9jYNeJkoimQ@mail.gmail.com> <08ea97544018430caf53af36677902b7@SFHDAG3NODE2.st.com>
In-Reply-To: <08ea97544018430caf53af36677902b7@SFHDAG3NODE2.st.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 23 May 2019 21:18:37 +0200
Message-ID: <CACRpkdZLbMJ5dKiL9J1x=PozBVH777kNNABZi-n0LxD0BOp8mw@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: stmfx: Fix compile issue when CONFIG_OF_GPIO is
 not defined
To:     Amelie DELAUNAY <amelie.delaunay@st.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "kbuild-all@01.org" <kbuild-all@01.org>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 4:11 PM Amelie DELAUNAY <amelie.delaunay@st.com> wr=
ote:
> On 5/22/19 11:48 PM, Linus Walleij wrote:
> > On Wed, May 22, 2019 at 11:21 AM Amelie DELAUNAY <amelie.delaunay@st.co=
m> wrote:
> >
> >> ../drivers/pinctrl/pinctrl-stmfx.c:409:20: error:
> >> =E2=80=98pinconf_generic_dt_node_to_map_pin=E2=80=99 undeclared here (=
not in a function)
> >>     .dt_node_to_map =3D pinconf_generic_dt_node_to_map_pin,
> >>
> >> OF_GPIO depends on OF.
> >>
> >> So either
> >>       depends on OF || (OF && COMPILE_TEST)
> >> or
> >>       depends on OF || (OF_GPIO && COMPILE_TEST)
> >>
> >> and
> >>
> >>       select OF_GPIO
> >
> > I would use just:
> >
> > depends on OF_GPIO
> >
> > Because OF_GPIO already depends on OF, and
> > compile tests will not work without OF_GPIO which
> > require OF so...
> >
> > Besides it is what most other GPIO drivers do.
> >
> > So just keep that one line and drop the rest.
> >
> > Yours,
> > Linus Walleij
> >
>
> Ok so I can get rid of COMPILE_TEST ?
>         depends on I2C
>         depends on OF_GPIO
>         select GENERIC_PINCONF
>         select GPIOLIB_IRQCHIP
>         select MFD_STMFX

Yep just like that.

> Because I've no arch to balance COMPILE_TEST. Or maybe something like
>         depends on OF_GPIO && (OF || COMPILE_TEST)
> even if OF_GPIO && OF is redundant ?

COMPILE_TEST is just to make something available for testing
on other architectures, such as testing ARM-specific drivers
on x86.

With just OF_GPIO as dependency, it will be compile tested anyways
because x86 allyesconfig will enable OF and OF_GPIO, and also
all the STMFX drivers.

Yours,
Linus Walleij
