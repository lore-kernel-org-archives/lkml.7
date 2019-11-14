Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A89C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 12:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00A76206F0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 12:30:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qB9TH3Jf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbfKNMal (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 07:30:41 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35310 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfKNMal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 07:30:41 -0500
Received: by mail-lf1-f68.google.com with SMTP id i26so4935319lfl.2;
        Thu, 14 Nov 2019 04:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hGArsf264JQk+iPX0IPuPINftEWiX5+PAj4DcYgpx7w=;
        b=qB9TH3JfzS49Ep1Yed43S5rnCbiK/aRGKYZmtHFp4wgQ1Od5C+7LpXfRXGrLG1xhOw
         zNgNTTpasunMhGwwij1EubHFvZEXVYIZWocmxqhOckX97VjrYAHcqRRTofl3iEYqqczu
         v4YASRxTD9P9rNQRxB6JkTGGRXqBtHKnMBADXxHPIW605+bWcI4Zp2hKo7YWjFXe7o7X
         3iGZhNO/H03FcMrmu4rfcubOTkyXhRxrFlsvfxtAYWUtu5GfMvhbWIQjnRxeqxP7wZPD
         cftw5Mx5jXDh6m3hjEmhsMC3Vlod6m0mDBJP34p8HNyteU1oIRGQ57Lac+Y8pZMIFjdS
         U5Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hGArsf264JQk+iPX0IPuPINftEWiX5+PAj4DcYgpx7w=;
        b=HiRLkBexL9IcnVgi27poIgp/sUlDnFfXXW7oFZiJFOl/HQ7/VfkyLYtKkv5z97Oml0
         6drl8gfsvqfU8WN2Vf0i509H9CpZxHrxPzl0DyJZZwXJqLLnTwTveOYpOZ2Td47BKzO8
         iQSa3Lanc3p6C90gwVpdkNXCjw4BJ1Vy6+VrmjY2v7/s6R4u4t4I8VZRvxCzhvfiS7ju
         r9w8Tpe6/q6YpAYvpwLlXOTYRmf4rMg+4Yf2MYFlx64qac/mwW3d/PudckFvOYP0lEPD
         hQmk7ip+0Urh+O0oPOAuD34UT6wgj8+SqpJkFr/M1UZ01qnniZARZWnPsjg+mQXKhuIH
         ZUpA==
X-Gm-Message-State: APjAAAUszlAcoJNGL5wfdZ/1mqev3SPVwAz39oQk2ofDTyNz/lSDtjbO
        WPhAv8E5Vlgsbu2TKWAQhvyGmwTL
X-Google-Smtp-Source: APXvYqzXRmKSGQ97chUIAUpRhU5DpoT8jSbBVituFjgS7tvCiu581kVtmeXwU7wgR+CIsCJ7SW8AgQ==
X-Received: by 2002:a19:8114:: with SMTP id c20mr6712488lfd.22.1573734636423;
        Thu, 14 Nov 2019 04:30:36 -0800 (PST)
Received: from [192.168.2.145] (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.googlemail.com with ESMTPSA id z3sm2625863lji.36.2019.11.14.04.30.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2019 04:30:35 -0800 (PST)
Subject: Re: clk/clk-next boot bisection: v5.4-rc1-201-ga228ae437aa5 on
 tegra124-nyan-big
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     "kernelci.org bot" <bot@kernelci.org>, tomeu.vizoso@collabora.com,
        Stephen Boyd <sboyd@kernel.org>,
        guillaume.tucker@collabora.com, mgalka@collabora.com,
        Thierry Reding <treding@nvidia.com>, broonie@kernel.org,
        matthew.hart@linaro.org, khilman@baylibre.com,
        enric.balletbo@collabora.com,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-kernel@vger.kernel.org,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        linux-tegra@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org
References: <5dccdf20.1c69fb81.418aa.a71c@mx.google.com>
 <2696747d-3a82-4244-84dc-bb351364e53e@gmail.com>
 <20191114121529.GD5690@aiwendil>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <3ec9c0c6-7a52-4c5e-7784-c56e416e3721@gmail.com>
Date:   Thu, 14 Nov 2019 15:30:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191114121529.GD5690@aiwendil>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

14.11.2019 15:15, Thierry Reding пишет:
> On Thu, Nov 14, 2019 at 02:56:20PM +0300, Dmitry Osipenko wrote:
>> 14.11.2019 07:59, kernelci.org bot пишет:
>>> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
>>> * This automated bisection report was sent to you on the basis  *
>>> * that you may be involved with the breaking commit it has      *
>>> * found.  No manual investigation has been done to verify it,   *
>>> * and the root cause of the problem may be somewhere else.      *
>>> *                                                               *
>>> * If you do send a fix, please include this trailer:            *
>>> *   Reported-by: "kernelci.org bot" <bot@kernelci.org>          *
>>> *                                                               *
>>> * Hope this helps!                                              *
>>> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
>>>
>>> clk/clk-next boot bisection: v5.4-rc1-201-ga228ae437aa5 on tegra124-nyan-big
>>>
>>> Summary:
>>>   Start:      a228ae437aa5 Merge branch 'clk-unused' into clk-next
>>>   Details:    https://kernelci.org/boot/id/5dcc99e959b514100f138e14
>>>   Plain log:  https://storage.kernelci.org//clk/clk-next/v5.4-rc1-201-ga228ae437aa5/arm/tegra_defconfig/gcc-8/lab-collabora/boot-tegra124-nyan-big.txt
>>>   HTML log:   https://storage.kernelci.org//clk/clk-next/v5.4-rc1-201-ga228ae437aa5/arm/tegra_defconfig/gcc-8/lab-collabora/boot-tegra124-nyan-big.html
>>>   Result:     25175c806a68 clk: tegra: Reimplement SOR clock on Tegra124
>>>
>>> Checks:
>>>   revert:     PASS
>>>   verify:     PASS
>>>
>>> Parameters:
>>>   Tree:       clk
>>>   URL:        https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git
>>>   Branch:     clk-next
>>>   Target:     tegra124-nyan-big
>>>   CPU arch:   arm
>>>   Lab:        lab-collabora
>>>   Compiler:   gcc-8
>>>   Config:     tegra_defconfig
>>>   Test suite: boot
>>>
>>> Breaking commit found:
>>>
>>> -------------------------------------------------------------------------------
>>> commit 25175c806a6841149abe46168e0af12593141612
>>> Author: Thierry Reding <treding@nvidia.com>
>>> Date:   Thu Jul 25 18:19:00 2019 +0200
>>>
>>>     clk: tegra: Reimplement SOR clock on Tegra124
>>>     
>>>     In order to allow the display driver to deal uniformly with all SOR
>>>     generations, implement the SOR clocks in a way that is compatible with
>>>     Tegra186 and later.
>>>     
>>>     Acked-by: Stephen Boyd <sboyd@kernel.org>
>>>     Signed-off-by: Thierry Reding <treding@nvidia.com>
>>>
>>> diff --git a/drivers/clk/tegra/clk-tegra124.c b/drivers/clk/tegra/clk-tegra124.c
>>> index 7d231529c3a5..b3110d5b5a6c 100644
>>> --- a/drivers/clk/tegra/clk-tegra124.c
>>> +++ b/drivers/clk/tegra/clk-tegra124.c
>>> @@ -1005,20 +1005,24 @@ static struct tegra_devclk devclks[] __initdata = {
>>>  	{ .con_id = "hda2hdmi", .dt_id = TEGRA124_CLK_HDA2HDMI },
>>>  };
>>>  
>>> -static const char *mux_pllp_pllm_plld_plla_pllc_plld2_clkm[] = {
>>> -	"pll_p", "pll_m", "pll_d_out0", "pll_a_out0", "pll_c",
>>> -	"pll_d2_out0", "clk_m"
>>> +static const char * const sor0_parents[] = {
>>> +	"pll_p_out0", "pll_m_out0", "pll_d_out0", "pll_a_out0", "pll_c_out0",
>>> +	"pll_d2_out0", "clk_m",
>>>  };
>>
>> I'm not sure how it supposed to work because looks like some of these
>> "_out0" parent clocks just do not exists in the upstream clk driver.
>>
>> Either some other patch that adds "_out0" aliases is missed or this
>> patch was based on top of a different codebase (downstream kernel?).
> 
> The pll_d{,2}_out0 clocks are registered as fixed-factor clocks. The
> others I'm not exactly sure, but I think I ended up taking these
> directly from the register tables in the TRM (the clock mux fields).
> Looks like we ended up naming these differently in the kernel driver
> when it was merged initially.
> 
> The reason why this works is because the common clock framework will not
> flag these clocks as missing since they may appear at some later point
> (perhaps by some different provider).

Right.

> In this case it doesn't really matter because the only parents that are
> ever used or the clk_m, pll_d_out0 and pll_d2_out0.

Okay.

> It might be a good idea to clean some of this up at some point, though.

Indeed.

>> What's also a bit odd is that commit says Tegra186.. but AFAIK there is
>> no driver for Tegra186 clocks in upstream.
> 
> Clocks on Tegra186 are provided by the clk-bpmp driver. Basically those
> are mostly the same clocks but the implementation is provided by the
> BPMP and the clk-bpmp driver talks to it via an IPC mechanism.

I see how it works now, thanks for the clarification.

> So basically the bottom line here is that the SOR clocks were not
> correctly implemented on chips prior to Tegra186 which leads to obscure
> bugs with HDMI and DP outputs.

Thank you for the explanation.

>> BTW, seems T114 clk driver also uses a non-existent pll_m/p/c_out0 for
>> the emc_mux.
>>
>> Thierry / Peter, could you please explain what's going on with this
>> patch and why clocks are missed on T114? Maybe I'm missing something?
>>
>>> -#define mux_pllp_pllm_plld_plla_pllc_plld2_clkm_idx NULL
>>>  
>>> -static const char *mux_clkm_plldp_sor0out[] = {
>>> -	"clk_m", "pll_dp", "sor0_out",
>>> +static const char * const sor0_out_parents[] = {
>>> +	"clk_m", "sor0_pad_clkout",
>>>  };
>>> -#define mux_clkm_plldp_sor0out_idx NULL
>>>  
>>>  static struct tegra_periph_init_data tegra124_periph[] = {
>>> -	MUX8_NOGATE_LOCK("sor0_out", mux_pllp_pllm_plld_plla_pllc_plld2_clkm, CLK_SOURCE_SOR0, tegra_clk_sor0_out, &sor0_lock),
>>> -	NODIV("sor0", mux_clkm_plldp_sor0out, CLK_SOURCE_SOR0, 14, 3, 182, 0, tegra_clk_sor0, &sor0_lock),
>>> +	TEGRA_INIT_DATA_TABLE("sor0", NULL, NULL, sor0_parents,
>>> +			      CLK_SOURCE_SOR0, 29, 0x7, 0, 0, 0, 0,
>>> +			      0, 182, 0, tegra_clk_sor0, NULL, 0,
>>> +			      &sor0_lock),
>>> +	TEGRA_INIT_DATA_TABLE("sor0_out", NULL, NULL, sor0_out_parents,
>>> +			      CLK_SOURCE_SOR0, 14, 0x1, 0, 0, 0, 0,
>>> +			      0, 0, TEGRA_PERIPH_NO_GATE, tegra_clk_sor0_out,
>>> +			      NULL, 0, &sor0_lock),
>>>  };
>>>  
>>>  static struct clk **clks;
>>> -------------------------------------------------------------------------------
>>>
>>>
>>> Git bisection log:
>>>
>>> -------------------------------------------------------------------------------
>>> git bisect start
>>> # good: [dafbb1e6473788cb3068eaeddc58f9d88e9c7a62] Merge branch 'clk-ti' into clk-next
>>> git bisect good dafbb1e6473788cb3068eaeddc58f9d88e9c7a62
>>> # bad: [a228ae437aa553736058cbbd58d2d0e191635cdc] Merge branch 'clk-unused' into clk-next
>>> git bisect bad a228ae437aa553736058cbbd58d2d0e191635cdc
>>> # bad: [3214be6cb1e487b0f8c3bb2eac9b06df07a07e06] clk: tegra: Share clk and rst register defines with Tegra clock driver
>>> git bisect bad 3214be6cb1e487b0f8c3bb2eac9b06df07a07e06
>>> # bad: [05308d7e7bbc932025f1dafc401c73ce83c6f414] clk: tegra: Reimplement SOR clocks on Tegra210
>>> git bisect bad 05308d7e7bbc932025f1dafc401c73ce83c6f414
>>> # good: [d1ee3173a139ed2eb8d87e06216f0426b16084d8] Merge branch 'for-5.5/dt-bindings' into for-5.5/clk
>>> git bisect good d1ee3173a139ed2eb8d87e06216f0426b16084d8
>>> # good: [e5f8a107d92db30a7ad7d8d95aee59f5ad76206a] clk: tegra: Move SOR0 implementation to Tegra124
>>> git bisect good e5f8a107d92db30a7ad7d8d95aee59f5ad76206a
>>> # bad: [25175c806a6841149abe46168e0af12593141612] clk: tegra: Reimplement SOR clock on Tegra124
>>> git bisect bad 25175c806a6841149abe46168e0af12593141612
>>> # good: [da8d1a3555406275650b366460c6235f1696bf8b] clk: tegra: Rename sor0_lvds to sor0_out
>>> git bisect good da8d1a3555406275650b366460c6235f1696bf8b
>>> # first bad commit: [25175c806a6841149abe46168e0af12593141612] clk: tegra: Reimplement SOR clock on Tegra124
>>> -------------------------------------------------------------------------------
>>>
>>

