Return-Path: <SRS0=X3/1=2E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1424BC43603
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 06:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0F7524656
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 06:27:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JE7/8TAe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725883AbfLNG1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Dec 2019 01:27:08 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44624 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbfLNG1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 01:27:08 -0500
Received: by mail-pf1-f196.google.com with SMTP id d199so2631621pfd.11
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2019 22:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=N159nS3D8Hn8gRTBZKGnMRdWL1Ga6pNqjdCPl4N21xQ=;
        b=JE7/8TAexRylLEdFaFVR2OYOLnaPn8Yui/QX0CA5dbMcoYpyn62AuVy18naHqXI/iJ
         evzi4hK2g3YArSpr8OoEUJGNpNtmF6oFbvjylCzT67SowRQ5IZpFldLS9FQ/lFVV2fKi
         I34BUQSIBN55E9Z8hKHjRqfAvHXobCzxSJlqzU+4rdrRjJBg99HQ6PRSMRZngi+oL+g1
         AugVwBguOU33FgR6V+6m7s4Ks4UR4f70Zt6GWNgz5X8VLtkihUFQud8p1LqHdwPgIa1R
         kFbnD/uMFdVCVpTL4Sc6vON/lIQdv1TnSWdBPgqqmPSaTREJeH61qoTiTBvDFgbbupHn
         RoNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=N159nS3D8Hn8gRTBZKGnMRdWL1Ga6pNqjdCPl4N21xQ=;
        b=Lr90w9HDoJOBDeB5r+NFyZSES5fgO3++GjYFR/r0FuTQA24hPhwgoNgTVZ16uJQxvi
         UkROnd3uF4JxbCM4TTIKkh7YQadgp+5uCW9/f6gIefeRXIXbGLnNMzi0YcSuHhFsbtC6
         uPZ0BqVWUThR1a/Wmt//AYEiqFJq4xoYZNvCVL4opGg4QC06J2X1dReExplSr3Hwz15Y
         3qLeiKawiDattmoDZvzXWLxaIfS0UVQeHEMCe7SR0O152E7CD7PJtEy7QF7gHv9DN1zh
         jJp0Elte3e3LuSzvW5vjPpcfd6rZ+eSzljRqTNDN3e6yhspOg2zjI0UZ3P25wIuTmPGh
         llcA==
X-Gm-Message-State: APjAAAXju52QTTVPmx8h1gURrLoHfX5gfg/NYIdQArrfc8Yd5Wwc6141
        n/6TOZVRMaBIc1/fc98IUlpAKxzPpLE=
X-Google-Smtp-Source: APXvYqw4/Er4Y8aacsRbHhS75VYTn96D0IU8NDEr2yZ/d8DKfusBv2zY1bPZM02FLsJDgry6BiVUkg==
X-Received: by 2002:a62:888e:: with SMTP id l136mr3888965pfd.80.1576304827303;
        Fri, 13 Dec 2019 22:27:07 -0800 (PST)
Received: from localhost ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id h16sm14084157pfn.85.2019.12.13.22.27.06
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 13 Dec 2019 22:27:06 -0800 (PST)
Date:   Sat, 14 Dec 2019 14:27:04 +0800
From:   chenqiwu <qiwuchen55@gmail.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        peterz@infradead.org, mingo@kernel.org
Cc:     kernel-team@android.com, linux-kernel@vger.kernel.org,
        chenqiwu@xiaomi.com
Subject: Re: [PATCH] kernel/exit: do panic earlier to get coredump if global
 init task exit
Message-ID: <20191214062704.GA5580@cqw-OptiPlex-7050>
References: <1576131255-3433-1-git-send-email-qiwuchen55@gmail.com>
 <20191212095127.GA5460@redhat.com>
 <20191212100838.GB5460@redhat.com>
 <20191212110513.qf2sapgggnp46voc@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191212110513.qf2sapgggnp46voc@wittgenstein>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2019 at 12:05:14PM +0100, Christian Brauner wrote:
> On Thu, Dec 12, 2019 at 11:08:38AM +0100, Oleg Nesterov wrote:
> > can't you use is_global_init() && group_dead ?
> 
> Seems reasonable.
> Looks like we can move
> group_dead = atomic_dec_and_test(&tsk->signal->live);
> further up...
> 
> (Ideally I'd like to have a test for this to ensure that this lets you
> capture a global init coredump but that might be tricky. But since you've
> seem to have run into this case maybe you even have something that could
> be turned into a test? (Similar to how we already have a purely opt-in
> test for pstore.))
> 
> Christian

Hi all,
I agree that using is_global_init() && group_dead is more reasonable.

The crash isuee happened on a Android phone by reboot stress test.
panic log:
[   84.048521] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
[   84.048521]
[   84.048540] CPU: 2 PID: 1 Comm: init Tainted: G S         O    4.14.117-perf-g8035d1a #1
[   84.048544] Hardware name: Qualcomm Technologies, Inc. SM8150 V2 PM8150 RAPHAEL (DT)
[   84.048550] Call trace:
[   84.048564]  dump_backtrace+0x0/0x268
[   84.048569]  show_stack+0x14/0x20
[   84.048577]  dump_stack+0xc4/0x100
[   84.048584]  panic+0x1f0/0x410
[   84.048591]  complete_and_exit+0x0/0x20
[   84.048596]  do_group_exit+0x8c/0xa0
[   84.048602]  get_signal+0x1c0/0x790
[   84.048608]  do_notify_resume+0x184/0xc30
[   84.048613]  work_pending+0x8/0x10

From the kdump loaded by crash utility, all threads of global init have exited,
the group_dead value of global init has truned to 0 by atomic_dec_and_test().
crash> ps init
   PID    PPID  CPU       TASK        ST  %MEM     VSZ    RSS  COMM
>     1      0   2  ffffffcd77526000  ??   0.0       0      0  init
    534      1   4  ffffffcd6b9a9000  ZO   0.0       0      0  init
    535      1   4  ffffffcd6b9aa000  ZO   0.0       0      0  init
crash> ps -g 1
PID: 1      TASK: ffffffcd77526000  CPU: 2   COMMAND: "init"
  (no threads)
crash> struct task_struct.signal ffffffcd77526000
  signal = 0xffffffcd77530000
crash> struct signal_struct 0xffffffcd77530000
struct signal_struct {
  sigcnt = {
    counter = 1
  },
  live = {
    counter = 0
  },
  nr_threads = 1,
  thread_head = {
    next = 0xffffffcd77526730,
    prev = 0xffffffcd77526730
  },
  group_exit_code = 11,
  notify_count = 0,
  group_exit_task = 0x0,
  group_stop_count = 0,
  flags = 4,
  ...
 }

However, as Christian said, the test for this is tricky since we must
make sure all of init threads exited. I make a test for is_global_init()
and send a SIGSEGV signal to global init task in userspace. The phone
crash imeddiately and reboot to collect kdump. Then I extract the coredump
of global init task from kdump successfully.
(gdb) core-file core.1.init
Core was generated by `/system/bin/init second_stage'.
#0  _exit () at bionic/libc/arch-arm64/syscalls/_exit.S:9
9           cmn     x0, #(MAX_ERRNO + 1)
(gdb) bt
#0  _exit () at bionic/libc/arch-arm64/syscalls/_exit.S:9
#1  0x00000055606db11c in android::init::InstallRebootSignalHandlers()::$_14::operator()(int) const (this=<optimized out>, signal=11)
    at system/core/init/reboot_utils.cpp:141
#2  0x00000055606db100 in android::init::InstallRebootSignalHandlers()::$_14::__invoke(int) (signal=11) at system/core/init/reboot_utils.cpp:138
#3  0x0000007f8de236a0 in ?? ()
Backtrace stopped: previous frame identical to this frame (corrupt stack?)

So from the following test, we have confidence that the following patch can help us
to get the extra coredump of init when global init task do real exit.

diff --git a/kernel/exit.c b/kernel/exit.c
index 8e288e8..9454106 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -476,10 +476,6 @@ static struct task_struct *find_child_reaper(struct task_struct *father,
        }

        write_unlock_irq(&tasklist_lock);
-       if (unlikely(pid_ns == &init_pid_ns)) {
-               panic("Attempted to kill init! exitcode=0x%08x\n",
-                       father->signal->group_exit_code ?: father->exit_code);
-       }

        list_for_each_entry_safe(p, n, dead, ptrace_entry) {
                list_del_init(&p->ptrace_entry);
@@ -687,6 +683,10 @@ void do_exit(long code)
        if (unlikely(!tsk->pid))
                panic("Attempted to kill the idle task!");

+       group_dead = atomic_dec_and_test(&tsk->signal->live);
+       if (unlikely(is_global_init(tsk) && group_dead))
+               panic("Attempted to kill init! exitcode=0x%08lx\n", code);
+
        /*
         * If do_exit is called because this processes oopsed, it's possible
         * that get_fs() was left as KERNEL_DS, so reset it to USER_DS before
@@ -743,7 +743,6 @@ void do_exit(long code)
        if (tsk->mm)
                sync_mm_rss(tsk->mm);
        acct_update_integrals(tsk);
-       group_dead = atomic_dec_and_test(&tsk->signal->live);
        if (group_dead) {
                hrtimer_cancel(&tsk->signal->real_timer);
                exit_itimers(tsk->signal);


