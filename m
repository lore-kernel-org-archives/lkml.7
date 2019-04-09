Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD1D8C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 14:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94BC02133D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 14:43:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbfDIOn2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 10:43:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:43264 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726709AbfDIOn0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 10:43:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2033EAFDA;
        Tue,  9 Apr 2019 14:43:25 +0000 (UTC)
Subject: Re: [PATCH] mm/vmstat: fix /proc/vmstat format for
 CONFIG_DEBUG_TLBFLUSH=y CONFIG_SMP=n
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Roman Gushchin <guro@fb.com>, Jann Horn <jannh@google.com>
References: <155481488468.467.4295519102880913454.stgit@buzz>
 <a606145d-b2e6-a55d-5e62-52492309e7dc@suse.cz>
 <bfcc286e-48dd-8069-3287-a923e4b5ab65@yandex-team.ru>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <81880eb3-ab26-e968-1820-5d5e46f82836@suse.cz>
Date:   Tue, 9 Apr 2019 16:43:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <bfcc286e-48dd-8069-3287-a923e4b5ab65@yandex-team.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/9/19 3:28 PM, Konstantin Khlebnikov wrote:
> On 09.04.2019 16:16, Vlastimil Babka wrote:
>> On 4/9/19 3:01 PM, Konstantin Khlebnikov wrote:
>>> Commit 58bc4c34d249 ("mm/vmstat.c: skip NR_TLB_REMOTE_FLUSH* properly")
>>> depends on skipping vmstat entries with empty name introduced in commit
>>> 7aaf77272358 ("mm: don't show nr_indirectly_reclaimable in /proc/vmstat")
>>> but reverted in commit b29940c1abd7 ("mm: rename and change semantics of
>>> nr_indirectly_reclaimable_bytes").
>> 
>> Oops, good catch.
> 
> Also 4.19.y has broken format in /sys/devices/system/node/node*/vmstat and /proc/zoneinfo.
> Do you have any plans on pushing related slab changes into that stable branch?

Hmm do you mean this?
https://lore.kernel.org/linux-mm/20181030174649.16778-1-guro@fb.com/

Looks like Roman marked it wrongly for # 4.14.x-4.18.x and I didn't notice, my
slab changes are indeed 4.20, so we should resend for 4.19.

>> 
>>> So, skipping no longer works and /proc/vmstat has misformatted lines " 0".
>>> This patch simply shows debug counters "nr_tlb_remote_*" for UP.
>> 
>> Right, that's the the best solution IMHO.
>> 
>>> Fixes: 58bc4c34d249 ("mm/vmstat.c: skip NR_TLB_REMOTE_FLUSH* properly")
>>> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
>> 
>> Acked-by: Vlastimil Babka <vbabka@suse.cz>
>> 
>>> ---
>>>   mm/vmstat.c |    5 -----
>>>   1 file changed, 5 deletions(-)
>>>
>>> diff --git a/mm/vmstat.c b/mm/vmstat.c
>>> index 36b56f858f0f..a7d493366a65 100644
>>> --- a/mm/vmstat.c
>>> +++ b/mm/vmstat.c
>>> @@ -1274,13 +1274,8 @@ const char * const vmstat_text[] = {
>>>   #endif
>>>   #endif /* CONFIG_MEMORY_BALLOON */
>>>   #ifdef CONFIG_DEBUG_TLBFLUSH
>>> -#ifdef CONFIG_SMP
>>>   	"nr_tlb_remote_flush",
>>>   	"nr_tlb_remote_flush_received",
>>> -#else
>>> -	"", /* nr_tlb_remote_flush */
>>> -	"", /* nr_tlb_remote_flush_received */
>>> -#endif /* CONFIG_SMP */
>>>   	"nr_tlb_local_flush_all",
>>>   	"nr_tlb_local_flush_one",
>>>   #endif /* CONFIG_DEBUG_TLBFLUSH */
>>>
>> 
> 

