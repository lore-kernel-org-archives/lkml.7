Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A7FAC04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 11:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 499AC216B7
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 11:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558438519;
	bh=7zMYKn/lb7TH7Qbcaw1G29BPEn68iQbSw/cn+PKfdZ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=N7G/KM9ZgGEDixKPxCMqbKkZ5t339Snz587uVEDdzt9dvfDUJZkbsk13oLIhkx1tR
	 acbdwAafkszWqGAobPeKE2hoXwyZTJOnMql2gnC52x5Esgwp8TnKeW4OKy+vZZ5LIP
	 5odYfUlUVBHzK4JCC6Lxhlsh3rS55qNaiyjWczGs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728017AbfEULfS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 07:35:18 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46496 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbfEULfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 07:35:18 -0400
Received: by mail-pg1-f194.google.com with SMTP id t187so8439677pgb.13
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 04:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=y2h8yY1nmbpXT69GC2+fAFJNTD2F5yTSQK2OB0WJFdg=;
        b=P/+Rf3vLEFCJ9GGi+UiBExXqhQ3XV3vz+RT46PUaPANKnXWspoI2jdiOm0eB/SDebN
         4SUg/3Z34WR+B+7LZbwJuvsWjT+i/FtsP+sywXUHxaBysgBjhHDwScpwj1/76Q9STasn
         xM67JkPb+0lckKUhz+xmSVpFCLtyitFjkkxqmT7T+OkFHvHB1ETmf7RG/Mf2fSvQOwXQ
         CUHTODx09k3UpEoSbhweZR4LuuW4LQY3KAziJqwr1S5EFqhB4eaXWb/RlJTCj4b+4lZ8
         aG5V/xKICRseiGomI7b9+g+yKS7gaqgHnnNmBYkXP+oS2aRWuCbuAAVQ/3TYZw+3YJKa
         P5yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=y2h8yY1nmbpXT69GC2+fAFJNTD2F5yTSQK2OB0WJFdg=;
        b=FqeFPgZAeCuD3gA7curkws4qk9EpPtFCh+QJEYAQbB4F7OMSrCGXBWnc8OZeq/tPmV
         Bk4JvrKu2ZOwhdxIADcUFBOcODnAujqnz4Zk5Z9eQEvUlZcMl3PWgoCq9q4ACowE/SyV
         BUNfBYq25vm43CoX+NfkIlAyRmjffdWPOT/4JFwxS5s/1WJzNDi4t5gPyXqcJYWk570P
         SLZwuj+pE7wDeHSIdDYG4z3jp0hGUNAI0SsxlOgrfPG1uTOtNbCMqyVE1zD+SEksH4Fi
         MjFXgFOInuE+SqKfMLRaPXjmaa4FcQMLEQfouh7Ikh+GvEIsY7MiG4UepSwcHwNPIxgl
         WSZA==
X-Gm-Message-State: APjAAAX5X6LfbmmDah4syYQSuRrfT8p9Fkm4wfs5Ogjyn3FE8Kw1KuNy
        vMrv8ts+9mCo4GoznSCU4KA=
X-Google-Smtp-Source: APXvYqyxR8EXt9zlV0d3tT3FEX90fHbIHPdhfJMjAqfANtUmS54/DDpKsjUgcdyor60Y9SM0FlNK0A==
X-Received: by 2002:a63:18e:: with SMTP id 136mr52432280pgb.277.1558438517231;
        Tue, 21 May 2019 04:35:17 -0700 (PDT)
Received: from google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id a8sm11389752pfk.14.2019.05.21.04.35.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 21 May 2019 04:35:16 -0700 (PDT)
Date:   Tue, 21 May 2019 20:35:10 +0900
From:   Minchan Kim <minchan@kernel.org>
To:     Christian Brauner <christian@brauner.io>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Colascione <dancol@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>, jannh@google.com,
        oleg@redhat.com
Subject: Re: [RFC 5/7] mm: introduce external memory hinting API
Message-ID: <20190521113510.GI219653@google.com>
References: <20190520035254.57579-1-minchan@kernel.org>
 <20190520035254.57579-6-minchan@kernel.org>
 <20190521090058.mdx4qecmdbum45t2@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521090058.mdx4qecmdbum45t2@brauner.io>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 11:01:01AM +0200, Christian Brauner wrote:
> Cc: Jann and Oleg too
> 
> On Mon, May 20, 2019 at 12:52:52PM +0900, Minchan Kim wrote:
> > There is some usecase that centralized userspace daemon want to give
> > a memory hint like MADV_[COOL|COLD] to other process. Android's
> > ActivityManagerService is one of them.
> > 
> > It's similar in spirit to madvise(MADV_WONTNEED), but the information
> > required to make the reclaim decision is not known to the app. Instead,
> > it is known to the centralized userspace daemon(ActivityManagerService),
> > and that daemon must be able to initiate reclaim on its own without
> > any app involvement.
> > 
> > To solve the issue, this patch introduces new syscall process_madvise(2)
> > which works based on pidfd so it could give a hint to the exeternal
> > process.
> > 
> > int process_madvise(int pidfd, void *addr, size_t length, int advise);
> > 
> > All advises madvise provides can be supported in process_madvise, too.
> > Since it could affect other process's address range, only privileged
> > process(CAP_SYS_PTRACE) or something else(e.g., being the same UID)
> > gives it the right to ptrrace the process could use it successfully.
> > 
> > Please suggest better idea if you have other idea about the permission.
> > 
> > * from v1r1
> >   * use ptrace capability - surenb, dancol
> > 
> > Signed-off-by: Minchan Kim <minchan@kernel.org>
> > ---
> >  arch/x86/entry/syscalls/syscall_32.tbl |  1 +
> >  arch/x86/entry/syscalls/syscall_64.tbl |  1 +
> >  include/linux/proc_fs.h                |  1 +
> >  include/linux/syscalls.h               |  2 ++
> >  include/uapi/asm-generic/unistd.h      |  2 ++
> >  kernel/signal.c                        |  2 +-
> >  kernel/sys_ni.c                        |  1 +
> >  mm/madvise.c                           | 45 ++++++++++++++++++++++++++
> >  8 files changed, 54 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
> > index 4cd5f982b1e5..5b9dd55d6b57 100644
> > --- a/arch/x86/entry/syscalls/syscall_32.tbl
> > +++ b/arch/x86/entry/syscalls/syscall_32.tbl
> > @@ -438,3 +438,4 @@
> >  425	i386	io_uring_setup		sys_io_uring_setup		__ia32_sys_io_uring_setup
> >  426	i386	io_uring_enter		sys_io_uring_enter		__ia32_sys_io_uring_enter
> >  427	i386	io_uring_register	sys_io_uring_register		__ia32_sys_io_uring_register
> > +428	i386	process_madvise		sys_process_madvise		__ia32_sys_process_madvise
> > diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
> > index 64ca0d06259a..0e5ee78161c9 100644
> > --- a/arch/x86/entry/syscalls/syscall_64.tbl
> > +++ b/arch/x86/entry/syscalls/syscall_64.tbl
> > @@ -355,6 +355,7 @@
> >  425	common	io_uring_setup		__x64_sys_io_uring_setup
> >  426	common	io_uring_enter		__x64_sys_io_uring_enter
> >  427	common	io_uring_register	__x64_sys_io_uring_register
> > +428	common	process_madvise		__x64_sys_process_madvise
> >  
> >  #
> >  # x32-specific system call numbers start at 512 to avoid cache impact
> > diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h
> > index 52a283ba0465..f8545d7c5218 100644
> > --- a/include/linux/proc_fs.h
> > +++ b/include/linux/proc_fs.h
> > @@ -122,6 +122,7 @@ static inline struct pid *tgid_pidfd_to_pid(const struct file *file)
> >  
> >  #endif /* CONFIG_PROC_FS */
> >  
> > +extern struct pid *pidfd_to_pid(const struct file *file);
> >  struct net;
> >  
> >  static inline struct proc_dir_entry *proc_net_mkdir(
> > diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> > index e2870fe1be5b..21c6c9a62006 100644
> > --- a/include/linux/syscalls.h
> > +++ b/include/linux/syscalls.h
> > @@ -872,6 +872,8 @@ asmlinkage long sys_munlockall(void);
> >  asmlinkage long sys_mincore(unsigned long start, size_t len,
> >  				unsigned char __user * vec);
> >  asmlinkage long sys_madvise(unsigned long start, size_t len, int behavior);
> > +asmlinkage long sys_process_madvise(int pid_fd, unsigned long start,
> > +				size_t len, int behavior);
> >  asmlinkage long sys_remap_file_pages(unsigned long start, unsigned long size,
> >  			unsigned long prot, unsigned long pgoff,
> >  			unsigned long flags);
> > diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
> > index dee7292e1df6..7ee82ce04620 100644
> > --- a/include/uapi/asm-generic/unistd.h
> > +++ b/include/uapi/asm-generic/unistd.h
> > @@ -832,6 +832,8 @@ __SYSCALL(__NR_io_uring_setup, sys_io_uring_setup)
> >  __SYSCALL(__NR_io_uring_enter, sys_io_uring_enter)
> >  #define __NR_io_uring_register 427
> >  __SYSCALL(__NR_io_uring_register, sys_io_uring_register)
> > +#define __NR_process_madvise 428
> > +__SYSCALL(__NR_process_madvise, sys_process_madvise)
> >  
> >  #undef __NR_syscalls
> >  #define __NR_syscalls 428
> > diff --git a/kernel/signal.c b/kernel/signal.c
> > index 1c86b78a7597..04e75daab1f8 100644
> > --- a/kernel/signal.c
> > +++ b/kernel/signal.c
> > @@ -3620,7 +3620,7 @@ static int copy_siginfo_from_user_any(kernel_siginfo_t *kinfo, siginfo_t *info)
> >  	return copy_siginfo_from_user(kinfo, info);
> >  }
> >  
> > -static struct pid *pidfd_to_pid(const struct file *file)
> > +struct pid *pidfd_to_pid(const struct file *file)
> >  {
> >  	if (file->f_op == &pidfd_fops)
> >  		return file->private_data;
> > diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
> > index 4d9ae5ea6caf..5277421795ab 100644
> > --- a/kernel/sys_ni.c
> > +++ b/kernel/sys_ni.c
> > @@ -278,6 +278,7 @@ COND_SYSCALL(mlockall);
> >  COND_SYSCALL(munlockall);
> >  COND_SYSCALL(mincore);
> >  COND_SYSCALL(madvise);
> > +COND_SYSCALL(process_madvise);
> >  COND_SYSCALL(remap_file_pages);
> >  COND_SYSCALL(mbind);
> >  COND_SYSCALL_COMPAT(mbind);
> > diff --git a/mm/madvise.c b/mm/madvise.c
> > index 119e82e1f065..af02aa17e5c1 100644
> > --- a/mm/madvise.c
> > +++ b/mm/madvise.c
> > @@ -9,6 +9,7 @@
> >  #include <linux/mman.h>
> >  #include <linux/pagemap.h>
> >  #include <linux/page_idle.h>
> > +#include <linux/proc_fs.h>
> >  #include <linux/syscalls.h>
> >  #include <linux/mempolicy.h>
> >  #include <linux/page-isolation.h>
> > @@ -16,6 +17,7 @@
> >  #include <linux/hugetlb.h>
> >  #include <linux/falloc.h>
> >  #include <linux/sched.h>
> > +#include <linux/sched/mm.h>
> >  #include <linux/ksm.h>
> >  #include <linux/fs.h>
> >  #include <linux/file.h>
> > @@ -1140,3 +1142,46 @@ SYSCALL_DEFINE3(madvise, unsigned long, start, size_t, len_in, int, behavior)
> >  {
> >  	return madvise_core(current, start, len_in, behavior);
> >  }
> > +
> > +SYSCALL_DEFINE4(process_madvise, int, pidfd, unsigned long, start,
> > +		size_t, len_in, int, behavior)
> > +{
> > +	int ret;
> > +	struct fd f;
> > +	struct pid *pid;
> > +	struct task_struct *tsk;
> > +	struct mm_struct *mm;
> > +
> > +	f = fdget(pidfd);
> > +	if (!f.file)
> > +		return -EBADF;
> > +
> > +	pid = pidfd_to_pid(f.file);
> 
> pidfd_to_pid() should not be directly exported since this allows
> /proc/<pid> fds to be used too. That's something we won't be going
> forward with. All new syscalls should only allow to operate on pidfds
> created through CLONE_PIDFD or pidfd_open() (cf. [1]).

Thanks for the information.

> 
> So e.g. please export a simple helper like
> 
> struct pid *pidfd_to_pid(const struct file *file)
> {
>         if (file->f_op == &pidfd_fops)
>                 return file->private_data;
> 
>         return NULL;
> }
> 
> turning the old pidfd_to_pid() into something like:
> 
> static struct pid *__fd_to_pid(const struct file *file)
> {
>         struct pid *pid;
> 
>         pid = pidfd_to_pid(file);
>         if (pid)
>                 return pid;
> 
>         return tgid_pidfd_to_pid(file);
> }

So, I want to clarify what you suggest here.

1. modify pidfd_to_pid as what you described above(ie, return NULL
instead of returning tgid_pidfd_to_pid(file);
2. never export pidfd_to_pid
3. create wrapper __fd_to_pid which calls pidfd_to_pid internally
4. export __fd_to_pid and use it

Correct?

Thanks.

> 
> All new syscalls should only be using anon inode pidfds since they can
> actually have a clean security model built around them in the future.
> Note, pidfd_open() will be sent out together with making pidfds pollable
> for the 5.3 merge window.
> 
> [1]: https://lore.kernel.org/lkml/20190520155630.21684-1-christian@brauner.io/
> 
> Thanks!
> Christian
