Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B7AC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 11:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B9B420693
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 11:40:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729027AbfIMLkM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 07:40:12 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54935 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728155AbfIMLkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 07:40:12 -0400
Received: from ip5b402a24.dynamic.kabel-deutschland.de ([91.64.42.36] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1i8jvt-0000Un-Br; Fri, 13 Sep 2019 11:40:09 +0000
Date:   Fri, 13 Sep 2019 13:40:07 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Eugene Syromiatnikov <esyr@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH v3] fork: check exit_signal passed in clone3() call
Message-ID: <20190913114006.7dfwzfm6a76grlk3@wittgenstein>
References: <cover.1568223594.git.esyr@redhat.com>
 <4b38fa4ce420b119a4c6345f42fe3cec2de9b0b5.1568223594.git.esyr@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4b38fa4ce420b119a4c6345f42fe3cec2de9b0b5.1568223594.git.esyr@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11, 2019 at 06:45:40PM +0100, Eugene Syromiatnikov wrote:
> Previously, higher 32 bits of exit_signal fields were lost when
> copied to the kernel args structure (that uses int as a type for the
> respective field).  Moreover, as Oleg has noted[1], exit_signal is used
> unchecked, so it has to be checked for sanity before use; for the legacy
> syscalls, applying CSIGNAL mask guarantees that it is at least non-negative;
> however, there's no such thing is done in clone3() code path, and that can
> break at least thread_group_leader.
> 
> Adding checks that user-passed exit_signal fits into int and passes
> valid_signal() check solves both of these problems.
> 
> [1] https://lkml.org/lkml/2019/9/10/467
> 
> * kernel/fork.c (copy_clone_args_from_user): Fail with -EINVAL if
> args.exit_signal is greater than UINT_MAX or is not a valid signal.
> (_do_fork): Note that exit_signal is expected to be checked for the
> sanity by the caller.
> 
> Fixes: 7f192e3cd316 ("fork: add clone3")
> Reported-by: Oleg Nesterov <oleg@redhat.com>
> Co-authored-by: Oleg Nesterov <oleg@redhat.com>
> Co-authored-by: Dmitry V. Levin <ldv@altlinux.org>
> Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>

For the sake of posterity I appended a reproducer to the patch (cf. [1])
that I pushed to mainline which illustrates how without this patch you
can cause a crash. I'll also explain how I think this happens here.

By passing in a negative signal you can cause a segfault in
proc_flush_task(). The reason is that at process creation time

static inline bool thread_group_leader(struct task_struct *p)
{
	return p->exit_signal >= 0;
}

will return false even though it should return true because exit_signal
overflowed in copy_clone_args_from_user. This means, the kernel
thinks this is a thread and doesn't make the process a thread-group
leader. In proc_flush_task() the kernel will then try to retrieve the
thread group leader but there'll be none ultimately causing a segfault.
Specifically:

void proc_flush_task(struct task_struct *task)
{
	int i;
	struct pid *pid, *tgid;
	struct upid *upid;

	pid = task_pid(task);
	tgid = task_tgid(task); #### tgid is NULL ####

	for (i = 0; i <= pid->level; i++) {
		upid = &pid->numbers[i];
		proc_flush_task_mnt(upid->ns->proc_mnt, upid->nr,
					tgid->numbers[i].nr); #### NULL pointer deref ####
	}
}

[1]:
  #define _GNU_SOURCE
 #include <linux/sched.h>
 #include <linux/types.h>
 #include <sched.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <sys/syscall.h>
 #include <sys/wait.h>
 #include <unistd.h>

 int main(int argc, char *argv[])
 {
        pid_t pid = -1;
        struct clone_args args = {0};
        args.exit_signal = -1;

        pid = syscall(__NR_clone3, &args, sizeof(struct clone_args));
        if (pid < 0)
                exit(EXIT_FAILURE);

        if (pid == 0)
                exit(EXIT_SUCCESS);

        wait(NULL);

        exit(EXIT_SUCCESS);
 }

 Christian
