Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E697C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 04:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 283CB2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 04:22:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726008AbfE2EWG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 00:22:06 -0400
Received: from ozlabs.org ([203.11.71.1]:36779 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725856AbfE2EWF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 00:22:05 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45DHbm6RTRz9s4V;
        Wed, 29 May 2019 14:21:55 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Young Xiao <92siuyang@gmail.com>, linux@armlinux.org.uk,
        mark.rutland@arm.com, mingo@redhat.com, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org, kan.liang@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ravi.bangoria@linux.vnet.ibm.com
Subject: Re: [PATCH] perf: Fix oops when kthread execs user process
In-Reply-To: <20190528153224.GE20758@fuggles.cambridge.arm.com>
References: <1559046689-24091-1-git-send-email-92siuyang@gmail.com> <20190528140103.GT2623@hirez.programming.kicks-ass.net> <20190528153224.GE20758@fuggles.cambridge.arm.com>
Date:   Wed, 29 May 2019 14:21:54 +1000
Message-ID: <877ea9q49p.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Will Deacon <will.deacon@arm.com> writes:
> On Tue, May 28, 2019 at 04:01:03PM +0200, Peter Zijlstra wrote:
>> On Tue, May 28, 2019 at 08:31:29PM +0800, Young Xiao wrote:
>> > When a kthread calls call_usermodehelper() the steps are:
>> >   1. allocate current->mm
>> >   2. load_elf_binary()
>> >   3. populate current->thread.regs
>> > 
>> > While doing this, interrupts are not disabled. If there is a perf
>> > interrupt in the middle of this process (i.e. step 1 has completed
>> > but not yet reached to step 3) and if perf tries to read userspace
>> > regs, kernel oops.
>
> This seems to be because pt_regs(current) gives NULL for kthreads on Power.

Right, we've done that since roughly forever in copy_thread():

int copy_thread(unsigned long clone_flags, unsigned long usp,
		unsigned long kthread_arg, struct task_struct *p)
{
	...
	/* Copy registers */
	sp -= sizeof(struct pt_regs);
	childregs = (struct pt_regs *) sp;
	if (unlikely(p->flags & PF_KTHREAD)) {
		/* kernel thread */
		memset(childregs, 0, sizeof(struct pt_regs));
		childregs->gpr[1] = sp + sizeof(struct pt_regs);
                ...
		p->thread.regs = NULL;	/* no user register state */

See commit from 2002:
  https://github.com/mpe/linux-fullhistory/commit/c0a96c0918d21d8a99270e94d9c4a4a322d04581#diff-edb76bfcc84905163f34d24d2aad3f3aR187

> From the initial report [1], it doesn't look like the mm isn't initialised,
> but rather than we're dereferencing a NULL pt_regs pointer somehow for the
> current task (see previous comment). I don't see how that can happen on
> arm64, given that we put the pt_regs on the kernel stack which is allocated
> during fork.

We have the regs on the stack too (see above), but we're explicitly
NULL'ing the link from task->thread.

Looks like on arm64 and x86 there is no link from task->thread, instead
you get from task to pt_regs via task_stack_page().

That actually seems potentially fishy given the comment on
task_stack_page() about the stack going away for exiting tasks. We
should probably be NULL'ing the regs pointer in free_thread_stack() or
similar. Though that race mustn't be happening because other arches
would see it.

Or are we just wrong and kthreads should have non-NULL regs? I can't
find another arch that does the same as us.

cheers
