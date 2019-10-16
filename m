Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 566BFFA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 12:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 214FF2168B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 12:57:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g+hwROET"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393378AbfJPM5N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 08:57:13 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39324 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393368AbfJPM5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 08:57:12 -0400
Received: by mail-qk1-f193.google.com with SMTP id 4so22598868qki.6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 05:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iKYnCxXI+enDKKpRO1ujL8VETmHUaDu3E+T33R6ISPM=;
        b=g+hwROET54h2vndrV5UvySYq7yp4qvTU86tqp4hmxXDtqKunS2ZAkElaa58Q5b4Q8D
         M1ywHBIht82QXc0sQVnbrPHvj/77gY5eosNK8hQ57ufu93BZWmbfvHTwXMyNa6fnpzXa
         1PN3FvGDq+leBePGK/7aSGNWvUDLqMkfCcbyiVYHfRQtVyXktxQg8UuNek2nnYs/epA9
         LTtVGWlzRReML6keZeXR3wcPzCm8eQWLQk3G/4OKsBlnUS3D94qdF20EvR61SCA9XRva
         ssR4DyZSN19wIDjz3MgR9L2lJCmq5uSYaMwXvKF0seOtB1wgHwYAWSVCE58/8T/cafDj
         cjzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iKYnCxXI+enDKKpRO1ujL8VETmHUaDu3E+T33R6ISPM=;
        b=Lf3kbjwZQdlfQ0W+aHOl0qS5HxTylc08RCjWIq5Q5Gkn2J+p1xaXx8kLJZY0CFzqrc
         I4FXGu2WOwMV3ItZ8biph5em5jpmEevSP1vSoMVQIzyZ6L8sbQR99+wTjg+pp/jL+RlR
         /POP3I5Qa5BhiJgJPEwbgSs4S73kPM7oXMxmwMqShJhJ0PrkHid6AEYlVIG20mwOmMVr
         Mcv21K5RbdC/HKXSTP91ejk2rll6b+SkHUZprZ+GiAiMC7eHy65UPCdJMfQQDFtC7aQ1
         74zzsXAkuKlOg1B7eH3pUBB42+kgZMqkqlCFCuKKGZHJs/lAQ42fFEZHUd86ffjza9Ub
         DGWQ==
X-Gm-Message-State: APjAAAWeTOVHMepvtpT7E+Szn1kWhz1YhHedYxv02ohI1d4nxX/mHVyx
        S6u0CEj/FXuNzcpjozGTYCnpvyKqDzm21P5Ivb76PA==
X-Google-Smtp-Source: APXvYqznfR9xVNBpGb36Jsp8fvtPYC6w0IX8Z65LGupMXk2zMNyuYFGC3dG8oecpreWNjUjM4OyYtcubd/IaRbgJffA=
X-Received: by 2002:a05:620a:34b:: with SMTP id t11mr38227900qkm.213.1571230629198;
 Wed, 16 Oct 2019 05:57:09 -0700 (PDT)
MIME-Version: 1.0
References: <20191007033200.13443-1-brgl@bgdev.pl> <20191014081220.GK4545@dell>
In-Reply-To: <20191014081220.GK4545@dell>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 16 Oct 2019 14:56:57 +0200
Message-ID: <CACRpkda9Kco-bVPw1OA6FMpQ1L8dZ4WFJ227wTCM9rh5JE7-+A@mail.gmail.com>
Subject: Re: [PATCH v5 0/7] backlight: gpio: simplify the driver
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2019 at 10:12 AM Lee Jones <lee.jones@linaro.org> wrote:

> >  arch/sh/boards/mach-ecovec24/setup.c         |  33 ++++--
>
> I guess we're just waiting for the SH Acks now?

The one maintainer with this board is probably overloaded.

I would say just apply it, it can't hold back the entire series.

Yours,
Linus Walleij
