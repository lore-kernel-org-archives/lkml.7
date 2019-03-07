Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA576C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A895D20851
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:20:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JJ/Dkr36"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbfCGPUf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 10:20:35 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45172 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbfCGPUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 10:20:34 -0500
Received: by mail-ed1-f66.google.com with SMTP id f19so13753508eds.12;
        Thu, 07 Mar 2019 07:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=D092XwkeKdHq49RirItCcv0nHLZtgssXSduKzzpP7W4=;
        b=JJ/Dkr36Jea2tEr9zi9JTMhH1JKe3uPDBQttu2Qmp/cZesPN+B5vm8ghJb/Brhs9Uq
         +73AapJm1ll0QHnRo/3G467foaAxLK9+0nDOQ9Qt4Hcm9hvoteGyXhjxyHjPKVf6tITU
         6gIKeKLJky356eNNutBCSlR6SsEANlHUh86hLBBKEgQkEH/yYCmktx4kcfmnT5o1+x9e
         6r6tISNqYjf5MRrUt+G2UMgod6oRRDtdM+UkTmm3orhijoUYENWjgW7m5l1OUZBk7zq2
         XP9SK7XzIC/7tqoC3Tw5jL37G1UTC2gAwDfeASZjw8Yy3a6U9wI/h3mzz7DwX8fAZuwj
         RRVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=D092XwkeKdHq49RirItCcv0nHLZtgssXSduKzzpP7W4=;
        b=LP5mCekjMqGToLBMcRUO9fJfaVXitHKZqJ9m4+0jZxSm3NsjtaKO3iQXcvTdiROTS/
         7piBILL5h+mHgK6l2iavfIK2if64MsowAQZwcFy/DbgVYlOYaqPoCYpdGo/ZVfk7N0uZ
         aTDqaugIETBPHtbZ68JH631nB0ZINK06eYmWEafY7a+6Xw7QIaZzMtAp0p6SHhCHEd8M
         /JqHwQ8up+OBShEVMEFVDVW+PcyWdro4O+7HW2hbw2NceIDi97fET/HKJmlWek4Q7bBg
         jCctqIlriNwAcIf/5NHH4WtqpM46Tohrgvlb7jTjGZTt4td/LuMDqiyog5ZqcVowaU5/
         dA6A==
X-Gm-Message-State: APjAAAWHgZTf1RYVZwGbNVlCW8xIGmVenZvFnBdA/L5hT1sPefpX4jUA
        ENLnBxEQtVhr1wn6IB7rQ1w=
X-Google-Smtp-Source: APXvYqzu9m6sBEITuFXNUpS1HvP/o3t74RvZ4jq1q01+2paVUS/sl77NGHFUPbvW1qeRlRmGixxFzQ==
X-Received: by 2002:a50:a550:: with SMTP id z16mr28735790edb.95.1551972032747;
        Thu, 07 Mar 2019 07:20:32 -0800 (PST)
Received: from archlinux-ryzen ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id f40sm1392722eda.25.2019.03.07.07.20.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 07 Mar 2019 07:20:31 -0800 (PST)
Date:   Thu, 7 Mar 2019 08:20:29 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Daniel Mack <daniel@zonque.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: pxamci: fix enum type confusion
Message-ID: <20190307152029.GD20201@archlinux-ryzen>
References: <20190307100948.570006-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190307100948.570006-1-arnd@arndb.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 11:09:19AM +0100, Arnd Bergmann wrote:
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

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

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
>  	struct dma_async_tx_descriptor *tx;
> -	enum dma_data_direction direction;
> +	enum dma_transfer_direction direction;
>  	struct dma_slave_config	config;
>  	struct dma_chan *chan;
>  	unsigned int nob = data->blocks;
> -- 
> 2.20.0
> 
