Return-Path: <SRS0=Iet2=Z5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF530C2D0BE
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 16:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AE5324673
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 16:00:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="banbk1xN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbfLGQAJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Dec 2019 11:00:09 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34390 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbfLGQAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Dec 2019 11:00:09 -0500
Received: by mail-lf1-f66.google.com with SMTP id l18so7558614lfc.1;
        Sat, 07 Dec 2019 08:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pSsGyhYusNn14wX08kX5/yw/DF7mNGeSPkIRQpam7uQ=;
        b=banbk1xNMgoJqtduf9/tQnrZW6RfkzY2RZjMWOjvZxKRjhSdLd938FvZPUdLHO5sSq
         DBqr2QBpVNMi4vwNo9UP9wGoUlC1vIyPMqEMPcpC9xdGWy3pWjlemyD4C7eNU8gp0MS1
         iPoY4tLaRQ2W9217Ellr/M0KOFY5nB2iSBGBN2Q5h+tQ6ZVJCqK9xx3f+EiGRG06MIca
         l3FjObPGkiAKva8uQJhYZA7orHbXQo11oMxZQAe9efP3zSXvJ7ik54tx1pt3Dc/NFN6F
         lfmMGC29oLWVVygPc9141xT0EwilkyiJc+xYKKpnhtRr7pGUamgsmCgwG+zbsHBHDDsq
         iYrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pSsGyhYusNn14wX08kX5/yw/DF7mNGeSPkIRQpam7uQ=;
        b=qHV5yJxpxSPqCSMChAyQkMUeMWac4TPNpMdqPaLAhFzDDN0Ywr6HKU7oWl8SKhqblO
         /wu0bB6XjU8HyOMXNkuv/x4LUFRn7LrVIm3ulsKFEY4yx2vk5c6KeQbJLJ18mU6j8tG0
         a0Er1oLhcETgSSgMCAmxGwlwZgPX7xViGyLNM1rGLoYs8MZRCVt6VCzq+7KU6xiZao1u
         Tu5JC//07Q3HNQGTR3/S+v48zck3PJRFMnGvcJj7sO2qMCooyV64hLmCuYH8PkMDuD0b
         L2X9KdFRW3kG/yawoT8xdLldyzlIlvLrxuY2bBzyqt7jVQMpQNWCx/qRS/erIHCNQH+5
         kvww==
X-Gm-Message-State: APjAAAVjdwqBAxCDLZHPkK1MvGwtqyH00OCk3SpcfEqSvE+HRg4vz494
        Dm1oRHobViquuIs2VCGms4k=
X-Google-Smtp-Source: APXvYqwgRepgXYD+Wsz26E3mZp/qWEn6slPq81tn70PkFLJrEpU7//YodsoJauhAhVXPZX5wfQRVog==
X-Received: by 2002:a19:5007:: with SMTP id e7mr11211683lfb.153.1575734406686;
        Sat, 07 Dec 2019 08:00:06 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id z5sm8268779lji.32.2019.12.07.08.00.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Dec 2019 08:00:06 -0800 (PST)
Subject: Re: [PATCH v3 03/15] soc: tegra: Add Tegra PMC clock registrations
 into PMC driver
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        mperttunen@nvidia.com, gregkh@linuxfoundation.org,
        sboyd@kernel.org, tglx@linutronix.de, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     allison@lohutok.net, pdeschrijver@nvidia.com, pgaikwad@nvidia.com,
        mturquette@baylibre.com, horms+renesas@verge.net.au,
        Jisheng.Zhang@synaptics.com, krzk@kernel.org, arnd@arndb.de,
        spujar@nvidia.com, josephl@nvidia.com, vidyas@nvidia.com,
        daniel.lezcano@linaro.org, mmaddireddy@nvidia.com,
        markz@nvidia.com, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        alexios.zavras@intel.com, alsa-devel@alsa-project.org
References: <1575600535-26877-1-git-send-email-skomatineni@nvidia.com>
 <1575600535-26877-4-git-send-email-skomatineni@nvidia.com>
 <7cf4ff77-2f33-4ee5-0e09-5aa6aef3e8be@gmail.com>
 <ad3a6743-4b36-fa25-9cc7-72803038ecc5@gmail.com>
 <dc7a057a-0bed-0e6f-0987-edcfec47f867@gmail.com>
Message-ID: <288a1701-def6-d628-26bc-a305f817bdb1@gmail.com>
Date:   Sat, 7 Dec 2019 19:00:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <dc7a057a-0bed-0e6f-0987-edcfec47f867@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

07.12.2019 18:53, Dmitry Osipenko пишет:
> 07.12.2019 18:47, Dmitry Osipenko пишет:
>> 07.12.2019 17:28, Dmitry Osipenko пишет:
>>> 06.12.2019 05:48, Sowjanya Komatineni пишет:
>>>> Tegra210 and prior Tegra PMC has clk_out_1, clk_out_2, clk_out_3 with
>>>> mux and gate for each of these clocks.
>>>>
>>>> Currently these PMC clocks are registered by Tegra clock driver using
>>>> clk_register_mux and clk_register_gate by passing PMC base address
>>>> and register offsets and PMC programming for these clocks happens
>>>> through direct PMC access by the clock driver.
>>>>
>>>> With this, when PMC is in secure mode any direct PMC access from the
>>>> non-secure world does not go through and these clocks will not be
>>>> functional.
>>>>
>>>> This patch adds these clocks registration with PMC as a clock provider
>>>> for these clocks. clk_ops callback implementations for these clocks
>>>> uses tegra_pmc_readl and tegra_pmc_writel which supports PMC programming
>>>> in secure mode and non-secure mode.
>>>>
>>>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>>>> ---
>>
>> [snip]
>>
>>>> +
>>>> +static const struct clk_ops pmc_clk_gate_ops = {
>>>> +	.is_enabled = pmc_clk_is_enabled,
>>>> +	.enable = pmc_clk_enable,
>>>> +	.disable = pmc_clk_disable,
>>>> +};
>>>
>>> What's the benefit of separating GATE from the MUX?
>>>
>>> I think it could be a single clock.
>>
>> According to TRM:
>>
>> 1. GATE and MUX are separate entities.
>>
>> 2. GATE is the parent of MUX (see PMC's CLK_OUT paths diagram in TRM).
>>
>> 3. PMC doesn't gate EXTPERIPH clock but could "force-enable" it, correct?
> 
> 4. clk_m_div2/4 are internal PMC OSC dividers and thus these clocks
> should belong to PMC.

Also, it should be "osc" and not "clk_m".
