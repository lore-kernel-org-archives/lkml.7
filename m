Return-Path: <SRS0=X3/1=2E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE34AC43603
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 11:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEE5524125
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 11:53:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbfLNLsW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Dec 2019 06:48:22 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:55886 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbfLNLsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 06:48:22 -0500
Received: from [213.220.153.21] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1ig5u8-0005YC-B3; Sat, 14 Dec 2019 11:48:12 +0000
Date:   Sat, 14 Dec 2019 12:48:11 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     chenqiwu <qiwuchen55@gmail.com>
Cc:     peterz@infradead.org, mingo@kernel.org, kernel-team@android.com,
        linux-kernel@vger.kernel.org, chenqiwu@xiaomi.com, oleg@redhat.com
Subject: Re: [PATCH] kernel/exit: do panic earlier to get coredump if global
 init task exit
Message-ID: <20191214114810.ftfxtx4qaa5nzji4@wittgenstein>
References: <1576131255-3433-1-git-send-email-qiwuchen55@gmail.com>
 <20191212095127.GA5460@redhat.com>
 <20191212100838.GB5460@redhat.com>
 <20191212110513.qf2sapgggnp46voc@wittgenstein>
 <20191214062704.GA5580@cqw-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191214062704.GA5580@cqw-OptiPlex-7050>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 14, 2019 at 02:27:04PM +0800, chenqiwu wrote:
> On Thu, Dec 12, 2019 at 12:05:14PM +0100, Christian Brauner wrote:
> > On Thu, Dec 12, 2019 at 11:08:38AM +0100, Oleg Nesterov wrote:
> > > can't you use is_global_init() && group_dead ?
> > 
> > Seems reasonable.
> > Looks like we can move
> > group_dead = atomic_dec_and_test(&tsk->signal->live);
> > further up...
> > 
> > (Ideally I'd like to have a test for this to ensure that this lets you
> > capture a global init coredump but that might be tricky. But since you've
> > seem to have run into this case maybe you even have something that could
> > be turned into a test? (Similar to how we already have a purely opt-in
> > test for pstore.))
> > 
> > Christian
> 
> Hi all,
> I agree that using is_global_init() && group_dead is more reasonable.
> 
> The crash isuee happened on a Android phone by reboot stress test.
> panic log:
> [   84.048521] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
> [   84.048521]
> [   84.048540] CPU: 2 PID: 1 Comm: init Tainted: G S         O    4.14.117-perf-g8035d1a #1
> [   84.048544] Hardware name: Qualcomm Technologies, Inc. SM8150 V2 PM8150 RAPHAEL (DT)
> [   84.048550] Call trace:
> [   84.048564]  dump_backtrace+0x0/0x268
> [   84.048569]  show_stack+0x14/0x20
> [   84.048577]  dump_stack+0xc4/0x100
> [   84.048584]  panic+0x1f0/0x410
> [   84.048591]  complete_and_exit+0x0/0x20
> [   84.048596]  do_group_exit+0x8c/0xa0
> [   84.048602]  get_signal+0x1c0/0x790
> [   84.048608]  do_notify_resume+0x184/0xc30
> [   84.048613]  work_pending+0x8/0x10
> 
> From the kdump loaded by crash utility, all threads of global init have exited,
> the group_dead value of global init has truned to 0 by atomic_dec_and_test().
> crash> ps init
>    PID    PPID  CPU       TASK        ST  %MEM     VSZ    RSS  COMM
> >     1      0   2  ffffffcd77526000  ??   0.0       0      0  init
>     534      1   4  ffffffcd6b9a9000  ZO   0.0       0      0  init
>     535      1   4  ffffffcd6b9aa000  ZO   0.0       0      0  init
> crash> ps -g 1
> PID: 1      TASK: ffffffcd77526000  CPU: 2   COMMAND: "init"
>   (no threads)
> crash> struct task_struct.signal ffffffcd77526000
>   signal = 0xffffffcd77530000
> crash> struct signal_struct 0xffffffcd77530000
> struct signal_struct {
>   sigcnt = {
>     counter = 1
>   },
>   live = {
>     counter = 0
>   },
>   nr_threads = 1,
>   thread_head = {
>     next = 0xffffffcd77526730,
>     prev = 0xffffffcd77526730
>   },
>   group_exit_code = 11,
>   notify_count = 0,
>   group_exit_task = 0x0,
>   group_stop_count = 0,
>   flags = 4,
>   ...
>  }
> 
> However, as Christian said, the test for this is tricky since we must
> make sure all of init threads exited. I make a test for is_global_init()
> and send a SIGSEGV signal to global init task in userspace. The phone
> crash imeddiately and reboot to collect kdump. Then I extract the coredump
> of global init task from kdump successfully.
> (gdb) core-file core.1.init
> Core was generated by `/system/bin/init second_stage'.
> #0  _exit () at bionic/libc/arch-arm64/syscalls/_exit.S:9
> 9           cmn     x0, #(MAX_ERRNO + 1)
> (gdb) bt
> #0  _exit () at bionic/libc/arch-arm64/syscalls/_exit.S:9
> #1  0x00000055606db11c in android::init::InstallRebootSignalHandlers()::$_14::operator()(int) const (this=<optimized out>, signal=11)
>     at system/core/init/reboot_utils.cpp:141
> #2  0x00000055606db100 in android::init::InstallRebootSignalHandlers()::$_14::__invoke(int) (signal=11) at system/core/init/reboot_utils.cpp:138
> #3  0x0000007f8de236a0 in ?? ()
> Backtrace stopped: previous frame identical to this frame (corrupt stack?)
> 
> So from the following test, we have confidence that the following patch can help us

Thanks. Can you please resend this as a proper patch for v2?

Christian
