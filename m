Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30316C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 04:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02A032081B
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 04:13:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbfCIENh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 23:13:37 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:4661 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726375AbfCIENg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 23:13:36 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id EC924E5BFBF796934EA7;
        Sat,  9 Mar 2019 12:13:33 +0800 (CST)
Received: from [127.0.0.1] (10.177.19.180) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.408.0; Sat, 9 Mar 2019
 12:13:31 +0800
Subject: Re: [PATCH] workqueue: unregister wq lockdep on error path in
 alloc_workqueue()
To:     Bart Van Assche <bvanassche@acm.org>,
        Ingo Molnar <mingo@kernel.org>, Tejun Heo <tj@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <syzbot+17335689e239ce135d8b@syzkaller.appspotmail.com>
References: <20190308073713.39853-1-wangkefeng.wang@huawei.com>
 <150578a7-f053-a479-2b1a-34279c93fc4b@acm.org>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <9fb0213e-efc2-ec7f-b257-d0c851e67025@huawei.com>
Date:   Sat, 9 Mar 2019 12:13:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <150578a7-f053-a479-2b1a-34279c93fc4b@acm.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.177.19.180]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/3/8 22:45, Bart Van Assche wrote:
> On 3/7/19 11:37 PM, Kefeng Wang wrote:
>> syzkaller report an issue "KASAN: use-after-free Read in alloc_workqueue",
>>
>> alloc_workqueue
>>   - kzalloc wq
>>   - wq_init_lockdep(wq);
>>     - lockdep_register_key(&wq->key);  // add to hlist
>>   - kfree wq
>>
>> But forget to call wq_unregister_lockdep()->lockdep_unregister_key(), it
>> will delete the entry from hlist.
>>
>> Reported-by: syzbot+17335689e239ce135d8b@syzkaller.appspotmail.com
>> Fixes: 669de8bda87b ("kernel/workqueue: Use dynamic lockdep keys for workqueues")
>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>> ---
>>   kernel/workqueue.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
>> index 7abbeed13421..9209d25dfade 100644
>> --- a/kernel/workqueue.c
>> +++ b/kernel/workqueue.c
>> @@ -4291,6 +4291,7 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
>>       return wq;
>>     err_free_wq:
>> +    wq_unregister_lockdep(wq);
>>       free_workqueue_attrs(wq->unbound_attrs);
>>       kfree(wq);
>>       return NULL;
>
> Hi Kefeng,
>
> Five days ago I had posted a similar but slightly different patch. Can you have a look at it? See also https://lore.kernel.org/lkml/20190303220046.29448-1-bvanassche@acm.org/  
I don't notice your patch due to no subscribe lkml,  that is better, wq->lock_name should be freed too; )
>
> Thanks,
>
> Bart.
>
>
>
> .
>

