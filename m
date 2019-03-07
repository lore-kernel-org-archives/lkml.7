Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB84C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A26CE2064A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:36:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbfCGPg1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 10:36:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:52722 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726275AbfCGPg0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 10:36:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CAE33ABF5;
        Thu,  7 Mar 2019 15:36:24 +0000 (UTC)
Subject: Re: [PATCH] bcache: add cond_resched() in __bch_cache_cmp()
To:     Shile Zhang <shile.zhang@linux.alibaba.com>
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        linux-bcache@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1551935728-243664-1-git-send-email-shile.zhang@linux.alibaba.com>
 <24916a71-39ff-7324-ad12-9d79cc68d0da@suse.de>
 <3640cd7f-f32a-1509-dbef-6000b6e14e75@linux.alibaba.com>
From:   Coly Li <colyli@suse.de>
Openpgp: preference=signencrypt
Organization: SUSE Labs
Message-ID: <c421d715-6d14-a6f0-907b-644318120c8e@suse.de>
Date:   Thu, 7 Mar 2019 23:36:18 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.5.2
MIME-Version: 1.0
In-Reply-To: <3640cd7f-f32a-1509-dbef-6000b6e14e75@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/3/7 11:06 下午, Shile Zhang wrote:
> 
> On 2019/3/7 18:34, Coly Li wrote:
>> On 2019/3/7 1:15 下午, shile.zhang@linux.alibaba.com wrote:
>>> From: Shile Zhang <shile.zhang@linux.alibaba.com>
>>>
>>> Read /sys/fs/bcache/<uuid>/cacheN/priority_stats can take very long
>>> time with huge cache after long run.
>>>
>>> Signed-off-by: Shile Zhang <shile.zhang@linux.alibaba.com>
>> Hi Shile,
>>
>> Do you test your change ? It will be helpful with more performance data
>> (what problem that you improved).
> 
> In case of 960GB SSD cache device, once read of the 'priority_stats'
> costs about 600ms in our test environment.
> 

After the fix, how much time it takes ?


> The perf tool shown that near 50% CPU time consumed by 'sort()', this
> means once sort will hold the CPU near 300ms.
> 
> In our case, the statistics collector reads the 'priority_stats'
> periodically, it will trigger the schedule latency jitters of the
> 
> task which shared same CPU core.
> 

Hmm, it seems you just make the sort slower, and nothing more changes.
Am I right ?


Coly Li


>>
>> Thanks.
>>
>> Coly Li
>>
>>> ---
>>>   drivers/md/bcache/sysfs.c | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/md/bcache/sysfs.c b/drivers/md/bcache/sysfs.c
>>> index 557a8a3..028fea1 100644
>>> --- a/drivers/md/bcache/sysfs.c
>>> +++ b/drivers/md/bcache/sysfs.c
>>> @@ -897,6 +897,7 @@ static void bch_cache_set_internal_release(struct
>>> kobject *k)
>>>     static int __bch_cache_cmp(const void *l, const void *r)
>>>   {
>>> +    cond_resched();
>>>       return *((uint16_t *)r) - *((uint16_t *)l);
>>>   }
>>>  
>>


-- 

Coly Li
