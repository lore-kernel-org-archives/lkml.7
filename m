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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0935AC432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 19:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFF4522466
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 19:33:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X+L5++4s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbfKSTdP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 14:33:15 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43484 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbfKSTdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 14:33:14 -0500
Received: by mail-lf1-f65.google.com with SMTP id l14so11406879lfh.10;
        Tue, 19 Nov 2019 11:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dzrCgwUpLqWb8RRoKvl9aYhAHfNi0y8XM9mLZkUuxzo=;
        b=X+L5++4sEVcsggN4mjN+1mx7L357ojcAHOlNIGq5DDZSw616bffq3756Uek6OQ3ik6
         npyRSvxx6UQ9kVqWUbQqYKn40MEVvPs9Yitj2413k95fUR8du+V/DtPUJzGLZo8zngyb
         jLzcwR+2/J+U71y8i28z0aJ234xRbfl1IoN0Ou24ktFu7SgsnV2p4aPLFCmEFy/4Ce7l
         l27lAF5vkRlXOQGCzbN5zoHiIEcFl0qEJqD1NLSv94ykkszDQD1v3ughTy/0lnUpHzdv
         J4NLAxes47DXlGqMSDbPonmJcp0wmkUgF+tCJU4YcG+5MaQIBLfWDa41ZNcOCEb5Ci8v
         yxAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dzrCgwUpLqWb8RRoKvl9aYhAHfNi0y8XM9mLZkUuxzo=;
        b=iIf2HxnqnVnnaAxFqvi6uNsMPA0ie6m9CgWebpBax4P273DnXLufaTH8lN1/tLc5vQ
         IvyYUgR5mmm/UHtVfc7oMY8yW6JhX6MYWmMFFJrNs/ZnofMYbdVwiXOKI+6Vx5D53cwD
         6pmFCPwHT/h1npNGCBkaiaUkbHjbzn9X8yesP9wVqGi55Bg6G9Xe6dGof9MOcQBB1CSa
         qgcwhYXRYp9G+bhO5WIBLI+Rq4BXpjgQseA17/nFODqRahCQD2pIj1mp5cgm8GLxKMbp
         QiJQwUMPfIYl2X/DyLUVEgFpSx05r52EyPIz2jFkx8uLEmWaPyFlnvGGtmP/80xwrwJK
         A1TQ==
X-Gm-Message-State: APjAAAXzvbEimQs5N6LUF0NntjaGlFMdZTZMyDb+/LJuVLI0AgLFVyCT
        cn+P928uBVj12mrcemWsJvvLUU+3
X-Google-Smtp-Source: APXvYqxkdZsjvMI6A5lE+RWVrIVp0EArmrWf1+M5kMxW5fKSUCZkKWCzcRatYyVC22MrJGpj+Z5SXw==
X-Received: by 2002:ac2:43c7:: with SMTP id u7mr3944397lfl.71.1574191989011;
        Tue, 19 Nov 2019 11:33:09 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id s27sm2456453lfc.31.2019.11.19.11.33.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Nov 2019 11:33:08 -0800 (PST)
Subject: Re: [PATCH v1 09/17] clk: tegra: Remove PMC base references from
 clock registration
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
 <1574146234-3871-10-git-send-email-skomatineni@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <3a6562a2-d107-314e-5ad6-283633c93cbf@gmail.com>
Date:   Tue, 19 Nov 2019 22:33:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <1574146234-3871-10-git-send-email-skomatineni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

19.11.2019 09:50, Sowjanya Komatineni пишет:
> Tegra clock driver uses helper functions from Tegra PMC driver.
> 
> This patch removes PMC base references from all clocks registration.
> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  drivers/clk/tegra/clk-pll.c              | 60 ++++++++++++++------------------
>  drivers/clk/tegra/clk-tegra-audio.c      |  4 +--
>  drivers/clk/tegra/clk-tegra-periph.c     |  8 ++---
>  drivers/clk/tegra/clk-tegra-super-gen4.c | 11 +++---
>  drivers/clk/tegra/clk-tegra114.c         | 33 ++++++++----------
>  drivers/clk/tegra/clk-tegra124.c         | 34 ++++++++----------
>  drivers/clk/tegra/clk-tegra20.c          |  6 ++--
>  drivers/clk/tegra/clk-tegra210.c         | 34 ++++++++----------
>  drivers/clk/tegra/clk-tegra30.c          | 19 +++++-----
>  drivers/clk/tegra/clk.h                  | 37 ++++++++------------
>  10 files changed, 108 insertions(+), 138 deletions(-)
> 
> diff --git a/drivers/clk/tegra/clk-pll.c b/drivers/clk/tegra/clk-pll.c
> index 4ae9e282e7be..6a9b4be8ef2a 100644
> --- a/drivers/clk/tegra/clk-pll.c
> +++ b/drivers/clk/tegra/clk-pll.c
> @@ -1801,7 +1801,7 @@ static void _clk_plle_tegra_init_parent(struct tegra_clk_pll *pll)
>  #endif
>  
>  static struct tegra_clk_pll *_tegra_init_pll(void __iomem *clk_base,
> -		void __iomem *pmc, struct tegra_clk_pll_params *pll_params,
> +		struct tegra_clk_pll_params *pll_params,
>  		spinlock_t *lock)
>  {
>  	struct tegra_clk_pll *pll;
> @@ -1811,7 +1811,6 @@ static struct tegra_clk_pll *_tegra_init_pll(void __iomem *clk_base,
>  		return ERR_PTR(-ENOMEM);
>  
>  	pll->clk_base = clk_base;
> -	pll->pmc = pmc;
>  
>  	pll->params = pll_params;
>  	pll->lock = lock;
> @@ -1852,8 +1851,8 @@ static struct clk *_tegra_clk_register_pll(struct tegra_clk_pll *pll,
>  }
>  
>  struct clk *tegra_clk_register_pll(const char *name, const char *parent_name,
> -		void __iomem *clk_base, void __iomem *pmc,
> -		unsigned long flags, struct tegra_clk_pll_params *pll_params,
> +		void __iomem *clk_base, unsigned long flags,
> +		struct tegra_clk_pll_params *pll_params,
>  		spinlock_t *lock)
>  {
>  	struct tegra_clk_pll *pll;
> @@ -1861,7 +1860,7 @@ struct clk *tegra_clk_register_pll(const char *name, const char *parent_name,
>  
>  	pll_params->flags |= TEGRA_PLL_BYPASS;
>  
> -	pll = _tegra_init_pll(clk_base, pmc, pll_params, lock);
> +	pll = _tegra_init_pll(clk_base, pll_params, lock);
>  	if (IS_ERR(pll))
>  		return ERR_CAST(pll);
>  
> @@ -1883,8 +1882,8 @@ static struct div_nmp pll_e_nmp = {
>  };
>  
>  struct clk *tegra_clk_register_plle(const char *name, const char *parent_name,
> -		void __iomem *clk_base, void __iomem *pmc,
> -		unsigned long flags, struct tegra_clk_pll_params *pll_params,
> +		void __iomem *clk_base, unsigned long flags,
> +		struct tegra_clk_pll_params *pll_params,
>  		spinlock_t *lock)
>  {
>  	struct tegra_clk_pll *pll;
> @@ -1895,7 +1894,7 @@ struct clk *tegra_clk_register_plle(const char *name, const char *parent_name,
>  	if (!pll_params->div_nmp)
>  		pll_params->div_nmp = &pll_e_nmp;
>  
> -	pll = _tegra_init_pll(clk_base, pmc, pll_params, lock);
> +	pll = _tegra_init_pll(clk_base, pll_params, lock);
>  	if (IS_ERR(pll))
>  		return ERR_CAST(pll);
>  
> @@ -1916,7 +1915,7 @@ struct clk *tegra_clk_register_pllu(const char *name, const char *parent_name,
>  
>  	pll_params->flags |= TEGRA_PLLU;
>  
> -	pll = _tegra_init_pll(clk_base, NULL, pll_params, lock);
> +	pll = _tegra_init_pll(clk_base, pll_params, lock);
>  	if (IS_ERR(pll))
>  		return ERR_CAST(pll);
>  
> @@ -1974,8 +1973,7 @@ static const struct clk_ops tegra_clk_pllu_tegra114_ops = {
>  };
>  
>  struct clk *tegra_clk_register_pllxc(const char *name, const char *parent_name,
> -			  void __iomem *clk_base, void __iomem *pmc,
> -			  unsigned long flags,
> +			  void __iomem *clk_base, unsigned long flags,
>  			  struct tegra_clk_pll_params *pll_params,
>  			  spinlock_t *lock)
>  {
> @@ -2025,7 +2023,7 @@ struct clk *tegra_clk_register_pllxc(const char *name, const char *parent_name,
>  		}
>  	}
>  
> -	pll = _tegra_init_pll(clk_base, pmc, pll_params, lock);
> +	pll = _tegra_init_pll(clk_base, pll_params, lock);
>  	if (IS_ERR(pll))
>  		return ERR_CAST(pll);
>  
> @@ -2038,8 +2036,7 @@ struct clk *tegra_clk_register_pllxc(const char *name, const char *parent_name,
>  }
>  
>  struct clk *tegra_clk_register_pllre(const char *name, const char *parent_name,
> -			  void __iomem *clk_base, void __iomem *pmc,
> -			  unsigned long flags,
> +			  void __iomem *clk_base, unsigned long flags,
>  			  struct tegra_clk_pll_params *pll_params,
>  			  spinlock_t *lock, unsigned long parent_rate)
>  {
> @@ -2053,7 +2050,7 @@ struct clk *tegra_clk_register_pllre(const char *name, const char *parent_name,
>  		pll_params->vco_min = pll_params->adjust_vco(pll_params,
>  							     parent_rate);
>  
> -	pll = _tegra_init_pll(clk_base, pmc, pll_params, lock);
> +	pll = _tegra_init_pll(clk_base, pll_params, lock);
>  	if (IS_ERR(pll))
>  		return ERR_CAST(pll);
>  
> @@ -2087,8 +2084,7 @@ struct clk *tegra_clk_register_pllre(const char *name, const char *parent_name,
>  }
>  
>  struct clk *tegra_clk_register_pllm(const char *name, const char *parent_name,
> -			  void __iomem *clk_base, void __iomem *pmc,
> -			  unsigned long flags,
> +			  void __iomem *clk_base, unsigned long flags,
>  			  struct tegra_clk_pll_params *pll_params,
>  			  spinlock_t *lock)
>  {
> @@ -2116,7 +2112,7 @@ struct clk *tegra_clk_register_pllm(const char *name, const char *parent_name,
>  
>  	pll_params->flags |= TEGRA_PLL_BYPASS;
>  	pll_params->flags |= TEGRA_PLLM;
> -	pll = _tegra_init_pll(clk_base, pmc, pll_params, lock);
> +	pll = _tegra_init_pll(clk_base, pll_params, lock);
>  	if (IS_ERR(pll))
>  		return ERR_CAST(pll);
>  
> @@ -2129,8 +2125,7 @@ struct clk *tegra_clk_register_pllm(const char *name, const char *parent_name,
>  }
>  
>  struct clk *tegra_clk_register_pllc(const char *name, const char *parent_name,
> -			  void __iomem *clk_base, void __iomem *pmc,
> -			  unsigned long flags,
> +			  void __iomem *clk_base, unsigned long flags,
>  			  struct tegra_clk_pll_params *pll_params,
>  			  spinlock_t *lock)
>  {
> @@ -2155,7 +2150,7 @@ struct clk *tegra_clk_register_pllc(const char *name, const char *parent_name,
>  	pll_params->vco_min = _clip_vco_min(pll_params->vco_min, parent_rate);
>  
>  	pll_params->flags |= TEGRA_PLL_BYPASS;
> -	pll = _tegra_init_pll(clk_base, pmc, pll_params, lock);
> +	pll = _tegra_init_pll(clk_base, pll_params, lock);
>  	if (IS_ERR(pll))
>  		return ERR_CAST(pll);
>  
> @@ -2211,7 +2206,7 @@ struct clk *tegra_clk_register_plle_tegra114(const char *name,
>  	struct tegra_clk_pll *pll;
>  	struct clk *clk;
>  
> -	pll = _tegra_init_pll(clk_base, NULL, pll_params, lock);
> +	pll = _tegra_init_pll(clk_base, pll_params, lock);
>  	if (IS_ERR(pll))
>  		return ERR_CAST(pll);
>  
> @@ -2236,7 +2231,7 @@ tegra_clk_register_pllu_tegra114(const char *name, const char *parent_name,
>  
>  	pll_params->flags |= TEGRA_PLLU;
>  
> -	pll = _tegra_init_pll(clk_base, NULL, pll_params, lock);
> +	pll = _tegra_init_pll(clk_base, pll_params, lock);
>  	if (IS_ERR(pll))
>  		return ERR_CAST(pll);
>  
> @@ -2282,7 +2277,7 @@ struct clk *tegra_clk_register_pllss(const char *name, const char *parent_name,
>  		return ERR_PTR(-EINVAL);
>  	}
>  
> -	pll = _tegra_init_pll(clk_base, NULL, pll_params, lock);
> +	pll = _tegra_init_pll(clk_base, pll_params, lock);
>  	if (IS_ERR(pll))
>  		return ERR_CAST(pll);
>  
> @@ -2344,7 +2339,7 @@ struct clk *tegra_clk_register_pllss(const char *name, const char *parent_name,
>  #if defined(CONFIG_ARCH_TEGRA_210_SOC)
>  struct clk *tegra_clk_register_pllre_tegra210(const char *name,
>  			  const char *parent_name, void __iomem *clk_base,
> -			  void __iomem *pmc, unsigned long flags,
> +			  unsigned long flags,
>  			  struct tegra_clk_pll_params *pll_params,
>  			  spinlock_t *lock, unsigned long parent_rate)
>  {
> @@ -2357,7 +2352,7 @@ struct clk *tegra_clk_register_pllre_tegra210(const char *name,
>  		pll_params->vco_min = pll_params->adjust_vco(pll_params,
>  							     parent_rate);
>  
> -	pll = _tegra_init_pll(clk_base, pmc, pll_params, lock);
> +	pll = _tegra_init_pll(clk_base, pll_params, lock);
>  	if (IS_ERR(pll))
>  		return ERR_CAST(pll);
>  
> @@ -2526,7 +2521,7 @@ struct clk *tegra_clk_register_plle_tegra210(const char *name,
>  	struct tegra_clk_pll *pll;
>  	struct clk *clk;
>  
> -	pll = _tegra_init_pll(clk_base, NULL, pll_params, lock);
> +	pll = _tegra_init_pll(clk_base, pll_params, lock);
>  	if (IS_ERR(pll))
>  		return ERR_CAST(pll);
>  
> @@ -2542,7 +2537,7 @@ struct clk *tegra_clk_register_plle_tegra210(const char *name,
>  
>  struct clk *tegra_clk_register_pllc_tegra210(const char *name,
>  			const char *parent_name, void __iomem *clk_base,
> -			void __iomem *pmc, unsigned long flags,
> +			unsigned long flags,
>  			struct tegra_clk_pll_params *pll_params,
>  			spinlock_t *lock)
>  {
> @@ -2570,7 +2565,7 @@ struct clk *tegra_clk_register_pllc_tegra210(const char *name,
>  							     parent_rate);
>  
>  	pll_params->flags |= TEGRA_PLL_BYPASS;
> -	pll = _tegra_init_pll(clk_base, pmc, pll_params, lock);
> +	pll = _tegra_init_pll(clk_base, pll_params, lock);
>  	if (IS_ERR(pll))
>  		return ERR_CAST(pll);
>  
> @@ -2618,7 +2613,7 @@ struct clk *tegra_clk_register_pllss_tegra210(const char *name,
>  							     parent_rate);
>  
>  	pll_params->flags |= TEGRA_PLL_BYPASS;
> -	pll = _tegra_init_pll(clk_base, NULL, pll_params, lock);
> +	pll = _tegra_init_pll(clk_base, pll_params, lock);
>  	if (IS_ERR(pll))
>  		return ERR_CAST(pll);
>  
> @@ -2632,8 +2627,7 @@ struct clk *tegra_clk_register_pllss_tegra210(const char *name,
>  }
>  
>  struct clk *tegra_clk_register_pllmb(const char *name, const char *parent_name,
> -			  void __iomem *clk_base, void __iomem *pmc,
> -			  unsigned long flags,
> +			  void __iomem *clk_base, unsigned long flags,
>  			  struct tegra_clk_pll_params *pll_params,
>  			  spinlock_t *lock)
>  {
> @@ -2661,7 +2655,7 @@ struct clk *tegra_clk_register_pllmb(const char *name, const char *parent_name,
>  
>  	pll_params->flags |= TEGRA_PLL_BYPASS;
>  	pll_params->flags |= TEGRA_PLLMB;
> -	pll = _tegra_init_pll(clk_base, pmc, pll_params, lock);
> +	pll = _tegra_init_pll(clk_base, pll_params, lock);
>  	if (IS_ERR(pll))
>  		return ERR_CAST(pll);
>  
> diff --git a/drivers/clk/tegra/clk-tegra-audio.c b/drivers/clk/tegra/clk-tegra-audio.c
> index c99e34d69711..1c813a7b89e7 100644
> --- a/drivers/clk/tegra/clk-tegra-audio.c
> +++ b/drivers/clk/tegra/clk-tegra-audio.c
> @@ -161,7 +161,7 @@ static void __init tegra_audio_sync_clk_init(void __iomem *clk_base,
>  }
>  
>  void __init tegra_audio_clk_init(void __iomem *clk_base,
> -			void __iomem *pmc_base, struct tegra_clk *tegra_clks,
> +			struct tegra_clk *tegra_clks,
>  			struct tegra_audio_clk_info *audio_info,
>  			unsigned int num_plls, unsigned long sync_max_rate)
>  {
> @@ -181,7 +181,7 @@ void __init tegra_audio_clk_init(void __iomem *clk_base,
>  		dt_clk = tegra_lookup_dt_id(info->clk_id, tegra_clks);
>  		if (dt_clk) {
>  			clk = tegra_clk_register_pll(info->name, info->parent,
> -					clk_base, pmc_base, 0, info->pll_params,
> +					clk_base, 0, info->pll_params,
>  					NULL);
>  			*dt_clk = clk;
>  		}
> diff --git a/drivers/clk/tegra/clk-tegra-periph.c b/drivers/clk/tegra/clk-tegra-periph.c
> index 0d07c0ba49b6..e2979b972526 100644
> --- a/drivers/clk/tegra/clk-tegra-periph.c
> +++ b/drivers/clk/tegra/clk-tegra-periph.c
> @@ -936,7 +936,7 @@ static void __init div_clk_init(void __iomem *clk_base,
>  	}
>  }
>  
> -static void __init init_pllp(void __iomem *clk_base, void __iomem *pmc_base,
> +static void __init init_pllp(void __iomem *clk_base,
>  				struct tegra_clk *tegra_clks,
>  				struct tegra_clk_pll_params *pll_params)
>  {
> @@ -948,7 +948,7 @@ static void __init init_pllp(void __iomem *clk_base, void __iomem *pmc_base,
>  	if (dt_clk) {
>  		/* PLLP */
>  		clk = tegra_clk_register_pll("pll_p", "pll_ref", clk_base,
> -					pmc_base, 0, pll_params, NULL);
> +					     0, pll_params, NULL);
>  		clk_register_clkdev(clk, "pll_p", NULL);
>  		*dt_clk = clk;
>  	}
> @@ -1020,10 +1020,10 @@ static void __init init_pllp(void __iomem *clk_base, void __iomem *pmc_base,
>  }
>  
>  void __init tegra_periph_clk_init(void __iomem *clk_base,
> -			void __iomem *pmc_base, struct tegra_clk *tegra_clks,
> +			struct tegra_clk *tegra_clks,
>  			struct tegra_clk_pll_params *pll_params)
>  {
> -	init_pllp(clk_base, pmc_base, tegra_clks, pll_params);
> +	init_pllp(clk_base, tegra_clks, pll_params);
>  	periph_clk_init(clk_base, tegra_clks);
>  	gate_clk_init(clk_base, tegra_clks);
>  	div_clk_init(clk_base, tegra_clks);
> diff --git a/drivers/clk/tegra/clk-tegra-super-gen4.c b/drivers/clk/tegra/clk-tegra-super-gen4.c
> index 5760c978bef7..26c9bc606228 100644
> --- a/drivers/clk/tegra/clk-tegra-super-gen4.c
> +++ b/drivers/clk/tegra/clk-tegra-super-gen4.c
> @@ -163,7 +163,6 @@ static void __init tegra_sclk_init(void __iomem *clk_base,
>  }
>  
>  static void __init tegra_super_clk_init(void __iomem *clk_base,
> -				void __iomem *pmc_base,
>  				struct tegra_clk *tegra_clks,
>  				struct tegra_clk_pll_params *params,
>  				const struct tegra_super_gen_info *gen_info)
> @@ -231,11 +230,11 @@ static void __init tegra_super_clk_init(void __iomem *clk_base,
>  #if defined(CONFIG_ARCH_TEGRA_210_SOC)
>  	if (gen_info->gen == gen5)
>  		clk = tegra_clk_register_pllc_tegra210("pll_x", "pll_ref",
> -			clk_base, pmc_base, CLK_IGNORE_UNUSED, params, NULL);
> +			clk_base, CLK_IGNORE_UNUSED, params, NULL);
>  	else
>  #endif
>  		clk = tegra_clk_register_pllxc("pll_x", "pll_ref", clk_base,
> -				pmc_base, CLK_IGNORE_UNUSED, params, NULL);
> +				CLK_IGNORE_UNUSED, params, NULL);
>  
>  	*dt_clk = clk;
>  
> @@ -251,19 +250,17 @@ static void __init tegra_super_clk_init(void __iomem *clk_base,
>  }
>  
>  void __init tegra_super_clk_gen4_init(void __iomem *clk_base,
> -				void __iomem *pmc_base,
>  				struct tegra_clk *tegra_clks,
>  				struct tegra_clk_pll_params *params)
>  {
> -	tegra_super_clk_init(clk_base, pmc_base, tegra_clks, params,
> +	tegra_super_clk_init(clk_base, tegra_clks, params,
>  			     &tegra_super_gen_info_gen4);
>  }
>  
>  void __init tegra_super_clk_gen5_init(void __iomem *clk_base,
> -				void __iomem *pmc_base,
>  				struct tegra_clk *tegra_clks,
>  				struct tegra_clk_pll_params *params)
>  {
> -	tegra_super_clk_init(clk_base, pmc_base, tegra_clks, params,
> +	tegra_super_clk_init(clk_base, tegra_clks, params,
>  			     &tegra_super_gen_info_gen5);
>  }
> diff --git a/drivers/clk/tegra/clk-tegra114.c b/drivers/clk/tegra/clk-tegra114.c
> index 77904334b6f0..e7c4af928da3 100644
> --- a/drivers/clk/tegra/clk-tegra114.c
> +++ b/drivers/clk/tegra/clk-tegra114.c
> @@ -904,14 +904,13 @@ static void __init tegra114_fixed_clk_init(void __iomem *clk_base)
>  
>  }
>  
> -static void __init tegra114_pll_init(void __iomem *clk_base,
> -				     void __iomem *pmc)
> +static void __init tegra114_pll_init(void __iomem *clk_base)
>  {
>  	struct clk *clk;
>  
>  	/* PLLC */
>  	clk = tegra_clk_register_pllxc("pll_c", "pll_ref", clk_base,
> -			pmc, 0, &pll_c_params, NULL);
> +				       0, &pll_c_params, NULL);
>  	clks[TEGRA114_CLK_PLL_C] = clk;
>  
>  	/* PLLC_OUT1 */
> @@ -924,17 +923,17 @@ static void __init tegra114_pll_init(void __iomem *clk_base,
>  	clks[TEGRA114_CLK_PLL_C_OUT1] = clk;
>  
>  	/* PLLC2 */
> -	clk = tegra_clk_register_pllc("pll_c2", "pll_ref", clk_base, pmc, 0,
> +	clk = tegra_clk_register_pllc("pll_c2", "pll_ref", clk_base, 0,
>  			     &pll_c2_params, NULL);
>  	clks[TEGRA114_CLK_PLL_C2] = clk;
>  
>  	/* PLLC3 */
> -	clk = tegra_clk_register_pllc("pll_c3", "pll_ref", clk_base, pmc, 0,
> +	clk = tegra_clk_register_pllc("pll_c3", "pll_ref", clk_base, 0,
>  			     &pll_c3_params, NULL);
>  	clks[TEGRA114_CLK_PLL_C3] = clk;
>  
>  	/* PLLM */
> -	clk = tegra_clk_register_pllm("pll_m", "pll_ref", clk_base, pmc,
> +	clk = tegra_clk_register_pllm("pll_m", "pll_ref", clk_base,
>  			     CLK_SET_RATE_GATE, &pll_m_params, NULL);
>  	clks[TEGRA114_CLK_PLL_M] = clk;
>  
> @@ -978,7 +977,7 @@ static void __init tegra114_pll_init(void __iomem *clk_base,
>  	clks[TEGRA114_CLK_PLL_U_12M] = clk;
>  
>  	/* PLLD */
> -	clk = tegra_clk_register_pll("pll_d", "pll_ref", clk_base, pmc, 0,
> +	clk = tegra_clk_register_pll("pll_d", "pll_ref", clk_base, 0,
>  			    &pll_d_params, &pll_d_lock);
>  	clks[TEGRA114_CLK_PLL_D] = clk;
>  
> @@ -988,7 +987,7 @@ static void __init tegra114_pll_init(void __iomem *clk_base,
>  	clks[TEGRA114_CLK_PLL_D_OUT0] = clk;
>  
>  	/* PLLD2 */
> -	clk = tegra_clk_register_pll("pll_d2", "pll_ref", clk_base, pmc, 0,
> +	clk = tegra_clk_register_pll("pll_d2", "pll_ref", clk_base, 0,
>  			    &pll_d2_params, &pll_d2_lock);
>  	clks[TEGRA114_CLK_PLL_D2] = clk;
>  
> @@ -998,7 +997,7 @@ static void __init tegra114_pll_init(void __iomem *clk_base,
>  	clks[TEGRA114_CLK_PLL_D2_OUT0] = clk;
>  
>  	/* PLLRE */
> -	clk = tegra_clk_register_pllre("pll_re_vco", "pll_ref", clk_base, pmc,
> +	clk = tegra_clk_register_pllre("pll_re_vco", "pll_ref", clk_base,
>  			     0, &pll_re_vco_params, &pll_re_lock, pll_ref_freq);
>  	clks[TEGRA114_CLK_PLL_RE_VCO] = clk;
>  
> @@ -1019,8 +1018,7 @@ static struct tegra_periph_init_data tegra_periph_clk_list[] = {
>  	MUX8("vi_sensor", mux_pllm_pllc2_c_c3_pllp_plla, CLK_SOURCE_VI_SENSOR, 20, TEGRA_PERIPH_NO_RESET, TEGRA114_CLK_VI_SENSOR),
>  };
>  
> -static __init void tegra114_periph_clk_init(void __iomem *clk_base,
> -					    void __iomem *pmc_base)
> +static __init void tegra114_periph_clk_init(void __iomem *clk_base)
>  {
>  	struct clk *clk;
>  	struct tegra_periph_init_data *data;
> @@ -1075,8 +1073,7 @@ static __init void tegra114_periph_clk_init(void __iomem *clk_base,
>  		clks[data->clk_id] = clk;
>  	}
>  
> -	tegra_periph_clk_init(clk_base, pmc_base, tegra114_clks,
> -				&pll_p_params);
> +	tegra_periph_clk_init(clk_base, tegra114_clks, &pll_p_params);
>  }
>  
>  /* Tegra114 CPU clock and reset control functions */
> @@ -1345,14 +1342,12 @@ static void __init tegra114_clock_init(struct device_node *np)
>  		return;
>  
>  	tegra114_fixed_clk_init(clk_base);
> -	tegra114_pll_init(clk_base, pmc_base);
> -	tegra114_periph_clk_init(clk_base, pmc_base);
> -	tegra_audio_clk_init(clk_base, pmc_base, tegra114_clks,
> -			     tegra114_audio_plls,
> +	tegra114_pll_init(clk_base);
> +	tegra114_periph_clk_init(clk_base);
> +	tegra_audio_clk_init(clk_base, tegra114_clks, tegra114_audio_plls,
>  			     ARRAY_SIZE(tegra114_audio_plls), 24000000);
>  	tegra_pmc_clk_init(pmc_base, tegra114_clks);
> -	tegra_super_clk_gen4_init(clk_base, pmc_base, tegra114_clks,
> -					&pll_x_params);
> +	tegra_super_clk_gen4_init(clk_base, tegra114_clks, &pll_x_params);
>  
>  	tegra_add_of_provider(np, of_clk_src_onecell_get);
>  	tegra_register_devclks(devclks, ARRAY_SIZE(devclks));
> diff --git a/drivers/clk/tegra/clk-tegra124.c b/drivers/clk/tegra/clk-tegra124.c
> index 010daac53ea7..0b7532857a58 100644
> --- a/drivers/clk/tegra/clk-tegra124.c
> +++ b/drivers/clk/tegra/clk-tegra124.c
> @@ -1019,8 +1019,7 @@ static struct tegra_periph_init_data tegra124_periph[] = {
>  
>  static struct clk **clks;
>  
> -static __init void tegra124_periph_clk_init(void __iomem *clk_base,
> -					    void __iomem *pmc_base)
> +static __init void tegra124_periph_clk_init(void __iomem *clk_base)
>  {
>  	struct clk *clk;
>  	unsigned int i;
> @@ -1078,17 +1077,16 @@ static __init void tegra124_periph_clk_init(void __iomem *clk_base,
>  		*clkp = clk;
>  	}
>  
> -	tegra_periph_clk_init(clk_base, pmc_base, tegra124_clks, &pll_p_params);
> +	tegra_periph_clk_init(clk_base, tegra124_clks, &pll_p_params);
>  }
>  
> -static void __init tegra124_pll_init(void __iomem *clk_base,
> -				     void __iomem *pmc)
> +static void __init tegra124_pll_init(void __iomem *clk_base)
>  {
>  	struct clk *clk;
>  
>  	/* PLLC */
>  	clk = tegra_clk_register_pllxc("pll_c", "pll_ref", clk_base,
> -			pmc, 0, &pll_c_params, NULL);
> +				       0, &pll_c_params, NULL);
>  	clk_register_clkdev(clk, "pll_c", NULL);
>  	clks[TEGRA124_CLK_PLL_C] = clk;
>  
> @@ -1109,19 +1107,19 @@ static void __init tegra124_pll_init(void __iomem *clk_base,
>  	clks[TEGRA124_CLK_PLL_C_UD] = clk;
>  
>  	/* PLLC2 */
> -	clk = tegra_clk_register_pllc("pll_c2", "pll_ref", clk_base, pmc, 0,
> +	clk = tegra_clk_register_pllc("pll_c2", "pll_ref", clk_base, 0,
>  			     &pll_c2_params, NULL);
>  	clk_register_clkdev(clk, "pll_c2", NULL);
>  	clks[TEGRA124_CLK_PLL_C2] = clk;
>  
>  	/* PLLC3 */
> -	clk = tegra_clk_register_pllc("pll_c3", "pll_ref", clk_base, pmc, 0,
> +	clk = tegra_clk_register_pllc("pll_c3", "pll_ref", clk_base, 0,
>  			     &pll_c3_params, NULL);
>  	clk_register_clkdev(clk, "pll_c3", NULL);
>  	clks[TEGRA124_CLK_PLL_C3] = clk;
>  
>  	/* PLLM */
> -	clk = tegra_clk_register_pllm("pll_m", "pll_ref", clk_base, pmc,
> +	clk = tegra_clk_register_pllm("pll_m", "pll_ref", clk_base,
>  			     CLK_SET_RATE_GATE, &pll_m_params, NULL);
>  	clk_register_clkdev(clk, "pll_m", NULL);
>  	clks[TEGRA124_CLK_PLL_M] = clk;
> @@ -1174,7 +1172,7 @@ static void __init tegra124_pll_init(void __iomem *clk_base,
>  	clks[TEGRA124_CLK_PLL_U_12M] = clk;
>  
>  	/* PLLD */
> -	clk = tegra_clk_register_pll("pll_d", "pll_ref", clk_base, pmc, 0,
> +	clk = tegra_clk_register_pll("pll_d", "pll_ref", clk_base, 0,
>  			    &pll_d_params, &pll_d_lock);
>  	clk_register_clkdev(clk, "pll_d", NULL);
>  	clks[TEGRA124_CLK_PLL_D] = clk;
> @@ -1186,7 +1184,7 @@ static void __init tegra124_pll_init(void __iomem *clk_base,
>  	clks[TEGRA124_CLK_PLL_D_OUT0] = clk;
>  
>  	/* PLLRE */
> -	clk = tegra_clk_register_pllre("pll_re_vco", "pll_ref", clk_base, pmc,
> +	clk = tegra_clk_register_pllre("pll_re_vco", "pll_ref", clk_base,
>  			     0, &pll_re_vco_params, &pll_re_lock, pll_ref_freq);
>  	clk_register_clkdev(clk, "pll_re_vco", NULL);
>  	clks[TEGRA124_CLK_PLL_RE_VCO] = clk;
> @@ -1491,10 +1489,9 @@ static void __init tegra124_132_clock_init_pre(struct device_node *np)
>  		return;
>  
>  	tegra_fixed_clk_init(tegra124_clks);
> -	tegra124_pll_init(clk_base, pmc_base);
> -	tegra124_periph_clk_init(clk_base, pmc_base);
> -	tegra_audio_clk_init(clk_base, pmc_base, tegra124_clks,
> -			     tegra124_audio_plls,
> +	tegra124_pll_init(clk_base);
> +	tegra124_periph_clk_init(clk_base);
> +	tegra_audio_clk_init(clk_base, tegra124_clks, tegra124_audio_plls,
>  			     ARRAY_SIZE(tegra124_audio_plls), 24576000);
>  	tegra_pmc_clk_init(pmc_base, tegra124_clks);
>  
> @@ -1511,13 +1508,12 @@ static void __init tegra124_132_clock_init_pre(struct device_node *np)
>   * Register most of the along with a few clocks controlled by the PMC
>   * IP block.  Everything in this function should be common to Tegra124
>   * and Tegra132.  This function must be called after
> - * tegra124_132_clock_init_pre(), otherwise clk_base and pmc_base will
> - * not be set.  No return value.
> + * tegra124_132_clock_init_pre(), otherwise clk_base will not be set.
> + * No return value.
>   */
>  static void __init tegra124_132_clock_init_post(struct device_node *np)
>  {
> -	tegra_super_clk_gen4_init(clk_base, pmc_base, tegra124_clks,
> -				  &pll_x_params);
> +	tegra_super_clk_gen4_init(clk_base, tegra124_clks, &pll_x_params);
>  	tegra_init_special_resets(1, tegra124_reset_assert,
>  				  tegra124_reset_deassert);
>  	tegra_add_of_provider(np, of_clk_src_onecell_get);
> diff --git a/drivers/clk/tegra/clk-tegra20.c b/drivers/clk/tegra/clk-tegra20.c
> index 4d8222f5c638..5cf33c99976d 100644
> --- a/drivers/clk/tegra/clk-tegra20.c
> +++ b/drivers/clk/tegra/clk-tegra20.c
> @@ -687,7 +687,7 @@ static void tegra20_pll_init(void)
>  	clks[TEGRA20_CLK_PLL_A_OUT0] = clk;
>  
>  	/* PLLE */
> -	clk = tegra_clk_register_plle("pll_e", "pll_ref", clk_base, pmc_base,
> +	clk = tegra_clk_register_plle("pll_e", "pll_ref", clk_base,
>  			     0, &pll_e_params, NULL);
>  	clks[TEGRA20_CLK_PLL_E] = clk;
>  }
> @@ -853,7 +853,7 @@ static void __init tegra20_periph_clk_init(void)
>  		clks[data->clk_id] = clk;
>  	}
>  
> -	tegra_periph_clk_init(clk_base, pmc_base, tegra20_clks, &pll_p_params);
> +	tegra_periph_clk_init(clk_base, tegra20_clks, &pll_p_params);
>  }
>  
>  static void __init tegra20_osc_clk_init(void)
> @@ -1145,7 +1145,7 @@ static void __init tegra20_clock_init(struct device_node *np)
>  	tegra_fixed_clk_init(tegra20_clks);
>  	tegra20_pll_init();
>  	tegra20_super_clk_init();
> -	tegra_super_clk_gen4_init(clk_base, pmc_base, tegra20_clks, NULL);
> +	tegra_super_clk_gen4_init(clk_base, tegra20_clks, NULL);
>  	tegra20_periph_clk_init();
>  	tegra20_audio_clk_init();
>  	tegra_pmc_clk_init(pmc_base, tegra20_clks);
> diff --git a/drivers/clk/tegra/clk-tegra210.c b/drivers/clk/tegra/clk-tegra210.c
> index 63f8a778821f..86d0b847be0d 100644
> --- a/drivers/clk/tegra/clk-tegra210.c
> +++ b/drivers/clk/tegra/clk-tegra210.c
> @@ -2993,8 +2993,7 @@ static const char * const la_parents[] = {
>  static struct tegra_clk_periph tegra210_la =
>  	TEGRA_CLK_PERIPH(29, 7, 9, 0, 8, 1, TEGRA_DIVIDER_ROUND_UP, 76, 0, NULL, 0);
>  
> -static __init void tegra210_periph_clk_init(void __iomem *clk_base,
> -					    void __iomem *pmc_base)
> +static __init void tegra210_periph_clk_init(void __iomem *clk_base)
>  {
>  	struct clk *clk;
>  	unsigned int i;
> @@ -3090,17 +3089,16 @@ static __init void tegra210_periph_clk_init(void __iomem *clk_base,
>  		*clkp = clk;
>  	}
>  
> -	tegra_periph_clk_init(clk_base, pmc_base, tegra210_clks, &pll_p_params);
> +	tegra_periph_clk_init(clk_base, tegra210_clks, &pll_p_params);
>  }
>  
> -static void __init tegra210_pll_init(void __iomem *clk_base,
> -				     void __iomem *pmc)
> +static void __init tegra210_pll_init(void __iomem *clk_base)
>  {
>  	struct clk *clk;
>  
>  	/* PLLC */
>  	clk = tegra_clk_register_pllc_tegra210("pll_c", "pll_ref", clk_base,
> -			pmc, 0, &pll_c_params, NULL);
> +					       0, &pll_c_params, NULL);
>  	if (!WARN_ON(IS_ERR(clk)))
>  		clk_register_clkdev(clk, "pll_c", NULL);
>  	clks[TEGRA210_CLK_PLL_C] = clk;
> @@ -3123,24 +3121,24 @@ static void __init tegra210_pll_init(void __iomem *clk_base,
>  
>  	/* PLLC2 */
>  	clk = tegra_clk_register_pllc_tegra210("pll_c2", "pll_ref", clk_base,
> -			     pmc, 0, &pll_c2_params, NULL);
> +					       0, &pll_c2_params, NULL);
>  	clk_register_clkdev(clk, "pll_c2", NULL);
>  	clks[TEGRA210_CLK_PLL_C2] = clk;
>  
>  	/* PLLC3 */
>  	clk = tegra_clk_register_pllc_tegra210("pll_c3", "pll_ref", clk_base,
> -			     pmc, 0, &pll_c3_params, NULL);
> +					       0, &pll_c3_params, NULL);
>  	clk_register_clkdev(clk, "pll_c3", NULL);
>  	clks[TEGRA210_CLK_PLL_C3] = clk;
>  
>  	/* PLLM */
> -	clk = tegra_clk_register_pllm("pll_m", "osc", clk_base, pmc,
> +	clk = tegra_clk_register_pllm("pll_m", "osc", clk_base,
>  			     CLK_SET_RATE_GATE, &pll_m_params, NULL);
>  	clk_register_clkdev(clk, "pll_m", NULL);
>  	clks[TEGRA210_CLK_PLL_M] = clk;
>  
>  	/* PLLMB */
> -	clk = tegra_clk_register_pllmb("pll_mb", "osc", clk_base, pmc,
> +	clk = tegra_clk_register_pllmb("pll_mb", "osc", clk_base,
>  			     CLK_SET_RATE_GATE, &pll_mb_params, NULL);
>  	clk_register_clkdev(clk, "pll_mb", NULL);
>  	clks[TEGRA210_CLK_PLL_MB] = clk;
> @@ -3210,7 +3208,7 @@ static void __init tegra210_pll_init(void __iomem *clk_base,
>  	clks[TEGRA210_CLK_PLL_U_48M] = clk;
>  
>  	/* PLLD */
> -	clk = tegra_clk_register_pll("pll_d", "pll_ref", clk_base, pmc, 0,
> +	clk = tegra_clk_register_pll("pll_d", "pll_ref", clk_base, 0,
>  			    &pll_d_params, &pll_d_lock);
>  	clk_register_clkdev(clk, "pll_d", NULL);
>  	clks[TEGRA210_CLK_PLL_D] = clk;
> @@ -3223,7 +3221,7 @@ static void __init tegra210_pll_init(void __iomem *clk_base,
>  
>  	/* PLLRE */
>  	clk = tegra_clk_register_pllre_tegra210("pll_re_vco", "pll_ref",
> -						clk_base, pmc, 0,
> +						clk_base, 0,
>  						&pll_re_vco_params,
>  						&pll_re_lock, pll_ref_freq);
>  	clk_register_clkdev(clk, "pll_re_vco", NULL);
> @@ -3251,7 +3249,7 @@ static void __init tegra210_pll_init(void __iomem *clk_base,
>  	clks[TEGRA210_CLK_PLL_E] = clk;
>  
>  	/* PLLC4 */
> -	clk = tegra_clk_register_pllre("pll_c4_vco", "pll_ref", clk_base, pmc,
> +	clk = tegra_clk_register_pllre("pll_c4_vco", "pll_ref", clk_base,
>  			     0, &pll_c4_vco_params, NULL, pll_ref_freq);
>  	clk_register_clkdev(clk, "pll_c4_vco", NULL);
>  	clks[TEGRA210_CLK_PLL_C4] = clk;
> @@ -3680,10 +3678,9 @@ static void __init tegra210_clock_init(struct device_node *np)
>  		return;
>  
>  	tegra_fixed_clk_init(tegra210_clks);
> -	tegra210_pll_init(clk_base, pmc_base);
> -	tegra210_periph_clk_init(clk_base, pmc_base);
> -	tegra_audio_clk_init(clk_base, pmc_base, tegra210_clks,
> -			     tegra210_audio_plls,
> +	tegra210_pll_init(clk_base);
> +	tegra210_periph_clk_init(clk_base);
> +	tegra_audio_clk_init(clk_base, tegra210_clks, tegra210_audio_plls,
>  			     ARRAY_SIZE(tegra210_audio_plls), 24576000);
>  	tegra_pmc_clk_init(pmc_base, tegra210_clks);
>  
> @@ -3694,8 +3691,7 @@ static void __init tegra210_clock_init(struct device_node *np)
>  
>  	tegra_clk_apply_init_table = tegra210_clock_apply_init_table;
>  
> -	tegra_super_clk_gen5_init(clk_base, pmc_base, tegra210_clks,
> -				  &pll_x_params);
> +	tegra_super_clk_gen5_init(clk_base, tegra210_clks, &pll_x_params);
>  	tegra_init_special_resets(2, tegra210_reset_assert,
>  				  tegra210_reset_deassert);
>  
> diff --git a/drivers/clk/tegra/clk-tegra30.c b/drivers/clk/tegra/clk-tegra30.c
> index e3b64c66acdc..d65e7edf0cfd 100644
> --- a/drivers/clk/tegra/clk-tegra30.c
> +++ b/drivers/clk/tegra/clk-tegra30.c
> @@ -809,7 +809,7 @@ static void __init tegra30_pll_init(void)
>  	struct clk *clk;
>  
>  	/* PLLC */
> -	clk = tegra_clk_register_pll("pll_c", "pll_ref", clk_base, pmc_base, 0,
> +	clk = tegra_clk_register_pll("pll_c", "pll_ref", clk_base, 0,
>  				     &pll_c_params, NULL);
>  	clks[TEGRA30_CLK_PLL_C] = clk;
>  
> @@ -823,7 +823,7 @@ static void __init tegra30_pll_init(void)
>  	clks[TEGRA30_CLK_PLL_C_OUT1] = clk;
>  
>  	/* PLLM */
> -	clk = tegra_clk_register_pll("pll_m", "pll_ref", clk_base, pmc_base,
> +	clk = tegra_clk_register_pll("pll_m", "pll_ref", clk_base,
>  			    CLK_SET_RATE_GATE, &pll_m_params, NULL);
>  	clks[TEGRA30_CLK_PLL_M] = clk;
>  
> @@ -837,7 +837,7 @@ static void __init tegra30_pll_init(void)
>  	clks[TEGRA30_CLK_PLL_M_OUT1] = clk;
>  
>  	/* PLLX */
> -	clk = tegra_clk_register_pll("pll_x", "pll_ref", clk_base, pmc_base, 0,
> +	clk = tegra_clk_register_pll("pll_x", "pll_ref", clk_base, 0,
>  			    &pll_x_params, NULL);
>  	clks[TEGRA30_CLK_PLL_X] = clk;
>  
> @@ -852,7 +852,7 @@ static void __init tegra30_pll_init(void)
>  	clks[TEGRA30_CLK_PLL_U] = clk;
>  
>  	/* PLLD */
> -	clk = tegra_clk_register_pll("pll_d", "pll_ref", clk_base, pmc_base, 0,
> +	clk = tegra_clk_register_pll("pll_d", "pll_ref", clk_base, 0,
>  			    &pll_d_params, &pll_d_lock);
>  	clks[TEGRA30_CLK_PLL_D] = clk;
>  
> @@ -862,7 +862,7 @@ static void __init tegra30_pll_init(void)
>  	clks[TEGRA30_CLK_PLL_D_OUT0] = clk;
>  
>  	/* PLLD2 */
> -	clk = tegra_clk_register_pll("pll_d2", "pll_ref", clk_base, pmc_base, 0,
> +	clk = tegra_clk_register_pll("pll_d2", "pll_ref", clk_base, 0,
>  			    &pll_d2_params, NULL);
>  	clks[TEGRA30_CLK_PLL_D2] = clk;

Same needs to be done for clk-tegra20.c:

drivers/clk/tegra/clk-tegra20.c:627:61: note: in expansion of macro ‘NULL’
  627 |  clk = tegra_clk_register_pll("pll_c", "pll_ref", clk_base, NULL, 0,
      |                                                             ^~~~
In file included from drivers/clk/tegra/clk-tegra20.c:15:
drivers/clk/tegra/clk.h:392:13: note: expected ‘long unsigned int’ but
argument is of type ‘void *’
  392 | struct clk *tegra_clk_register_pll(const char *name, const char
*parent_name,
      |             ^~~~~~~~~~~~~~~~~~~~~~
drivers/clk/tegra/clk-tegra20.c:628:8: error: passing argument 6 of
‘tegra_clk_register_pll’ from incompatible pointer type
[-Werror=incompatible-pointer-types]
  628 |        &pll_c_params, NULL);

>  
> @@ -876,7 +876,7 @@ static void __init tegra30_pll_init(void)
>  			       ARRAY_SIZE(pll_e_parents),
>  			       CLK_SET_RATE_NO_REPARENT,
>  			       clk_base + PLLE_AUX, 2, 1, 0, NULL);
> -	clk = tegra_clk_register_plle("pll_e", "pll_e_mux", clk_base, pmc_base,
> +	clk = tegra_clk_register_plle("pll_e", "pll_e_mux", clk_base

Comma is missed:

drivers/clk/tegra/clk-tegra30.c: In function ‘tegra30_pll_init’:
drivers/clk/tegra/clk-tegra30.c:872:54: error: called object ‘clk_base’
is not a function or function pointer
  872 |  clk = tegra_clk_register_plle("pll_e", "pll_e_mux", clk_base

[snip]
