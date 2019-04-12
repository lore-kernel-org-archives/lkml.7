Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68AC3C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 10:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 364D120674
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 10:09:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YiSkVyD2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfDLKJS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 06:09:18 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46482 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbfDLKJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 06:09:17 -0400
Received: by mail-lj1-f194.google.com with SMTP id h21so8285025ljk.13;
        Fri, 12 Apr 2019 03:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=os5pqjAq5k1cEB6VJ+KHy6sQDqZjQToNqpqqo+gWQxA=;
        b=YiSkVyD2cdhvlGyZhZjOxoWi78CTHepnh5/iYE0KJbz4f23Bj1UtjD2QFlsvesRl1V
         tLdKYLSKAcBQgWjoT9tHdAtNACNZYcJ3Ze2m47Von3O52mB1NU5N6WIoU+c+fAOfGyen
         dCygtAEbHj042lXKOK3fflVOvw7Wb3toaBX3nJ7OBT7GgiLt/cTs1an0xAwzENz1F/gX
         xQwBb/aWUrJoRT9Tp1ZOv8Rgdp3LhAqdseWU+AtdY4PmcspoT3YmaYUtb/JvYVk/3vpJ
         WTTvUrAJ4rAQa83Z2SMooKBM2fA8CyYLBuOJFU96JeOjCeiNzTSPgik/1U+//lrYEKyA
         GLLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=os5pqjAq5k1cEB6VJ+KHy6sQDqZjQToNqpqqo+gWQxA=;
        b=nk15t6MFV9jqcMXRkDRbtIJJyUQiXNGEbzIfR6BSrVrHsaYYJ84JfMNOqnWls+KzQA
         Q1QNrtnumpNPvOJuhCg6zB9tYnwT/LKWDGw4yw1vERRdO9eumawY+5jrp5lEhwl1nqr7
         DyZBFQpR4uWRTWHSxiWWHv5y/1jDXKktGnhJNxRRzrFX0fRqREGOyUy7c+chH00HsRRz
         x7CjpCBpy+OeuZqnqjUaUxOxD8y8s6INdyUbArdc1ReNco4yC6JruZYKwqPtcIdjP6zh
         vI0VehEkIUxPX2df+yzRD+MXEIxl8YoLwtOg3tvMBh8rIepyifZSjvppiBjlsfH/wiC1
         SpiQ==
X-Gm-Message-State: APjAAAU09QZWtWwaR+yBb/BaN3j7xfpT6cK+joiRS5NPepNWL0pjEbtc
        k8gCION8AcYA6gscOqLUib8TpnXi
X-Google-Smtp-Source: APXvYqwdwSY00bViyBUG5fj3oDR2Ns6SdkKbzTtJQCGpLef0qoBjAkk/8sGr3DWlJTwy3h4g+8E6oA==
X-Received: by 2002:a2e:844a:: with SMTP id u10mr12995672ljh.41.1555063754872;
        Fri, 12 Apr 2019 03:09:14 -0700 (PDT)
Received: from [192.168.2.145] (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.googlemail.com with ESMTPSA id u19sm8073783lfg.74.2019.04.12.03.09.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 03:09:13 -0700 (PDT)
Subject: Re: [PATCH v1] clk: tegra20/30: Add custom EMC clock implementation
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
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <683b978a-8c7c-0593-755b-90975907e7ff@gmail.com>
Date:   Fri, 12 Apr 2019 13:09:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190412074658.GF12975@pdeschrijver-desktop.Nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

12.04.2019 10:46, Peter De Schrijver пишет:
> On Fri, Apr 12, 2019 at 01:47:08AM +0300, Dmitry Osipenko wrote:
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
> ..
> 
>> +	val = readl_relaxed(emc->ioaddr);
>> +	val &= ~CLK_SOURCE_EMC_2X_CLK_DIVISOR_MASK;
>> +	val |= div;
>> +
>> +	parent = val >> CLK_SOURCE_EMC_2X_CLK_SRC_SHIFT;
>> +
>> +	if (parent == EMC_SRC_PLL_M && div == 0 && emc->want_low_jitter)
>> +		val |= USE_PLLM_UD;
>> +	else
>> +		val &= ~USE_PLLM_UD;
>> +
> 
> Note that low jitter means the divider is bypassed, so you can only use
> this when div == 1.
> 
>> +	writel_relaxed(val, emc->ioaddr);
>> +
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
>> +	val = readl_relaxed(emc->ioaddr);
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
> 
> Same here ofcourse.

Please note that hw_div = div + 1.0, hence writing div=0 means that HW divider is disabled and thus can be bypassed to get a low jitter clock. Also please note that div_frac_get() returns the "hw_div" value. Tegra30 doesn't work well if low jitter isn't enabled for the high clock rate (hangs after couple seconds) and Tegra20 is the opposite. Everything should be fine and it is working well, I don't see any problem.
