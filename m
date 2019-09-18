Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A3AC4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 08:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85C9220882
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 08:03:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729272AbfIRIC7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 04:02:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51148 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728338AbfIRIC7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 04:02:59 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D593230B2502;
        Wed, 18 Sep 2019 08:02:58 +0000 (UTC)
Received: from [10.72.12.58] (ovpn-12-58.pek2.redhat.com [10.72.12.58])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F3201600C8;
        Wed, 18 Sep 2019 08:02:56 +0000 (UTC)
Subject: Re: [RFC PATCH] memalloc_noio: update the comment to make it cleaner
To:     Michal Hocko <mhocko@kernel.org>
Cc:     mingo@redhat.com, peterz@infradead.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20190917232820.23504-1-xiubli@redhat.com>
 <20190918072542.GC12770@dhcp22.suse.cz>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <315246db-ec28-f5e0-e9b3-eba0cb60b796@redhat.com>
Date:   Wed, 18 Sep 2019 16:02:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190918072542.GC12770@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Wed, 18 Sep 2019 08:02:58 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/9/18 15:25, Michal Hocko wrote:
> On Wed 18-09-19 04:58:20, xiubli@redhat.com wrote:
>> From: Xiubo Li <xiubli@redhat.com>
>>
>> The GFP_NOIO means all further allocations will implicitly drop
>> both __GFP_IO and __GFP_FS flags and so they are safe for both the
>> IO critical section and the the critical section from the allocation
>> recursion point of view. Not only the __GFP_IO, which a bit confusing
>> when reading the code or using the save/restore pair.
> Historically GFP_NOIO has always implied GFP_NOFS as well. I can imagine
> that this might come as an surprise for somebody not familiar with the
> code though.

Yeah, it true.

>   I am wondering whether your update of the documentation
> would be better off at __GFP_FS, __GFP_IO resp. GFP_NOFS, GFP_NOIO level.
> This interface is simply a way to set a scoped NO{IO,FS} context.

The "Documentation/core-api/gfp_mask-from-fs-io.rst" is already very 
detail about them all.

This fixing just means to make sure that it won't surprise someone who 
is having a quickly through some code and not familiar much about the 
detail. It may make not much sense ?

Thanks,
BRs
Xiubo


>> Signed-off-by: Xiubo Li <xiubli@redhat.com>
>> ---
>>   include/linux/sched/mm.h | 9 +++++----
>>   1 file changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
>> index 4a7944078cc3..9bdc97e52de1 100644
>> --- a/include/linux/sched/mm.h
>> +++ b/include/linux/sched/mm.h
>> @@ -211,10 +211,11 @@ static inline void fs_reclaim_release(gfp_t gfp_mask) { }
>>    * memalloc_noio_save - Marks implicit GFP_NOIO allocation scope.
>>    *
>>    * This functions marks the beginning of the GFP_NOIO allocation scope.
>> - * All further allocations will implicitly drop __GFP_IO flag and so
>> - * they are safe for the IO critical section from the allocation recursion
>> - * point of view. Use memalloc_noio_restore to end the scope with flags
>> - * returned by this function.
>> + * All further allocations will implicitly drop __GFP_IO and __GFP_FS
>> + * flags and so they are safe for both the IO critical section and the
>> + * the critical section from the allocation recursion point of view. Use
>> + * memalloc_noio_restore to end the scope with flags returned by this
>> + * function.
>>    *
>>    * This function is safe to be used from any context.
>>    */
>> -- 
>> 2.21.0


