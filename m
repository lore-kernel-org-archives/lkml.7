Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC467C4740C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 13:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B940E222C2
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 13:45:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731009AbfIINph (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 09:45:37 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35066 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729438AbfIINpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 09:45:36 -0400
Received: by mail-qt1-f193.google.com with SMTP id k10so16220459qth.2;
        Mon, 09 Sep 2019 06:45:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xDjWmrpelBMsV8acnAMsSy3b05LWkf2FcGFKigsCXs8=;
        b=ZTF/tDzG62yB4FDhhFASUr7EB/XKctjUYY2chJU4IwpVsoFEdUoqzgCyrnQemvdEi2
         0Ejs1D0UDYwA7WyS24DNSNILzZep0CH/UGo2MnNRE3Gak7bZSP/rio5GkJddswe1Pa/k
         0dbjNPA6tTk1wlUaEltvo6BYFNlx7+8INsx+fLCY09CtJlLVtAbRoWlzvLRW0JTwfbqw
         iEP0QzLxeBPGIbNg6AaC/N99q0hdXyNFLQQd4m/2AjjhOwkufVBI2e0v4kavdv1Q4Y23
         +o6+iGvnkjXhiLyQiSKa/M0w93e3TE3m373oboCMdibPwBeWtcgrdk89MIZA1mvPKM5l
         nNrg==
X-Gm-Message-State: APjAAAXMJ4AybhpJab1vaUY33sxnIl2MyQNNZWu8kYCc52T8MOgxGfIx
        rbkEEwEHmKjwNzvS+8jRXKD6Bqj2SNm2vkvoGyk=
X-Google-Smtp-Source: APXvYqy6uMINd7bjqrBIpL+FlSlRZCnr6jDIP9BcfsScpej8dgHINCuOakM78zZlQ2S5h2RBKY29EifUZf3k9t5zUQM=
X-Received: by 2002:ac8:6b1a:: with SMTP id w26mr22956448qts.304.1568036734738;
 Mon, 09 Sep 2019 06:45:34 -0700 (PDT)
MIME-Version: 1.0
References: <1568020220-7758-1-git-send-email-talel@amazon.com>
 <1568020220-7758-4-git-send-email-talel@amazon.com> <CAK8P3a0DEMeFWK+RuAdSLyDYduWWwj9DxP_Beipays-d_6ixnA@mail.gmail.com>
 <ab512ced-d989-5c10-a550-2a4723d38e7e@amazon.com>
In-Reply-To: <ab512ced-d989-5c10-a550-2a4723d38e7e@amazon.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 9 Sep 2019 15:45:18 +0200
Message-ID: <CAK8P3a34eKFXoAPOfkFN5+H4kxOhRjXgws_0wy+d-186LFxcTw@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: alpine: select AL_POS
To:     "Shenhar, Talel" <talel@amazon.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        David Miller <davem@davemloft.net>,
        gregkh <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Patrick Venture <venture@google.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        Maxime Ripard <mripard@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        paul.kocialkowski@bootlin.com, mjourdan@baylibre.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        hhhawa@amazon.com, ronenk@amazon.com, jonnyc@amazon.com,
        hanochu@amazon.com, barakw@amazon.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 9, 2019 at 12:17 PM Shenhar, Talel <talel@amazon.com> wrote:
> On 9/9/2019 12:40 PM, Arnd Bergmann wrote:
> > On Mon, Sep 9, 2019 at 11:14 AM Talel Shenhar <talel@amazon.com> wrote:
> >> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> >> index 4778c77..bd86b15 100644
> >> --- a/arch/arm64/Kconfig.platforms
> >> +++ b/arch/arm64/Kconfig.platforms
> >> @@ -25,6 +25,7 @@ config ARCH_SUNXI
> >>   config ARCH_ALPINE
> >>          bool "Annapurna Labs Alpine platform"
> >>          select ALPINE_MSI if PCI
> >> +       select AL_POS
> >>          help
> >>            This enables support for the Annapurna Labs Alpine
> >>            Soc family.
> > Generally I think this kind of thing should go into the defconfig
> > rather than being hard-selected. There might be users that
> > want to not enable the driver.
>
> The reason for selecting it is because this is a driver that we will
> always want for ARCH_ALPINE.

Can you put the exact requirement (other than "we want this")
in the changelog text then? It's still not clear to me what breaks
without this driver.

        Arnd
