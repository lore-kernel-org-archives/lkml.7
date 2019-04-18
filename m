Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B6A5C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 16:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3880521479
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 16:48:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389704AbfDRQs1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 12:48:27 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:38663 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387519AbfDRQs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 12:48:26 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0TPeyfr1_1555606089;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TPeyfr1_1555606089)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 19 Apr 2019 00:48:12 +0800
Subject: Re: [PATCH] mm: use mm.arg_lock in get_cmdline()
To:     Laurent Dufour <ldufour@linux.ibm.com>,
        Michal Hocko <mhocko@kernel.org>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Michal Koutny <mkoutny@suse.com>
References: <20190418125827.57479-1-ldufour@linux.ibm.com>
 <20190418130310.GJ6567@dhcp22.suse.cz>
 <749b8c73-a97d-b568-c0e5-a7bda77090c9@linux.ibm.com>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <efc01241-1ef0-09ed-e3b5-c4b04a0f64e8@linux.alibaba.com>
Date:   Thu, 18 Apr 2019 09:48:09 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <749b8c73-a97d-b568-c0e5-a7bda77090c9@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/18/19 6:05 AM, Laurent Dufour wrote:
> Le 18/04/2019 à 15:03, Michal Hocko a écrit :
>> Michal has posted the same patch few days ago 
>> http://lkml.kernel.org/r/20190417120347.15397-1-mkoutny@suse.com
>
> Oups, sorry for the noise, I missed it.

Yes, Michal already posted a similar patch. Anyway, thanks for catching 
this.

>
>> On Thu 18-04-19 14:58:27, Laurent Dufour wrote:
>>> The commit 88aa7cc688d4 ("mm: introduce arg_lock to protect 
>>> arg_start|end
>>> and env_start|end in mm_struct") introduce the spinlock arg_lock to 
>>> protect
>>> the arg_* and env_* field of the mm_struct structure.
>>>
>>> While reading the code, I found that this new spinlock was not used in
>>> get_cmdline() to protect access to these fields.
>>>
>>> Fixing this even if there is no issue reported yet for this.
>>>
>>> Fixes: 88aa7cc688d4 ("mm: introduce arg_lock to protect 
>>> arg_start|end and env_start|end in mm_struct")
>>> Cc: Yang Shi <yang.shi@linux.alibaba.com>
>>> Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
>>> ---
>>>   mm/util.c | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/mm/util.c b/mm/util.c
>>> index 05a464929b3e..789760c3028b 100644
>>> --- a/mm/util.c
>>> +++ b/mm/util.c
>>> @@ -758,12 +758,12 @@ int get_cmdline(struct task_struct *task, char 
>>> *buffer, int buflen)
>>>       if (!mm->arg_end)
>>>           goto out_mm;    /* Shh! No looking before we're done */
>>>   -    down_read(&mm->mmap_sem);
>>> +    spin_lock(&mm->arg_lock);
>>>       arg_start = mm->arg_start;
>>>       arg_end = mm->arg_end;
>>>       env_start = mm->env_start;
>>>       env_end = mm->env_end;
>>> -    up_read(&mm->mmap_sem);
>>> +    spin_unlock(&mm->arg_lock);
>>>         len = arg_end - arg_start;
>>>   --
>>> 2.21.0
>>

