Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B65D6C32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 13:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A6B52086A
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 13:02:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731044AbfI3NCu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 09:02:50 -0400
Received: from foss.arm.com ([217.140.110.172]:53784 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730830AbfI3NCu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 09:02:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8E9751000;
        Mon, 30 Sep 2019 06:02:49 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8C1FF3F706;
        Mon, 30 Sep 2019 06:02:48 -0700 (PDT)
Date:   Mon, 30 Sep 2019 14:02:46 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Julien Grall <julien.grall@arm.com>
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64/sve: Fix wrong free for task->thread.sve_state
Message-ID: <20190930130244.GT27757@arm.com>
References: <20190927153949.29870-1-msys.mizuma@gmail.com>
 <b3dba44e-216c-f060-be8e-1c44bdc61576@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3dba44e-216c-f060-be8e-1c44bdc61576@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 30, 2019 at 01:23:18PM +0100, Julien Grall wrote:
> Hi,
> 
> On 27/09/2019 16:39, Masayoshi Mizuma wrote:
> >From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> >
> >The system which has SVE feature crashed because of
> >the memory pointed by task->thread.sve_state was destroyed
> >by someone.
> >
> >That is because sve_state is freed while the forking the
> >child process. The child process has the pointer of sve_state
> >which is same as the parent's because the child's task_struct
> >is copied from the parent's one. If the copy_process()
> >fails as an error on somewhere, for example, copy_creds(),
> >then the sve_state is freed even if the parent is alive.
> >The flow is as follows.
> >
> >copy_process
> >         p = dup_task_struct
> >             => arch_dup_task_struct
> >                 *dst = *src;  // copy the entire region.
> >:
> >         retval = copy_creds
> >         if (retval < 0)
> >                 goto bad_fork_free;
> >:
> >bad_fork_free:
> >...
> >         delayed_free_task(p);
> >           => free_task
> >              => arch_release_task_struct
> >                 => fpsimd_release_task
> >                    => __sve_free
> >                       => kfree(task->thread.sve_state);
> >                          // free the parent's sve_state
> >
> >Move child's sve_state = NULL and clearing TIF_SVE flag
> >to arch_dup_task_struct() so that the child doesn't free the
> >parent's one.
> >
> >Cc: stable@vger.kernel.org
> >Fixes: bc0ee4760364 ("arm64/sve: Core task context handling")
> 
> Looking at the log, it looks like THREAD_INFO_IN_TASK was selected before
> the bc0ee4760364. So it should be fine to backport for all the Linux tree
> contain this commit.
> 
> >Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> >Reported-by: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
> >Suggested-by: Dave Martin <Dave.Martin@arm.com>
> 
> I have tested the patch and can confirm that double-free disappeared after
> the patch is applied:
> 
> Tested-by: Julien Grall <julien.grall@arm.com>

Good to have that confirmed -- thanks for verifying.

[...]

> >---
> >  arch/arm64/kernel/process.c | 21 ++++-----------------
> >  1 file changed, 4 insertions(+), 17 deletions(-)
> >
> >diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> >index f674f28df..6937f5935 100644
> >--- a/arch/arm64/kernel/process.c
> >+++ b/arch/arm64/kernel/process.c
> >@@ -323,22 +323,16 @@ void arch_release_task_struct(struct task_struct *tsk)
> >  	fpsimd_release_task(tsk);
> >  }
> >-/*
> >- * src and dst may temporarily have aliased sve_state after task_struct
> >- * is copied.  We cannot fix this properly here, because src may have
> >- * live SVE state and dst's thread_info may not exist yet, so tweaking
> >- * either src's or dst's TIF_SVE is not safe.
> >- *
> >- * The unaliasing is done in copy_thread() instead.  This works because
> >- * dst is not schedulable or traceable until both of these functions
> >- * have been called.
> >- */
> 
> It would be good to explain in the commit message why tweaking "dst" in
> arch_dup_task_struct() is fine.
> 
> From my understanding, Arm64 used to have thread_info on the stack. So it
> would not be possible to clear TIF_SVE until the stack is initialized.
> 
> Now that the thread_info is part of the task, it should be valid to modify
> the flag from arch_dup_task_struct().
> 
> Note that technically, TIF_SVE does not need to be cleared from
> arch_dup_task_struct(). It could also be done from copy_thread(). But it is
> easier to keep the both changes together.
> 
> >  int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
> >  {
> >  	if (current->mm)
> >  		fpsimd_preserve_current_state();
> >  	*dst = *src;

Ack, some more explanation would be a good idea here.

Maybe the following comments are sufficient?

	/* We rely on the above assingment to initialise dst's thread_flags: */

> >+	BUILD_BUG_ON(!IS_ENABLED(CONFIG_THREAD_INFO_IN_TASK));
> 

and

	/*
	 * Detach src's sve_state (if any) from dst so that it does not
	 * get erroneously used or freed prematurely.  dst's sve_state
	 * will be allocated on demand later on if dst uses SVE.
	 * For consistency, also clear TIF_SVE here: this could be done
	 * later in copy_process(), but to avoid tripping up future
	 * maintainers it is best not to leave TIF_SVE and sve_state in
	 * an inconsistent state, even temporarily.
	 */

> >+	dst->thread.sve_state = NULL;
> >+	clear_tsk_thread_flag(dst, TIF_SVE);

(TIF_SVE should not usually be set in the first place of course, since
we are in a fork() or clone() syscall in src.  This may not be true if
a task is created using kernel_thread() while running in the context of
some user task that entered the kernel due to a trap or syscall --
though probably nobody should be doing that.)

[...]

Cheers
---DavE
