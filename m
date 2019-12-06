Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE75AC43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 01:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 798552075C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 01:48:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbfLFBse (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 20:48:34 -0500
Received: from mga05.intel.com ([192.55.52.43]:46933 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725988AbfLFBse (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 20:48:34 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Dec 2019 17:48:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,282,1571727600"; 
   d="scan'208";a="205970739"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by orsmga008.jf.intel.com with ESMTP; 05 Dec 2019 17:48:31 -0800
Date:   Fri, 6 Dec 2019 09:48:25 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Wei Yang <richard.weiyang@gmail.com>,
        Wei Yang <richardw.yang@linux.intel.com>,
        n-horiguchi@ah.jp.nec.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm/memory-failure.c: not necessary to recalculate
 hpage
Message-ID: <20191206014825.GA3846@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20191118082003.26240-1-richardw.yang@linux.intel.com>
 <20191118082003.26240-2-richardw.yang@linux.intel.com>
 <fdba31c8-d0c0-83a8-62d1-c04c1e894218@redhat.com>
 <20191202222827.isaelnqmuyn7zrns@master>
 <37eedde2-05ab-e42e-7bcd-09090b090366@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37eedde2-05ab-e42e-7bcd-09090b090366@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 05, 2019 at 04:06:20PM +0100, David Hildenbrand wrote:
>On 02.12.19 23:28, Wei Yang wrote:
>> On Wed, Nov 20, 2019 at 04:07:38PM +0100, David Hildenbrand wrote:
>>> On 18.11.19 09:20, Wei Yang wrote:
>>>> hpage is not changed.
>>>>
>>>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>>>> ---
>>>>   mm/memory-failure.c | 1 -
>>>>   1 file changed, 1 deletion(-)
>>>>
>>>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>>>> index 392ac277b17d..9784f4339ae7 100644
>>>> --- a/mm/memory-failure.c
>>>> +++ b/mm/memory-failure.c
>>>> @@ -1319,7 +1319,6 @@ int memory_failure(unsigned long pfn, int flags)
>>>>   		}
>>>>   		unlock_page(p);
>>>>   		VM_BUG_ON_PAGE(!page_count(p), p);
>>>> -		hpage = compound_head(p);
>>>>   	}
>>>>   	/*
>>>>
>>>
>>> I am *absolutely* no transparent huge page expert (sorry :) ), but won't the
>>> split_huge_page(p) eventually split the compound page, such that
>>> compound_head(p) will return something else after that call?
>>>
>> 
>> Hi, David
>> 
>> Took sometime to look into the code and re-think about it. Found maybe we can
>> simplify this in another way.
>> 
>> First, code touches here means split_huge_page() succeeds and "p" is now a PTE
>> page. So compound_head(p) == p.
>
>While this would also be my intuition, I can't state that this is
>guaranteed to be the case (IOW, I did not check the code/documentation) :)
>

If my understanding is correct, split_huge_page() succeeds the THP would be
tear down to normal page.

>> 
>> Then let's look at who will use hpage in the following function. There are two
>> uses in current upstream:
>> 
>>     * page_flags calculation
>>     * hwpoison_user_mappings()
>> 
>> The first one would be removed in next patch since PageHuge is handled at the
>> beginning.
>> 
>> And in the second place, comment says if split succeeds, hpage points to page
>> "p".
>> 
>> After all, we don't need to re-calculate hpage after split, and just replace
>> hpage in hwpoison_user_mappings() with p is enough.
>
>That assumption would only be true in case all compound pages at this
>point are transparent huge pages, no? AFAIK that is not necessarily
>true. Or am I missing something?
>

Function hwpoison_user_mappings() just handle user space mapping. If my
understanding is correct, we just have three type of pages would be used in
user space mapping:

    * normal page
    * THP
    * hugetlb

Since THP would be split or already returned and hugetlb is handled in another
branch, this means for other pages hwpoison_user_mappings() would just return
true.

>
>-- 
>Thanks,
>
>David / dhildenb

-- 
Wei Yang
Help you, Help me
