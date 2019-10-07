Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 099A3ECE58D
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 12:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2B8421721
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 12:03:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbfJGMDF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 08:03:05 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:40097 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727490AbfJGMDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 08:03:04 -0400
Received: by mail-oi1-f195.google.com with SMTP id k9so11381212oib.7;
        Mon, 07 Oct 2019 05:03:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SjlvWt+TP5em4hhlxgUiQ+FTlfEovVoQnG11bRnaQXg=;
        b=CgYfp4/ZlSeZFOdozcNNY3/R0R+n6BQ7+HhXjO8Jpk1XSzEK8NWYWrq0bxR/MGgpTq
         33cpxoz1fSRpkLPnhQd0Jd7X95Jglil5KVfuseoIRbay33MsOduYJ1etqyP5dfypBlaz
         Z9TYIrcm3/stvU9+K2vE8fUF3+2ZfZsEnhwFLYpmXJaMYpuXCJ/7XD28bYQxwmjNnpI8
         FNW7PhLhzPTxXrDX3m2oMGBbFvdkkbfT0shy0dqoMCZnckdUDFNWkV+PjjqgabYA/5f7
         W21GcfnkxMJ7rplReou/UaxQKwQ3JMUqeNxQf7sqd3U9orf0iB368Z15A7N9XKwXN2DO
         LkBw==
X-Gm-Message-State: APjAAAX252hDX1NfpJqgKjDIFIIFZ/iHJmhMwP0f9Ob+DUqYPmthRxCb
        lbQM1enwE4osjSfzv81uY2HmQlTbpxPrrBvW0Ds=
X-Google-Smtp-Source: APXvYqxg4pxC4P8ufrn2Xp4LTiuo8RNZqLnMmEWTzs6n4uOaV3eZZu95o5qT56+3Wy5rkjijbbbOi2hV8K5HeJFdn5s=
X-Received: by 2002:aca:f305:: with SMTP id r5mr17223296oih.131.1570449782920;
 Mon, 07 Oct 2019 05:03:02 -0700 (PDT)
MIME-Version: 1.0
References: <20191004094826.8320-1-linux@rasmusvillemoes.dk>
In-Reply-To: <20191004094826.8320-1-linux@rasmusvillemoes.dk>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 7 Oct 2019 14:02:49 +0200
Message-ID: <CAMuHMdXSb0mgsqJgNFWqJXywQJLsqvasj7P_bUj4MBvyrAUgVw@mail.gmail.com>
Subject: Re: [PATCH] clk: mark clk_disable_unused() as __init
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 4, 2019 at 12:30 PM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
> clk_disable_unused is only called once, as a late_initcall, so reclaim
> a bit of memory by marking it (and the functions and data it is the
> sole user of) as __init/__initdata. This moves ~1900 bytes from .text
> to .init.text for a imx_v6_v7_defconfig.
>
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
