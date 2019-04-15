Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E779C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 15:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBA2020880
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 15:51:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbfDOPvP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 11:51:15 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:34000 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726034AbfDOPvP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 11:51:15 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 5BDF17F7799A833B01C0;
        Mon, 15 Apr 2019 23:51:10 +0800 (CST)
Received: from [127.0.0.1] (10.184.38.59) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.408.0; Mon, 15 Apr 2019
 23:51:04 +0800
Subject: Re: [PATCH] sched/fair: Use 'unsigned long' for
 group_shares,group_runnable
To:     Peter Zijlstra <peterz@infradead.org>
CC:     <huawei.libin@huawei.com>, <xiexiuqi@huawei.com>,
        <yangyingliang@huawei.com>, <mingo@redhat.com>,
        <linux-kernel@vger.kernel.org>,
        "chengjian (D)" <cj.chengjian@huawei.com>
References: <20190413033234.30002-1-cj.chengjian@huawei.com>
 <20190415124617.GP11158@hirez.programming.kicks-ass.net>
 <eb7dede4-9668-9252-b95a-e20e313c5890@huawei.com>
 <20190415152549.GQ11158@hirez.programming.kicks-ass.net>
From:   "chengjian (D)" <cj.chengjian@huawei.com>
Message-ID: <8c8e96d0-226b-de46-d498-0d8a6947b4c9@huawei.com>
Date:   Mon, 15 Apr 2019 23:50:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.2
MIME-Version: 1.0
In-Reply-To: <20190415152549.GQ11158@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.184.38.59]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/4/15 23:25, Peter Zijlstra wrote:
> On Mon, Apr 15, 2019 at 11:20:31PM +0800, chengjian (D) wrote:
>> Hi, Peter
>>
>>
>> On 2019/4/15 20:46, Peter Zijlstra wrote:
>>
>> I write a demo about this, which I described it as overflow.
> I'm not saying there's no overflow, I'm saying there's nothing UB about
> it.
>

Yeah. I got it.

This may not be an undefined behavior,

but rather a bug or logic error caused by overflow.


```cpp


static long calc_group_shares(struct cfs_rq *cfs_rq)
{

     // ......

     shares = (tg_shares * load);   // 1048576 * 9144968455305  = 
-8857549630719655936 (OVERFLOW)
     if (tg_weight)                         // assume tg_weight is 3
         shares /= tg_weight;         //  0xd7068dd8c2daaaab shoule be 
0x2c5be32e18300000
}

```


It will cause `se->runnable_weight` to have an incorrect value in 
reweight_entity().


Thanks.

CHENG Jian


