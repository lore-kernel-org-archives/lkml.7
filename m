Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 760D1C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 06:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49D772087E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 06:32:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ehRWcBqW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbfIDGc5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 02:32:57 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:46346 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbfIDGc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 02:32:56 -0400
Received: by mail-ua1-f67.google.com with SMTP id k12so2356851uan.13
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 23:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pX/GIsxIbo847f+9FXL/2KTOJZD24+9rFmb5WYj6XnM=;
        b=ehRWcBqW/GnnrlLMZcxZ1viX7IZQO1jEB4mYsM9rvT1aBiuak1bsc24ghhQdY1flE3
         vPA2jiJUTn1TxryfeBlRjQ3Zwbs1C3Dunqzz4HZkyEiMl97AvEVyCVEaWjU6YE7yaZKk
         QFgRRsxbYODVVkXzkzv884LEQiuC6CBl0EzykoH6XDI3YiF6P/FItLJb/RwWZ3WBjEm+
         xgLWF+y9fqqIfJu3KwOf92/Px/4TcUs8f/18B1U+7F+oX/+glyXDhD/ZyW6QeKN+5uAF
         8okc6Lt6HMfjAbzd6/HPu9e0mzp/NiTRYkXmdgRsh9M2sq8qaAnaSsbXJHXkYvE0oeO/
         u+iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pX/GIsxIbo847f+9FXL/2KTOJZD24+9rFmb5WYj6XnM=;
        b=oNNU+4JpXBDVWgJR5qTaagm7vF+tfMmgzgVum2nRupLddK2GWfxxaSiZEFU3GGRXh1
         4SoLiUOFcMvv9DpRyhcAiIAJpxdf95IUAuh1MUZFhS7TX2fGPMRQwcgQeExzRZP1bzTn
         Sf+G96F+2MysyrINyoaiAGJdKMQ9GhB7d5bsTaTqQm2Mgum4baAM2TH3CXLp0cGfMKat
         XRjtiaT8nxQM1kMQrJ7VxWSRuf4H45ziuirZX1w7X9RE6WiINTnAGn9JGlMMsIUf0ePr
         BYqPGWK6192T9XqNSpF/p1uK68TGUqE+tzEqTuWpC1ELDqQdW0JfPmLfY3gRDbMY98eo
         oZOQ==
X-Gm-Message-State: APjAAAWvx2P8acuukJu2n1bfqbC77zL3yludzfFl/e2BJ7VYaLj0qYE6
        s5ce+AE4r+T4Qb2OO36Gj6+NRXDSMxU0xz/c0CqCAQ==
X-Google-Smtp-Source: APXvYqxLkO4gsK7ntkEBpo/NFXtCvWaI2cOa5+E0oSaexWzXKH/CEQPs/hLtZQ5zTm1z1/mU8QRSrIfhVXyy42mFJDY=
X-Received: by 2002:ab0:6601:: with SMTP id r1mr5047079uam.100.1567578775596;
 Tue, 03 Sep 2019 23:32:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190904022120.4174-1-andrew@aj.id.au>
In-Reply-To: <20190904022120.4174-1-andrew@aj.id.au>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 4 Sep 2019 08:32:18 +0200
Message-ID: <CAPDyKFqj84wm4hHTv4xWMOXpBBi5mkBB8BXJgNFb7-c_YtzpCg@mail.gmail.com>
Subject: Re: [PATCH v3] mmc: sdhci-of-aspeed: Depend on CONFIG_OF_ADDRESS
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Joel Stanley <joel@jms.id.au>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kbuild test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Sep 2019 at 04:20, Andrew Jeffery <andrew@aj.id.au> wrote:
>
> Resolves the following build error reported by the 0-day bot:
>
>     ERROR: "of_platform_device_create" [drivers/mmc/host/sdhci-of-aspeed.ko] undefined!
>
> SPARC does not set CONFIG_OF_ADDRESS so the symbol is missing. Depend on
> CONFIG_OF_ADDRESS to ensure the driver is only built for supported
> configurations.
>
> Fixes: 2d28dbe042f4 ("mmc: sdhci-of-aspeed: Add support for the ASPEED SD controller")
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>

Applied for next, thanks!

Kind regards
Uffe


> ---
> v2 was a series of 4 patches, three of which were applied leaving this build
> fix to be reworked. The v2 series can be found here:
>
> https://patchwork.ozlabs.org/cover/1156457/
>
>  drivers/mmc/host/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 0f8a230de2f3..3a52f5703286 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -157,7 +157,7 @@ config MMC_SDHCI_OF_ARASAN
>  config MMC_SDHCI_OF_ASPEED
>         tristate "SDHCI OF support for the ASPEED SDHCI controller"
>         depends on MMC_SDHCI_PLTFM
> -       depends on OF
> +       depends on OF && OF_ADDRESS
>         help
>           This selects the ASPEED Secure Digital Host Controller Interface.
>
> --
> 2.20.1
>
