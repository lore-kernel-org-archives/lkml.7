Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD7E3C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 10:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 764E322387
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 10:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563965985;
	bh=+SLeYzBrFqrvQlKq8tfptWG7tfjTeB0dYCaKxtC/F1U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=RMWI0l4wHpBSbIAhdIKUurzIqdeI0NmhAQ2L2L+26cI+lsyn9ND0moDd8cofQO9t9
	 MS55/KiyfC30W2ntAk9bdwguJxsXQq4K+13NvJFtgWrhkEYV8meBrCT1CLUkfZak7g
	 Y8oL72l0aHBQWQqY9ZPlWvxJ8z5fGAi0tUkXesEQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbfGXK7o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 06:59:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:60622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726622AbfGXK7o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 06:59:44 -0400
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2274B22ADA;
        Wed, 24 Jul 2019 10:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563965983;
        bh=+SLeYzBrFqrvQlKq8tfptWG7tfjTeB0dYCaKxtC/F1U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HAv7AF0ukKxL6GYXk1xun6fguFyzJ7NapvsVooizJX9ii0nisFl4Rz0JDEw9Ab3b2
         gjhffA7s31ujpM4iPuY1BfjQqGmT7Si1Mt7OOeRQKdz6lfzkth32MAzg0mglg73Xf/
         Eg1AX/SsYMKjTrWI+PEW4oeXPwa7OZ0/SydEoASs=
Received: by mail-lj1-f178.google.com with SMTP id i21so44091342ljj.3;
        Wed, 24 Jul 2019 03:59:43 -0700 (PDT)
X-Gm-Message-State: APjAAAX/Wjj51n2DoamswMECmf3ZxItO2kkPNKeMg2uNkA9FIjjHnDeU
        nNw6i4Br02m4FHWGmnFnhBjQftgj9EX0NxNCzl4=
X-Google-Smtp-Source: APXvYqwezSx0YMy1Onv2nAziBZ5h3uvoLRSWEZ6B72J6vovOVKzX95DIdnPlSg9aaez+CQYQ18XozsjqXWS11kg092g=
X-Received: by 2002:a2e:124b:: with SMTP id t72mr43113386lje.143.1563965981368;
 Wed, 24 Jul 2019 03:59:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190722185938.9043-1-linux.amoon@gmail.com> <20190722185938.9043-2-linux.amoon@gmail.com>
In-Reply-To: <20190722185938.9043-2-linux.amoon@gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 24 Jul 2019 12:59:30 +0200
X-Gmail-Original-Message-ID: <CAJKOXPch9i0GBLLTQFNF=jPSJ++ZUJeE+Y5MCA7zFLFYO79R4Q@mail.gmail.com>
Message-ID: <CAJKOXPch9i0GBLLTQFNF=jPSJ++ZUJeE+Y5MCA7zFLFYO79R4Q@mail.gmail.com>
Subject: Re: [RFC/RFT 1/5] phy: exynos5-usbdrd: read from correct offset of
 xhci linksystem
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Kukjin Kim <kgene@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Jul 2019 at 20:59, Anand Moon <linux.amoon@gmail.com> wrote:
>
> Read from linksystem offset to update the xhci version.

But why? As many times before, you do not specify why you are doing
things. What problem are you solving? What feature are you adding?

Best regards,
Krzysztof

>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
>  drivers/phy/samsung/phy-exynos5-usbdrd.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/phy/samsung/phy-exynos5-usbdrd.c b/drivers/phy/samsung/phy-exynos5-usbdrd.c
> index 646259bee909..3c14bf7718c1 100644
> --- a/drivers/phy/samsung/phy-exynos5-usbdrd.c
> +++ b/drivers/phy/samsung/phy-exynos5-usbdrd.c
> @@ -397,7 +397,8 @@ static int exynos5_usbdrd_phy_init(struct phy *phy)
>          * Setting the Frame length Adj value[6:1] to default 0x20
>          * See xHCI 1.0 spec, 5.2.4
>          */
> -       reg =   LINKSYSTEM_XHCI_VERSION_CONTROL |
> +       reg = readl(phy_drd->reg_phy + EXYNOS5_DRD_LINKSYSTEM);
> +       reg |=  LINKSYSTEM_XHCI_VERSION_CONTROL |
>                 LINKSYSTEM_FLADJ(0x20);
>         writel(reg, phy_drd->reg_phy + EXYNOS5_DRD_LINKSYSTEM);
>
> --
> 2.22.0
>
