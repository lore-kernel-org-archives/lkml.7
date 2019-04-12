Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B20C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 04:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D02D2084D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 04:32:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbfDLEcz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 00:32:55 -0400
Received: from mx.socionext.com ([202.248.49.38]:43170 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbfDLEcz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 00:32:55 -0400
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 12 Apr 2019 13:32:53 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id B42EC6117D;
        Fri, 12 Apr 2019 13:32:53 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Fri, 12 Apr 2019 13:32:53 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 2C49F1A15B7;
        Fri, 12 Apr 2019 13:32:53 +0900 (JST)
Received: from [127.0.0.1] (unknown [10.213.119.83])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 12D4A120487;
        Fri, 12 Apr 2019 13:32:53 +0900 (JST)
Subject: Re: [PATCH 1/3] clocksource/drivers/timer-milbeaut: Fix to enable
 one-shot timer
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Cc:     Takao Orito <orito.takao@socionext.com>,
        Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
        Shinji Kanematsu <kanematsu.shinji@socionext.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>
References: <1553483149-8922-1-git-send-email-sugaya.taichi@socionext.com>
 <1553483149-8922-2-git-send-email-sugaya.taichi@socionext.com>
 <0488b22d-6e47-768a-6bde-eb2d7196f7e9@linaro.org>
From:   "Sugaya, Taichi" <sugaya.taichi@socionext.com>
Message-ID: <0d0a4ceb-9ddc-447a-5e78-440a3efe8129@socionext.com>
Date:   Fri, 12 Apr 2019 13:32:51 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <0488b22d-6e47-768a-6bde-eb2d7196f7e9@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thank you for your comment.

On 2019/04/12 5:08, Daniel Lezcano wrote:
> On 25/03/2019 04:05, Sugaya Taichi wrote:
>> Fix mlb_set_oneshot_state() to enable one-shot timer.
>> The function should stop and start a timer, but "start" statement was
>> dropped. Kick the register to start one-shot timer.
> 
> Can you add the "Fixes" tag please.
> 
I got it, will resend with correct form.

Thanks,
Sugaya Taichi

> 
> 
>> Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
>> ---
>>   drivers/clocksource/timer-milbeaut.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/clocksource/timer-milbeaut.c b/drivers/clocksource/timer-milbeaut.c
>> index f2019a8..9fd5d08 100644
>> --- a/drivers/clocksource/timer-milbeaut.c
>> +++ b/drivers/clocksource/timer-milbeaut.c
>> @@ -80,6 +80,8 @@ static int mlb_set_state_oneshot(struct clock_event_device *clk)
>>   	u32 val = MLB_TMR_TMCSR_CSL_DIV2;
>>   
>>   	writel_relaxed(val, timer_of_base(to) + MLB_TMR_EVT_TMCSR_OFS);
>> +	val |= MLB_TMR_TMCSR_CNTE | MLB_TMR_TMCSR_TRG | MLB_TMR_TMCSR_INTE;
>> +	writel_relaxed(val, timer_of_base(to) + MLB_TMR_EVT_TMCSR_OFS);
>>   	return 0;
>>   }
>>   
>>
> 
> 

