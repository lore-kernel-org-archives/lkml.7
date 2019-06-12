Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E3BC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 07:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8FA32080A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 07:50:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MxOgXdPv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408594AbfFLHuK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 03:50:10 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42883 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408494AbfFLHuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 03:50:08 -0400
Received: by mail-lj1-f195.google.com with SMTP id t28so14184491lje.9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 00:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IEaEkHGgpzdEriV3OpBUDcZF+KYsAf8LOl6nPBOdL0I=;
        b=MxOgXdPvNtfxAeQKrsT6Hhks3ZJt5BbhJTAVPBRxH2NTM0bwdeOB3XxaszrRVJ8l9+
         VWsL6ISsBFvP+YlNVumKlbdeBsd+Vq8pbeA033UZIughCukKYSKF8MrVmIYZHq53An+P
         l0wBipa1xKndvyvg0c7UF5i8yf5YpBtkZsSqPn6GdysoNn+e6HfsSyT7R3Hc9FyYmUms
         lAHjkrVnZoVr8d3Iy/SeNcpqx4mJBq4WV5Ncbd+DHQQxYYu4ww6iSaeJ6VxbaIXPibCu
         4QTq+nY14JrmffPXRcD6eoSD80Fu329m6RZWZEYnYUjyQx9jBka1uKNwyHZ2UB1vbM93
         gdjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IEaEkHGgpzdEriV3OpBUDcZF+KYsAf8LOl6nPBOdL0I=;
        b=k3PwlNlDsRG297MjwJiqJc2X+ks8Q/y5wKnO9MCb5BdOQPmbwQ++kLhOv1LIePe/c0
         4MZU/HCtKsBR52/zweZxKrsYIQ1BFZZ2niwhkDgYyhKxWvzqrwT3a9v4TtIKAAhOHLVI
         rw7dQvaNz/nCQSwW5woMbsqZRXx294yd55idALrD5BYQtFqhRmTFxAx/MRTyQSnEVZYP
         R2AAUmoqQqsLEHQ7qq2jUbYBCft2Zv9g/Te0W15QCkERT4ivbdT4DYAqeF68W/6rH+nQ
         mYuDPLV8qLoPbuQkOsxI9wFWiEcphxtQf+djKye8GCFw5Q9/YFlPebe0N9x3rapzXzLF
         CCsQ==
X-Gm-Message-State: APjAAAVCQ+7z06u+Vjgn3BuamJGcYaLO7lzdHMCXHzZvqAz/a5P4ctUj
        92dCg0m7PKKUWl/xDUtXop+noH9FRlrkiC/nj8X9zoaHf/cX9g==
X-Google-Smtp-Source: APXvYqzzh0lP2GP0zIA0B/CjEu8rHnPuiyl2/5JjJotWd+XukV1gNSf6KSOn2KcSDsb1T6tKaT1WrBmGn5bHZWiacxo=
X-Received: by 2002:a2e:5bdd:: with SMTP id m90mr33630569lje.46.1560325806228;
 Wed, 12 Jun 2019 00:50:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190610170523.26554-1-martin.blumenstingl@googlemail.com>
In-Reply-To: <20190610170523.26554-1-martin.blumenstingl@googlemail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 12 Jun 2019 09:49:54 +0200
Message-ID: <CACRpkdboUO1iEipXTvhy2x6bxuVJuwxd5FduMdk-KtK3f8FeaA@mail.gmail.com>
Subject: Re: [PATCH 0/1] gpio: of: prepare for switching stmmac to GPIO descriptors
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Andrew Lunn <andrew@lunn.ch>, netdev <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2019 at 7:05 PM Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:

> This is a preparation patch which is needed before we can switch stmmac
> to GPIO descriptors. stmmac has a custom "snps,reset-active-low"
> property because it has ignored the GPIO flags including the polarity.
>
> Add the parsing to gpiolib-of so we can port stmmac over to GPIO
> descriptors.
>
> This patch is split from my series at [0].
>
> Linus W.: please create an immutable branch as discussed so I can send
> the stmmac patches to the net-next tree (which will then have to pull
> in your immutable branch).

Thanks Martin!
I have applied the patch and created an immutable branch:
git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git
ib-snps-reset-gpio

https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git/log/?h=ib-snps-reset-gpio

Please refer to this so the network maintainer can pull it in.

It is based on v5.2-rc1

Yours,
Linus Walleij
