Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00EDCC4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 14:38:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9CB4217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 14:38:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gdy6bBky"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbfI0OiO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 10:38:14 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41004 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbfI0OiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 10:38:13 -0400
Received: by mail-qt1-f196.google.com with SMTP id n1so7533793qtp.8
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 07:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jrHNI3Ce7FmUodhQRVtGcsJ0pLEFaGdjrMz0TSMeI14=;
        b=gdy6bBkyFWrJRqDzxuj+ffl+TWf+KxxDcRTg5xzkSVSYhacNEPDUFs7hf1Z7k9nbiP
         t1P4TsWUMzn64nL99YhMJ9SDZ3K7B4zfF2XYp2fG85Mhb9y7GkL8GRpW/d+iGxxBDX7t
         y9/mZU/5nGtaVppi4vtaQJ3OadRWElWKzFBcugEnQanr0QTUD9LrgRMawTuFFmglBhKd
         QVCmF9xDk7nwIW5Ifh9dSCQc/eg1uiSzeeQcOKt2UddDj1WWdhvg8KJFBTxfNkPDpd/R
         UGlMdJHd4yFmjvjUH9kLkKzC+5Xvmp5Jc4sj1aUiaGbd/zltG/tszxTLdbIgOGwQ5354
         mLRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jrHNI3Ce7FmUodhQRVtGcsJ0pLEFaGdjrMz0TSMeI14=;
        b=aImh6WUIANGwb/pO/kWDU1yIbCZO/rA5UkLhDQ0LUNxVNBqcrFEWrT9rbqSMYyepgO
         dvcUgGH0VlwR+WmHZ2sJECt82BBmyPR189wSu9GomgJiYbZ2fJ044BjEum0L1IBLb8GY
         1DHfmtFN/TbyTtoZW3jm0bVWuI2ceTIuZS8ntfClh6PUtnkFv2jiisdaR/C1ycSWWLn5
         BZSJP8j2Rok+UJd8tXdpVpqd3WiGcCrDmVQYHe3Nzg1Ww9r47MoMfwWSlpYccTt1aRTA
         X6dN/VuJ226IS1v4eJqeUbIRx7ON016ieVqv/GHt5wLQuZmNijIAgHEnhhCMWqsKM2hc
         11TQ==
X-Gm-Message-State: APjAAAWvWd+p/i0KwXYjZCw3Fr3pcrGdldANb5ImEoQwiOwuhxbHPD4m
        G5xv2iWnFhBq7rYIcWwLEgGoco4=
X-Google-Smtp-Source: APXvYqwwoge698F5Xxzui1cLXlPOYUFc3RNCieXrSeJ6XQEv0O7SxcSD9y+NxTVpeNlpmhRZtzCRDg==
X-Received: by 2002:ac8:1288:: with SMTP id y8mr10189488qti.243.1569595092630;
        Fri, 27 Sep 2019 07:38:12 -0700 (PDT)
Received: from gabell (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id 207sm1320331qkh.33.2019.09.27.07.38.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Sep 2019 07:38:12 -0700 (PDT)
Date:   Fri, 27 Sep 2019 10:38:02 -0400
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        Julien Grall <julien.grall@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] arm64/sve: Fix wrong free for task->thread.sve_state
Message-ID: <20190927143801.tpaohgbuzdheiwp3@gabell>
References: <20190926190846.3072-1-msys.mizuma@gmail.com>
 <20190926190846.3072-2-msys.mizuma@gmail.com>
 <20190927125228.GQ27757@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190927125228.GQ27757@arm.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Julien and Dave,

Thank you for your comments!
Dave's suggestion looks good for me, many thanks!
I'll post it as v2.

- Masa

On Fri, Sep 27, 2019 at 01:52:30PM +0100, Dave Martin wrote:
> On Thu, Sep 26, 2019 at 03:08:46PM -0400, Masayoshi Mizuma wrote:
> > From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> > 
> > The system which has SVE feature crashed because of
> > the memory pointed by task->thread.sve_state was destroyed
> > by someone.
> > 
> > That is because sve_state is freed while the forking the
> > child process. The child process has the pointer of sve_state
> > which is same as the parent's because the child's task_struct
> > is copied from the parent's one. If the copy_process()
> > fails as an error on somewhere, for example, copy_creds(),
> > then the sve_state is freed even if the parent is alive.
> > The flow is as follows.
> > 
> > copy_process
> >         p = dup_task_struct
> >             => arch_dup_task_struct
> >                 *dst = *src;  // copy the entire region.
> > :
> >         retval = copy_creds
> >         if (retval < 0)
> >                 goto bad_fork_free;
> > :
> > bad_fork_free:
> > ...
> >         delayed_free_task(p);
> >           => free_task
> >              => arch_release_task_struct
> >                 => fpsimd_release_task
> >                    => __sve_free
> >                       => kfree(task->thread.sve_state);
> >                          // free the parent's sve_state
> > 
> > Add a flag in task->thread which shows the fork is in progress.
> > If the fork is in progress, that means the child has the pointer
> > to the parent's sve_state, doesn't free the sve_state.
> > 
> > Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> > Reported-by: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
> > ---
> >  arch/arm64/include/asm/processor.h | 1 +
> >  arch/arm64/kernel/fpsimd.c         | 6 ++++--
> >  arch/arm64/kernel/process.c        | 2 ++
> >  3 files changed, 7 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
> > index 5623685c7d13..3ca3e350145a 100644
> > --- a/arch/arm64/include/asm/processor.h
> > +++ b/arch/arm64/include/asm/processor.h
> > @@ -143,6 +143,7 @@ struct thread_struct {
> >  	unsigned long		fault_address;	/* fault info */
> >  	unsigned long		fault_code;	/* ESR_EL1 value */
> >  	struct debug_info	debug;		/* debugging */
> > +	unsigned int		fork_in_progress;
> >  #ifdef CONFIG_ARM64_PTR_AUTH
> >  	struct ptrauth_keys	keys_user;
> >  #endif
> > diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
> > index 37d3912cfe06..8641db4cb062 100644
> > --- a/arch/arm64/kernel/fpsimd.c
> > +++ b/arch/arm64/kernel/fpsimd.c
> > @@ -202,8 +202,10 @@ static bool have_cpu_fpsimd_context(void)
> >   */
> >  static void __sve_free(struct task_struct *task)
> >  {
> > -	kfree(task->thread.sve_state);
> > -	task->thread.sve_state = NULL;
> > +	if (!task->thread.fork_in_progress) {
> > +		kfree(task->thread.sve_state);
> > +		task->thread.sve_state = NULL;
> > +	}
> >  }
> >  
> >  static void sve_free(struct task_struct *task)
> > diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> > index a47462def04b..8ac0ee4e5f76 100644
> > --- a/arch/arm64/kernel/process.c
> > +++ b/arch/arm64/kernel/process.c
> > @@ -347,6 +347,7 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
> >  	if (current->mm)
> >  		fpsimd_preserve_current_state();
> >  	*dst = *src;
> > +	dst->thread.fork_in_progress = 1;
> >  
> >  	return 0;
> >  }
> > @@ -365,6 +366,7 @@ int copy_thread(unsigned long clone_flags, unsigned long stack_start,
> >  	 * and disable discard SVE state for p:
> >  	 */
> >  	clear_tsk_thread_flag(p, TIF_SVE);
> > +	p->thread.fork_in_progress = 0;
> >  	p->thread.sve_state = NULL;
> 
> There's definitely a problem here, but a simpler fix is probably to
> NULL sve_state and clear TIF_SVE for dst at the same time.
> 
> Once upon a time, I had to cope with the thread_flags not being copied
> as part of task_struct here, which is one reason why the code is the
> (broken) way it is, but this is ancient history...
> 
> Commit c02433dd6de3 ("arm64: split thread_info from task stack") was
> merged in v4.10 and predates SVE support anyway.
> 
> 
> So can just do the following (untested) and delete the confusing
> comments?
> 
> Cheers
> ---Dave
> 
> --8<--
> 
> 
> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index f674f28..6937f59 100644
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
> @@ -352,13 +346,6 @@ int copy_thread(unsigned long clone_flags, unsigned long stack_start,
>  	memset(&p->thread.cpu_context, 0, sizeof(struct cpu_context));
>  
>  	/*
> -	 * Unalias p->thread.sve_state (if any) from the parent task
> -	 * and disable discard SVE state for p:
> -	 */
> -	clear_tsk_thread_flag(p, TIF_SVE);
> -	p->thread.sve_state = NULL;
> -
> -	/*
>  	 * In case p was allocated the same task_struct pointer as some
>  	 * other recently-exited task, make sure p is disassociated from
>  	 * any cpu that may have run that now-exited task recently.
