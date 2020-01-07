Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 008E9C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 08:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C043620715
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 08:59:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Co0IXaiH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbgAGI7g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 03:59:36 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35230 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726937AbgAGI7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 03:59:35 -0500
Received: by mail-lj1-f196.google.com with SMTP id j1so46476461lja.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 00:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qcYz+S37e6lohC/PrwT9exdPec8JcjwTa/J8RhkOk3Y=;
        b=Co0IXaiH/+kIDbiPhYQnpNffs6+jp1pyoZ09ElFeN6AOYIbJXEvar943+qbxVK8eVO
         Ac10A0XtFpcY4904o9UkXWZB/k+R86TnE4uP+o5HbMfmc50EmTA2/8tZqnPU1lY/VRSj
         +Nq15vL0MeA0WA49I12NeF0uyPfHUDNEhIrdQZ9lmHT+D7Sy1Vo0QQOSovHCVTLEE39m
         bdqTdDzIdSDP4slKvcGQOaxOZP4WKGC+TVyMuChd+blxaubwKrE/mX4s5+EF9SY8Oekd
         0KJ/KSnHv8WYVZWsRhuUr84Amq/wNlLqgaS2VGI13QneOizWgYF/PRXyI3z+9jo+/ZqH
         wQFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qcYz+S37e6lohC/PrwT9exdPec8JcjwTa/J8RhkOk3Y=;
        b=OD7ZyANpefjJm1zPcheQXaNZNf/rfNWUlKRdzIBYpPXC9+OFV71yLtyvZrI+x9x71y
         vZ+1Q3ayb4HtbA6tSgl0bUfZefzB4+NIXODtDMzY5vfBvpPv8p53/nK1509+7GsR4pSF
         c0cICP+A8QqgpVELpZ5e6t0ejCPJ7aNDIc6a5RVg5Zs1/5WBBlcsm+em5Z8Tm8zoMtqG
         wBUW903k5cncmtj0ik89BaYXf1hIankzrcoX7ks2adQ22Ty1WX6QXkmi5oMuU6r46PHu
         EOg6pF03aSaP+DgVzek8D7wnr9Bnp0AHz5XQYs3rYbSwtYyGKCoQkOdr3t/57iCSa/id
         JoVQ==
X-Gm-Message-State: APjAAAU6V0LYdF9qbadMTUe9g3qWL9xyyT2zEZedTepTCRhgUIk4GqGd
        eR5sYnNORFIHQyWsMEtcrbIHqeHGyEhPpX2fWQBo2g==
X-Google-Smtp-Source: APXvYqwzgm1tDEg4oG7KWcWr6Vc7Evz3UAMAEgRq5uMClmvIjLnB28dsi3QY+dtK8eFMarZQ24w9mM6MQt8rCUS7ErY=
X-Received: by 2002:a2e:844e:: with SMTP id u14mr63300233ljh.183.1578387573393;
 Tue, 07 Jan 2020 00:59:33 -0800 (PST)
MIME-Version: 1.0
References: <20191219131459.18640-1-baijiaju1990@gmail.com>
In-Reply-To: <20191219131459.18640-1-baijiaju1990@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 7 Jan 2020 09:59:22 +0100
Message-ID: <CACRpkdZEpMDbrHxkaNLiqqaeVKTW3y6k6EpZA8z6nf-9sRF3qQ@mail.gmail.com>
Subject: Re: [PATCH 1/2 v2] gpio: gpio-grgpio: fix possible
 sleep-in-atomic-context bugs in grgpio_remove()
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 19, 2019 at 2:15 PM Jia-Ju Bai <baijiaju1990@gmail.com> wrote:

> drivers/gpio/gpiolib-sysfs.c, 796:
>         mutex_lock in gpiochip_sysfs_unregister
> drivers/gpio/gpiolib.c, 1455:
>         gpiochip_sysfs_unregister in gpiochip_remove
> drivers/gpio/gpio-grgpio.c, 460:
>         gpiochip_remove in grgpio_remove
> drivers/gpio/gpio-grgpio.c, 449:
>         _raw_spin_lock_irqsave in grgpio_remove
>
> kernel/irq/irqdomain.c, 243:
>         mutex_lock in irq_domain_remove
> drivers/gpio/gpio-grgpio.c, 463:
>         irq_domain_remove in grgpio_remove
> drivers/gpio/gpio-grgpio.c, 449:
>         _raw_spin_lock_irqsave in grgpio_remove
>
> mutex_lock() can sleep at runtime.
>
> To fix these bugs, the lock is dropped in grgpio_remove(), because there
> is no need for locking in remove() callbacks.
>
> These bugs are found by a static analysis tool STCheck written by
> myself.
>
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---
> v2:
> * Drop the lock instead of moving the calls to lock functions.
>   Thank Bartosz for good advice.

Looks good to me, patch applied!

Yours,
Linus Walleij
