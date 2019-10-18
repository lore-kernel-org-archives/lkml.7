Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E8BCA9EC8
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 01:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57EC520820
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 01:11:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409223AbfJRBLS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 21:11:18 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4247 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2392283AbfJRBLR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 21:11:17 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 0BA28C49BC07D5EF93FC;
        Fri, 18 Oct 2019 09:11:15 +0800 (CST)
Received: from [127.0.0.1] (10.133.217.137) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Fri, 18 Oct 2019
 09:11:10 +0800
Subject: Re: [PATCH 00/32] Kill pr_warning in the whole linux code
To:     Joe Perches <joe@perches.com>, Petr Mladek <pmladek@suse.com>
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
        ArnaldoCarvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, <linux-kernel@vger.kernel.org>
References: <20190920062544.180997-1-wangkefeng.wang@huawei.com>
 <20191002085554.ddvx6yx6nx7tdeey@pathway.suse.cz>
 <f613df39-6903-123b-a0f1-d1b783a755ce@huawei.com>
 <20191017130550.nwswlnwdroyjwwun@pathway.suse.cz>
 <21f6322c-1c2b-f857-2e6e-e1c6aa45dd2d@huawei.com>
 <c2a4d95bee896df95d277fe84295e91014835030.camel@perches.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <4698b6c1-a112-b327-29e7-706a4e46a430@huawei.com>
Date:   Fri, 18 Oct 2019 09:11:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <c2a4d95bee896df95d277fe84295e91014835030.camel@perches.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.217.137]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/10/18 0:38, Joe Perches wrote:
> On Thu, 2019-10-17 at 21:29 +0800, Kefeng Wang wrote:
>> On 2019/10/17 21:05, Petr Mladek wrote:
>>> On Tue 2019-10-08 14:39:32, Kefeng Wang wrote:
>>>> On 2019/10/2 16:55, Petr Mladek wrote:
>>>>> On Fri 2019-09-20 14:25:12, Kefeng Wang wrote:
>>>>>> There are pr_warning and pr_warng to show WARNING level message,
>>>>>> most of the code using pr_warn, number based on next-20190919,
>>>>>>
>>>>>> pr_warn: 5189   pr_warning: 546 (tools: 398, others: 148)
>>>>>
>>>>> The ratio is 10:1 in favor of pr_warn(). It would make sense
>>>>> to remove the pr_warning().
>>>>>
>>>>> Would you accept pull request with these 32 simple patches
>>>>> for rc2, please?
>>>>>
>>>>> Alternative is to run a simple sed. But it is not trivial
>>>>> to fix indentation of the related lines.
>>>>
>>>> Kindly ping, should I respin patches with comments fixed?
>>>> Is the patchset acceptable, hope to be clear that what to do next :)
>>>
>>> I am going to check how many conflicts appeared in linux-next.
>>>
>>> If there are only few then I'll take it via printk.git. This way
>>> we get proper indentation and other changes.
> []
>> For tools parts(api/bpf/perf, patch [29-31]), it renames pr_warning
>> to pr_warn, and make manually changes in some place, simply 'sed'
>> maybe not enough.
> 
> Perhaps tools/ should not be changed.
> 
> Last time I did this, I did not convert tools/ as there are
> possible external dependencies and code like pr_warning_wrapper
> exists and that adds some complexity to the change.

The pr_warning dependencies and wrappers in tools may not seem
to be much in following head files, and build test all passed.

tools/lib/api/debug-internal.h
tools/lib/bpf/libbpf_internal.h
tools/perf/lib/internal.h
tools/perf/util/debug.h

Let's remove all pr_warning if there is no objection.>
> https://lore.kernel.org/patchwork/cover/761816/
> 
> 
> 
> .
> 

