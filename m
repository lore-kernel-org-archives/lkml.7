Return-Path: <SRS0=CMjL=VD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E1AC0650E
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 18:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C17F02070D
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 18:15:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AOXZYY0y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbfGFSP2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jul 2019 14:15:28 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43209 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbfGFSP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 14:15:27 -0400
Received: by mail-lj1-f194.google.com with SMTP id 16so12076560ljv.10
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jul 2019 11:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A5lm0JSw+Z8wQ0Vdkc6Vkvw8WJnahchqFx9ZZf0C1bw=;
        b=AOXZYY0ycpRLRb/cuxQRZXeXQqW+nq2DUKUycdltMljz6f3AWjl7BTug/90DxbEVkm
         +USftXGrGeluRa+0NDXg7Im2eWo97UoPdo+U4Z+Tbr8nmZ1HpYI7GJ1h0mfgGOzFV28n
         FZHoifvTVwMZTx1/AnjDBFVWKDNKYbEnMA8HymAw4E5AxgKCNMW7TnxEmv9HOAq7O/Kk
         U9UVU6/8bxDYHfzaLef5W9PoGUsLNGOeQso1rscyxkNIbGvyBZOFHPspKd/noy7eKTkJ
         c+IfxVIzehYxL0GmIf51EIu7BbKqvJtX7txYbJRVEtDOI9KXcJvNs7suY8RWVHFrqNeC
         GaeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A5lm0JSw+Z8wQ0Vdkc6Vkvw8WJnahchqFx9ZZf0C1bw=;
        b=nn6d2eemwmCFv9A5zMQvH0q3Ft3ZJT424TlH1D16PX3aHjoqbUezrk8NrZlUql6dif
         TWsbl+Om7AGlWUIOyBJA+w9AOsnzQKepWoSRsBNn1r2cTQ3nHjhrXf1NCfckFTe6vnG+
         ln9IupCpkRP8r2xiSVNnreI5u1nwGIRguF9+lVW1RmUEpyV4KxvzthF7iVcw+3vKaLS9
         vAOLlQPe/a3kaZfU00MPfXb6iC5IrZsnDXHTJbYarDTdfqpCt0GOwAh3aJ5rocme+ff5
         7z8sertr/TTEWj5U5LYZJdZPeLxZsuY/8tiBaWt0WVOEzGAxhBbL5tME0jBtsxJBAjO2
         IOrA==
X-Gm-Message-State: APjAAAUjMy9/bV+7afXFwJyEBVGFK5zJyNdLqo7FvHqCDCohRxUZzrPV
        g2U0SykZo0Px9CgcR+PgH5DaQLNqsfJ+lNz+SfF5hA==
X-Google-Smtp-Source: APXvYqz7lsLg+z4aZBOaKSE3IQ/hz5dnOlRYMqln19xtliTli2/FjLoEkwKW5PKDUGW8qlx3tKK22leN2u6gdA9eSjo=
X-Received: by 2002:a2e:781a:: with SMTP id t26mr2079752ljc.28.1562436925636;
 Sat, 06 Jul 2019 11:15:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190704153803.12739-1-bigeasy@linutronix.de> <20190704153803.12739-8-bigeasy@linutronix.de>
In-Reply-To: <20190704153803.12739-8-bigeasy@linutronix.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 6 Jul 2019 20:15:14 +0200
Message-ID: <CACRpkdb5Si0qQ71Ef10erN-pFNsK8xVpbfbztkr1-z-R+nKw8Q@mail.gmail.com>
Subject: Re: [PATCH 7/7] gpiolib: Use spinlock_t instead of struct spinlock
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 4, 2019 at 5:38 PM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:

> For spinlocks the type spinlock_t should be used instead of "struct
> spinlock".
>
> Use spinlock_t for spinlock's definition.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> Cc: linux-gpio@vger.kernel.org
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Patch applied with Bartosz' ACK!

Yours,
Linus Walleij
