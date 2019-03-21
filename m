Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2332BC4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 23:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE8A421900
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 23:29:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbfCUX3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 19:29:40 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:45746 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727274AbfCUX3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 19:29:40 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04427;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0TNJJXe4_1553210974;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TNJJXe4_1553210974)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 22 Mar 2019 07:29:36 +0800
Subject: Re: [RFC PATCH] mm: mempolicy: remove MPOL_MF_LAZY
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Michal Hocko <mhocko@kernel.org>, vbabka@suse.cz,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1553041659-46787-1-git-send-email-yang.shi@linux.alibaba.com>
 <20190321145745.GS8696@dhcp22.suse.cz>
 <75059b39-dbc4-3649-3e6b-7bdf282e3f53@linux.alibaba.com>
 <20190321165112.GU8696@dhcp22.suse.cz>
 <60ef6b4a-4f24-567f-af2f-50d97a2672d6@linux.alibaba.com>
 <20190321192403.GF3189@techsingularity.net>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <504618a2-3214-5f25-5d59-2aee629a9ff1@linux.alibaba.com>
Date:   Thu, 21 Mar 2019 16:29:32 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20190321192403.GF3189@techsingularity.net>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/21/19 12:24 PM, Mel Gorman wrote:
> On Thu, Mar 21, 2019 at 10:25:08AM -0700, Yang Shi wrote:
>>
>> On 3/21/19 9:51 AM, Michal Hocko wrote:
>>> On Thu 21-03-19 09:21:39, Yang Shi wrote:
>>>> On 3/21/19 7:57 AM, Michal Hocko wrote:
>>>>> On Wed 20-03-19 08:27:39, Yang Shi wrote:
>>>>>> MPOL_MF_LAZY was added by commit b24f53a0bea3 ("mm: mempolicy: Add
>>>>>> MPOL_MF_LAZY"), then it was disabled by commit a720094ded8c ("mm:
>>>>>> mempolicy: Hide MPOL_NOOP and MPOL_MF_LAZY from userspace for now")
>>>>>> right away in 2012.  So, it is never ever exported to userspace.
>>>>>>
>>>>>> And, it looks nobody is interested in revisiting it since it was
>>>>>> disabled 7 years ago.  So, it sounds pointless to still keep it around.
>>>>> The above changelog owes us a lot of explanation about why this is
>>>>> safe and backward compatible. I am also not sure you can change
>>>>> MPOL_MF_INTERNAL because somebody still might use the flag from
>>>>> userspace and we want to guarantee it will have the exact same semantic.
>>>> Since MPOL_MF_LAZY is never exported to userspace (Mel helped to confirm
>>>> this in the other thread), so I'm supposed it should be safe and backward
>>>> compatible to userspace.
>>> You didn't get my point. The flag is exported to the userspace and
>>> nothing in the syscall entry path checks and masks it. So we really have
>>> to preserve the semantic of the flag bit for ever.
>> Thanks, I see you point. Yes, it is exported to userspace in some sense
>> since it is in uapi header. But, it is never documented and MPOL_MF_VALID
>> excludes it. mbind() does check and mask it. It would return -EINVAL if
>> MPOL_MF_LAZY or any other undefined/invalid flag is set. See the below code
>> snippet from do_mbind():
>>
> That does not explain the motivation behind removing it or what we gain.
> Yes, it's undocumented and it's unlikely that anyone will. Any potential
> semantics are almost meaningless with mbind but there are two
> possibilities. One, mbind is relaxed to allow migration within allowed
> nodes and two, interleave could initially interleave but allow migration
> to local node to get a mix of average performance at init and local
> performance over time. No one tried taking that option so far but it
> appears harmless to leave it alone too.

Yes, actually this is what I argued, no one tried taking the flag for 
long time. I also agree it sounds harmless to leave it. I just thought 
it may be dead code, if so why not just remove it.

Thanks,
Yang

>

