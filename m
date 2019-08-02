Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5323C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 22:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4A402087C
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 22:20:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c11DsE6x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388026AbfHBWUM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 18:20:12 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45301 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732371AbfHBWUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 18:20:12 -0400
Received: by mail-lj1-f195.google.com with SMTP id m23so74128619lje.12
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 15:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IZ48FMZQTs4uLcOa+ewd+uatrSZkDn8qdysdEWbOPPM=;
        b=c11DsE6xhXFUkGZOKxS0st145dWqvewhcd3fQlz6reUM8JMeFAhgV6u4i+TozRJvOo
         sKH5UKHncsWaB2Xjfz8zRmJm8YpIFS1WpghI8V66dbRbM/YCMrbRdoOOGFjkAw2VUDd4
         XeMVfXUsMg2le9LZ2rOUIV+hapnOY1oM85zlQapDge4ELyVgXchMO4Mc74KZbF1gXQRw
         CqbrPqC0Tx7XdvggiEfEoGga6UZEwaZsbj3bN4hJ7QMGjvdm5rhbcl77SyloCyw7b5BN
         SODi1TlVZcC/IVLwZydxi5Vx7TJZ2gKURa+2D9HfIPnftiW4ftpjrvsCVhZinnnEtmf8
         s7OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IZ48FMZQTs4uLcOa+ewd+uatrSZkDn8qdysdEWbOPPM=;
        b=UFmZNw4kkyMmW7YnoiJNM9+mj+rEkrhnTCrt4pJlQlSGjn2/L9AOZTFDjxO55HM3bp
         Yt1dy/evCHC4Xm2v2ab0yb+mlUWAVos2+uE8nFuFlwVRKh91AkNtaRoaN3lw8TIfMYdN
         E//XMklhZAyUO1BJh5GX6H9rs78kk+qYcc/Gf/1WuFpjfuiFDeWmmjD7SdykA04s2o+E
         0z0XJlOLmkGB0P0JOeTlYBWp+LVyU5vzr7ozPza27wNsh7s+l+TlSZppAJHkEXzgf0wQ
         YGXfqzsemy1/E3+XnUQxdzdhIHJkw8rMkmI73XkC8t7sYBaFQ/pcZtN1u4WDppf8Ivve
         g6ZA==
X-Gm-Message-State: APjAAAWPUmEPvndfOSYjP84Dna23nbL3vYj8wSzk0H/DBBcNKN0lrzOJ
        90yHbNrEaPxrB8aOP3Shso9J66c+tNa1MHeiWjA3Hg==
X-Google-Smtp-Source: APXvYqzlGf0tKCzKwDLVMNReMvQcDY2AOLHnYQ7fYCG4kMKmoHKNejXmOFBQGqIQflfBg5mRKfTF8g1MtfHSnrhNYSs=
X-Received: by 2002:a2e:8756:: with SMTP id q22mr73630699ljj.108.1564784410398;
 Fri, 02 Aug 2019 15:20:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190718094902.15562-1-hui.song_1@nxp.com> <20190718094902.15562-2-hui.song_1@nxp.com>
In-Reply-To: <20190718094902.15562-2-hui.song_1@nxp.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 3 Aug 2019 00:19:59 +0200
Message-ID: <CACRpkdYRg8mMe5yxu=+tC1uz_usyNyVjn7NFobSUZi0rR5uGjw@mail.gmail.com>
Subject: Re: [PATCH 2/2] gpio: mpc8xxx: Add ls1028a device specify function.
To:     Hui Song <hui.song_1@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2019 at 11:58 AM Hui Song <hui.song_1@nxp.com> wrote:

> From: Song Hui <hui.song_1@nxp.com>
>
> There is a device specify register(named GPIO_IBE)
> on ls1028a need to enable in initial stage.
>
> Signed-off-by: Song Hui <hui.song_1@nxp.com>

Patch applied.

As noted on patch 1/2, send a separate patch to add the
device tree bindings in Documentation/devicetree/bindings/gpio/gpio-mpc8xxx.txt

Yours,
Linus Walleij
