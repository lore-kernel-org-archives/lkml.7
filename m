Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D6AEC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 08:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 658BD2184C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 08:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552551489;
	bh=D/bHFF0DYtp6x5PmFeQEeN3PVrqh0VQg0bZnb9rl9xk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=oUXXI7A6SuAF8iBhsRSY/aDxWHNtkgKpQgH8y8NyThnZvzitqIAahth6ko5J+HNL6
	 kyTWv55l1czlum8YN6XZl/EDeQ13Y7rez+oCh6tVjEwlIhjY6j3vwc9DWYtJzZl3rb
	 fdpHVGwiCvJFqdXFZL8AxRbVg9LCKCBRMMSBEiQY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbfCNISH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 04:18:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:51802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726539AbfCNISH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 04:18:07 -0400
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F08D421852;
        Thu, 14 Mar 2019 08:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552551486;
        bh=D/bHFF0DYtp6x5PmFeQEeN3PVrqh0VQg0bZnb9rl9xk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LnBIVdmmN6jPzRVW3eRbtwLBM4PHVGNviCY/I+5zFTFCt5pZ7lenJfP6BjUG5Yezv
         883HSGUn4NdwjrCmbsEeiAkSguGDwVc+PkoApLCRqHRFPzij3xGG3medHWtsaw2LEr
         CFxZDzKUZsgZrDMiPSpgJnqJOQLdrQ5Dm0t6PBcU=
Received: by mail-lf1-f43.google.com with SMTP id a132so2074061lfa.13;
        Thu, 14 Mar 2019 01:18:05 -0700 (PDT)
X-Gm-Message-State: APjAAAUgGXqufBIB5mY6NIEJghWjiYNieha9QgAurkaKmdJ1HYA33vHJ
        bS+AiLYugzR2QTLwuSlqMfzwK6UASJLF3T1P5SQ=
X-Google-Smtp-Source: APXvYqyidmxMbVe6bkoEOIHnf07DmMx6kadRYL1b66fpokFR/W+6EPDscDXJ/hRKjLywF9uz8Ez6j1A5OvZXvLagarI=
X-Received: by 2002:a19:4948:: with SMTP id l8mr16593560lfj.156.1552551484045;
 Thu, 14 Mar 2019 01:18:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190314064202.14864-1-kjlu@umn.edu>
In-Reply-To: <20190314064202.14864-1-kjlu@umn.edu>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Thu, 14 Mar 2019 09:17:53 +0100
X-Gmail-Original-Message-ID: <CAJKOXPfg+T-1acZd-NmSF6uerK0inCPirEyhGJ213VNtM5u1YQ@mail.gmail.com>
Message-ID: <CAJKOXPfg+T-1acZd-NmSF6uerK0inCPirEyhGJ213VNtM5u1YQ@mail.gmail.com>
Subject: Re: [PATCH] spi: fix NULL pointer dereferences by checking dmaengine_prep_slave_sg
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, Kukjin Kim <kgene@kernel.org>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Mar 2019 at 07:42, Kangjie Lu <kjlu@umn.edu> wrote:
>
> In case dmaengine_prep_slave_sg fails, the fix returns to avoid
> NULL pointer dereference.
>
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>

Hi,

Thanks for the patch, but the fix is the same as here:
https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1402451.html
and the answer is the same as there - I think you did not handle the
error at all. Did you test the error path in this case? How does it
behave? I think there is no point to replace one NULL pointer to
another NULL pointer right after it. :)

Best regards,
Krzysztof

> ---
>  drivers/spi/spi-s3c64xx.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> index 7b7151ec14c8..3a5f161ce558 100644
> --- a/drivers/spi/spi-s3c64xx.c
> +++ b/drivers/spi/spi-s3c64xx.c
> @@ -293,6 +293,8 @@ static void prepare_dma(struct s3c64xx_spi_dma_data *dma,
>
>         desc = dmaengine_prep_slave_sg(dma->ch, sgt->sgl, sgt->nents,
>                                        dma->direction, DMA_PREP_INTERRUPT);
> +       if (!desc)
> +               return;
>
>         desc->callback = s3c64xx_spi_dmacb;
>         desc->callback_param = dma;
> --
> 2.17.1
>
