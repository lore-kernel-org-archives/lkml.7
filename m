Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48661C3A5A3
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 10:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15BA820850
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 10:03:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qqbt7Hg7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391682AbfHWKDM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 06:03:12 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38485 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729716AbfHWKDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 06:03:11 -0400
Received: by mail-lj1-f196.google.com with SMTP id x3so8324918lji.5
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 03:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nSBz+3Ajg0zUkEHOpalFy2yQQERAUt33EX4Z6O2112Q=;
        b=Qqbt7Hg7CVMJ++GMLAdQEdO5V9jYs6VU8k5Bb8ML6AnhICBExaR4DjFJFmQ0NzNuYg
         sbHDg5E0qPzUgFo/PS7UqlpYU8Q7IkC3yhgkNUVXiNT7Z9oy02pGpElc7Cx617GhQ5bT
         fdl4cZlVArIRQmvmtcE/+ktEuqhIdbU8oGRyAOaBsqRse5q6yZPnGYsjVFdMl84v9qFo
         i3jTov1EHj3JqU1+740PmIgYO2WxvE4K6zJihYHaEm3EX7eZZzTFuJrEyoYhVYCsesu5
         QCAUmZ5er+iYxYZj7EiDOTWvJFkXwQbA7pmT+eZy87XDQK9NC8sAyfNuMN3SXXZxfHIn
         bNIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nSBz+3Ajg0zUkEHOpalFy2yQQERAUt33EX4Z6O2112Q=;
        b=V05kpgceVXe08dVHB9H4UPhnkCPnInuGP4lEvKzL8A44gY/YvHvttRWr1MvcFHoCOz
         B4l0mvRnrWVFLT92n5RjaMuvblNunPr75PmnL9axQHsHX6ZxFJ3WxlSenYASuPsinGiS
         yuFODTRj+13Mnpk6dOeuJoGhBw7DaL+JqyrcloUjJqsQQubsAC5AQaxTozQk2U1KUPCv
         RVxWSj03GQdfdoK5Zzi+nb5z9iqJ99A2rgvg75O4ruItLHuQNG4jarnkYdEOsCN0O9wV
         drlFpDvX4h4FfmOds3lIjzmsx8kAHajbPtOOk8HyOOil8pW88anXP0dGkywQbNGaBu4R
         gObg==
X-Gm-Message-State: APjAAAVKvuGLJ3Qw0wEk5LK0FGWZ8lehb451CN1BlMRB7ZX1/TyBM96D
        ic/yGE/kkUFdoeB71MVs+UdYOfDX7Y9vnNd0iYQVlw==
X-Google-Smtp-Source: APXvYqxTjn97YdwzicnGq3IvnbKXlScd2i/LCcZyVhZZvRtC+Dg4mYSvpgp9/b3MPiBed4CvWtwmVE/lJdpaeT8Pa0g=
X-Received: by 2002:a2e:9903:: with SMTP id v3mr2446810lji.37.1566554589125;
 Fri, 23 Aug 2019 03:03:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190822204538.4791-1-christophe.jaillet@wanadoo.fr>
In-Reply-To: <20190822204538.4791-1-christophe.jaillet@wanadoo.fr>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 23 Aug 2019 12:02:57 +0200
Message-ID: <CACRpkdacDZTnT2myMrsPLMZYkonGbFu27nr_A1hgw1AKozMMgQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: ftgpio: Fix an error handling path in 'ftgpio_gpio_probe()'
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 22, 2019 at 10:45 PM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:

> If 'devm_kcalloc()' fails, we should go through the error handling path,
> should some clean-up be needed.
>
> Fixes: 42d9fc7176eb ("gpio: ftgpio: Pass irqchip when adding gpiochip")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Patch applied, thanks!

Yours,
Linus Waleij
