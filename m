Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D16FC10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 00:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DA7821773
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 00:31:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="SpSbBTRp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731009AbfDQAbQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 20:31:16 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:36434 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728856AbfDQAbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 20:31:15 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190417003111epoutp01decc4c9badcea8b06b96bc921c392777~WG5pgzxZ11220112201epoutp01K
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 00:31:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190417003111epoutp01decc4c9badcea8b06b96bc921c392777~WG5pgzxZ11220112201epoutp01K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1555461071;
        bh=/fwUGWBYXm3xLapEYxQzr3nmjHWGj0LDUGEc5xzfj6o=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=SpSbBTRpHla3qsJr91ifVxjoandV3Oc9gG6yRNmZqRa8j3dsfIoppOL9C9iZyP+M6
         xZTx56Aw9C0Qy2b2A0Ay3Qd3eCr8yy0J7iXgKLf+WYu0YPsnmw5tZodwE8b39gYGJP
         /C+4CVpTN9CgsqvuvX1skkeWe127BUED49rTr3mg=
Received: from epsmges1p2.samsung.com (unknown [182.195.40.157]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190417003108epcas1p1146c702cee410865976728c2fe3ca809~WG5nEHw2v3134331343epcas1p1a;
        Wed, 17 Apr 2019 00:31:08 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        5D.5A.04142.6C376BC5; Wed, 17 Apr 2019 09:31:02 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20190417003102epcas1p4a37ed453bce822c67ce9492e1295b0a1~WG5haSf4H0063600636epcas1p4r;
        Wed, 17 Apr 2019 00:31:02 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190417003102epsmtrp145caec57f071cddc6cdab88c96f5612e~WG5hZi6nR1476014760epsmtrp1G;
        Wed, 17 Apr 2019 00:31:02 +0000 (GMT)
X-AuditID: b6c32a36-ce1ff7000000102e-8e-5cb673c6cd51
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        7D.37.03662.6C376BC5; Wed, 17 Apr 2019 09:31:02 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190417003102epsmtip1cdef4e93f400c49aa1eca1fa10af95c3~WG5hRkr5N2434524345epsmtip1K;
        Wed, 17 Apr 2019 00:31:02 +0000 (GMT)
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
Message-ID: <c10de3f3-b1ce-7f9b-5991-075581fbff24@samsung.com>
Date:   Wed, 17 Apr 2019 09:31:58 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <286d8d4a-f761-93d3-8b77-cf71a7d0dab3@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHJsWRmVeSWpSXmKPExsWy7bCmnu6x4m0xBrPWWVus/viY0aJl1iIW
        i7NNb9gtLu+aw2bxufcIo0Xnl1lsFrcbV7BZ/Nw1j8Wib+0lNgdOjx13lzB67Jx1l92jt/kd
        m0ffllWMHp83yQWwRmXbZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoq
        ufgE6Lpl5gAdpKRQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkpsCzQK07MLS7NS9dL
        zs+1MjQwMDIFKkzIzvh6cjNrQbduxd9r9xgbGLtVuxg5OSQETCRam6czdzFycQgJ7GCU+HV8
        CZTziVHi59KLUM43Rok7Czaww7ScmXuTCcQWEtjLKHF2agVE0XtGid6jj1lBEsICwRJ3L81g
        A0mICPxjlPi0awZYglkgUuLrwaXMIDabgJbE/hc32EBsfgFFias/HjOC2LwCdhJLpzwA2sDB
        wSKgKnH5aDhIWFQgQuL+sQ2sECWCEidnPmEBsTkFbCXWv93EDDFeXOLWk/lMELa8RPPW2WAf
        SAg0s0tMfn2VDeIDF4mlk2exQNjCEq+Ob4H6TEriZX8blF0tsfLkETaI5g5GiS37L7BCJIwl
        9i+dDHYcs4CmxPpd+hDL+CTefe1hBQlLCPBKdLQJQVQrS1x+cJcJwpaUWNzeyQZR4iFx75XJ
        BEbFWUi+mYXkg1lIPpiFsGsBI8sqRrHUguLc9NRiwwIj5MjexAhOq1pmOxgXnfM5xCjAwajE
        w7vi59YYIdbEsuLK3EOMEhzMSiK8jilbYoR4UxIrq1KL8uOLSnNSiw8xmgLDeiKzlGhyPjDl
        55XEG5oaGRsbW5gYmpkaGiqJ8653cI4REkhPLEnNTk0tSC2C6WPi4JRqYFyfy3oxsW215qKO
        6iNun068tr9x4bzBqg+CjQdvnDoblNles7+mTWnTqTL5debT5HtOZJr5Sh3/cSj7+RvXVX9S
        JbPm36yXXFkX0Kuh/0bUsYIrNmfqDel3MrGdWcZFdbVZ3DbcSmcSpK0iLS1FnNtjYxiY2qtX
        3XaYbfH5+FGGMh9P9rNhSizFGYmGWsxFxYkAiMYrocEDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRmVeSWpSXmKPExsWy7bCSnO6x4m0xBqefSlqs/viY0aJl1iIW
        i7NNb9gtLu+aw2bxufcIo0Xnl1lsFrcbV7BZ/Nw1j8Wib+0lNgdOjx13lzB67Jx1l92jt/kd
        m0ffllWMHp83yQWwRnHZpKTmZJalFunbJXBlfD25mbWgW7fi77V7jA2M3apdjJwcEgImEmfm
        3mTqYuTiEBLYzShxfdozdoiEpMS0i0eZuxg5gGxhicOHiyFq3jJKHJ88kRWkRlggWOLupRls
        IAkRgSYmic8PW5hAEswCkRL9j7pZITrmMUkc3zeHGSTBJqAlsf/FDTYQm19AUeLqj8eMIDav
        gJ3E0ikPmEC2sQioSlw+Gg4SFhWIkDjzfgULRImgxMmZT8BsTgFbifVvNzFD7FKX+DPvEpQt
        LnHryXyoG+QlmrfOZp7AKDwLSfssJC2zkLTMQtKygJFlFaNkakFxbnpusWGBUV5quV5xYm5x
        aV66XnJ+7iZGcIxpae1gPHEi/hCjAAejEg/vip9bY4RYE8uKK3MPMUpwMCuJ8DqmbIkR4k1J
        rKxKLcqPLyrNSS0+xCjNwaIkziuffyxSSCA9sSQ1OzW1ILUIJsvEwSnVwFgaWbX5DUvk0cn1
        3y8/+mB4s7LW3aKv9OKfpgQ7jhVyX9befvVrQ7iTSv0JHn+3Eys2vGoPvqH35FBg1PNbmS5M
        f0/u3bdOOnZSUPwpv+IcN5vNFvJXSv9vv7hw1uGd56fZbppudam1qfak2Id19lrK638zdnet
        qeyqs5yWFamW/ZbTf9ZcxmIlluKMREMt5qLiRAAB7KXSrQIAAA==
X-CMS-MailID: 20190417003102epcas1p4a37ed453bce822c67ce9492e1295b0a1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190415145737epcas1p39300df7ef83ed20bd7aaa4e920d1f475
References: <20190415145505.18397-1-digetx@gmail.com>
        <CGME20190415145737epcas1p39300df7ef83ed20bd7aaa4e920d1f475@epcas1p3.samsung.com>
        <20190415145505.18397-11-digetx@gmail.com>
        <93574885-d695-2288-a4c6-2b845ad8daaf@samsung.com>
        <286d8d4a-f761-93d3-8b77-cf71a7d0dab3@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 19. 4. 17. 오전 12:23, Dmitry Osipenko wrote:
> 16.04.2019 8:56, Chanwoo Choi пишет:
>> Hi,
>>
>> It looks good to me to drop the primary interrupt handler
>> but I have some comments. Please check it.
>>
>> On 19. 4. 15. 오후 11:54, Dmitry Osipenko wrote:
>>> There is no real need in the primary interrupt handler, hence move
>>> everything to the secondary (threaded) handler. In a result locking
>>> is consistent now and there are no potential races with the interrupt
>>> handler because it is protected with the devfreq's mutex.
>>>
>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>> ---
>>>  drivers/devfreq/tegra-devfreq.c | 61 ++++++++++++---------------------
>>>  1 file changed, 22 insertions(+), 39 deletions(-)
>>>
>>> diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
>>> index 2a1464098200..69b557df5084 100644
>>> --- a/drivers/devfreq/tegra-devfreq.c
>>> +++ b/drivers/devfreq/tegra-devfreq.c
>>> @@ -144,7 +144,6 @@ static struct tegra_devfreq_device_config actmon_device_configs[] = {
>>>  struct tegra_devfreq_device {
>>>  	const struct tegra_devfreq_device_config *config;
>>>  	void __iomem *regs;
>>> -	spinlock_t lock;
>>>  
>>>  	/* Average event count sampled in the last interrupt */
>>>  	u32 avg_count;
>>> @@ -249,11 +248,8 @@ static void actmon_write_barrier(struct tegra_devfreq *tegra)
>>>  static void actmon_isr_device(struct tegra_devfreq *tegra,
>>>  			      struct tegra_devfreq_device *dev)
>>>  {
>>> -	unsigned long flags;
>>>  	u32 intr_status, dev_ctrl;
>>>  
>>> -	spin_lock_irqsave(&dev->lock, flags);
>>> -
>>>  	dev->avg_count = device_readl(dev, ACTMON_DEV_AVG_COUNT);
>>>  	tegra_devfreq_update_avg_wmark(tegra, dev);
>>>  
>>> @@ -302,26 +298,6 @@ static void actmon_isr_device(struct tegra_devfreq *tegra,
>>>  	device_writel(dev, ACTMON_INTR_STATUS_CLEAR, ACTMON_DEV_INTR_STATUS);
>>>  
>>>  	actmon_write_barrier(tegra);
>>> -
>>> -	spin_unlock_irqrestore(&dev->lock, flags);
>>> -}
>>> -
>>> -static irqreturn_t actmon_isr(int irq, void *data)
>>> -{
>>> -	struct tegra_devfreq *tegra = data;
>>> -	bool handled = false;
>>> -	unsigned int i;
>>> -	u32 val;
>>> -
>>> -	val = actmon_readl(tegra, ACTMON_GLB_STATUS);
>>> -	for (i = 0; i < ARRAY_SIZE(tegra->devices); i++) {
>>> -		if (val & tegra->devices[i].config->irq_mask) {
>>> -			actmon_isr_device(tegra, tegra->devices + i);
>>> -			handled = true;
>>> -		}
>>> -	}
>>> -
>>> -	return handled ? IRQ_WAKE_THREAD : IRQ_NONE;
>>>  }
>>>  
>>>  static unsigned long actmon_cpu_to_emc_rate(struct tegra_devfreq *tegra,
>>> @@ -348,35 +324,46 @@ static void actmon_update_target(struct tegra_devfreq *tegra,
>>>  	unsigned long cpu_freq = 0;
>>>  	unsigned long static_cpu_emc_freq = 0;
>>>  	unsigned int avg_sustain_coef;
>>> -	unsigned long flags;
>>> +	u32 avg_count;
>>>  
>>>  	if (dev->config->avg_dependency_threshold) {
>>>  		cpu_freq = cpufreq_get(0);
>>>  		static_cpu_emc_freq = actmon_cpu_to_emc_rate(tegra, cpu_freq);
>>>  	}
>>>  
>>> -	spin_lock_irqsave(&dev->lock, flags);
>>> -
>>> -	dev->target_freq = dev->avg_count / ACTMON_SAMPLING_PERIOD;
>>> +	avg_count = dev->avg_count;
>>> +	dev->target_freq = avg_count / ACTMON_SAMPLING_PERIOD;
>>
>> Actually, this change is not related to this patch.
>> Please keep the original code.
>>
>>>  	avg_sustain_coef = 100 * 100 / dev->config->boost_up_threshold;
>>>  	dev->target_freq = do_percent(dev->target_freq, avg_sustain_coef);
>>>  	dev->target_freq += dev->boost_freq;
>>>  
>>> -	if (dev->avg_count >= dev->config->avg_dependency_threshold)
>>> +	if (avg_count >= dev->config->avg_dependency_threshold)
>>
>> ditto.
> 
> Good catch, it's a leftover from v1 that I forgot to revert. Thank you.
> 
> [snip]
> 
>>
>> When I review this patch, I have a question
>> about why tegra_actmon_rate_notify_cb is needed.
>>
>> tegra_actmon_rate_notify_cb() do something
>> when the clock rate of emc_clock is changed.
>> I think that 'emc_clock' is changed by this driver.
>> It means that the this driver can catch the change timing
>> of emc_clock rate without notifier. 
> 
> The devfreq driver isn't the only driver of the EMC clock rate. The devfreq driver changes EMC freq dynamically based of on average memory usage activity, but for some hardware units (like display controller for example) there is a requirement for a minimum memory bandwidth (isochronous transactions) and hence when display is waking up from suspend it immediately requires an amount of memory bandwidth that could be higher than ACTMON hardware unit suggests and besides the ACTMON's reaction is delayed by the sampling period (12ms).

Thanks for explaining it. If EMC clock is used on multiple point,
I understand why the clock notifier is necessary.

> 
>> IMO, it is possible to call tegra_devfreq_update_wmark()
>> directly without clock notifier before calling
>> 'clk_set_min_rate()/clk_set_rate()' in the tegra_devfreq_target().
>>
>> With clock notifier, it cannot restore something for
>> tegra_devfreq_update_wmark(tegra, dev) when failed to
>> set the rate of emc_clk by 'clk_set_min_rate()/clk_set_rate()'.
> 
> The watermarks should be changed in accordance to the actual EMC clock rate. Given that EMC rate could be changed by something else than the devfreq driver, we need to re-adjust the watermarks to the actual values after the EMC rate-change completion. Please note that the clock notifier uses the POST_RATE_CHANGE event that happens only after successful completion of EMC clock rate change.

I understand the needs of clock notifier. Thanks.

> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
