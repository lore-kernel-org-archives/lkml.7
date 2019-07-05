Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8517C5B57D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 21:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A94DA20856
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 21:56:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MGDGDqvl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbfGEV4F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 17:56:05 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43834 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbfGEV4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 17:56:05 -0400
Received: by mail-lf1-f68.google.com with SMTP id c19so1537326lfm.10
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2019 14:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XgKC08iiEaNapEt8oecESiRwrLkTQTJmIfIX4GB6LAo=;
        b=MGDGDqvlWi1VmpjxiAjxE8n12n9Zt/Hu1m/27IujOA15048scaVNqKGwFrfcu5/97S
         arY+icppvf6BGGkP3fZXw4APZBKgnCVYTwzXU7pQAKIhBESuKgT0CMHHskpH0VAn0xjq
         dGeK5Czy7CocvUPvqAgQyCl3l7yc7SOJb7BbNSAkPjvwa83cELO0xt0Bt5IZOFgw1cQH
         MNyRr002c46SDSVziYSlDsQguBEwJib/Y/ApMu+wJhLo6Kt/o2EvPJhhsjTm2eJMH8O0
         e8DtWK5V+f4y/bZm36kxr4mtv2niMywmiF8DaC/UOyH9CIhkAhtH6Z9S2i/TQIyP5nt8
         UW5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XgKC08iiEaNapEt8oecESiRwrLkTQTJmIfIX4GB6LAo=;
        b=cnF8se1eb+jBopEH/ls66mHcl05LgyU7jczCony54jK34A+a47FOXbqpG2EU/xywu2
         Q0Mdi0yGlG0yzDsl+TvQWat8cdIumN3wsIMnc5Zhg1lVHE/6B5AfcckxYeYUfRKSuTj8
         hVtUjtCG1W6cklZ0DefJDjzA6D5fqsPPsTzkSa/LGWKJ1kgSmaQ4e7BO7OeNGRKQXgll
         tO4JMuQOmFy4+0gOzEAxKkk8BN0riT8SWIrIv3J6kTCXv6wPR8dEz+mxVJ9miENe380O
         /Rwh5KbMjk+oDTw+8msz5shhDFK3NfioeUDyY97wfzA+SYX7iL4tNmhEVtngtHEPdFvm
         wTrA==
X-Gm-Message-State: APjAAAWbgL3ef02xM9M70BpvX/o7ndJgnTgAsU46EgNUrRWRVo1E234m
        H/4ZW0SRBKr3rtQQF5A/g01ueQtBhdMt6CTWGinHhQ==
X-Google-Smtp-Source: APXvYqwMkXMyOGNxusvNtzdRCvnI5J43hplKIhDlLunGWI5KYF1VSpVsFZX9oMXvfjTIHq2L2mfIqHeqxPVAqPcbsK8=
X-Received: by 2002:ac2:4891:: with SMTP id x17mr3096454lfc.60.1562363762981;
 Fri, 05 Jul 2019 14:56:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190704042027.18966-1-chris.packham@alliedtelesis.co.nz>
In-Reply-To: <20190704042027.18966-1-chris.packham@alliedtelesis.co.nz>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 5 Jul 2019 23:55:51 +0200
Message-ID: <CACRpkdbWWWhQ5V5tc0FkQSx80ZXZ+ki-mn9Cc_Vm-jOwVu0R3A@mail.gmail.com>
Subject: Re: [PATCH v2] gpiolib: Preserve desc->flags when setting state
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

thanks for your patch!

On Thu, Jul 4, 2019 at 6:21 AM Chris Packham
<chris.packham@alliedtelesis.co.nz> wrote:

> desc->flags may already have values set by of_gpiochip_add() so make
> sure that this isn't undone when setting the initial direction.
>
> Fixes: 3edfb7bd76bd1cba ("gpiolib: Show correct direction from the beginning")
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
>
> Notes:
>     Changes in v2:
>     - add braces to avoid ambiguious else warning

This is almost the solution!

> -               if (chip->get_direction && gpiochip_line_is_valid(chip, i))
> -                       desc->flags = !chip->get_direction(chip, i) ?
> -                                       (1 << FLAG_IS_OUT) : 0;
> -               else
> -                       desc->flags = !chip->direction_input ?
> -                                       (1 << FLAG_IS_OUT) : 0;
> +               if (chip->get_direction && gpiochip_line_is_valid(chip, i)) {
> +                       if (!chip->get_direction(chip, i))
> +                               set_bit(FLAG_IS_OUT, &desc->flags);

You need to clear_bit() in the reverse case. We just learned we can't
assume anything about the flags here, like just assign them.

> +               } else {
> +                       if (!chip->direction_input)
> +                               set_bit(FLAG_IS_OUT, &desc->flags);

Same here.

Yours,
Linus Walleij
