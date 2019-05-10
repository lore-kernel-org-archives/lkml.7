Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 495F2C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 16:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16CA82070D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 16:54:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbfEJQyZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 12:54:25 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:44968 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727771AbfEJQyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 12:54:25 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R471e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0TRMMEdW_1557507254;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TRMMEdW_1557507254)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 11 May 2019 00:54:17 +0800
Subject: Re: [PATCH] mm: vmscan: correct nr_reclaimed for THP
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Huang, Ying" <ying.huang@intel.com>, hannes@cmpxchg.org,
        mhocko@suse.com, mgorman@techsingularity.net,
        kirill.shutemov@linux.intel.com, hughd@google.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1557447392-61607-1-git-send-email-yang.shi@linux.alibaba.com>
 <87y33fjbvr.fsf@yhuang-dev.intel.com>
 <20190510163612.GA23417@bombadil.infradead.org>
 <3a919cba-fefe-d78e-313a-8f0d81a4a75d@linux.alibaba.com>
 <20190510165207.GB3162@bombadil.infradead.org>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <72fb1554-4cda-27f4-8c09-038ab3350ff8@linux.alibaba.com>
Date:   Fri, 10 May 2019 09:54:11 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20190510165207.GB3162@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/10/19 9:52 AM, Matthew Wilcox wrote:
> On Fri, May 10, 2019 at 09:50:04AM -0700, Yang Shi wrote:
>> On 5/10/19 9:36 AM, Matthew Wilcox wrote:
>>> On Fri, May 10, 2019 at 10:12:40AM +0800, Huang, Ying wrote:
>>>>> +		nr_reclaimed += (1 << compound_order(page));
>>>> How about to change this to
>>>>
>>>>           nr_reclaimed += hpage_nr_pages(page);
>>> Please don't.  That embeds the knowledge that we can only swap out either
>>> normal pages or THP sized pages.  I'm trying to make the VM capable of
>>> supporting arbitrary-order pages, and this would be just one more place
>>> to fix.
>>>
>>> I'm sympathetic to the "self documenting" argument.  My current tree has
>>> a patch in it:
>>>
>>>       mm: Introduce compound_nr
>>>       Replace 1 << compound_order(page) with compound_nr(page).  Minor
>>>       improvements in readability.
>>>
>>> It goes along with this patch:
>>>
>>>       mm: Introduce page_size()
>>>
>>>       It's unnecessarily hard to find out the size of a potentially huge page.
>>>       Replace 'PAGE_SIZE << compound_order(page)' with page_size(page).
>> So you prefer keeping using  "1 << compound_order" as v1 did? Then you will
>> convert all "1 << compound_order" to compound_nr?
> Yes.  Please, let's merge v1 and ignore v2.

Fine to me. I think Andrew will take care of it, Andrew?


