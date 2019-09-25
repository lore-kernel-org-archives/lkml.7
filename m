Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C907C4360C
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 13:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 647A7222BD
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 13:46:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406961AbfIYNqb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 09:46:31 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2721 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2406887AbfIYNqa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 09:46:30 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 837F7C084E2234E37D0C;
        Wed, 25 Sep 2019 21:46:26 +0800 (CST)
Received: from [127.0.0.1] (10.177.251.225) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Wed, 25 Sep 2019
 21:46:25 +0800
Subject: Re: [PATCH] async: Let kfree() out of the critical area of the lock
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     <bvanassche@acm.org>, <bhelgaas@google.com>, <dsterba@suse.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        <alexander.h.duyck@linux.intel.com>,
        <sakari.ailus@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <216356b1-38c1-8477-c4e8-03f497dd6ac8@huawei.com>
 <20190925133826.GA1496885@kroah.com>
From:   Yunfeng Ye <yeyunfeng@huawei.com>
Message-ID: <c3659e7d-0fba-ec1c-d50f-736a8c819559@huawei.com>
Date:   Wed, 25 Sep 2019 21:45:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190925133826.GA1496885@kroah.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.251.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/9/25 21:38, gregkh@linuxfoundation.org wrote:
> On Wed, Sep 25, 2019 at 08:52:26PM +0800, Yunfeng Ye wrote:
>> It's not necessary to put kfree() in the critical area of the lock, so
>> let it out.
>>
>> Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
>> ---
>>  kernel/async.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/kernel/async.c b/kernel/async.c
>> index 4f9c1d6..1de270d 100644
>> --- a/kernel/async.c
>> +++ b/kernel/async.c
>> @@ -135,12 +135,12 @@ static void async_run_entry_fn(struct work_struct *work)
>>  	list_del_init(&entry->domain_list);
>>  	list_del_init(&entry->global_list);
>>
>> -	/* 3) free the entry */
>> -	kfree(entry);
>>  	atomic_dec(&entry_count);
>> -
>>  	spin_unlock_irqrestore(&async_lock, flags);
>>
>> +	/* 3) free the entry */
>> +	kfree(entry);
>> +
>>  	/* 4) wake up any waiters */
>>  	wake_up(&async_done);
>>  }
>> -- 
>> 2.7.4
>>
> 
> Does this result any any measurable performance changes?
> 
No performance has been Measured at present, I just want the critical area
to be as short as possible. I think it's good to put it outside.

thanks

> thanks,
> 
> greg k-h
> 
> .
> 

