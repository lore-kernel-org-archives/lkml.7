Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C16DFC3A5A7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 09:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2C5921881
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 09:54:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728638AbfICJyy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 05:54:54 -0400
Received: from mga07.intel.com ([134.134.136.100]:48656 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726631AbfICJyy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 05:54:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Sep 2019 02:54:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,462,1559545200"; 
   d="scan'208";a="211934702"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 03 Sep 2019 02:54:52 -0700
Received: from [10.226.38.83] (rtanwar-mobl.gar.corp.intel.com [10.226.38.83])
        by linux.intel.com (Postfix) with ESMTP id 59C1858043A;
        Tue,  3 Sep 2019 02:54:49 -0700 (PDT)
Subject: Re: [PATCH v1 1/2] clk: intel: Add CGU clock driver for a new SoC
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     andriy.shevchenko@intel.com, cheol.yong.kim@intel.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, mturquette@baylibre.com,
        qi-ming.wu@intel.com, rahul.tanwar@intel.com, robh+dt@kernel.org,
        robh@kernel.org, sboyd@kernel.org, yixin.zhu@linux.intel.com
References: <6a3c26bc6e25d883686287883528dbde30725922.1566975410.git.rahul.tanwar@linux.intel.com>
 <20190902222015.11360-1-martin.blumenstingl@googlemail.com>
From:   "Tanwar, Rahul" <rahul.tanwar@linux.intel.com>
Message-ID: <d9e96dab-96be-0c14-b7af-e1f2dc07ebd2@linux.intel.com>
Date:   Tue, 3 Sep 2019 17:54:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190902222015.11360-1-martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Martin,

On 3/9/2019 6:20 AM, Martin Blumenstingl wrote:
> Hello,
>
> I only noticed this patchset today and I don't have much time left.
> Here's my initial impressions without going through the code in detail.
> I'll continue my review in the next days (as time permits).
>
> As with all other Intel LGM patches: I don't have access to the
> datasheets, so it's possible that I don't understand <insert topic here>
> feel free to correct me in this case (I appreciate an explanation where
> I was wrong, so I can learn from it)
>
>
> [...]
> --- /dev/null
> +++ b/drivers/clk/intel/Kconfig
> @@ -0,0 +1,13 @@
> +# SPDX-License-Identifier: GPL-2.0
> +config INTEL_LGM_CGU_CLK
> +	depends on COMMON_CLK
> +	select MFD_SYSCON
> can you please explain the reason why you need to use syscon?
> also please see [0] for a comment from Rob on another LGM dt-binding
> regarding syscon


Actually, there is no need to use syscon for CGU in LGM. It got carried

over from older SoCs (Falcon Mountain) where CGU was a MFD device

because it included PHY registers as well. And PHY drivers were using

syscon node to access CGU regmap. But for LGM, this is not the case.

My understanding is that if we do not use syscon, then there is no

point in using regmap because this driver uses simple 32 bit register

access. Can directly read/write registers using readl() & writel().

Would you agree ?


Yi Xin, please correct me if you think i am mistaken anywhere. If not,

i will change the driver to not use regmap & instead use readl() &

writel().


> +	select OF_EARLY_FLATTREE
> there's not a single other "select OF_EARLY_FLATTREE" in driver/clk
> I'm not saying this is wrong but it makes me curious why you need this


We need OF_EARLY_FLATTREE for LGM. But adding a new x86

platform for LGM is discouraged because that would lead to too

many platforms. Only differentiating factor for LGM is CPU model

ID but it can differentiate only at run time. So i had no option

other then enabling it with some LGM specific core system module

driver and CGU seemed perfect for this purpose.


> [...]
> diff --git a/drivers/clk/intel/clk-cgu.h b/drivers/clk/intel/clk-cgu.h
> new file mode 100644
> index 000000000000..e44396b4aad7
> --- /dev/null
> +++ b/drivers/clk/intel/clk-cgu.h
> @@ -0,0 +1,278 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + *  Copyright(c) 2018 Intel Corporation.
> + *  Zhu YiXin <Yixin.zhu@intel.com>
> + */
> +
> +#ifndef __INTEL_CLK_H
> +#define __INTEL_CLK_H
> +
> +struct intel_clk_mux {
> +	struct clk_hw hw;
> +	struct device *dev;
> +	struct regmap *map;
> +	unsigned int reg;
> +	u8 shift;
> +	u8 width;
> +	unsigned long flags;
> +};
> +
> +struct intel_clk_divider {
> +	struct clk_hw hw;
> +	struct device *dev;
> +	struct regmap *map;
> +	unsigned int reg;
> +	u8 shift;
> +	u8 width;
> +	unsigned long flags;
> +	const struct clk_div_table *table;
> +};
> +
> +struct intel_clk_ddiv {
> +	struct clk_hw hw;
> +	struct device *dev;
> +	struct regmap *map;
> +	unsigned int reg;
> +	u8 shift0;
> +	u8 width0;
> +	u8 shift1;
> +	u8 width1;
> +	u8 shift2;
> +	u8 width2;
> +	unsigned int mult;
> +	unsigned int div;
> +	unsigned long flags;
> +};
> +
> +struct intel_clk_gate {
> +	struct clk_hw hw;
> +	struct device *dev;
> +	struct regmap *map;
> +	unsigned int reg;
> +	u8 shift;
> +	unsigned long flags;
> +};
> I know at least two existing regmap clock implementations:
> - drivers/clk/qcom/clk-regmap*
> - drivers/clk/meson/clk-regmap*
>
> it would be great if we could decide to re-use one of those for the
> "generic" clock types (mux, divider and gate).
> Stephen, do you have any preference here?
> personally I like the meson one, but I'm biased because I've used it
> a lot in the past and I haven't used the qcom one at all.


I went through meson & qcom regmap clock code. Agree, it can be

reused for mux, divider and gate. But as mentioned above, i am now

considering to move away from using regmap.

Regards,

Rahul

