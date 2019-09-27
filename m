Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6716C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 16:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1D6F217D9
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 16:15:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbfI0QPk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 12:15:40 -0400
Received: from foss.arm.com ([217.140.110.172]:55990 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727079AbfI0QPj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 12:15:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 32B2A1000;
        Fri, 27 Sep 2019 09:15:39 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2F5BC3F534;
        Fri, 27 Sep 2019 09:15:38 -0700 (PDT)
Date:   Fri, 27 Sep 2019 17:15:36 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Masayoshi Mizuma <msys.mizuma@gmail.com>
Cc:     Julien Grall <julien.grall@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64/sve: Fix wrong free for task->thread.sve_state
Message-ID: <20190927161535.GS27757@arm.com>
References: <20190927153949.29870-1-msys.mizuma@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190927153949.29870-1-msys.mizuma@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 27, 2019 at 11:39:49AM -0400, Masayoshi Mizuma wrote:
> From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> 
> The system which has SVE feature crashed because of
> the memory pointed by task->thread.sve_state was destroyed
> by someone.
> 
> That is because sve_state is freed while the forking the
> child process. The child process has the pointer of sve_state
> which is same as the parent's because the child's task_struct
> is copied from the parent's one. If the copy_process()
> fails as an error on somewhere, for example, copy_creds(),
> then the sve_state is freed even if the parent is alive.
> The flow is as follows.
> 
> copy_process
>         p = dup_task_struct
>             => arch_dup_task_struct
>                 *dst = *src;  // copy the entire region.
> :
>         retval = copy_creds
>         if (retval < 0)
>                 goto bad_fork_free;
> :
> bad_fork_free:
> ...
>         delayed_free_task(p);
>           => free_task
>              => arch_release_task_struct
>                 => fpsimd_release_task
>                    => __sve_free
>                       => kfree(task->thread.sve_state);
>                          // free the parent's sve_state
> 
> Move child's sve_state = NULL and clearing TIF_SVE flag
> to arch_dup_task_struct() so that the child doesn't free the
> parent's one.

You could also add:

--8<--
There is no need to wait until copy_process() to clear TIF_SVE for
dst, becuase the thread flags for dst are initialized already by
copying the src task_struct.

This change simplifies the code, so get rid of comments that are no
longer needed.
-->8--

> 
> Cc: stable@vger.kernel.org

Since SVE only exists from v4.15, it may be helpful to specify that,
i.e., replace that Cc line with:

Cc: <stable@vger.kernel.org> # 4.15.x-


Otherwise, I'm happy to see this applied, but I'd like somebody to
confirm that this change definitely fixes the bug.

Cheers
---Dave

[...]

> Fixes: bc0ee4760364 ("arm64/sve: Core task context handling")
> Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> Reported-by: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
> Suggested-by: Dave Martin <Dave.Martin@arm.com>
> ---
>  arch/arm64/kernel/process.c | 21 ++++-----------------
>  1 file changed, 4 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index f674f28df..6937f5935 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -323,22 +323,16 @@ void arch_release_task_struct(struct task_struct *tsk)
>  	fpsimd_release_task(tsk);
>  }
>  
> -/*
> - * src and dst may temporarily have aliased sve_state after task_struct
> - * is copied.  We cannot fix this properly here, because src may have
> - * live SVE state and dst's thread_info may not exist yet, so tweaking
> - * either src's or dst's TIF_SVE is not safe.
> - *
> - * The unaliasing is done in copy_thread() instead.  This works because
> - * dst is not schedulable or traceable until both of these functions
> - * have been called.
> - */
>  int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
>  {
>  	if (current->mm)
>  		fpsimd_preserve_current_state();
>  	*dst = *src;
>  
> +	BUILD_BUG_ON(!IS_ENABLED(CONFIG_THREAD_INFO_IN_TASK));
> +	dst->thread.sve_state = NULL;
> +	clear_tsk_thread_flag(dst, TIF_SVE);
> +
>  	return 0;
>  }
>  
> @@ -351,13 +345,6 @@ int copy_thread(unsigned long clone_flags, unsigned long stack_start,
>  
>  	memset(&p->thread.cpu_context, 0, sizeof(struct cpu_context));
>  
> -	/*
> -	 * Unalias p->thread.sve_state (if any) from the parent task
> -	 * and disable discard SVE state for p:
> -	 */
> -	clear_tsk_thread_flag(p, TIF_SVE);
> -	p->thread.sve_state = NULL;
> -
>  	/*
>  	 * In case p was allocated the same task_struct pointer as some
>  	 * other recently-exited task, make sure p is disassociated from
> -- 
> 2.18.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
