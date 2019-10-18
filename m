Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E47DFCA9EA1
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 08:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C51122064A
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 08:13:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395523AbfJRINj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 04:13:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37656 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732147AbfJRINj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 04:13:39 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EC35C10CC1E6;
        Fri, 18 Oct 2019 08:13:38 +0000 (UTC)
Received: from [10.36.118.57] (unknown [10.36.118.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6F0A85C1B5;
        Fri, 18 Oct 2019 08:13:37 +0000 (UTC)
Subject: Re: memory offline infinite loop after soft offline
To:     Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Michal Hocko <mhocko@kernel.org>, Qian Cai <cai@lca.pw>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
References: <1570829564.5937.36.camel@lca.pw>
 <20191014083914.GA317@dhcp22.suse.cz>
 <20191017093410.GA19973@hori.linux.bs1.fc.nec.co.jp>
 <20191017100106.GF24485@dhcp22.suse.cz> <1571335633.5937.69.camel@lca.pw>
 <20191017182759.GN24485@dhcp22.suse.cz>
 <20191018021906.GA24978@hori.linux.bs1.fc.nec.co.jp>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <33946728-bdeb-494a-5db8-e279acebca47@redhat.com>
Date:   Fri, 18 Oct 2019 10:13:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191018021906.GA24978@hori.linux.bs1.fc.nec.co.jp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.65]); Fri, 18 Oct 2019 08:13:39 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.10.19 04:19, Naoya Horiguchi wrote:
> On Thu, Oct 17, 2019 at 08:27:59PM +0200, Michal Hocko wrote:
>> On Thu 17-10-19 14:07:13, Qian Cai wrote:
>>> On Thu, 2019-10-17 at 12:01 +0200, Michal Hocko wrote:
>>>> On Thu 17-10-19 09:34:10, Naoya Horiguchi wrote:
>>>>> On Mon, Oct 14, 2019 at 10:39:14AM +0200, Michal Hocko wrote:
>>>>
>>>> [...]
>>>>>> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
>>>>>> index 89c19c0feadb..5fb3fee16fde 100644
>>>>>> --- a/mm/page_isolation.c
>>>>>> +++ b/mm/page_isolation.c
>>>>>> @@ -274,7 +274,7 @@ __test_page_isolated_in_pageblock(unsigned long pfn, unsigned long end_pfn,
>>>>>>   			 * simple way to verify that as VM_BUG_ON(), though.
>>>>>>   			 */
>>>>>>   			pfn += 1 << page_order(page);
>>>>>> -		else if (skip_hwpoisoned_pages && PageHWPoison(page))
>>>>>> +		else if (skip_hwpoisoned_pages && PageHWPoison(compound_head(page)))
>>>>>>   			/* A HWPoisoned page cannot be also PageBuddy */
>>>>>>   			pfn++;
>>>>>>   		else
>>>>>
>>>>> This fix looks good to me. The original code only addresses hwpoisoned 4kB-page,
>>>>> we seem to have this issue since the following commit,
>>>>
>>>> Thanks a lot for double checking Naoya!
>>>>   
>>>>>    commit b023f46813cde6e3b8a8c24f432ff9c1fd8e9a64
>>>>>    Author: Wen Congyang <wency@cn.fujitsu.com>
>>>>>    Date:   Tue Dec 11 16:00:45 2012 -0800
>>>>>    
>>>>>        memory-hotplug: skip HWPoisoned page when offlining pages
>>>>>
>>>>> and extension of LTP coverage finally discovered this.
>>>>
>>>> Qian, could you give the patch some testing?
>>>
>>> Unfortunately, this does not solve the problem. It looks to me that in
>>> soft_offline_huge_page(), set_hwpoison_free_buddy_page() will only set
>>> PG_hwpoison for buddy pages, so the even the compound_head() has no PG_hwpoison
>>> set.
>>>
>>> 		if (PageBuddy(page_head) && page_order(page_head) >= order) {
>>> 			if (!TestSetPageHWPoison(page))
>>> 				hwpoisoned = true;
>>
>> This is more than unexpected. How are we supposed to find out that the
>> page is poisoned? Any idea Naoya?
> 
> # sorry for my poor review...
> 
> We set PG_hwpoison bit only on the head page for hugetlb, that's because
> we handle multiple pages as a single one for hugetlb. So it's enough
> to check isolation only on the head page.  Simply skipping pfn cursor to
> the page after the hugepage should avoid the infinite loop:
> 
>    @@ -274,9 +274,13 @@ __test_page_isolated_in_pageblock(unsigned long pfn, unsigned long end_pfn,
>     			 * simple way to verify that as VM_BUG_ON(), though.
>     			 */
>     			pfn += 1 << page_order(page);
>    -		else if (skip_hwpoisoned_pages && PageHWPoison(page))
>    -			/* A HWPoisoned page cannot be also PageBuddy */
>    -			pfn++;
>    +		else if (skip_hwpoisoned_pages && PageHWPoison(compound_head(page)))
>    +			/*
>    +			 * A HWPoisoned page cannot be also PageBuddy.
>    +			 * PG_hwpoison could be set only on the head page in
>    +			 * hugetlb case, so no need to check tail pages.
>    +			 */
>    +			pfn += 1 << compound_order(page);
>     		else
>     			break;
>     	}
> 
> Qian, could you please try this?

That should result in the same behavior if I'm not wrong.

a) Checking the head, skipping over the tail
b) Checking for every tail the head

However, if the compound page spans multiple pageblocks, I am not sure 
if your change is correct. (if you don't start at the compoound head - 
when page != compoound_head(page), you would still jump 1 << 
compound_order(page))

-- 

Thanks,

David / dhildenb
