Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D28AC5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 07:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 715A321D6C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 07:51:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DGew32WL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727224AbfKGHvG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 02:51:06 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45761 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbfKGHvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 02:51:06 -0500
Received: by mail-lj1-f195.google.com with SMTP id n21so1099902ljg.12
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 23:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qSQjzivSQWR3vk7yLY/YJH/RUhPjuRasO+9jC+q89bU=;
        b=DGew32WLlEUC99wuJsG/2cOFmi/9tbj9IsU3zfo2nRYQS7rtVNcwa2pOalO0EvNk8m
         k9dJ6Ag6CjsByBhneIUTwyqr1aqadRcLsGzPztBS1rfy+iT0DR1Biytu95CuyZXgSjo4
         8ZN2QIuoFJzRmzxlw98K4gigwS9cNY97lYKEcQ+4IuPC+AwS0tMWY+1XsfMuQICoH/Ep
         RvgNiOzWuHwN31kB9gfCeXRorT5C9YHJtg4M1BhNwack6xFF5SPND7/6oxhxCn21LPvf
         kL8zn3pnzvsE6LxTaTAoUcwWAihwHQ4MbB5AccBj1JCkWQyoWYbWzngEDKX8MG8sqmYy
         ABIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qSQjzivSQWR3vk7yLY/YJH/RUhPjuRasO+9jC+q89bU=;
        b=ZNbWEfIsr84kQTpIzAnf/jyHbE2hX0u9XSObIlZtuZwYm2AsyuVZjOoftjWEPbdy5i
         ltQ3SC2QJYM1YKaAyrnic1H/Q6F4NGpikyNJnecmuu90pBf6EJvIwm/E6xJINWq0V8hO
         R2OkOI0tWiatYXID1shuqpH8aoxZPvllknJYU9ae3sPPLbr1jJTTvAFZb425YmA+O+up
         1nxkc+vFiPcXdfrwOCiuMHq6CNyxTtDDhlHjBB3/LUTsYhsdfcAGjBmyGIXCA6vvgmBQ
         6xwHD3CWP46h2TmdBeEN/U8rkJQ3OqaX1gfWryUHagHBwaQIqSVGknI4wX1s4rrrHLOC
         c18Q==
X-Gm-Message-State: APjAAAVZ2t6J7nRWHeyi1DSrchYK1vLeJ/UfVia7TIVIqA8uc6lK3P4O
        oBj9shyGJ5lSG4dkhgiMg9o4tBWncIVEM+klK7r8XYQhFZg=
X-Google-Smtp-Source: APXvYqwKHwHViiRns9nUe35XE09guXcyAAkHBHKXy6BqY0BpDujW7VYTEQakwhSoD0SR/mqO1m1nrrf0lziVhLJDa0A=
X-Received: by 2002:a2e:9784:: with SMTP id y4mr1275845lji.77.1573113062506;
 Wed, 06 Nov 2019 23:51:02 -0800 (PST)
MIME-Version: 1.0
References: <20191106060301.17408-1-joel@jms.id.au> <20191106060301.17408-4-joel@jms.id.au>
In-Reply-To: <20191106060301.17408-4-joel@jms.id.au>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 7 Nov 2019 08:50:50 +0100
Message-ID: <CACRpkdaQsz-cbRqgRrAyP_3VpO9Upzcwc2CNKDL4GvC286Y63Q@mail.gmail.com>
Subject: Re: [PATCH 3/4] clocksource: fttmr010: Add support for ast2600
To:     Joel Stanley <joel@jms.id.au>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Andrew Jeffery <andrew@aj.id.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 6, 2019 at 7:03 AM Joel Stanley <joel@jms.id.au> wrote:

> The ast2600 has some minor differences to previous versions. The
> interrupt handler must acknowledge the timer interrupt in a status
> register. Secondly the control register becomes write to set only,
> requiring the use of a separate set to clear register.
>
> Signed-off-by: Joel Stanley <joel@jms.id.au>

> +/*
> +  Control register set to clear for ast2600 only.
> + */
> +#define TIMER_CR_CLR           (0x3c)

If it is AST2600-specific then please add some AST2600 prefix such as
AST2600_TIMER_CR_CLR (0x3c)

With that:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
