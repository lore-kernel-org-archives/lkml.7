Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0477C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 15:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA21020818
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 15:20:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727690AbfDOPUv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 11:20:51 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:41858 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726034AbfDOPUv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 11:20:51 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6EEEE427724505D695B4;
        Mon, 15 Apr 2019 23:20:46 +0800 (CST)
Received: from [127.0.0.1] (10.184.38.59) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.408.0; Mon, 15 Apr 2019
 23:20:38 +0800
Subject: Re: [PATCH] sched/fair: Use 'unsigned long' for
 group_shares,group_runnable
To:     Peter Zijlstra <peterz@infradead.org>
CC:     <huawei.libin@huawei.com>, <xiexiuqi@huawei.com>,
        <yangyingliang@huawei.com>, <mingo@redhat.com>,
        <linux-kernel@vger.kernel.org>,
        "chengjian (D)" <cj.chengjian@huawei.com>,
        Yang Yingliang <yangyingliang@huawei.com>
References: <20190413033234.30002-1-cj.chengjian@huawei.com>
 <20190415124617.GP11158@hirez.programming.kicks-ass.net>
From:   "chengjian (D)" <cj.chengjian@huawei.com>
Message-ID: <eb7dede4-9668-9252-b95a-e20e313c5890@huawei.com>
Date:   Mon, 15 Apr 2019 23:20:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.2
MIME-Version: 1.0
In-Reply-To: <20190415124617.GP11158@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.184.38.59]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Peter


On 2019/4/15 20:46, Peter Zijlstra wrote:

I write a demo about this, which I described it as overflow.

#cat test.c

//test.c
#include <stdio.h>
#include <stdlib.h>
#include <limits.h>
#include <assert.h>

int main(void)
{
     long a = 1048576 * 9144968455305; /* shares = tg_shares * load */
     unsigned long b = a;
     //unsigned long e = 1048576 * 9144968455305;

     printf("LONG_MAX = %ld, 0x%lx\n", LONG_MAX, LONG_MAX);
     printf("ULONG_MAX = %lu, 0x%lx\n", ULONG_MAX, ULONG_MAX);

     if (b > LONG_MAX)
         printf("==overflow!!!==\n");   // OVERFLOW
     printf("a = %20ld,0x%016lx\n", a, a);
     printf("b = %20lu,0x%016lx\n", b, b);

     /* shares /= tg_weight */
     printf("a/3 = 0x%016lx\n", (a / 3));                        // WRONG
     printf("a/3 = 0x%016lx\n", (((unsigned long)a) / 3));   // unsigned
     printf("a/3 = 0x%016lx\n", (a / (unsigned long)3));    // unsigned
     printf("b/3 = 0x%016lx\n", b / 3);            // unsigned

     return EXIT_SUCCESS;
}



#./test

LONG_MAX = 9223372036854775807, 0x7fffffffffffffff
ULONG_MAX = 18446744073709551615, 0xffffffffffffffff
==overflow!!!==
a = -8857549630719655936,0x8513a98a48900000
b =  9589194442989895680,0x8513a98a48900000
a/3 = 0xd7068dd8c2daaaab     //  WRONG
a/3 = 0x2c5be32e18300000
a/3 = 0x2c5be32e18300000
b/3 = 0x2c5be32e18300000



> On Sat, Apr 13, 2019 at 03:32:34AM +0000, Cheng Jian wrote:
>> group_share and group_runnable are tracked as 'unsigned long',
>> however some functions using them as 'long' which is ultimately
>> assigned back to 'unsigned long' variables in reweight_entity.
>>
>> Since there is not scope on using a different and signed type,
>> this change improves code consistency and avoids further type
>> conversions. More important, to prevent undefined behavior
>> caused by overflow.
> There is no undefined behaviour due to overflow.UBSAN is broken,
> upgrade to GCC8 or later.
>
> .


So, function calc_group_shares will return the wrong value.


```cpp

static long calc_group_shares(struct cfs_rq *cfs_rq)
{

     // ......

     shares = (tg_shares * load);
     if (tg_weight)
         shares /= tg_weight;
}

```


The same to calc_group_runnable.


Thanks.

     CHENG Jian.


