Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADEC9C5ACAE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 13:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8429020872
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 13:45:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c/y2pXyG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728128AbfIKNpw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 09:45:52 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36447 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbfIKNpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 09:45:52 -0400
Received: by mail-lf1-f68.google.com with SMTP id x80so16533259lff.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 06:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nP0S20EG8LYe+0hd/5mZu3tMCLe/Md3Azkq9J3MKJKE=;
        b=c/y2pXyG9iAcROZvJYUWXzj08AwzhP+UtUM6Zvf/8ps1wHhTw+scZ4stj//aj35eud
         RL27Bf8D2dJW7JcyiLA/yX5gfNSAhmDOY/1XugvUaPZe8EC6rty0tbvIVKhMaLf1+deA
         /zxHOrlv8g2hF8FmJf9naGJY8vhNwopQr/98tJh0jRzPJAelieRtB7xzpxf2KMwDJNA1
         ntc9M5ItL3dv3Hji1pW11E8+fEfTYqyzZwOI0yrKULS9G5ud4S1a9TlkGLj1+6Y0UN/u
         QKjblsTwYO3m8OoWh7s1DFbOo0levTzp7EH/1G2ufv/5StbeoAOjKtfyVUD4LUcy57gR
         Oraw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nP0S20EG8LYe+0hd/5mZu3tMCLe/Md3Azkq9J3MKJKE=;
        b=aurVucV0rZNnSZAAxRS6letbHxKiASlDX+/+MjCFCly7nyHMouKHzIJi2AViian6cg
         cG1uFxRp6NvCtaNyOkjSZcVCKKx4/yDBmNmkR839+YK/8hG4BepBsllMUOXjz2SEzr1f
         WqHaixGfvqqdwbj7BvPyuUE9R0mMo/tN83EucCT6QR4gU//DB16+SghxMlrkJuFbORje
         AD+WThkyo4UwZCrrUdOycpwBAlq7MAJ6c26z4hi7Q/osLMlRScgb/EurYiCFleL4KlwM
         Bc2n2NVYkXgVEiuhsXY3O4Q8b39Q8q+29upTpCFrl05GHsw6mHzyAMNv8bvkTXWV2U1Q
         /Olg==
X-Gm-Message-State: APjAAAUmJyNXU+DqV0mLbqPghN2c9WA2d/+mGC7QWUffr4fZ8Rw4kEv5
        4OJ1qUueF/2h1sGvpC08gblXn03JETl8smsPxsc6kA==
X-Google-Smtp-Source: APXvYqyjFpv46U3/SHRumoathl8NLWc2Qs97KoWiUJCJOU9xmtA6GddnV4DQQxnfIrpO4ge71BO6yrhZSpCiBINuM/M=
X-Received: by 2002:ac2:530e:: with SMTP id c14mr23463783lfh.165.1568209550231;
 Wed, 11 Sep 2019 06:45:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190906084539.21838-1-geert+renesas@glider.be> <20190906084539.21838-2-geert+renesas@glider.be>
In-Reply-To: <20190906084539.21838-2-geert+renesas@glider.be>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 11 Sep 2019 14:45:38 +0100
Message-ID: <CACRpkdaB_cX3AZiCQVN3=P5C=ffQa1cOZtVx_g4b+ej458P6ow@mail.gmail.com>
Subject: Re: [PATCH 1/4] gpio: of: Make of_get_named_gpiod_flags() private
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 6, 2019 at 9:45 AM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> Since commit f626d6dfb7098525 ("gpio: of: Break out OF-only code"),
> there are no more users of of_get_named_gpiod_flags() outside
> gpiolib-of.c.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Patch applied.

Yours,
Linus Walleij
