Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B09BC282DA
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 15:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC3A62084F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 15:14:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="hzUCGN+h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbfDIPOz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 11:14:55 -0400
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:49496 "EHLO
        forwardcorp1o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726494AbfDIPOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 11:14:55 -0400
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::301])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id A76C12E124E;
        Tue,  9 Apr 2019 18:14:51 +0300 (MSK)
Received: from smtpcorp1p.mail.yandex.net (smtpcorp1p.mail.yandex.net [2a02:6b8:0:1472:2741:0:8b6:10])
        by mxbackcorp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id O6B4N7cw9s-Epe4nNAf;
        Tue, 09 Apr 2019 18:14:51 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1554822891; bh=Zq7XV50n7QXA0gzTBdPE0IaBxIK3vgM1+6amziQnoP4=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=hzUCGN+hKdMsnX47sEsw2Dh0TaJ17wBUMk+eFFp8yvRU2HIJV31WqaqlcNctOm3Pv
         hfhK/fBuSyBHWdBY6jFCRWFyZcORXl/BvxMdA/5KU9DOedFOH7Rm5xlSCu4sro9nRk
         m2BapnreM33Zyj5NR1hxDyw/NdqG2O/7gWnFQ9Qw=
Authentication-Results: mxbackcorp1o.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net [2a02:6b8:0:3711::1:6d])
        by smtpcorp1p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id Nakda5vvvL-Ep0iGsqr;
        Tue, 09 Apr 2019 18:14:51 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: Re: [PATCH] mm/vmstat: fix /proc/vmstat format for
 CONFIG_DEBUG_TLBFLUSH=y CONFIG_SMP=n
To:     Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Roman Gushchin <guro@fb.com>, Jann Horn <jannh@google.com>
References: <155481488468.467.4295519102880913454.stgit@buzz>
 <a606145d-b2e6-a55d-5e62-52492309e7dc@suse.cz>
 <bfcc286e-48dd-8069-3287-a923e4b5ab65@yandex-team.ru>
 <81880eb3-ab26-e968-1820-5d5e46f82836@suse.cz>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <abd24dbf-c5b2-1222-c066-5a6736ad3ecb@yandex-team.ru>
Date:   Tue, 9 Apr 2019 18:14:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <81880eb3-ab26-e968-1820-5d5e46f82836@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09.04.2019 17:43, Vlastimil Babka wrote:
> On 4/9/19 3:28 PM, Konstantin Khlebnikov wrote:
>> On 09.04.2019 16:16, Vlastimil Babka wrote:
>>> On 4/9/19 3:01 PM, Konstantin Khlebnikov wrote:
>>>> Commit 58bc4c34d249 ("mm/vmstat.c: skip NR_TLB_REMOTE_FLUSH* properly")
>>>> depends on skipping vmstat entries with empty name introduced in commit
>>>> 7aaf77272358 ("mm: don't show nr_indirectly_reclaimable in /proc/vmstat")
>>>> but reverted in commit b29940c1abd7 ("mm: rename and change semantics of
>>>> nr_indirectly_reclaimable_bytes").
>>>
>>> Oops, good catch.
>>
>> Also 4.19.y has broken format in /sys/devices/system/node/node*/vmstat and /proc/zoneinfo.
>> Do you have any plans on pushing related slab changes into that stable branch?
> 
> Hmm do you mean this?
> https://lore.kernel.org/linux-mm/20181030174649.16778-1-guro@fb.com/
> 
> Looks like Roman marked it wrongly for # 4.14.x-4.18.x and I didn't notice, my
> slab changes are indeed 4.20, so we should resend for 4.19.

Yep, this should fix zoneinfo
but /sys/devices/system/node/node*/vmstat needs yet another fix.

> 
>>>
>>>> So, skipping no longer works and /proc/vmstat has misformatted lines " 0".
>>>> This patch simply shows debug counters "nr_tlb_remote_*" for UP.
>>>
>>> Right, that's the the best solution IMHO.
>>>
>>>> Fixes: 58bc4c34d249 ("mm/vmstat.c: skip NR_TLB_REMOTE_FLUSH* properly")
>>>> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
>>>
>>> Acked-by: Vlastimil Babka <vbabka@suse.cz>
>>>
>>>> ---
>>>>    mm/vmstat.c |    5 -----
>>>>    1 file changed, 5 deletions(-)
>>>>
>>>> diff --git a/mm/vmstat.c b/mm/vmstat.c
>>>> index 36b56f858f0f..a7d493366a65 100644
>>>> --- a/mm/vmstat.c
>>>> +++ b/mm/vmstat.c
>>>> @@ -1274,13 +1274,8 @@ const char * const vmstat_text[] = {
>>>>    #endif
>>>>    #endif /* CONFIG_MEMORY_BALLOON */
>>>>    #ifdef CONFIG_DEBUG_TLBFLUSH
>>>> -#ifdef CONFIG_SMP
>>>>    	"nr_tlb_remote_flush",
>>>>    	"nr_tlb_remote_flush_received",
>>>> -#else
>>>> -	"", /* nr_tlb_remote_flush */
>>>> -	"", /* nr_tlb_remote_flush_received */
>>>> -#endif /* CONFIG_SMP */
>>>>    	"nr_tlb_local_flush_all",
>>>>    	"nr_tlb_local_flush_one",
>>>>    #endif /* CONFIG_DEBUG_TLBFLUSH */
>>>>
>>>
>>
> 
