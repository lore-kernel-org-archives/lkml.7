Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD09C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 15:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 249632084F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 15:47:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbfCKPrR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 11:47:17 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4671 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726942AbfCKPrQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 11:47:16 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id DF83580B34D41A751C5;
        Mon, 11 Mar 2019 23:47:11 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.408.0; Mon, 11 Mar 2019
 23:47:08 +0800
Subject: Re: [PATCH] clocksource: cadence_ttc: fix memory leak in
 ttc_setup_clockevent
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        <michal.simek@xilinx.com>, <tglx@linutronix.de>
References: <20190309131958.17996-1-yuehaibing@huawei.com>
 <b9831ea9-3230-6f63-8c73-b3b2cd28c59f@linaro.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <e0eaa44c-4997-5fd8-8418-ac02922bffcd@huawei.com>
Date:   Mon, 11 Mar 2019 23:47:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <b9831ea9-3230-6f63-8c73-b3b2cd28c59f@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/3/9 22:24, Daniel Lezcano wrote:
> 
> Hi Yue,
> 
> I appreciate the fix but usually we add a rollback for all the
> operations done in the init function.
> 
> Please, migrate the init function to the timer-of API, so the rollback
> will be automatically handled.
> 
> Example here:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/clocksource/timer-sprd.c#n197

It seems complicated for me,

ttc_setup_clocksource and ttc_setup_clockevent use a different of_clk,
hard to use timer_of_init to do a initialization.

I'm not familiar with this. Maybe someone else can do this?

> 
> On 09/03/2019 14:19, Yue Haibing wrote:
>> From: YueHaibing <yuehaibing@huawei.com>
>>
>> Add the missing kfree() in ttc_setup_clockevent() to free the
>> mem before error return.
>>
>> Fixes: 70504f311d4b ("clocksource/drivers/cadence_ttc: Convert init function to return error")
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
>>  drivers/clocksource/timer-cadence-ttc.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/clocksource/timer-cadence-ttc.c b/drivers/clocksource/timer-cadence-ttc.c
>> index b334029..b664af8 100644
>> --- a/drivers/clocksource/timer-cadence-ttc.c
>> +++ b/drivers/clocksource/timer-cadence-ttc.c
>> @@ -432,6 +432,7 @@ static int __init ttc_setup_clockevent(struct clk *clk,
>>  				    &ttcce->ttc.clk_rate_change_nb);
>>  	if (err) {
>>  		pr_warn("Unable to register clock notifier.\n");
>> +		kfree(ttcce);
>>  		return err;
>>  	}
>>  
>>
> 
> 

