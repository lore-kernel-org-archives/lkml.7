Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D73C606BF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 761A120693
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:05:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="bhvlPCno"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732086AbfGHPFa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 11:05:30 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54570 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfGHPF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 11:05:29 -0400
Received: by mail-wm1-f68.google.com with SMTP id p74so13143340wme.4
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 08:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CX33oZ1IjUA6qem5aVbPWfrfYrv4TR7LkIcBin1DDYg=;
        b=bhvlPCnoeg5TumQ9yOns8RLzCyl0U9q+B64cYvtPyo+At5LVqWwvIhjcHq0K2pLvll
         +ZRNaNlIH+KYFnAeixXoAXH2YhhZI8yS1jprXVchyGWBtKGL8yOUUhor7ME/YNKm4+W0
         XBvfGEIGkIy9KuYUo3sj/0TABu4v/YKN+Eh5jIS8W47YuNLYUcC910ZM30+fHMVF8tWG
         7pUSBGMdK8RfP9R7gxK67yhzqRhQ2Y0u1xJqu/qgiUL91XVjh0PcMCzdYADj/4D7aTej
         z6HVjKmRVoJnZM+nPqgeJ0L5eleR1Ierosau8H15W0NYyGiXj4RK/stzb8Qq7rRRQNOH
         Q++A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CX33oZ1IjUA6qem5aVbPWfrfYrv4TR7LkIcBin1DDYg=;
        b=DhBn+oqd7hhFFZY0Mrz2u8qMTaMRdDghVL0KA+rpdR/rq4wG2js2Mi8x0h0IuJwxIm
         8EhePiQjFu4dSnlqy64KIBoCq+3eNMF9oYG11Zji0remGgCE4FORiMOWBqsGXo75ca9K
         MRHe6AUJwIPkgQhSNbY4APbeVjZPru2xcI/YWsyxiKMixQlaAPl9l/ATPFPW3OQ/e/Tj
         n5cIr5Jm13UD92cSs2B2xKzsBV8V+I/iFT8lekJPChrWV1HYIq1JJzE0PVMc9g8g98AR
         8g7kMcyqPbHxnf7yK46vkPqEj805OdrTNrwIg7qfu1+NcFiSqnZhlWamhQtHAsuU3vma
         ohJw==
X-Gm-Message-State: APjAAAUb70SXH+5wMr9C4ZBtG+euIgISpZtXUWzZEU5nV0wfDgldEo1Z
        gq38eN7kB6YRva7q9zvi8Q/gLpGdiXsngQ==
X-Google-Smtp-Source: APXvYqyeLHMZC47UBzB3DR8CyMMz7Cw3A5DeVnM/n9V2TFx8RJ8qFMdVO2kdr5VZ/HAtkWHuSZdQVw==
X-Received: by 2002:a1c:cfc7:: with SMTP id f190mr16465856wmg.85.1562598326433;
        Mon, 08 Jul 2019 08:05:26 -0700 (PDT)
Received: from localhost.localdomain ([212.91.227.56])
        by smtp.gmail.com with ESMTPSA id s25sm12198524wmc.21.2019.07.08.08.05.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 08:05:25 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] clone3 for v5.3
Date:   Mon,  8 Jul 2019 17:00:42 +0200
Message-Id: <20190708150042.11590-1-christian@brauner.io>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This is the PR for the clone3 system call.

The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:

  Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/clone3-v5.3

for you to fetch changes up to d68dbb0c9ac8b1ff52eb09aa58ce6358400fa939:

  arch: handle arches who do not yet define clone3 (2019-06-21 01:54:53 +0200)

/* Summary */
This adds the clone3 syscall which is an extensible successor to clone
after we snagged the last flag with CLONE_PIDFD during the 5.2 merge window
for clone(). It cleanly supports all of the flags from clone() and thus all
legacy workloads.

There are few user visible differences between clone3 and clone. First,
CLONE_DETACHED will cause EINVAL with clone3 so we can reuse this flag.
Second, the CSIGNAL flag is deprecated and will cause EINVAL to be
reported. It is superseeded by a dedicated "exit_signal" argument in struct
clone_args thus freeing up even more flags. And third, clone3 gives
CLONE_PIDFD a dedicated return argument in struct clone_args instead of
abusing CLONE_PARENT_SETTID's parent_tidptr argument.

The clone3 uapi is designed to be easy to handle on 32- and 64 bit:

    /* uapi */
    struct clone_args {
            __aligned_u64 flags;
            __aligned_u64 pidfd;
            __aligned_u64 child_tid;
            __aligned_u64 parent_tid;
            __aligned_u64 exit_signal;
            __aligned_u64 stack;
            __aligned_u64 stack_size;
            __aligned_u64 tls;
    };

and a separate kernel struct is used that uses proper kernel typing:

    /* kernel internal */
    struct kernel_clone_args {
            u64 flags;
            int __user *pidfd;
            int __user *child_tid;
            int __user *parent_tid;
            int exit_signal;
            unsigned long stack;
            unsigned long stack_size;
            unsigned long tls;
    };

The system call comes with a size argument which enables the kernel to
detect what version of clone_args userspace is passing in. clone3 validates
that any additional bytes a given kernel does not know about are set to
zero and that the size never exceeds a page.

A nice feature is that this patchset allowed us to cleanup and simplify
various core kernel codepaths in kernel/fork.c by making the internal
_do_fork() function take struct kernel_clone_args even for legacy clone().

This patch also unblocks the time namespace patchset which wants to
introduce a new CLONE_TIMENS flag.

Note, that clone3 has only been wired up for x86{_32,64}, arm{64}, and
xtensa. These were the architectures that did not require special
massaging. Other architectures treat fork-like system calls individually
and after some back and forth neither Arnd nor I felt confident that we
dared to add clone3 unconditionally to all architectures. We agreed to
leave this up to individual architecture maintainers. This is why there's
an additional patch that introduces __ARCH_WANT_SYS_CLONE3 which any
architecture can set once it has implemented support for clone3. The patch
also adds a cond_syscall(clone3) for architectures such as nios2 or h8300
that generate their syscall table by simply including asm-generic/unistd.h.
The hope is to get rid of __ARCH_WANT_SYS_CLONE3 and cond_syscall() rather
soon.

I sent this patchset separately from the pidfd patches for polling support
and pidfd_open() mostly because they were not necessarily related but also
so you can easily decide what you want to pull.

/* Testing */
The patch is based on v5.2-rc1 and have been sitting in linux-next since
then.

/* Conflicts with v5.2 */
A test-merge of my tree into pristine v5.2 revealed a conflict in
kernel/fork.c. It's not a very difficult conflict to resolve but it's also
not trivial. The fix that was carried in linux-next and that I carry
locally can be seen in [1]. I can also provide a fixed/rebased tree if
needed.

/* Conflicts with other trees */
I am not aware of any conflicts with other trees based on linux-next.

/* Syscall number 435 */
clone3() uses syscall number 435 and is coordinated with pidfd_open() which
uses syscall number 434. I'm not aware of any other syscall targeted for
5.3 that has chosen the same number.

/* New signing subkey */
So that there are no suprises, please note that I signed-off the tag with a
new signing key: 0x91C61BC06578DCA2
It's an ed25519 signing subkey that I moved to a Nitrokey and that's
available from the new, safer keys.openpgp.org keyserver.
Given the SKS churn I figured it might be a good idea to use a new,
dedicated kernel-only subkey instead of my general signing subkey.

Thanks!
Christian

[1]:

diff --cc kernel/fork.c
index fe83343da24b,98abea995629..000000000000
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@@ -1753,7 -1768,7 +1748,8 @@@ static __latent_entropy struct task_str
        int pidfd = -1, retval;
        struct task_struct *p;
        struct multiprocess_signals delayed;
 +      struct file *pidfile = NULL;
+       u64 clone_flags = args->flags;

        /*
         * Don't allow sharing the root directory with processes in a different
@@@ -2031,17 -2044,7 +2025,17 @@@
                        goto bad_fork_free_pid;

                pidfd = retval;
 +
 +              pidfile = anon_inode_getfile("[pidfd]", &pidfd_fops, pid,
 +                                            O_RDWR | O_CLOEXEC);
 +              if (IS_ERR(pidfile)) {
 +                      put_unused_fd(pidfd);
 +                      retval = PTR_ERR(pidfile);
 +                      goto bad_fork_free_pid;
 +              }
 +              get_pid(pid);   /* held by pidfile now */
 +
-               retval = put_user(pidfd, parent_tidptr);
+               retval = put_user(pidfd, args->pidfd);
                if (retval)
                        goto bad_fork_put_pidfd;
        }

----------------------------------------------------------------
clone3-v5.3

----------------------------------------------------------------
Christian Brauner (3):
      fork: add clone3
      arch: wire-up clone3() syscall
      arch: handle arches who do not yet define clone3

 arch/arm/include/asm/unistd.h               |   1 +
 arch/arm/tools/syscall.tbl                  |   1 +
 arch/arm64/include/asm/unistd.h             |   3 +-
 arch/arm64/include/asm/unistd32.h           |   2 +
 arch/microblaze/kernel/syscalls/syscall.tbl |   1 +
 arch/x86/entry/syscalls/syscall_32.tbl      |   1 +
 arch/x86/entry/syscalls/syscall_64.tbl      |   1 +
 arch/x86/ia32/sys_ia32.c                    |  12 +-
 arch/x86/include/asm/unistd.h               |   1 +
 arch/xtensa/include/asm/unistd.h            |   1 +
 arch/xtensa/kernel/syscalls/syscall.tbl     |   1 +
 include/linux/sched/task.h                  |  17 ++-
 include/linux/syscalls.h                    |   4 +
 include/uapi/asm-generic/unistd.h           |   4 +-
 include/uapi/linux/sched.h                  |  16 +++
 kernel/fork.c                               | 203 +++++++++++++++++++++-------
 kernel/sys_ni.c                             |   2 +
 17 files changed, 218 insertions(+), 53 deletions(-)
