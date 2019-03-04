Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D3AC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 12:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CEE22070B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 12:35:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbfCDMfY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 07:35:24 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:43615 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbfCDMfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 07:35:23 -0500
Received: by mail-ua1-f68.google.com with SMTP id g1so4208547uae.10;
        Mon, 04 Mar 2019 04:35:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w1B3TxawuZfoWnukQ4aoJb63D7QoG/Hwq34wP9Ec4OI=;
        b=rr/6NLDdthOpsLXk5/DEzmP1a1wh0+9CkOkcyAfoOJHDf011EVNFhpsz35DP1Zw26h
         PVOlIAhisxJOkgcFE0S19S3ViTee3eiHg/PcfzXE+TQGwNvEYHiJ9BXXuXBvstKEl0wB
         /uJ3/WGyJaeo2uDOMblDaujOBrZA2eAHi0X80CR4j+D7sNX+ptyQeDZpE6osr1uFQqXN
         ybDfjuPw9aYqk3XBxOJnZlrgcwz0UpUn7RnyQ4HD7sKHqIKlNPySYXejzRAWr0tAyXqy
         UpAMltAEY5vjx1wNbQXnLUhYg9Fy5kQbuHOuWrs7wYcct0FgzjVIqBJbXNGhDbjX6DYI
         d9mg==
X-Gm-Message-State: APjAAAX6S/r72U8zDckuO001cEVitX6qP85LZGMkOkYT0g9hwW9P76v1
        6psKxhf9J5qCrnQ11CRl+Fn/eNCZjtE+G8tVfwA=
X-Google-Smtp-Source: APXvYqx15knVAJlVLnsNJ7lOTEOyK4t5K1D8vGqLHSbnE6QPK9fpmDKdGe7rmE1nuayLqkO6dqYtiKQq7JhGzqsuzEs=
X-Received: by 2002:a67:7dd1:: with SMTP id y200mr8481973vsc.96.1551702922539;
 Mon, 04 Mar 2019 04:35:22 -0800 (PST)
MIME-Version: 1.0
References: <20190302134735.4393-1-wsa+renesas@sang-engineering.com> <20190302134735.4393-3-wsa+renesas@sang-engineering.com>
In-Reply-To: <20190302134735.4393-3-wsa+renesas@sang-engineering.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 4 Mar 2019 13:35:10 +0100
Message-ID: <CAMuHMdXPbsoWD3kJKK25=KL1kXsA23o7-7LsayMSoB=so4-zxw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/7] i2c: core: use I2C locking behaviour also for SMBUS
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     Linux I2C <linux-i2c@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Keerthy <j-keerthy@ti.com>, Peter Rosin <peda@axentia.se>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Stefan Lengfeld <contact@stefanchrist.eu>,
        Phil Reid <preid@electromag.com.au>,
        Tero Kristo <t-kristo@ti.com>,
        "open list:TI ETHERNET SWITCH DRIVER (CPSW)" 
        <linux-omap@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 2, 2019 at 2:49 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> If I2C transfers are executed in atomic contexts, trylock is used
> instead of lock. This behaviour was missing for SMBUS, although a lot of
> transfers are of SMBUS type, either emulated or direct. So, factor out
> the locking routine into a helper and use it for I2C and SMBUS.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Acked-by: Peter Rosin <peda@axentia.se>
> Acked-by: Tony Lindgren <tony@atomide.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
