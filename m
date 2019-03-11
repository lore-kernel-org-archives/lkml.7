Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB89AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 12:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3A562075C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 12:09:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727318AbfCKMJj convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 08:09:39 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41876 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbfCKMJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 08:09:38 -0400
Received: by mail-qt1-f196.google.com with SMTP id v10so4651408qtp.8;
        Mon, 11 Mar 2019 05:09:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=F9xZ7hfJToXhyAYcSKA/tTjG0XHQ0y7p6x3W7IWJTDg=;
        b=NMh+gmt8QdFTuXDyMlRTCdrqn9zZ2pa2cCejboir/a76+bNM+rGxLSMDqos7EmTMMK
         qrPGtMGyPh8kyq7JsnG150Rw1sfRllp5pUO7Zee/f5iZzxHl1UkDtUq4Hi13MTGS+iv9
         lD7Zy0pb2wOKXpEhsTQs8FWmKMz6m5MfqcvySTdifHN0D0juJYBqNvsk8VSEAIRLvePL
         uRXHma51GqT+x7no98xGACkbYCq+g9L+Ac9b7LeiVn8PKY6KlfyMHuxzN5T4Kgx/QQ/I
         vI2YZM61g/o6xCCV1FWm+wRl1DbZJkqahvBTXzW7YYyp0K+qTQZdMCc8l/9+tW0tnveP
         uGBQ==
X-Gm-Message-State: APjAAAVuSDt0oOSdAtBki6J4NEGcvOG/c/M3fDzHhBSQosiZ4TxNoHRR
        amX4y5RUCoDmjrFKWzhCbyIHf7Pwo56CXXfOSSrOFw==
X-Google-Smtp-Source: APXvYqztZ1LN9QwC8KuvhbmvbC/BbCMhEsA+mp+WRDFqiGlIKnMIDbPC3PuO8L+x9dtWjgBfFTpvbII7PRCpNvBa/rc=
X-Received: by 2002:a0c:98c8:: with SMTP id g8mr25981737qvd.161.1552306177664;
 Mon, 11 Mar 2019 05:09:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190307103348.1591457-1-arnd@arndb.de> <CAMpxmJXpYtJp5eZfz1uCQfE8yg_uLzQxWNt9wKZ4uMzfckU2TQ@mail.gmail.com>
In-Reply-To: <CAMpxmJXpYtJp5eZfz1uCQfE8yg_uLzQxWNt9wKZ4uMzfckU2TQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 11 Mar 2019 13:09:21 +0100
Message-ID: <CAK8P3a1+yitZDApTkkz843NBhi++A54rupi_cBKa59K1XQ6N2Q@mail.gmail.com>
Subject: Re: [PATCH] gpio: omap: avoid clang warning
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Grygorii Strashko <grygorii.strashko@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tony Lindgren <tony@atomide.com>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 10:40 AM Bartosz Golaszewski
<bgolaszewski@baylibre.com> wrote:
> czw., 7 mar 2019 o 11:39 Arnd Bergmann <arnd@arndb.de> napisał(a):
> > clang warns about a tentative array definition in the gpio-omap driver:
> >
> > drivers/gpio/gpio-omap.c:1282:34: error: tentative array definition assumed to have one element [-Werror]
> > static const struct of_device_id omap_gpio_match[];
> >
> > It's best to just reorder the entire file to avoid forward declarations,
> > which lets us use the regular declaration. To do this, the unnecessary
> > CONFIG_OF check must also be removed.
> >

> > +static const struct dev_pm_ops gpio_pm_ops = {
> > +       SET_RUNTIME_PM_OPS(omap_gpio_runtime_suspend, omap_gpio_runtime_resume,
> > +                                                                       NULL)
> > +};
> > +
> >  static struct platform_driver omap_gpio_driver = {
> >         .probe          = omap_gpio_probe,
> >         .remove         = omap_gpio_remove,
> >         .driver         = {
> >                 .name   = "omap_gpio",
> >                 .pm     = &gpio_pm_ops,
> > -               .of_match_table = of_match_ptr(omap_gpio_match),
> > +               .of_match_table = omap_gpio_match,
>
> This doesn't seem like a logical part of this commit. Can you send a
> separate patch?
>
> Other than that, looks good to me.

This change has to be kept together the with removal of the #ifdef,
otherwise I'd introduce a new warning about an unused variable.

I could try to split out the reordering of the file though.

      Arnd
