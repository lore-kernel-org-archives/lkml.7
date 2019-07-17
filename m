Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0443C7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 16:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C648721743
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 16:51:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728144AbfGQQvd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 12:51:33 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:42080 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727124AbfGQQvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 12:51:33 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0TX8jliE_1563382282;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TX8jliE_1563382282)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 18 Jul 2019 00:51:24 +0800
Subject: Re: [v2 PATCH 1/2] mm: mempolicy: make the behavior consistent when
 MPOL_MF_MOVE* and MPOL_MF_STRICT were specified
To:     Vlastimil Babka <vbabka@suse.cz>, mhocko@kernel.org,
        mgorman@techsingularity.net, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1561162809-59140-1-git-send-email-yang.shi@linux.alibaba.com>
 <1561162809-59140-2-git-send-email-yang.shi@linux.alibaba.com>
 <fb74d657-90cd-6667-f253-162c951f1b05@suse.cz>
 <efe90132-6832-d61a-5d55-d2cc134c7087@linux.alibaba.com>
 <7806e608-ffcb-fd56-2e0f-a20bea127f40@suse.cz>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <88894b57-7005-5882-ab9f-fc64e42cf8ca@linux.alibaba.com>
Date:   Wed, 17 Jul 2019 09:51:21 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <7806e608-ffcb-fd56-2e0f-a20bea127f40@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/17/19 3:55 AM, Vlastimil Babka wrote:
> On 7/16/19 7:18 PM, Yang Shi wrote:
>>> I think after your patch, you miss putback_movable_pages() in cases
>>> where some were queued, and later the walk returned -EIO. The previous
>>> code doesn't miss it, but it's also not obvious due to the multiple if
>>> (!err) checks. I would rewrite it some thing like this:
>>>
>>> if (ret < 0) {
>>>       putback_movable_pages(&pagelist);
>>>       err = ret;
>>>       goto mmap_out; // a new label above up_write()
>>> }
>> Yes, the old code had putback_movable_pages called when !err. But, I
>> think that is for error handling of mbind_range() if I understand it
>> correctly since if queue_pages_range() returns -EIO (only MPOL_MF_STRICT
>> was specified and there was misplaced page) that page list should be
>> empty . The old code should checked whether that list is empty or not.
> Hm I guess you're right, returning with EIO means nothing was queued.
>> So, in the new code I just removed that.
>>
>>> The rest can have reduced identation now.
>> Yes, the goto does eliminate the extra indentation.
>>
>>>> +	else {
>>>> +		err = mbind_range(mm, start, end, new);
>>>>    
>>>> -		if (nr_failed && (flags & MPOL_MF_STRICT))
>>>> -			err = -EIO;
>>>> -	} else
>>>> -		putback_movable_pages(&pagelist);
>>>> +		if (!err) {
>>>> +			int nr_failed = 0;
>>>> +
>>>> +			if (!list_empty(&pagelist)) {
>>>> +				WARN_ON_ONCE(flags & MPOL_MF_LAZY);
>>>> +				nr_failed = migrate_pages(&pagelist, new_page,
>>>> +					NULL, start, MIGRATE_SYNC,
>>>> +					MR_MEMPOLICY_MBIND);
>>>> +				if (nr_failed)
>>>> +					putback_movable_pages(&pagelist);
>>>> +			}
>>>> +
>>>> +			if ((ret > 0) ||
>>>> +			    (nr_failed && (flags & MPOL_MF_STRICT)))
>>>> +				err = -EIO;
>>>> +		} else
>>>> +			putback_movable_pages(&pagelist);
>>> While at it, IIRC the kernel style says that when the 'if' part uses
>>> '{ }' then the 'else' part should as well, and it shouldn't be mixed.
>> Really? The old code doesn't have '{ }' for else, and checkpatch doesn't
>> report any error or warning.
> Checkpatch probably doesn't catch it, nor did the reviewers of the older
> code. But coding-style.rst says:
>
> Do not unnecessarily use braces where a single statement will do.
>
> ...
>
> This does not apply if only one branch of a conditional statement is a
> single
> statement; in the latter case use braces in both branches:
>
> .. code-block:: c
>
>          if (condition) {
>                  do_this();
>                  do_that();
>          } else {
>                  otherwise();
>          }

Thanks. Good to know this. Anyway, with the "goto" suggested above, we 
don't need that "else" anymore and we could save some change of lines.

>
>
> Thanks,
> Vlastimil

