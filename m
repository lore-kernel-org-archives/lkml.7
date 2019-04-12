Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63612C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 10:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2741621872
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 10:25:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ngUWlkCG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbfDLKZU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 06:25:20 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36331 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbfDLKZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 06:25:20 -0400
Received: by mail-lj1-f194.google.com with SMTP id r24so8399008ljg.3;
        Fri, 12 Apr 2019 03:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6G+l4HRtDXC8V+QnF5etvnMD5+Lz33fnqLoRq9LgE18=;
        b=ngUWlkCG9ZufOrdS/RM0jm3/FLnDxUYR2E7++4jX6/jmiYnakdXWC1B3MUW7IWjINc
         QjpWu6aZW8yvz8ZK32+CKTn20o/qO+k1w623C4ECQqsDcE0UshGC1NIpTWCvkx73Vb/N
         dNo8yxrVYoyCHkTSrHVK0jiuyIKRcFPiwXdPHjHfYsiEuYFwgrgfv1izWu0vhMqaQDUx
         vvGe6nYs4JGFZRv3SZGPL9RwOJxRWzXKvROF6F6D/Sq1PJSfUqKkkgrxOIAICrdsi2DE
         xd5hsqp78R9C+l4LfmKT2+q2whutEfXJJyYLrlJrO/nmSn4wwMtlV122lQddFuw6VW/u
         Y6eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6G+l4HRtDXC8V+QnF5etvnMD5+Lz33fnqLoRq9LgE18=;
        b=OtyoamlxCZgQka/PDHusEhGkStnACKOlMIp5wFQAZvYbqC8iX7qlxMt8Dp4XWffran
         czD1sPh5IaIS5B+ltbU2eYXeCV8Bch8rep7j/XNhVPI3QKspXwUV6SYdLlzBH00Hng4h
         afxTwq+qRkCsQa58YA6VBSdd/KczzMqi59A2qay5lf+nj4OVVbT5K4M71GEf7GknH34j
         z3gH3M0SXvBfbCOn3jfBq2pNYADKvPIkhfEdCC9/8c7cLMkG3flz1jYKFAEvfRrGBcH7
         vAa5bfRleYAZvMgiOPWFTcOJToHkKlglA5If5yqVh4qGPBUhqp+QJmkaxsvbdP39+iug
         KGJg==
X-Gm-Message-State: APjAAAVuZHhDh/pblYYjf+e1EkEuxj5A5ThkWU6tY9b/8AQv9EoYAgJ8
        7/xvvLjsq7nwIFil8YACRr1GVYRX
X-Google-Smtp-Source: APXvYqx3+hgcdeOQu0NdacrX7uv/ifXVn5TxgFOKPp8HO2wEhi8oMp08eUGDB7OBOK08B4zcw+wCAQ==
X-Received: by 2002:a2e:42cf:: with SMTP id h76mr28859782ljf.95.1555064717379;
        Fri, 12 Apr 2019 03:25:17 -0700 (PDT)
Received: from [192.168.2.145] (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.googlemail.com with ESMTPSA id p18sm7738637ljp.1.2019.04.12.03.25.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 03:25:16 -0700 (PDT)
Subject: Re: [PATCH v1] clk: tegra20/30: Add custom EMC clock implementation
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joseph Lo <josephl@nvidia.com>, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190411224708.29103-1-digetx@gmail.com>
 <20190412074658.GF12975@pdeschrijver-desktop.Nvidia.com>
 <683b978a-8c7c-0593-755b-90975907e7ff@gmail.com>
Message-ID: <783553d2-15d0-5c59-3fef-59e2a8aba4ed@gmail.com>
Date:   Fri, 12 Apr 2019 13:25:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <683b978a-8c7c-0593-755b-90975907e7ff@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

12.04.2019 13:09, Dmitry Osipenko пишет:
> 12.04.2019 10:46, Peter De Schrijver пишет:
>> On Fri, Apr 12, 2019 at 01:47:08AM +0300, Dmitry Osipenko wrote:
>>> A proper External Memory Controller clock rounding and parent selection
>>> functionality is required by the EMC drivers. It is not available using
>>> the generic clock implementation, hence add a custom one. The clock rate
>>> rounding shall be done by the EMC drivers because they have information
>>> about available memory timings, so the drivers will have to register a
>>> callback that will round the requested rate. EMC clock users won't be able
>>> to request EMC clock by getting -EPROBE_DEFER until EMC driver is probed
>>> and the callback is set up. The functionality is somewhat similar to the
>>> clk-emc.c which serves Tegra124+ SoC's, the later HW generations support
>>> more parent clock sources and the HW configuration and integration with
>>> the EMC drivers differs a tad from the older gens, hence it's not really
>>> worth to try to squash everything into a single source file.
>>>
>> ..
>>
>>> +	val = readl_relaxed(emc->ioaddr);
>>> +	val &= ~CLK_SOURCE_EMC_2X_CLK_DIVISOR_MASK;
>>> +	val |= div;
>>> +
>>> +	parent = val >> CLK_SOURCE_EMC_2X_CLK_SRC_SHIFT;
>>> +
>>> +	if (parent == EMC_SRC_PLL_M && div == 0 && emc->want_low_jitter)
>>> +		val |= USE_PLLM_UD;
>>> +	else
>>> +		val &= ~USE_PLLM_UD;
>>> +
>>
>> Note that low jitter means the divider is bypassed, so you can only use
>> this when div == 1.
>>
>>> +	writel_relaxed(val, emc->ioaddr);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int emc_set_rate_and_parent(struct clk_hw *hw,
>>> +				   unsigned long rate,
>>> +				   unsigned long parent_rate,
>>> +				   u8 index)
>>> +{
>>> +	struct tegra_clk_emc *emc = to_tegra_clk_emc(hw);
>>> +	u32 val, div;
>>> +
>>> +	div = div_frac_get(rate, parent_rate, 8, 1, 0);
>>> +
>>> +	val = readl_relaxed(emc->ioaddr);
>>> +
>>> +	val &= ~CLK_SOURCE_EMC_2X_CLK_SRC_MASK;
>>> +	val |= index << CLK_SOURCE_EMC_2X_CLK_SRC_SHIFT;
>>> +
>>> +	val &= ~CLK_SOURCE_EMC_2X_CLK_DIVISOR_MASK;
>>> +	val |= div;
>>> +
>>> +	if (index == EMC_SRC_PLL_M && div == 0 && emc->want_low_jitter)
>>> +		val |= USE_PLLM_UD;
>>> +	else
>>> +		val &= ~USE_PLLM_UD;
>>> +
>>
>> Same here ofcourse.
> 
> Please note that hw_div = div + 1.0, hence writing div=0 means that HW divider is disabled and thus can be bypassed to get a low jitter clock. Also please note that div_frac_get() returns the "hw_div" value. Tegra30 doesn't work well if low jitter isn't enabled for the high clock rate (hangs after couple seconds) and Tegra20 is the opposite. Everything should be fine and it is working well, I don't see any problem.
> 

Oh, div_frac_get() returns the "div" value of course.
