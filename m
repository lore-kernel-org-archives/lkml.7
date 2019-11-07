Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B297EC5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 13:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85ED02178F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 13:51:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389187AbfKGNvv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 08:51:51 -0500
Received: from foss.arm.com ([217.140.110.172]:56556 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387662AbfKGNvv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 08:51:51 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 19CEC31B;
        Thu,  7 Nov 2019 05:51:50 -0800 (PST)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EE9603F71A;
        Thu,  7 Nov 2019 05:51:48 -0800 (PST)
Subject: Re: [sched] 10e7071b2f: BUG:kernel_NULL_pointer_dereference,address
To:     kernel test robot <lkp@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Aaron Lu <aaron.lwe@gmail.com>, Phil Auld <pauld@redhat.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>, lkp@01.org
References: <20191107090808.GW29418@shao2-debian>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <d94e549d-04de-5b23-c4e0-6c161ec8213e@arm.com>
Date:   Thu, 7 Nov 2019 13:51:47 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191107090808.GW29418@shao2-debian>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/11/2019 09:08, kernel test robot wrote:
> FYI, we noticed the following commit (built with gcc-7):
> 
> commit: 10e7071b2f491b0fb981717ea0a585c441906ede ("sched: Rework CPU hotplug task selection")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> in testcase: kernel_selftests
> with following parameters:
> 
> 	group: kselftests-01
> 
> test-description: The kernel contains a set of "self tests" under the tools/testing/selftests/ directory. These are intended to be small unit tests to exercise individual code paths in the kernel.
> test-url: https://www.kernel.org/doc/Documentation/kselftest.txt
> 
> 
> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 8G
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> +-------------------------------------------------+------------+------------+
> |                                                 | f95d4eaee6 | 10e7071b2f |
> +-------------------------------------------------+------------+------------+
> | boot_successes                                  | 54         | 12         |
> | boot_failures                                   | 0          | 82         |
> | BUG:kernel_NULL_pointer_dereference,address     | 0          | 79         |
> | Oops:#[##]                                      | 0          | 79         |
> | RIP:pick_next_task_dl                           | 0          | 79         |
> | Kernel_panic-not_syncing:Fatal_exception        | 0          | 79         |
> | BUG:kernel_reboot-without-warning_in_test_stage | 0          | 3          |
> +-------------------------------------------------+------------+------------+
> 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <lkp@intel.com>
> 
> 

FWIW the decoded stacktrace from my end is (my x86 GCC is a tad ancient,
but the lines seem to match):

[   84.432464] BUG: kernel NULL pointer dereference, address: 0000000000000064
[   84.433700] #PF: supervisor read access in kernel mode
[   84.434589] #PF: error_code(0x0000) - not-present page
[   84.435499] PGD 0 P4D 0
[   84.435933] Oops: 0000 [#1] SMP PTI
[   84.436581] CPU: 1 PID: 15 Comm: migration/1 Not tainted 5.3.0-rc1-00086-g10e7071b2f491 #1
[   84.438004] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
[   84.439461] RIP: 0010:pick_next_task_dl (./include/linux/sched/deadline.h:13 ./include/linux/sched/deadline.h:20 kernel/sched/deadline.c:505 kernel/sched/deadline.c:1766)
[ 84.440266] Code: ed bd 70 01 01 e8 42 2d fb ff 0f 0b e9 6b ff ff ff 66 66 2e 0f 1f 84 00 00 00 00 00 66 66 66 66 90 55 53 48 89 fb 48 83 ec 10 <8b> 46 64 85 c0 78 73 48 81 7e 78 a0 3f e2 a7 74 57 48 83 bb 10 09
All code
========
   0:	ed			in     (%dx),%eax
   1:	bd 70 01 01 e8		mov    $0xe8010170,%ebp
   6:	42 2d fb ff 0f 0b	rex.X sub $0xb0ffffb,%eax
   c:	e9 6b ff ff ff		jmpq   0xffffffffffffff7c
  11:	66 66 2e 0f 1f 84 00	data16 nopw %cs:0x0(%rax,%rax,1)
  18:	00 00 00 00
  1c:	66 66 66 66 90		data16 data16 data16 xchg %ax,%ax
  21:	55			push   %rbp
  22:	53			push   %rbx
  23:	48 89 fb		mov    %rdi,%rbx
  26:	48 83 ec 10		sub    $0x10,%rsp
  2a:*	8b 46 64		mov    0x64(%rsi),%eax		<-- trapping instruction
  2d:	85 c0			test   %eax,%eax
  2f:	78 73			js     0xa4
  31:	48 81 7e 78 a0 3f e2	cmpq   $0xffffffffa7e23fa0,0x78(%rsi)
  38:	a7
  39:	74 57			je     0x92
  3b:	48			rex.W
  3c:	83			.byte 0x83
  3d:	bb			.byte 0xbb
  3e:	10 09			adc    %cl,(%rcx)

Code starting with the faulting instruction
===========================================
   0:	8b 46 64		mov    0x64(%rsi),%eax
   3:	85 c0			test   %eax,%eax
   5:	78 73			js     0x7a
   7:	48 81 7e 78 a0 3f e2	cmpq   $0xffffffffa7e23fa0,0x78(%rsi)
   e:	a7
   f:	74 57			je     0x68
  11:	48			rex.W
  12:	83			.byte 0x83
  13:	bb			.byte 0xbb
  14:	10 09			adc    %cl,(%rcx)
[   84.443485] RSP: 0000:ffffa5518008bd40 EFLAGS: 00010082
[   84.444423] RAX: ffffffffa6eeeae0 RBX: ffff98ebbfd2b0c0 RCX: ffff98ebbfd2d040
[   84.445641] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff98ebbfd2b0c0
[   84.446877] RBP: ffffa5518008bdc0 R08: 0000001ac1016512 R09: 0000000000000001
[   84.448128] R10: ffffffffa863e640 R11: 0000000000000003 R12: ffff98ebbfd2b0c0
[   84.449349] R13: ffffffffa7e23fa0 R14: ffffffffa7e24060 R15: 0000000000000000
[   84.450603] FS:  0000000000000000(0000) GS:ffff98ebbfd00000(0000) knlGS:0000000000000000
[   84.452007] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   84.453022] CR2: 0000000000000064 CR3: 00000001aab84000 CR4: 00000000000406e0
[   84.454244] Call Trace:
[   84.455263] ? update_rq_clock (kernel/sched/pelt.h:85 kernel/sched/core.c:196 kernel/sched/core.c:218)
[   84.456081] sched_cpu_dying (kernel/sched/core.c:6093 kernel/sched/core.c:6143 kernel/sched/core.c:6366)
[   84.456777] ? sched_cpu_starting (kernel/sched/core.c:6353)
[   84.457510] cpuhp_invoke_callback (kernel/cpu.c:166 (discriminator 4))
[   84.458279] ? cpu_disable_common (./arch/x86/include/asm/bitops.h:80 ./include/asm-generic/bitops-instrumented.h:57 ./include/linux/cpumask.h:327 arch/x86/kernel/smpboot.c:1570 arch/x86/kernel/smpboot.c:1585)
[   84.459047] take_cpu_down (kernel/cpu.c:855)
[   84.459649] multi_cpu_stop (./arch/x86/include/asm/atomic.h:125 ./include/asm-generic/atomic-instrumented.h:748 kernel/stop_machine.c:176 kernel/stop_machine.c:227)
[   84.460339] ? stop_machine_yield (??:?)
[   84.461078] cpu_stopper_thread (kernel/stop_machine.c:519)
[   84.461809] ? smpboot_thread_fn (kernel/smpboot.c:113)
[   84.462539] ? smpboot_thread_fn (kernel/smpboot.c:128 (discriminator 3))
[   84.463280] ? smpboot_thread_fn (kernel/smpboot.c:129)
[   84.464024] smpboot_thread_fn (kernel/smpboot.c:129)
[   84.464768] ? sort_range (kernel/smpboot.c:108)
[   84.465389] kthread (kernel/kthread.c:237)
[   84.465961] ? kthread_park (kernel/kthread.c:609)
[   84.466605] ret_from_fork (arch/x86/entry/entry_64.S:358)
[   84.467236] Modules linked in: rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver binfmt_misc intel_rapl_msr intel_rapl_common sr_mod crct10dif_pclmul cdrom crc32_pclmul sg crc32c_intel ghash_clmulni_intel ata_generic pata_acpi ppdev bochs_drm drm_vram_helper ttm drm_kms_helper syscopyarea sysfillrect snd_pcm sysimgblt fb_sys_fops drm aesni_intel snd_timer ata_piix crypto_simd snd cryptd glue_helper libata soundcore pcspkr joydev serio_raw parport_pc i2c_piix4 parport floppy ip_tables
[   84.474471] CR2: 0000000000000064
[   84.475066] ---[ end trace af8f1919a81ca744 ]---


Using that, the fail is on:

	if (need_pull_dl_task(rq, prev)) {

Which is most likely explained by the above call ending up doing a 

  dl_prio(prev->prio);

which doesn't play well with 

  class->pick_next_task(rq, NULL, NULL);


Now, this is no longer an issue (I think) with the rest of Peter's series,
since the above deref is gone with

67692435c411 ("sched: Rework pick_next_task() slow-path")

It would be interesting to know whether LKP found this on a mainline kernel
and bisected it down, or if it stumbled on this while bisecting something
else.
