Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F832C3A5A2
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 22:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 152BD206B6
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 22:35:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iIKGbXDY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389118AbfIVWfH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 18:35:07 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35819 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388488AbfIVWfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 18:35:07 -0400
Received: by mail-lf1-f68.google.com with SMTP id w6so8632334lfl.2;
        Sun, 22 Sep 2019 15:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2jgqfQ4Zn3anCJix/pJOKzECWClw8RneGZ8/9ElN/RE=;
        b=iIKGbXDYqTJiPMsFLqB5KUT0RH7thj0dq3v6w6h6qKEurO7NZWYUf1bnJy9hFWtW3Q
         A2Vk3DD9+hSfbgKUM2dFFqrN0XT5VVF22R+kwHi2y82rDU5E5GpKpo323Iyxc2pGR4uK
         bWavOgtHADRHCC5Bep34fYrDsb5AG5TAKpTCc4SAQ7tnt2j/rhBECUhVO6iOuhnzhETZ
         ntV1rbowIoMmKKcRZSGrFg7hFUujnCefHcFrBxib2rNYH5Pi+in+aa2BSnCoL7Ika6tc
         mI0Oc6MdOf2jC9gqEB0+FVXNmMt7kajInH7NKD+XmkNDltK/MxCs4RE6xHV4uOho8Zyi
         6nDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2jgqfQ4Zn3anCJix/pJOKzECWClw8RneGZ8/9ElN/RE=;
        b=bqT5C04nFaIUH1Jx6bV5vOoGM4bdzsVx3UHylzvu6qVMoOodaa5ko9s05v+R/mpj+W
         j0L4qPK2ZY1LxcdMwfBtqpcRR9tHBruRilHAzS7TzMezO2Clojscm3y+W9QxSiPiVJKx
         vlAQGTBZ47uiQ2ctxPgkWGUlsd75p71wkcPUDhzWJllD20OR6YdPpopuXoTZRyV3JOWF
         JHkMgqy3Rb3qyGU/9ygJyp31pfcDZhyrM3czPDtC3trCJLs1oSFy6a7Wgi1949NHA/H+
         FSe3LEGWcf0Y4mnYyLbgKi+H9KBwX82gv5OTuT+omKFpfUJ4e1oPgy5EgSx6yfoSKyX9
         ghNw==
X-Gm-Message-State: APjAAAVQRObHHc6UDGb+KgIPKP5BsKUf+hGOagPpyqm05BUpS/88TTlr
        tESv4fWuwRvqhiu9xRUi05E3KvNN
X-Google-Smtp-Source: APXvYqwY2sNPbaMeg/tMBK1g80hieg590i7A/DumcuWWZOTmOtgtt51S2oBVvQACwuI8Np8ALosmXw==
X-Received: by 2002:a19:6517:: with SMTP id z23mr13598026lfb.31.1569191704299;
        Sun, 22 Sep 2019 15:35:04 -0700 (PDT)
Received: from [192.168.2.145] (ppp94-29-32-67.pppoe.spdop.ru. [94.29.32.67])
        by smtp.googlemail.com with ESMTPSA id c10sm1821085lfp.65.2019.09.22.15.35.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Sep 2019 15:35:03 -0700 (PDT)
Subject: Re: [PATCH v4 1/2] soc/tegra: pmc: Query PCLK clock rate at probe
 time
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190804202927.15014-1-digetx@gmail.com>
Message-ID: <8ad9dea9-efb5-4be3-0a14-651df468d80d@gmail.com>
Date:   Mon, 23 Sep 2019 01:35:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190804202927.15014-1-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

04.08.2019 23:29, Dmitry Osipenko пишет:
> It is possible to get a lockup if kernel decides to enter LP2 cpuidle
> from some clk-notifier, in that case CCF's "prepare" mutex is kept locked
> and thus clk_get_rate(pclk) blocks on the same mutex with interrupts being
> disabled.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
> 
> Changelog:
> 
> v4: Added clk-notifier to track PCLK rate-changes, which may become useful
>     in the future. That's done in response to v3 review comment from Peter
>     De Schrijver.
> 
>     Now properly handling case where clk pointer is intentionally NULL on
>     the driver's probe.
> 
> v3: Changed commit's message because I actually recalled what was the
>     initial reason for the patch, since the problem reoccurred once again.
> 
> v2: Addressed review comments that were made by Jon Hunter to v1 by
>     not moving the memory barrier, replacing one missed clk_get_rate()
>     with pmc->rate, handling possible clk_get_rate() error on probe and
>     slightly adjusting the commits message.
> 
>  drivers/soc/tegra/pmc.c | 71 ++++++++++++++++++++++++++++++-----------
>  1 file changed, 53 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
> index 9f9c1c677cf4..4e44943d0b26 100644
> --- a/drivers/soc/tegra/pmc.c
> +++ b/drivers/soc/tegra/pmc.c
> @@ -309,6 +309,7 @@ static const char * const tegra210_reset_sources[] = {
>   * @pctl_dev: pin controller exposed by the PMC
>   * @domain: IRQ domain provided by the PMC
>   * @irq: chip implementation for the IRQ domain
> + * @clk_nb: pclk clock changes handler
>   */
>  struct tegra_pmc {
>  	struct device *dev;
> @@ -344,6 +345,8 @@ struct tegra_pmc {
>  
>  	struct irq_domain *domain;
>  	struct irq_chip irq;
> +
> +	struct notifier_block clk_nb;
>  };
>  
>  static struct tegra_pmc *pmc = &(struct tegra_pmc) {
> @@ -1192,7 +1195,7 @@ static int tegra_io_pad_prepare(struct tegra_pmc *pmc, enum tegra_io_pad id,
>  		return err;
>  
>  	if (pmc->clk) {
> -		rate = clk_get_rate(pmc->clk);
> +		rate = pmc->rate;
>  		if (!rate) {
>  			dev_err(pmc->dev, "failed to get clock rate\n");
>  			return -ENODEV;
> @@ -1433,6 +1436,7 @@ void tegra_pmc_set_suspend_mode(enum tegra_suspend_mode mode)
>  void tegra_pmc_enter_suspend_mode(enum tegra_suspend_mode mode)
>  {
>  	unsigned long long rate = 0;
> +	u64 ticks;
>  	u32 value;
>  
>  	switch (mode) {
> @@ -1441,31 +1445,22 @@ void tegra_pmc_enter_suspend_mode(enum tegra_suspend_mode mode)
>  		break;
>  
>  	case TEGRA_SUSPEND_LP2:
> -		rate = clk_get_rate(pmc->clk);
> +		rate = pmc->rate;
>  		break;
>  
>  	default:
>  		break;
>  	}
>  
> -	if (WARN_ON_ONCE(rate == 0))
> -		rate = 100000000;
> -
> -	if (rate != pmc->rate) {
> -		u64 ticks;
> -
> -		ticks = pmc->cpu_good_time * rate + USEC_PER_SEC - 1;
> -		do_div(ticks, USEC_PER_SEC);
> -		tegra_pmc_writel(pmc, ticks, PMC_CPUPWRGOOD_TIMER);
> +	ticks = pmc->cpu_good_time * rate + USEC_PER_SEC - 1;
> +	do_div(ticks, USEC_PER_SEC);
> +	tegra_pmc_writel(pmc, ticks, PMC_CPUPWRGOOD_TIMER);
>  
> -		ticks = pmc->cpu_off_time * rate + USEC_PER_SEC - 1;
> -		do_div(ticks, USEC_PER_SEC);
> -		tegra_pmc_writel(pmc, ticks, PMC_CPUPWROFF_TIMER);
> +	ticks = pmc->cpu_off_time * rate + USEC_PER_SEC - 1;
> +	do_div(ticks, USEC_PER_SEC);
> +	tegra_pmc_writel(pmc, ticks, PMC_CPUPWROFF_TIMER);
>  
> -		wmb();
> -
> -		pmc->rate = rate;
> -	}
> +	wmb();
>  
>  	value = tegra_pmc_readl(pmc, PMC_CNTRL);
>  	value &= ~PMC_CNTRL_SIDE_EFFECT_LP0;
> @@ -2019,6 +2014,20 @@ static int tegra_pmc_irq_init(struct tegra_pmc *pmc)
>  	return 0;
>  }
>  
> +static int tegra_pmc_clk_notify_cb(struct notifier_block *nb,
> +				   unsigned long action, void *ptr)
> +{
> +	struct clk_notifier_data *data = ptr;
> +	struct tegra_pmc *pmc;
> +
> +	if (action == POST_RATE_CHANGE) {
> +		pmc = container_of(nb, struct tegra_pmc, clk_nb);
> +		pmc->rate = data->new_rate;
> +	}
> +
> +	return NOTIFY_OK;
> +}
> +
>  static int tegra_pmc_probe(struct platform_device *pdev)
>  {
>  	void __iomem *base;
> @@ -2082,6 +2091,30 @@ static int tegra_pmc_probe(struct platform_device *pdev)
>  		pmc->clk = NULL;
>  	}
>  
> +	/*
> +	 * PCLK clock rate can't be retrieved using CLK API because it
> +	 * causes lockup if CPU enters LP2 idle state from some other
> +	 * CLK notifier, hence we're caching the rate's value locally.
> +	 */
> +	if (pmc->clk) {
> +		pmc->clk_nb.notifier_call = tegra_pmc_clk_notify_cb;
> +		err = clk_notifier_register(pmc->clk, &pmc->clk_nb);
> +		if (err) {
> +			dev_err(&pdev->dev,
> +				"failed to register clk notifier\n");
> +			return err;
> +		}
> +
> +		pmc->rate = clk_get_rate(pmc->clk);
> +	}
> +
> +	if (!pmc->rate) {
> +		if (pmc->clk)
> +			dev_err(&pdev->dev, "failed to get pclk rate\n");
> +
> +		pmc->rate = 100000000;
> +	}
> +
>  	pmc->dev = &pdev->dev;
>  
>  	tegra_pmc_init(pmc);
> @@ -2133,6 +2166,8 @@ static int tegra_pmc_probe(struct platform_device *pdev)
>  cleanup_sysfs:
>  	device_remove_file(&pdev->dev, &dev_attr_reset_reason);
>  	device_remove_file(&pdev->dev, &dev_attr_reset_level);
> +	clk_notifier_unregister(pmc->clk, &pmc->clk_nb);
> +
>  	return err;
>  }
>  
> 

Hello Peter and Jon,

You had some comments that have been addressed, does this version look good to you? ACK?
