Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FCE2C43215
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 17:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BC0D20872
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 17:46:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XYPYGEsR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728064AbfKTRqJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 12:46:09 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44728 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727639AbfKTRqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 12:46:08 -0500
Received: by mail-lj1-f196.google.com with SMTP id g3so51025ljl.11;
        Wed, 20 Nov 2019 09:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eXubl2Ww8hYmI5jI8u6b5ajpQpT9guM2OU2Sn6bPwZw=;
        b=XYPYGEsRhnhotPNqKuiRQp4cD24+tZwh5P0743M3PeK7m1qhVOk5PNLCJdQMMiL//Z
         4LjIlpVZt/3HGK0OURosHy4k8e0Zf26kgN8RyYi7ZgxpdLgi4SbCnNdjC+6E1Mg0I7mb
         0Jdf0sI6u554XLG3n8uyZ1i89S1V05H6lf+l+PYV5yuk/JjrLN19mdCFi5+JroxUn5ht
         B6wI+noLpVotzDNdPH15IkcajaXBFbdQ1ph5oDn6DhHAQ0Ko2BcfdE8NGWzjujl4Anbk
         Ef8b6nNaqBOj3HT2RePG8dKkRAqtsXaihiTx+O43soJPJoD9MN354RKjI93lGMo92RhE
         pQYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eXubl2Ww8hYmI5jI8u6b5ajpQpT9guM2OU2Sn6bPwZw=;
        b=PFLLIY8+UwUy8QnlRIipRZZwNKwN37GprJmOKC5kbFhY+u+DtWtfdzkambvN6cF8Nn
         ZV5bGN34KdtN6ddIe1KBvlpNdE0hL+vIG/Pd08kMgHd3KuV8fG1xF0RLPiT28PibeaA/
         pL4MhmyUTOtSB/jQLIqCmW8wqdZKsAa4qAnaQh2fyC6430URJIarewiNLb822GdxchNn
         voyNxBKiUMbKVDadIYviRQUf8oI8sQDx1yZUup5NO2eYZSgFUHm4tghL3d1a9oQNyBNH
         kd+iSpvIz537RQt/hUaHt22gWuMfBcZ5V1vYScX7O3ocirxKM8ybOoK7AQd+NBckpyg/
         rzmw==
X-Gm-Message-State: APjAAAVSwzkej/JaryFv7Qyo44Bj5sVmIte39kHa9OIzfz2boNgzFws5
        oVS1o3xIVkdP8El0Kq1IsXf9Muxj
X-Google-Smtp-Source: APXvYqxDRrGRo1AOn5dQxGAfiWJrtQfHoVg51hHdaVbj+zViUs2CSzDOQCg9cmcCkyTvngYLiaZnGg==
X-Received: by 2002:a2e:6c0c:: with SMTP id h12mr4030068ljc.24.1574271965303;
        Wed, 20 Nov 2019 09:46:05 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id u6sm5634906lfu.49.2019.11.20.09.46.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2019 09:46:04 -0800 (PST)
Subject: Re: [PATCH v1 04/17] soc: tegra: Add Tegra PMC clock registrations
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
        linux-kernel@vger.kernel.org
References: <1574146234-3871-1-git-send-email-skomatineni@nvidia.com>
 <1574146234-3871-5-git-send-email-skomatineni@nvidia.com>
 <d072bd37-9628-4eb2-1706-a1f640606b8d@gmail.com>
 <d76f4689-5986-9239-9c67-9dd125f6547e@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <a87a08c1-5104-a534-89c4-73463c08abba@gmail.com>
Date:   Wed, 20 Nov 2019 20:46:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <d76f4689-5986-9239-9c67-9dd125f6547e@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

19.11.2019 23:08, Sowjanya Komatineni пишет:
> 
> On 11/19/19 11:33 AM, Dmitry Osipenko wrote:
>> 19.11.2019 09:50, Sowjanya Komatineni пишет:
>>> Tegra PMC has clk_out_1, clk_out_2, clk_out_3 with mux and gate for
>>> each of these clocks.
>>>
>>> Currently these PMC clocks are registered by Tegra clock driver using
>>> clk_register_mux and clk_register_gate by passing PMC base address
>>> and register offsets and PMC programming for these clocks happens
>>> through direct PMC access by the clock driver.
>>>
>>> With this, when PMC is in secure mode any direct PMC access from the
>>> non-secure world does not go through and these clocks will not be
>>> functional.
>>>
>>> This patch adds these clocks registration with PMC as a clock provider
>>> for these clocks. clk_ops callback implementations for these clocks
>>> uses tegra_pmc_readl and tegra_pmc_writel which supports PMC programming
>>> in secure mode and non-secure mode.
>>>
>>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>>> ---
>>>   drivers/soc/tegra/pmc.c | 330
>>> ++++++++++++++++++++++++++++++++++++++++++++++++
>>>   1 file changed, 330 insertions(+)
>>>
>>> diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
>>> index 7a5aab0b993b..790a6619ba32 100644
>>> --- a/drivers/soc/tegra/pmc.c
>>> +++ b/drivers/soc/tegra/pmc.c
>>> @@ -13,6 +13,9 @@
>>>     #include <linux/arm-smccc.h>
>>>   #include <linux/clk.h>
>>> +#include <linux/clk-provider.h>
>>> +#include <linux/clkdev.h>
>>> +#include <linux/clk/clk-conf.h>
>>>   #include <linux/clk/tegra.h>
>>>   #include <linux/debugfs.h>
>>>   #include <linux/delay.h>
>>> @@ -48,6 +51,7 @@
>>>   #include <dt-bindings/pinctrl/pinctrl-tegra-io-pad.h>
>>>   #include <dt-bindings/gpio/tegra186-gpio.h>
>>>   #include <dt-bindings/gpio/tegra194-gpio.h>
>>> +#include <dt-bindings/soc/tegra-pmc.h>
>>>     #define PMC_CNTRL            0x0
>>>   #define  PMC_CNTRL_INTR_POLARITY    BIT(17) /* inverts INTR
>>> polarity */
>>> @@ -108,6 +112,7 @@
>>>   #define PMC_WAKE2_STATUS        0x168
>>>   #define PMC_SW_WAKE2_STATUS        0x16c
>>>   +#define PMC_CLK_OUT_CNTRL        0x1a8
>>>   #define PMC_SATA_PWRGT            0x1ac
>>>   #define PMC_SATA_PWRGT_PLLE_IDDQ_VALUE BIT(5)
>>>   #define PMC_SATA_PWRGT_PLLE_IDDQ_SWCTL BIT(4)
>>> @@ -170,6 +175,78 @@
>>>   #define  TEGRA_SMC_PMC_READ    0xaa
>>>   #define  TEGRA_SMC_PMC_WRITE    0xbb
>>>   +struct pmc_clk_mux {
>>> +    struct clk_hw    hw;
>>> +    unsigned long    offs;
>>> +    u32        mask;
>>> +    u32        shift;
>>> +    /* register lock */
>>> +    spinlock_t    *lock;
>>> +};
>>> +
>>> +#define to_pmc_clk_mux(_hw) container_of(_hw, struct pmc_clk_mux, hw)
>>> +
>>> +struct pmc_clk_gate {
>>> +    struct clk_hw    hw;
>>> +    unsigned long    offs;
>>> +    u32        shift;
>>> +    /* register lock */
>>> +    spinlock_t    *lock;

Why clk_out_lock is needed at all? CCLK framework already takes care of
the clock's locking and then nothing else in PMC code uses that lock to
avoid races, thus that spinlock doesn't do anything useful and should be
removed from both mux and gate.

>>> +};
>>> +
>>> +#define to_pmc_clk_gate(_hw) container_of(_hw, struct pmc_clk_gate, hw)
>>> +
>>> +struct pmc_clk_init_data {
>>> +    char *mux_name;
>>> +    char *gate_name;
>>> +    const char **parents;
>>> +    int num_parents;
>>> +    int mux_id;
>>> +    int gate_id;
>>> +    char *dev_name;
>>> +    u8 mux_shift;
>>> +    u8 gate_shift;
>>> +    u8 init_parent;
>>> +    int init_state;
>>> +    struct pmc_clk_mux mux;
>>> +    struct pmc_clk_gate gate;
>>> +};
>>> +
>>> +#define PMC_CLK(_num, _mux_shift, _gate_shift, _init_parent,
>>> _init_state)\
>>> +    {\
>>> +        .mux_name = "clk_out_" #_num "_mux",\
>>> +        .gate_name = "clk_out_" #_num,\
>>> +        .parents = clk_out ##_num ##_parents,\
>>> +        .num_parents = ARRAY_SIZE(clk_out ##_num ##_parents),\
>>> +        .mux_id = TEGRA_PMC_CLK_OUT_ ##_num ##_MUX,\
>>> +        .gate_id = TEGRA_PMC_CLK_OUT_ ##_num,\
>>> +        .dev_name = "extern" #_num,\
>>> +        .mux_shift = _mux_shift,\
>>> +        .gate_shift = _gate_shift,\
>>> +        .init_parent = _init_parent,\
>>> +        .init_state = _init_state,\
>>> +    }
>>> +
>>> +static DEFINE_SPINLOCK(clk_out_lock);
>>> +
>>> +static const char *clk_out1_parents[] = { "clk_m", "clk_m_div2",
>>> +    "clk_m_div4", "extern1",
>>> +};
>>> +
>>> +static const char *clk_out2_parents[] = { "clk_m", "clk_m_div2",
>>> +    "clk_m_div4", "extern2",
>>> +};
>>> +
>>> +static const char *clk_out3_parents[] = { "clk_m", "clk_m_div2",
>>> +    "clk_m_div4", "extern3",
>>> +};
>> Why these are unused?
> They are used in PMC_CLK macro

Looks like it will better to define those three structs directly,
without the PMC_CLK macro.

[snip]

