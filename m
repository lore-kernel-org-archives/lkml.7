Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3AF6CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 14:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AACE820640
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 14:33:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fo+M5yNG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728911AbfJUOd2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 10:33:28 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:37730 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727344AbfJUOd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 10:33:28 -0400
Received: by mail-vk1-f193.google.com with SMTP id v78so2803462vke.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 07:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8jfA0P/Q8T8UjCLrgdWWyNBUpvtRRs/536E+E+xKTUI=;
        b=fo+M5yNGWjh6WpyTan0dMaP6adElk8Q28uVOOSVGR6oiDnQuPMI6e5xfGmEds2bvv2
         IZMqR+5WOgGiJjjultpETJ7uo8T7veXupA55susBuyXB3N3RA8t2kBkiFC7FeiwQrY0a
         S3uv76RJKvqdexspozSjBMMdh+Fbw7PUvOfTRlUkCf3WFVU48277x4gcmqd5D63DMsLp
         SvtWTKOaN/08hHadAKZNaTeN3YkefHsndbvdf3CYoc7cu4n3287YMpAgef4nIr6AXUWQ
         lQfJ9MA1fE89OMxCfSUQ29NsqZEh07ssu/CmNX5i+UalUOUU+JKl/VNLstP4teC6m+4q
         AVtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8jfA0P/Q8T8UjCLrgdWWyNBUpvtRRs/536E+E+xKTUI=;
        b=Ezymb3o4qiOQS7mhd5DpJ8of9Y7EzPE4agTEw4xO7Hf0ahOmDcqbpMJMVkgPIIJZHM
         15rJwjdq5u8ZVtc+HKJhLozcuKIizbo2cGnAZFegt+rmb82v6YTHC7U/7wbFEX33I3Fk
         8t1fOpJ4gBz/g4DPapShPkxu1yhXXE2/vnXQQB0PaWNoEHcbgrfrH9PhgNIFGa4Z+YdC
         ZJURNmixGJrKCBVdtJ8qAUFFN3zW8QLr6i1iA2t52Mbkvc0stuJLQXMJA9X0KoY20Js+
         5aCbWdYD41dOvrT6v34eyN58pwVo+CUtp9+Cgk3r3NzCq832OPAdj2upd3VAenINZ9fq
         8Nzw==
X-Gm-Message-State: APjAAAUtafEKzql1ObSlAvvcYwbR0joJaiW06O9WJkrANklU//Xz8nkL
        C1BecrnPwIxe57rgHXxAaa1Yb/XOxthOq5ieDDT7kg==
X-Google-Smtp-Source: APXvYqwxG+OOH5vTVcxbeM++YEq/oLjw7diPz4dlTQB9dJJL+KeH2klQ2bLGQpl2ZMsrWsuLtAulGEUhOnAzfVkF7Ws=
X-Received: by 2002:a1f:2f51:: with SMTP id v78mr12965554vkv.101.1571668405527;
 Mon, 21 Oct 2019 07:33:25 -0700 (PDT)
MIME-Version: 1.0
References: <20191018131338.11713-1-hslester96@gmail.com>
In-Reply-To: <20191018131338.11713-1-hslester96@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 21 Oct 2019 16:32:49 +0200
Message-ID: <CAPDyKFoBYchP96hv=7XfTo8CrCSD+KC0h_oFRAsOYT-Lc1SFZQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: renesas_sdhi: add checks for pinctrl_lookup_state
To:     Chuhong Yuan <hslester96@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Oct 2019 at 15:13, Chuhong Yuan <hslester96@gmail.com> wrote:
>
> renesas_sdhi_probe misses checks for pinctrl_lookup_state and may miss
> failures.
> Add checks for them to fix the problem.
>
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> ---
>  drivers/mmc/host/renesas_sdhi_core.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
> index d4ada5cca2d1..dc5ad6632df3 100644
> --- a/drivers/mmc/host/renesas_sdhi_core.c
> +++ b/drivers/mmc/host/renesas_sdhi_core.c
> @@ -694,8 +694,13 @@ int renesas_sdhi_probe(struct platform_device *pdev,
>         if (!IS_ERR(priv->pinctrl)) {
>                 priv->pins_default = pinctrl_lookup_state(priv->pinctrl,
>                                                 PINCTRL_STATE_DEFAULT);
> +               if (IS_ERR(priv->pins_default))
> +                       return PTR_ERR(priv->pins_default);
> +
>                 priv->pins_uhs = pinctrl_lookup_state(priv->pinctrl,
>                                                 "state_uhs");
> +               if (IS_ERR(priv->pins_uhs))
> +                       return PTR_ERR(priv->pins_uhs);
>         }

This looks correct to me, as I guess if there is a pinctrl specified
for device node of the controller, it means that it should be used!?

I understand that this is only used for those variants that supports
UHS-I via the renesas_sdhi_start_signal_voltage_switch(). Wolfram, is
this fine you think?

>
>         host = tmio_mmc_host_alloc(pdev, mmc_data);
> --
> 2.20.1
>

Kind regards
Uffe
