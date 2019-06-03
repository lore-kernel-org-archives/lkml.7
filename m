Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48485C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 23:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05B1F257D6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 23:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WnjU0E/r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbfFCXHz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 19:07:55 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33795 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfFCXHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 19:07:54 -0400
Received: by mail-lj1-f193.google.com with SMTP id j24so17877185ljg.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 16:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9NFfbp/l7iiiVWginEhWa3ckd/womtHkaNdf8Bm+794=;
        b=WnjU0E/rAfa9vZPRfObu2NgpsAHWsZFHvUV69mxl3ei5E4u3wUqLrcOWCZxid+etwI
         idPmXKgOnv9LyIDizXMxnkZQ+rv8mvDL6cTXNKkn9o9jIgCoa8xNvnMpVupFnH/DBubR
         z7Bbbdf/rBN4ueBDUCIbsmCasr1uaK8BDfV164NMFB9nXdq4W5H6ci7QmylT47TohsdZ
         UhPArasjBBa8E/NXknmNzB6UoToQJo50DzNz5SA86P600icvEf8/0jXCnibqqjJHvO8X
         B8hbGJOYCQTjKJyEJew5yq44nQGuynbzdgtPWt1JdD7FsKL6iZSbeNyy+BXMW8o2lh3H
         3xSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9NFfbp/l7iiiVWginEhWa3ckd/womtHkaNdf8Bm+794=;
        b=rjPa9qJTrwF9CPmMidHJGZWcKcITypNQNGbjT3JcPA8VGrlbi98DzMMdZVbEf2FUKA
         A/YMbtHVvt0hveQeHy2rAhVEXLi4nDTD9oJ5rd0kn6nfWpRCejvgE+X7sikHBDQjrCOh
         AuNUaBUFHhxyt2NOSK7UZIAzje1VfBlXHzrstaBa4nADeXoovuOx7YCf/A56Tm5P/umI
         QehCbDOyAopi67uCkrTrdvlBdWZetlPGj1O80MdxIZrYJ1T+RuRzBeawtNOithWTWozk
         uJ9NwDfpewQksCvUkWNjqWc/mafM4xK8P77qK8Mep7Nc7Y+Rt4a/+TbXV2aqXtc7egNo
         lGow==
X-Gm-Message-State: APjAAAUnahlfBUyK6BaVC9kqk7JqTLJmxLUZDMpqcJDq0Cwwdyjpf55W
        AsfviGz/9FO6h4wtQPTuujzW3YlL/QFUt6K3oCLf/g==
X-Google-Smtp-Source: APXvYqx/DD8LnqDfO9YJiKsu3INvZtWWGhNNb2rLcK1MCFxZlVhpM9tSmP7auz1Iw4f1nXvHBAfBzZXk3RUmWeEQt6U=
X-Received: by 2002:a2e:9018:: with SMTP id h24mr8048502ljg.165.1559603272528;
 Mon, 03 Jun 2019 16:07:52 -0700 (PDT)
MIME-Version: 1.0
References: <1559601789-27121-1-git-send-email-hongweiz@ami.com>
In-Reply-To: <1559601789-27121-1-git-send-email-hongweiz@ami.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 4 Jun 2019 01:07:41 +0200
Message-ID: <CACRpkdYPHw994Ov0xCfK6tCg60tiuWrRwTcYpMSfOr4G0VKu_Q@mail.gmail.com>
Subject: Re: [PATCH linux dev-5.1 v1] ARM: dts: aspeed: Add SGPM pinmux
To:     Hongwei Zhang <hongweiz@ami.com>
Cc:     Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed@lists.ozlabs.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hongwei,

On Tue, Jun 4, 2019 at 12:44 AM Hongwei Zhang <hongweiz@ami.com> wrote:
>
> Add SGPM pinmux to ast2500-pinctrl function and group, to prepare for
> supporting SGPIO in AST2500 SoC.
>
> Signed-off-by: Hongwei Zhang <hongweiz@ami.com>
> ---
>  Documentation/devicetree/bindings/pinctrl/pinctrl-aspeed.txt | 2 +-
>  arch/arm/boot/dts/aspeed-g5.dtsi                             | 5 +++++
>  drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c                   | 4 ++++

Please try to separate out the change to arch/arm/boot/dts/aspeed-g5.dtsi
into a separate patch that goes through ARM SoC.

Other than that it looks fine to me.

Yours,
Linus Walleij
