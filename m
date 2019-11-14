Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 861CEC43215
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 11:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 577E92068D
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 11:56:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eU+XUfxe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfKNL41 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 06:56:27 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33280 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbfKNL40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 06:56:26 -0500
Received: by mail-lj1-f196.google.com with SMTP id t5so6390168ljk.0;
        Thu, 14 Nov 2019 03:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RP7UNiyaHO8+r7kpfPPSZl+7CLaEDwaXa5rOmyP2nQs=;
        b=eU+XUfxe4PlTZis397kJtmf4KQjVzXI6BTm9ZdjA2S9dF7vi/sonk7PvVhHIsm1XYH
         8N/qdGGHqIDXOb59fQNvso6kUK0p4e8xISvjBkdh3Gdm6tsnclFRCUD8tPIxQaMvsE4X
         InlCwSk9Icd2p8+C/Oh9pEYj+2o78t8VOTmFLYIVVft+l+o4eZAJhT7qNfDb/XJGYLZl
         +aDX/Cay3u4YrSlK7HWYQGS1cwvPADBKMHvYktF5mpL7UEgA3LrOPm4OnF0H/A8lYkpY
         lpX3zpXMOcVV6XGXEBva8FabDEKsNuYOmDnus7TeUWasUd3n/dSWem9E7f7qoZ32E8+O
         Pw7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RP7UNiyaHO8+r7kpfPPSZl+7CLaEDwaXa5rOmyP2nQs=;
        b=lbNpIK3MGPzw9jhSNh5Zh6qvYnWfHZZ7tX1fbHQ9AZIZ2dE8k9eMd7AeTfM3UaG2s6
         aNkCi+3EgsZlGZOsLif3YUnHQ8dEckUrwl7yyHIeJ+POHDg0is5oCa/rJy7LP30/saLP
         PdyTsMj31Oj0C7h5Pqx0/W2clwlCc6tNRl9/h/jI91Dasx3c/ububiZR6xI8PIsr6aj2
         6xec4os+24VoMLoUITuq5/g9Q2lXfu5qqRsrjSrUFU+8gRVJp37qSX3O64uw1WInQ09W
         CQ8T2fqCZByr78nUvRkIitWqrjS1WsbZ7pW/35bw+qjTHg618KKhCEEPSGPFVC9IzafI
         G7nw==
X-Gm-Message-State: APjAAAXbOML3Zdt77UaQnwtxJGQidPySogA9P0K3ufgTxciP467xoIVf
        aw02NHV2OStr1cncm6cZouOoIZLw
X-Google-Smtp-Source: APXvYqzxS0ZnVRzWZix8WOIpETzLNmYrA9tvR5zprlN01ZVStJ4SbLlB1oo25V7aQSZrgZhfTvIJqg==
X-Received: by 2002:a2e:8601:: with SMTP id a1mr6431993lji.159.1573732582273;
        Thu, 14 Nov 2019 03:56:22 -0800 (PST)
Received: from [192.168.2.145] (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.googlemail.com with ESMTPSA id z17sm2087243ljm.16.2019.11.14.03.56.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2019 03:56:21 -0800 (PST)
Subject: Re: clk/clk-next boot bisection: v5.4-rc1-201-ga228ae437aa5 on
 tegra124-nyan-big
To:     "kernelci.org bot" <bot@kernelci.org>, tomeu.vizoso@collabora.com,
        Stephen Boyd <sboyd@kernel.org>,
        guillaume.tucker@collabora.com, mgalka@collabora.com,
        Thierry Reding <treding@nvidia.com>, broonie@kernel.org,
        matthew.hart@linaro.org, khilman@baylibre.com,
        enric.balletbo@collabora.com,
        Thierry Reding <thierry.reding@gmail.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        linux-kernel@vger.kernel.org,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        linux-tegra@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org
References: <5dccdf20.1c69fb81.418aa.a71c@mx.google.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <2696747d-3a82-4244-84dc-bb351364e53e@gmail.com>
Date:   Thu, 14 Nov 2019 14:56:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <5dccdf20.1c69fb81.418aa.a71c@mx.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

14.11.2019 07:59, kernelci.org bot пишет:
> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> * This automated bisection report was sent to you on the basis  *
> * that you may be involved with the breaking commit it has      *
> * found.  No manual investigation has been done to verify it,   *
> * and the root cause of the problem may be somewhere else.      *
> *                                                               *
> * If you do send a fix, please include this trailer:            *
> *   Reported-by: "kernelci.org bot" <bot@kernelci.org>          *
> *                                                               *
> * Hope this helps!                                              *
> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> 
> clk/clk-next boot bisection: v5.4-rc1-201-ga228ae437aa5 on tegra124-nyan-big
> 
> Summary:
>   Start:      a228ae437aa5 Merge branch 'clk-unused' into clk-next
>   Details:    https://kernelci.org/boot/id/5dcc99e959b514100f138e14
>   Plain log:  https://storage.kernelci.org//clk/clk-next/v5.4-rc1-201-ga228ae437aa5/arm/tegra_defconfig/gcc-8/lab-collabora/boot-tegra124-nyan-big.txt
>   HTML log:   https://storage.kernelci.org//clk/clk-next/v5.4-rc1-201-ga228ae437aa5/arm/tegra_defconfig/gcc-8/lab-collabora/boot-tegra124-nyan-big.html
>   Result:     25175c806a68 clk: tegra: Reimplement SOR clock on Tegra124
> 
> Checks:
>   revert:     PASS
>   verify:     PASS
> 
> Parameters:
>   Tree:       clk
>   URL:        https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git
>   Branch:     clk-next
>   Target:     tegra124-nyan-big
>   CPU arch:   arm
>   Lab:        lab-collabora
>   Compiler:   gcc-8
>   Config:     tegra_defconfig
>   Test suite: boot
> 
> Breaking commit found:
> 
> -------------------------------------------------------------------------------
> commit 25175c806a6841149abe46168e0af12593141612
> Author: Thierry Reding <treding@nvidia.com>
> Date:   Thu Jul 25 18:19:00 2019 +0200
> 
>     clk: tegra: Reimplement SOR clock on Tegra124
>     
>     In order to allow the display driver to deal uniformly with all SOR
>     generations, implement the SOR clocks in a way that is compatible with
>     Tegra186 and later.
>     
>     Acked-by: Stephen Boyd <sboyd@kernel.org>
>     Signed-off-by: Thierry Reding <treding@nvidia.com>
> 
> diff --git a/drivers/clk/tegra/clk-tegra124.c b/drivers/clk/tegra/clk-tegra124.c
> index 7d231529c3a5..b3110d5b5a6c 100644
> --- a/drivers/clk/tegra/clk-tegra124.c
> +++ b/drivers/clk/tegra/clk-tegra124.c
> @@ -1005,20 +1005,24 @@ static struct tegra_devclk devclks[] __initdata = {
>  	{ .con_id = "hda2hdmi", .dt_id = TEGRA124_CLK_HDA2HDMI },
>  };
>  
> -static const char *mux_pllp_pllm_plld_plla_pllc_plld2_clkm[] = {
> -	"pll_p", "pll_m", "pll_d_out0", "pll_a_out0", "pll_c",
> -	"pll_d2_out0", "clk_m"
> +static const char * const sor0_parents[] = {
> +	"pll_p_out0", "pll_m_out0", "pll_d_out0", "pll_a_out0", "pll_c_out0",
> +	"pll_d2_out0", "clk_m",
>  };

I'm not sure how it supposed to work because looks like some of these
"_out0" parent clocks just do not exists in the upstream clk driver.

Either some other patch that adds "_out0" aliases is missed or this
patch was based on top of a different codebase (downstream kernel?).

What's also a bit odd is that commit says Tegra186.. but AFAIK there is
no driver for Tegra186 clocks in upstream.

BTW, seems T114 clk driver also uses a non-existent pll_m/p/c_out0 for
the emc_mux.

Thierry / Peter, could you please explain what's going on with this
patch and why clocks are missed on T114? Maybe I'm missing something?

> -#define mux_pllp_pllm_plld_plla_pllc_plld2_clkm_idx NULL
>  
> -static const char *mux_clkm_plldp_sor0out[] = {
> -	"clk_m", "pll_dp", "sor0_out",
> +static const char * const sor0_out_parents[] = {
> +	"clk_m", "sor0_pad_clkout",
>  };
> -#define mux_clkm_plldp_sor0out_idx NULL
>  
>  static struct tegra_periph_init_data tegra124_periph[] = {
> -	MUX8_NOGATE_LOCK("sor0_out", mux_pllp_pllm_plld_plla_pllc_plld2_clkm, CLK_SOURCE_SOR0, tegra_clk_sor0_out, &sor0_lock),
> -	NODIV("sor0", mux_clkm_plldp_sor0out, CLK_SOURCE_SOR0, 14, 3, 182, 0, tegra_clk_sor0, &sor0_lock),
> +	TEGRA_INIT_DATA_TABLE("sor0", NULL, NULL, sor0_parents,
> +			      CLK_SOURCE_SOR0, 29, 0x7, 0, 0, 0, 0,
> +			      0, 182, 0, tegra_clk_sor0, NULL, 0,
> +			      &sor0_lock),
> +	TEGRA_INIT_DATA_TABLE("sor0_out", NULL, NULL, sor0_out_parents,
> +			      CLK_SOURCE_SOR0, 14, 0x1, 0, 0, 0, 0,
> +			      0, 0, TEGRA_PERIPH_NO_GATE, tegra_clk_sor0_out,
> +			      NULL, 0, &sor0_lock),
>  };
>  
>  static struct clk **clks;
> -------------------------------------------------------------------------------
> 
> 
> Git bisection log:
> 
> -------------------------------------------------------------------------------
> git bisect start
> # good: [dafbb1e6473788cb3068eaeddc58f9d88e9c7a62] Merge branch 'clk-ti' into clk-next
> git bisect good dafbb1e6473788cb3068eaeddc58f9d88e9c7a62
> # bad: [a228ae437aa553736058cbbd58d2d0e191635cdc] Merge branch 'clk-unused' into clk-next
> git bisect bad a228ae437aa553736058cbbd58d2d0e191635cdc
> # bad: [3214be6cb1e487b0f8c3bb2eac9b06df07a07e06] clk: tegra: Share clk and rst register defines with Tegra clock driver
> git bisect bad 3214be6cb1e487b0f8c3bb2eac9b06df07a07e06
> # bad: [05308d7e7bbc932025f1dafc401c73ce83c6f414] clk: tegra: Reimplement SOR clocks on Tegra210
> git bisect bad 05308d7e7bbc932025f1dafc401c73ce83c6f414
> # good: [d1ee3173a139ed2eb8d87e06216f0426b16084d8] Merge branch 'for-5.5/dt-bindings' into for-5.5/clk
> git bisect good d1ee3173a139ed2eb8d87e06216f0426b16084d8
> # good: [e5f8a107d92db30a7ad7d8d95aee59f5ad76206a] clk: tegra: Move SOR0 implementation to Tegra124
> git bisect good e5f8a107d92db30a7ad7d8d95aee59f5ad76206a
> # bad: [25175c806a6841149abe46168e0af12593141612] clk: tegra: Reimplement SOR clock on Tegra124
> git bisect bad 25175c806a6841149abe46168e0af12593141612
> # good: [da8d1a3555406275650b366460c6235f1696bf8b] clk: tegra: Rename sor0_lvds to sor0_out
> git bisect good da8d1a3555406275650b366460c6235f1696bf8b
> # first bad commit: [25175c806a6841149abe46168e0af12593141612] clk: tegra: Reimplement SOR clock on Tegra124
> -------------------------------------------------------------------------------
> 

