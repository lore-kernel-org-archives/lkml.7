Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2262C7618F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 22:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 896302075E
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 22:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BIE6GziP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbfG1WE3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 18:04:29 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46800 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbfG1WE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 18:04:28 -0400
Received: by mail-lj1-f193.google.com with SMTP id v24so56716946ljg.13
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2019 15:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kk27LH34PvQToQHwpyl6iPwl02xFmMQ5j5Bomd4bUHA=;
        b=BIE6GziPZgEJnAyvDHQ/i7eiVhYicQ+4TGYL3LIZ1FGo79J+EfngkwIAKGo7x7NlYx
         uLCC5+gAO6q9Uhtwb6RgprtR6y/kTocq0f84tH7frmUx3H0jcC2iC6oWlSoktycvoyaW
         eMGybC8RqnaYGn9Pqx68Hw5x+H4puqFM4DKTQQzAhiuLk4kz+cg0i0wqjvZ7SskX6IuN
         0IMoFuYnQyTMsQMR8cCLiWCZs7FvmyyO7tshL3za8/UCqyLiKuZHuq7WV5JLRC9FZCHK
         WwdduQZTZbvDiBPUwpWeXKqwkjLVNI5QaG2JROmFYSgod2FbizfdUHzT+jcPDK8k/f8A
         LcUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kk27LH34PvQToQHwpyl6iPwl02xFmMQ5j5Bomd4bUHA=;
        b=TgOuR56f8NF+JRuWoOnO2CTaE8zDtVPw+3T/oGlyuv4uQ18lxePqx3if0enXNJ+05m
         d6i0kFA5koPWjcLJquFBgSccQh/vXH58J2EuEaEf/idf8jLm1esxeNwJTytzk20awryb
         IdgvQalwS2ajZo0Y59CMhB6Wk9oBKHR5Rg+h9LIb5VXw0kH6Ybm3Z3KLH5TlncKHgDrj
         ucIKol6DpBAPr76CdoFpFeRJebIyekQfgFa9lonGcfzNErx/+wcnXAbv8TnZbyjwC1aM
         3EUdb4o7gzKb/n26maKfWJkX0iVo2TlKpe2OIvzIBut4wv+Au7EaVL4TzqO2vGF5O31V
         YMng==
X-Gm-Message-State: APjAAAW3QbQ74j1xz9Uagy0HNpZHWbXjFIe8jC8HZ1k0Z14gkRKUlMu6
        RyUVAFISlXOVF4NDhRtQ7QiZ2djEgz2XZeK0E8P2Xg==
X-Google-Smtp-Source: APXvYqzEhjR0PDkOZOsttahgmoIEM11iCTzzKxH0WYJApEBsjU9EY8w/dgGBwLo3VXwLXHoSfi94hrofG2r5gwj5+Ys=
X-Received: by 2002:a2e:2c14:: with SMTP id s20mr8034907ljs.54.1564351466852;
 Sun, 28 Jul 2019 15:04:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190703084601.9276-1-brgl@bgdev.pl>
In-Reply-To: <20190703084601.9276-1-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 29 Jul 2019 00:04:15 +0200
Message-ID: <CACRpkdbcNAe1_cKgObDqODND6h87Jnz_jbGy-XAGDANf1D8Gvg@mail.gmail.com>
Subject: Re: [PATCH] gpio: max77650: add MODULE_ALIAS()
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 3, 2019 at 10:46 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> Define a MODULE_ALIAS() in the gpio sub-driver for max77650 so that
> the appropriate module gets loaded together with the core mfd driver.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Patch applied.

Yours,
Linus Walleij
