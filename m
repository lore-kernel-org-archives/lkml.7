Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5BBCC04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 12:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8774E20818
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 12:00:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BKV5XUrU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbfEPMA0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 08:00:26 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45515 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727278AbfEPMAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 08:00:21 -0400
Received: by mail-lj1-f195.google.com with SMTP id r76so2801033lja.12
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 05:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HQOMAI84PZC0+DOegMD1ITt0MKv7Ak8ewW8Etm9lkUA=;
        b=BKV5XUrUWOMwueeRMWBchST5WvqZHM/NtRV5B0YPoEjo6I6spgwvU8qLG+o4JSIM0o
         b5gqWR35P6H9JsEzpk+g6yBI3JFTkP9cQHMHOaf/tD18SLlVdkPkTpH4ZSkc7A4IEyc4
         n/CLdvVAQ8fsM3drNPN2LdDMQdHGU5z8vX2K65sEzb19qN4Tz5YpiBCSC1SiryKKz35F
         U7Z4vH4IedkRwZ2DX6OSLp4lpJ0kHhC2R32nQ2EjtMrT0smDBybpstccZDvHw1MqKuXB
         fi3IkL5WBAArrYUKAr9I+AHokO+s76ktwYZm6sb6JIFUd2LNvdL+4RyVh05L2D1ex7bU
         wIGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HQOMAI84PZC0+DOegMD1ITt0MKv7Ak8ewW8Etm9lkUA=;
        b=VfmWZgD/3DptfmREQ2i4r224FN+VyaLcoUBbPeEHz9fM/1+SceP/uv6XMmplqhT4eI
         AlFfgTcJrEt3eMs8KlSl/TudoUwKTYjYCqzHAwkGY3TexHVU9cXgoWftwvOp1R5BWX5P
         ICct1Vs4ItGl2dw6py7zM34Y1Q3q47bsoaDoVF5378kkKyBzVG6Tq/cGra6++5OWU9cM
         Ur54mwtKr3D+k3skvNUzSPIlnYJYGkM+MqHprLy4KaIBl23HnSvlSROL0mdIfdv2SGD2
         VoSMEaTy6fcsa9gr9cZBaHsaAC4qirodm/3UV20kxpo/BuGym0rRVQl7MZ9RZnwO2dG/
         6JjA==
X-Gm-Message-State: APjAAAXWZD8oZAUprDV2EjaDJK6TyoRiIB9mfVpr0D0jw62aIJDn0hWA
        oif/r61/c5eoGzGPhCjaBJhsuBhhPK1Sjo7hzBhVQg==
X-Google-Smtp-Source: APXvYqy/QxzuRbuXA6LlmSJaji7Uopbqp+ypyEJdX/0a0gSPzRqRuYaG5w1iurs9HkQD6IRJXQRPc5QkY1MTgNnxhCw=
X-Received: by 2002:a2e:9a4f:: with SMTP id k15mr19438972ljj.159.1558008019876;
 Thu, 16 May 2019 05:00:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190429054948.9185-1-andrew.smirnov@gmail.com> <20190429054948.9185-2-andrew.smirnov@gmail.com>
In-Reply-To: <20190429054948.9185-2-andrew.smirnov@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 16 May 2019 14:00:07 +0200
Message-ID: <CACRpkdbgkh5o6HojAot6orHcT8xV-eaYa9KCgXmhp0wN7OGGpw@mail.gmail.com>
Subject: Re: [PATCH 2/2] gpio: vf610: Use PTR_ERR_OR_ZERO() in vf610_gpio_probe()
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Chris Healy <cphealy@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 29, 2019 at 7:50 AM Andrey Smirnov <andrew.smirnov@gmail.com> wrote:

> Simplify error checking code by replacing multiple ERR macros with a
> call to PTR_ERR_OR_ZERO. No functional change intended.
>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: linux-gpio@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org

Patch applied for v5.3.

Yours,
Linus Walleij
