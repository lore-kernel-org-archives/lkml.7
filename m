Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09867C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCDB42082C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:24:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ueZi6C9B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732100AbfFMPYd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:24:33 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45044 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731713AbfFMMOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 08:14:37 -0400
Received: by mail-lf1-f65.google.com with SMTP id r15so14888791lfm.11;
        Thu, 13 Jun 2019 05:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Di51b04bROtCX/vuM0wVqtGuQS1eHeWTyN72NZcfLpI=;
        b=ueZi6C9BckqIlGM9iOCyBVB/ob1mEPQQTEbO4hF0ltPPZ+zczG4ZT8Ce/4iUWi7aKx
         BtE3HaG4HFWrGaO4fH14CVa+al4wdbPhiRf7YRoBiGmM/YA/RNrjdB2IbykgMjsxb4Ax
         fjltvV2mUrXX6WgmWs5LXa9phBp4LYUZFR+3R5B2cVFv1/8pxpVuRZ8f1p14SxkurgY1
         nE+WVZFVq3yZY3DExW5hM6SJZ76kjMmCmpMfgqvenYHe0v3UinsJj41aqxgxjqXv1SjR
         wkL922OC6EEQOmKLCX45W8CZOK8cmq3vpOVhKNMOHrBFY6akrOiAsqA3tsglyqQzpMc5
         E/RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Di51b04bROtCX/vuM0wVqtGuQS1eHeWTyN72NZcfLpI=;
        b=N3miRoCVDK0UbDUHmDQdWOR42ZtQNn6L+rK0Bcsl/j1w2P+O6PUkGzv/JAEZ/SR37B
         oZ84++pO8qy3nVNrPs+t2Sb7KOkpToMRSZoXskC+8SvamQiub+oF8EBQkK0dUlGdzyzT
         R2Dfhoe2XD6/VwXC+gwq/58juxwPNOrf9nQXrfFsSqnFRZTu7krm/R7Y/6J0qoJfrbDP
         6VYJLn58da6q73ohOmiSl+2j8v2wIorhocGHDip1Z+33LQIfaT4D5xvdfUUzyN6dbLWf
         q40zX7hFm8f1Z/7zvJ8e5BM+hk6578LlJaIlRI5q4GCV64o/tvTECyBvgoX5V/fZc4kg
         fSgg==
X-Gm-Message-State: APjAAAXOyK8A7DfJiMebh36cM5giq2gZg53mULVufwOJDmOU3iWD/CM8
        XaIFaBxJxGTTiaFVe+JXCjDkZTHC
X-Google-Smtp-Source: APXvYqzUTRSIUmi6E6J8xTlzxDOIGnHtfLC3lcEsJusM8CQrI3hBqsHFcNFaS71aOXiZXgh2DQVf5w==
X-Received: by 2002:ac2:499b:: with SMTP id f27mr19467015lfl.88.1560428073517;
        Thu, 13 Jun 2019 05:14:33 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.googlemail.com with ESMTPSA id i5sm566913lfo.55.2019.06.13.05.14.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 05:14:32 -0700 (PDT)
Subject: Re: [PATCH v3 1/8] clk: tegra20/30: Add custom EMC clock
 implementation
To:     Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Joseph Lo <josephl@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190524172353.29087-1-digetx@gmail.com>
 <20190524172353.29087-2-digetx@gmail.com>
 <20190613104945.GJ29894@pdeschrijver-desktop.Nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <9c4af080-89d1-84a3-d909-b5595b8a6959@gmail.com>
Date:   Thu, 13 Jun 2019 15:14:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190613104945.GJ29894@pdeschrijver-desktop.Nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

13.06.2019 13:49, Peter De Schrijver пишет:
> On Fri, May 24, 2019 at 08:23:46PM +0300, Dmitry Osipenko wrote:
>> A proper External Memory Controller clock rounding and parent selection
>> functionality is required by the EMC drivers. It is not available using
>> the generic clock implementation, hence add a custom one. The clock rate
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
>> ---
>>  drivers/clk/tegra/Makefile          |   2 +
>>  drivers/clk/tegra/clk-tegra20-emc.c | 299 ++++++++++++++++++++++++++++
>>  drivers/clk/tegra/clk-tegra20.c     |  55 ++---
>>  drivers/clk/tegra/clk-tegra30.c     |  38 +++-
>>  drivers/clk/tegra/clk.h             |   6 +
>>  include/linux/clk/tegra.h           |  14 ++
>>  6 files changed, 362 insertions(+), 52 deletions(-)
>>  create mode 100644 drivers/clk/tegra/clk-tegra20-emc.c
>>
>> diff --git a/drivers/clk/tegra/Makefile b/drivers/clk/tegra/Makefile
>> index 4812e45c2214..df966ca06788 100644
>> --- a/drivers/clk/tegra/Makefile
>> +++ b/drivers/clk/tegra/Makefile
>> @@ -17,7 +17,9 @@ obj-y					+= clk-tegra-fixed.o
>>  obj-y					+= clk-tegra-super-gen4.o
>>  obj-$(CONFIG_TEGRA_CLK_EMC)		+= clk-emc.o
>>  obj-$(CONFIG_ARCH_TEGRA_2x_SOC)         += clk-tegra20.o
>> +obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= clk-tegra20-emc.o
>>  obj-$(CONFIG_ARCH_TEGRA_3x_SOC)         += clk-tegra30.o
>> +obj-$(CONFIG_ARCH_TEGRA_3x_SOC)		+= clk-tegra20-emc.o
>>  obj-$(CONFIG_ARCH_TEGRA_114_SOC)	+= clk-tegra114.o
>>  obj-$(CONFIG_ARCH_TEGRA_124_SOC)	+= clk-tegra124.o
>>  obj-$(CONFIG_TEGRA_CLK_DFLL)		+= clk-tegra124-dfll-fcpu.o
>> diff --git a/drivers/clk/tegra/clk-tegra20-emc.c b/drivers/clk/tegra/clk-tegra20-emc.c
>> new file mode 100644
>> index 000000000000..d971b5425ce3
>> --- /dev/null
>> +++ b/drivers/clk/tegra/clk-tegra20-emc.c
>> @@ -0,0 +1,299 @@
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
>> +#define CLK_SOURCE_EMC_2X_CLK_DIVISOR_MASK	GENMASK(7, 0)
>> +#define CLK_SOURCE_EMC_2X_CLK_SRC_MASK		GENMASK(31, 30)
>> +#define CLK_SOURCE_EMC_2X_CLK_SRC_SHIFT		30
>> +
>> +#define MC_EMC_SAME_FREQ	BIT(16)
>> +#define USE_PLLM_UD		BIT(29)
>> +
>> +#define EMC_SRC_PLL_M		0
>> +#define EMC_SRC_PLL_C		1
>> +#define EMC_SRC_PLL_P		2
>> +#define EMC_SRC_CLK_M		3
>> +
>> +static const char * const emc_parent_clk_names[] = {
>> +	"pll_m", "pll_c", "pll_p", "clk_m",
>> +};
>> +
>> +struct tegra_clk_emc {
>> +	struct clk_hw hw;
>> +	void __iomem *reg;
>> +	bool mc_same_freq;
>> +	bool want_low_jitter;
>> +
>> +	tegra20_clk_emc_round_cb *round_cb;
>> +	void *cb_arg;
>> +};
>> +
>> +static inline struct tegra_clk_emc *to_tegra_clk_emc(struct clk_hw *hw)
>> +{
>> +	return container_of(hw, struct tegra_clk_emc, hw);
>> +}
>> +
>> +static unsigned long emc_recalc_rate(struct clk_hw *hw,
>> +				     unsigned long parent_rate)
>> +{
>> +	struct tegra_clk_emc *emc = to_tegra_clk_emc(hw);
>> +	u32 val, div;
>> +
>> +	val = readl_relaxed(emc->reg);
>> +	div = val & CLK_SOURCE_EMC_2X_CLK_DIVISOR_MASK;
>> +
>> +	return DIV_ROUND_UP(parent_rate * 2, div + 2);
>> +}
>> +
>> +static u8 emc_get_parent(struct clk_hw *hw)
>> +{
>> +	struct tegra_clk_emc *emc = to_tegra_clk_emc(hw);
>> +
>> +	return readl_relaxed(emc->reg) >> CLK_SOURCE_EMC_2X_CLK_SRC_SHIFT;
>> +}
>> +
>> +static int emc_set_parent(struct clk_hw *hw, u8 index)
>> +{
>> +	struct tegra_clk_emc *emc = to_tegra_clk_emc(hw);
>> +	u32 val, div;
>> +
>> +	val = readl_relaxed(emc->reg);
>> +	val &= ~CLK_SOURCE_EMC_2X_CLK_SRC_MASK;
>> +	val |= index << CLK_SOURCE_EMC_2X_CLK_SRC_SHIFT;
>> +
>> +	div = val & CLK_SOURCE_EMC_2X_CLK_DIVISOR_MASK;
>> +
>> +	if (index == EMC_SRC_PLL_M && div == 0 && emc->want_low_jitter)
>> +		val |= USE_PLLM_UD;
>> +	else
>> +		val &= ~USE_PLLM_UD;
>> +
>> +	if (emc->mc_same_freq)
>> +		val |= MC_EMC_SAME_FREQ;
>> +	else
>> +		val &= ~MC_EMC_SAME_FREQ;
>> +
>> +	writel_relaxed(val, emc->reg);
>> +
> 
> I think technically you need a fence_udelay(1) here, but in practice
> this is probably not needed because you will poll some EMC register for
> the frequency completion anyway. Maybe add a comment about this?
> 
>> +	return 0;
>> +}
>> +
>> +static int emc_set_rate(struct clk_hw *hw, unsigned long rate,
>> +			unsigned long parent_rate)
>> +{
>> +	struct tegra_clk_emc *emc = to_tegra_clk_emc(hw);
>> +	unsigned int index;
>> +	u32 val, div;
>> +
>> +	div = div_frac_get(rate, parent_rate, 8, 1, 0);
>> +
>> +	val = readl_relaxed(emc->reg);
>> +	val &= ~CLK_SOURCE_EMC_2X_CLK_DIVISOR_MASK;
>> +	val |= div;
>> +
>> +	index = val >> CLK_SOURCE_EMC_2X_CLK_SRC_SHIFT;
>> +
>> +	if (index == EMC_SRC_PLL_M && div == 0 && emc->want_low_jitter)
>> +		val |= USE_PLLM_UD;
>> +	else
>> +		val &= ~USE_PLLM_UD;
>> +
>> +	if (emc->mc_same_freq)
>> +		val |= MC_EMC_SAME_FREQ;
>> +	else
>> +		val &= ~MC_EMC_SAME_FREQ;
>> +
>> +	writel_relaxed(val, emc->reg);
>> +
> 
> Same here.
> 
>> +	return 0;
>> +}
>> +
>> +static int emc_set_rate_and_parent(struct clk_hw *hw,
>> +				   unsigned long rate,
>> +				   unsigned long parent_rate,
>> +				   u8 index)
>> +{
>> +	struct tegra_clk_emc *emc = to_tegra_clk_emc(hw);
>> +	u32 val, div;
>> +
>> +	div = div_frac_get(rate, parent_rate, 8, 1, 0);
>> +
>> +	val = readl_relaxed(emc->reg);
>> +
>> +	val &= ~CLK_SOURCE_EMC_2X_CLK_SRC_MASK;
>> +	val |= index << CLK_SOURCE_EMC_2X_CLK_SRC_SHIFT;
>> +
>> +	val &= ~CLK_SOURCE_EMC_2X_CLK_DIVISOR_MASK;
>> +	val |= div;
>> +
>> +	if (index == EMC_SRC_PLL_M && div == 0 && emc->want_low_jitter)
>> +		val |= USE_PLLM_UD;
>> +	else
>> +		val &= ~USE_PLLM_UD;
>> +
>> +	if (emc->mc_same_freq)
>> +		val |= MC_EMC_SAME_FREQ;
>> +	else
>> +		val &= ~MC_EMC_SAME_FREQ;
>> +
>> +	writel_relaxed(val, emc->reg);
>> +
> 
> And here.
> 
>> +	return 0;
>> +}
> 
> Peter.
> 

Thank you very much for the feedback! Indeed, it will be a bit more
robust to add fence_udelay() since one microsecond is practically
nothing and then it will be a part of the clk-change awaiting anyway
(note that EMC driver waits for the interrupt event and doesn't poll the
status), we also don't really care about the EMC rate-change performance
much because it won't happen frequently.
