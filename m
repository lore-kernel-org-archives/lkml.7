Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E6FC2D0BF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 08:08:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC32620700
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 08:08:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q5x+Bkta"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfLPII3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 03:08:29 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:42518 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726856AbfLPII3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 03:08:29 -0500
Received: by mail-ua1-f66.google.com with SMTP id d8so1754795uak.9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 00:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q6wmtqrWytSgVVPaG+tJiiZU+H7YE7GNP+DoOxtH1VI=;
        b=Q5x+BktaOm2b3vqBHMvP5gzjjoxagKJ79ZZToE4NJrZ47jD69ofO1gQcxdrv3AgM+1
         4OaRDkeeLIr3Qcnzc+ndcMDhKYlIx7NFEDP+nr09xZo+x6EH1CjzS+Gk8yewKOxcXour
         fgsEnvJqJ5ymbKxwAdF9OuuMDz6Za6gzyXqPzxyM/TgAyX4v8M6WRbEbiZVPzGSvmSl2
         w84dXiQJjoT5pZ5r/sxd4bgs1WgI8vTIws4k5w+VAFSZmAyrIanEcKNjEJiraO9TFO8f
         HB3tbj/39d1t/rlYDtNIpWRDpcWcWIG1lsiCQXaOj/XHJcATVvQv8jCdMp1hPNXZM9A2
         8H5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q6wmtqrWytSgVVPaG+tJiiZU+H7YE7GNP+DoOxtH1VI=;
        b=gbwMzOgDcBW2pWLwkYcGi+E9vOUl4rvLIM9R2RJwPb7uizSMGaXL0+l44bL1M2djCG
         akqsfZJdefhGHI9mVJfQG6uiustTa6pRwwA6c1pP98GeDaNKKURgE+ZQEVcJd3wKaV+y
         uXzK41YcZsW6INRw4D1nE1JvJeS6JJoTRuSvDlbROSPYe9mUlFT5MyI1URRG4o9uDlk8
         eA8wk3UPnnLDpH2TuITC5hBMCZ0Qi/7ZX6cBidF/IzQA4yZzPsF5Xnbfxni2gLma4Ebz
         yuV7aABIIX9cyGuq+/3JUfDVWaYHqTHYGZvl3t2mV937SBn0qYPElxWeJ2gK/lwe+hif
         Z58g==
X-Gm-Message-State: APjAAAUQ48K/dg7wPP5zYhdiENqpbphSYIUnvj/6NxpItasDMi41Nvfl
        X2QDhmbLWwEU3LE+AeledVvcPjlGosNzr5BbSgV1FA==
X-Google-Smtp-Source: APXvYqwTmNQL9yAF4ysRmXvFWucNUjVzF64EIGjJntMayVn5WjwCpACT1hjuTxdjff5Z5fVgnzInp5q0Ayr6YWbMa9w=
X-Received: by 2002:ab0:2716:: with SMTP id s22mr22593797uao.20.1576483708557;
 Mon, 16 Dec 2019 00:08:28 -0800 (PST)
MIME-Version: 1.0
References: <20191210154157.21930-1-ktouil@baylibre.com> <20191210154157.21930-2-ktouil@baylibre.com>
In-Reply-To: <20191210154157.21930-2-ktouil@baylibre.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 16 Dec 2019 09:08:17 +0100
Message-ID: <CACRpkdZb6OppcdCcaQ9abdkDJMk4escyyEm1TMB75rRxoN5e2A@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: nvmem: new optional property write-protect-gpios
To:     Khouloud Touil <ktouil@baylibre.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        baylibre-upstreaming@groups.io,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-i2c <linux-i2c@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2019 at 4:42 PM Khouloud Touil <ktouil@baylibre.com> wrote:

> +  wp-gpios:
> +    description:
> +      GPIO to which the write-protect pin of the chip is connected.
> +      The write-protect GPIO is asserted, when it's driven high
> +      (logical '1') to block the write operation. It's deasserted,
> +      when it's driven low (logical '0') to allow writing.
> +    maxItems: 1

OK I guess we can't get it less convoluted. This section is consistent.

>  patternProperties:
>    "^.*@[0-9a-f]+$":
>      type: object
> @@ -66,6 +74,7 @@ examples:
>        qfprom: eeprom@700000 {
>            #address-cells = <1>;
>            #size-cells = <1>;
> +          wp-gpios = <&gpio1 3 0>;

In the example please use the include for GPIO:

#include <dt-bindings/gpio/gpio.h>

wp-gpios = <&gpio1 3 GPIO_ACTIVE_HIGH>;

You can just put the #include directive right before the
example, it should work fine.

Yours,
Linus Walleij
