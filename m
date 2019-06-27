Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A34A9C48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 14:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73B8320828
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 14:32:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbfF0OcG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 10:32:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:33522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726422AbfF0OcF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 10:32:05 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1E7620828;
        Thu, 27 Jun 2019 14:32:03 +0000 (UTC)
Date:   Thu, 27 Jun 2019 10:32:02 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        LKP <lkp@01.org>
Subject: Re: fcc784be83 [  150.952780] WARNING: held lock freed!
Message-ID: <20190627103202.2680e4e0@gandalf.local.home>
In-Reply-To: <20190619024114.GI7221@shao2-debian>
References: <20190619024114.GI7221@shao2-debian>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jun 2019 10:41:14 +0800
kernel test robot <lkp@intel.com> wrote:

> Greetings,
> 
> 0day kernel testing robot got the below dmesg and the first bad commit is
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> 
> commit fcc784be837714a9173b372ff9fb9b514590dad9
> Author:     Steven Rostedt (VMware) <rostedt@goodmis.org>
> AuthorDate: Wed Apr 4 14:06:30 2018 -0400
> Commit:     Ingo Molnar <mingo@kernel.org>
> CommitDate: Thu Jun 21 18:19:01 2018 +0200
> 
>     locking/lockdep: Do not record IRQ state within lockdep code
>     
>     While debugging where things were going wrong with mapping
>     enabling/disabling interrupts with the lockdep state and actual real
>     enabling and disabling interrupts, I had to silent the IRQ
>     disabling/enabling in debug_check_no_locks_freed() because it was
>     always showing up as it was called before the splat was.
>     
>     Use raw_local_irq_save/restore() for not only debug_check_no_locks_freed()
>     but for all internal lockdep functions, as they hide useful information
>     about where interrupts were used incorrectly last.
>     
>     Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
>     Cc: Andrew Morton <akpm@linux-foundation.org>
>     Cc: Linus Torvalds <torvalds@linux-foundation.org>
>     Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
>     Cc: Peter Zijlstra <peterz@infradead.org>
>     Cc: Thomas Gleixner <tglx@linutronix.de>
>     Cc: Will Deacon <will.deacon@arm.com>
>     Link: https://lkml.kernel.org/lkml/20180404140630.3f4f4c7a@gandalf.local.home
>     Signed-off-by: Ingo Molnar <mingo@kernel.org>
> 

I can crash with this config with and without this commit.

Are you sure the bug is with this commit? Can you consistently
reproduce the problem with the commit applied, and consistently not see
the problem with the commit removed? If not, then you should definitely
add that procedure before sending these reports, otherwise they will
start to be ignored.

-- Steve


> 03eeafdd9a  locking/rwsem: Fix up_read_non_owner() warning with DEBUG_RWSEMS
> fcc784be83  locking/lockdep: Do not record IRQ state within lockdep code
> bed3c0d84e  Merge tag 'for-5.2-rc5-tag' of git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux
> 1c6b40509d  Add linux-next specific files for 20190618
> +----------------------------------------------------------------------------------+------------+------------+------------+---------------+
> |                                                                                  | 03eeafdd9a | fcc784be83 | bed3c0d84e | next-20190618 |
> +----------------------------------------------------------------------------------+------------+------------+------------+---------------+
> | boot_successes                                                                   | 874        | 277        | 276        | 21            |
> | boot_failures                                                                    | 14         | 19         | 64         | 7             |
> | BUG:soft_lockup-CPU##stuck_for#s                                                 | 11         | 2          | 4          |               |
> | EIP:smp_call_function_single                                                     | 1          | 1          |            |               |
> | Kernel_panic-not_syncing:softlockup:hung_tasks                                   | 11         | 2          | 4          |               |
> | EIP:_raw_spin_unlock_irqrestore                                                  | 3          | 0          | 1          |               |
> | EIP:__copy_user_ll                                                               | 2          | 0          | 1          |               |
> | invoked_oom-killer:gfp_mask=0x                                                   | 1          | 2          | 1          |               |
> | Mem-Info                                                                         | 1          | 2          | 2          |               |
> | EIP:wp_page_copy                                                                 | 3          |            |            |               |
> | BUG:kernel_hang_in_early-boot_stage                                              | 1          |            |            |               |
> | EIP:shmem_getpage_gfp                                                            | 2          | 0          | 1          |               |
> | BUG:workqueue_lockup-pool                                                        | 1          | 0          | 1          |               |
> | BUG:kernel_hang_in_boot-around-mounting-root_stage                               | 0          | 1          |            |               |
> | Out_of_memory:Kill_process                                                       | 0          | 1          |            |               |
> | WARNING:held_lock_freed                                                          | 0          | 13         | 58         | 7             |
> | is_freeing_memory#-#,with_a_lock_still_held_there                                | 0          | 13         | 58         | 7             |
> | BUG:kernel_hang_in_early-boot_stage,last_printk:early_console_in_setup_code      | 0          | 1          |            |               |
> | EIP:rcu_is_watching                                                              | 0          | 1          |            |               |
> | EIP:ring_buffer_consume                                                          | 0          | 0          | 1          |               |
> | page_allocation_failure:order:#,mode:#(GFP_KERNEL|__GFP_NORETRY),nodemask=(null) | 0          | 0          | 1          |               |
> | BUG:unable_to_handle_page_fault_for_address                                      | 0          | 0          | 1          |               |
> | Oops:#[##]                                                                       | 0          | 0          | 1          |               |
> | EIP:debug_check_no_locks_freed                                                   | 0          | 0          | 1          |               |
> | Kernel_panic-not_syncing:Fatal_exception                                         | 0          | 0          | 1          |               |
> +----------------------------------------------------------------------------------+------------+------------+------------+---------------+
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <lkp@intel.com>
> 
> [  147.470176] init: tty3 main process (364) terminated with status 1
> [  147.497211] init: tty3 main process ended, respawning
> [  147.612415] init: tty6 main process (365) terminated with status 1
> [  147.687364] init: tty6 main process ended, respawning
> [  150.937355] 
> [  150.941927] =========================
> [  150.952780] WARNING: held lock freed!
> [  150.963993] 4.17.0-09747-gfcc784b #1 Tainted: G                T
> [  150.989489] -------------------------
> [  151.005112] trinity-main/356 is freeing memory ce93de20-ce93de47, with a lock still held there!
> [  151.040984] (ptrval) (&wq#3){....}, at: __wake_up_common_lock+0x5a/0x140
> [  151.069147] 1 lock held by trinity-main/356:
> [  151.087139]  #0: (ptrval) (&sb->s_type->i_mutex_key){....}, at: iterate_dir+0x42/0x2a0
> [  151.117861] 
> [  151.117861] stack backtrace:
> [  151.132116] CPU: 1 PID: 356 Comm: trinity-main Tainted: G                T 4.17.0-09747-gfcc784b #1
> [  151.162025] Call Trace:
> [  151.170423]  dump_stack+0x2bc/0x41a
> [  151.182441]  debug_check_no_locks_freed+0x354/0x370
> [  151.199065]  __raw_spin_lock_init+0x29/0x80
> [  151.214099]  __init_waitqueue_head+0x2e/0x70
> [  151.228615]  ? proc_tgid_base_lookup+0x40/0x40
> [  151.243819]  proc_fill_cache+0x118/0x360
> [  151.256974]  ? format_decode+0x1a6/0x890
> [  151.270037]  ? format_decode+0x308/0x890
> [  151.283679]  ? vsnprintf+0x622/0x860
> [  151.293724]  proc_map_files_readdir+0x648/0x6a0
> [  151.306619]  ? proc_tgid_base_lookup+0x40/0x40
> [  151.320722]  iterate_dir+0x225/0x2a0
> [  151.331637]  ? __fget_light+0x7f/0x100
> [  151.342010]  ksys_getdents64+0x1ac/0x2f0
> [  151.353610]  ? sys_old_readdir+0x160/0x160
> [  151.366017]  sys_getdents64+0x24/0x40
> [  151.377653]  do_fast_syscall_32+0x14b/0x780
> [  151.392209]  entry_SYSENTER_32+0x53/0x86
> [  151.404786] EIP: 0xa7fc4cd9
> [  151.423581] Code: 08 8b 80 5c cd ff ff 85 d2 74 02 89 02 5d c3 8b 04 24 c3 8b 0c 24 c3 8b 1c 24 c3 8b 3c 24 c3 90 90 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d 76 00 58 b8 77 00 00 00 cd 80 90 8d 76 
> [  151.547420] EAX: ffffffda EBX: 0000002b ECX: 08aefedc EDX: 00008000
> [  151.586666] ESI: 08aefedc EDI: ffffffd0 EBP: 00000026 ESP: af88aac4
> [  151.605753] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000246
> [main] Added 10680 filenames from /proc
> [main] Added 13148 filenames from /proc
> [main] Added 13151 filenames from /proc
> [  156.784347] init: tty4 main process (366) terminated with status 1
> [  156.849880] init: tty4 main process ended, respawning
> 
>                                                           # HH:MM RESULT GOOD BAD GOOD_BUT_DIRTY DIRTY_NOT_BAD
> git bisect start v4.18 v4.17 --
> git bisect  bad c81b995f00c7a1c2ca9ad67f5bb4a50d02f98f84  # 23:06  B      6     1    0   0  Merge branch 'perf-urgent-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> git bisect good 2a70ea5cda00214a1d573acf19fa0cd06d947e38  # 23:43  G    205     0    9   9  Merge tag 'hsi-for-4.18' of git://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-hsi
> git bisect good e7655d2b25466c534ed1f539367dae595bb0bd20  # 00:13  G    209     0   15  15  Merge tag 'for-4.18-part2-tag' of git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux
> git bisect good 6d90eb7ba341b3eb035121eff0b69d370cbc251e  # 00:44  G    206     0   18  18  Merge tag 'dma-rename-4.18' of git://git.infradead.org/users/hch/dma-mapping
> git bisect good 5e2204832b20ef9db859dd6a2e955ac3e33eef27  # 01:07  G    212     0    9   9  Merge tag 'powerpc-4.18-2' of git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux
> git bisect good 6242258b6b472f8fdd8ed9b735cc1190c185d16d  # 01:37  G    206     0   24  24  Merge branch 'timers-urgent-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> git bisect  bad d4e860eaf0584dfcc1375e06eeb34f85f43c8d34  # 02:10  B     36     1    4   4  Merge branch 'x86-urgent-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> git bisect  bad 2da2ca24a38f0200111e3b8823c08d02cb59d362  # 03:07  B     90     1    7   7  Merge branch 'locking-urgent-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> git bisect good a43de489934cadcbc4cc08a6590fdcc833768461  # 04:05  G    302     0   21  21  Merge branch 'ras-urgent-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> git bisect good 7ea959c45769612aa92557fb6464679f5fec7d9e  # 04:37  G    306     0   18  18  locking/refcounts: Implement refcount_dec_and_lock_irqsave()
> git bisect  bad fcc784be837714a9173b372ff9fb9b514590dad9  # 06:19  B     19     1    3   3  locking/lockdep: Do not record IRQ state within lockdep code
> git bisect good 03eeafdd9ab06a770d42c2b264d50dff7e2f4eee  # 06:47  G    305     0   18  18  locking/rwsem: Fix up_read_non_owner() warning with DEBUG_RWSEMS
> # first bad commit: [fcc784be837714a9173b372ff9fb9b514590dad9] locking/lockdep: Do not record IRQ state within lockdep code
> git bisect good 03eeafdd9ab06a770d42c2b264d50dff7e2f4eee  # 07:23  G    904     0   40  58  locking/rwsem: Fix up_read_non_owner() warning with DEBUG_RWSEMS
> # extra tests on HEAD of internal-eywa/master
> git bisect  bad b4c6b079156ebc029114a45812d5e5298f51fa01  # 07:23  B      8     3    0   2  Intel Next: Add release files for v5.2-rc5 2019-06-17
> # extra tests on tree/branch linus/master
> git bisect  bad bed3c0d84e7e25c8e0964d297794f4c215b01f33  # 08:52  B      5     2    0   0  Merge tag 'for-5.2-rc5-tag' of git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux
> # extra tests with first bad commit reverted
> git bisect  bad b0f031ad2fd0758b5bb7c58afe7f8bbaab65c265  # 09:42  B    126     2   10  10  Revert "locking/lockdep: Do not record IRQ state within lockdep code"
> # extra tests on tree/branch linux-next/master
> git bisect  bad 1c6b40509daf5190b1fd2c758649f7df1da4827b  # 10:20  B      9     2    0   0  Add linux-next specific files for 20190618
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/lkp                          Intel Corporation

