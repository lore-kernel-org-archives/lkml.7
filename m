Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E08BCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 18:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D8F2206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 18:49:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbfJYStk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 14:49:40 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:38365 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726079AbfJYStj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 14:49:39 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R651e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01451;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0TgBtoWc_1572029368;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TgBtoWc_1572029368)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 26 Oct 2019 02:49:31 +0800
Subject: Re: [PATCH] mm: thp: clear PageDoubleMap flag when the last PMD map
 gone
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     hughd@google.com, kirill.shutemov@linux.intel.com,
        aarcange@redhat.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1571938066-29031-1-git-send-email-yang.shi@linux.alibaba.com>
 <20191025153618.ajcecye3bjm5abax@box>
 <74becfc0-3c34-bdd2-02cd-25b763c92f3b@linux.alibaba.com>
 <20191025163233.myl7kcgz25qsbnwm@box> <20191025163955.qsvkqic2hrorvdzj@box>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <2171f0a9-d01a-e863-2009-3f1bfa249d6c@linux.alibaba.com>
Date:   Fri, 25 Oct 2019 11:49:26 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20191025163955.qsvkqic2hrorvdzj@box>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/25/19 9:39 AM, Kirill A. Shutemov wrote:
> On Fri, Oct 25, 2019 at 07:32:33PM +0300, Kirill A. Shutemov wrote:
>> On Fri, Oct 25, 2019 at 08:58:22AM -0700, Yang Shi wrote:
>>>
>>> On 10/25/19 8:36 AM, Kirill A. Shutemov wrote:
>>>> On Fri, Oct 25, 2019 at 01:27:46AM +0800, Yang Shi wrote:
>>>>> File THP sets PageDoubleMap flag when the first it gets PTE mapped, but
>>>>> the flag is never cleared until the THP is freed.  This result in
>>>>> unbalanced state although it is not a big deal.
>>>>>
>>>>> Clear the flag when the last compound_mapcount is gone.  It should be
>>>>> cleared when all the PTE maps are gone (become PMD mapped only) as well,
>>>>> but this needs check all subpage's _mapcount every time any subpage's
>>>>> rmap is removed, the overhead may be not worth.  The anonymous THP also
>>>>> just clears PageDoubleMap flag when the last PMD map is gone.
>>>> NAK, sorry.
>>>>
>>>> The key difference with anon THP that file THP can be mapped again with
>>>> PMD after all PMD (or all) mappings are gone.
>>>>
>>>> Your patch breaks the case when you map the page with PMD again while the
>>>> page is still mapped with PTEs. Who would set PageDoubleMap() in this
>>>> case?
>>> Aha, yes, you are right. I missed that point. However, I'm wondering we
>>> might move this up a little bit like this:
>>>
>>> diff --git a/mm/rmap.c b/mm/rmap.c
>>> index d17cbf3..ac046fd 100644
>>> --- a/mm/rmap.c
>>> +++ b/mm/rmap.c
>>> @@ -1230,15 +1230,17 @@ static void page_remove_file_rmap(struct page *page,
>>> bool compound)
>>>                          if (atomic_add_negative(-1, &page[i]._mapcount))
>>>                                  nr++;
>>>                  }
>>> +
>>> +               /* No PTE map anymore */
>>> +               if (nr == HPAGE_PMD_NR)
>>> +                       ClearPageDoubleMap(compound_head(page));
>>> +
>>>                  if (!atomic_add_negative(-1, compound_mapcount_ptr(page)))
>>>                          goto out;
>>>                  if (PageSwapBacked(page))
>>>                          __dec_node_page_state(page, NR_SHMEM_PMDMAPPED);
>>>                  else
>>>                          __dec_node_page_state(page, NR_FILE_PMDMAPPED);
>>> -
>>> -               /* The last PMD map is gone */
>>> -               ClearPageDoubleMap(compound_head(page));
>>>          } else {
>>>                  if (!atomic_add_negative(-1, &page->_mapcount))
>>>                          goto out;
>>>
>>>
>>> This should guarantee no PTE map anymore, it should be safe to clear the
>>> flag.
>> At first glance looks safe, but let me think more about it. I didn't
>> expect it be that easy :P
> How do you protect from races? What prevents other thread/process to map
> the page as PTE after you've calculated 'nr'?
>
> I don't remember the code that well, but I believe we don't require
> PageLock for all cases... Or do we?

No, page lock is required by adding PTE rmap, but not required when 
removing rmap, i.e. huge pmd split. It looks we can't prevent from the 
races for processes, threads are protected by ptl.

>

