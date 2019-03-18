Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 309E8C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 10:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0088620850
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 10:52:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LfHXM4sl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfCRKwD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 06:52:03 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:34397 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbfCRKwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 06:52:03 -0400
Received: by mail-ua1-f65.google.com with SMTP id c6so2635585uan.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 03:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NBVJIce5DakwzoiXVSQ5+lEX7UhvtkC0Ee/wHdQ8nGc=;
        b=LfHXM4slujme97ITPmx5wAypWTMHwIY1r4hbX/AcsouDotB2egBhskalOJpqgPBVuf
         KuejdtLvRfjbs1tYDOCZRP1UBeweFb0o8ivYsKf481tl/Vcg1LQ97A8pu4lhMFdhNl4b
         uvJXkv0CuQ/fz9gLT1JmFlEFn5UQoQ7D8vXql4FC1bKlFvF/J7KxxbnQeoQUqsxQuQ0D
         dwGGl5P+qmH+KBySc0D01Qs0HSB3nRqhga4WdFAa/8+cbtiiaqMzQQe2Fl73YUgeFey9
         LCZK9cxb1EqHwo82/6aKARsh7KVEWGE/dVwwYf4cp3l/eJnHDkxdI2H4lvIjNk0+2gr/
         ax0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NBVJIce5DakwzoiXVSQ5+lEX7UhvtkC0Ee/wHdQ8nGc=;
        b=SgwEXujhl5ZKnqU9sC0/0GGSTovkQ57eyJ8kPo3EiyRIs9UW8F6VrXd95XPHpXbemV
         6sTMvfzAXwGLXCB1f661MLX0cEbRFVVzU0OE28EDd+vA4967Wjh4YeqrUYhOLLkspVIG
         4C4+vl9/uBEl/K0SQWMIPzVbJSd+5dpL1N503E1edrtxLy7/u8x/nQYU3FZ/0p9yyRmR
         b9EgH9zc4T+mVEg/HMRWlb4oANGBTShLIFB97kgJboqmV869HFhho7UkCzrNSoqNnJpN
         DKbnU4JsxlsFHT8FdrV6ZQEiwTh8i3nSsxgThXj/nEF8IAqT9VVb9QakOTVWzmDA3eG7
         onHg==
X-Gm-Message-State: APjAAAWCK7NMgAQHnjRB9C22ZdXP5dGw0OubyOzwqx7Igg7oalTHY/DJ
        hwqiRGLJQQ/vzyJ8hwfxC2cW5XR6kvRbJxEGP/ZoHg==
X-Google-Smtp-Source: APXvYqwayf1C41aII9GGjem1SSILqp0B4owNq6T45CpTbJHPNzCAvHiRblPPeu7gLL8RbRmlHwH14LbQe6TOY5Jk57Q=
X-Received: by 2002:ab0:6819:: with SMTP id z25mr5850110uar.0.1552906322061;
 Mon, 18 Mar 2019 03:52:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190307100948.570006-1-arnd@arndb.de>
In-Reply-To: <20190307100948.570006-1-arnd@arndb.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 18 Mar 2019 11:51:26 +0100
Message-ID: <CAPDyKFq00AV6bhR0M-ZA5D0tO5S-cTx2bK=0w4DEGttb8khcOw@mail.gmail.com>
Subject: Re: [PATCH] mmc: pxamci: fix enum type confusion
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Robert Jarzmik <robert.jarzmik@free.fr>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Daniel Mack <daniel@zonque.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Mar 2019 at 11:09, Arnd Bergmann <arnd@arndb.de> wrote:
>
> clang points out several instances of mismatched types in this drivers,
> all coming from a single declaration:
>
> drivers/mmc/host/pxamci.c:193:15: error: implicit conversion from enumeration type 'enum dma_transfer_direction' to
>       different enumeration type 'enum dma_data_direction' [-Werror,-Wenum-conversion]
>                 direction = DMA_DEV_TO_MEM;
>                           ~ ^~~~~~~~~~~~~~
> drivers/mmc/host/pxamci.c:212:62: error: implicit conversion from enumeration type 'enum dma_data_direction' to
>       different enumeration type 'enum dma_transfer_direction' [-Werror,-Wenum-conversion]
>         tx = dmaengine_prep_slave_sg(chan, data->sg, host->dma_len, direction,
>
> The behavior is correct, so this must be a simply typo from
> dma_data_direction and dma_transfer_direction being similarly named
> types with a similar purpose.
>
> Fixes: 6464b7140951 ("mmc: pxamci: switch over to dmaengine use")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/pxamci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
> index c907bf502a12..c1d3f0e38921 100644
> --- a/drivers/mmc/host/pxamci.c
> +++ b/drivers/mmc/host/pxamci.c
> @@ -162,7 +162,7 @@ static void pxamci_dma_irq(void *param);
>  static void pxamci_setup_data(struct pxamci_host *host, struct mmc_data *data)
>  {
>         struct dma_async_tx_descriptor *tx;
> -       enum dma_data_direction direction;
> +       enum dma_transfer_direction direction;
>         struct dma_slave_config config;
>         struct dma_chan *chan;
>         unsigned int nob = data->blocks;
> --
> 2.20.0
>
