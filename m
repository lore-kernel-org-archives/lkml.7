Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE61C282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 20:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B94BC2077B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 20:53:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgAGUxS convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 15:53:18 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46973 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbgAGUxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 15:53:17 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iovqZ-0007mP-1a; Tue, 07 Jan 2020 21:53:03 +0100
Date:   Tue, 7 Jan 2020 21:53:02 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     syzbot <syzbot+f2ca20d4aa1408b0385a@syzkaller.appspotmail.com>
Cc:     alexander.deucher@amd.com, bp@alien8.de, dave.hansen@intel.com,
        hpa@zytor.com, linux-kernel@vger.kernel.org, mingo@redhat.com,
        nicholas.kazlauskas@amd.com, riel@surriel.com, sunpeng.li@amd.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        x86@kernel.org, zhan.liu@amd.com
Subject: Re: WARNING in switch_fpu_return
Message-ID: <20200107205302.45yb2rkekz3nat6v@linutronix.de>
References: <000000000000f04e43059b1ee697@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <000000000000f04e43059b1ee697@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-01-01 18:25:09 [-0800], syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    bf8d1cd4 Merge tag 'scsi-fixes' of git://git.kernel.org/pu..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=17a4ce15e00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=ed9d672709340e35
> dashboard link: https://syzkaller.appspot.com/bug?extid=f2ca20d4aa1408b0385a
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> userspace arch: i386
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10cc8971e00000

So I tried to reproduce this. syz-prog2c made .c out of the above link.
It starts with:
|int main(void)
| {
|   syscall(__NR_mmap, 0x20000000ul, 0x1000000ul, 3ul, 0x32ul, -1, 0);

and segfaults on execution. The problem is that for for 32bit-x86 this
should be __NR_mmap2 instead. This fixed the mmap() calls however the
openat() still failed… Nothing bad happened in the end since all the
syscalls failed "early".
As a 64bit binary, it is a different story:
- On a Intel box the KVM_RUN ioctl() worked and did not return (CTRL-C
  ended the ioctl() without an error/warning)
- On a AMD box the KVM_RUN ioctl() triggered a reboot of the kvm guest.

> The bug was bisected to:
> 
> commit 92e6475ae0a0383b012eb21c1aaf0e5456b1a3d9
> Author: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
> Date:   Wed Jul 3 14:02:39 2019 +0000
> 
>     drm/amd/display: Set enabled to false at start of audio disable
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15614e3ee00000

This commit changes a file which is not compiled by the config provided.

> console output: https://syzkaller.appspot.com/x/log.txt?x=13614e3ee00000

> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+f2ca20d4aa1408b0385a@syzkaller.appspotmail.com
> Fixes: 92e6475ae0a0 ("drm/amd/display: Set enabled to false at start of
> audio disable")
> 
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 2862 at arch/x86/include/asm/fpu/internal.h:539
> __fpregs_load_activate arch/x86/include/asm/fpu/internal.h:539 [inline]
> WARNING: CPU: 0 PID: 2862 at arch/x86/include/asm/fpu/internal.h:539
> switch_fpu_return+0x437/0x4f0 arch/x86/kernel/fpu/core.c:343
> Kernel panic - not syncing: panic_on_warn set ...
> CPU: 0 PID: 2862 Comm: kworker/0:3 Not tainted 5.5.0-rc3-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Workqueue: events async_pf_execute
> Call Trace:
…
> ff e8 9d 8d 4a 00 0f 0b e9 18 fd ff ff e8 91 8d
> RSP: 0018:ffffc90007ecfa80 EFLAGS: 00010293
> RAX: ffff88809f60e0c0 RBX: ffff88809f60e0c0 RCX: ffffffff812a9ccf
> RDX: 0000000000000000 RSI: ffffffff812aa047 RDI: 0000000000000005
> RBP: ffffc90007ecfb10 R08: ffff88809f60e0c0 R09: ffffed1013ec1c19
> R10: ffffed1013ec1c18 R11: ffff88809f60e0c7 R12: 1ffff92000fd9f51
> R13: ffff88809f60f5c0 R14: 0000000000200000 R15: ffffc90007ecfae8
>  kvm_arch_vcpu_load+0x66e/0x950 arch/x86/kvm/x86.c:3463
>  vcpu_load+0x43/0x90 arch/x86/kvm/../../../virt/kvm/kvm_main.c:201
>  kvm_unload_vcpu_mmu arch/x86/kvm/x86.c:9543 [inline]
>  kvm_free_vcpus arch/x86/kvm/x86.c:9558 [inline]
>  kvm_arch_destroy_vm+0x184/0x5f0 arch/x86/kvm/x86.c:9663
>  kvm_destroy_vm arch/x86/kvm/../../../virt/kvm/kvm_main.c:816 [inline]
>  kvm_put_kvm+0x5a5/0xcc0 arch/x86/kvm/../../../virt/kvm/kvm_main.c:837
>  async_pf_execute+0x3bf/0x800 arch/x86/kvm/../../../virt/kvm/async_pf.c:101
>  process_one_work+0x9af/0x1740 kernel/workqueue.c:2264
>  worker_thread+0x98/0xe40 kernel/workqueue.c:2410
>  kthread+0x361/0x430 kernel/kthread.c:255
>  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
> Kernel Offset: disabled
> Rebooting in 86400 seconds..

As part of kvm_arch_vcpu_load() switch_fpu_return() is invoked which
triggers the warning. The problem is that a workqueue should have
TIF_NEED_FPU_LOAD set. I have no idea how that one got set since it
should not be set for kernel threads.

Sebastian
