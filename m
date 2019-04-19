Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4569EC282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CFBE20693
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:22:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727571AbfDSTWv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:22:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37856 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725961AbfDSTWs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:22:48 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E1F83883BA;
        Fri, 19 Apr 2019 16:56:25 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-19.bos.redhat.com [10.18.17.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ABAB51001E95;
        Fri, 19 Apr 2019 16:56:22 +0000 (UTC)
Subject: Re: [PATCH v5 00/18] locking/rwsem: Rwsem rearchitecture part 2
From:   Waiman Long <longman@redhat.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>
References: <20190418234628.3675-1-longman@redhat.com>
 <8f1adff7-3bd4-7d35-1a0d-698662bfa2b8@redhat.com>
 <20190419075055.GA6795@gmail.com> <20190419124944.GA44010@gmail.com>
 <c06c9fd4-629a-3488-31ff-9f0f148364a4@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=longman@redhat.com; prefer-encrypt=mutual; keydata=
 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
 weim8xU=
Organization: Red Hat
Message-ID: <d1108b06-8274-14d2-bfdc-7062648148b9@redhat.com>
Date:   Fri, 19 Apr 2019 12:56:22 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <c06c9fd4-629a-3488-31ff-9f0f148364a4@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Fri, 19 Apr 2019 16:56:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/19/2019 11:00 AM, Waiman Long wrote:
> On 04/19/2019 08:49 AM, Ingo Molnar wrote:
>> * Ingo Molnar <mingo@kernel.org> wrote:
>>
>>> * Waiman Long <longman@redhat.com> wrote:
>>>
>>>> On 04/18/2019 07:46 PM, Waiman Long wrote:
>>>>>  v5:
>>>>>   - Drop v4 patch 1 as it is merged into tip's locking/core branch.
>>>>>   - Integrate the 2 followup patches into the series. The first
>>>>>     follow-up patch is broken into 2 pieces. The first piece comes in
>>>>>     before the "Enable readers spinning on writer" and the 2nd piece
>>>>>     is merged into the "Enable time-based spinning on reader-owned
>>>>>     rwsem" patch. The 2nd followup patch is added after that.
>>>>>   - Add a new patch to make all wake_up_q() calls after dropping
>>>>>     wait_lock as suggested by PeterZ.
>>>>>   - Incorporate numerouos suggestions by PeterZ and Davidlohr.
>>>> This patchset is still being reviewed by Peter . The purpose of this
>>>> series is mainly to sync up the version that Peter has and the ones that
>>>> I am working on incorporating his feedback. Further changes may still be
>>>> needed.
>>>>
>>>> I run an overall performance test on this new patchset and present the
>>>> data in this cover letter. However, I haven't run performance tests for
>>>> individual patches. So the performance data listed in some of the
>>>> patches may be stale.
>>> Just for those who'd like to follow the scope of changes, find below the 
>>> v4->v5 interdiff. v5 is now included in tip:WIP.locking/core, and also 
>>> merged into tip:master. (But not propagated towards linux-next yet.)
>> Hm, I'm experiencing early boot hangs with v5, on defconfig-ish x86-64 
>> kernels:
>>
>> [    0.153940] rcu: Hierarchical RCU implementation.
>> [    0.154289] rcu: 	RCU restricting CPUs from NR_CPUS=128 to nr_cpu_ids=17.
>> [    0.154829] rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
>> [    0.155390] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=17
>>
>>
>> I bisected it back to the v5 version of this patch:
>>
>>   2fd5f60fa4c3: locking/rwsem: Merge owner into count on x86-64
>>
>> I'm moving -tip back to -v4 meanwhile.
>>
>> Thanks,
>>
>> 	Ingo
> Sorry about that. Will look into that problem.
>
> -Longman
>
Yes, there is a bug in that patch. The following change should fix it:

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 19d8fbd50d17..857dff330f9b 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -198,9 +198,15 @@
 /*
  * Task structure pointer compression (64-bit only):
  * (owner - PAGE_OFFSET) >> (L1_CACHE_SHIFT - 2)
+ *
+ * However, init_task may lie outside of the linearly mapped physical
+ * to virtual memory range and so has to be handled separately.
  */
 static inline unsigned long rwsem_owner_count(struct task_struct *owner)
 {
+       if (unlikely(owner == &init_task))
+               return RWSEM_WRITER_MASK;
+
        return ((unsigned long)owner - PAGE_OFFSET) >> (L1_CACHE_SHIFT - 2);
 }

@@ -208,6 +214,9 @@ static inline unsigned long rwsem_count_owner(long
count)
 {
        unsigned long writer = (unsigned long)count & RWSEM_WRITER_MASK;

+       if (unlikely(writer == RWSEM_WRITER_MASK))
+               return (unsigned long)&init_task;
+
        return writer ? (writer << (L1_CACHE_SHIFT - 2)) + PAGE_OFFSET : 0;
 }

