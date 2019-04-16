Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDCCCC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 824D520868
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:24:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n0AKNv0H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729781AbfDPPY4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 11:24:56 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45991 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728963AbfDPPYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 11:24:53 -0400
Received: by mail-lf1-f68.google.com with SMTP id t11so11847989lfl.12;
        Tue, 16 Apr 2019 08:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5H9Q6Msy1kZlDn/xFUkq6eltb7uUb4OSlCzoCWVh1jQ=;
        b=n0AKNv0Hlcq65zF81LczVoFSHqvFEjt3ZpBbKIcN6o2PcDsB4Qa8QcrU1F2CU9nVUz
         kZviSdAytTGoC/k2B84sxupnXMFOn0RwK7MortIsJ8FoaP3j/3A/jR076s6ThJPo6PZg
         YiL4BjSdW9yASpUch/i9hi2ymhMfPIiX1Wkrcmx1EOCCQzhLm5qxP4m3q/Qzlh9zIGLS
         LbmsHCwHGoNCJpv6ezE2vyrviFi+nqVBdcivSCXYZ46TlnrAa5Cqsp7by/lgVrSc4eIO
         X1sisd0CNBdQDqFtgEMSqk4Bpa12AFFEL52bb1NRQrajQvyEJGL5ILtD1xfZSTU8HdGG
         qz9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5H9Q6Msy1kZlDn/xFUkq6eltb7uUb4OSlCzoCWVh1jQ=;
        b=AJIa2j7YnzremaWKnz9m5oP7wWVF5Rpc+xa6MUmRCyQRUI3gq9vzwJzPVf1rcSTo3q
         tmQP+NwByZZg4MxulLe2Drodt+kXo3JV7GRtRK90sOzBOZRxpgT6c0XGenPgtWT0uSw3
         i8NEKcHn+Mgdi6+pKDqkwaSmzcV7knI7V089obQ1/7Y2YCQhwP6A6pc7eGsGkh5OvvtV
         xWhLaOn2x+tbmQehUxh11GAG4ZBHhbUz0btPAedGL79/Ct6FSeYk1Dj53/W4M2V7cWnU
         YgaS6vrbiBpaFnR/bSsIWpOY6jYAodA4nHaMEP8ejfmlhJ2WzczH1x52A7viUNB1XDLn
         D1YQ==
X-Gm-Message-State: APjAAAVLYWh67ag7F92sJla1bBZeYumK1wme0H/iOV4dLRx6eUk9x1Aw
        BlYIVU2chhagmPeu+9VFAAbIE7Kd
X-Google-Smtp-Source: APXvYqxVheQJU26Tbt/Qi8GK8FjmVFRDYob8Y6wCGpCvaxrVCtUSI+s4K7TDs3zIBcc+OrlfNJTOuA==
X-Received: by 2002:a19:6911:: with SMTP id e17mr15525448lfc.5.1555428289990;
        Tue, 16 Apr 2019 08:24:49 -0700 (PDT)
Received: from [192.168.2.145] (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.googlemail.com with ESMTPSA id a11sm10600964ljf.68.2019.04.16.08.24.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 08:24:49 -0700 (PDT)
Subject: Re: [PATCH v2 10/19] PM / devfreq: tegra: Drop primary interrupt
 handler
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20190415145505.18397-1-digetx@gmail.com>
 <CGME20190415145737epcas1p39300df7ef83ed20bd7aaa4e920d1f475@epcas1p3.samsung.com>
 <20190415145505.18397-11-digetx@gmail.com>
 <93574885-d695-2288-a4c6-2b845ad8daaf@samsung.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <286d8d4a-f761-93d3-8b77-cf71a7d0dab3@gmail.com>
Date:   Tue, 16 Apr 2019 18:23:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <93574885-d695-2288-a4c6-2b845ad8daaf@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

16.04.2019 8:56, Chanwoo Choi пишет:
> Hi,
> 
> It looks good to me to drop the primary interrupt handler
> but I have some comments. Please check it.
> 
> On 19. 4. 15. 오후 11:54, Dmitry Osipenko wrote:
>> There is no real need in the primary interrupt handler, hence move
>> everything to the secondary (threaded) handler. In a result locking
>> is consistent now and there are no potential races with the interrupt
>> handler because it is protected with the devfreq's mutex.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/devfreq/tegra-devfreq.c | 61 ++++++++++++---------------------
>>  1 file changed, 22 insertions(+), 39 deletions(-)
>>
>> diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
>> index 2a1464098200..69b557df5084 100644
>> --- a/drivers/devfreq/tegra-devfreq.c
>> +++ b/drivers/devfreq/tegra-devfreq.c
>> @@ -144,7 +144,6 @@ static struct tegra_devfreq_device_config actmon_device_configs[] = {
>>  struct tegra_devfreq_device {
>>  	const struct tegra_devfreq_device_config *config;
>>  	void __iomem *regs;
>> -	spinlock_t lock;
>>  
>>  	/* Average event count sampled in the last interrupt */
>>  	u32 avg_count;
>> @@ -249,11 +248,8 @@ static void actmon_write_barrier(struct tegra_devfreq *tegra)
>>  static void actmon_isr_device(struct tegra_devfreq *tegra,
>>  			      struct tegra_devfreq_device *dev)
>>  {
>> -	unsigned long flags;
>>  	u32 intr_status, dev_ctrl;
>>  
>> -	spin_lock_irqsave(&dev->lock, flags);
>> -
>>  	dev->avg_count = device_readl(dev, ACTMON_DEV_AVG_COUNT);
>>  	tegra_devfreq_update_avg_wmark(tegra, dev);
>>  
>> @@ -302,26 +298,6 @@ static void actmon_isr_device(struct tegra_devfreq *tegra,
>>  	device_writel(dev, ACTMON_INTR_STATUS_CLEAR, ACTMON_DEV_INTR_STATUS);
>>  
>>  	actmon_write_barrier(tegra);
>> -
>> -	spin_unlock_irqrestore(&dev->lock, flags);
>> -}
>> -
>> -static irqreturn_t actmon_isr(int irq, void *data)
>> -{
>> -	struct tegra_devfreq *tegra = data;
>> -	bool handled = false;
>> -	unsigned int i;
>> -	u32 val;
>> -
>> -	val = actmon_readl(tegra, ACTMON_GLB_STATUS);
>> -	for (i = 0; i < ARRAY_SIZE(tegra->devices); i++) {
>> -		if (val & tegra->devices[i].config->irq_mask) {
>> -			actmon_isr_device(tegra, tegra->devices + i);
>> -			handled = true;
>> -		}
>> -	}
>> -
>> -	return handled ? IRQ_WAKE_THREAD : IRQ_NONE;
>>  }
>>  
>>  static unsigned long actmon_cpu_to_emc_rate(struct tegra_devfreq *tegra,
>> @@ -348,35 +324,46 @@ static void actmon_update_target(struct tegra_devfreq *tegra,
>>  	unsigned long cpu_freq = 0;
>>  	unsigned long static_cpu_emc_freq = 0;
>>  	unsigned int avg_sustain_coef;
>> -	unsigned long flags;
>> +	u32 avg_count;
>>  
>>  	if (dev->config->avg_dependency_threshold) {
>>  		cpu_freq = cpufreq_get(0);
>>  		static_cpu_emc_freq = actmon_cpu_to_emc_rate(tegra, cpu_freq);
>>  	}
>>  
>> -	spin_lock_irqsave(&dev->lock, flags);
>> -
>> -	dev->target_freq = dev->avg_count / ACTMON_SAMPLING_PERIOD;
>> +	avg_count = dev->avg_count;
>> +	dev->target_freq = avg_count / ACTMON_SAMPLING_PERIOD;
> 
> Actually, this change is not related to this patch.
> Please keep the original code.
> 
>>  	avg_sustain_coef = 100 * 100 / dev->config->boost_up_threshold;
>>  	dev->target_freq = do_percent(dev->target_freq, avg_sustain_coef);
>>  	dev->target_freq += dev->boost_freq;
>>  
>> -	if (dev->avg_count >= dev->config->avg_dependency_threshold)
>> +	if (avg_count >= dev->config->avg_dependency_threshold)
> 
> ditto.

Good catch, it's a leftover from v1 that I forgot to revert. Thank you.

[snip]

> 
> When I review this patch, I have a question
> about why tegra_actmon_rate_notify_cb is needed.
> 
> tegra_actmon_rate_notify_cb() do something
> when the clock rate of emc_clock is changed.
> I think that 'emc_clock' is changed by this driver.
> It means that the this driver can catch the change timing
> of emc_clock rate without notifier. 

The devfreq driver isn't the only driver of the EMC clock rate. The devfreq driver changes EMC freq dynamically based of on average memory usage activity, but for some hardware units (like display controller for example) there is a requirement for a minimum memory bandwidth (isochronous transactions) and hence when display is waking up from suspend it immediately requires an amount of memory bandwidth that could be higher than ACTMON hardware unit suggests and besides the ACTMON's reaction is delayed by the sampling period (12ms).

> IMO, it is possible to call tegra_devfreq_update_wmark()
> directly without clock notifier before calling
> 'clk_set_min_rate()/clk_set_rate()' in the tegra_devfreq_target().
> 
> With clock notifier, it cannot restore something for
> tegra_devfreq_update_wmark(tegra, dev) when failed to
> set the rate of emc_clk by 'clk_set_min_rate()/clk_set_rate()'.

The watermarks should be changed in accordance to the actual EMC clock rate. Given that EMC rate could be changed by something else than the devfreq driver, we need to re-adjust the watermarks to the actual values after the EMC rate-change completion. Please note that the clock notifier uses the POST_RATE_CHANGE event that happens only after successful completion of EMC clock rate change.
