Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 912C9C282DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 00:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 498EA2184B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 00:24:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="cZKc8OEM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387833AbfDRAYD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 20:24:03 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:22396 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729446AbfDRAYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 20:24:03 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190418002400epoutp044f54f218504ea6146c606c5cdb184376~WacqbVTU61456614566epoutp04D
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 00:24:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190418002400epoutp044f54f218504ea6146c606c5cdb184376~WacqbVTU61456614566epoutp04D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1555547040;
        bh=N8Jw5pK8Y5xQF6TuLeGGtAcTIF7IYkV4BnblRP8hm7A=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=cZKc8OEM4NvRDZ7aKQrygrtAL9huB6SMypxjnQOWnH38fUSem5v/dij6GzWbrzc8K
         XjKTTFqzjrMBgXrOjtNbaVdLr2d/iYaohnSl9NndhHGvSWxaQo3hqk0JyxJ/lHebtt
         d+KNq2OWTrJYKmntbYVF1/O8fUvK8lhqp6mo/wxw=
Received: from epsmges1p4.samsung.com (unknown [182.195.40.157]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190418002355epcas1p1ac8540d5c0a372edbd2082b844d3e16e~WaclyXKdU2673226732epcas1p1H;
        Thu, 18 Apr 2019 00:23:55 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        1D.79.04257.B93C7BC5; Thu, 18 Apr 2019 09:23:55 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190418002354epcas1p17e67d197bf869c4633f87e5c634dd24f~WaclhRMCP2260322603epcas1p1L;
        Thu, 18 Apr 2019 00:23:54 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190418002354epsmtrp1ef1fac9974bc4df2fe7b85de8d167bf5~WaclgXBK12241922419epsmtrp1E;
        Thu, 18 Apr 2019 00:23:54 +0000 (GMT)
X-AuditID: b6c32a38-5e3ff700000010a1-4f-5cb7c39b377d
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        4A.52.03692.A93C7BC5; Thu, 18 Apr 2019 09:23:54 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190418002354epsmtip2114be836b838a0e1bc2ca351278ee0ca~WaclSsClK0762307623epsmtip2h;
        Thu, 18 Apr 2019 00:23:54 +0000 (GMT)
Subject: Re: [PATCH v3 06/16] PM / devfreq: tegra: Drop primary interrupt
 handler
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <22ae12dc-9a6c-4f37-722b-adc7289a32c3@samsung.com>
Date:   Thu, 18 Apr 2019 09:24:52 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190417222925.5815-7-digetx@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRju2zk7TnH1tcrehGweqdDQPM7VMdIuSo0SEqToYtjJHTZxN3am
        3Yi0hbWRZgWRsxulZYZoNUvNFC8YRlclLEuSJt3pYlctsm3HyH/P937P8z7f836vjFBUU6Gy
        bJONt5o4A00FkdfaI2Oiy9qvZ8Te7wxmL332IHaf6yzJ3t37PoDtaTxBsV+KOhDr+Oqi2KcF
        lRQ73HiKZIuru6mlgZr6/nKkaXD1B2iK7B8oTbG7Cmm+XAlLk27MWaznOS1vVfKmLLM226RL
        pFenZyZnqhfEMtFMAruQVpo4I59Ip6SmRa/INngfRCvzOEOut5TGCQI9P2mx1Zxr45V6s2BL
        pHmL1mBJsMQInFHINelisszGRUxsbJzaS9ySo+8qsJOWmnnbB041EPnoWIQTBcoAx0NV64jE
        hxW4HsGFS2FOFOTFQwiKHvYR4uE7ghPFe6l/itPPmklRcRPBkx9KkfQRQYNnVOpEMtkUnA61
        J7f66lPxHwRDjcelPgGBN8C31grChykcBS2vH/ubTsLh8OinB/mwHCfBi3yn34DEs+HFoSE/
        ZxpeD887a6UiZzJ0lQ6SPq9ArIaSu9vE9tOhb/C0RMSzwF5X5g8AeJSCI82/A8QAKVBeOoJE
        PAXe3nKP1UPhzaHCMbwLLnZ1UKL4AAJ3ywOpeKGCloqjEp8xgSOhpnG+aDYRPnw76M8OWA4H
        ChUiOwJ6BvolIp4B5/Y7xmaoAcf9O1QJCneNS+MaF8E1LoLrv9kZRFahEN4iGHW8wFjix//1
        FeRf1Si2HjXdS21DWIboYHnl7OsZCimXJ+wwtiGQEfRU+TKtO0Mh13I7dvJWc6Y118ALbUjt
        HfZhInRaltm7+CZbJqOOU6lUbDyzQM0w9HR5zdLkDAXWcTY+h+ctvPWfTiILDM1HjoLe23M/
        rXr1S5lsn5A3ojO7rXkdkc608Bh2RZY2rOllr2JY2f1uU9KF1qZ1dZf1eGbEnJsV9CrbjOrS
        NSWHRzcvT7gdohncHb2yLmT1ucTKoGHNmtoHawdrC2/obJ4z5Y+C09c1vevuLOtRSTe2nU+9
        2rspxePo7uP67ce/Fu1ZQpOCnmOiCKvA/QXHwX7cwAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJIsWRmVeSWpSXmKPExsWy7bCSvO6sw9tjDA6dNrRY/fExo0XLrEUs
        Fmeb3rBbXN41h83ic+8RRovOL7PYLG43rmCz+LlrHotF39pLbA6cHjvuLmH02DnrLrtHb/M7
        No++LasYPT5vkgtgjeKySUnNySxLLdK3S+DKONnYzFKwXrviwbydzA2M05S7GDk5JARMJObf
        2cfSxcjFISSwm1Hi26ZtzBAJSYlpF48C2RxAtrDE4cPFEDVvGSVWz9jECBIXFgiW2DA3CSQu
        ItDEJPH5YQsTSC+zQKRE/6NuVoiGzYwSP058YQVJsAloSex/cYMNxOYXUJS4+uMxI4jNK2An
        8aihiwXEZhFQlXjU/wmsRlQgQuLM+xUsEDWCEidnPmEBWcwpYCox4Ww5xC51iT/zLjFD2OIS
        t57Mh7pBXqJ562zmCYzCs5B0z0LSMgtJyywkLQsYWVYxSqYWFOem5xYbFhjmpZbrFSfmFpfm
        pesl5+duYgRHmJbmDsbLS+IPMQpwMCrx8K5Q3R4jxJpYVlyZe4hRgoNZSYTXMWVLjBBvSmJl
        VWpRfnxRaU5q8SFGaQ4WJXHep3nHIoUE0hNLUrNTUwtSi2CyTBycUg2MEiyzJtWyirBaPWG8
        +cnm4f+Y4CiPHb9tGXbJrd7Icua18Ks5bivCH89ZWdf62+IQ07l/J16aqNxfNDd9252fkbyi
        enzJKqv/if1YKGTrmRbap8FYci7y7zObZxdn8m3JDv54+fvJdNmUDROSo2uFXmld/BjmdtW5
        aU7Xxbs/M6/9Vy/+5P5ymRJLcUaioRZzUXEiADwxo2CsAgAA
X-CMS-MailID: 20190418002354epcas1p17e67d197bf869c4633f87e5c634dd24f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190417224246epcas3p2fe81ce63069496ea13c3aeeb54189afd
References: <20190417222925.5815-1-digetx@gmail.com>
        <CGME20190417224246epcas3p2fe81ce63069496ea13c3aeeb54189afd@epcas3p2.samsung.com>
        <20190417222925.5815-7-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19. 4. 18. 오전 7:29, Dmitry Osipenko wrote:
> There is no real need in the primary interrupt handler, hence move
> everything to the secondary (threaded) handler. In a result locking
> is consistent now and there are no potential races with the interrupt
> handler because it is protected with the devfreq's mutex.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/devfreq/tegra-devfreq.c | 55 +++++++++++----------------------
>  1 file changed, 18 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
> index 24ec65556c39..b65313fe3c2e 100644
> --- a/drivers/devfreq/tegra-devfreq.c
> +++ b/drivers/devfreq/tegra-devfreq.c
> @@ -144,7 +144,6 @@ static struct tegra_devfreq_device_config actmon_device_configs[] = {
>  struct tegra_devfreq_device {
>  	const struct tegra_devfreq_device_config *config;
>  	void __iomem *regs;
> -	spinlock_t lock;
>  
>  	/* Average event count sampled in the last interrupt */
>  	u32 avg_count;
> @@ -249,11 +248,8 @@ static void actmon_write_barrier(struct tegra_devfreq *tegra)
>  static void actmon_isr_device(struct tegra_devfreq *tegra,
>  			      struct tegra_devfreq_device *dev)
>  {
> -	unsigned long flags;
>  	u32 intr_status, dev_ctrl;
>  
> -	spin_lock_irqsave(&dev->lock, flags);
> -
>  	dev->avg_count = device_readl(dev, ACTMON_DEV_AVG_COUNT);
>  	tegra_devfreq_update_avg_wmark(tegra, dev);
>  
> @@ -302,26 +298,6 @@ static void actmon_isr_device(struct tegra_devfreq *tegra,
>  	device_writel(dev, ACTMON_INTR_STATUS_CLEAR, ACTMON_DEV_INTR_STATUS);
>  
>  	actmon_write_barrier(tegra);
> -
> -	spin_unlock_irqrestore(&dev->lock, flags);
> -}
> -
> -static irqreturn_t actmon_isr(int irq, void *data)
> -{
> -	struct tegra_devfreq *tegra = data;
> -	bool handled = false;
> -	unsigned int i;
> -	u32 val;
> -
> -	val = actmon_readl(tegra, ACTMON_GLB_STATUS);
> -	for (i = 0; i < ARRAY_SIZE(tegra->devices); i++) {
> -		if (val & tegra->devices[i].config->irq_mask) {
> -			actmon_isr_device(tegra, tegra->devices + i);
> -			handled = true;
> -		}
> -	}
> -
> -	return handled ? IRQ_WAKE_THREAD : IRQ_NONE;
>  }
>  
>  static unsigned long actmon_cpu_to_emc_rate(struct tegra_devfreq *tegra,
> @@ -348,15 +324,12 @@ static void actmon_update_target(struct tegra_devfreq *tegra,
>  	unsigned long cpu_freq = 0;
>  	unsigned long static_cpu_emc_freq = 0;
>  	unsigned int avg_sustain_coef;
> -	unsigned long flags;
>  
>  	if (dev->config->avg_dependency_threshold) {
>  		cpu_freq = cpufreq_get(0);
>  		static_cpu_emc_freq = actmon_cpu_to_emc_rate(tegra, cpu_freq);
>  	}
>  
> -	spin_lock_irqsave(&dev->lock, flags);
> -
>  	dev->target_freq = dev->avg_count / ACTMON_SAMPLING_PERIOD;
>  	avg_sustain_coef = 100 * 100 / dev->config->boost_up_threshold;
>  	dev->target_freq = do_percent(dev->target_freq, avg_sustain_coef);
> @@ -364,19 +337,31 @@ static void actmon_update_target(struct tegra_devfreq *tegra,
>  
>  	if (dev->avg_count >= dev->config->avg_dependency_threshold)
>  		dev->target_freq = max(dev->target_freq, static_cpu_emc_freq);
> -
> -	spin_unlock_irqrestore(&dev->lock, flags);
>  }
>  
>  static irqreturn_t actmon_thread_isr(int irq, void *data)
>  {
>  	struct tegra_devfreq *tegra = data;
> +	bool handled = false;
> +	unsigned int i;
> +	u32 val;
>  
>  	mutex_lock(&tegra->devfreq->lock);
> -	update_devfreq(tegra->devfreq);
> +
> +	val = actmon_readl(tegra, ACTMON_GLB_STATUS);
> +	for (i = 0; i < ARRAY_SIZE(tegra->devices); i++) {
> +		if (val & tegra->devices[i].config->irq_mask) {
> +			actmon_isr_device(tegra, tegra->devices + i);
> +			handled = true;
> +		}
> +	}
> +
> +	if (handled)
> +		update_devfreq(tegra->devfreq);
> +
>  	mutex_unlock(&tegra->devfreq->lock);
>  
> -	return IRQ_HANDLED;
> +	return handled ? IRQ_HANDLED : IRQ_NONE;
>  }
>  
>  static int tegra_actmon_rate_notify_cb(struct notifier_block *nb,
> @@ -386,7 +371,6 @@ static int tegra_actmon_rate_notify_cb(struct notifier_block *nb,
>  	struct tegra_devfreq *tegra;
>  	struct tegra_devfreq_device *dev;
>  	unsigned int i;
> -	unsigned long flags;
>  
>  	if (action != POST_RATE_CHANGE)
>  		return NOTIFY_OK;
> @@ -398,9 +382,7 @@ static int tegra_actmon_rate_notify_cb(struct notifier_block *nb,
>  	for (i = 0; i < ARRAY_SIZE(tegra->devices); i++) {
>  		dev = &tegra->devices[i];
>  
> -		spin_lock_irqsave(&dev->lock, flags);
>  		tegra_devfreq_update_wmark(tegra, dev);
> -		spin_unlock_irqrestore(&dev->lock, flags);
>  	}
>  
>  	actmon_write_barrier(tegra);
> @@ -682,7 +664,6 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>  		dev = tegra->devices + i;
>  		dev->config = actmon_device_configs + i;
>  		dev->regs = tegra->regs + dev->config->offset;
> -		spin_lock_init(&dev->lock);
>  
>  		tegra_actmon_configure_device(tegra, dev);
>  	}
> @@ -700,8 +681,8 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, tegra);
>  
> -	err = devm_request_threaded_irq(&pdev->dev, irq, actmon_isr,
> -					actmon_thread_isr, IRQF_SHARED,
> +	err = devm_request_threaded_irq(&pdev->dev, irq, NULL,
> +					actmon_thread_isr, IRQF_ONESHOT,
>  					"tegra-devfreq", tegra);
>  	if (err) {
>  		dev_err(&pdev->dev, "Interrupt request failed\n");
> 

Looks good to me.
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
