Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F4CC76192
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 17:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF5C22173C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 17:19:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388234AbfGPRT1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 13:19:27 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:49459 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728124AbfGPRT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 13:19:27 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0TX4BD5v_1563297559;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TX4BD5v_1563297559)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 17 Jul 2019 01:19:21 +0800
Subject: Re: [v2 PATCH 1/2] mm: mempolicy: make the behavior consistent when
 MPOL_MF_MOVE* and MPOL_MF_STRICT were specified
To:     Vlastimil Babka <vbabka@suse.cz>, mhocko@kernel.org,
        mgorman@techsingularity.net, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1561162809-59140-1-git-send-email-yang.shi@linux.alibaba.com>
 <1561162809-59140-2-git-send-email-yang.shi@linux.alibaba.com>
 <fb74d657-90cd-6667-f253-162c951f1b05@suse.cz>
 <0a57d280-a56c-ceef-282b-b9dec380c7c7@suse.cz>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <3933e4b1-e6cd-3e6b-d1a3-7a835767ab44@linux.alibaba.com>
Date:   Tue, 16 Jul 2019 10:19:17 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <0a57d280-a56c-ceef-282b-b9dec380c7c7@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/16/19 1:47 AM, Vlastimil Babka wrote:
> On 7/16/19 10:12 AM, Vlastimil Babka wrote:
>>> --- a/mm/mempolicy.c
>>> +++ b/mm/mempolicy.c
>>> @@ -429,11 +429,14 @@ static inline bool queue_pages_required(struct page *page,
>>>   }
>>>   
>>>   /*
>>> - * queue_pages_pmd() has three possible return values:
>>> + * queue_pages_pmd() has four possible return values:
>>> + * 2 - there is unmovable page, and MPOL_MF_MOVE* & MPOL_MF_STRICT were
>>> + *     specified.
>>>    * 1 - pages are placed on the right node or queued successfully.
>>>    * 0 - THP was split.
>> I think if you renumbered these, it would be more consistent with
>> queue_pages_pte_range() and simplify the code there.
>> 0 - pages on right node/queued
>> 1 - unmovable page with right flags specified
>> 2 - THP split
> Ah, alternatively you could add a boolean to struct queue_pages
> accessible from mm_walk, set true to indicate that unmovable page has
> been encountered, without propagating it back through special return values.

I will try both to see which one (renumbering return value or use flag) 
is better.

Thanks,
Yang


