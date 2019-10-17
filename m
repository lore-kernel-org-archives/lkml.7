Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 842BBFA372A
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 13:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D3772054F
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 13:30:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732324AbfJQNaB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 09:30:01 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4215 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726520AbfJQNaA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 09:30:00 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 797EB3B1144C868CCA79;
        Thu, 17 Oct 2019 21:29:58 +0800 (CST)
Received: from [127.0.0.1] (10.133.217.137) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Thu, 17 Oct 2019
 21:29:57 +0800
Subject: Re: [PATCH 00/32] Kill pr_warning in the whole linux code
To:     Petr Mladek <pmladek@suse.com>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Whitcroft <apw@canonical.com>,
        "DavidS. Miller" <davem@davemloft.net>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        AlexeiStarovoitov <ast@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        GregKroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>,
        ArnaldoCarvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, <linux-kernel@vger.kernel.org>
References: <20190920062544.180997-1-wangkefeng.wang@huawei.com>
 <20191002085554.ddvx6yx6nx7tdeey@pathway.suse.cz>
 <f613df39-6903-123b-a0f1-d1b783a755ce@huawei.com>
 <20191017130550.nwswlnwdroyjwwun@pathway.suse.cz>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <21f6322c-1c2b-f857-2e6e-e1c6aa45dd2d@huawei.com>
Date:   Thu, 17 Oct 2019 21:29:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20191017130550.nwswlnwdroyjwwun@pathway.suse.cz>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.217.137]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/10/17 21:05, Petr Mladek wrote:
> On Tue 2019-10-08 14:39:32, Kefeng Wang wrote:
>> Hi all,
>>
>> On 2019/10/2 16:55, Petr Mladek wrote:
>>> Linus,
>>>
>>> On Fri 2019-09-20 14:25:12, Kefeng Wang wrote:
>>>> There are pr_warning and pr_warng to show WARNING level message,
>>>> most of the code using pr_warn, number based on next-20190919,
>>>>
>>>> pr_warn: 5189   pr_warning: 546 (tools: 398, others: 148)
>>>
>>> The ratio is 10:1 in favor of pr_warn(). It would make sense
>>> to remove the pr_warning().
>>>
>>> Would you accept pull request with these 32 simple patches
>>> for rc2, please?
>>>
>>> Alternative is to run a simple sed. But it is not trivial
>>> to fix indentation of the related lines.
>>
>> Kindly ping, should I respin patches with comments fixed?
>> Is the patchset acceptable, hope to be clear that what to do next :)
> 
> I am going to check how many conflicts appeared in linux-next.
> 
> If there are only few then I'll take it via printk.git. This way
> we get proper indentation and other changes.

There are some conflicts(not too much), and I have already rebased
on next-20191017 with comment fixed, added Reviewed-by/Acked-by.
I could resend them ASAP if necessary.
> 
> If there are too many conflicts then I'll ask Linus to do a mass
> change using a script.

For tools parts(api/bpf/perf, patch [29-31]), it renames pr_warning
to pr_warn, and make manually changes in some place, simply 'sed'
maybe not enough.

Thanks
Kefeng

> 
> I am sorry for late reply. I have never pushed such a mass change.
> I hoped that anyone more experienced will provide some opinion ;-)
> 
> Best Regards,
> Petr
> 
> .
> 

