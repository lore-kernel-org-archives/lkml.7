Return-Path: <SRS0=Iet2=Z5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D433CC43603
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 15:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CB8D24670
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 15:53:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tKeXKLzI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbfLGPxj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Dec 2019 10:53:39 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46671 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbfLGPxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Dec 2019 10:53:39 -0500
Received: by mail-lf1-f66.google.com with SMTP id f15so6703880lfl.13;
        Sat, 07 Dec 2019 07:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fH/Cb31jYEPGogb8f2+iaeg542opqKMOZ7lMxFJPQIw=;
        b=tKeXKLzIAcKFmF0Mwf1RVL7DQHzE0ICmG2H1a6v+QeY5aahYo7oHTXcTkzuWDZbx3X
         LnZUW1nHbMft634YXkFFWL3iqH423Id9IgQbEafXlLPaZBu4JT3/WxtRAJAhKWuL0koy
         ybKTwNU81xAi+WBpJ4RUnNE3oehiU8i30w1WYXu5D23XToZeb4Vg5cqzTqKosUmRjZoo
         pbBQKrW4Vr/1aZsdC03bT7LhqP8GmRYh2ZVDFo4OwHM4VGPjr8Ld9OGX7WZ+pxYVvfbf
         dgizH2AjvpiPQXN/YLwR12E6euKIo5IQh60x+6mb073znORRB5A5pzC7btNGVmySR7WG
         kIRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fH/Cb31jYEPGogb8f2+iaeg542opqKMOZ7lMxFJPQIw=;
        b=mLVrB1Th6BtBjdNKpgzcITDlr23EGiLz766OUc0QGnItI1rf9NvM3SOMCMbItcdJYK
         s7tTUgtWBUG+oXUeAgECUvAAKs/LXL/BzbnCGZY523CMpjmtKV1IGAR0WBldY/eFJoL3
         H05mRoB+d1PFllfceRMG076RvnfhLJGjwmGnpHJLoqk3cD3EQRoz+Qw03xXlS6vGp/6p
         WHrNEzi7j5d/GKkFzLa3M9D1/HhvK8eWlWTATIvzJskHn02F7AF5pgt7sCdKgaXW1rZc
         bCH8VzPJcLAaswlhws28yjSKjr/ST3HpTu04uGTDNPUWzx4MVH+2PJoP93nq34g0m4gO
         vVpA==
X-Gm-Message-State: APjAAAWxGYRAmn4+WB7phhpecVXzqtNVYMPPRXJ2SZm2qkEB1DKwEhpD
        slIdpc3s+1PiaIvcLGBWogI=
X-Google-Smtp-Source: APXvYqwVVXkKdtSCHhcDsPC5obY0P8+ELH7kxpNBj912HH/ZsWUCjhrIqgJpy3Fn/wap8rKrgutUDQ==
X-Received: by 2002:a19:4901:: with SMTP id w1mr7061966lfa.56.1575734016840;
        Sat, 07 Dec 2019 07:53:36 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id l26sm914272lfj.59.2019.12.07.07.53.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Dec 2019 07:53:36 -0800 (PST)
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
Message-ID: <dc7a057a-0bed-0e6f-0987-edcfec47f867@gmail.com>
Date:   Sat, 7 Dec 2019 18:53:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <ad3a6743-4b36-fa25-9cc7-72803038ecc5@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

07.12.2019 18:47, Dmitry Osipenko пишет:
> 07.12.2019 17:28, Dmitry Osipenko пишет:
>> 06.12.2019 05:48, Sowjanya Komatineni пишет:
>>> Tegra210 and prior Tegra PMC has clk_out_1, clk_out_2, clk_out_3 with
>>> mux and gate for each of these clocks.
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
> 
> [snip]
> 
>>> +
>>> +static const struct clk_ops pmc_clk_gate_ops = {
>>> +	.is_enabled = pmc_clk_is_enabled,
>>> +	.enable = pmc_clk_enable,
>>> +	.disable = pmc_clk_disable,
>>> +};
>>
>> What's the benefit of separating GATE from the MUX?
>>
>> I think it could be a single clock.
> 
> According to TRM:
> 
> 1. GATE and MUX are separate entities.
> 
> 2. GATE is the parent of MUX (see PMC's CLK_OUT paths diagram in TRM).
> 
> 3. PMC doesn't gate EXTPERIPH clock but could "force-enable" it, correct?

4. clk_m_div2/4 are internal PMC OSC dividers and thus these clocks
should belong to PMC.
