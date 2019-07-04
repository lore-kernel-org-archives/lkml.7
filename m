Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D66AC0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 07:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25630218A3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 07:34:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fvw4InV7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbfGDHem (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 03:34:42 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42285 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbfGDHem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 03:34:42 -0400
Received: by mail-lf1-f68.google.com with SMTP id s19so2811588lfb.9
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2019 00:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3Hg/OzgYff2zZVyVZhRe3CSo4vz7vDcSjMj5u9XKRBc=;
        b=fvw4InV7Xrh30ZZSoTB30kuoVn11+FBcGxu8IajJvWwcQPcAFRB8+Wb1fAbfsCP3Dd
         i9ZXFeDK2fhOkMNlG1R9xRC1dYRODxk+c3ifPmqPvXcQ7TgpfpnJA9DJ149w2PGd1opE
         bruSfRy6No3axplr2CN/Bo/cL64vAxZgfORvAUVtvCr0j1qxgXq6carH4QgxHzPcrjuJ
         H+r1Kwelri9T2Q0irWD1ctZ48qB9thzhwhnncgEntj+u3G1IB5+nMueCD1re1HfPtwuM
         gkp9DaJiYjJvxPJoFeP/rQNb/zvLtJ/uRnfdzglEwkw6lK882UI0Q0GC/Oatp2vb1TmC
         8Wpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3Hg/OzgYff2zZVyVZhRe3CSo4vz7vDcSjMj5u9XKRBc=;
        b=T1hPj9o9htsbKnTPTs8x+A2uyU8noVK39s9/3yTA+unf/KTIm5m02FIK75Vcsh7CXA
         Yi2X1mG2+KxLaa7HSbVGmjxV4DMOJMbM+LmDryQjno0PRJww/JK/kz9KhBWBEvVSyOjZ
         xEwTe/Pg2/LuvAPgehtjTmbiX2nKU+0svx9SWQWMWsyKxRkvV5T7DcH7CF8WV3NR6ZCS
         oFmTlMohwN3YtT4ez8zzcaT9cGw/n448gc9jXJzcZpPSnwuo8wtq5N44ftwQsdsG624J
         UoL9/fZI0wjWP0/q+YYrXIqM0WSA1JRlt5+BNpaDfuDYy9N79jOEGmXOr8JdW8RTfKQa
         ayDg==
X-Gm-Message-State: APjAAAXys1z5kxEsSZ8ZqC3uzseT9h0n3EanCT2xuXt2LrKLObiCKt7C
        22vqWJ+rsRog7k/skOrjxxGJIYxX1iSx7sEbWVGbdFs8
X-Google-Smtp-Source: APXvYqz9jKSdQHqdcCLr4daSvcS7ZzdPvZymwRQWhwjjTbjz949nTsYJRG/zvKF2/lIB1eCk1XVePn0LFINzCWM3Tuk=
X-Received: by 2002:ac2:5c42:: with SMTP id s2mr4234270lfp.61.1562225680360;
 Thu, 04 Jul 2019 00:34:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190701142650.25122-1-geert+renesas@glider.be>
In-Reply-To: <20190701142650.25122-1-geert+renesas@glider.be>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 4 Jul 2019 09:34:29 +0200
Message-ID: <CACRpkdYRcmp=k=v8eQ9gjhSr13uoXQqCBKf=Fc8LWzKExhs_ZQ@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: Document new gpio_chip.init_valid_mask field
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 1, 2019 at 4:26 PM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> A new field init_valid_mask was added to struct gpio_chip, but it was
> not documented.
>
> Fixes: f8ec92a9f63b3b11 ("gpiolib: Add init_valid_mask exported function")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Patch applied.

Yours,
Linus Walleij
