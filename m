Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 967F1C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 06:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A13720854
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 06:47:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbfCHGrq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 01:47:46 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:52646 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725372AbfCHGrp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 01:47:45 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id BE25B47C25AD5E53302B
        for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2019 14:47:43 +0800 (CST)
Received: from [127.0.0.1] (10.184.52.56) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.408.0; Fri, 8 Mar 2019
 14:47:39 +0800
Subject: Re: [PATCH v3] posix-cpu-timers: Avoid undefined behaviour in
 timespec64_to_ns()
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1551861646-52541-1-git-send-email-wangxiongfeng2@huawei.com>
 <CAK8P3a2VicE7e8pU8UD9UwEmr_wb9GdxKWdE64mKGkvU4Ac37A@mail.gmail.com>
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
Message-ID: <e8f0948b-81dd-53c9-6a18-1da50b099b7a@huawei.com>
Date:   Fri, 8 Mar 2019 14:47:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2VicE7e8pU8UD9UwEmr_wb9GdxKWdE64mKGkvU4Ac37A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.184.52.56]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/3/6 18:38, Arnd Bergmann wrote:
> On Wed, Mar 6, 2019 at 9:41 AM Xiongfeng Wang <wangxiongfeng2@huawei.com> wrote:
>>
>>
>> diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
>> index 0e84bb7..4b57566 100644
>> --- a/kernel/time/posix-timers.c
>> +++ b/kernel/time/posix-timers.c
>> @@ -856,6 +856,10 @@ static int do_timer_settime(timer_t timer_id, int flags,
>>         if (!timespec64_valid(&new_spec64->it_interval) ||
>>             !timespec64_valid(&new_spec64->it_value))
>>                 return -EINVAL;
>> +       if (new_spec64->it_interval.tv_sec > KTIME_SEC_MAX)
>> +               new_spec64->it_interval.tv_sec = KTIME_SEC_MAX;
>> +       if (new_spec64->it_value.tv_sec > KTIME_SEC_MAX)
>> +               new_spec64->it_value.tv_sec = KTIME_SEC_MAX;
>>
> 
> I looked at the calculation we do later, and I think this can still overflow
> if tv_nsec is too large. The largest timespec value we can support is
> 
> (struct timespec64) { .tv_sec = 9223372036, .tv_nsec = 854775807 }
> 
> Your patch caps the tv_sec value to 9223372036, but it does not
> cap the tv_nsec. The easiest fix would be to always set tv_nsec
> to 0 if tv_sec>=9223372036, or a more correct calculation would
> have to limit tv_nsec if tv_sec==9223372036. I don't know if that
> matters or not (it should not, unless we explicitly compare the
> ktime_t for equality with KTIME_MAX later).

Thanks for your advice. I will send another one to  set tv_nsec
to 0 if tv_sec>=9223372036.
Do need to add a helper to clamp timespec64, such as 'saturate_timespec64_valid()'
to limit it between 0 and KTIME_MAX(or KTIME_SEC_MAX, it's easier.)

Thanks,
Xiongfeng

> 
>      Arnd
> 
> .
> 

