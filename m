Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D70C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 14:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3590724AEC
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 14:59:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZY7495ce"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbfFDO7i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 10:59:38 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45389 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727913AbfFDO7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 10:59:33 -0400
Received: by mail-lf1-f66.google.com with SMTP id u10so9669046lfm.12;
        Tue, 04 Jun 2019 07:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SD6HfIZbi8wMOY2Id0Tt+HtWegnuLFYwrZ8yF6OM2aI=;
        b=ZY7495ce7QAOj6O1FfzvGzPVnkXdy8rsY3pn/MS+XfQJpcE7wnglcTGhLnzlHfiE15
         k9CPb7A0sDbK1Fbk4kMmvbt4qDzM45Y26F7+mREjAE5Q8OVfluD5UZZFHKaqyItSXyjI
         ThLi7bnuA9qFh27T/xgOQNFQDXFZadlX5mFu6n8G4e7prKFtjS8rpDuudCZbUSAuh9gn
         icffP8IfURSbqiDaSi74UkyezLzFBYA/ZGYYYbSfMrHjLgSU5fGmFj6Q5JpcZYN/HWfz
         UXQDzoa5p1I+ed2If+BHl4qaijsUX7yQdpxxe4ZKqcvAEYnek8/Qtb0jIzkvHWrvHG6V
         IXfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SD6HfIZbi8wMOY2Id0Tt+HtWegnuLFYwrZ8yF6OM2aI=;
        b=FSGRWri5tvNwIUBhOE8PR/1KyGK8LOz4trfxPrvQui79XcQQVWS0Sp+rQFLTS5V+eT
         uvcO9IiHdNQOi16VSgIna6fRZ1shYPF9SyYa7ahtYlODLPmNYQXm4/UpoMXm309OnC3q
         LgRUrN9WUdqezNFOiZhYNYfL3VbzTVhi2vdLr1qIKKNm82ac7EdJ/3Z2xbH8Xhsn0gpW
         nspiZwKEYZT4AsuKQaOIgDAKkLwTQKRtxwD7Iyui+GvSz1+GEmAolNW7Fd35mpNKZtqC
         aeT48CRn1yEt6x3d1+8jJyGO0+5FVdYyVv7Eq5tlpwOQ5iKx8PUzk8HuDP01DX8W7vsZ
         +O8g==
X-Gm-Message-State: APjAAAUIuQclAtyW8PDDgExO3hFXpTQqqItydPVLnM40RutJ+1xJ1/ms
        yZimkbqKTHQbCQe5xXOKOtAngWOC
X-Google-Smtp-Source: APXvYqxTjpD5zkrGN5wvl2r3a1cp0QsmeoCORET5P87osoK6fOwXVB+/33u/wVHvQGYWt7OQxFcxqQ==
X-Received: by 2002:a19:9e53:: with SMTP id h80mr16575642lfe.77.1559660370429;
        Tue, 04 Jun 2019 07:59:30 -0700 (PDT)
Received: from [192.168.2.145] ([94.29.35.141])
        by smtp.googlemail.com with ESMTPSA id m25sm2781939lfp.97.2019.06.04.07.59.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 07:59:28 -0700 (PDT)
Subject: Re: [PATCH v4 07/16] PM / devfreq: tegra: Properly disable interrupts
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190501233815.32643-1-digetx@gmail.com>
 <20190501233815.32643-8-digetx@gmail.com> <20190604110744.GG16519@ulmo>
 <c2f2a8c8-1f30-34aa-9b95-a7a44e0ec96f@gmail.com> <20190604140633.GA397@ulmo>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <f322485b-4118-7e9a-e2e5-6d3ae9bccd27@gmail.com>
Date:   Tue, 4 Jun 2019 17:59:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190604140633.GA397@ulmo>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

04.06.2019 17:06, Thierry Reding пишет:
> On Tue, Jun 04, 2019 at 04:40:18PM +0300, Dmitry Osipenko wrote:
>> 04.06.2019 14:07, Thierry Reding пишет:
>>> On Thu, May 02, 2019 at 02:38:06AM +0300, Dmitry Osipenko wrote:
>>>> There is no guarantee that interrupt handling isn't running in parallel
>>>> with tegra_actmon_disable_interrupts(), hence it is necessary to protect
>>>> DEV_CTRL register accesses and clear IRQ status with ACTMON's IRQ being
>>>> disabled in the Interrupt Controller in order to ensure that device
>>>> interrupt is indeed being disabled.
>>>>
>>>> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>>> ---
>>>>  drivers/devfreq/tegra-devfreq.c | 21 +++++++++++++++------
>>>>  1 file changed, 15 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
>>>> index b65313fe3c2e..ce1eb97a2090 100644
>>>> --- a/drivers/devfreq/tegra-devfreq.c
>>>> +++ b/drivers/devfreq/tegra-devfreq.c
>>>> @@ -171,6 +171,8 @@ struct tegra_devfreq {
>>>>  	struct notifier_block	rate_change_nb;
>>>>  
>>>>  	struct tegra_devfreq_device devices[ARRAY_SIZE(actmon_device_configs)];
>>>> +
>>>> +	int irq;
>>>
>>> Interrupts are typically unsigned int.
>>>
>>>>  };
>>>>  
>>>>  struct tegra_actmon_emc_ratio {
>>>> @@ -417,6 +419,8 @@ static void tegra_actmon_disable_interrupts(struct tegra_devfreq *tegra)
>>>>  	u32 val;
>>>>  	unsigned int i;
>>>>  
>>>> +	disable_irq(tegra->irq);
>>>> +
>>>>  	for (i = 0; i < ARRAY_SIZE(tegra->devices); i++) {
>>>>  		dev = &tegra->devices[i];
>>>>  
>>>> @@ -427,9 +431,14 @@ static void tegra_actmon_disable_interrupts(struct tegra_devfreq *tegra)
>>>>  		val &= ~ACTMON_DEV_CTRL_CONSECUTIVE_ABOVE_WMARK_EN;
>>>>  
>>>>  		device_writel(dev, val, ACTMON_DEV_CTRL);
>>>> +
>>>> +		device_writel(dev, ACTMON_INTR_STATUS_CLEAR,
>>>> +			      ACTMON_DEV_INTR_STATUS);
>>>>  	}
>>>>  
>>>>  	actmon_write_barrier(tegra);
>>>> +
>>>> +	enable_irq(tegra->irq);
>>>
>>> Why do we enable interrupts after this? Is there any use in having the
>>> top-level interrupt enabled if nothing's going to generate an interrupt
>>> anyway?
>>
>> There is no real point in having the interrupt enabled other than to
>> keep the enable count balanced.
>>
>> IIUC, we will need to disable IRQ at the driver's probe time (after
>> requesting the IRQ) if we want to avoid that (not really necessary)
>> balancing. This is probably something that could be improved in a
>> follow-up patches, if desired.
>>
>>>>  }
>>>>  
>>>>  static void tegra_actmon_configure_device(struct tegra_devfreq *tegra,
>>>> @@ -604,7 +613,6 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>>>>  	struct resource *res;
>>>>  	unsigned int i;
>>>>  	unsigned long rate;
>>>> -	int irq;
>>>>  	int err;
>>>>  
>>>>  	tegra = devm_kzalloc(&pdev->dev, sizeof(*tegra), GFP_KERNEL);
>>>> @@ -673,15 +681,16 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>>>>  		dev_pm_opp_add(&pdev->dev, rate, 0);
>>>>  	}
>>>>  
>>>> -	irq = platform_get_irq(pdev, 0);
>>>> -	if (irq < 0) {
>>>> -		dev_err(&pdev->dev, "Failed to get IRQ: %d\n", irq);
>>>> -		return irq;
>>>> +	tegra->irq = platform_get_irq(pdev, 0);
>>>> +	if (tegra->irq < 0) {
>>>> +		err = tegra->irq;
>>>> +		dev_err(&pdev->dev, "Failed to get IRQ: %d\n", err);
>>>> +		return err;
>>>>  	}
>>>
>>> This is very oddly written. tegra->irq should really be an unsigned int
>>> since that's the standard type for interrupt numbers. But since you need
>>> to be able to detect errors from platform_get_irq() it now becomes
>>> natural to write this as:
>>>
>>> 	err = platform_get_irq(pdev, 0);
>>> 	if (err < 0) {
>>> 		dev_err(...);
>>> 		return err;
>>> 	}
>>>
>>> 	tegra->irq = err;
>>>
>>> Two birds with one stone. I suppose this could be done in a follow-up
>>> patch since it isn't practically wrong in your version, so either way:
>>>
>>> Acked-by: Thierry Reding <treding@nvidia.com>
>>>
>>
>> Thank you for the ACK! Although, I disagree with yours suggestion, to me
>> that makes code a bit less straightforward and it's not really
>> worthwhile to bloat the code just because technically IRQ's are unsigned
>> numbers (we don't care about that). It also makes me a bit uncomfortable
>> to see "err" assigned to a variable, I don't think it's a good practice.
> 
> Actually you should care that IRQs are unsigned. Implicit casting from
> a potentially negative value can hide bugs. That is, once you've passed
> that negative value into the IRQ API you loose the context that it could
> be an error code. Hence I think it makes sense to always store values in
> the native type, and only store them if they are actually valid.
> 
> In the above you have an error value in tegra->irq. In this particular
> case it's pretty harmless because you don't do anything with it, but if
> the circumstances were slightly different that could lead to problems
> down the road.
> 
> On the other hand what I was proposing makes it pretty clear from the
> context that err contains a valid interrupt number when it is assigned
> to tegra->irq. There's plenty of similar constructs in the kernel if you
> want to grep for it.
> 
> Also, it's not bloating the code at all. It's the exact same number of
> lines of code as your variant.

I agree that it is better to maintain proper typing everywhere in
general, I have been bitten so many times by typecasting bugs..
Opentegra's Bool (unsigned) -> BOOL (signed) casting horror was the most
recent one. Well, I guess indeed it won't hurt to apply your suggestion
in a follow-up patch to keep things a bit more consistent.
