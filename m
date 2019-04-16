Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C23AAC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 07:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80A1720857
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 07:40:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="kAnDvhi5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728548AbfDPHkh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 03:40:37 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:52407 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbfDPHkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 03:40:37 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190416074031epoutp04991f36768c242927d67438727c75e966~V5HOiojzy2771627716epoutp04Z
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 07:40:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190416074031epoutp04991f36768c242927d67438727c75e966~V5HOiojzy2771627716epoutp04Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1555400431;
        bh=jiSGLF+PgsYpVrUadyHPFCUBrxAkkQIvJk9chqS11IM=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=kAnDvhi5aQzze3MMDxmsh0uQIp+/xd5XoPuKjLQeD/V+5Ey1ksgKYYYnOnRzw1+PR
         eyBl0zT5L56tLamaOSdfqi9tavFqexGD17+FhbkGiIADPW7LLE0MUvKOQ7YDYmXtDr
         fKYRmUaUL2R0Ofgago96nnmmNON4hGeey0So16vQ=
Received: from epsmges1p3.samsung.com (unknown [182.195.40.155]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190416074023epcas1p36c2d609eccef5cf134633d0b5591abae~V5HG5ql2f0581005810epcas1p3Q;
        Tue, 16 Apr 2019 07:40:23 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        84.73.04143.0E685BC5; Tue, 16 Apr 2019 16:40:16 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190416074016epcas1p26dda3c528848ca6e3e12146c82f4a098~V5HAQM7P80566605666epcas1p2o;
        Tue, 16 Apr 2019 07:40:16 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190416074016epsmtrp192d247763b85139ca742739f806980d7~V5HAPcCpx2321423214epsmtrp1j;
        Tue, 16 Apr 2019 07:40:16 +0000 (GMT)
X-AuditID: b6c32a37-f31ff7000000102f-e0-5cb586e0b614
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A7.00.03662.0E685BC5; Tue, 16 Apr 2019 16:40:16 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190416074016epsmtip154b31cad883c2ca024682b5108485ca7~V5HAEJsb72354623546epsmtip1P;
        Tue, 16 Apr 2019 07:40:16 +0000 (GMT)
Subject: Re: [PATCH v2 15/19] PM / devfreq: tegra: Synchronize IRQ after
 masking it in hardware
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
Message-ID: <81db3a75-2d17-5268-fea5-8b6ed650056f@samsung.com>
Date:   Tue, 16 Apr 2019 16:41:10 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190415145505.18397-16-digetx@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTURzHOXtcp7S6TrOfE2teMUjQ7bqmV5nSC1nkH4a9FGle3G0Tt92x
        u0UWiVZYRlphlM7epdjKkppmoxiZvaCi7EEZYmGRr5JaRUWvXa+R/33O9/y+5/f7nnNkYsV5
        TCkrs7sYp522EliEpOvGgtSUVzWdxZr273rq7MchRO3wnJRQ97eNh1GP/YcxKljXi6jazx6M
        elndhlHf/UclVH17H7Yo3NA9cBoZrngGwgx12z9ghnqfFxmCF+fmS4vK9RaGNjFOFWMvZU1l
        dnM2saLAuNSoS9eQKWQmlUGo7LSNySaW5eWn5JZZQwMRqo201R2S8mmOI9Q5eifrdjEqC8u5
        sgnGYbI6Mh2pHG3j3HZzailryyI1mjRdqLCk3NLaPSpyXJ276fDJ11gVCsBuFC4DfCE8O/hD
        wrMC70Zw7+D63SgixJ8Q/Br6KhEWXxE0nXsb9s9xtKFNJGxcQ9DYN4aExQSCn9U3QzsyWRRO
        w/jZAl6Pxn8j+ORvlPJuMV4IX663iHnG8GQIDD/HeJ6FJ8DTb0OIZzmeA8GXbRh/jgRPAu/A
        Gl6eja+DwVsdUqEkEu42vZkcOxzPgOHgtzDh+DnQ/+aYSOB5sL2zWczPAPgfDO68fy0VEiyD
        gN8vEjgKRm/7ppIpYWRvzRRvgTN3ezHBvAuBL/BwyqyFQEvDZEgxvgAu+NVCs5nw4cseKS8D
        LoddNQqhOhEevxqYahULp3bWYgIb4OaRQ9g+lOCZFsczLYJnWgTP/2bHkcSLYhgHZzMzHOnQ
        Tn/si2jyryZndKOOB3k9CJchYoa8pN5XrJDSG7kKWw8CmZiIli82hSS5ia7YzDhZo9NtZbge
        pAtd9n6xcnYpG/r5dpeR1KVptVpqIZmuI0lijvzCoqXFCtxMu5hyhnEwzn8+kSxcWYUq3jpU
        5/OcEd7WTcsrN2viot/lrs0rqHPbZ6j7c1+wLCO3bO2PuXcityuSe3G1qWH+k+aiJafX6clD
        bOxEb/Uqlfq2Iu7ade/llT3xG3R0jiIx6dGJ+C39EOEt7BupjDT31bTPFOlHS7LGkrYGVh8I
        xh8nLg0mKWsT36mpDLhBSDgLTSaLnRz9Fz75zkDBAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJIsWRmVeSWpSXmKPExsWy7bCSnO6Dtq0xBod/8lis/viY0aJl1iIW
        i7NNb9gtLu+aw2bxufcIo0Xnl1lsFrcbV7BZ/Nw1j8Wib+0lNgdOjx13lzB67Jx1l92jt/kd
        m0ffllWMHp83yQWwRnHZpKTmZJalFunbJXBlLNvxiqlgj1zFnEUP2RoY90t0MXJySAiYSMyb
        vIKpi5GLQ0hgN6NEx4lF7BAJSYlpF48ydzFyANnCEocPF0PUvGWUOHNxGitIXFggUeLN6mCQ
        uIhAE5PE54ctTCC9zAKREv2PulkhGrYxSrzbeJYRJMEmoCWx/8UNNhCbX0BR4uqPx2BxXgE7
        ic+3V7CBDGURUJVYdTcMJCwqECFx5v0KFogSQYmTM5+A2ZwC5hIvPv9gh9ilLvFn3iVmCFtc
        4taT+VA3yEs0b53NPIFReBaS9llIWmYhaZmFpGUBI8sqRsnUguLc9NxiwwKjvNRyveLE3OLS
        vHS95PzcTYzgCNPS2sF44kT8IUYBDkYlHt6Evi0xQqyJZcWVuYcYJTiYlUR4HVOAQrwpiZVV
        qUX58UWlOanFhxilOViUxHnl849FCgmkJ5akZqemFqQWwWSZODilGhhns6+8tLo0pbC1/MvL
        a4pLe5xOOm3qPshmJnZQitlst+RF3chpymFz7fnvzfnWuaagYv/Zpx5qO5bGyH3hZ/vCm8Oi
        sVAr/dmrFU8T7sx2MjOTnjTl4KEz/2rir59unRx34qPemcdGi7klNdm2RRW+XiFyceMff5Ob
        rbXhtsyPZ4arW03590RMiaU4I9FQi7moOBEAjZnTx6wCAAA=
X-CMS-MailID: 20190416074016epcas1p26dda3c528848ca6e3e12146c82f4a098
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190415145717epcas4p1647551d3a4c7bb2a0d9698707fa03f43
References: <20190415145505.18397-1-digetx@gmail.com>
        <CGME20190415145717epcas4p1647551d3a4c7bb2a0d9698707fa03f43@epcas4p1.samsung.com>
        <20190415145505.18397-16-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In this patchset,
the patch11 adds new 'disable_interrupt' goto statement
and then patch15 removes 'disable_interrupt' goto statement again.
Actually, it is inefficient.

If you change the order of patches,
you could remove this stuff.

On 19. 4. 15. 오후 11:55, Dmitry Osipenko wrote:
> There is no guarantee that interrupt handling isn't running in parallel,
> hence it is necessary to synchronize IRQ in order to ensure that interrupt
> is indeed disabled.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/devfreq/tegra-devfreq.c | 33 ++++++++++++++++-----------------
>  1 file changed, 16 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
> index 46c61af8ca33..cfbfbe28e7bf 100644
> --- a/drivers/devfreq/tegra-devfreq.c
> +++ b/drivers/devfreq/tegra-devfreq.c
> @@ -171,6 +171,8 @@ struct tegra_devfreq {
>  	struct notifier_block	rate_change_nb;
>  
>  	struct tegra_devfreq_device devices[ARRAY_SIZE(actmon_device_configs)];
> +
> +	int irq;
>  };
>  
>  struct tegra_actmon_emc_ratio {
> @@ -432,6 +434,8 @@ static void tegra_actmon_disable_interrupts(struct tegra_devfreq *tegra)
>  	}
>  
>  	actmon_write_barrier(tegra);
> +
> +	synchronize_irq(tegra->irq);
>  }
>  
>  static void tegra_actmon_configure_device(struct tegra_devfreq *tegra,
> @@ -603,7 +607,6 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>  	struct resource *res;
>  	unsigned int i;
>  	unsigned long rate;
> -	int irq;
>  	int err;
>  
>  	tegra = devm_kzalloc(&pdev->dev, sizeof(*tegra), GFP_KERNEL);
> @@ -659,18 +662,18 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>  		tegra_actmon_configure_device(tegra, dev);
>  	}
>  
> +	tegra->irq = platform_get_irq(pdev, 0);
> +	if (tegra->irq < 0) {
> +		err = tegra->irq;
> +		dev_err(&pdev->dev, "Failed to get IRQ: %d\n", err);
> +		return err;
> +	}
> +
>  	for (rate = 0; rate <= tegra->max_freq * KHZ; rate++) {
>  		rate = clk_round_rate(tegra->emc_clock, rate);
>  		dev_pm_opp_add(&pdev->dev, rate, 0);
>  	}
>  
> -	irq = platform_get_irq(pdev, 0);
> -	if (irq < 0) {
> -		err = irq;
> -		dev_err(&pdev->dev, "Failed to get IRQ: %d\n", err);
> -		goto remove_opps;
> -	}
> -
>  	platform_set_drvdata(pdev, tegra);
>  
>  	err = devfreq_add_governor(&tegra_devfreq_governor);
> @@ -689,10 +692,11 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>  		goto remove_governor;
>  	}
>  
> -	err = request_threaded_irq(irq, NULL, actmon_thread_isr, IRQF_ONESHOT,
> -				   "tegra-devfreq", tegra);
> +	err = devm_request_threaded_irq(&pdev->dev, tegra->irq, NULL,
> +					actmon_thread_isr, IRQF_ONESHOT,
> +					"tegra-devfreq", tegra);
>  	if (err) {
> -		dev_err(&pdev->dev, "Interrupt request failed\n");
> +		dev_err(&pdev->dev, "Interrupt request failed: %d\n", err);
>  		goto remove_devfreq;
>  	}
>  
> @@ -701,14 +705,11 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>  	if (err) {
>  		dev_err(&pdev->dev,
>  			"Failed to register rate change notifier\n");
> -		goto disable_interrupt;
> +		goto remove_devfreq;
>  	}
>  
>  	return 0;
>  
> -disable_interrupt:
> -	free_irq(irq, tegra);
> -
>  remove_devfreq:
>  	devfreq_remove_device(tegra->devfreq);
>  
> @@ -727,10 +728,8 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>  static int tegra_devfreq_remove(struct platform_device *pdev)
>  {
>  	struct tegra_devfreq *tegra = platform_get_drvdata(pdev);
> -	int irq = platform_get_irq(pdev, 0);
>  
>  	clk_notifier_unregister(tegra->emc_clock, &tegra->rate_change_nb);
> -	free_irq(irq, tegra);
>  
>  	devfreq_remove_device(tegra->devfreq);
>  	dev_pm_opp_remove_all_dynamic(&pdev->dev);
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
