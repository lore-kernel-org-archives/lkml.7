Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 289EAC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 08:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0682222CE3
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 08:28:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392806AbfHWI2j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 04:28:39 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43902 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390566AbfHWI2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 04:28:39 -0400
Received: by mail-ot1-f68.google.com with SMTP id e12so8041197otp.10
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 01:28:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I01Rd3eaxSJ78FG7Sav/xOd85SsWSsEzvMhKftmhJLE=;
        b=mQ9spONT1/DOnCwOYCs1jFqq5EOYQ5h1dBBo6WCcHhHTi/4/PRWa05u2hQAyEUlrYQ
         FCaxfYqtH19ZZv5ZEVI9xgl/G9OwKDtKY9dQx3ApjD8FRl8sgf8itnZbcEMSjayQybsb
         er5yyW+0w1vk/xPkeSIETCMPMCrtxzDqwZvlSNzxorIqGCAeY0m69aZB7bpZqh1Iu8QQ
         akzfe+0Dn+XdvQw3rU66YFie/i20h3+iMFruntsULVcKSi1W6wQt8sdYhYycUZ+eSKGY
         JM+m24tJfmIQ0Oajtr/M7KRfxPHNBmwQbpq5jzVpz+uYUHa2WHY1niJZuB6UoWfC38GS
         oFKg==
X-Gm-Message-State: APjAAAXKfhNEsYRcHP9XHUCo60MnRoSlLzRWgQKevCgHj+jG7hycMCGO
        VEEClwEGlpKYxaiCBvkzhJSa/xOlbKj3O2ZozVYKKQ==
X-Google-Smtp-Source: APXvYqyqdAxGVm2yMUytfNc9WX6a5aL/7hEQvriEj+yfmj8WyLMbwK0No6Navxiw9hVPjb9mfFcw4wZ2uC0dwAqCxI4=
X-Received: by 2002:a9d:61c3:: with SMTP id h3mr3269258otk.39.1566548918554;
 Fri, 23 Aug 2019 01:28:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190819080028.13091-1-geert@linux-m68k.org> <CACRpkdb66GWnW6j=G==vAP_79ePyVCL=dHwcM2ui-GRC58eCjg@mail.gmail.com>
In-Reply-To: <CACRpkdb66GWnW6j=G==vAP_79ePyVCL=dHwcM2ui-GRC58eCjg@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 23 Aug 2019 10:28:26 +0200
Message-ID: <CAMuHMdWAQn+GmJ6q_VfGdkMmS7amEaSUndSJ73J616nFKNbfFw@mail.gmail.com>
Subject: Re: [PATCH] soc: ixp4xx: Protect IXP4xx SoC drivers by ARCH_IXP4XX || COMPILE_TEST
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Linus Walleij <linusw@kernel.org>, Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Fri, Aug 23, 2019 at 10:26 AM Linus Walleij <linus.walleij@linaro.org> wrote:
> On Mon, Aug 19, 2019 at 10:46 AM Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > The move of the IXP4xx SoC drivers exposed their config options on all
> > platforms.
> >
> > Fix this by wrapping them inside an ARCH_IXP4XX or COMPILE_TEST block.
> >
> > Fixes: fcf2d8978cd538a5 ("ARM: ixp4xx: Move NPE and QMGR to drivers/soc")
> > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > ---
> > v2:
> >   - Rebased on top of commit ec8f24b7faaf3d47 ("treewide: Add SPDX
> >     license identifier - Makefile/Kconfig").
>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>
> Do you want me to also take care of sending this into the ARM SoC tree?

Given you're listed as (one of) the maintainer(s), I think that would make
perfect sense.

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
