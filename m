Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E3FC10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 15:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E1C7217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 15:46:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="df8q7He9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728613AbfDWPqI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 11:46:08 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44272 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728404AbfDWPqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 11:46:07 -0400
Received: by mail-pl1-f194.google.com with SMTP id y12so5154421plk.11;
        Tue, 23 Apr 2019 08:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ss4coKP3/fly6lpyjZfRsj5hHm8V32Xxuy/8hmJjsSQ=;
        b=df8q7He9B3mzZfzmiV89fsyvBR/hxPZJomPPUMV9BQnhESNRVrhK6HUaWUHvOmHgI2
         +IOvCFwSkFt2xAvLQXONzT8+m0kjYNS72d8PEbiTXfNnno18GTz4cnx4EdOdH0IfLbJC
         wDw5ubNSDgum2B6XvBEa6eqqQbjn54eTI5pyC2edVKd/Qz2JTMwykk2HC6oUnKysS7HH
         ZQaqRw4KpD0CU5X8qGuDJS2/xTFzVE7nc7ree5Q4OQX85Li6F69hcf2wGnANj7sPyGQq
         Bairsvql8CUBUF95pLKH1uKOW61I0HtSYm2krWvndt9DDnYh8g8mtOyOV8hAYdOvO01F
         hJlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ss4coKP3/fly6lpyjZfRsj5hHm8V32Xxuy/8hmJjsSQ=;
        b=sGaD80FMo45QGj/VKPDQJKx0LJZMA9aTPG3yachU7aNyXI+tPMprIFzGq9c2GLn6eG
         nrIkuA8bgXADjvgQRwOgu+02Kl/aVgovVS5jl/RD8gnFzE+NCFAj5KPYFEPIDHwf+peW
         /GkXsJOOS3LRTyKmFJeDg/jXDKoAHELB3LNmtdBSCjWDcaXTajIkFvzlc0lLw+yfDMag
         wHivYcWCtnGqK3rZd329Bkyo9513bS+UMKvC+8x+mhltFKMxpbrMdezgR8+YHAcEu8Ma
         4q6kHKo48afp9DNey3i+trwaDGYm5C5Fk5AndgpiIygqZFMVhav8m+UtT2jbfRSkFE70
         CL3w==
X-Gm-Message-State: APjAAAXpkSnMrpRkpROfFRSiC/XqcyPM0UzgzHIFbLtnXhFG5DjQlACR
        ZbA30/dhdMx97Tw+2W6DbfufxPSK
X-Google-Smtp-Source: APXvYqwf9Q/RuzYDz7BqoHp7SgsiIlvB2mOv3cR560S44h1Amp8YvZpZ49IMcPRpuZGU7pFAEOO0WA==
X-Received: by 2002:a17:902:e183:: with SMTP id cd3mr27035538plb.233.1556034366450;
        Tue, 23 Apr 2019 08:46:06 -0700 (PDT)
Received: from localhost.localdomain ([2601:644:8201:32e0:7256:81ff:febd:926d])
        by smtp.gmail.com with ESMTPSA id u188sm1923377pfb.37.2019.04.23.08.46.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 08:46:05 -0700 (PDT)
Date:   Tue, 23 Apr 2019 08:46:03 -0700
From:   Eduardo Valentin <edubezval@gmail.com>
To:     Wei Ni <wni@nvidia.com>
Cc:     daniel.lezcano@linaro.org, robh@kernel.org,
        thierry.reding@gmail.com, linux-tegra@vger.kernel.org,
        rui.zhang@intel.com, srikars@nvidia.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 12/12] thermal: tegra: enable OC hw throttle
Message-ID: <20190423154602.GB16014@localhost.localdomain>
References: <1550744327-4677-1-git-send-email-wni@nvidia.com>
 <1550744327-4677-13-git-send-email-wni@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550744327-4677-13-git-send-email-wni@nvidia.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 06:18:47PM +0800, Wei Ni wrote:
> Parse Over Current settings from DT and program them to
> generate interrupts. Also enable hw throttling whenever
> there are OC events. Log the OC events as debug messages.
> 
> Signed-off-by: Wei Ni <wni@nvidia.com>

I applied this series except for this specific patch which:
a. does not apply clean
b. does not compile.

Please rebase on top of my -linus branch and resend this. remember to 
checkpatch and compile and boot test before sending.

> ---
>  drivers/thermal/tegra/soctherm.c | 130 ++++++++++++++++++++++++++++++++++++---
>  1 file changed, 120 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
> index b8c66368e54e..6e3f329d1ac4 100644
> --- a/drivers/thermal/tegra/soctherm.c
> +++ b/drivers/thermal/tegra/soctherm.c
> @@ -106,9 +106,26 @@
>  #define STATS_CTL_CLR_UP			0x2
>  #define STATS_CTL_EN_UP				0x1
>  
> +#define OC1_CFG					0x310
> +#define OC1_CFG_LONG_LATENCY_MASK		BIT(6)
> +#define OC1_CFG_HW_RESTORE_MASK			BIT(5)
> +#define OC1_CFG_PWR_GOOD_MASK_MASK		BIT(4)
> +#define OC1_CFG_THROTTLE_MODE_MASK		(0x3 << 2)
> +#define OC1_CFG_ALARM_POLARITY_MASK		BIT(1)
> +#define OC1_CFG_EN_THROTTLE_MASK		BIT(0)
> +
> +#define OC1_CNT_THRESHOLD			0x314
> +#define OC1_THROTTLE_PERIOD			0x318
> +#define OC1_ALARM_COUNT				0x31c
> +#define OC1_FILTER				0x320
> +#define OC1_STATS				0x3a8
> +
>  #define OC_INTR_STATUS				0x39c
>  #define OC_INTR_ENABLE				0x3a0
>  #define OC_INTR_DISABLE				0x3a4
> +#define OC_STATS_CTL				0x3c4
> +#define OC_STATS_CTL_CLR_ALL			0x2
> +#define OC_STATS_CTL_EN_ALL			0x1
>  
>  #define OC_INTR_OC1_MASK			BIT(0)
>  #define OC_INTR_OC2_MASK			BIT(1)
> @@ -207,6 +224,25 @@
>  #define THROT_DELAY_CTRL(throt)		(THROT_DELAY_LITE + \
>  					(THROT_OFFSET * throt))
>  
> +#define ALARM_OFFSET			0x14
> +#define ALARM_CFG(throt)		(OC1_CFG + \
> +					(ALARM_OFFSET * (throt - THROTTLE_OC1)))
> +
> +#define ALARM_CNT_THRESHOLD(throt)	(OC1_CNT_THRESHOLD + \
> +					(ALARM_OFFSET * (throt - THROTTLE_OC1)))
> +
> +#define ALARM_THROTTLE_PERIOD(throt)	(OC1_THROTTLE_PERIOD + \
> +					(ALARM_OFFSET * (throt - THROTTLE_OC1)))
> +
> +#define ALARM_ALARM_COUNT(throt)	(OC1_ALARM_COUNT + \
> +					(ALARM_OFFSET * (throt - THROTTLE_OC1)))
> +
> +#define ALARM_FILTER(throt)		(OC1_FILTER + \
> +					(ALARM_OFFSET * (throt - THROTTLE_OC1)))
> +
> +#define ALARM_STATS(throt)		(OC1_STATS + \
> +					(4 * (throt - THROTTLE_OC1)))
> +
>  /* get CCROC_THROT_PSKIP_xxx offset per HIGH/MED/LOW vect*/
>  #define CCROC_THROT_OFFSET			0x0c
>  #define CCROC_THROT_PSKIP_CTRL_CPU_REG(vect)    (CCROC_THROT_PSKIP_CTRL_CPU + \
> @@ -218,6 +254,9 @@
>  #define THERMCTL_LVL_REGS_SIZE		0x20
>  #define THERMCTL_LVL_REG(rg, lv)	((rg) + ((lv) * THERMCTL_LVL_REGS_SIZE))
>  
> +#define OC_THROTTLE_MODE_DISABLED	0
> +#define OC_THROTTLE_MODE_BRIEF		2
> +
>  static const int min_low_temp = -127000;
>  static const int max_high_temp = 127000;
>  
> @@ -266,6 +305,15 @@ struct tegra_thermctl_zone {
>  	const struct tegra_tsensor_group *sg;
>  };
>  
> +struct soctherm_oc_cfg {
> +	u32 active_low;
> +	u32 throt_period;
> +	u32 alarm_cnt_thresh;
> +	u32 alarm_filter;
> +	u32 mode;
> +	bool intr_en;
> +};
> +
>  struct soctherm_throt_cfg {
>  	const char *name;
>  	unsigned int id;
> @@ -273,6 +321,7 @@ struct soctherm_throt_cfg {
>  	u8 cpu_throt_level;
>  	u32 cpu_throt_depth;
>  	u32 gpu_throt_level;
> +	struct soctherm_oc_cfg oc_cfg;
>  	struct thermal_cooling_device *cdev;
>  	bool init;
>  };
> @@ -715,7 +764,7 @@ static int tegra_soctherm_set_hwtrips(struct device *dev,
>  		return 0;
>  	}
>  
> -	for (i = 0; i < THROTTLE_SIZE; i++) {
> +	for (i = 0; i < THROTTLE_OC1; i++) {
>  		struct thermal_cooling_device *cdev;
>  
>  		if (!ts->throt_cfgs[i].init)
> @@ -1537,6 +1586,32 @@ static int soctherm_thermtrips_parse(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static void soctherm_oc_cfg_parse(struct device *dev,
> +				struct device_node *np_oc,
> +				struct soctherm_throt_cfg *stc)
> +{
> +	u32 val;
> +
> +	if (of_property_read_bool(np_oc, "nvidia,polarity-active-low"))
> +		stc->oc_cfg.active_low = 1;
> +	else
> +		stc->oc_cfg.active_low = 0;
> +
> +	if (!of_property_read_u32(np_oc, "nvidia,count-threshold", &val)) {
> +		stc->oc_cfg.intr_en = 1;
> +		stc->oc_cfg.alarm_cnt_thresh = val;
> +	}
> +
> +	if (!of_property_read_u32(np_oc, "nvidia,throttle-period-us", &val))
> +		stc->oc_cfg.throt_period = val;
> +
> +	if (!of_property_read_u32(np_oc, "nvidia,alarm-filter", &val))
> +		stc->oc_cfg.alarm_filter = val;
> +
> +	/* BRIEF throttling by default, do not support STICKY */
> +	stc->oc_cfg.mode = OC_THROTTLE_MODE_BRIEF;
> +}
> +
>  static int soctherm_throt_cfg_parse(struct device *dev,
>  				    struct device_node *np,
>  				    struct soctherm_throt_cfg *stc)
> @@ -1619,24 +1694,34 @@ static void soctherm_init_hw_throt_cdev(struct platform_device *pdev)
>  			continue;
>  		}
>  
> +		if (stc->init) {
> +			dev_err(dev, "throttle-cfg: %s: redefined!\n", name);
> +			of_node_put(np_stcc);
> +			break;
> +		}
>  
>  		err = soctherm_throt_cfg_parse(dev, np_stcc, stc);
>  		if (err)
>  			continue;
>  
> -		tcd = thermal_of_cooling_device_register(np_stcc,
> +		if (stc->id >= THROTTLE_OC1) {
> +			soctherm_oc_cfg_parse(dev, np_stcc, stc);
> +			stc->init = true;
> +		} else {
> +
> +			tcd = thermal_of_cooling_device_register(np_stcc,
>  							 (char *)name, ts,
>  							 &throt_cooling_ops);
> -		of_node_put(np_stcc);
> -		if (IS_ERR_OR_NULL(tcd)) {
> -			dev_err(dev,
> -				"throttle-cfg: %s: failed to register cooling device\n",
> -				name);
> -			continue;
> +			if (IS_ERR_OR_NULL(tcd)) {
> +				dev_err(dev,
> +					"throttle-cfg: %s: failed to register cooling device\n",
> +					name);
> +				continue;
> +			}
> +			stc->cdev = tcd;
> +			stc->init = true;
>  		}
>  
> -		stc->cdev = tcd;
> -		stc->init = true;
>  	}
>  
>  	of_node_put(np_stc);
> @@ -1787,6 +1872,28 @@ static void throttlectl_gpu_level_select(struct tegra_soctherm *ts,
>  	writel(r, ts->regs + THROT_PSKIP_CTRL(throt, THROTTLE_DEV_GPU));
>  }
>  
> +static int soctherm_oc_cfg_program(struct tegra_soctherm *ts,
> +				      enum soctherm_throttle_id throt)
> +{
> +	u32 r;
> +	struct soctherm_oc_cfg *oc = &ts->throt_cfgs[throt].oc_cfg;
> +
> +	if (oc->mode == OC_THROTTLE_MODE_DISABLED)
> +		return -EINVAL;
> +
> +	r = REG_SET_MASK(0, OC1_CFG_HW_RESTORE_MASK, 1);
> +	r = REG_SET_MASK(r, OC1_CFG_THROTTLE_MODE_MASK, oc->mode);
> +	r = REG_SET_MASK(r, OC1_CFG_ALARM_POLARITY_MASK, oc->active_low);
> +	r = REG_SET_MASK(r, OC1_CFG_EN_THROTTLE_MASK, 1);
> +	writel(r, ts->regs + ALARM_CFG(throt));
> +	writel(oc->throt_period, ts->regs + ALARM_THROTTLE_PERIOD(throt));
> +	writel(oc->alarm_cnt_thresh, ts->regs + ALARM_CNT_THRESHOLD(throt));
> +	writel(oc->alarm_filter, ts->regs + ALARM_FILTER(throt));
> +	soctherm_oc_intr_enable(ts, throt, oc->intr_en);
> +
> +	return 0;
> +}
> +
>  /**
>   * soctherm_throttle_program() - programs pulse skippers' configuration
>   * @throt: the LIGHT/HEAVY of the throttle event id.
> @@ -1803,6 +1910,9 @@ static void soctherm_throttle_program(struct tegra_soctherm *ts,
>  	if (!stc.init)
>  		return;
>  
> +	if ((throt >= THROTTLE_OC1) && (soctherm_oc_cfg_program(ts, throt)))
> +		return;
> +
>  	/* Setup PSKIP parameters */
>  	if (ts->soc->use_ccroc)
>  		throttlectl_cpu_level_select(ts, throt);
> -- 
> 2.7.4
> 
