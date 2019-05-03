Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 806F3C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 15:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C2872075E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 15:26:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728046AbfECP0W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 11:26:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34282 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726267AbfECP0V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 11:26:21 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8AEC130C5833;
        Fri,  3 May 2019 15:26:21 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-85.bos.redhat.com [10.18.17.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 274B819C4F;
        Fri,  3 May 2019 15:26:20 +0000 (UTC)
Subject: Re: [PATCH-tip v7 12/20] locking/rwsem: Clarify usage of owner's
 nonspinaable bit
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>
References: <20190428212557.13482-1-longman@redhat.com>
 <20190428212557.13482-13-longman@redhat.com>
 <20190503152125.GH2623@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <c2e2ce9b-d04b-9f05-8fc6-11fa5b659b52@redhat.com>
Date:   Fri, 3 May 2019 11:26:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190503152125.GH2623@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Fri, 03 May 2019 15:26:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/3/19 11:21 AM, Peter Zijlstra wrote:
> On Sun, Apr 28, 2019 at 05:25:49PM -0400, Waiman Long wrote:
>> Bit 1 of sem->owner (RWSEM_ANONYMOUSLY_OWNED) is used to designate an
>> anonymous owner - readers or an anonymous writer. The setting of this
>> anonymous bit is used as an indicator that optimistic spinning cannot
>> be done on this rwsem.
>>
>> With the upcoming reader optimistic spinning patches, a reader-owned
>> rwsem can be spinned on for a limit period of time. We still need
>> this bit to indicate a rwsem is nonspinnable, but not setting this
>> bit loses its meaning that the owner is known. So rename the bit
>> to RWSEM_NONSPINNABLE to clarify its meaning.
>>
>> This patch also fixes a DEBUG_RWSEMS_WARN_ON() bug in __up_write().
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>  include/linux/rwsem.h  |  2 +-
>>  kernel/locking/rwsem.c | 43 +++++++++++++++++++++---------------------
>>  2 files changed, 22 insertions(+), 23 deletions(-)
>>
>> diff --git a/include/linux/rwsem.h b/include/linux/rwsem.h
>> index 148983e21d47..bb76e82398b2 100644
>> --- a/include/linux/rwsem.h
>> +++ b/include/linux/rwsem.h
>> @@ -50,7 +50,7 @@ struct rw_semaphore {
>>  };
>>  
>>  /*
>> - * Setting bit 1 of the owner field but not bit 0 will indicate
>> + * Setting all bits of the owner field except bit 0 will indicate
>>   * that the rwsem is writer-owned with an unknown owner.
>>   */
>>  #define RWSEM_OWNER_UNKNOWN	((struct task_struct *)-2L)
> As you know, I'm trying to kill that :-)

I am planning to remove it once your patch is merged.

Cheers,
Longman

