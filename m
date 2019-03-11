Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 268AAC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 05:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7138206DF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 05:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552283281;
	bh=dvPU26e8PNP/AuAFulRw6zeHgmvQ5pRxCpsu5mVY484=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=2ex/aJkn1mQerfTOUBU+NM8SKfI5mKWFM0MDYR8Z2g/oHDHUCkh2uUK8LJ5R9Oou5
	 1F6iJCBg3fS+LlrMfLvz+ucM44Eysg4QobXcMLvWnPJi7j+3zLko1u261BZ3psTf9N
	 OGROGNLhd8XYx3WUvyzk/8MdOyU/uSCEPfU0PG9c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbfCKFr7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 01:47:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:60916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725831AbfCKFr7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 01:47:59 -0400
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06AF5206DF;
        Mon, 11 Mar 2019 05:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552283277;
        bh=dvPU26e8PNP/AuAFulRw6zeHgmvQ5pRxCpsu5mVY484=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KCzX6q/SU/fdda/HoDgSaMuCS4SDnSJgypE2SgOt84IVgoaT2pgBpNjLCqhCPWuuJ
         5SzQjnhjhdZ/uX/89cimZlio3X5gEj8kSdrkPyjHfW4Jfh/nuOakfoT0mfudUftebF
         85/bp8OwHnT+q6cSJiESdkH47tjelZniOw0v61EU=
Received: by mail-wm1-f49.google.com with SMTP id c13so13079970wmb.0;
        Sun, 10 Mar 2019 22:47:56 -0700 (PDT)
X-Gm-Message-State: APjAAAU6qKh28Bt/EK6SAtzLRTHQZCJau5gaAtWdigL7Dpk7jB752XME
        LZwDhpvKwdCGlZQRexvXbS8JGE7cpdZujc0raxE=
X-Google-Smtp-Source: APXvYqwR0xUmUuQCkLjP7+ElsebBvyT+rOPb4y26fpO5RMqwFEKVf90TdkhHUPJHr0ohAI9xF4XNTbkw14pMcm5/2wU=
X-Received: by 2002:a1c:4c08:: with SMTP id z8mr14512901wmf.99.1552283275492;
 Sun, 10 Mar 2019 22:47:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190307165829.9086-1-jernej.skrabec@siol.net> <20190307165829.9086-3-jernej.skrabec@siol.net>
In-Reply-To: <20190307165829.9086-3-jernej.skrabec@siol.net>
From:   Chen-Yu Tsai <wens@kernel.org>
Date:   Mon, 11 Mar 2019 13:47:43 +0800
X-Gmail-Original-Message-ID: <CAGb2v65GNtmDdmnixfdFg6Lt4Rzq_MrUf==fiV=wtgk+uR6WzA@mail.gmail.com>
Message-ID: <CAGb2v65GNtmDdmnixfdFg6Lt4Rzq_MrUf==fiV=wtgk+uR6WzA@mail.gmail.com>
Subject: Re: [PATCH 2/6] dmaengine: sun6i: Add a quirk for additional mbus clock
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>, vkoul@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 8, 2019 at 12:58 AM Jernej Skrabec <jernej.skrabec@siol.net> wrote:
>
> H6 DMA controller needs additional mbus clock to be enabled.
>
> Add a quirk for it and handle it accordingly.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  drivers/dma/sun6i-dma.c | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
> index 0cd13f17fc11..761555080325 100644
> --- a/drivers/dma/sun6i-dma.c
> +++ b/drivers/dma/sun6i-dma.c
> @@ -129,6 +129,7 @@ struct sun6i_dma_config {
>         u32 dst_burst_lengths;
>         u32 src_addr_widths;
>         u32 dst_addr_widths;
> +       bool mbus_clk;

Nit: has_mbus_clk. Be explicit. Leave nothing to assumptions.

>  };
>
>  /*
> @@ -182,6 +183,7 @@ struct sun6i_dma_dev {
>         struct dma_device       slave;
>         void __iomem            *base;
>         struct clk              *clk;
> +       struct clk              *clk_mbus;
>         int                     irq;
>         spinlock_t              lock;
>         struct reset_control    *rstc;
> @@ -1208,6 +1210,14 @@ static int sun6i_dma_probe(struct platform_device *pdev)
>                 return PTR_ERR(sdc->clk);
>         }
>
> +       if (sdc->cfg->mbus_clk) {
> +               sdc->clk_mbus = devm_clk_get(&pdev->dev, "mbus");
> +               if (IS_ERR(sdc->clk_mbus)) {
> +                       dev_err(&pdev->dev, "No mbus clock specified\n");
> +                       return PTR_ERR(sdc->clk_mbus);
> +               }
> +       }
> +
>         sdc->rstc = devm_reset_control_get(&pdev->dev, NULL);
>         if (IS_ERR(sdc->rstc)) {
>                 dev_err(&pdev->dev, "No reset controller specified\n");
> @@ -1312,11 +1322,19 @@ static int sun6i_dma_probe(struct platform_device *pdev)
>                 goto err_reset_assert;
>         }
>
> +       if (sdc->cfg->mbus_clk) {
> +               ret = clk_prepare_enable(sdc->clk_mbus);

The clk API checks for NULL pointer, so you could just drop the
conditional here.

> +               if (ret) {
> +                       dev_err(&pdev->dev, "Couldn't enable mbus clock\n");
> +                       goto err_clk_disable;
> +               }
> +       }
> +
>         ret = devm_request_irq(&pdev->dev, sdc->irq, sun6i_dma_interrupt, 0,
>                                dev_name(&pdev->dev), sdc);
>         if (ret) {
>                 dev_err(&pdev->dev, "Cannot request IRQ\n");
> -               goto err_clk_disable;
> +               goto err_mbus_clk_disable;
>         }
>
>         ret = dma_async_device_register(&sdc->slave);
> @@ -1341,6 +1359,8 @@ static int sun6i_dma_probe(struct platform_device *pdev)
>         dma_async_device_unregister(&sdc->slave);
>  err_irq_disable:
>         sun6i_kill_tasklet(sdc);
> +err_mbus_clk_disable:
> +       clk_disable_unprepare(sdc->clk_mbus);

Since you aren't using it here either.

ChenYu


>  err_clk_disable:
>         clk_disable_unprepare(sdc->clk);
>  err_reset_assert:
> @@ -1359,6 +1379,7 @@ static int sun6i_dma_remove(struct platform_device *pdev)
>
>         sun6i_kill_tasklet(sdc);
>
> +       clk_disable_unprepare(sdc->clk_mbus);
>         clk_disable_unprepare(sdc->clk);
>         reset_control_assert(sdc->rstc);
>
> --
> 2.21.0
>
