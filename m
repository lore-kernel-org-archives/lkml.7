Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 420DDCA9EBC
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 12:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1759121872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 12:17:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TSznJC2N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439648AbfJXMR1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 08:17:27 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:34110 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbfJXMR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 08:17:27 -0400
Received: by mail-vs1-f65.google.com with SMTP id d3so16074395vsr.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 05:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sNS+0ZH0Gw7jjCkQeuG7rLnQoFmkx0bcU4Vuwapalrc=;
        b=TSznJC2NG3Y5TxoVaRiWfH4Vy4Dn5deWJutBTeFoKFBNaQKrmQRbnNNDFOE8ohWOfF
         O2ZHb7G8BmJZVjDnLUQ3cYhopl2cUmYsZkistSuia0JuY7Iv/OJiM6IGjeiekdEyR0lM
         +ddD8rWPzRWAXc2c9QOO3VbkBTLksRELKVUHcUeBejTxnpqLQJu6RQYb1WBnnGs5vGzD
         LDdWnb04rYzo07aM6eQ2NBMLBBA2sZpnD5FjjzY6LIFHltL28JjVEjIhPMleL2O0c+OM
         41JlAUbbSjCvHJLIuU8Q7PgeLn5qEtGn+0QfHHxVGSMumOLsi0t5hm2w93PJcXxak/V0
         qupA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sNS+0ZH0Gw7jjCkQeuG7rLnQoFmkx0bcU4Vuwapalrc=;
        b=ONySxI5WuupD5L90p8h+U3Z4J7CITN4OVpcKPPhMOL/etnGGNrvqWr2jlrP/R8YnPj
         5JFY1ADoEvXNy3mxf6F89GloIvALR8wNcx0VJzDi+yW+uDrp1VckTHKsV2E8sbU3oBQP
         7KoQil1WG/R+UF1+FehfHF3e/S9RXyxjb588JgKJL/gePkj+ydTV4KYTHGSvk9DVkAwU
         qNGge2zJdrA3MyPtyaHib3KLa33rcJq3B8IqeCbemH6Q2hjhPJ3KruSWHIqCHONJI+GK
         n+IMnCBYcG/pjm3yOZsuiYHS9ZB/rp+MuWaKD/jUMCXbjNFR6rll2Vqiv+mwCga4nOs0
         E6ig==
X-Gm-Message-State: APjAAAVOKfTRh5gK4lOVaPPP4TBiBj9H0h6UdppHDY3JF8nHvFALVNMj
        QDWumKlZvgKJAgqYBR3iHYfNjTGthF0TjGqOVZ9DvQ==
X-Google-Smtp-Source: APXvYqzqhpzcbYKla28yt8jpWxsX9rgQQYneKtDnu48YuaT+mxSVPuYskQJvGL1uqhsNTLZAmD7gOiwKMheJBTm/+6w=
X-Received: by 2002:a05:6102:2436:: with SMTP id l22mr3492203vsi.93.1571919446500;
 Thu, 24 Oct 2019 05:17:26 -0700 (PDT)
MIME-Version: 1.0
References: <20191017114906.30302-1-linux@rasmusvillemoes.dk> <20191017114906.30302-4-linux@rasmusvillemoes.dk>
In-Reply-To: <20191017114906.30302-4-linux@rasmusvillemoes.dk>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 24 Oct 2019 14:17:15 +0200
Message-ID: <CACRpkdYpnX0JMT9tG8AYhRQiXo90GJoF_J8c6f+KoWKvZmyj-g@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] decompress/keepalive.h: add config option for
 toggling a set of bits
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Gao Xiang <xiang@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Sascha Hauer <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2019 at 1:49 PM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:

> +config DECOMPRESS_KEEPALIVE_TOGGLE_REG
> +       hex "Address of register to modify while decompressing"
> +       help
> +         Set this to a physical address of a 32-bit memory word to
> +         modify while decompressing.
> +
> +config DECOMPRESS_KEEPALIVE_TOGGLE_MASK
> +       hex "Bit mask to toggle while decompressing"
> +       help
> +         The register selected above will periodically be xor'ed with
> +         this value during decompression.

I would not allow users to store these vital hex values in their
defconfig and other unsafe places. Instead follow the pattern from
arch/arm/Kconfig.debug for storing the DEBUG_UART_PHYS:

config DEBUG_UART_PHYS
        hex "Physical base address of debug UART"
        default 0x01c20000 if DEBUG_DAVINCI_DMx_UART0
        default 0x01c28000 if DEBUG_SUNXI_UART0
        default 0x01c28400 if DEBUG_SUNXI_UART1
....
i.e. make sure to provide the right default values. We probably
need at least one example for others to follow.

Maybe this is your plan, I don't know, wanted to point it out
anyways.

Yours,
Linus Walleij
