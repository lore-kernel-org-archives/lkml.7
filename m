Return-Path: <SRS0=Ba5y=Y3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F772CA9EB0
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 22:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 643532190F
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 22:30:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xv61OMy7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728220AbfKCWaZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Nov 2019 17:30:25 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44555 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728059AbfKCWaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 17:30:24 -0500
Received: by mail-lj1-f195.google.com with SMTP id g3so9403638ljl.11
        for <linux-kernel@vger.kernel.org>; Sun, 03 Nov 2019 14:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=37IsC1QYGxBYfZW5BvnzIGLjijvofWTFPrPML1ai3TE=;
        b=xv61OMy7HnCmcLqpeBquckd87P7nJi4UAXS/fJ/Hz2DjA48u2x5qTPs7j5L82y6mwa
         JAwShxCoFU+50UNj/SpQHFCppQGWfqSYKXE+bk8Xd1pSRK7EnDQYJWgRemQnZXFEbs8i
         mb++LMai+QyfBrih9AvQD3H0IsvwTFSgXi1Qo1K5ji0736ZNaAIji3RgI6ftuDGDE2kH
         I1grzgb2TSw1jbxE8k/AjXadIJcx7yGtyb3pm6j0zVyEdzgOTRRa8p1iYlyzWwVLCmzT
         dlShVoOreqcZANoVltSLTeiC0cHzt7yiJfI92HQ2x4Lj10gvjmJYw8gMMknPHGJTEmG0
         cz8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=37IsC1QYGxBYfZW5BvnzIGLjijvofWTFPrPML1ai3TE=;
        b=jhzvlBUOBws2F8wPCY7CNR+b7Tlb3Ajf0WXlWbcIjotaIwledBtqEE5MBjUIWjePDo
         F93ODVIx5qtjPqQSAeNiww4DOOeAGPlmZ9WlbHQg4DckYZgNVJgmCM/9xi2+WruX/7Da
         70Lm3zBSNQzxFGlv95Ia07tAZkWjMOoOQ8yLwr9EI7ZdI9ovVpFTt83EURUd6Hh+5C00
         J/PvomTetTBsn613HqvP787cFM1PfVM16hCxi80pl4mIzMU+2HDjQ4basmqyK5ESkazt
         7AK8ksYvb7K0JY4l1Pz+3Toipgqji0KfHVCFv6EK1Zk8zYYZT48X3mflH8EnB2gBz4/Z
         Pk/A==
X-Gm-Message-State: APjAAAVmHbmc3m4ONC9Mr/PqP/X1S+eNZLmxmHm9XK0ZeyWhyiGuj23Y
        ZM4xTJpzX05LiRIFCXhIyeqBs72iTvkggVl0wUSrwA==
X-Google-Smtp-Source: APXvYqwVg9mCs8V+YbBxGYd5H+o7zjgzBRtm+eVs9wqZnKUeUHaI8SATdFAn61fPpaWBK++YT2y7RJlFoFraFdF5Uus=
X-Received: by 2002:a2e:9a55:: with SMTP id k21mr2882628ljj.251.1572820221912;
 Sun, 03 Nov 2019 14:30:21 -0800 (PST)
MIME-Version: 1.0
References: <cover.1572606437.git.matti.vaittinen@fi.rohmeurope.com> <f08d265c12ebf185c0e1dbbfe0a3f86de4907194.1572606437.git.matti.vaittinen@fi.rohmeurope.com>
In-Reply-To: <f08d265c12ebf185c0e1dbbfe0a3f86de4907194.1572606437.git.matti.vaittinen@fi.rohmeurope.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 3 Nov 2019 23:30:10 +0100
Message-ID: <CACRpkdYhasTEQq2btQ_3GSo=hMJetp128jFo-6hE=JMeX4MJSA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 14/15] gpio: Add definition for GPIO direction
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-rtc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matti!

Good initiative (and I will see a ton of janitorial patches as a
result of this...)

On Fri, Nov 1, 2019 at 12:50 PM Matti Vaittinen
<matti.vaittinen@fi.rohmeurope.com> wrote:

> At least for me it is difficult to remember the meaning of GPIO
> direction values. Define GPIO_IN and GPIO_OUT so that occasional
> GPIO contributors would not need to always check the meaning of
> hard coded values 1 and 0.
>
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
(...)
> +#define GPIO_IN                1
> +#define GPIO_OUT       0

Please spell it out or people will be confused:

GPIO_LINE_DIRECTION_IN
GPIO_LINE_DIRECTION_OUT

Yours,
Linus Walleij
