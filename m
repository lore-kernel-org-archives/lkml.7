Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F6AC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 03:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 249DA2147C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 03:45:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wr2JJSyL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbfDDDpR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 23:45:17 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34465 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfDDDpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 23:45:16 -0400
Received: by mail-lj1-f193.google.com with SMTP id j89so767352ljb.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 20:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eUeZvnDeBoyszcIs3ZuOF/5bwu88onqAqlTbNkbTzeU=;
        b=Wr2JJSyLKpmO2o21aJgzN+PaKLmCDnWytFY9BKYnffhYZQ9dDPX4nV3xKM5mF3nCAZ
         Z5d1irVJVXsNJ+CwmSZeM+nlYyFq5jpey/qbedaMd/qMeuPtA0D2kIb7MQ/p7tHPuN9X
         i8HOtjN7czCQqDQ4SUzHk2O8qXZKx/gwXJdawSowQz0eIJW10I+JxRrtj0NQHsXMx3Sq
         /14VcIkmX04cPLafzlBATByLn0ZgTrpttPY2EORTySbOvJw+9wVyOArlnVvGLj12y5GG
         ExteHE2swD4mNWr0Kk9zpJCplh2NjeDq4x9LiooX5GumVEDmsEpti93nxQDeHjErGWoi
         rb2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eUeZvnDeBoyszcIs3ZuOF/5bwu88onqAqlTbNkbTzeU=;
        b=KakKgKWiP/3hOk4AZWLiGZ6IAFZGIxmoxwtf/MyM8j74GdR4IjJ2uTiAm+SqgWVdOW
         Wz+9CSLMZPj+eKNSEzJMxutrnv9MmT64wGlbWPeb+7SrZM6tlPpWC+SYoLeuk0kZ2K+m
         Tm0PYu/lrFxdkSSmelYi4DSYY09KQYqazIPb9NpGBmFb4HJGYDWMiULBG3LuhJpdhRta
         JUEOoFN1GMLmzdJHemmjUE+23vZW0y/iWoVV3nxuEbH2csAFjQzGsFJThNS1dwRyMCV/
         lt5plN6OLvzPmnSRif6LCsDuMNThNqpExd1N7x7V/UOqklTDOigO3x2jb0TV8UBgaqm2
         769g==
X-Gm-Message-State: APjAAAW3c1svgyVUCYM4ckEFgCiJK6O6eHb+FJqPtUvnMGdAwcpGoJ8z
        uUmQby8D+AS2g7difyK67zH3B1AiIciZ0VVx9t2i+Q==
X-Google-Smtp-Source: APXvYqxR3f/DHRmm5repc+ti8xgiRG/T3oJS+op3iOB/DxBVOFFsITMIUgjLZp4TNfRMCbLtUArxwsOjnpyZsNob4wo=
X-Received: by 2002:a2e:808e:: with SMTP id i14mr1948536ljg.103.1554349514482;
 Wed, 03 Apr 2019 20:45:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190318174228.18194-1-brgl@bgdev.pl> <20190318174228.18194-8-brgl@bgdev.pl>
In-Reply-To: <20190318174228.18194-8-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 4 Apr 2019 10:45:02 +0700
Message-ID: <CACRpkdaZ1M9DmAoHv_YdGxJKLPow9-kwuMR_mB4WeKfBvHrcSw@mail.gmail.com>
Subject: Re: [RESEND PATCH v6 07/11] power: supply: max77650: add support for
 battery charger
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Input <linux-input@vger.kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 12:42 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> Add basic support for the battery charger for max77650 PMIC.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This looks like a clean and good driver to me.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
