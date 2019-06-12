Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E49E0C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 17:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4BE1215EA
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 17:14:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728987AbfFLROC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 13:14:02 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:42790 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726721AbfFLROB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 13:14:01 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R281e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07487;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0TU.ZihY_1560359634;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TU.ZihY_1560359634)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 13 Jun 2019 01:13:57 +0800
Subject: Re: [PATCH 2/4] mm: thp: make deferred split shrinker memcg aware
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     ktkhai@virtuozzo.com, kirill.shutemov@linux.intel.com,
        hannes@cmpxchg.org, mhocko@suse.com, hughd@google.com,
        shakeelb@google.com, rientjes@google.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1559887659-23121-1-git-send-email-yang.shi@linux.alibaba.com>
 <1559887659-23121-3-git-send-email-yang.shi@linux.alibaba.com>
 <20190612024747.f5nsol7ntvubjckq@box>
 <ace52062-e6be-a3f2-7ef1-d8612f3a76f9@linux.alibaba.com>
 <20190612100906.xllp2bfgmadvbh2q@box>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <d2f6737c-6682-f985-0790-77483e95f298@linux.alibaba.com>
Date:   Wed, 12 Jun 2019 10:13:51 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20190612100906.xllp2bfgmadvbh2q@box>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/12/19 3:09 AM, Kirill A. Shutemov wrote:
> On Tue, Jun 11, 2019 at 10:06:36PM -0700, Yang Shi wrote:
>>
>> On 6/11/19 7:47 PM, Kirill A. Shutemov wrote:
>>> On Fri, Jun 07, 2019 at 02:07:37PM +0800, Yang Shi wrote:
>>>> +	/*
>>>> +	 * The THP may be not on LRU at this point, e.g. the old page of
>>>> +	 * NUMA migration.  And PageTransHuge is not enough to distinguish
>>>> +	 * with other compound page, e.g. skb, THP destructor is not used
>>>> +	 * anymore and will be removed, so the compound order sounds like
>>>> +	 * the only choice here.
>>>> +	 */
>>>> +	if (PageTransHuge(page) && compound_order(page) == HPAGE_PMD_ORDER) {
>>> What happens if the page is the same order as THP is not THP? Why removing
>> It may corrupt the deferred split queue since it is never added into the
>> list, but deleted here.
>>
>>> of destructor is required?
>> Due to the change to free_transhuge_page() (extracted deferred split queue
>> manipulation and moved before memcg uncharge since page->mem_cgroup is
>> needed), it just calls free_compound_page(). So, it sounds pointless to
>> still keep THP specific destructor.
>>
>> It looks there is not a good way to tell if the compound page is THP in
>> free_page path or not, we may keep the destructor just for this?
> Other option would be to move mem_cgroup_uncharge(page); from
> __page_cache_release() to destructors. Destructors will be able to
> call it as it fits.

Yes, it is an option. Since __page_cache_release() is called by 
__put_single_page() too, so mem_cgroup_uncharge() has to be called in 
both __put_single_page() and the desctructor (free_compound_page() which 
is called by both THP and other compound page except HugeTLB). But, it 
sounds acceptable IMHO.

>

