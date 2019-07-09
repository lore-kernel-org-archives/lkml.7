Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF3BC606B0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 01:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A63B421537
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 01:26:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbfGIB0P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 21:26:15 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2187 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725886AbfGIB0P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 21:26:15 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 48593A0AEE318C646116;
        Tue,  9 Jul 2019 09:26:11 +0800 (CST)
Received: from [127.0.0.1] (10.184.225.177) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Tue, 9 Jul 2019
 09:26:00 +0800
Subject: Re: [PATCH next] softirq: enable MAX_SOFTIRQ_TIME tuning with sysctl
 max_softirq_time_usecs
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     <corbet@lwn.net>, <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>, <akpm@linux-foundation.org>,
        <manfred@colorfullife.com>, <jwilk@jwilk.net>,
        <dvyukov@google.com>, <feng.tang@intel.com>,
        <sunilmut@microsoft.com>, <quentin.perret@arm.com>,
        <linux@leemhuis.info>, <alex.popov@linux.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>,
        "wangxiaogang (F)" <wangxiaogang3@huawei.com>,
        "Zhoukang (A)" <zhoukang7@huawei.com>,
        Mingfangsen <mingfangsen@huawei.com>, <tedheadster@gmail.com>,
        Eric Dumazet <edumazet@google.com>
References: <f274f85a-bbb6-3e32-b293-1d5d7f27a98f@huawei.com>
 <alpine.DEB.2.21.1906231820470.32342@nanos.tec.linutronix.de>
 <0099726a-ead3-bdbe-4c66-c8adc9a4f11b@huawei.com>
 <alpine.DEB.2.21.1906241141370.32342@nanos.tec.linutronix.de>
 <c1b7a345-fa22-e52a-4db8-1f1288e7ad15@huawei.com>
 <alpine.DEB.2.21.1907081558400.4709@nanos.tec.linutronix.de>
From:   Zhiqiang Liu <liuzhiqiang26@huawei.com>
Message-ID: <cbd68d63-ac48-7b36-d317-7bb2b480e6f7@huawei.com>
Date:   Tue, 9 Jul 2019 09:25:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1907081558400.4709@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="gb18030"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.184.225.177]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/7/8 22:14, Thomas Gleixner wrote:
> Zhiqiang,
> 
>> If HZ satisfies the condition: HZ <= MSEC_PER_SEC && !(MSEC_PER_SEC %
>> HZ), the return value of _msecs_to_jiffies func with m=0 is different
>> with different HZ setting.
> 
>> ------------------------------------
>> | HZ |	MSEC_PER_SEC / HZ | return |
>> ------------------------------------
>> |1000|		1	  |   0	   |
>> |500 |		2	  |   1	   |
>> |200 |		5	  |   1	   |
>> |100 |		10	  |   1	   |
>> ------------------------------------
>>
>> Why only the return value of HZ=1000 is equal to 0 with m=0 ?
> 
> I don't know how you tested that, but obviously all four HZ values use
> this variant:
> 
>>     #if HZ <= MSEC_PER_SEC && !(MSEC_PER_SEC % HZ)
>>     static inline unsigned long _msecs_to_jiffies(const unsigned int m)
>>     {
>>             return (m + (MSEC_PER_SEC / HZ) - 1) / (MSEC_PER_SEC / HZ);
>>     }
> 
> and for all four HZ values the result is 0. Why?
> 
> For m = 0 the calculation reduces to:
> 
>       ((MSEC_PER_SEC / HZ) - 1) / (MSEC_PER_SEC / HZ)
> 
> i.e.
> 
> 	(x - 1) / x	where x = [1, 2, 5, 10]
> 
> which is guaranteed to be 0 for integer math. If not, you have a compiler
> problem.
> 
> Thanks,
> 
> 	tglx
Thanks for your reply. Actually, I have made a low-level mistake.
I am really sorry for that.
Thanks again.

