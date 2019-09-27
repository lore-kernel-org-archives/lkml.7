Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C43DFC4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 11:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E1A5217F4
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 11:04:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfI0LEk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 07:04:40 -0400
Received: from foss.arm.com ([217.140.110.172]:49192 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725882AbfI0LEk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 07:04:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9EA0928;
        Fri, 27 Sep 2019 04:04:39 -0700 (PDT)
Received: from [10.1.196.50] (e108454-lin.cambridge.arm.com [10.1.196.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AFD8C3F67D;
        Fri, 27 Sep 2019 04:04:38 -0700 (PDT)
Subject: Re: [PATCH 1/1] arm64/sve: Fix wrong free for task->thread.sve_state
To:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org, Dave P Martin <Dave.Martin@arm.com>
References: <20190926190846.3072-1-msys.mizuma@gmail.com>
 <20190926190846.3072-2-msys.mizuma@gmail.com>
From:   Julien Grall <julien.grall@arm.com>
Message-ID: <32b59c08-cc59-60d6-16c7-ffb5582c2901@arm.com>
Date:   Fri, 27 Sep 2019 12:04:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190926190846.3072-2-msys.mizuma@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(+ Dave)

Hi,

Thank you for the patch.

On 26/09/2019 20:08, Masayoshi Mizuma wrote:
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
>          p = dup_task_struct
>              => arch_dup_task_struct
>                  *dst = *src;  // copy the entire region.
> :
>          retval = copy_creds
>          if (retval < 0)
>                  goto bad_fork_free;
> :
> bad_fork_free:
> ...
>          delayed_free_task(p);
>            => free_task
>               => arch_release_task_struct
>                  => fpsimd_release_task
>                     => __sve_free
>                        => kfree(task->thread.sve_state);
>                           // free the parent's sve_state

The flow makes sense to me and I agree you would end up to free the parent's state.

> 
> Add a flag in task->thread which shows the fork is in progress.
> If the fork is in progress, that means the child has the pointer
> to the parent's sve_state, doesn't free the sve_state.

I haven't fully investigate it yet but I was wondering if we could just clear 
task->thread.sve_state for the child in arch_dup_task_struct().

I saw the comment on top of function mentioning potential issue to do it there. 
I understand that you may not be able to clear TIF_SVE in the function, but I 
don't understand why clearing just task->thread.sve_state would be an issue.

The only risk I can see is TIF_SVE may be set with task->thread.sve_state to be 
NULL. But this is a new task, so I don't think there are risk here to have it 
unsync. Dave?

> 
> Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> Reported-by: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
> ---
>   arch/arm64/include/asm/processor.h | 1 +
>   arch/arm64/kernel/fpsimd.c         | 6 ++++--
>   arch/arm64/kernel/process.c        | 2 ++
>   3 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
> index 5623685c7d13..3ca3e350145a 100644
> --- a/arch/arm64/include/asm/processor.h
> +++ b/arch/arm64/include/asm/processor.h
> @@ -143,6 +143,7 @@ struct thread_struct {
>   	unsigned long		fault_address;	/* fault info */
>   	unsigned long		fault_code;	/* ESR_EL1 value */
>   	struct debug_info	debug;		/* debugging */
> +	unsigned int		fork_in_progress;
>   #ifdef CONFIG_ARM64_PTR_AUTH
>   	struct ptrauth_keys	keys_user;
>   #endif
> diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
> index 37d3912cfe06..8641db4cb062 100644
> --- a/arch/arm64/kernel/fpsimd.c
> +++ b/arch/arm64/kernel/fpsimd.c
> @@ -202,8 +202,10 @@ static bool have_cpu_fpsimd_context(void)
>    */
>   static void __sve_free(struct task_struct *task)
>   {
> -	kfree(task->thread.sve_state);
> -	task->thread.sve_state = NULL;
> +	if (!task->thread.fork_in_progress) {
> +		kfree(task->thread.sve_state);
> +		task->thread.sve_state = NULL;
> +	}
>   }
>   
>   static void sve_free(struct task_struct *task)
> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index a47462def04b..8ac0ee4e5f76 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -347,6 +347,7 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
>   	if (current->mm)
>   		fpsimd_preserve_current_state();
>   	*dst = *src;
> +	dst->thread.fork_in_progress = 1;
>   
>   	return 0;
>   }
> @@ -365,6 +366,7 @@ int copy_thread(unsigned long clone_flags, unsigned long stack_start,
>   	 * and disable discard SVE state for p:
>   	 */
>   	clear_tsk_thread_flag(p, TIF_SVE);
> +	p->thread.fork_in_progress = 0;
>   	p->thread.sve_state = NULL;
>   
>   	/*
> 

Cheers,

-- 
Julien Grall
