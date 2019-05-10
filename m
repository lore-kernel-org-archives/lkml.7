Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 110B1C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 10:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB2DA217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 10:50:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="GlZI7T1W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbfEJKuw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 06:50:52 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41765 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727049AbfEJKuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 06:50:51 -0400
Received: by mail-ed1-f68.google.com with SMTP id m4so4719993edd.8
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 03:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yBUeJbZyUrlht1SFBwi6imTZ/NYy8ameJGgWrSP1vis=;
        b=GlZI7T1WnjFL/pCE6RL90JiD3HomfRyuzRWfXP8khwqfvE1O6jQ0EJT7SLdL1uV/NR
         XQmpo0W9B9YA0jvl4Yac4pBrlmAo4bPEhoSFOasnOgaegfebiqLi//LpoHp6KpdEtzbT
         SlkXhMj6zigiMw8w1+kEGXBDwLSrVLL3YhvmRoIXIqd/3Au14Kq78BtvSre3p+lEoyKJ
         8YBhMKSqHIt0xrhsePlpnvDjL/w8ChHGEk7h7nEJe8URf3Th+c2dgzNSOSFQvMMmouwH
         Pgo7GDsXGiQG5fp4yGsSTdpqUvc4Yrw6KcO+8UL15xOuWaCu/k3BZB/bU7JHtJJ83cXI
         eUhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yBUeJbZyUrlht1SFBwi6imTZ/NYy8ameJGgWrSP1vis=;
        b=hz4hrqJNEE05E0iqnYYllLhtOVGT6hF1PrikGBerSHhUoOyYEzskFuN3F7kqErxUTz
         EZUJpH+lHymXdBoyGgFn/Vrx5HxiAPPNFp9qSClCCjxZCuqfRGTrizyKS813rVOa0gbi
         y+Vl5aQAxebgmJSnshDcrT09xVPoBHpZFR9G0Q5aVfJp32IZUGpm7p1da3MmtvaS5Dls
         2RK4vMnB/R/Td9ZjdRY3jGT1vILp/5fgwS4dcFUDYkP4BgmhHOvwgw9TI9iPr95Pw/1Q
         KF2wbaON8T9hu/agdWmUi9bCuWAtEeR6cRcYKU4ktT1aJ9CaqvWLL/8uIUMSrbnixiBd
         p1lQ==
X-Gm-Message-State: APjAAAVDByyaCirOAUq+ouvM2ZNElLsSQNHFpWBkgWKsFZQVUa+ZkO0U
        qBz2neuseKhrz8R17m4fBxegVg==
X-Google-Smtp-Source: APXvYqx6c5SkAxkvR6E61Q2AtV20gSOHa2PQkwc1IXDfDbCR3sG9xcU6m4gnZhy4jJvHFeqqTuhIcw==
X-Received: by 2002:a17:906:b789:: with SMTP id dt9mr7831653ejb.244.1557485448979;
        Fri, 10 May 2019 03:50:48 -0700 (PDT)
Received: from brauner.io ([178.19.218.101])
        by smtp.gmail.com with ESMTPSA id r18sm684027ejh.92.2019.05.10.03.50.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 10 May 2019 03:50:48 -0700 (PDT)
Date:   Fri, 10 May 2019 12:50:47 +0200
From:   Christian Brauner <christian@brauner.io>
To:     jannh@google.com, oleg@redhat.com, viro@zeniv.linux.org.uk,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, arnd@arndb.de, arunks@codeaurora.org,
        cyphar@cyphar.com, dhowells@redhat.com, ebiederm@xmission.com,
        elena.reshetova@intel.com, guro@fb.com, keescook@chromium.org,
        luto@amacapital.net, luto@kernel.org, mhocko@suse.com,
        mingo@kernel.org, mtk.manpages@gmail.com, namit@vmware.com,
        peterz@infradead.org, riel@surriel.com, shakeelb@google.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        wad@chromium.org,
        syzbot+3286e58549edc479faae@syzkaller.appspotmail.com
Subject: Re: [PATCH] fork: do not release lock that wasn't taken
Message-ID: <20190510105046.jdox22ytlhojw37q@brauner.io>
References: <20190510104913.27143-1-christian@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190510104913.27143-1-christian@brauner.io>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 10, 2019 at 12:49:13PM +0200, Christian Brauner wrote:
> Avoid calling cgroup_threadgroup_change_end() without having called
> cgroup_threadgroup_change_begin() first.
> 
> During process creation we need to check whether the cgroup we are in
> allows us to fork. To perform this check the cgroup needs to guard itself
> against threadgroup changes and takes a lock.
> Prior to CLONE_PIDFD the cleanup target "bad_fork_free_pid" would also need
> to call cgroup_threadgroup_change_end() because said lock had already been
> taken.
> However, this is not the case anymore with the addition of CLONE_PIDFD. We
> are now allocating a pidfd before we check whether the cgroup we're in can
> fork and thus prior to taking the lock. So when copy_process() fails at the
> right step it would release a lock we haven't taken.
> This bug is not even very subtle to be honest. It's just not very clear
> from the naming of cgroup_threadgroup_change_{begin,end}() that a lock is
> taken.
> 
> Here's the relevant splat:
> 
> entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat.S:139
> RIP: 0023:0xf7fec849
> Code: 85 d2 74 02 89 0a 5b 5d c3 8b 04 24 c3 8b 14 24 c3 8b 3c 24 c3 90 90
> 90 90 90 90 90 90 90 90 90 90 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90
> 90 90 90 eb 0d 90 90 90 90 90 90 90 90 90 90 90 90
> RSP: 002b:00000000ffed5a8c EFLAGS: 00000246 ORIG_RAX: 0000000000000078
> RAX: ffffffffffffffda RBX: 0000000000003ffc RCX: 0000000000000000
> RDX: 00000000200005c0 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: 0000000000000012 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> ------------[ cut here ]------------
> DEBUG_LOCKS_WARN_ON(depth <= 0)
> WARNING: CPU: 1 PID: 7744 at kernel/locking/lockdep.c:4052 __lock_release
> kernel/locking/lockdep.c:4052 [inline]
> WARNING: CPU: 1 PID: 7744 at kernel/locking/lockdep.c:4052
> lock_release+0x667/0xa00 kernel/locking/lockdep.c:4321
> Kernel panic - not syncing: panic_on_warn set ...
> CPU: 1 PID: 7744 Comm: syz-executor007 Not tainted 5.1.0+ #4
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>   __dump_stack lib/dump_stack.c:77 [inline]
>   dump_stack+0x172/0x1f0 lib/dump_stack.c:113
>   panic+0x2cb/0x65c kernel/panic.c:214
>   __warn.cold+0x20/0x45 kernel/panic.c:566
>   report_bug+0x263/0x2b0 lib/bug.c:186
>   fixup_bug arch/x86/kernel/traps.c:179 [inline]
>   fixup_bug arch/x86/kernel/traps.c:174 [inline]
>   do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:272
>   do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:291
>   invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:972
> RIP: 0010:__lock_release kernel/locking/lockdep.c:4052 [inline]
> RIP: 0010:lock_release+0x667/0xa00 kernel/locking/lockdep.c:4321
> Code: 0f 85 a0 03 00 00 8b 35 77 66 08 08 85 f6 75 23 48 c7 c6 a0 55 6b 87
> 48 c7 c7 40 25 6b 87 4c 89 85 70 ff ff ff e8 b7 a9 eb ff <0f> 0b 4c 8b 85
> 70 ff ff ff 4c 89 ea 4c 89 e6 4c 89 c7 e8 52 63 ff
> RSP: 0018:ffff888094117b48 EFLAGS: 00010086
> RAX: 0000000000000000 RBX: 1ffff11012822f6f RCX: 0000000000000000
> RDX: 0000000000000000 RSI: ffffffff815af236 RDI: ffffed1012822f5b
> RBP: ffff888094117c00 R08: ffff888092bfc400 R09: fffffbfff113301d
> R10: fffffbfff113301c R11: ffffffff889980e3 R12: ffffffff8a451df8
> R13: ffffffff8142e71f R14: ffffffff8a44cc80 R15: ffff888094117bd8
>   percpu_up_read.constprop.0+0xcb/0x110 include/linux/percpu-rwsem.h:92
>   cgroup_threadgroup_change_end include/linux/cgroup-defs.h:712 [inline]
>   copy_process.part.0+0x47ff/0x6710 kernel/fork.c:2222
>   copy_process kernel/fork.c:1772 [inline]
>   _do_fork+0x25d/0xfd0 kernel/fork.c:2338
>   __do_compat_sys_x86_clone arch/x86/ia32/sys_ia32.c:240 [inline]
>   __se_compat_sys_x86_clone arch/x86/ia32/sys_ia32.c:236 [inline]
>   __ia32_compat_sys_x86_clone+0xbc/0x140 arch/x86/ia32/sys_ia32.c:236
>   do_syscall_32_irqs_on arch/x86/entry/common.c:334 [inline]
>   do_fast_syscall_32+0x281/0xd54 arch/x86/entry/common.c:405
>   entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat.S:139
> RIP: 0023:0xf7fec849
> Code: 85 d2 74 02 89 0a 5b 5d c3 8b 04 24 c3 8b 14 24 c3 8b 3c 24 c3 90 90
> 90 90 90 90 90 90 90 90 90 90 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90
> 90 90 90 eb 0d 90 90 90 90 90 90 90 90 90 90 90 90
> RSP: 002b:00000000ffed5a8c EFLAGS: 00000246 ORIG_RAX: 0000000000000078
> RAX: ffffffffffffffda RBX: 0000000000003ffc RCX: 0000000000000000
> RDX: 00000000200005c0 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: 0000000000000012 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> Kernel Offset: disabled
> Rebooting in 86400 seconds..
> 
> Reported-by: syzbot+3286e58549edc479faae@syzkaller.appspotmail.com
> Fixes: b3e583825266 ("clone: add CLONE_PIDFD")
> Signed-off-by: Christian Brauner <christian@brauner.io>

Assuming we agree that this is correct I bundle this into my pidfd tree
together with the pidfd-metadata fix for .gitignore that Linus pointed
out beginning of this week and send pr later today.

Christian

> ---
>  kernel/fork.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 5359facf9867..737db1828437 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -2102,7 +2102,7 @@ static __latent_entropy struct task_struct *copy_process(
>  	 */
>  	retval = cgroup_can_fork(p);
>  	if (retval)
> -		goto bad_fork_put_pidfd;
> +		goto bad_fork_cgroup_threadgroup_change_end;
>  
>  	/*
>  	 * From this point on we must avoid any synchronous user-space
> @@ -2217,11 +2217,12 @@ static __latent_entropy struct task_struct *copy_process(
>  	spin_unlock(&current->sighand->siglock);
>  	write_unlock_irq(&tasklist_lock);
>  	cgroup_cancel_fork(p);
> +bad_fork_cgroup_threadgroup_change_end:
> +	cgroup_threadgroup_change_end(current);
>  bad_fork_put_pidfd:
>  	if (clone_flags & CLONE_PIDFD)
>  		ksys_close(pidfd);
>  bad_fork_free_pid:
> -	cgroup_threadgroup_change_end(current);
>  	if (pid != &init_struct_pid)
>  		free_pid(pid);
>  bad_fork_cleanup_thread:
> -- 
> 2.21.0
> 
