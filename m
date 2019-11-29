Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA850C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 10:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C12C2086A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 10:19:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QBfEobs7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbfK2KT2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 05:19:28 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35530 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbfK2KT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 05:19:28 -0500
Received: by mail-lj1-f193.google.com with SMTP id j6so22385757lja.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2019 02:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tpY2pLF0HAewtAE48D1xv731kjs5nuVhUrjH/3/vp2I=;
        b=QBfEobs7rG/ytrsdlTWoPADEwrTervnGvWy8SkJUm3ySK4Y3PSpVhXcygiwiTi5xSX
         Xul6YL7sVzHkWpxwAOOMFfDTdw1aWx0K/ixwh4o1BMeMLYejcabrPf93xrDZHTAepwvJ
         a4fvWJUUbXSjC35jBA+oZ56BtBw0FlMHN+qLqnTQ6YUmDgxBi2OyaeWSZfNcYppwataj
         SrZhV8KT8wOwp/BkdnOA5dzNdfeSS1NfzGF+rlB3qpp54yfdDC6yAm5Gtpn1VrylzY/o
         s/qVRxhh+/I/S0D7gFpxY6vYAgztO8V8Tfp1SsdkcQ1sFKrmTRVms/+PSKalH+7NKU3p
         TLmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tpY2pLF0HAewtAE48D1xv731kjs5nuVhUrjH/3/vp2I=;
        b=uBRN7LvTLz8773PwtFSRKo85iSAgCVCGa8mxpFg5JdV+ZGfnZuHUuaa3+qkFTs+iM/
         OoVpfvuod1sL5VJ6czaOxlc9wIuypeUlZd6+uuvIGbUNQu1tQGl7+7g2Sp+qRCFj0NfZ
         7zGrwCPYZfrUaBerOrjBeCAoT3Jmzd7XhQstGJuUGUoOz/xh3aNSieUf8Ybgu21jh+/+
         kdOkhXVSw4P1Sca3POUb0KMvgmZRs28S90HdQ1yHJbjCho0ScLTnDlLIoQtj25Z8aG32
         QZUXRUxDm/7IU0hCenGzXN8j0S8rU/pTtjaB1Tgs+jPFyQxsuQL+7fef1PgrC4vNpYOz
         n16A==
X-Gm-Message-State: APjAAAXtyR6W4RP/N5oGTlAjZrTdf1MoQed7/k+KTmwKTAXqAqVBL3La
        eBezXcSaw4dJYf1H71kNvXI9jJNUEvcWQu/yEmt5aA==
X-Google-Smtp-Source: APXvYqxN/Y4uVJgF3NNYfvlg1HzJfrX0YEMacBE5k98pOLhcoQOsyYFotp7sjXb0MK/jIgbMdD9NTndp/iqlTAdh7i4=
X-Received: by 2002:a05:651c:1049:: with SMTP id x9mr16248533ljm.233.1575022766281;
 Fri, 29 Nov 2019 02:19:26 -0800 (PST)
MIME-Version: 1.0
References: <20191127135932.7223-1-m.felsch@pengutronix.de>
 <20191127135932.7223-2-m.felsch@pengutronix.de> <CACRpkdbG=XiQHNZa+zBqdyTDRhyXD5rLxbLjp3qqGbcQeTX26Q@mail.gmail.com>
 <20191129101542.drtcn44twcyzxqmm@pengutronix.de>
In-Reply-To: <20191129101542.drtcn44twcyzxqmm@pengutronix.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 29 Nov 2019 11:19:14 +0100
Message-ID: <CACRpkda-mYbzxL9u-U9AHrFihtAQBaZajrQ-SN=WQH6=bg4swg@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] gpio: add support to get local gpio number
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, stwiss.opensource@diasemi.com,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 29, 2019 at 11:15 AM Marco Felsch <m.felsch@pengutronix.de> wrote:

> > What about renaming gpio_chip_hwgpio() everywhere
> > to gpiod_to_offet(), remove it from drivers/gpio/gpiolib.h
> > and export it in <linux/gpio/consumer.h> instead?
>
> That's also possible but then we have to include the consumer.h header
> within the gpiolib.c and this seems to be wrong. But since I'm not the
> maintainer it is up to you and Bart. Both ways are possible,

What about following the pattern by the clk subsystem and
create <linux/gpio/private.h> and put it there?

It should be an indication to people to not use these features
lightly. We can decorate the header file with some warnings.

Yours,
Linus Walleij
