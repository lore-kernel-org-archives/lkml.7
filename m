Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6620C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 05:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99DC420868
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 05:56:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="HMf2Hxia"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbfDPF4K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 01:56:10 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:42770 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbfDPF4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 01:56:10 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190416055606epoutp010fb37c33a25394dacff06444c0706516~V3sDWqEjD1588815888epoutp01B
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 05:56:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190416055606epoutp010fb37c33a25394dacff06444c0706516~V3sDWqEjD1588815888epoutp01B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1555394166;
        bh=KsLl0ZEnr1eG05Spvk9eOasY3YZ06v7pzpNcUfVWxI8=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=HMf2HxiaVK3MjfdYq3bW1Z+tLalH2KaBvTQARDsACPYc5lt5fR0wnaeUMbREplgFj
         EWYas+zywhXXAUc8+e8/1yWt0NK4wp+iSvuQGdM13Hy+MVFja9jx9yvxHD56/quMpr
         +yaxMLse5bFuXLrqzby2zyJdrL2n1K/OGJnBSgQc=
Received: from epsmges1p2.samsung.com (unknown [182.195.40.157]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190416055603epcas1p2e06db46c7b9f165a784cc875a3a9ef61~V3sAolf6c2256722567epcas1p2f;
        Tue, 16 Apr 2019 05:56:03 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        84.EA.04142.07E65BC5; Tue, 16 Apr 2019 14:56:00 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20190416055600epcas1p37fea929aa4977f3dd97290f06c9ed189~V3r9zgNVz0036600366epcas1p3j;
        Tue, 16 Apr 2019 05:56:00 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190416055600epsmtrp2631f55a6861395675bcc401479ebc372~V3r9wLSbn1282112821epsmtrp2g;
        Tue, 16 Apr 2019 05:56:00 +0000 (GMT)
X-AuditID: b6c32a36-cf9ff7000000102e-e8-5cb56e704f87
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D1.8B.03692.F6E65BC5; Tue, 16 Apr 2019 14:56:00 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190416055559epsmtip2d0fff6bffd6d10f0113ec7b42cd6bdff~V3r9gBoLM1918319183epsmtip2j;
        Tue, 16 Apr 2019 05:55:59 +0000 (GMT)
Subject: Re: [PATCH v2 10/19] PM / devfreq: tegra: Drop primary interrupt
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
Message-ID: <93574885-d695-2288-a4c6-2b845ad8daaf@samsung.com>
Date:   Tue, 16 Apr 2019 14:56:54 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190415145505.18397-11-digetx@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SaUwTQRiGM+x2KcTiUEU/0CiuRwQDdinFxYDRQLSJ/CAxniGBDV0Locem
        2xKPHwoYRUU8g1gIEsVEMQiBIlhRIiqGIEoUj6j1RKNFUDk84rntauTfM+/3zrzfNzNKQl1H
        RShzLXbeZuFMNBVMnr8aFRMjWJozNEc+suzZT68Qu8N5gmR7Ct8HsnfdlRQ7su8aYnePOin2
        ccFpiv3mriLZ0ro71NIgfaunBukvOD2B+n1FQ5S+1FWL9CONM9IVG/KScnjOwNsieUu21ZBr
        MSbTK1dlpmTqEjRMDJPILqIjLZyZT6ZT09JjlueapIboyHzO5JCkdE4U6YVLkmxWh52PzLGK
        9mSaFwwmIVGIFTmz6LAYY7Ot5sWMRhOnk4xZeTm/B8cI4UXcpuG9zcR2VB61BwUpAcdD08dz
        hI/VuBXB0fdrZR5G8OS3fg8KlvgzgjdlBwP+bdjfWxYoFy4heN35i5IXHxBUDI6SPtckvAo8
        d8r9hcn4F4Jhd7nCVyDwehi7csqfR+FoaH/7kPLxRDwL7n19hXyswktgoGqH/yASz4WWi1f8
        ehheB886GxSyJxS6jvX7PUF4EXQdukzK50+FR/3HA2SeCUXNFYTc9ncK7v8wy5wKlQU1f/VJ
        4L3hCpQ5AkaGLlEyb4UzXdf8AwAuRuBq71XIBS20nzosBSilgCiody+Us0JgaKxE4ZMBq6B4
        p1p2z4a7zz1/by4cTu7aTckWPTz1xh9As5zjhnGOG8A5bgDn/6xqRNaiKbwgmo28yAhx49+6
        Efm/anRCKzpxK60DYSWiJ6iUJa4MtYLLFzebOxAoCXqyaplBklQGbvMW3mbNtDlMvNiBdNJd
        HyQiwrKt0se32DMZXZxWq2XjmQQdw9BTVfVLUzLU2MjZ+TyeF3jbv30ByqCI7ajM7fpShJt6
        UjXVjYPfvEc8KV/b+tpG+5qm9+tmhqxLyn2pTX8hLC4eVNXwP0s1WS27zO8axuY/yLowx9Bk
        9OLKZ6Eb1edD1OtXhN6ccIM8U3K9uDu8Yu+y+kJDXWFnzSZF0kAVwuK9ts8LFN19q+0tt6el
        EQVrvOHbnnQkOua10qSYwzHRhE3k/gCWEOIkwAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJIsWRmVeSWpSXmKPExsWy7bCSvG5B3tYYg+NOFqs/Pma0aJm1iMXi
        bNMbdovLu+awWXzuPcJo0fllFpvF7cYVbBY/d81jsehbe4nNgdNjx90ljB47Z91l9+htfsfm
        0bdlFaPH501yAaxRXDYpqTmZZalF+nYJXBn/335lLnhoVPGpeytzA+MMzS5GTg4JAROJ/gvT
        2EFsIYHdjBIb5pRBxCUlpl08ytzFyAFkC0scPlzcxcgFVPKWUWLL67eMIDXCAsESdy/NYANJ
        iAg0MUl8ftjCBJJgFoiU6H/UzQrRsY1R4nvfP7AONgEtif0vbrCB2PwCihJXfzwGi/MK2Em8
        ntfCAmKzCKhKbN99ECwuKhAhceb9ChaIGkGJkzOfgNmcAuYSJyftY4FYpi7xZ94lZghbXOLW
        k/lQR8hLNG+dzTyBUXgWkvZZSFpmIWmZhaRlASPLKkbJ1ILi3PTcYsMCw7zUcr3ixNzi0rx0
        veT83E2M4AjT0tzBeHlJ/CFGAQ5GJR7ehL4tMUKsiWXFlbmHGCU4mJVEeB1TgEK8KYmVValF
        +fFFpTmpxYcYpTlYlMR5n+YdixQSSE8sSc1OTS1ILYLJMnFwSjUwRj39ZNYcHSmQuMvjm8V7
        y7Tvmppr+S5/YfvhVRzKGbhqnasvU/OBtQeaOXguuhm2ZWpzJf5WWGvntnOxo5n8vZebHV77
        TVt/2PjK67WGBc3ZZ1Y9X2urwG2od+u/j8bpSo5pHcuDApzrRMzajjk8z5D5fWrZzdPeDYve
        L3l//crN9baHHBUElFiKMxINtZiLihMBx3KtSKwCAAA=
X-CMS-MailID: 20190416055600epcas1p37fea929aa4977f3dd97290f06c9ed189
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190415145737epcas1p39300df7ef83ed20bd7aaa4e920d1f475
References: <20190415145505.18397-1-digetx@gmail.com>
        <CGME20190415145737epcas1p39300df7ef83ed20bd7aaa4e920d1f475@epcas1p3.samsung.com>
        <20190415145505.18397-11-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

It looks good to me to drop the primary interrupt handler
but I have some comments. Please check it.

On 19. 4. 15. 오후 11:54, Dmitry Osipenko wrote:
> There is no real need in the primary interrupt handler, hence move
> everything to the secondary (threaded) handler. In a result locking
> is consistent now and there are no potential races with the interrupt
> handler because it is protected with the devfreq's mutex.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/devfreq/tegra-devfreq.c | 61 ++++++++++++---------------------
>  1 file changed, 22 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
> index 2a1464098200..69b557df5084 100644
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
> @@ -348,35 +324,46 @@ static void actmon_update_target(struct tegra_devfreq *tegra,
>  	unsigned long cpu_freq = 0;
>  	unsigned long static_cpu_emc_freq = 0;
>  	unsigned int avg_sustain_coef;
> -	unsigned long flags;
> +	u32 avg_count;
>  
>  	if (dev->config->avg_dependency_threshold) {
>  		cpu_freq = cpufreq_get(0);
>  		static_cpu_emc_freq = actmon_cpu_to_emc_rate(tegra, cpu_freq);
>  	}
>  
> -	spin_lock_irqsave(&dev->lock, flags);
> -
> -	dev->target_freq = dev->avg_count / ACTMON_SAMPLING_PERIOD;
> +	avg_count = dev->avg_count;
> +	dev->target_freq = avg_count / ACTMON_SAMPLING_PERIOD;

Actually, this change is not related to this patch.
Please keep the original code.

>  	avg_sustain_coef = 100 * 100 / dev->config->boost_up_threshold;
>  	dev->target_freq = do_percent(dev->target_freq, avg_sustain_coef);
>  	dev->target_freq += dev->boost_freq;
>  
> -	if (dev->avg_count >= dev->config->avg_dependency_threshold)
> +	if (avg_count >= dev->config->avg_dependency_threshold)

ditto.

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
> @@ -386,7 +373,6 @@ static int tegra_actmon_rate_notify_cb(struct notifier_block *nb,
>  	struct tegra_devfreq *tegra;
>  	struct tegra_devfreq_device *dev;
>  	unsigned int i;
> -	unsigned long flags;
>  
>  	if (action != POST_RATE_CHANGE)
>  		return NOTIFY_OK;
> @@ -398,9 +384,7 @@ static int tegra_actmon_rate_notify_cb(struct notifier_block *nb,

When I review this patch, I have a question
about why tegra_actmon_rate_notify_cb is needed.

tegra_actmon_rate_notify_cb() do something
when the clock rate of emc_clock is changed.
I think that 'emc_clock' is changed by this driver.
It means that the this driver can catch the change timing
of emc_clock rate without notifier. 

IMO, it is possible to call tegra_devfreq_update_wmark()
directly without clock notifier before calling
'clk_set_min_rate()/clk_set_rate()' in the tegra_devfreq_target().

With clock notifier, it cannot restore something for
tegra_devfreq_update_wmark(tegra, dev) when failed to
set the rate of emc_clk by 'clk_set_min_rate()/clk_set_rate()'.

>  	for (i = 0; i < ARRAY_SIZE(tegra->devices); i++) {
>  		dev = &tegra->devices[i];
>  
> -		spin_lock_irqsave(&dev->lock, flags);
>  		tegra_devfreq_update_wmark(tegra, dev);
> -		spin_unlock_irqrestore(&dev->lock, flags);
>  	}
>  
>  	actmon_write_barrier(tegra);
> @@ -668,7 +652,6 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>  		dev = tegra->devices + i;
>  		dev->config = actmon_device_configs + i;
>  		dev->regs = tegra->regs + dev->config->offset;
> -		spin_lock_init(&dev->lock);
>  
>  		tegra_actmon_configure_device(tegra, dev);
>  	}
> @@ -696,8 +679,8 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>  		return err;
>  	}
>  
> -	err = devm_request_threaded_irq(&pdev->dev, irq, actmon_isr,
> -					actmon_thread_isr, IRQF_SHARED,
> +	err = devm_request_threaded_irq(&pdev->dev, irq, NULL,
> +					actmon_thread_isr, IRQF_ONESHOT,
>  					"tegra-devfreq", tegra);
>  	if (err) {
>  		dev_err(&pdev->dev, "Interrupt request failed\n");
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
