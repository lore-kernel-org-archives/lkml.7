Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE318C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 09:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8126F205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 09:00:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="IwHbmKd1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbfLKJAs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 04:00:48 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:39249 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbfLKJAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 04:00:48 -0500
Received: by mail-il1-f195.google.com with SMTP id n1so4230238ilm.6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 01:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2+SYstpsmRi699Er2ILUdweEKga8FQwyz0HU6eHs/8I=;
        b=IwHbmKd13ezqDoJQKy/R4uH/seWKHnooxINFFwbmpezCSMZljv4E3PCroyLKAWIN0f
         sGEIRZgER84lrSw1/zoEEqb7RtskZH042OKXa1zJ4mu9xZ7rF0dHfh7ZoRiY3M2nWut2
         YfRLREnbFrp1LzcjUoDZNPmvTEkm+MZMQD2zun/vCuFa+OSWOWy5xsE671nkA3AGhnzE
         qE2q9UpXoBaLX25CWWGbZc8tp8kVGFtFvDI+bZvgOx5NFhgNytMaCOBf5bxI08Ibzoqb
         aSmZ0SWiqvfvHczdB4CnqJu/KSXEUYQyaMtxeVxxD4wPtdrlvITbaupnu3ZExEUducyE
         Y7mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2+SYstpsmRi699Er2ILUdweEKga8FQwyz0HU6eHs/8I=;
        b=qO8jThveD4TK7EoZdDgtBZlMsfiWuzEQEkrtEnY6C6BKSvbImtHGCQQoGM8tPxYgFa
         jrIfErQJBBB6Al63oXQcHXSIv1MOFNQ0CeD+ovDI2RlVkmAIf3of8Q2rqjWx7tjLMCdE
         NNLLV7Q26rlTCqpcY4bQM6FknP6FDGQedQ/JmbBKJGd9FjXP2lWS+/0LBjwchhpAkur4
         8lG1gtpTQrUevAEIdv5DnbKoXRLkyuNt6QW/5Eds3thdpOXzTUS63W3gLAAV8xDWLr2P
         TNpJV/UYXC/JWKCzwEpS1/F8cVbOGX7rIW00HDmWOYFAqc8NrgmcMFggzEOjzVocJgxa
         j1Hw==
X-Gm-Message-State: APjAAAU71JqMUB582ur4y3kso0MWCfzQLJx3n2Dk5jwQuiFYObznXBjQ
        v4+CIcGbQzDubcG3sv4M5YdztRCn23saQ+mVGunj8A==
X-Google-Smtp-Source: APXvYqyS8LbG6E9XAOLBdtoQz17koiZIDdSIvdrNjQdPQytPutaWJbkQvz86NlpCKRGX6jndFGkwt+ExRsJ4XqsAthk=
X-Received: by 2002:a92:49d1:: with SMTP id k78mr2145697ilg.6.1576054846070;
 Wed, 11 Dec 2019 01:00:46 -0800 (PST)
MIME-Version: 1.0
References: <20191211004631.8756-1-warthog618@gmail.com>
In-Reply-To: <20191211004631.8756-1-warthog618@gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 11 Dec 2019 10:00:35 +0100
Message-ID: <CAMRc=Mcr668LQVB5yUBdn523UdV4aYUrSYCg1VEokBTTuNxhdA@mail.gmail.com>
Subject: Re: [PATCH v2] gpio: gpio-mockup: Fix usage of new GPIO_LINE_DIRECTION
To:     Kent Gibson <warthog618@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bamvor Jian Zhang <bamv2005@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C5=9Br., 11 gru 2019 o 01:46 Kent Gibson <warthog618@gmail.com> napisa=C5=
=82(a):
>
> Restore the external behavior of gpio-mockup to what it was prior to the
> change to using GPIO_LINE_DIRECTION.
>
> Fixes: e42615ec233b ("gpio: Use new GPIO_LINE_DIRECTION")
> Signed-off-by: Kent Gibson <warthog618@gmail.com>
> ---
>
> Changes v1 -> v2:
>  - add Fixes tag.
>
> Fix a regression introduced in v5.5-rc1.
>
> The change to GPIO_LINE_DIRECTION reversed the polarity of the
> dir field within gpio-mockup.c, but overlooked inverting the value on
> initialization and when returned by gpio_mockup_get_direction.
> The latter is a bug.
> The former is a problem for tests which assume initial conditions,
> specifically the mockup used to initialize chips with all lines as inputs=
.
> That superficially appeared to be the case after the previous patch due
> to the bug in gpio_mockup_get_direction.
>
>  drivers/gpio/gpio-mockup.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>

Applied for fixes.

Thanks!
Bartosz
