Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A15B4C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 01:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F93420878
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 01:05:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbfKUBFr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 20:05:47 -0500
Received: from mga14.intel.com ([192.55.52.115]:5760 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726202AbfKUBFr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 20:05:47 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2019 17:05:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,223,1571727600"; 
   d="scan'208";a="237975989"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga002.fm.intel.com with ESMTP; 20 Nov 2019 17:05:45 -0800
Date:   Thu, 21 Nov 2019 09:05:36 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Wei Yang <richardw.yang@linux.intel.com>,
        n-horiguchi@ah.jp.nec.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm/memory-failure.c: not necessary to recalculate
 hpage
Message-ID: <20191121010536.GA12975@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20191118082003.26240-1-richardw.yang@linux.intel.com>
 <20191118082003.26240-2-richardw.yang@linux.intel.com>
 <fdba31c8-d0c0-83a8-62d1-c04c1e894218@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fdba31c8-d0c0-83a8-62d1-c04c1e894218@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 04:07:38PM +0100, David Hildenbrand wrote:
>On 18.11.19 09:20, Wei Yang wrote:
>> hpage is not changed.
>> 
>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>> ---
>>   mm/memory-failure.c | 1 -
>>   1 file changed, 1 deletion(-)
>> 
>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>> index 392ac277b17d..9784f4339ae7 100644
>> --- a/mm/memory-failure.c
>> +++ b/mm/memory-failure.c
>> @@ -1319,7 +1319,6 @@ int memory_failure(unsigned long pfn, int flags)
>>   		}
>>   		unlock_page(p);
>>   		VM_BUG_ON_PAGE(!page_count(p), p);
>> -		hpage = compound_head(p);
>>   	}
>>   	/*
>> 
>
>I am *absolutely* no transparent huge page expert (sorry :) ), but won't the
>split_huge_page(p) eventually split the compound page, such that
>compound_head(p) will return something else after that call?
>

ok, you may get some point. I lost some concentration here.

Thanks

>-- 
>
>Thanks,
>
>David / dhildenb

-- 
Wei Yang
Help you, Help me
