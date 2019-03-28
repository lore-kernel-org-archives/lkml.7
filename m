Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4497C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7437821773
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:09:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cY7Icjzb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbfC1QJP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 12:09:15 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37476 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbfC1QJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 12:09:14 -0400
Received: by mail-lj1-f194.google.com with SMTP id v13so18170311ljk.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 09:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0ZBthnL9k7UVb8fXDdVB3PSaHNclvQgmPjT7eQRUXvY=;
        b=cY7IcjzbdGC4R9SR8N58J3BiHnGcLPEXQW35OuXLbWv61YwlfLY2x5lyD//10V12Jh
         y1KkSA1iXNeCvT9kjdwtAkPlZ5YiHoXhxSPolhXUbMVhp5Gq8jlok+F0oFvr/fI558Le
         hxbRqMaavX08tl6ivz7VHcFNezD4s/GSKG+sbvcXlBpH4i0comJRM9fHxVaXcOW5Ih6E
         N6NttvXO1sZxCS1yl9l+4ajDfJzEqrnoVD365NP2Ko9R4gBPdm59uDxaVPjQ0uXmGxV7
         vo3idSe1eJTB3er+R3sdHKFroL+otHPuTROo6yXGHmkIOlBfANUmH/qBpJeTr3PexdAx
         VPjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0ZBthnL9k7UVb8fXDdVB3PSaHNclvQgmPjT7eQRUXvY=;
        b=i+u1II/2VOcKQ4+XatuejQfJ20EklERwFNyK75s6NNtKaIkoEwLkKRsu7w6vEVGzg7
         JSsG8Zhbv3AnkNMF5UArjhqX/ZhqXoGNhzZBMSlwZWF7PhVnfq3Z9c72G9ns33p1leg8
         n0GTCT7Pc/v/WLvgWglGkg/xzS2tssgHTh+r56cLt4MZMwf8vTSxgfgvR+SsmHCTJZ23
         mFm6wNDh2O8eHIMAoi0hdQWEZ4bteK4tHmFlOb7YII+OozSarDo4wbEtInXFJyrpnkmZ
         dmZslqaBKmOFUyI6liPdYiRa+13Ze4cVUZkIxppxYYHgv56tYbq36+386/o2FB2mD7L/
         +O/g==
X-Gm-Message-State: APjAAAUSPbFaSoaUC/4EeOQecqwuDMit4RCrlY3/63A9BVH0nZ18aE2j
        J+xE/Hj9zvo2OJS4OhXQEE9d1gkbCmP2zi5ad0VKrQ==
X-Google-Smtp-Source: APXvYqwKHhdRRK23uRjykjrXccueVE2DHOB3d19ij8eABL5l3ydE1jzU+QQKDHn73+Z18WsQOleDHzGbyu2kt02XBC8=
X-Received: by 2002:a2e:5056:: with SMTP id v22mr24000076ljd.153.1553789352632;
 Thu, 28 Mar 2019 09:09:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190326063209.6421-1-andrew.smirnov@gmail.com>
In-Reply-To: <20190326063209.6421-1-andrew.smirnov@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 28 Mar 2019 17:08:59 +0100
Message-ID: <CACRpkdZLxr8JWTbhpKKxt-kciERAYUmDLiemFij30oJTjYeMiQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] gpio: of: Check propname before applying "cs-gpios" quirks
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Chris Healy <cphealy@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 7:32 AM Andrey Smirnov <andrew.smirnov@gmail.com> wrote:

> SPI GPIO device has more than just "cs-gpio" property in its node and
> would request those GPIOs as a part of its initialization. To avoid
> applying CS-specific quirk to all of them add a check to make sure
> that propname is "cs-gpios".
>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: linux-gpio@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org

Patch applied for fixes.

Sorry for my mistakes...

Yours,
Linus Walleij
