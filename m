Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EAEEC2D0BF
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 10:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7268D24651
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 10:00:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729347AbfLEKAn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 05:00:43 -0500
Received: from relay.sw.ru ([185.231.240.75]:46774 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728955AbfLEKAn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 05:00:43 -0500
Received: from dhcp-172-16-24-104.sw.ru ([172.16.24.104])
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1icnw0-0005eA-3y; Thu, 05 Dec 2019 13:00:32 +0300
Subject: Re: [PATCH] mm: vmscan: protect shrinker idr replace with
 CONFIG_MEMCG
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Yang Shi <yang.shi@linux.alibaba.com>, hannes@cmpxchg.org,
        shakeelb@google.com, guro@fb.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1575486978-45249-1-git-send-email-yang.shi@linux.alibaba.com>
 <e320f8af-c164-ce5e-8964-8785b0bf5f2e@virtuozzo.com>
 <20191205094341.GC28317@dhcp22.suse.cz>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <894b9951-449d-6d7e-84aa-a1c510417710@virtuozzo.com>
Date:   Thu, 5 Dec 2019 13:00:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191205094341.GC28317@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.12.2019 12:43, Michal Hocko wrote:
> On Thu 05-12-19 11:23:28, Kirill Tkhai wrote:
>> On 04.12.2019 22:16, Yang Shi wrote:
>>> Since commit 0a432dcbeb32edcd211a5d8f7847d0da7642a8b4 ("mm: shrinker:
>>> make shrinker not depend on memcg kmem"), shrinkers' idr is protected by
>>> CONFIG_MEMCG instead of CONFIG_MEMCG_KMEM, so it makes no sense to
>>> protect shrinker idr replace with CONFIG_MEMCG_KMEM.
>>>
>>> Cc: Kirill Tkhai <ktkhai@virtuozzo.com>
>>> Cc: Johannes Weiner <hannes@cmpxchg.org>
>>> Cc: Michal Hocko <mhocko@suse.com>
>>> Cc: Shakeel Butt <shakeelb@google.com>
>>> Cc: Roman Gushchin <guro@fb.com>
>>> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
>>
>> It looks like that in CONFIG_SLOB case we do not even call some shrinkers
>> for subordinate mem cgroups (i.e., we don't call deferred_split_shrinker),
>> since they never become completely registered.
>>
>> Fixes: 0a432dcbeb32edcd211a5d8f7847d0da7642a8b4 ("mm: shrinker: make shrinker not depend on memcg kmem")
> 
> I am confused. Why the Fixes tag? Nothing should be really broken with
> KMEM config guard right?

idr_replace() is disabled in CONFIG_MEMCG && CONFIG_SLOB case, and this is
wrong.

0a432dcbeb32edcd211a5d8f7847d0da7642a8b4 goes in the series, which enables
shrinker_idr infrastructure for huge_memory.c's deferred_split_shrinker
in CONFIG_MEMCG case. Previously, all SHRINKER_MEMCG_AWARE shrinkers were
based on LRUs, and they remain to base of CONFIG_MEMCG_KMEM.
But deferred_split_shrinker is an exception.

In CONFIG_MEMCG && CONFIG_SLOB case, shrinker_idr contains only shrinker,
and it is deferred_split_shrinker. But it is never actually called, since
idr_replace() is never compiled. deferred_split_shrinker all the time is
staying in half-registered state, and it's never called for subordinate
mem cgroups.

So, this is a BUG, and this should go to stable.

> This is a mere clean up AFAICS.
> 
>> Reviewed-by: Kirill Tkhai <ktkhai@virtuozzo.com>
>>
>>> ---
>>>  mm/vmscan.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>>> index ee4eecc..e7f10c4 100644
>>> --- a/mm/vmscan.c
>>> +++ b/mm/vmscan.c
>>> @@ -422,7 +422,7 @@ void register_shrinker_prepared(struct shrinker *shrinker)
>>>  {
>>>  	down_write(&shrinker_rwsem);
>>>  	list_add_tail(&shrinker->list, &shrinker_list);
>>> -#ifdef CONFIG_MEMCG_KMEM
>>> +#ifdef CONFIG_MEMCG
>>>  	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
>>>  		idr_replace(&shrinker_idr, shrinker, shrinker->id);
>>>  #endif
>>>
> 

