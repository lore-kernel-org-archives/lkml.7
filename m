Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 573F4C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 09:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F9CE216E3
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 09:18:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dudxju8w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731173AbfFYJSj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 05:18:39 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:32958 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730620AbfFYJSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 05:18:38 -0400
Received: by mail-lj1-f194.google.com with SMTP id h10so15521407ljg.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 02:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t4qhaTHJZ+3VBU1sVx1P1bcNOnkqcH9GEq/1NAbRuaM=;
        b=dudxju8wkw9TnDww1MEY+prohp3emhDrV6fkIsizGs9ivSRezr09XAmqfYjzhFzVMU
         M7dAzWcIrqssTYQ+ntjda0GlaqnCFf3x8MqRLrGBB2pELALKPgRLTC96hz/QGoV5nGP3
         vQ+v+HCwhp3r+tZpxQ5nVhn7UVTGXadDPrevIgF0bafpI5g85m1kUYlXK7xsxEZGebTu
         u/CEYDoE6RcP+5AtgX3cltmInNUs7FXhX761Rm9Wk9qS3//cZYLbP84TOJGFDG9y5lOn
         Z40GhL86T6fir5q17T6MJR/rukojQMoAcghGapd2Wa8oQLWJvjHMdmsR6ogv9aMnWXOD
         h8lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t4qhaTHJZ+3VBU1sVx1P1bcNOnkqcH9GEq/1NAbRuaM=;
        b=KncUCWUYj24msgF5r49fnVEEmM4+ryMTM8dSR/sKrz9kOHcBDip6G7Jd3p42gufO+l
         RSyEiKe9SkWMs7VVQRWNRf/YOsbAic+LJ254rZB/xbVGAAmJGTaIjKntpQKWsTq0YH6w
         57Em1t1my2bJhQ8Mmnnt78wYsPoSbrZ5EEViioFA/+8skbnbXaFcNsxi+JhE/EuKE+Sb
         fitYhrIafaqkYHjCPWtzzrzNtETgZ4SJzsT3I07D0d3dv8MFQKA4HVxebHOyfdK10CiX
         DtboZOp+5bJC8C77N1ybttp3T62+7MJJz01RPuhCMLuEn/lNnqRBTJM18bDzasEsGjRS
         vj0w==
X-Gm-Message-State: APjAAAXQgFDX5mXgKjmVT39df0xma+O+gihJqfDYcVtdnfpattAPRWWm
        zrRq/NiX6EweWS9+nTYW2CyQ0oPzIWS9vqqc/Hu6nA==
X-Google-Smtp-Source: APXvYqzvk2RCfrRnXaXWwBrZIvYLYyUWEsxMZVmaEfW91r8is6s4PyLGcy8jnjPFrzrLe73W09Y89A9lRRIfkn3eSFk=
X-Received: by 2002:a2e:2c14:: with SMTP id s20mr15217716ljs.54.1561454316621;
 Tue, 25 Jun 2019 02:18:36 -0700 (PDT)
MIME-Version: 1.0
References: <1560796871-18560-1-git-send-email-info@metux.net>
In-Reply-To: <1560796871-18560-1-git-send-email-info@metux.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 25 Jun 2019 11:18:25 +0200
Message-ID: <CACRpkdYQXFd5q+k8aKWKK5krzq0KpCmo9fsUW8Dx3jHq1LHwhA@mail.gmail.com>
Subject: Re: [PATCH 01/30] include: linux: platform_device: more helpers for
 declaring platform drivers
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tien Hock Loh <thloh@altera.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        linux-tegra@vger.kernel.org, patches@opensource.cirrus.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 8:41 PM Enrico Weigelt, metux IT consult
<info@metux.net> wrote:

> From: Enrico Weigelt <info@metux.net>
>
> Add more helper macros for trivial driver init cases, similar to the
> already existing module_platform_driver()+friends - now for those which
> are initialized at other stages. Lots of drivers couldn't use the existing
> macros, as they need to be called at different init stages, eg. subsys,
> postcore, arch.
>
> This helps to further reduce driver init boilerplate.
>
> Signed-off-by: Enrico Weigelt <info@metux.net>

You need to send this to Greg as device core maintainer.
Possibly to Rafael as well, he did a very intersting rework
on device dependencies with device links.

While in general I agree that this diets down a lot of duplicate
code that we have done the same way over and over, there
is the issue that we don't want any drivers to do this mockery
and instead use deferred probe and ultimately just probe in the
right order.

I think device links were supposed to fix this up, but it indeed
assumes that you know of these dependencies before you
start probing the first driver, and often you do not, unless the
hardware description explicitly encodes that. And that is one
big problem.

If we should do this, device core changes must be merged or
explicitly ACKed first.

Yours,
Linus Walleij
