Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D26F3C43215
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 19:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A728C2186D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 19:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ioz2oJK8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbfKSTeS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 14:34:18 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43270 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbfKSTeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 14:34:18 -0500
Received: by mail-lj1-f194.google.com with SMTP id y23so24695782ljh.10;
        Tue, 19 Nov 2019 11:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6i22jjuq6psYcmB4Qo1yClbc19oDCC98rypRJiM2kFc=;
        b=ioz2oJK8zcEUkcjZrufuzn/BktEf/augSq5JnBtM3JNjj4q7ULsnv9Ql3VLReZy9ft
         kYefzzT6NnQ8qu6er7uKAXYvjKfQD6dZ4Ps1N8rDKs8KePAZ857CEpN2eYpnAjffUrom
         zKp3B70qfN1rPALkG9dlIPoWb+uQMFjjeyGevuvSSvIDVRJcyU42R10XiCEMy002g+sP
         8Qb9jg9tGcMjVeWekWP/dVCnIiIwn3aii7xRcYxLaS36Y8vZQ6cFG5w6N236RfzrzOZ2
         AXRttIB8KTGNhwSu/Yj/kC64KeGloDBe+knfhzhhk+4rohgHNl+jz78GqAIbNPYuf6c0
         zAgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6i22jjuq6psYcmB4Qo1yClbc19oDCC98rypRJiM2kFc=;
        b=EE71+3nQ2GTiytGUERBTq0emHTBRaKOD2rj2U6w7rk6oz8f9LYzsrof8fN5UwVsNAg
         7D+0KqeDV5oE4dLNFXnIvNMnr02oG049nMb0SkBzK9qWlv3dM+i0ZxIyZ4b6JLc4qLzX
         ncDWaXnnOXFsSboDwg258Z/C2ELyflJ+7wjjo40uHFeXbuS546b1ioRp3pn3BIqv1Kl5
         9FEpvAzm7u0wasQAVBXfFnpmtEb3fKyHNOorVmxRnEiKvV3uDswn6+sJMMdvcpEOQ0In
         46hbh5GU8FoADpWU7FAfqNXWmhmvR8at295Ec01JsGaGIRNNDlYkrQQqawSv4fVUks8i
         GFvQ==
X-Gm-Message-State: APjAAAU9D0L8sQYIpcUVd2VaAabTZKnXFKAsj5rPxU1Q9ou2Ef8o7aOJ
        EH2kWXyWxm/z8ib1+OmgG9nyfb3E
X-Google-Smtp-Source: APXvYqwjp40IzfQbKwCC+OP/Cob50iQyYhXBidVcOfzXPpNsqZTTw4syFIFbqbn4Of7tqJstF6dMwQ==
X-Received: by 2002:a2e:87cf:: with SMTP id v15mr5309577ljj.79.1574192054580;
        Tue, 19 Nov 2019 11:34:14 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id p24sm11076087lfc.96.2019.11.19.11.34.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Nov 2019 11:34:14 -0800 (PST)
Subject: Re: [PATCH v1 06/17] soc: pmc: Add blink output clock registration to
 Tegra PMC
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
 <1574146234-3871-7-git-send-email-skomatineni@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <95f3e928-3e08-abbd-5617-d3570a592c06@gmail.com>
Date:   Tue, 19 Nov 2019 22:34:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <1574146234-3871-7-git-send-email-skomatineni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

19.11.2019 09:50, Sowjanya Komatineni пишет:
> Tegra PMC has blink control to output 32 Khz clock out to Tegra
> blink pin. Blink pad DPD state and enable controls are part of
> Tegra PMC register space.
> 
> Currently Tegra clock driver registers blink control by passing
> PMC address and register offset to clk_register_gate which performs
> direct PMC access during clk_ops and with this when PMC is in secure
> mode, any access from non-secure world does not go through.
> 
> This patch adds blink control registration to the Tegra PMC driver
> using PMC specific clock gate operations that use tegra_pmc_readl
> and tegra_pmc_writel to support both secure mode and non-secure
> mode PMC register access.
> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  drivers/soc/tegra/pmc.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 
> diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
> index 790a6619ba32..095e89c7fa3f 100644
> --- a/drivers/soc/tegra/pmc.c
> +++ b/drivers/soc/tegra/pmc.c
> @@ -61,12 +61,15 @@
>  #define  PMC_CNTRL_SYSCLK_OE		BIT(11) /* system clock enable */
>  #define  PMC_CNTRL_SYSCLK_POLARITY	BIT(10) /* sys clk polarity */
>  #define  PMC_CNTRL_PWRREQ_POLARITY	BIT(8)
> +#define  PMC_CNTRL_BLINK_EN		BIT(7)
>  #define  PMC_CNTRL_MAIN_RST		BIT(4)
>  
>  #define PMC_WAKE_MASK			0x0c
>  #define PMC_WAKE_LEVEL			0x10
>  #define PMC_WAKE_STATUS			0x14
>  #define PMC_SW_WAKE_STATUS		0x18
> +#define PMC_DPD_PADS_ORIDE		0x1c
> +#define  PMC_DPD_PADS_ORIDE_BLINK	BIT(20)
>  
>  #define DPD_SAMPLE			0x020
>  #define  DPD_SAMPLE_ENABLE		BIT(0)
> @@ -79,6 +82,7 @@
>  
>  #define PWRGATE_STATUS			0x38
>  
> +#define TEGRA210_PMC_BLINK_TIMER	0x40
>  #define PMC_IMPL_E_33V_PWR		0x40
>  
>  #define PMC_PWR_DET			0x48
> @@ -247,6 +251,9 @@ static struct pmc_clk_init_data tegra_pmc_clks_data[] = {
>  	PMC_CLK(3, 22, 18, 0, 0),
>  };
>  
> +static struct pmc_clk_gate blink_override;
> +static struct pmc_clk_gate blink;
> +
>  struct tegra_powergate {
>  	struct generic_pm_domain genpd;
>  	struct tegra_pmc *pmc;
> @@ -359,6 +366,7 @@ struct tegra_pmc_soc {
>  
>  	struct pmc_clk_init_data *pmc_clks_data;
>  	unsigned int num_pmc_clks;
> +	bool has_blink_output;
>  };
>  
>  static const char * const tegra186_reset_sources[] = {
> @@ -2530,6 +2538,9 @@ static void tegra_pmc_clock_register(struct tegra_pmc *pmc,
>  	/* each pmc clock output has a mux and a gate */
>  	num_clks = pmc->soc->num_pmc_clks * 2;
>  
> +	if (pmc->soc->has_blink_output)
> +		num_clks += 1;
> +
>  	if (!num_clks)
>  		return;
>  
> @@ -2604,6 +2615,30 @@ static void tegra_pmc_clock_register(struct tegra_pmc *pmc,
>  		}
>  	}
>  
> +	if (pmc->soc->has_blink_output) {
> +		tegra_pmc_writel(pmc, 0x0, TEGRA210_PMC_BLINK_TIMER);
> +		clkgate = tegra_pmc_clk_gate_register("blink_override",
> +						      "clk_32k",
> +						      0, &blink_override,
> +					      PMC_DPD_PADS_ORIDE,
> +						      PMC_DPD_PADS_ORIDE_BLINK,
> +						      NULL);
> +		if (IS_ERR(clkgate))
> +			goto free_clks;
> +
> +		clkgate = tegra_pmc_clk_gate_register("blink",
> +						      "blink_override",
> +						      0, &blink,
> +						      PMC_CNTRL,
> +						      PMC_CNTRL_BLINK_EN,
> +						      NULL);
> +		if (IS_ERR(clkgate))
> +			goto free_clks;
> +
> +		clk_data->clks[TEGRA_PMC_CLK_BLINK] = clkgate;
> +		clk_register_clkdev(clkgate, "blink", NULL);

Tegra20 has pmc->soc->num_pmc_clks = 0 and thus num_clks = 1, while
TEGRA_PMC_CLK_BLINK = 6.

BTW, Tegra30 doesn't boot. I'll try again v2.

Please fix it all in v2. Compile-test all patches and make at least a
boot-test where possible.

[snip]
