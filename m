Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF81C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 20:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB88D21556
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 20:12:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oyNHS4Vl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbfLIUMp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 15:12:45 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42632 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbfLIUMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 15:12:40 -0500
Received: by mail-lj1-f196.google.com with SMTP id e28so17114331ljo.9;
        Mon, 09 Dec 2019 12:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=toXARQVeazduKdMBcjZ4AH+zKbnIDWRz3fBlo89SsY8=;
        b=oyNHS4VlNQIeO8uN4MTz5mnnSbKmtqbZwyZ5dC7UpkgqBEwuGlmOIN0+RPkkDpEMOa
         vCZXz7sr6AVN0zyHTNBcclHbuWsYc+4eO5xAzAjB7nTQhnuaqs6H0E95/9FyprYS6Nxh
         3OghsnDtsPF72u6J9DOE11wxG0welgCE3mwMUMQ92BAWyHTsOzblUWF+kON4av1oX12Q
         hOMQyJbCrvt01M4XYMXodNBql795RbFgyYevszJWpwRaNVe4cqSgfpvlCPZUekti4onD
         K/cYJA/cZnHYMIxm7WENW7bOSBDY956QC5jk6f0MHTqVhPl5cJAAmU+rKjlIUgVhgB76
         HMSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=toXARQVeazduKdMBcjZ4AH+zKbnIDWRz3fBlo89SsY8=;
        b=ZXu/BU3rQ3FnotN/tqn0Piz0ErURHYpckMbqYb0BF8rpyQ5PyPrJklmRdCKr0bJBXN
         vJGZlruNCAuz+99Swv8Cv7HCKe+YDbAfa3OD7Awfosgf2ndxSPNRdapBWtH9CdwSwfoE
         jH9fYH235lm0n1raQ57CHwSFhSaV9ic3i1DljsV7loW2Px1t730eNXw5U0SmbCS1c02Y
         up05PH0xady7l77E2lOeqX5Z8EmukEuC99v88tPsHhioGNdTDqOsotNXzuxo4jqTgoQ6
         1NaT0khAuNFXnvtadZWr2I7Yoxztm3qTh/WhwiSUVisoE9jvP4a37FN76OTJfFExj7dN
         b6Gw==
X-Gm-Message-State: APjAAAVeO0IL2zOLTfOg0BgMzQ0FpxJyDrJnJO9yzxpZcfoZS1pOqyAj
        A8uEoLBiuCZysGSKgvCde/U=
X-Google-Smtp-Source: APXvYqzFJzecx4/IUoPCD798bOm5o7OiSgWA4hOkXHCqKz5R/DTqwq7ycwmvKJ9TE7el6GO2a/JYvA==
X-Received: by 2002:a2e:9741:: with SMTP id f1mr17084867ljj.123.1575922357865;
        Mon, 09 Dec 2019 12:12:37 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id k25sm453452lji.42.2019.12.09.12.12.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2019 12:12:36 -0800 (PST)
Subject: Re: [PATCH v3 03/15] soc: tegra: Add Tegra PMC clock registrations
 into PMC driver
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
 <288a1701-def6-d628-26bc-a305f817bdb1@gmail.com>
 <78644d45-2ae3-121f-99fc-0a46f205907d@nvidia.com>
 <b35916e1-c6ee-52ca-9111-5ae109437b6e@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <ccb715cc-c927-ea91-a26e-24d6eeeeef1a@gmail.com>
Date:   Mon, 9 Dec 2019 23:12:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <b35916e1-c6ee-52ca-9111-5ae109437b6e@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

08.12.2019 00:36, Sowjanya Komatineni пишет:
> 
> On 12/7/19 11:59 AM, Sowjanya Komatineni wrote:
>>
>> On 12/7/19 8:00 AM, Dmitry Osipenko wrote:
>>> 07.12.2019 18:53, Dmitry Osipenko пишет:
>>>> 07.12.2019 18:47, Dmitry Osipenko пишет:
>>>>> 07.12.2019 17:28, Dmitry Osipenko пишет:
>>>>>> 06.12.2019 05:48, Sowjanya Komatineni пишет:
>>>>>>> Tegra210 and prior Tegra PMC has clk_out_1, clk_out_2, clk_out_3
>>>>>>> with
>>>>>>> mux and gate for each of these clocks.
>>>>>>>
>>>>>>> Currently these PMC clocks are registered by Tegra clock driver
>>>>>>> using
>>>>>>> clk_register_mux and clk_register_gate by passing PMC base address
>>>>>>> and register offsets and PMC programming for these clocks happens
>>>>>>> through direct PMC access by the clock driver.
>>>>>>>
>>>>>>> With this, when PMC is in secure mode any direct PMC access from the
>>>>>>> non-secure world does not go through and these clocks will not be
>>>>>>> functional.
>>>>>>>
>>>>>>> This patch adds these clocks registration with PMC as a clock
>>>>>>> provider
>>>>>>> for these clocks. clk_ops callback implementations for these clocks
>>>>>>> uses tegra_pmc_readl and tegra_pmc_writel which supports PMC
>>>>>>> programming
>>>>>>> in secure mode and non-secure mode.
>>>>>>>
>>>>>>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>>>>>>> ---
>>>>> [snip]
>>>>>
>>>>>>> +
>>>>>>> +static const struct clk_ops pmc_clk_gate_ops = {
>>>>>>> +    .is_enabled = pmc_clk_is_enabled,
>>>>>>> +    .enable = pmc_clk_enable,
>>>>>>> +    .disable = pmc_clk_disable,
>>>>>>> +};
>>>>>> What's the benefit of separating GATE from the MUX?
>>>>>>
>>>>>> I think it could be a single clock.
>>>>> According to TRM:
>>>>>
>>>>> 1. GATE and MUX are separate entities.
>>>>>
>>>>> 2. GATE is the parent of MUX (see PMC's CLK_OUT paths diagram in TRM).
>>>>>
>>>>> 3. PMC doesn't gate EXTPERIPH clock but could "force-enable" it,
>>>>> correct?
> 
> Was following existing clk-tegra-pmc as I am not sure of reason for
> having these clocks registered as separate mux and gate clocks.
> 
> Yes, PMC clocks can be registered as single clock and can use clk_ops
> for set/get parent and enable/disable.
> 
> enable/disable of PMC clocks is for force-enable to force the clock to
> run regardless of ACCEPT_REQ or INVERT_REQ.
> 
>>>> 4. clk_m_div2/4 are internal PMC OSC dividers and thus these clocks
>>>> should belong to PMC.
>>> Also, it should be "osc" and not "clk_m".
>>
>> I followed the same parents as it were in existing clk-tegra-pmc driver.
>>
>> Yeah they are wrong and they should be from osc and not clk_m.
>>
>> Will fix in next version.
>>

Could you please describe the full EXTPERIPH clock topology and how the
pinmux configuration is related to it all?

What is internal to the Tegra chip and what are the external outputs?

Is it possible to bypass PMC on T30+ for the EXTPERIPH clocks?
