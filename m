Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BCB1C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 18:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DDEA22459
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 18:33:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GwLPK+NL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728400AbfIZSd5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 14:33:57 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34441 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfIZSd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 14:33:56 -0400
Received: by mail-lj1-f193.google.com with SMTP id j19so3244676lja.1;
        Thu, 26 Sep 2019 11:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dFl1ZKp0Ywp0VhdaWYocm6hvzK4g2RN3+IcvO0KiVvI=;
        b=GwLPK+NLCpmb2EjbszdghyE2jhPmEbZNb1zFhrG8yAm3mA3EGJeu/yXnZ+/d8W5QWL
         QcbxsMiElBwOpG9Rwz3VOVCq2vxmawPmbX38xrJ1x+txqDeolUYy3eq/m5Q4UGRrTe0L
         H7FydFSxktwHoWSCTEnd8mwWi7ltLiLg/pgHENLgXIiy6OxHBnK3fsNUfRMnXtNmISQH
         Dmmy0n6dnIpz87AXYrjx9hbVYpKrUihmb/J5SHE0TfzyDHGkJk2pdbDEBC2+kjbLCRF7
         xGdsJD9IokaHfnV6HgeNAMUKfvLG4koEP8iRIR/tsHInMXpqDr1mE+dhrnrOe9zuIAH/
         5TYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dFl1ZKp0Ywp0VhdaWYocm6hvzK4g2RN3+IcvO0KiVvI=;
        b=FarsAzmgetMujBuv+5qmpokUcEXDFrJ1fehi3/fb9y5/r8c78bSieFm+aJPt5A+uqD
         56kIw0hJf3fowouyX9MfW7kf5oTZhjNdL4S1Uza0VVDyz1gcfy7xqND5F4rABnWpOMgR
         DO8WBrrVqprQlumfduUFeBMFrf3fJNT9TzNa1vAXwtcAUrtsPBpHRSdEqQhuL6AaL4Z5
         oGUyQqS5pZ30GKLTaTz3nXHoNdG4j1JP/gwT2weRzs++OT11eHswnMeItl0TgMvzdUtH
         zG35wttM1fjg57KIhztYwX71DpoI0tFv7YbOfYEmMeI6yNiYtoGvA7acfS476HUed/kq
         UBFg==
X-Gm-Message-State: APjAAAUZlHqFveJ5QS5w0BYkUt4FUre9ojdyBFdOuI9b/iQu35UqlEhr
        5rK+AgZjixqB4RrplQt2G1//etVL
X-Google-Smtp-Source: APXvYqwfVWwGVvCs/Ue8YlLmIOutb8eGQkSLca61uFEaO1XlQA+m70DA7jNXj4FOqD5DTZdrJMiqSg==
X-Received: by 2002:a2e:9185:: with SMTP id f5mr22753ljg.235.1569522832948;
        Thu, 26 Sep 2019 11:33:52 -0700 (PDT)
Received: from [192.168.2.145] (ppp94-29-32-67.pppoe.spdop.ru. [94.29.32.67])
        by smtp.googlemail.com with ESMTPSA id q21sm8335lfc.2.2019.09.26.11.33.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Sep 2019 11:33:51 -0700 (PDT)
Subject: Re: [PATCH v4 1/2] soc/tegra: pmc: Query PCLK clock rate at probe
 time
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Jon Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190804202927.15014-1-digetx@gmail.com>
 <23856887-06b0-66a8-1df2-ef4d7b48dc68@nvidia.com>
 <854c90c4-9e42-2020-5fa7-8711203f56a5@gmail.com>
 <c5a5a059-c949-1a25-c7ac-59d88ad9a026@nvidia.com>
 <ff1a790f-baba-dd0b-8cbe-f9468fbd56e3@gmail.com>
 <546ec91f-2486-21e1-9fdf-b3d087e176ed@gmail.com>
Message-ID: <4fb0ac32-863e-c922-471f-1dea8f95c53b@gmail.com>
Date:   Thu, 26 Sep 2019 21:33:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <546ec91f-2486-21e1-9fdf-b3d087e176ed@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

23.09.2019 16:36, Dmitry Osipenko пишет:
> 23.09.2019 16:31, Dmitry Osipenko пишет:
>> 23.09.2019 16:01, Jon Hunter пишет:
>>>
>>> On 23/09/2019 13:49, Dmitry Osipenko wrote:
>>>> 23.09.2019 13:56, Jon Hunter пишет:
>>>>>
>>>>>
>>>>> On 04/08/2019 21:29, Dmitry Osipenko wrote:
>>>>>> It is possible to get a lockup if kernel decides to enter LP2 cpuidle
>>>>>> from some clk-notifier, in that case CCF's "prepare" mutex is kept locked
>>>>>> and thus clk_get_rate(pclk) blocks on the same mutex with interrupts being
>>>>>> disabled.
>>>>>>
>>>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>>>>> ---
>>>>>>
>>>>>> Changelog:
>>>>>>
>>>>>> v4: Added clk-notifier to track PCLK rate-changes, which may become useful
>>>>>>     in the future. That's done in response to v3 review comment from Peter
>>>>>>     De Schrijver.
>>>>>>
>>>>>>     Now properly handling case where clk pointer is intentionally NULL on
>>>>>>     the driver's probe.
>>>>>>
>>>>>> v3: Changed commit's message because I actually recalled what was the
>>>>>>     initial reason for the patch, since the problem reoccurred once again.
>>>>>>
>>>>>> v2: Addressed review comments that were made by Jon Hunter to v1 by
>>>>>>     not moving the memory barrier, replacing one missed clk_get_rate()
>>>>>>     with pmc->rate, handling possible clk_get_rate() error on probe and
>>>>>>     slightly adjusting the commits message.
>>>>>>
>>>>>>  drivers/soc/tegra/pmc.c | 71 ++++++++++++++++++++++++++++++-----------
>>>>>>  1 file changed, 53 insertions(+), 18 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
>>>>>> index 9f9c1c677cf4..4e44943d0b26 100644
>>>>>> --- a/drivers/soc/tegra/pmc.c
>>>>>> +++ b/drivers/soc/tegra/pmc.c
>>>>>> @@ -309,6 +309,7 @@ static const char * const tegra210_reset_sources[] = {
>>>>>>   * @pctl_dev: pin controller exposed by the PMC
>>>>>>   * @domain: IRQ domain provided by the PMC
>>>>>>   * @irq: chip implementation for the IRQ domain
>>>>>> + * @clk_nb: pclk clock changes handler
>>>>>>   */
>>>>>>  struct tegra_pmc {
>>>>>>  	struct device *dev;
>>>>>> @@ -344,6 +345,8 @@ struct tegra_pmc {
>>>>>>  
>>>>>>  	struct irq_domain *domain;
>>>>>>  	struct irq_chip irq;
>>>>>> +
>>>>>> +	struct notifier_block clk_nb;
>>>>>>  };
>>>>>>  
>>>>>>  static struct tegra_pmc *pmc = &(struct tegra_pmc) {
>>>>>> @@ -1192,7 +1195,7 @@ static int tegra_io_pad_prepare(struct tegra_pmc *pmc, enum tegra_io_pad id,
>>>>>>  		return err;
>>>>>>  
>>>>>>  	if (pmc->clk) {
>>>>>> -		rate = clk_get_rate(pmc->clk);
>>>>>> +		rate = pmc->rate;
>>>>>>  		if (!rate) {
>>>>>>  			dev_err(pmc->dev, "failed to get clock rate\n");
>>>>>>  			return -ENODEV;
>>>>>
>>>>> So this error should never happen now, right? Assuming that rate is
>>>>> never set to 0. But ...
>>>>
>>>> Good catch!
>>>>
>>>>>> @@ -1433,6 +1436,7 @@ void tegra_pmc_set_suspend_mode(enum tegra_suspend_mode mode)
>>>>>>  void tegra_pmc_enter_suspend_mode(enum tegra_suspend_mode mode)
>>>>>>  {
>>>>>>  	unsigned long long rate = 0;
>>>>>> +	u64 ticks;
>>>>>>  	u32 value;
>>>>>>  
>>>>>>  	switch (mode) {
>>>>>> @@ -1441,31 +1445,22 @@ void tegra_pmc_enter_suspend_mode(enum tegra_suspend_mode mode)
>>>>>>  		break;
>>>>>>  
>>>>>>  	case TEGRA_SUSPEND_LP2:
>>>>>> -		rate = clk_get_rate(pmc->clk);
>>>>>> +		rate = pmc->rate;
>>>>>>  		break;
>>>>>>  
>>>>>>  	default:
>>>>>>  		break;
>>>>>>  	}
>>>>>>  
>>>>>> -	if (WARN_ON_ONCE(rate == 0))
>>>>>> -		rate = 100000000;
>>>>>> -
>>>>>> -	if (rate != pmc->rate) {
>>>>>> -		u64 ticks;
>>>>>> -
>>>>>> -		ticks = pmc->cpu_good_time * rate + USEC_PER_SEC - 1;
>>>>>> -		do_div(ticks, USEC_PER_SEC);
>>>>>> -		tegra_pmc_writel(pmc, ticks, PMC_CPUPWRGOOD_TIMER);
>>>>>> +	ticks = pmc->cpu_good_time * rate + USEC_PER_SEC - 1;
>>>>>> +	do_div(ticks, USEC_PER_SEC);
>>>>>> +	tegra_pmc_writel(pmc, ticks, PMC_CPUPWRGOOD_TIMER);
>>>>>>  
>>>>>> -		ticks = pmc->cpu_off_time * rate + USEC_PER_SEC - 1;
>>>>>> -		do_div(ticks, USEC_PER_SEC);
>>>>>> -		tegra_pmc_writel(pmc, ticks, PMC_CPUPWROFF_TIMER);
>>>>>> +	ticks = pmc->cpu_off_time * rate + USEC_PER_SEC - 1;
>>>>>> +	do_div(ticks, USEC_PER_SEC);
>>>>>> +	tegra_pmc_writel(pmc, ticks, PMC_CPUPWROFF_TIMER);
>>>>>>  
>>>>>> -		wmb();
>>>>>> -
>>>>>> -		pmc->rate = rate;
>>>>>> -	}
>>>>>> +	wmb();
>>>>>>  
>>>>>>  	value = tegra_pmc_readl(pmc, PMC_CNTRL);
>>>>>>  	value &= ~PMC_CNTRL_SIDE_EFFECT_LP0;
>>>>>> @@ -2019,6 +2014,20 @@ static int tegra_pmc_irq_init(struct tegra_pmc *pmc)
>>>>>>  	return 0;
>>>>>>  }
>>>>>>  
>>>>>> +static int tegra_pmc_clk_notify_cb(struct notifier_block *nb,
>>>>>> +				   unsigned long action, void *ptr)
>>>>>> +{
>>>>>> +	struct clk_notifier_data *data = ptr;
>>>>>> +	struct tegra_pmc *pmc;
>>>>>> +
>>>>>> +	if (action == POST_RATE_CHANGE) {
>>>>>> +		pmc = container_of(nb, struct tegra_pmc, clk_nb);
>>>>>> +		pmc->rate = data->new_rate;
>>>>>> +	}
>>>>>> +
>>>>>> +	return NOTIFY_OK;
>>>>>> +}
>>>>>> +
>>>>>>  static int tegra_pmc_probe(struct platform_device *pdev)
>>>>>>  {
>>>>>>  	void __iomem *base;
>>>>>> @@ -2082,6 +2091,30 @@ static int tegra_pmc_probe(struct platform_device *pdev)
>>>>>>  		pmc->clk = NULL;
>>>>>>  	}
>>>>>>  
>>>>>> +	/*
>>>>>> +	 * PCLK clock rate can't be retrieved using CLK API because it
>>>>>> +	 * causes lockup if CPU enters LP2 idle state from some other
>>>>>> +	 * CLK notifier, hence we're caching the rate's value locally.
>>>>>> +	 */
>>>>>> +	if (pmc->clk) {
>>>>>> +		pmc->clk_nb.notifier_call = tegra_pmc_clk_notify_cb;
>>>>>> +		err = clk_notifier_register(pmc->clk, &pmc->clk_nb);
>>>>>> +		if (err) {
>>>>>> +			dev_err(&pdev->dev,
>>>>>> +				"failed to register clk notifier\n");
>>>>>> +			return err;
>>>>>> +		}
>>>>>> +
>>>>>> +		pmc->rate = clk_get_rate(pmc->clk);
>>>>>> +	}
>>>>>> +
>>>>>> +	if (!pmc->rate) {
>>>>>> +		if (pmc->clk)
>>>>>> +			dev_err(&pdev->dev, "failed to get pclk rate\n");
>>>>>> +
>>>>>> +		pmc->rate = 100000000;
>>>>>
>>>>> I wonder if we should just let this fail. Or set to 0 so that if the
>>>>> rate is not set we will never suspend or configure the IO pads? I could
>>>>> run some quick tests to see if there are any problems by failing here.
>>>>
>>>> Do you mean to fail the PMC driver to probe? I guess that will be fatal
>>>> and system won't be in a useful state, from a user perspective that
>>>> should be equal to a hang on boot with a black screen. On the other
>>>> hand, it seems that failing tegra_io_pad_prepare() should have similar
>>>> fatal result.
>>>>
>>>> I'm wondering whether that IO PAD misconfiguration could be harmful. If
>>>> not, then looks like falling back to 100Mhz should be good enough. In
>>>> practice clk_get_rate() shouldn't ever fail unless there is some serious
>>>> bug in clk/. What do you think?
>>>
>>> Exactly. I think that if clk_get_rate() is failing then something bad is
>>> happening. I can see if this causes any obvious problems across the
>>> different boards we test, but it would be great to get rid of this
>>> 100MHz value (unless Peter knows of a good reason to keep it).
>>
>> Okay!
>>
>> Peter, do you have any thoughts about whether it worth to keep the
>> 100MHz workaround?
>>
>> BTW.. looking at tegra_io_pad_prepare() again, I think that it should be
>> fine to simply keep the clk_get_rate() there.
> 
> [it will be fine without having the clk notifier or without the locking
> within the notifier that I suggested below]
> 
>> It also looks like clk notifier should actually take powergates_lock to
>> be really robust and not potentially race with tegra_io_pad_prepare(). I
>> can fix up it in v5, but.. maybe it will be better to postpone the clk
>> notifier addition until there will be a real use-case for PMC clk
>> freq-scaling and for now assume that clk rate is static?

I'll make a new version that has proper locking and preserves the
original 100MHz fallback logic, any other changes could be made on top
of it. Let's continue in the new thread.
