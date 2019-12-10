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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C80C2D0BF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 18:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D815E20663
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 18:30:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X/8vG0ml"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727637AbfLJSaG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 13:30:06 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37473 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbfLJSaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 13:30:05 -0500
Received: by mail-lf1-f68.google.com with SMTP id b15so14525467lfc.4;
        Tue, 10 Dec 2019 10:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qJU4Pmn8p+BP6WtR4OMNjM0SlbVb7r9lcUi4XdHIpn4=;
        b=X/8vG0mliUAaIF4AfnO5i7Xkz0m6r0I1Guf84MbCuz9S76xmx4xu/0UiO32//pvXxl
         I+SYlBnp2QkEqd1Td3/X9xRrrYwwoZPSucVDR4luj0Bq+LC6c6y+QUU4ITNMep/ISIag
         YiHUno0cnwaF4V+dCzvQFmBt3VxXvVEA19HrnKjaPbI0ApizKiFWEFqig6jKb3Ft7wf9
         m6Rh7P1C/ZnJvCNbQFw6shgZuNq0gjdey2Cy78F1sO0jLbUXdNb+JAHKJRgIf8TgIiwW
         03hIVUOa9YUiEZdWTX3Zjbd6qqyE7w1PQqA3iDFJUFBzyy5HDMpEXCd4DGKiJCgfnEOf
         6ZyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qJU4Pmn8p+BP6WtR4OMNjM0SlbVb7r9lcUi4XdHIpn4=;
        b=XO3+LTzsMMaozr/TzkGXJTiL48LRDzStO7xGeuMH+ZOXpiPVIMiGrMFnzK8rJPBe1R
         UvRbCLI+rg44VPagixB4GcoTXxj0dCLAc2EVyaQOp/MzQMncJQRVvJBt38vhbGv+2zrB
         OS+djYPwAnhG0siYjpeb/ydJD0M74I/HgUNeYAp4/3WceeVwf5dgeISY7jIRe1GY8sUW
         UbCp2VhyEViSOGDGssp++QiHCHmo/D2OPzy3degUcNPuv8Eit9WRjuzLmSthHSFpYwmc
         42/3cl/GOYdjrWmRz4QqsTsOzWduH8O3zMk2t7iGRqkVXRo44CnJHzTiaf3az6xXFD8K
         Xo7A==
X-Gm-Message-State: APjAAAWlQn1bCsfzbom5Ex4dRshhmn4QAyoHgql/JK4CDX+sR8VMYEaJ
        NsWjzWeYkLh7FNVFu/1KVFs=
X-Google-Smtp-Source: APXvYqyO2DJRFRYreVbJWU1FOfHdesOW3uMVxL4CrJOhxgLnOJJWcJ1dSr+dh7dlPGifSs3bh7KGqA==
X-Received: by 2002:a19:5013:: with SMTP id e19mr20136293lfb.8.1576002602556;
        Tue, 10 Dec 2019 10:30:02 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id g5sm2018377lfc.11.2019.12.10.10.30.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2019 10:30:01 -0800 (PST)
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
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <5a5cfa74-66be-5c7a-04eb-88c355851c59@gmail.com>
Date:   Tue, 10 Dec 2019 21:30:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <22a2f8bd-561d-f4c6-4eef-bb61095c53b2@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

10.12.2019 20:48, Sowjanya Komatineni пишет:
> 
> On 12/10/19 9:41 AM, Dmitry Osipenko wrote:
>> 09.12.2019 23:46, Sowjanya Komatineni пишет:
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
>>>>>>>>>>> clk_register_mux and clk_register_gate by passing PMC base address
>>>>>>>>>>> and register offsets and PMC programming for these clocks happens
>>>>>>>>>>> through direct PMC access by the clock driver.
>>>>>>>>>>>
>>>>>>>>>>> With this, when PMC is in secure mode any direct PMC access
>>>>>>>>>>> from the
>>>>>>>>>>> non-secure world does not go through and these clocks will not be
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
>>>>>>>>> 2. GATE is the parent of MUX (see PMC's CLK_OUT paths diagram in
>>>>>>>>> TRM).
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
>>>> Could you please describe the full EXTPERIPH clock topology and how the
>>>> pinmux configuration is related to it all?
>>>>
>>>> What is internal to the Tegra chip and what are the external outputs?
>>>>
>>>> Is it possible to bypass PMC on T30+ for the EXTPERIPH clocks?
>>> PMC CLK1/2/3 possible sources are OSC_DIV1, OSC_DIV2, OSC_DIV4,
>>> EXTPERIPH from CAR.
>>>
>>> OSC_DIV1/2/4 are with internal dividers at the OSC Pads
>>>
>>> EXTPERIPH is from CAR and it has reset and enable controls along with
>>> clock source selections to choose one of the PLLA_OUT0, CLK_S,
>>> PLLP_OUT0, CLK_M, PLLE_OUT0
>> Are you sure that EXTPERIPH has a reset? What will it reset? Why it's
>> not documented in TRM?
> Yes, Extperiph1/2/3 has RST part of CAR RST_DEVICES_V bits 24/25/26

Are these bits not documented in a public TRMs? I checked
T30/114/124/210 TRMs and CLK_RST_CONTROLLER_RST_DEVICES_V_0 doesn't have
those bits in the docs.

>>> So, PMC CLK1/2/4 possible parents are OSC_DIV1, OSC_DIV2, OSC_DIV4, EXTERN.
>>>
>>>
>>> CLK1/2/3 also has Pinmux to route EXTPERIPH output on to these pins.
>> Could you please clarify what are "these" pins? Perhaps you meant the
>> EXTERN pin of PMC?
> By CLK1/2/3 pins, I am referring to CLK_OUT_1/2/3 pins from Tegra

I see now what you meant, thanks.

[snip}
