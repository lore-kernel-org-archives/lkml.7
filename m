Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90AB4C433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 09:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F9792086D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 09:40:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390003AbfIIJkh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 05:40:37 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41560 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbfIIJkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 05:40:36 -0400
Received: by mail-qt1-f193.google.com with SMTP id j10so15367478qtp.8;
        Mon, 09 Sep 2019 02:40:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OSsOhHBNA6WtbtbcXdsydd62P7AL/2R8zBg5KGvl2fg=;
        b=PvPY02hUfe3iKw2FKJK+9my/KR5YHWL39pdOOUWtpgfHHPaqIldTkM16Pq98WCUKvU
         xOBIXY4BColuhJFkPbDEM1t56yGDqIJFBOehoSTrrEFGdjvKSA4X/1kTo/MaSOCMHZHt
         YKQJ5Zdxe3/D01BeJnvG8lqi84h5Yur7+dSVc1ueuUveiHFC154xvvicr4S5RDkKBMtz
         NoiCvffyQxSf5YfGq6PAF1PLdqg/5bseSKIQO3fPEAO6RYTRbzqds9RXCqdHuygpUtf7
         zhdj+ErG6PBRVzogrZ/qhqNal9z9+RjRYjfRBD5FvXIYDwfOOcBt8kfREDmhLfwYo8qu
         en4w==
X-Gm-Message-State: APjAAAXhGQ99zzN584yVfHejUvrSoWF9FAGM6QumZoxjaTBu9g+US1pk
        g7jOCk8ul9E6Y9lCbCj13APuIyrMPwGj86i+0cI=
X-Google-Smtp-Source: APXvYqwGHNSlvuqRvmxQq/EGJBTJRlR/BM2K59/TY6zrahtKUOrOlSXx0rXk+OXZ1vtblalawqRd5ou4Jyx8XeSegu8=
X-Received: by 2002:ac8:6b1a:: with SMTP id w26mr21971357qts.304.1568022035326;
 Mon, 09 Sep 2019 02:40:35 -0700 (PDT)
MIME-Version: 1.0
References: <1568020220-7758-1-git-send-email-talel@amazon.com> <1568020220-7758-4-git-send-email-talel@amazon.com>
In-Reply-To: <1568020220-7758-4-git-send-email-talel@amazon.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 9 Sep 2019 11:40:19 +0200
Message-ID: <CAK8P3a0DEMeFWK+RuAdSLyDYduWWwj9DxP_Beipays-d_6ixnA@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: alpine: select AL_POS
To:     Talel Shenhar <talel@amazon.com>
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

On Mon, Sep 9, 2019 at 11:14 AM Talel Shenhar <talel@amazon.com> wrote:
>
> Amazon's Annapurna Labs SoCs uses al-pos driver, enable it.
>
> Signed-off-by: Talel Shenhar <talel@amazon.com>
> ---
>  arch/arm64/Kconfig.platforms | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> index 4778c77..bd86b15 100644
> --- a/arch/arm64/Kconfig.platforms
> +++ b/arch/arm64/Kconfig.platforms
> @@ -25,6 +25,7 @@ config ARCH_SUNXI
>  config ARCH_ALPINE
>         bool "Annapurna Labs Alpine platform"
>         select ALPINE_MSI if PCI
> +       select AL_POS
>         help
>           This enables support for the Annapurna Labs Alpine
>           Soc family.

Generally I think this kind of thing should go into the defconfig
rather than being hard-selected. There might be users that
want to not enable the driver.

       Arnd
