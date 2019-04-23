Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88327C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 19:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 545C721773
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 19:56:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="I8KW9sB4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfDWT4V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 15:56:21 -0400
Received: from merlin.infradead.org ([205.233.59.134]:54160 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbfDWT4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 15:56:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=uBJlpdTHp6Z4y9fxNWwd3vt4kb8Y+n8p3Is+SZyxL1M=; b=I8KW9sB4KOwxZRtkHQ1cntwdC
        90k82dAwZZt3KWtXa69CvKctECv1xKXqRuz4JCk4zntMv5q0iYkZ9dfEvNwlg2diyuNV+1Vtrib/f
        um6HAr5kWPy04/WSK6GOirByatKHryStedDxe8Ze/0jXapufmq/ew96BUTiAzZUdOrRkNMh5ne+vu
        6NHlGVODDpCn6Vu3QgZ4O1bLgb/YDwqJEi3l2y+az4MME7wG6+VTTOzBsLTtgEiKyFAiUM4k97Muf
        MGLXPGdPJfrdJLYznNgJ28UkMmD58e/CIuen7tYpNKZJGwTDjkq1EsmHzDOd+i2Ad71eSUA8Injtn
        JR/AzUFVw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJ1WK-0000xY-NS; Tue, 23 Apr 2019 19:56:00 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 53BAE29C30E0A; Tue, 23 Apr 2019 21:55:59 +0200 (CEST)
Date:   Tue, 23 Apr 2019 21:55:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH] bpf: Fix preempt_enable_no_resched() abuse
Message-ID: <20190423195559.GY4038@hirez.programming.kicks-ass.net>
References: <20190419120207.GO4038@hirez.programming.kicks-ass.net>
 <20190419130304.GV14281@hirez.programming.kicks-ass.net>
 <20190419131522.GW14281@hirez.programming.kicks-ass.net>
 <57620139-92a3-4a21-56bd-5d6fff23214f@redhat.com>
 <7b1bfc26-6e90-bd65-ab46-08413acd80e9@redhat.com>
 <20190423141714.GO11158@hirez.programming.kicks-ass.net>
 <CAHk-=whnQJ9YDrkcKteNSACMJxzw1bL0RPfGQsey_9Nm7b8mnw@mail.gmail.com>
 <4f62d7f2-e5f6-500e-3e70-b1d1978f7140@redhat.com>
 <20190423193435.GX4038@hirez.programming.kicks-ass.net>
 <88ba7be0-9ec5-941e-1b3f-80fbe05fe3a0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88ba7be0-9ec5-941e-1b3f-80fbe05fe3a0@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 03:41:32PM -0400, Waiman Long wrote:
> On 4/23/19 3:34 PM, Peter Zijlstra wrote:
> > On Tue, Apr 23, 2019 at 03:12:16PM -0400, Waiman Long wrote:

> >> You are right on that. However, there is a variant called
> >> preempt_enable_no_resched() that doesn't have this side effect. So I am
> >> going to use that one instead.
> > Only if the very next line is schedule(). Otherwise you're very much not
> > going to use that function.
> 
> May I know the reason why. 

Because it can 'consume' a need_resched and introduces arbitrary delays
before the schedule() eventually happens, breaking the very notion of
PREEMPT=y (and the fundamentals RT relies on).

> I saw a number of instances of
> preempt_enable_no_resched() without right next a schedule().

Look more closely.. and let me know, if true, those are bugs that need
fixing.

Argghhh.. BPF...

Also, with the recent RCU rework, we can probably drop that
rcu_read_lock()/rcu_read_unlock() from there if we're disabling
preemption anyway.

---
Subject: bpf: Fix preempt_enable_no_resched() abuse

Unless the very next line is schedule(), or implies it, one must not use
preempt_enable_no_resched(). It can cause a preemption to go missing and
thereby cause arbitrary delays, breaking the PREEMPT=y invariant.

Cc: Roman Gushchin <guro@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index f02367faa58d..944ccc310201 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -510,7 +510,7 @@ int bpf_prog_array_copy(struct bpf_prog_array __rcu *old_array,
 		}					\
 _out:							\
 		rcu_read_unlock();			\
-		preempt_enable_no_resched();		\
+		preempt_enable();			\
 		_ret;					\
 	 })
 
