Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E46D7CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 11:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2672206C2
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 11:19:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728181AbfJULTb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 07:19:31 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56970 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbfJULTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 07:19:31 -0400
Received: from [213.220.153.21] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iMVic-0006Ks-23; Mon, 21 Oct 2019 11:19:22 +0000
Date:   Mon, 21 Oct 2019 13:19:21 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     syzbot <syzbot+492a4acccd8fc75ddfd0@syzkaller.appspotmail.com>,
        oleg@redhat.com
Cc:     akpm@linux-foundation.org, arnd@arndb.de, christian@brauner.io,
        deepa.kernel@gmail.com, ebiederm@xmission.com, elver@google.com,
        guro@fb.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, will@kernel.org
Subject: Re: KCSAN: data-race in exit_signals / prepare_signal
Message-ID: <20191021111920.frmc3njkha4c3a72@wittgenstein>
References: <0000000000003b1e8005956939f1@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0000000000003b1e8005956939f1@google.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+Cc Will]

On Mon, Oct 21, 2019 at 03:34:07AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    d724f94f x86, kcsan: Enable KCSAN for x86
> git tree:       https://github.com/google/ktsan.git kcsan
> console output: https://syzkaller.appspot.com/x/log.txt?x=13eab79f600000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c0906aa620713d80
> dashboard link: https://syzkaller.appspot.com/bug?extid=492a4acccd8fc75ddfd0
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> 
> Unfortunately, I don't have any reproducer for this crash yet.
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+492a4acccd8fc75ddfd0@syzkaller.appspotmail.com
> 
> ==================================================================
> BUG: KCSAN: data-race in exit_signals / prepare_signal

This traces back to Oleg fixing a race between a group stop and a thread
exiting before it notices that it has a pending signal or is in the middle of
do_exit() already, causing group stop to get wacky.
The original commit to fix this race is
commit d12619b5ff56 ("fix group stop with exit race") which took sighand
lock before setting PF_EXITING on the thread.

Later on in
commit 5dee1707dfbf ("move the related code from exit_notify() to exit_signals()")
an improvement was made for the single-threaded case and the
case where the group stop is already in progress. This removed the
sighand lock around the PF_EXITING assignment.

If the race really matters and given how tsk->flags is currently accessed
everywhere the simple fix for now might be:

diff --git a/kernel/signal.c b/kernel/signal.c
index c4da1ef56fdf..cf61e044c4cc 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2819,7 +2819,9 @@ void exit_signals(struct task_struct *tsk)
        cgroup_threadgroup_change_begin(tsk);

        if (thread_group_empty(tsk) || signal_group_exit(tsk->signal)) {
+               spin_lock_irq(&tsk->sighand->siglock);
                tsk->flags |= PF_EXITING;
+               spin_unlock_irq(&tsk->sighand->siglock);
                cgroup_threadgroup_change_end(tsk);
                return;
        }

Christian
