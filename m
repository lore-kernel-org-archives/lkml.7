Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FDB5C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 14:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72BAA20718
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 14:40:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbfKNOkd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 09:40:33 -0500
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:59432 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726263AbfKNOkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 09:40:33 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=shile.zhang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Ti3zzN0_1573742422;
Received: from ali-6c96cfdd1403.local(mailfrom:shile.zhang@linux.alibaba.com fp:SMTPD_---0Ti3zzN0_1573742422)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 14 Nov 2019 22:40:23 +0800
Subject: Re: [PATCH] mm/vmalloc: Fix regression caused by needless
 vmalloc_sync_all()
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20191113095530.228959-1-shile.zhang@linux.alibaba.com>
 <20191114135641.GA1356@dhcp22.suse.cz>
From:   Shile Zhang <shile.zhang@linux.alibaba.com>
Message-ID: <83a39694-373b-da16-3be1-22108ace0107@linux.alibaba.com>
Date:   Thu, 14 Nov 2019 22:40:22 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191114135641.GA1356@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/11/14 21:56, Michal Hocko wrote:
> On Wed 13-11-19 17:55:30, Shile Zhang wrote:
>> vmalloc_sync_all() was put in the common path in
>> __purge_vmap_area_lazy(), for one sync issue only happened on X86_32
>> with PTI enabled. It is needless for X86_64, which caused a big regression
>> in UnixBench Shell8 testing on X86_64.
>> Similar regression also reported by 0-day kernel test robot in reaim
>> benchmarking:
>> https://lists.01.org/hyperkitty/list/lkp@lists.01.org/thread/4D3JPPHBNOSPFK2KEPC6KGKS6J25AIDB/
>>
>> Fix it by adding more conditions.
> This doesn't really explain a lot. Could you explain why the syncing
> should be limited only to PAE and !SHARED_KERNEL_PMD?

Thanks for your review!
Sorry for that, I'm not clear about the original issue the patch
3f8fd02b1bf1 ("mm/vmalloc: Sync unmappings in __purge_vmap_area_lazy()")
fixed.

I just get that limitation info from the commit log as following:
"
This is only needed x86-32 with !SHARED_KERNEL_PMD, which is the case on 
a PAE kernel with PTI enabled. On affected systems the missing sync 
causes old mappings to persist in some page-tables, causing data 
corruption and other undefined behavior.
"
https://patchwork.kernel.org/cover/11050511/

Hi, Joerg
Could you please help to recall the original issue you encountered before?
Thanks!

>
>> Fixes: 3f8fd02b1bf1 ("mm/vmalloc: Sync unmappings in __purge_vmap_area_lazy()")
>>
>> Signed-off-by: Shile Zhang <shile.zhang@linux.alibaba.com>
>> ---
>>   mm/vmalloc.c | 8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
>> index a3c70e275f4e..7b9fc7966da6 100644
>> --- a/mm/vmalloc.c
>> +++ b/mm/vmalloc.c
>> @@ -1255,11 +1255,17 @@ static bool __purge_vmap_area_lazy(unsigned long start, unsigned long end)
>>   	if (unlikely(valist == NULL))
>>   		return false;
>>   
>> +#if defined(CONFIG_X86_32) && defined(CONFIG_X86_PAE)
>>   	/*
>>   	 * First make sure the mappings are removed from all page-tables
>>   	 * before they are freed.
>> +	 *
>> +	 * This is only needed on x86-32 with !SHARED_KERNEL_PMD, which is
>> +	 * the case on a PAE kernel with PTI enabled.
>>   	 */
>> -	vmalloc_sync_all();
>> +	if (!SHARED_KERNEL_PMD && boot_cpu_has(X86_FEATURE_PTI))
>> +		vmalloc_sync_all();
>> +#endif
>>   
>>   	/*
>>   	 * TODO: to calculate a flush range without looping.
>> -- 
>> 2.24.0.rc2
>>

