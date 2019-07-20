Return-Path: <SRS0=8q5G=VR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4FECC76188
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 15:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99BFC2085A
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 15:04:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbfGTPES (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jul 2019 11:04:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49318 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbfGTPES (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jul 2019 11:04:18 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1588A3082E57;
        Sat, 20 Jul 2019 15:04:14 +0000 (UTC)
Received: from llong.remote.csb (ovpn-120-88.rdu2.redhat.com [10.10.120.88])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D5A8B1024719;
        Sat, 20 Jul 2019 15:04:10 +0000 (UTC)
Subject: Re: [PATCH v8 13/19] locking/rwsem: Make rwsem->owner an
 atomic_long_t
To:     Luis Henriques <lhenriques@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Borislav Petkov <bp@alien8.de>, Will Deacon <will.deacon@arm.com>,
        huang ying <huang.ying.caritas@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Jeff Layton <jlayton@kernel.org>
References: <20190520205918.22251-1-longman@redhat.com>
 <20190520205918.22251-14-longman@redhat.com>
 <20190719184538.GA20324@hermes.olymp>
 <2ed44afa-4528-a785-f188-2daf24343f97@redhat.com>
 <CAHk-=wioLqXBWWQywZGfxumsY_H6dFE3R=+WJ3mAL_WYV1fm9Q@mail.gmail.com>
 <87h87hksim.fsf@suse.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <81e82d5b-5074-77e8-7204-28479bbe0df0@redhat.com>
Date:   Sat, 20 Jul 2019 11:04:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <87h87hksim.fsf@suse.com>
Content-Type: multipart/mixed;
 boundary="------------7CE4E258FA1DECF46F49C77A"
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Sat, 20 Jul 2019 15:04:17 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------7CE4E258FA1DECF46F49C77A
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

On 7/20/19 4:41 AM, Luis Henriques wrote:
> "Linus Torvalds" <torvalds@linux-foundation.org> writes:
>
>> On Fri, Jul 19, 2019 at 12:32 PM Waiman Long <longman@redhat.com> wrote:
>>> This patch shouldn't change the behavior of the rwsem code. The code
>>> only access data within the rw_semaphore structures. I don't know why it
>>> will cause a KASAN error. I will have to reproduce it and figure out
>>> exactly which statement is doing the invalid access.
>> The stack traces should show line numbers if you run them through
>> scripts/decode_stacktrace.sh.
>>
>> You need to have debug info enabled for that, though.
>>
>> Luis?
>>
>>              Linus
> Yep, sure.  And I should have done this in the initial report.  It's a
> different trace, I had to recompile the kernel.
>
> (I'm also adding Jeff to the CC list.)
>
> Cheers,

Thanks for the information. I think I know where the problem is. Would
you mind applying the attached patch to see if it can fix the KASAN error.

Thanks,
Longman



--------------7CE4E258FA1DECF46F49C77A
Content-Type: text/x-patch;
 name="0001-locking-rwsem-Don-t-call-owner_on_cpu-on-read-owner.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-locking-rwsem-Don-t-call-owner_on_cpu-on-read-owner.pat";
 filename*1="ch"

From 445dc58add71f976c20359568d370f5059d30f77 Mon Sep 17 00:00:00 2001
From: Waiman Long <longman@redhat.com>
Date: Sat, 20 Jul 2019 10:45:39 -0400
Subject: [PATCH] locking/rwsem: Don't call owner_on_cpu() on read-owner

For writer, the owner value is cleared on unlock. For reader, it is
left intact on unlock for providing better debugging aid on crash dump
and the unlock of one reader may not mean the lock is free.

As a result, the owner_on_cpu() shouldn't be used on read-owner
as the task pointer value may not be valid and it might have
been freed. That is the case in rwsem_spin_on_owner(), but not in
rwsem_can_spin_on_owner(). This can lead to use-after-free error from
KASAN. For example,

  BUG: KASAN: use-after-free in rwsem_down_write_slowpath
  (/home/miguel/kernel/linux/kernel/locking/rwsem.c:669
  /home/miguel/kernel/linux/kernel/locking/rwsem.c:1125)

Fix this by checking for RWSEM_READER_OWNED flag before calling
owner_on_cpu().

Fixes: 94a9717b3c40e ("locking/rwsem: Make rwsem->owner an atomic_long_t")
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/rwsem.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 37524a47f002..bc91aacaab58 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -666,7 +666,11 @@ static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem,
 	preempt_disable();
 	rcu_read_lock();
 	owner = rwsem_owner_flags(sem, &flags);
-	if ((flags & nonspinnable) || (owner && !owner_on_cpu(owner)))
+	/*
+	 * Don't check the read-owner as the entry may be stale.
+	 */
+	if ((flags & nonspinnable) ||
+	    (owner && !(flags & RWSEM_READER_OWNED) && !owner_on_cpu(owner)))
 		ret = false;
 	rcu_read_unlock();
 	preempt_enable();
-- 
2.18.1


--------------7CE4E258FA1DECF46F49C77A--
