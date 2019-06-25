Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAFC9C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 07:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A113120652
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 07:32:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="OpXv/aLA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728544AbfFYHcj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 03:32:39 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:42913 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727853AbfFYHcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 03:32:39 -0400
Received: by mail-io1-f67.google.com with SMTP id u19so942676ior.9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 00:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=itsUv/R5Z0LiFi8Ms96Myz65aYPzk0O9BRDX68lJ/Ic=;
        b=OpXv/aLA5bTcHGv1g4Y9H7GVufdq5venFQIX302ZPIzC8Bd2kRTQCz5Fzpup0FWNa9
         vPp24m4yGolOOfhuTnHxxKVwpY5DUSbq0dUpj1nFZ8GyFih2D3x7UjkcxFVnOgN8ajqO
         KSYnKEIvp0RpNryHcejYITXZgV+Kfh+ZOVkgvyqeSB9kAmRnJoOG/6HX9tlaa9xDgThM
         p3zvbr6nV4gYJh4215ls3Xxpd49pnoLKMs7R5PYhbpPvX/+t1VxiAPxJFXN1Yvp6t96x
         yibuzpCL1jEbvyJQ4RIjsmGpDQEU3Q8ypajVY0IJVt000ae5l4bP6ydCqyNdE+CXxghH
         EScQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=itsUv/R5Z0LiFi8Ms96Myz65aYPzk0O9BRDX68lJ/Ic=;
        b=FzEtRhjy/4fzz2sMXEsWUC3ezUzkvnqBlSQUBeI/Lrw0LASsXtsJkYexKqeDteqV9v
         KxPOqY2TX0uzyFUJ5CErey/HuaJ+fhW1h74pYPUYfvo5Zeg9o5jn10pueG2JZUdEuXTL
         Gu6qyVZ4IoxFy4JO8Rt7CAmU3VXtqz8I539qPHPuNNVtbqi7NrokfE81u7EYwDEbaGqq
         2L3SyIHdOKjj0tWHxl+q+cOrB9dXQEkGcGnRYwY55QaDosOKCtlshrhRLNDndKyMcLyt
         O3Npzu90xutCIigWh0cU9YGc8hzS8Ki9/k4FeeGaeTn3R0cHOdji+M/PNxTvzZmj7GPm
         yHCA==
X-Gm-Message-State: APjAAAXm7aforc9xkMYijGir72kx3Ko9QeGzVKnqn5SnodwzARe9JaAS
        lgecaINBR8kqwv0qoue/DEcFQYQtTka1GL/BC/gMRA==
X-Google-Smtp-Source: APXvYqw8JyLTQ0KTYV1boVSPAqZGTbHNJM3dDQ3L1045VnDaOLHeGbUnD4HBz+4tfaEqfikX3yTLopsf/476n+8H9cU=
X-Received: by 2002:a02:7715:: with SMTP id g21mr47384257jac.24.1561447958085;
 Tue, 25 Jun 2019 00:32:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190221162627.3476-1-brgl@bgdev.pl> <9efcbce2-4d49-7197-a3d8-0e83850892d5@web.de>
 <CAMpxmJX-wXQ-ff1RWkPmJBWSsP_v2MjZrA3fhj3HQX0_zM0eZA@mail.gmail.com>
 <39ae399a-c606-c6de-f84d-35e39d0410c0@metux.net> <CAMRc=McepqowJNi6ay6x9KKoHOC8aCxP_ob12SgbsnJU_sKQng@mail.gmail.com>
 <1dd52704-0e41-db31-33f4-c9f446a47344@metux.net> <CAMRc=Mfp85diy849r_8UHKS9eao26djrsMF0_iwE--d62mQ5jg@mail.gmail.com>
 <20190625073016.GA18381@kroah.com>
In-Reply-To: <20190625073016.GA18381@kroah.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 25 Jun 2019 09:32:27 +0200
Message-ID: <CAMRc=McPjPtDFL2m=n5fWm-fHvVbDzMopb9r=RkzS+TshMJBAQ@mail.gmail.com>
Subject: Re: [PATCH] drivers: Adjust scope for CONFIG_HAS_IOMEM before devm_platform_ioremap_resource()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Markus Elfring <Markus.Elfring@web.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Keerthy <j-keerthy@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wt., 25 cze 2019 o 09:30 Greg Kroah-Hartman
<gregkh@linuxfoundation.org> napisa=C5=82(a):
>
> On Tue, Jun 25, 2019 at 09:10:25AM +0200, Bartosz Golaszewski wrote:
> > pon., 24 cze 2019 o 20:22 Enrico Weigelt, metux IT consult
> > <lkml@metux.net> napisa=C5=82(a):
> > >
> > > On 24.06.19 12:46, Bartosz Golaszewski wrote:
> > >
> > > >> The patch seems pretty trivial and doesn't change any actual code,=
 so
> > > >> I don't see hard resons for rejecting it.
> > > >>
> > > >
> > > > In its current form it makes the code even less readable. The #ifde=
f
> > > > should actually be one line lower and touch the comment instead of =
the
> > > > EXPORT_SYMBOL() related to a different function.
> > >
> > > Okay, that missing newline should be fixed (as well as the extra one
> > > after the #ifdef). Besides that, I don't see any further problems.
> > >
> >
> > Are we sure this even changes something? Does kernel documentation get
> > generated according to current config options? I really think this
> > patch just pollutes the history for now apparent reason.
> >
> > Greg, could you give your opinion on this?
>
> Why are you all arguing with a all-but-instinguishable-from-a-bot
> persona about a patch that I will never apply?
>
> greg k-h

Oh so it's another troll then? Good to know, ignoring from now on.

Thanks,
Bart
