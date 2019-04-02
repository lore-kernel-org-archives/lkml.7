Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D56C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 15:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA6DB20645
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 15:50:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="YwSvRg4Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730921AbfDBPu1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 11:50:27 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:3395 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728448AbfDBPu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 11:50:26 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ca384be0000>; Tue, 02 Apr 2019 08:50:22 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 02 Apr 2019 08:50:24 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 02 Apr 2019 08:50:24 -0700
Received: from [10.19.108.132] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 2 Apr
 2019 15:50:23 +0000
Subject: Re: [PATCH] clocksource/drivers/tegra: rework for compensation of
 suspend time
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        <linux-kernel@vger.kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        <linux-tegra@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-arm-kernel@lists.infradead.org>
References: <20190402030234.13488-1-josephl@nvidia.com>
 <20190402144603.GE8017@ulmo>
From:   Joseph Lo <josephl@nvidia.com>
Message-ID: <01028c3a-8e2e-835b-f886-ca5b85474cd2@nvidia.com>
Date:   Tue, 2 Apr 2019 23:50:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190402144603.GE8017@ulmo>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1554220222; bh=q9txnQ4W+e9sAEuFTH4iLiqz4V88OzIpqVl8VyWZIVU=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=YwSvRg4YkXsN3Kqk1QS7+0rhO0pI1VrfvpxJDC/gm+CdsNNwJk+gsG00AiBROVFSI
         NcTHavGcfS9xZD5iAJuVRxAiBl9om4L2xU+/A0WNTm54xK0rGjaqEwvrItew24SRGj
         y93m6pc7ZoLmFFSbZUq7ntpO4cAqYkTKkNzhhoGpuc9jzS4oTL7en3hl8K4n5ehUGq
         rr0B9sZEGT9OyyYYLkqMfjbmYJjhKBJ9xuKYuUxZz1FuecO3INEfFEQIV2PK/OjXn0
         u1RErLn2sjJHC5uyguxqNqR2cUs1Sk0C5+qyKpCuxzk07hh3e17bIJy0msMrdUvEeW
         cPh2ukEx3W+Kg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/2/19 10:46 PM, Thierry Reding wrote:
> On Tue, Apr 02, 2019 at 11:02:34AM +0800, Joseph Lo wrote:
>> Since the clocksource framework has the support for suspend time
>> compensation. Re-work the driver to use that, so we can reduce the
>> duplicate code.
>>
>> Suggested-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Signed-off-by: Joseph Lo <josephl@nvidia.com>
>> ---
>>   drivers/clocksource/timer-tegra20.c | 63 +++++++++--------------------
>>   1 file changed, 20 insertions(+), 43 deletions(-)
> 
> Nice!
> 
>>
>> diff --git a/drivers/clocksource/timer-tegra20.c b/drivers/clocksource/timer-tegra20.c
>> index fdb3d795a409..919b3568c495 100644
>> --- a/drivers/clocksource/timer-tegra20.c
>> +++ b/drivers/clocksource/timer-tegra20.c
>> @@ -60,9 +60,6 @@
>>   static u32 usec_config;
>>   static void __iomem *timer_reg_base;
>>   #ifdef CONFIG_ARM
>> -static void __iomem *rtc_base;
>> -static struct timespec64 persistent_ts;
>> -static u64 persistent_ms, last_persistent_ms;
>>   static struct delay_timer tegra_delay_timer;
>>   #endif
>>   
>> @@ -199,40 +196,30 @@ static unsigned long tegra_delay_timer_read_counter_long(void)
>>   	return readl(timer_reg_base + TIMERUS_CNTR_1US);
>>   }
>>   
>> +static struct timer_of suspend_rtc_to = {
>> +	.flags = TIMER_OF_BASE | TIMER_OF_CLOCK,
>> +};
>> +
>>   /*
>>    * tegra_rtc_read - Reads the Tegra RTC registers
>>    * Care must be taken that this funciton is not called while the
>>    * tegra_rtc driver could be executing to avoid race conditions
>>    * on the RTC shadow register
>>    */
>> -static u64 tegra_rtc_read_ms(void)
>> +static u64 tegra_rtc_read_ms(struct clocksource *cs)
>>   {
>> -	u32 ms = readl(rtc_base + RTC_MILLISECONDS);
>> -	u32 s = readl(rtc_base + RTC_SHADOW_SECONDS);
>> +	u32 ms = readl(timer_of_base(&suspend_rtc_to) + RTC_MILLISECONDS);
>> +	u32 s = readl(timer_of_base(&suspend_rtc_to) + RTC_SHADOW_SECONDS);
>>   	return (u64)s * MSEC_PER_SEC + ms;
>>   }
>>   
>> -/*
>> - * tegra_read_persistent_clock64 -  Return time from a persistent clock.
>> - *
>> - * Reads the time from a source which isn't disabled during PM, the
>> - * 32k sync timer.  Convert the cycles elapsed since last read into
>> - * nsecs and adds to a monotonically increasing timespec64.
>> - * Care must be taken that this funciton is not called while the
>> - * tegra_rtc driver could be executing to avoid race conditions
>> - * on the RTC shadow register
>> - */
>> -static void tegra_read_persistent_clock64(struct timespec64 *ts)
>> -{
>> -	u64 delta;
>> -
>> -	last_persistent_ms = persistent_ms;
>> -	persistent_ms = tegra_rtc_read_ms();
>> -	delta = persistent_ms - last_persistent_ms;
>> -
>> -	timespec64_add_ns(&persistent_ts, delta * NSEC_PER_MSEC);
>> -	*ts = persistent_ts;
>> -}
>> +static struct clocksource suspend_rtc_clocksource = {
>> +	.name	= "tegra_suspend_timer",
>> +	.rating	= 200,
>> +	.read	= tegra_rtc_read_ms,
>> +	.mask	= CLOCKSOURCE_MASK(32),
>> +	.flags	= CLOCK_SOURCE_IS_CONTINUOUS | CLOCK_SOURCE_SUSPEND_NONSTOP,
>> +};
>>   #endif
>>   
>>   static int tegra_timer_common_init(struct device_node *np, struct timer_of *to)
>> @@ -385,25 +372,15 @@ static int __init tegra_init_timer(struct device_node *np)
>>   
>>   static int __init tegra20_init_rtc(struct device_node *np)
>>   {
>> -	struct clk *clk;
>> +	int ret;
>>   
>> -	rtc_base = of_iomap(np, 0);
>> -	if (!rtc_base) {
>> -		pr_err("Can't map RTC registers\n");
>> -		return -ENXIO;
>> -	}
>> +	ret = timer_of_init(np, &suspend_rtc_to);
>> +	if (ret)
>> +		return ret;
>>   
>> -	/*
>> -	 * rtc registers are used by read_persistent_clock, keep the rtc clock
>> -	 * enabled
>> -	 */
>> -	clk = of_clk_get(np, 0);
>> -	if (IS_ERR(clk))
>> -		pr_warn("Unable to get rtc-tegra clock\n");
>> -	else
>> -		clk_prepare_enable(clk);
>> +	clocksource_register_hz(&suspend_rtc_clocksource, 1000);
>>   
>> -	return register_persistent_clock(tegra_read_persistent_clock64);
>> +	return 0;
>>   }
>>   TIMER_OF_DECLARE(tegra20_rtc, "nvidia,tegra20-rtc", tegra20_init_rtc);
>>   #endif
> 
> I wonder if there's any reason left for the #ifdefs now. My recollection
> is that these were only needed because register_persistent_clock() was
> not available on 64-bit ARM. The new APIs seem to be available
> regardless of architecture, so do we still need to differentiate?
> 

Actually, only Tegra20/30 that doesn't have ARM arch timer support need 
this. The latter Tegra chips which have ARM arch timer support use TSC ( 
time stamp counter or timer system counter depends on the chip it has 
different name) as the timer source in the PMC. And it uses OSC during 
runtime and switches to 32KHz always-on clock source to keep counting 
when the chip is in the SC7 or LP0 state.

So I didn't change that for this reason.

Thanks,
Joseph

