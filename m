Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0271EC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 20:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C28CA2077B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 20:32:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IyTk5iPn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbfLJUcF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 15:32:05 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36549 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727050AbfLJUcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 15:32:03 -0500
Received: by mail-lf1-f65.google.com with SMTP id n12so14839515lfe.3;
        Tue, 10 Dec 2019 12:32:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8PGr6iFXqcH5u2siMcozfGqSHbu6yt+vqLtRq5b4v6M=;
        b=IyTk5iPnIDMKfFHAyFcx8JzsVzLa2UdoTMeDdm7G4jE3shioDRJb8wX7IskqJAGRow
         Bs7cv1SF5Z8LpaAdlo0TOvedUsnQJAF4oQML/UzLmVmPbuJZiFV8/+ug/HcTngZQjSWA
         fKsoCE7DPAaqSQgSkfyKCa3t/FV0wwNZyJlTT+mqx+2cUf78H0D7pULivx+hhsovDOTn
         XQ50BZ6wZJ7Fpy4js0j/NbzHPQfbmYn0OwoOuGYBtWDbSn9XUghNxaKKZdA0bNdppYfh
         Wpd5COMMUxCdJyK/qQyrDCTvz5sIHpglMxa6UUZfu86eeDl/TvWeBRgB5muNNqIjDNe5
         cO+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8PGr6iFXqcH5u2siMcozfGqSHbu6yt+vqLtRq5b4v6M=;
        b=P6lA5YlBwqsPTt1pxpCgXwLgBfjeTAhe+XiKbpPvUMcubWvOJ8vaoUQ1rbijz+VE9o
         tN/Ip8aVpqqxcyo9/rXcTpM+YgxNPWrpNcxCvzZQfYwd/T2mbY/x2C5CattgrhswCKXK
         97Fk8Ao7fnEuVwanCLRodidn0MSQLckm5phghI+8ACrTYtaLpu8PhUlHtB7PH8YPZwlB
         hZGqbnoLmBMn2qngoXicI7CTXzHuTT30AaFgcFhDW6TpAZMNvkz2oKNmdlVaSfPowkQJ
         ajkY1XxsCnZ/xzVeFDRQT1K+0Pgy7btu4zm95uJAMbl/i8EOEOSD4vvoPu3OwFR8HQvZ
         1gKA==
X-Gm-Message-State: APjAAAVakjtv6xmm/JEyy+wHaHT51+MkUV+/S6cEAB8psdKE9JSatoVg
        aoALi9iQ4EUTWjJiTR61cCM=
X-Google-Smtp-Source: APXvYqygJGjv3y7p8+QV+ErPle5+A2IkBFU3QJPycgtjC67SRuybF7hWpB19CKr121VXentSRjbjGg==
X-Received: by 2002:a19:491a:: with SMTP id w26mr6897711lfa.98.1576009920603;
        Tue, 10 Dec 2019 12:32:00 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id g27sm2176381lfh.57.2019.12.10.12.31.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2019 12:32:00 -0800 (PST)
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
 <ccb715cc-c927-ea91-a26e-24d6eeeeef1a@gmail.com>
 <ee1d39d4-9a57-da9b-fce6-8130dac1d2fd@nvidia.com>
 <db3bee1e-1bfa-2f9e-9ed1-91b98554556a@gmail.com>
 <22a2f8bd-561d-f4c6-4eef-bb61095c53b2@nvidia.com>
 <5a5cfa74-66be-5c7a-04eb-88c355851c59@gmail.com>
 <302d8483-513c-9c20-e4d4-1e24f2b317d6@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <c8208be6-6471-9963-26ee-67579846b1ff@gmail.com>
Date:   Tue, 10 Dec 2019 23:31:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <302d8483-513c-9c20-e4d4-1e24f2b317d6@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

10.12.2019 22:18, Sowjanya Komatineni пишет:
> 
> On 12/10/19 10:30 AM, Dmitry Osipenko wrote:
>> 10.12.2019 20:48, Sowjanya Komatineni пишет:
>>> On 12/10/19 9:41 AM, Dmitry Osipenko wrote:
>>>> 09.12.2019 23:46, Sowjanya Komatineni пишет:
>>>>> On 12/9/19 12:12 PM, Dmitry Osipenko wrote:
>>>>>> 08.12.2019 00:36, Sowjanya Komatineni пишет:
>>>>>>> On 12/7/19 11:59 AM, Sowjanya Komatineni wrote:
>>>>>>>> On 12/7/19 8:00 AM, Dmitry Osipenko wrote:
>>>>>>>>> 07.12.2019 18:53, Dmitry Osipenko пишет:
>>>>>>>>>> 07.12.2019 18:47, Dmitry Osipenko пишет:
>>>>>>>>>>> 07.12.2019 17:28, Dmitry Osipenko пишет:
>>>>>>>>>>>> 06.12.2019 05:48, Sowjanya Komatineni пишет:
>>>>>>>>>>>>> Tegra210 and prior Tegra PMC has clk_out_1, clk_out_2,
>>>>>>>>>>>>> clk_out_3
>>>>>>>>>>>>> with
>>>>>>>>>>>>> mux and gate for each of these clocks.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Currently these PMC clocks are registered by Tegra clock
>>>>>>>>>>>>> driver
>>>>>>>>>>>>> using
>>>>>>>>>>>>> clk_register_mux and clk_register_gate by passing PMC base
>>>>>>>>>>>>> address
>>>>>>>>>>>>> and register offsets and PMC programming for these clocks
>>>>>>>>>>>>> happens
>>>>>>>>>>>>> through direct PMC access by the clock driver.
>>>>>>>>>>>>>
>>>>>>>>>>>>> With this, when PMC is in secure mode any direct PMC access
>>>>>>>>>>>>> from the
>>>>>>>>>>>>> non-secure world does not go through and these clocks will
>>>>>>>>>>>>> not be
>>>>>>>>>>>>> functional.
>>>>>>>>>>>>>
>>>>>>>>>>>>> This patch adds these clocks registration with PMC as a clock
>>>>>>>>>>>>> provider
>>>>>>>>>>>>> for these clocks. clk_ops callback implementations for these
>>>>>>>>>>>>> clocks
>>>>>>>>>>>>> uses tegra_pmc_readl and tegra_pmc_writel which supports PMC
>>>>>>>>>>>>> programming
>>>>>>>>>>>>> in secure mode and non-secure mode.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>>>>>>>>>>>>> ---
>>>>>>>>>>> [snip]
>>>>>>>>>>>
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +static const struct clk_ops pmc_clk_gate_ops = {
>>>>>>>>>>>>> +    .is_enabled = pmc_clk_is_enabled,
>>>>>>>>>>>>> +    .enable = pmc_clk_enable,
>>>>>>>>>>>>> +    .disable = pmc_clk_disable,
>>>>>>>>>>>>> +};
>>>>>>>>>>>> What's the benefit of separating GATE from the MUX?
>>>>>>>>>>>>
>>>>>>>>>>>> I think it could be a single clock.
>>>>>>>>>>> According to TRM:
>>>>>>>>>>>
>>>>>>>>>>> 1. GATE and MUX are separate entities.
>>>>>>>>>>>
>>>>>>>>>>> 2. GATE is the parent of MUX (see PMC's CLK_OUT paths diagram in
>>>>>>>>>>> TRM).
>>>>>>>>>>>
>>>>>>>>>>> 3. PMC doesn't gate EXTPERIPH clock but could "force-enable" it,
>>>>>>>>>>> correct?
>>>>>>> Was following existing clk-tegra-pmc as I am not sure of reason for
>>>>>>> having these clocks registered as separate mux and gate clocks.
>>>>>>>
>>>>>>> Yes, PMC clocks can be registered as single clock and can use
>>>>>>> clk_ops
>>>>>>> for set/get parent and enable/disable.
>>>>>>>
>>>>>>> enable/disable of PMC clocks is for force-enable to force the
>>>>>>> clock to
>>>>>>> run regardless of ACCEPT_REQ or INVERT_REQ.
>>>>>>>
>>>>>>>>>> 4. clk_m_div2/4 are internal PMC OSC dividers and thus these
>>>>>>>>>> clocks
>>>>>>>>>> should belong to PMC.
>>>>>>>>> Also, it should be "osc" and not "clk_m".
>>>>>>>> I followed the same parents as it were in existing clk-tegra-pmc
>>>>>>>> driver.
>>>>>>>>
>>>>>>>> Yeah they are wrong and they should be from osc and not clk_m.
>>>>>>>>
>>>>>>>> Will fix in next version.
>>>>>>>>
>>>>>> Could you please describe the full EXTPERIPH clock topology and
>>>>>> how the
>>>>>> pinmux configuration is related to it all?
>>>>>>
>>>>>> What is internal to the Tegra chip and what are the external outputs?
>>>>>>
>>>>>> Is it possible to bypass PMC on T30+ for the EXTPERIPH clocks?
>>>>> PMC CLK1/2/3 possible sources are OSC_DIV1, OSC_DIV2, OSC_DIV4,
>>>>> EXTPERIPH from CAR.
>>>>>
>>>>> OSC_DIV1/2/4 are with internal dividers at the OSC Pads
>>>>>
>>>>> EXTPERIPH is from CAR and it has reset and enable controls along with
>>>>> clock source selections to choose one of the PLLA_OUT0, CLK_S,
>>>>> PLLP_OUT0, CLK_M, PLLE_OUT0
>>>> Are you sure that EXTPERIPH has a reset? What will it reset? Why it's
>>>> not documented in TRM?
>>> Yes, Extperiph1/2/3 has RST part of CAR RST_DEVICES_V bits 24/25/26
>> Are these bits not documented in a public TRMs? I checked
>> T30/114/124/210 TRMs and CLK_RST_CONTROLLER_RST_DEVICES_V_0 doesn't have
>> those bits in the docs.
>>
> Yeah these bits are missing in all Tegra TRM docs. Will request for
> having EXTPERIPH reset bits to be updated in TRM...

Thanks
