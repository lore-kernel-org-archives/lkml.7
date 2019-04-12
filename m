Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54CD2C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 07:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 222742064A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 07:47:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="qRch6MLy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbfDLHrC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 03:47:02 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:12819 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726682AbfDLHrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 03:47:01 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cb042790000>; Fri, 12 Apr 2019 00:47:05 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 12 Apr 2019 00:47:00 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 12 Apr 2019 00:47:00 -0700
Received: from tbergstrom-lnx.Nvidia.com (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 12 Apr
 2019 07:47:00 +0000
Received: by tbergstrom-lnx.Nvidia.com (Postfix, from userid 1000)
        id 2BBC941B97; Fri, 12 Apr 2019 10:46:58 +0300 (EEST)
Date:   Fri, 12 Apr 2019 10:46:58 +0300
From:   Peter De Schrijver <pdeschrijver@nvidia.com>
To:     Dmitry Osipenko <digetx@gmail.com>
CC:     Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joseph Lo <josephl@nvidia.com>, <linux-clk@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] clk: tegra20/30: Add custom EMC clock implementation
Message-ID: <20190412074658.GF12975@pdeschrijver-desktop.Nvidia.com>
References: <20190411224708.29103-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190411224708.29103-1-digetx@gmail.com>
X-NVConfidentiality: public
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL101.nvidia.com (172.20.187.10)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1555055225; bh=wai0/O1OOC7HFu1FkJi782os2EEBhi6VCUNQkuqnmZc=;
        h=X-PGP-Universal:Date:From:To:CC:Subject:Message-ID:References:
         MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
         X-NVConfidentiality:User-Agent:X-Originating-IP:X-ClientProxiedBy;
        b=qRch6MLywuGK7J60SBrUvFBH9ldjXIGyJh86NHq/N4f006mVDE0GQZuf5E5OoXXgD
         ZxhiEWyHIVfxNj36hXQLwR/AWWLx05JT1+F9ND5GVpTPdSOuKOCOrbeuox7K6Oh4WX
         CSOd+W2hsmKm2IEW6FSUeMwQKAj5oez5Rp7b1x19FccZ03LEy2Nl0qDk5chfobedLn
         xl3gR5KTdIHO8bA9rHhPo/vJttrCjrW25Nn564DR+2NO+iLGohX33hh9R4x263zUFo
         xIVbK8bNfofNMpQs2n0TzQ9Sd8/lCDN9LSE1j49+VyZ2ehRTTtZlI+5sIVzDW9oqow
         klNNUB9E4snng==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2019 at 01:47:08AM +0300, Dmitry Osipenko wrote:
> A proper External Memory Controller clock rounding and parent selection
> functionality is required by the EMC drivers. It is not available using
> the generic clock implementation, hence add a custom one. The clock rate
> rounding shall be done by the EMC drivers because they have information
> about available memory timings, so the drivers will have to register a
> callback that will round the requested rate. EMC clock users won't be able
> to request EMC clock by getting -EPROBE_DEFER until EMC driver is probed
> and the callback is set up. The functionality is somewhat similar to the
> clk-emc.c which serves Tegra124+ SoC's, the later HW generations support
> more parent clock sources and the HW configuration and integration with
> the EMC drivers differs a tad from the older gens, hence it's not really
> worth to try to squash everything into a single source file.
> 
..

> +	val = readl_relaxed(emc->ioaddr);
> +	val &= ~CLK_SOURCE_EMC_2X_CLK_DIVISOR_MASK;
> +	val |= div;
> +
> +	parent = val >> CLK_SOURCE_EMC_2X_CLK_SRC_SHIFT;
> +
> +	if (parent == EMC_SRC_PLL_M && div == 0 && emc->want_low_jitter)
> +		val |= USE_PLLM_UD;
> +	else
> +		val &= ~USE_PLLM_UD;
> +

Note that low jitter means the divider is bypassed, so you can only use
this when div == 1.

> +	writel_relaxed(val, emc->ioaddr);
> +
> +	return 0;
> +}
> +
> +static int emc_set_rate_and_parent(struct clk_hw *hw,
> +				   unsigned long rate,
> +				   unsigned long parent_rate,
> +				   u8 index)
> +{
> +	struct tegra_clk_emc *emc = to_tegra_clk_emc(hw);
> +	u32 val, div;
> +
> +	div = div_frac_get(rate, parent_rate, 8, 1, 0);
> +
> +	val = readl_relaxed(emc->ioaddr);
> +
> +	val &= ~CLK_SOURCE_EMC_2X_CLK_SRC_MASK;
> +	val |= index << CLK_SOURCE_EMC_2X_CLK_SRC_SHIFT;
> +
> +	val &= ~CLK_SOURCE_EMC_2X_CLK_DIVISOR_MASK;
> +	val |= div;
> +
> +	if (index == EMC_SRC_PLL_M && div == 0 && emc->want_low_jitter)
> +		val |= USE_PLLM_UD;
> +	else
> +		val &= ~USE_PLLM_UD;
> +

Same here ofcourse.

Peter.
