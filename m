Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC6AC04E87
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 07:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CD242089E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 07:31:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbfEOHbK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 03:31:10 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:36802 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbfEOHbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 03:31:09 -0400
Received: by mail-vs1-f65.google.com with SMTP id l20so1049504vsp.3;
        Wed, 15 May 2019 00:31:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/RiZNLVGk5uscGAFyY2St4mHBVN2ZWa9kSjg9JS7O1Q=;
        b=Yd/RgVCU6hSPudtzKlIeHrXCql7LN4CsaEt9vbuH/YTrYHdEhqSu81c0nxNwbp3qI+
         OijZgkHUu4sWREJ96cF/Jh4G702Q87x8KwjMamh/4Cj66Yd0LnG1CgNnL4tydK1qoK/l
         6MFgJE7eF3IrOqePqQvIe4Hv6hERc3embyFpV0FnPBXNt+wOpXg0jLRrKCRHEoVvNyVC
         42gJSmGh76TXTNfSsrr6LlpqYgo3yGUBj3nts2l7ZZczQkoEwRAPtItX4wGv3dBJIX5S
         4PQ3MpkAijy6k/F8VFGU3RRpMRzDUkflSurkMIuJHTxcPXkIvLw/xyS1pnbuF5kF3bSv
         jlLg==
X-Gm-Message-State: APjAAAWlI+2vtmZmFK+kvnI1lnmUK2IFgMJ96zCJxEbQedsMqp9sR6Ax
        NjdTJW3nu1uFTzwCtgMNryZvaUmLhinpKDN8jSc=
X-Google-Smtp-Source: APXvYqyRcOXdW0fMdPdyx6mSbkideJurOlUHR/isxy0xxECgEAo+PwOhR3EJ2IbRUlwpuj9hKqBv+SYlm731qEA+c0s=
X-Received: by 2002:a67:7c93:: with SMTP id x141mr11569593vsc.96.1557905468511;
 Wed, 15 May 2019 00:31:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190514170931.56312-1-sboyd@kernel.org>
In-Reply-To: <20190514170931.56312-1-sboyd@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 15 May 2019 09:30:55 +0200
Message-ID: <CAMuHMdXigXCDjZ=HzhTqgrRdL3nDrYrZ1be3nuDjqO3PbxZOng@mail.gmail.com>
Subject: Re: [PATCH] clk: Remove io.h from clk-provider.h
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Tero Kristo <t-kristo@ti.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        John Crispin <john@phrozen.org>,
        Heiko Stuebner <heiko@sntech.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Tue, May 14, 2019 at 7:09 PM Stephen Boyd <swboyd@chromium.org> wrote:
> Now that we've gotten rid of clk_readl() we can remove io.h from the
> clk-provider header and push out the io.h include to any code that isn't
> already including the io.h header but using things like readl/writel,
> etc.
>
> Found with this grep:
>
>   git grep -l clk-provider.h | grep '.c$' | xargs git grep -L 'linux/io.h' | \

Suggestion for future use:

    git grep -l clk-provider.h -- "*.c" | ...

> I'm going to push this into clk-next today and if nothing breaks, send
> it off for inclusion in a couple days, at least before -rc1 is released.

Thanks!

For clk/renesas:
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
