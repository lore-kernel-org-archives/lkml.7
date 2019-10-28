Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE8DCA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 14:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7263F20659
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 14:13:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="C+wt+VFf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389942AbfJ1ONk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 10:13:40 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:8205 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730033AbfJ1ONj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 10:13:39 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5db6f7980000>; Mon, 28 Oct 2019 07:13:44 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 28 Oct 2019 07:13:38 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 28 Oct 2019 07:13:38 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 28 Oct
 2019 14:13:37 +0000
Received: from tbergstrom-lnx.Nvidia.com (10.124.1.5) by
 DRHQMAIL107.nvidia.com (10.27.9.16) with Microsoft SMTP Server (TLS) id
 15.0.1473.3; Mon, 28 Oct 2019 14:13:37 +0000
Received: by tbergstrom-lnx.Nvidia.com (Postfix, from userid 1000)
        id 5E8D8428E8; Mon, 28 Oct 2019 16:13:35 +0200 (EET)
Date:   Mon, 28 Oct 2019 16:13:35 +0200
From:   Peter De Schrijver <pdeschrijver@nvidia.com>
To:     Dmitry Osipenko <digetx@gmail.com>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 1/2] soc/tegra: pmc: Query PCLK clock rate at probe
 time
Message-ID: <20191028141335.GB27141@pdeschrijver-desktop.Nvidia.com>
References: <20190926191755.27131-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190926191755.27131-1-digetx@gmail.com>
X-NVConfidentiality: public
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1572272024; bh=GDdUfoTlXuJ/I5h4xpmH5KabIPSUTO+CAkxSTq9NI6Y=;
        h=X-PGP-Universal:Date:From:To:CC:Subject:Message-ID:References:
         MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
         X-NVConfidentiality:User-Agent:X-Originating-IP:X-ClientProxiedBy;
        b=C+wt+VFfd03mwv2emI5ZsD8P1D2pDOPG/XL4PkZmWtjz4Qo0C07C+GxirIP283Lmo
         Oa+j0863L0VYSSsaQgrfOuQxiOllpQechRCyPLQysbxd5XccE7ywdMmj3XCafACKXh
         d9l3BiY2Ksp393k2lLECaZHrIiKMix4ozWep0/4qlz2gneYLSD55ZtaPPwL9aRhd7b
         4J3uNr6dKa3k1ScpE6WXuT2gaDJXUS2Q7yysNZXL/CJl3fHrCQe9HX9CXVf3YuH3O9
         paZTpqIGe/LkrFWIz3QiBfFpk2IA/BZOirEkmtCWn6f/4m3xt5pUKBSAUvrVLYSsyD
         7y/XKrmRGwWqg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-By  Peter De Schrijver <pdeschrijver@nvidia.com>

On Thu, Sep 26, 2019 at 10:17:54PM +0300, Dmitry Osipenko wrote:
> It is possible to get a lockup if kernel decides to enter LP2 cpuidle
> from some clk-notifier, in that case CCF's "prepare" mutex is kept locked
> and thus clk_get_rate(pclk) blocks on the same mutex with interrupts being
> disabled, hanging machine.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
> 
> Changelog:
> 
> v5: Clk notifier now takes powergates_lock to avoid potential racing with
>     tegra_io_pad_*().
> 
>     The original fallback to 100MHz when clk_get_rate() fails is preserved
>     now.
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
>  drivers/soc/tegra/pmc.c | 71 ++++++++++++++++++++++++++++++++---------
>  1 file changed, 56 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
> index 9f9c1c677cf4..ee39ded6bc7b 100644
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
> @@ -1441,7 +1445,7 @@ void tegra_pmc_enter_suspend_mode(enum tegra_suspend_mode mode)
>  		break;
>  
>  	case TEGRA_SUSPEND_LP2:
> -		rate = clk_get_rate(pmc->clk);
> +		rate = pmc->rate;
>  		break;
>  
>  	default:
> @@ -1451,21 +1455,15 @@ void tegra_pmc_enter_suspend_mode(enum tegra_suspend_mode mode)
>  	if (WARN_ON_ONCE(rate == 0))
>  		rate = 100000000;
>  
> -	if (rate != pmc->rate) {
> -		u64 ticks;
> -
> -		ticks = pmc->cpu_good_time * rate + USEC_PER_SEC - 1;
> -		do_div(ticks, USEC_PER_SEC);
> -		tegra_pmc_writel(pmc, ticks, PMC_CPUPWRGOOD_TIMER);
> -
> -		ticks = pmc->cpu_off_time * rate + USEC_PER_SEC - 1;
> -		do_div(ticks, USEC_PER_SEC);
> -		tegra_pmc_writel(pmc, ticks, PMC_CPUPWROFF_TIMER);
> +	ticks = pmc->cpu_good_time * rate + USEC_PER_SEC - 1;
> +	do_div(ticks, USEC_PER_SEC);
> +	tegra_pmc_writel(pmc, ticks, PMC_CPUPWRGOOD_TIMER);
>  
> -		wmb();
> +	ticks = pmc->cpu_off_time * rate + USEC_PER_SEC - 1;
> +	do_div(ticks, USEC_PER_SEC);
> +	tegra_pmc_writel(pmc, ticks, PMC_CPUPWROFF_TIMER);
>  
> -		pmc->rate = rate;
> -	}
> +	wmb();
>  
>  	value = tegra_pmc_readl(pmc, PMC_CNTRL);
>  	value &= ~PMC_CNTRL_SIDE_EFFECT_LP0;
> @@ -2019,6 +2017,30 @@ static int tegra_pmc_irq_init(struct tegra_pmc *pmc)
>  	return 0;
>  }
>  
> +static int tegra_pmc_clk_notify_cb(struct notifier_block *nb,
> +				   unsigned long action, void *ptr)
> +{
> +	struct tegra_pmc *pmc = container_of(nb, struct tegra_pmc, clk_nb);
> +	struct clk_notifier_data *data = ptr;
> +
> +	switch (action) {
> +	case PRE_RATE_CHANGE:
> +		mutex_lock(&pmc->powergates_lock);
> +		break;
> +	case POST_RATE_CHANGE:
> +		pmc->rate = data->new_rate;
> +		/* fall through */
> +	case ABORT_RATE_CHANGE:
> +		mutex_unlock(&pmc->powergates_lock);
> +		break;
> +	default:
> +		WARN_ON_ONCE(1);
> +		return notifier_from_errno(-EINVAL);
> +	}
> +
> +	return NOTIFY_OK;
> +}
> +
>  static int tegra_pmc_probe(struct platform_device *pdev)
>  {
>  	void __iomem *base;
> @@ -2082,6 +2104,23 @@ static int tegra_pmc_probe(struct platform_device *pdev)
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
>  	pmc->dev = &pdev->dev;
>  
>  	tegra_pmc_init(pmc);
> @@ -2133,6 +2172,8 @@ static int tegra_pmc_probe(struct platform_device *pdev)
>  cleanup_sysfs:
>  	device_remove_file(&pdev->dev, &dev_attr_reset_reason);
>  	device_remove_file(&pdev->dev, &dev_attr_reset_level);
> +	clk_notifier_unregister(pmc->clk, &pmc->clk_nb);
> +
>  	return err;
>  }
>  
> -- 
> 2.23.0
> 
