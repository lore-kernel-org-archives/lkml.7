Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C78DC31E5E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 15:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B3E421881
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 15:37:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qYFqwSmE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729501AbfFSPhx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 11:37:53 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34677 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbfFSPhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 11:37:53 -0400
Received: by mail-lj1-f193.google.com with SMTP id p17so1460762ljg.1;
        Wed, 19 Jun 2019 08:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UECGP8MRpgSe0wlNtHRfOu7ZqgyGcPgqV/DzV6XnpFo=;
        b=qYFqwSmEePJstG0vbqMJ4JoqScutHOoCbjhE5YTAD7VirMBeZrsOgiOiknbC45RACp
         uhaa5P7acDrmP6BoPmKJTh9HE0Ss3Q/dwSyWV3kbUJDaTS3U3+fFBYvny03fp10Nrj7b
         uW342H5xlzzw1vo1lmPDiHxN5K3sfSNz5P3sANwRe2Fbog9iUdiV0Y1kcybHWsBc4R9W
         F93/GtRaodGgivHk4bEjjWlkR09vrLCXTeXh5mllzouVKpx72VNDfKGWz5bvxweZdAbH
         4I4SF1vTr05YfKVaQM2X5YM4Eb78CgF3GDtfkeeCGU9IWmNWyGVAUbJj9SoJ8p0XDedk
         NGXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UECGP8MRpgSe0wlNtHRfOu7ZqgyGcPgqV/DzV6XnpFo=;
        b=f3RBoSQNPElgZC5N/dyUy86zakYu9XE7zo1wFw7RY41slDiuPUDZWr1D5qLrGs4jQ1
         3MXpp+nQ2uedTDljIC1mFX90HqdiKnkou2WxdtqJeN/I6tsflAkOTu5nCz906VeFR2iW
         PSsY0P1ISjMxrbc9MFL/JGEcXI3X/AWnHvE2s88KaCX/c5WUWnmlpo2m9VG8cOvtz7eX
         koqtTesf27PLCtbuEo6W2HfKIwBfGnud5dwfUNYySjBd43J+WdoTi19tmEORZH7zLwxe
         2IBsMw/AE7BSD4tvU2usZFYmYIVnYjDwjYzGS/PV9tgVZXLsCwvUCba0AIbLC74IFwVY
         KJZQ==
X-Gm-Message-State: APjAAAWb81iBiEYj2BlmUYsm+qz/MiAXxMYD/JKRjkphniGk712u4nft
        TkKaSGdPdNw5c63UpRJHacvS7zne
X-Google-Smtp-Source: APXvYqyCA3iPBLXFer4OyIlveZpO5AzBd+zr0S1yItMV+ojRLQGFJfKzdKRRIKG02eVH2oJ9NvUTUA==
X-Received: by 2002:a2e:8744:: with SMTP id q4mr2215235ljj.77.1560958670296;
        Wed, 19 Jun 2019 08:37:50 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.googlemail.com with ESMTPSA id 80sm2762445lfz.56.2019.06.19.08.37.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 08:37:49 -0700 (PDT)
Subject: Re: [PATCH v4 01/10] clk: tegra20/30: Add custom EMC clock
 implementation
To:     Stephen Boyd <sboyd@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joseph Lo <josephl@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190616233551.6838-1-digetx@gmail.com>
 <20190616233551.6838-2-digetx@gmail.com>
 <20190619011401.9DE5C2085A@mail.kernel.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <1b3a95c7-37e5-535a-ff8c-2d52596cef1b@gmail.com>
Date:   Wed, 19 Jun 2019 18:37:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190619011401.9DE5C2085A@mail.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

19.06.2019 4:14, Stephen Boyd пишет:
> Quoting Dmitry Osipenko (2019-06-16 16:35:42)
>> A proper External Memory Controller clock rounding and parent selection
>> functionality is required by the EMC drivers. It is not available using
>> the generic clock implementation, hence add a custom one. 
> 
> Why isn't it available? Please add this information to the commit text.

Ok! It's not available because only the EMC driver has information about available memory
timings and thus about the available rates (and parents consequently).

>> The clock rate
>> rounding shall be done by the EMC drivers because they have information
>> about available memory timings, so the drivers will have to register a
>> callback that will round the requested rate. EMC clock users won't be able
>> to request EMC clock by getting -EPROBE_DEFER until EMC driver is probed
>> and the callback is set up. The functionality is somewhat similar to the
>> clk-emc.c which serves Tegra124+ SoC's, the later HW generations support
>> more parent clock sources and the HW configuration and integration with
>> the EMC drivers differs a tad from the older gens, hence it's not really
>> worth to try to squash everything into a single source file.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> [...]
>> diff --git a/drivers/clk/tegra/clk-tegra20-emc.c b/drivers/clk/tegra/clk-tegra20-emc.c
>> new file mode 100644
>> index 000000000000..b7f64ad5c04c
>> --- /dev/null
>> +++ b/drivers/clk/tegra/clk-tegra20-emc.c
>> @@ -0,0 +1,305 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +#include <linux/bits.h>
>> +#include <linux/clk-provider.h>
>> +#include <linux/clk/tegra.h>
>> +#include <linux/err.h>
>> +#include <linux/io.h>
>> +#include <linux/kernel.h>
>> +#include <linux/slab.h>
>> +
>> +#include "clk.h"
>> +
>> +#define CLK_SOURCE_EMC_2X_CLK_DIVISOR_MASK     GENMASK(7, 0)
>> +#define CLK_SOURCE_EMC_2X_CLK_SRC_MASK         GENMASK(31, 30)
>> +#define CLK_SOURCE_EMC_2X_CLK_SRC_SHIFT                30
>> +
>> +#define MC_EMC_SAME_FREQ       BIT(16)
>> +#define USE_PLLM_UD            BIT(29)
>> +
>> +#define EMC_SRC_PLL_M          0
>> +#define EMC_SRC_PLL_C          1
>> +#define EMC_SRC_PLL_P          2
>> +#define EMC_SRC_CLK_M          3
>> +
> [...]
>> +void tegra20_clk_set_emc_round_callback(tegra20_clk_emc_round_cb *round_cb,
>> +                                       void *cb_arg)
>> +{
>> +       struct clk *clk = __clk_lookup("emc");
>> +       struct tegra_clk_emc *emc;
>> +       struct clk_hw *hw;
>> +
>> +       if (clk) {
>> +               hw = __clk_get_hw(clk);
>> +               emc = to_tegra_clk_emc(hw);
>> +
>> +               emc->round_cb = round_cb;
>> +               emc->cb_arg = cb_arg;
>> +       }
>> +}
>> +
>> +bool tegra20_clk_emc_driver_available(struct clk_hw *emc_hw)
>> +{
>> +       return to_tegra_clk_emc(emc_hw)->round_cb != NULL;
>> +}
>> +
>> +struct clk *tegra20_clk_register_emc(void __iomem *ioaddr)
> 
> Is this used outside this file?

Yes, it is. It is getting used even in this patch, you just snipped it off in the reply.

>> +{
>> +       struct tegra_clk_emc *emc;
>> +       struct clk_init_data init;
>> +       struct clk *clk;
>> +
>> +       emc = kzalloc(sizeof(*emc), GFP_KERNEL);
>> +       if (!emc)
>> +               return NULL;
>> +
>> +       init.name = "emc";
>> +       init.ops = &tegra_clk_emc_ops;
>> +       init.flags = CLK_IS_CRITICAL;
> 
> Can you please add a comment in the code why this clk is critical?

Okay!

>> +       init.parent_names = emc_parent_clk_names;
>> +       init.num_parents = ARRAY_SIZE(emc_parent_clk_names);
>> +
>> +       emc->reg = ioaddr;
>> +       emc->hw.init = &init;
>> +
>> +       clk = clk_register(NULL, &emc->hw);
>> +       if (IS_ERR(clk)) {
>> +               kfree(emc);
>> +               return NULL;
>> +       }
>> +
>> +       return clk;
>> +}
>> +
>> +void tegra30_clk_set_emc_round_callback(tegra30_clk_emc_round_cb *round_cb,
>> +                                       void *cb_arg)
>> +{
>> +       tegra20_clk_set_emc_round_callback(round_cb, cb_arg);
>> +}
>> +
>> +bool tegra30_clk_emc_driver_available(struct clk_hw *emc_hw)
>> +{
>> +       return tegra20_clk_emc_driver_available(emc_hw);
>> +}
>> +
>> +struct clk *tegra30_clk_register_emc(void __iomem *ioaddr)
>> +{
>> +       struct tegra_clk_emc *emc;
>> +       struct clk_hw *hw;
>> +       struct clk *clk;
>> +
>> +       clk = tegra20_clk_register_emc(ioaddr);
>> +       if (!clk)
>> +               return NULL;
>> +
>> +       hw = __clk_get_hw(clk);
> 
> It would be nicer to not use __clk_get_hw() and have the above function
> return the clk_hw pointer instead. Then some driver can return the clk
> pointer from there, if it's even needed for anything?

This is solely for internal use by the tegra-clk driver itself, this function isn't publicly
exposed. Again, you snipped off a lot in the reply, please take a look at the original patch.

Technically I could return clk_hw from here, but it doesn't make much sense in the context
of the tegra-clk driver. Please see how these functions are getting used in the original patch.

In short, tegra-clk driver operates with clk struct and not clk_hw. You already was asking
the same question in v3 and I replied that converting the whole driver for clk_hw will take
a lot of effort. I suppose it will be somewhat similar to what was done for the IMX driver
recently [1].

[1] https://lkml.org/lkml/2019/5/2/170

>> +       emc = to_tegra_clk_emc(hw);
>> +       emc->want_low_jitter = true;
>> +
>> +       return clk;
>> +}
>> +
>> +int tegra30_clk_prepare_emc_mc_same_freq(struct clk *emc_clk, bool same)
>> +{
>> +       struct tegra_clk_emc *emc;
>> +       struct clk_hw *hw;
>> +
>> +       if (emc_clk) {
>> +               hw = __clk_get_hw(emc_clk);
>> +               emc = to_tegra_clk_emc(hw);
>> +               emc->mc_same_freq = same;
>> +
>> +               return 0;
>> +       }
>> +
>> +       return -EINVAL;
>> +}
>> diff --git a/drivers/clk/tegra/clk-tegra20.c b/drivers/clk/tegra/clk-tegra20.c
>> index bcd871134f45..f937a0f35afb 100644
>> --- a/drivers/clk/tegra/clk-tegra20.c
>> +++ b/drivers/clk/tegra/clk-tegra20.c
>> @@ -1115,6 +1083,8 @@ static struct clk *tegra20_clk_src_onecell_get(struct of_phandle_args *clkspec,
>>         if (IS_ERR(clk))
>>                 return clk;
>>  
>> +       hw = __clk_get_hw(clk);
>> +
>>         /*
>>          * Tegra20 CDEV1 and CDEV2 clocks are a bit special case, their parent
>>          * clock is created by the pinctrl driver. It is possible for clk user
>> @@ -1124,13 +1094,16 @@ static struct clk *tegra20_clk_src_onecell_get(struct of_phandle_args *clkspec,
>>          */
>>         if (clkspec->args[0] == TEGRA20_CLK_CDEV1 ||
>>             clkspec->args[0] == TEGRA20_CLK_CDEV2) {
>> -               hw = __clk_get_hw(clk);
>> -
>>                 parent_hw = clk_hw_get_parent(hw);
>>                 if (!parent_hw)
>>                         return ERR_PTR(-EPROBE_DEFER);
>>         }
>>  
>> +       if (clkspec->args[0] == TEGRA20_CLK_EMC) {
>> +               if (!tegra20_clk_emc_driver_available(hw))
>> +                       return ERR_PTR(-EPROBE_DEFER);
>> +       }
>> +
>>         return clk;
>>  }
>>  
>> diff --git a/drivers/clk/tegra/clk-tegra30.c b/drivers/clk/tegra/clk-tegra30.c
>> index 7b4c6a488527..fab075808c20 100644
>> --- a/drivers/clk/tegra/clk-tegra30.c
>> +++ b/drivers/clk/tegra/clk-tegra30.c
>> @@ -1302,6 +1298,26 @@ static struct tegra_audio_clk_info tegra30_audio_plls[] = {
>>         { "pll_a", &pll_a_params, tegra_clk_pll_a, "pll_p_out1" },
>>  };
>>  
>> +static struct clk *tegra30_clk_src_onecell_get(struct of_phandle_args *clkspec,
>> +                                              void *data)
>> +{
>> +       struct clk_hw *hw;
>> +       struct clk *clk;
>> +
>> +       clk = of_clk_src_onecell_get(clkspec, data);
>> +       if (IS_ERR(clk))
>> +               return clk;
>> +
>> +       hw = __clk_get_hw(clk);
>> +
>> +       if (clkspec->args[0] == TEGRA30_CLK_EMC) {
>> +               if (!tegra30_clk_emc_driver_available(hw))
>> +                       return ERR_PTR(-EPROBE_DEFER);
>> +       }
>> +
>> +       return clk;
>> +}
> 
> This above function makes me uneasy because it looks like a clk_get() on
> top of a clk_get()? 

Yes, this way we're intercepting clk_get() within the driver, which is a very nice feature.
We're already doing that in the clk-tegra20.c, can't see any problems with that.
