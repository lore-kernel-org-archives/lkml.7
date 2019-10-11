Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E2DBC47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 09:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A0DE20679
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 09:51:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbfJKJvt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 05:51:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49410 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726585AbfJKJvt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 05:51:49 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AF53A8980E9;
        Fri, 11 Oct 2019 09:51:48 +0000 (UTC)
Received: from [10.36.118.168] (unknown [10.36.118.168])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3BE58600C4;
        Fri, 11 Oct 2019 09:51:47 +0000 (UTC)
Subject: Re: [PATCH v1] drivers/base/memory.c: Don't access uninitialized
 memmaps in soft_offline_page_store()
To:     Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20191010141200.8985-1-david@redhat.com>
 <20191011061335.GA30803@hori.linux.bs1.fc.nec.co.jp>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <2937e23d-0f27-a99c-f661-b3fe326494ca@redhat.com>
Date:   Fri, 11 Oct 2019 11:51:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191011061335.GA30803@hori.linux.bs1.fc.nec.co.jp>
Content-Type: text/plain; charset=iso-2022-jp; format=flowed; delsp=yes
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.67]); Fri, 11 Oct 2019 09:51:48 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.10.19 08:13, Naoya Horiguchi wrote:
> On Thu, Oct 10, 2019 at 04:12:00PM +0200, David Hildenbrand wrote:
>> Uninitialized memmaps contain garbage and in the worst case trigger kernel
>> BUGs, especially with CONFIG_PAGE_POISONING. They should not get
>> touched.
>>
>> Right now, when trying to soft-offline a PFN that resides on a memory
>> block that was never onlined, one gets a misleading error with
>> CONFIG_PAGE_POISONING:
>>    :/# echo 5637144576 > /sys/devices/system/memory/soft_offline_page
>>    [   23.097167] soft offline: 0x150000 page already poisoned
>>
>> But the actual result depends on the garbage in the memmap.
>>
>> soft_offline_page() can only work with online pages, it returns -EIO in
>> case of ZONE_DEVICE. Make sure to only forward pages that are online
>> (iow, managed by the buddy) and, therefore, have an initialized memmap.
>>
>> Add a check against pfn_to_online_page() and similarly return -EIO.
>>
>> Fixes: f1dd2cd13c4b ("mm, memory_hotplug: do not associate hotadded memory to zones until online") # visible after d0dc12e86b319
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
>> Cc: Michal Hocko <mhocko@kernel.org>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>   drivers/base/memory.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
>> index 6bea4f3f8040..55907c27075b 100644
>> --- a/drivers/base/memory.c
>> +++ b/drivers/base/memory.c
>> @@ -540,6 +540,9 @@ static ssize_t soft_offline_page_store(struct device *dev,
>>   	pfn >>= PAGE_SHIFT;
>>   	if (!pfn_valid(pfn))
>>   		return -ENXIO;
>> +	/* Only online pages can be soft-offlined (esp., not ZONE_DEVICE). */
>> +	if (!pfn_to_online_page(pfn))
>> +		return -EIO;
> 
> Acked-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> 
> I think this check could be placed in soft_offline_page(), but that requires
> a few more unrelated lines of changes due to the mismatch on type of parameter
> between memory_failure() and soft_offline_page(),  This is not your problem,
> and I plan to do some cleanup on related interfaces, so this patch is fine.
> 

Thanks,

well I think when you come via madvise(), you are always guaranteed to  
hold a reasonable page in your hands. Only when converting from  
arbitrary pfns, we have to watch out. But yeah, feel free to cc me on  
cleanups :)

> - Naoya Horiguchi
> 


-- 

Thanks,

David / dhildenb
