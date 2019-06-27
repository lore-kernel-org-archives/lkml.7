Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8EAFC48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 11:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EF132084B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 11:15:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Oh8LTD8m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbfF0LPM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 07:15:12 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45670 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbfF0LPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 07:15:11 -0400
Received: by mail-lj1-f195.google.com with SMTP id m23so1885783lje.12
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 04:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5TqvPz8DpORGx1+vi8ExXWSK0FXpNg/HXwHTY32b52w=;
        b=Oh8LTD8m7IDgDorBBc7V+VvCco9ShEfKtubYx65x1T5UADxUHneIwXm5D34fbeGt8A
         ixjCx/VH3pF/bQ6ZHMg9PHCQmjkpCAiXVk/t5qsh/Qqm5tx9SPGzVhjOT8gQTzjQQrfi
         lAGtQ9fEG9oF9K1v8oeREAXC0uuw/SL0BJN950l/xiDxO5+wGYpYmT+5VPl0QUp7nSue
         aAMKG7ngQmAlBgnfr7IMamGqNGSDVnT6ZsHyoFmoAYfgNHCqJ4qfQ4AxjZkWYV30/+vx
         p6K15ZkS7XsSbBvwsLCURk/PDZbWbvX4UVyTadC7wxBwmODusUKB4z9LZEZdJG1mVlPF
         JTEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5TqvPz8DpORGx1+vi8ExXWSK0FXpNg/HXwHTY32b52w=;
        b=dLLOAwkxFdVcwV1w5lyxKVonLSj4Hd0KUn9QXXVQjrbPNZHkxfRTbX5+S4A9/5PQEm
         dwfE+UVWbUMIQlwf4XnpwbvM2nvxW8CZdBz3zm63I3Oax7T1FNxKds6cE2Ra3P9hwUZo
         2gtix27CmKHonPyVrVny302iz159CBA6e1TQe78fuYWyueSIrvhiha/euLpF8mpmwEQ7
         0fyohSvZFi02pkHCKhKUm+o5HrB8DA05nbgwwVDI/Nq+sKm+WQ6Ez5p+zBqxacVM80Vu
         4pHdRuYrc2UeQTd3d7jxivfknH7VbLffcGXxwGaHat2qlUY93YxWqXQZqFcAxAto0EVs
         XO/A==
X-Gm-Message-State: APjAAAWu5cTC6BJnBLvqf2zRJr/YTuTg4qeOUu13F0WP3SIGK2BNmHe1
        xg0rj0+L1o+Bsk8GIDKuQMCkjARexgRNIjvM6z/sUQ==
X-Google-Smtp-Source: APXvYqyVA9C7Y1iH92FooDzDgEr3HQuytpfeJym/aOuE5hBX0/swTw0Rz9L0rgrDIJ1qob4Es/otbtAluqfU9XSMIXs=
X-Received: by 2002:a2e:a0cf:: with SMTP id f15mr2303238ljm.180.1561634109728;
 Thu, 27 Jun 2019 04:15:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190625163434.13620-1-brgl@bgdev.pl> <20190625163434.13620-4-brgl@bgdev.pl>
In-Reply-To: <20190625163434.13620-4-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 27 Jun 2019 12:14:58 +0100
Message-ID: <CACRpkdZm35HOxBqDN0dfAyiMPFAPOguPrzuPUwS14kZM-VJV4A@mail.gmail.com>
Subject: Re: [PATCH 03/12] backlight: gpio: pull the non-pdata device probing
 code into probe()
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        David Lechner <david@lechnology.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 5:34 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> There's no good reason to have the generic probing code in a separate
> routine. This function is short and is inlined by the compiler anyway.
> Move it into probe under the pdata-specific part.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
