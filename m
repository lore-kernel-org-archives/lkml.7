Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F19C5B57D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 09:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C63A8218BC
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 09:34:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="mpEnVSRn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbfGEJeB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 05:34:01 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:35398 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728264AbfGEJeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 05:34:01 -0400
Received: by mail-oi1-f196.google.com with SMTP id a127so6736887oii.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2019 02:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=k7JeaJZT9YLEJlXuKXiJcbNBJ0svwTrsoQVxCOdP3dc=;
        b=mpEnVSRnmeyi+d9CXxwfr5p0t/UtYdJ8mHFSB1cfOuZbfj98idtIUKu9MXbcplNKVm
         Mb5R7Wmsww3eqzijwq/psqqW3JWGMe3WRYcyQDusKrzaKjotLc/mXzF7sSq/HeMz751a
         mgKUnUsKzIRJfTnMY3LKNeSUUjr6kyHsPFP3uL7+QPKuhWDonVt3mQk2sM7Ma4nH3g6o
         CmEkCHrxBn5WM7nvbNXYn8sfPsEY49vZ6+BMTnmOL4ShhnMTfeU584fxtXeBHU5ck1/O
         4xH/B0kknxH/8HHXnb3kqFSSmbuIakpGcyEa7crP9P+SiqcXM+By/0bDicdQOKYNtuup
         EjCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=k7JeaJZT9YLEJlXuKXiJcbNBJ0svwTrsoQVxCOdP3dc=;
        b=o8ZTSIaOP9H9L+n/ZLH6pqxg91cWfB8D380ftVCOk3NDrbZVtfrQkDaHXqEhovLbEz
         3ARHIYBkghYApHE0Kf9QKFLOKEYrpCu9WmQnIwb07R2rt6XKalaPjGjgX2iz3nYzGBBk
         k1b0D/P034lU4M0PC4L730rrnINaMic+1C/H2y3zKILWjFsYdfljQM0dUoULLwPXlNEu
         kqCD0sDXlW/BjvhBO1sWjwoZ502DIOcRDy0L8bwrNKT8hIR8hrmMWTSskGaF2IN4Y6Cu
         jZYc96nFIbs4v4Mkeo0nyopCE9/A8LNFUxjCvEhY3U+3feOA2LYr5gWWqlS7optd/yg+
         13gA==
X-Gm-Message-State: APjAAAX+ixzrylImiqU9SSV2VBD9Ls0nYQlGlkDqTfJKDaQnkPfMW3L3
        8L47bJG6HrA8tzqSgqloOD1GMEuhlssp1RO4scX62w==
X-Google-Smtp-Source: APXvYqxqzTa/ARUTZ5WSojLnyWSxsdX9n6tGNrUqj5cuuqMryH0l/dHnjFBS3EoEGSLjPcrj4i0sVSlI+tSZEvL0CxU=
X-Received: by 2002:aca:b58b:: with SMTP id e133mr1432573oif.147.1562319240426;
 Fri, 05 Jul 2019 02:34:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190704153803.12739-1-bigeasy@linutronix.de> <20190704153803.12739-8-bigeasy@linutronix.de>
In-Reply-To: <20190704153803.12739-8-bigeasy@linutronix.de>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Fri, 5 Jul 2019 11:33:49 +0200
Message-ID: <CAMpxmJXZy6S8OLb9iD6zfoFHnhZT4Nc0baxR1hH8YgphaEFOOw@mail.gmail.com>
Subject: Re: [PATCH 7/7] gpiolib: Use spinlock_t instead of struct spinlock
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

czw., 4 lip 2019 o 17:38 Sebastian Andrzej Siewior
<bigeasy@linutronix.de> napisa=C5=82(a):
>
> For spinlocks the type spinlock_t should be used instead of "struct
> spinlock".
>
> Use spinlock_t for spinlock's definition.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> Cc: linux-gpio@vger.kernel.org
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  drivers/gpio/gpiolib.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
> index 7a65dad43932c..7c52c2442173e 100644
> --- a/drivers/gpio/gpiolib.h
> +++ b/drivers/gpio/gpiolib.h
> @@ -210,7 +210,7 @@ int gpiod_set_array_value_complex(bool raw, bool can_=
sleep,
>                                   struct gpio_array *array_info,
>                                   unsigned long *value_bitmap);
>
> -extern struct spinlock gpio_lock;
> +extern spinlock_t gpio_lock;
>  extern struct list_head gpio_devices;
>
>  struct gpio_desc {
> --
> 2.20.1
>

Thanks for spotting that!

Reviewed-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
