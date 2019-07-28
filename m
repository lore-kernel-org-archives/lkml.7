Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8948C7618B
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 09:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C243A2075C
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 09:59:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FRl0zJAK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbfG1J7j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 05:59:39 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43056 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbfG1J7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 05:59:39 -0400
Received: by mail-lf1-f66.google.com with SMTP id c19so39964033lfm.10
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2019 02:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TT2iQ+fh+yLVfA5XCASIgHgqymw+iJWW639N0+0UQAE=;
        b=FRl0zJAKpwfKOlbX9Q5cPuWYSDRbmQE6DNbukn1h3ogrfsflueUFSgzjLc2SzfKJmR
         E+m+RKFJGXHGTQxCbHHEAUyvrMW/i27uOzMblM7E39IlLXNUZipq1sxXEr1Ao0deWM61
         TGd1Y3wy9ZkJPV1km0kHVQPpc60PiIcjgjN1kqdkGKmSX4gtr3WNxQ/oUIpud41n0A0z
         2WMIZKD+ZSBh3LQUlMhvfTu+Wqewi0XFx2CrquUtFg2bV6LD/CUto6RiC6XIFhhKnWrQ
         NXoh3Wji7vjpIauRm10bkwehuX0zeLTsL8XU3nQZMZkod6NRP4C6u/6Okl1ooGbx/yI9
         1Lcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TT2iQ+fh+yLVfA5XCASIgHgqymw+iJWW639N0+0UQAE=;
        b=P58F7bIM5rxMBLjpZL7CUcVEoW8dVlThxqcOEUbXCSNiWDK7rAQsWVlSJiUzN2vHKJ
         448yPZZUiwyIh3H+qUZUP4cvLoRoUapeL0WSCDh3q6ARJLP7IXw6/1/f0b9+kE7sU6fJ
         Qa8S16oq+wGCToWK5OMJaY58vs0cTRVC7rACyNZbvXzgohNmPPiTB7Wbum2c1oLLiYT8
         YnM7j6xsPb2bV1djcFEJXWwD6kqdcDVhCCPPk3+t+fEbeIYiula30sU7QNZpBr8eN1e8
         tUK1WeqfE87kglFxfjovRS22IslZafgiuPXcuH9zWkfWwwbpzPHZvVyPy/vo10rkOgUb
         4ayQ==
X-Gm-Message-State: APjAAAXDiBnYMSFqNJ81XDZe1X9JotEDeUmWLsT7eLs8udOFe5c+AXwE
        hnn41Xz3Gfwe3Le+gR0aruoWbqcNHhpc6en07sbzEg==
X-Google-Smtp-Source: APXvYqxkR2GcWRl3K2H831/69AeuP+bZxZIVeB/0pJPp/XlfvJyMah1IjsUVQhTN/o7bF6FNas2xCMlAk3GX6qDHTY0=
X-Received: by 2002:a19:6a01:: with SMTP id u1mr48506198lfu.141.1564307977519;
 Sun, 28 Jul 2019 02:59:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190628161419.26439-1-colin.king@canonical.com>
In-Reply-To: <20190628161419.26439-1-colin.king@canonical.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 28 Jul 2019 11:59:26 +0200
Message-ID: <CACRpkdZvmbCkfCn=PqREp=v7bB7OaGG9+B8_PG5+nK_=CRWM8w@mail.gmail.com>
Subject: Re: [PATCH][next] gpio: bd70528: fix spelling misstake "debouce" -> "debounce"
To:     Colin King <colin.king@canonical.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lee Jones <lee.jones@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 6:14 PM Colin King <colin.king@canonical.com> wrote:

> From: Colin Ian King <colin.king@canonical.com>
>
> There is a spelling mistake in a dev_err message. Fix it.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Patch applied.

Yours,
Linus Walleij
