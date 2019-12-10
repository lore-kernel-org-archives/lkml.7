Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC8FC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 17:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A7B6207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 17:42:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="guhLgbks"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbfLJRmC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 12:42:02 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34390 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727527AbfLJRmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 12:42:02 -0500
Received: by mail-lj1-f196.google.com with SMTP id m6so20899479ljc.1;
        Tue, 10 Dec 2019 09:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QfJTKVdfbIy1QvA+crqjL/pZ+t72s8W0hogs96+o5qs=;
        b=guhLgbks/0Dffx9yG++K/APuJa0GiTUODnARKWEjQlrtff0bNQ4fps8W5gqhSA4S+M
         /jJ7inz4GrvMt7YtWaHmmh35YYv0/2DPkB5Fs1xhpdSjv+muAXdyyeYlxRiECqqzfDP1
         BKAo467YedEEwzsAwPwfUmBZ268AiJJyd4qU8hSrpuPlxylwAqLeDvRKSF4FFcM9MHRk
         2gMJMyfG8KM1EP/ocaXF7oGxGFB8DqbfLKZjzM7+Va1hgxQ7Ok7skqo1vR0RjVYXWzul
         WJS59rI3zyRWnMx4Ah19JBTnsp6wcZAxV9cVfH+nTE+RZovrNjtKssNWj7+XRofoO6VK
         Cyzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QfJTKVdfbIy1QvA+crqjL/pZ+t72s8W0hogs96+o5qs=;
        b=Oa/4gms5THMM7/Fhlu4XBFhQiAGCL3IuTbqjljp8UMik9HnJggOH+8iP+WvAZtey+B
         Y3x2o2l05gBaIDSWw/zHLXDyqRAGW4e76DhzI717x9+5Nk2fNGQj1wD77rPYF2b76p8u
         8nbCPaDZs5IDBI7o3TgM23xk+ocq+IPLDLNkT24bOpuNX3N3/QgocXN45hybRv9mAh/V
         PQF6tYxx3KHN2TN0BfXhugjMi271qsAOfnmhWShfYutdlbAwkr99nzDB4ECP92gtwTSa
         xvlrO5y5s2CR9/YvjuH74GR/M1QgYJlZ4KXzjeBaSnngVyzeNTo5B3mTz/VcRsKijDGZ
         VH0Q==
X-Gm-Message-State: APjAAAXrJLyMYMxFcQlyaWCTjSRAOxW0l7YXjV+nczAzVjQ5LILzwtdx
        VPdTasfITXMi75ZS+Rs9jB0=
X-Google-Smtp-Source: APXvYqylMr6Wle/q9f4QHc5wvwewu9vXCNgcbAHDny/NQFx/kBCZ735EOS5N4YgckKoIp8tomb6KTQ==
X-Received: by 2002:a2e:5751:: with SMTP id r17mr21566317ljd.254.1575999718425;
        Tue, 10 Dec 2019 09:41:58 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id e8sm2586832ljb.45.2019.12.10.09.41.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2019 09:41:57 -0800 (PST)
Subject: Re: [PATCH v3 03/15] soc: tegra: Add Tegra PMC clock registrations
 into PMC driver
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        mperttunen@nvidia.com, sboyd@kernel.org, pdeschrijver@nvidia.com
Cc:     gregkh@linuxfoundation.org, tglx@linutronix.de, robh+dt@kernel.org,
        mark.rutland@arm.com, allison@lohutok.net, pgaikwad@nvidia.com,
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
 <ccb715cc-c927-ea91-a26e-24d6eeeeef1a@gmail.com>
 <ee1d39d4-9a57-da9b-fce6-8130dac1d2fd@nvidia.com>
 <49da77dc-b346-68eb-9ef8-42cfb3221489@nvidia.com>
 <3f1c9325-3017-62be-1e3b-82fd28540fdf@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <6fcbff3d-8695-7cd0-60de-6eb523b6964c@gmail.com>
Date:   Tue, 10 Dec 2019 20:41:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <3f1c9325-3017-62be-1e3b-82fd28540fdf@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

10.12.2019 19:53, Sowjanya Komatineni пишет:
> 
> On 12/9/19 3:03 PM, Sowjanya Komatineni wrote:
>>
>> On 12/9/19 12:46 PM, Sowjanya Komatineni wrote:
>>>
>>> On 12/9/19 12:12 PM, Dmitry Osipenko wrote:
>>>> 08.12.2019 00:36, Sowjanya Komatineni пишет:
>>>>> On 12/7/19 11:59 AM, Sowjanya Komatineni wrote:
>>>>>> On 12/7/19 8:00 AM, Dmitry Osipenko wrote:
>>>>>>> 07.12.2019 18:53, Dmitry Osipenko пишет:
>>>>>>>> 07.12.2019 18:47, Dmitry Osipenko пишет:
>>>>>>>>> 07.12.2019 17:28, Dmitry Osipenko пишет:
>>>>>>>>>> 06.12.2019 05:48, Sowjanya Komatineni пишет:
>>>>>>>>>>> Tegra210 and prior Tegra PMC has clk_out_1, clk_out_2, clk_out_3
>>>>>>>>>>> with
>>>>>>>>>>> mux and gate for each of these clocks.
>>>>>>>>>>>
>>>>>>>>>>> Currently these PMC clocks are registered by Tegra clock driver
>>>>>>>>>>> using
>>>>>>>>>>> clk_register_mux and clk_register_gate by passing PMC base
>>>>>>>>>>> address
>>>>>>>>>>> and register offsets and PMC programming for these clocks
>>>>>>>>>>> happens
>>>>>>>>>>> through direct PMC access by the clock driver.
>>>>>>>>>>>
>>>>>>>>>>> With this, when PMC is in secure mode any direct PMC access
>>>>>>>>>>> from the
>>>>>>>>>>> non-secure world does not go through and these clocks will
>>>>>>>>>>> not be
>>>>>>>>>>> functional.
>>>>>>>>>>>
>>>>>>>>>>> This patch adds these clocks registration with PMC as a clock
>>>>>>>>>>> provider
>>>>>>>>>>> for these clocks. clk_ops callback implementations for these
>>>>>>>>>>> clocks
>>>>>>>>>>> uses tegra_pmc_readl and tegra_pmc_writel which supports PMC
>>>>>>>>>>> programming
>>>>>>>>>>> in secure mode and non-secure mode.
>>>>>>>>>>>
>>>>>>>>>>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>>>>>>>>>>> ---
>>>>>>>>> [snip]
>>>>>>>>>
>>>>>>>>>>> +
>>>>>>>>>>> +static const struct clk_ops pmc_clk_gate_ops = {
>>>>>>>>>>> +    .is_enabled = pmc_clk_is_enabled,
>>>>>>>>>>> +    .enable = pmc_clk_enable,
>>>>>>>>>>> +    .disable = pmc_clk_disable,
>>>>>>>>>>> +};
>>>>>>>>>> What's the benefit of separating GATE from the MUX?
>>>>>>>>>>
>>>>>>>>>> I think it could be a single clock.
>>>>>>>>> According to TRM:
>>>>>>>>>
>>>>>>>>> 1. GATE and MUX are separate entities.
>>>>>>>>>
>>>>>>>>> 2. GATE is the parent of MUX (see PMC's CLK_OUT paths diagram
>>>>>>>>> in TRM).
>>>>>>>>>
>>>>>>>>> 3. PMC doesn't gate EXTPERIPH clock but could "force-enable" it,
>>>>>>>>> correct?
>>>>> Was following existing clk-tegra-pmc as I am not sure of reason for
>>>>> having these clocks registered as separate mux and gate clocks.
>>>>>
>>>>> Yes, PMC clocks can be registered as single clock and can use clk_ops
>>>>> for set/get parent and enable/disable.
>>>>>
>>>>> enable/disable of PMC clocks is for force-enable to force the clock to
>>>>> run regardless of ACCEPT_REQ or INVERT_REQ.
>>>>>
>>>>>>>> 4. clk_m_div2/4 are internal PMC OSC dividers and thus these clocks
>>>>>>>> should belong to PMC.
>>>>>>> Also, it should be "osc" and not "clk_m".
>>>>>> I followed the same parents as it were in existing clk-tegra-pmc
>>>>>> driver.
>>>>>>
>>>>>> Yeah they are wrong and they should be from osc and not clk_m.
>>>>>>
>>>>>> Will fix in next version.
>>>>>>
>> Reg clk_m_div2/3, they are dividers at OSC pad and not really internal
>> to PMC block.
>>
>> current clock driver creates clk_m_div clocks which should actually be
>> osc_div2/osc_div4 clocks with osc as parent.
>>
>> There are no clk_m_div2 and clk_m_div4 from clk_m
>>
>> Will fix this in next version.
>>
>>>> Could you please describe the full EXTPERIPH clock topology and how the
>>>> pinmux configuration is related to it all?
>>>>
>>>> What is internal to the Tegra chip and what are the external outputs?
>>>>
>>>> Is it possible to bypass PMC on T30+ for the EXTPERIPH clocks?
>>>
>>> PMC CLK1/2/3 possible sources are OSC_DIV1, OSC_DIV2, OSC_DIV4,
>>> EXTPERIPH from CAR.
>>>
>>> OSC_DIV1/2/4 are with internal dividers at the OSC Pads
>>>
>>> EXTPERIPH is from CAR and it has reset and enable controls along with
>>> clock source selections to choose one of the PLLA_OUT0, CLK_S,
>>> PLLP_OUT0, CLK_M, PLLE_OUT0
>>>
>>> So, PMC CLK1/2/4 possible parents are OSC_DIV1, OSC_DIV2, OSC_DIV4,
>>> EXTERN.
>>>
>>>
>>> CLK1/2/3 also has Pinmux to route EXTPERIPH output on to these pins.
>>>
>>>
>>> When EXTERN output clock is selected for these PMC clocks thru
>>> CLKx_SRC_SEL, output clock is from driver by EXTPERIPH from CAR via
>>> Pinmux logic or driven as per CLKx_SRC_SEL bypassing pinmux based on
>>> CLKx_ACCEPT_REQ bit.
>>>
>>>
>>> PMC Clock control register has bit CLKx_ACCEPT_REQ
>>> When CLKx_ACCEPT_REQ = 0, output clock driver is from by EXTPERIPH
>>> through the pinmux
>>> When CLKx_ACCEPT_REQ = 1, output clock is based on CLKx_SRC_SEL bits
>>> (OSC_DIV1/2/4 and EXTPERIPH clock bypassing the pinmux)
>>>
>>> FORCE_EN bit in PMC CLock control register forces the clock to run
>>> regardless of this.
> 
> PMC clock gate is based on the state of CLKx_ACCEPT_REQ and FORCE_EN
> like explained above.
> 
> CLKx_ACCEPT_REQ is 0 default and FORCE_EN acts as gate to enable/disable
> EXTPERIPH clock output to PMC CLK_OUT_1/2/3.

[and to enable OSC as well]

> So I believe we need to register as MUX and Gate rather than as a single
> clock. Please confirm.

1. The force-enabling is applied to both OSC and EXTERN sources of
PMC_CLK_OUT_x by PMC at once.

2. Both of PMC's force-enabling and OSC/EXTERN selection is internal to PMC.

Should be better to define it as a single "pmc_clk_out_x". I don't see
any good reasons for differentiating PMC's Gate from the MUX, it's a
single hardware unit from a point of view of the rest of the system.

Peter, do you have any objections?
