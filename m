Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B26AC4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 12:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E84D0206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 12:16:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728553AbfFKMQo convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 08:16:44 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:6935 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726713AbfFKMQn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 08:16:43 -0400
Received: from dggemi403-hub.china.huawei.com (unknown [172.30.72.56])
        by Forcepoint Email with ESMTP id 542341CB09A22907BC29;
        Tue, 11 Jun 2019 20:16:42 +0800 (CST)
Received: from DGGEMI529-MBS.china.huawei.com ([169.254.5.79]) by
 dggemi403-hub.china.huawei.com ([10.3.17.136]) with mapi id 14.03.0415.000;
 Tue, 11 Jun 2019 20:16:35 +0800
From:   "Chengang (L)" <cg.chen@huawei.com>
To:     Michal Hocko <mhocko@kernel.org>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "pavel.tatashin@microsoft.com" <pavel.tatashin@microsoft.com>,
        "mgorman@techsingularity.net" <mgorman@techsingularity.net>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        "richard.weiyang@gmail.com" <richard.weiyang@gmail.com>,
        "alexander.h.duyck@linux.intel.com" 
        <alexander.h.duyck@linux.intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: align up min_free_kbytes to multipy of 4
Thread-Topic: [PATCH] mm: align up min_free_kbytes to multipy of 4
Thread-Index: AdUgTpdGfX4K+yczTYe6f6nhJDDS/w==
Date:   Tue, 11 Jun 2019 12:16:35 +0000
Message-ID: <D27E5778F399414A8B5D5F672064BAD8B3E5FB7B@dggemi529-mbs.china.huawei.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.74.216.69]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal


>On Sun 09-06-19 17:10:28, ChenGang wrote:
>> Usually the value of min_free_kbytes is multiply of 4, and in this 
>> case ,the right shift is ok.
>> But if it's not, the right-shifting operation will lose the low 2 
>> bits, and this cause kernel don't reserve enough memory.
>> So it's necessary to align the value of min_free_kbytes to multiply of 4.
>> For example, if min_free_kbytes is 64, then should keep 16 pages, but 
>> if min_free_kbytes is 65 or 66, then should keep 17 pages.

>Could you describe the actual problem? Do we ever generate min_free_kbytes that would lead to unexpected reserves or is this trying to compensate for those values being configured from the userspace? If later why do we care at all?

>Have you seen this to be an actual problem or is this mostly motivated by the code reading?

I haven't seen an actual problem, and it's motivated by code reading.  Users can configure this value through interface /proc/sys/vm/min_free_kbytes, so I think a bit precious is better.

>> Signed-off-by: ChenGang <cg.chen@huawei.com>
>> ---
>>  mm/page_alloc.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>> 
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c index d66bc8a..1baeeba 
>> 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -7611,7 +7611,8 @@ static void setup_per_zone_lowmem_reserve(void)
>>  
>>  static void __setup_per_zone_wmarks(void)  {
>> -	unsigned long pages_min = min_free_kbytes >> (PAGE_SHIFT - 10);
>> +	unsigned long pages_min =
>> +		(PAGE_ALIGN(min_free_kbytes * 1024) / 1024) >> (PAGE_SHIFT - 10);
>>  	unsigned long lowmem_pages = 0;
>>  	struct zone *zone;
>>  	unsigned long flags;
>> --
>> 1.8.5.6
>> 

>-- 
>Michal Hocko
>SUSE Labs
