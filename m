Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UPPERCASE_50_75,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFC67C31E51
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 02:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D517206B7
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 02:41:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730290AbfFSClL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 22:41:11 -0400
Received: from mga17.intel.com ([192.55.52.151]:59030 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726037AbfFSClL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 22:41:11 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jun 2019 19:41:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,391,1557212400"; 
   d="gz'50?scan'50,208,50";a="162072352"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.6])
  by orsmga003.jf.intel.com with ESMTP; 18 Jun 2019 19:41:03 -0700
Date:   Wed, 19 Jun 2019 10:41:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        LKP <lkp@01.org>
Subject: fcc784be83 [  150.952780] WARNING: held lock freed!
Message-ID: <20190619024114.GI7221@shao2-debian>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="itqfrb9Qq3wY07cp"
Content-Disposition: inline
User-Agent: Heirloom mailx 12.5 6/20/10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--itqfrb9Qq3wY07cp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Greetings,

0day kernel testing robot got the below dmesg and the first bad commit is

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

commit fcc784be837714a9173b372ff9fb9b514590dad9
Author:     Steven Rostedt (VMware) <rostedt@goodmis.org>
AuthorDate: Wed Apr 4 14:06:30 2018 -0400
Commit:     Ingo Molnar <mingo@kernel.org>
CommitDate: Thu Jun 21 18:19:01 2018 +0200

    locking/lockdep: Do not record IRQ state within lockdep code
    
    While debugging where things were going wrong with mapping
    enabling/disabling interrupts with the lockdep state and actual real
    enabling and disabling interrupts, I had to silent the IRQ
    disabling/enabling in debug_check_no_locks_freed() because it was
    always showing up as it was called before the splat was.
    
    Use raw_local_irq_save/restore() for not only debug_check_no_locks_freed()
    but for all internal lockdep functions, as they hide useful information
    about where interrupts were used incorrectly last.
    
    Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
    Cc: Andrew Morton <akpm@linux-foundation.org>
    Cc: Linus Torvalds <torvalds@linux-foundation.org>
    Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Cc: Thomas Gleixner <tglx@linutronix.de>
    Cc: Will Deacon <will.deacon@arm.com>
    Link: https://lkml.kernel.org/lkml/20180404140630.3f4f4c7a@gandalf.local.home
    Signed-off-by: Ingo Molnar <mingo@kernel.org>

03eeafdd9a  locking/rwsem: Fix up_read_non_owner() warning with DEBUG_RWSEMS
fcc784be83  locking/lockdep: Do not record IRQ state within lockdep code
bed3c0d84e  Merge tag 'for-5.2-rc5-tag' of git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux
1c6b40509d  Add linux-next specific files for 20190618
+----------------------------------------------------------------------------------+------------+------------+------------+---------------+
|                                                                                  | 03eeafdd9a | fcc784be83 | bed3c0d84e | next-20190618 |
+----------------------------------------------------------------------------------+------------+------------+------------+---------------+
| boot_successes                                                                   | 874        | 277        | 276        | 21            |
| boot_failures                                                                    | 14         | 19         | 64         | 7             |
| BUG:soft_lockup-CPU##stuck_for#s                                                 | 11         | 2          | 4          |               |
| EIP:smp_call_function_single                                                     | 1          | 1          |            |               |
| Kernel_panic-not_syncing:softlockup:hung_tasks                                   | 11         | 2          | 4          |               |
| EIP:_raw_spin_unlock_irqrestore                                                  | 3          | 0          | 1          |               |
| EIP:__copy_user_ll                                                               | 2          | 0          | 1          |               |
| invoked_oom-killer:gfp_mask=0x                                                   | 1          | 2          | 1          |               |
| Mem-Info                                                                         | 1          | 2          | 2          |               |
| EIP:wp_page_copy                                                                 | 3          |            |            |               |
| BUG:kernel_hang_in_early-boot_stage                                              | 1          |            |            |               |
| EIP:shmem_getpage_gfp                                                            | 2          | 0          | 1          |               |
| BUG:workqueue_lockup-pool                                                        | 1          | 0          | 1          |               |
| BUG:kernel_hang_in_boot-around-mounting-root_stage                               | 0          | 1          |            |               |
| Out_of_memory:Kill_process                                                       | 0          | 1          |            |               |
| WARNING:held_lock_freed                                                          | 0          | 13         | 58         | 7             |
| is_freeing_memory#-#,with_a_lock_still_held_there                                | 0          | 13         | 58         | 7             |
| BUG:kernel_hang_in_early-boot_stage,last_printk:early_console_in_setup_code      | 0          | 1          |            |               |
| EIP:rcu_is_watching                                                              | 0          | 1          |            |               |
| EIP:ring_buffer_consume                                                          | 0          | 0          | 1          |               |
| page_allocation_failure:order:#,mode:#(GFP_KERNEL|__GFP_NORETRY),nodemask=(null) | 0          | 0          | 1          |               |
| BUG:unable_to_handle_page_fault_for_address                                      | 0          | 0          | 1          |               |
| Oops:#[##]                                                                       | 0          | 0          | 1          |               |
| EIP:debug_check_no_locks_freed                                                   | 0          | 0          | 1          |               |
| Kernel_panic-not_syncing:Fatal_exception                                         | 0          | 0          | 1          |               |
+----------------------------------------------------------------------------------+------------+------------+------------+---------------+

If you fix the issue, kindly add following tag
Reported-by: kernel test robot <lkp@intel.com>

[  147.470176] init: tty3 main process (364) terminated with status 1
[  147.497211] init: tty3 main process ended, respawning
[  147.612415] init: tty6 main process (365) terminated with status 1
[  147.687364] init: tty6 main process ended, respawning
[  150.937355] 
[  150.941927] =========================
[  150.952780] WARNING: held lock freed!
[  150.963993] 4.17.0-09747-gfcc784b #1 Tainted: G                T
[  150.989489] -------------------------
[  151.005112] trinity-main/356 is freeing memory ce93de20-ce93de47, with a lock still held there!
[  151.040984] (ptrval) (&wq#3){....}, at: __wake_up_common_lock+0x5a/0x140
[  151.069147] 1 lock held by trinity-main/356:
[  151.087139]  #0: (ptrval) (&sb->s_type->i_mutex_key){....}, at: iterate_dir+0x42/0x2a0
[  151.117861] 
[  151.117861] stack backtrace:
[  151.132116] CPU: 1 PID: 356 Comm: trinity-main Tainted: G                T 4.17.0-09747-gfcc784b #1
[  151.162025] Call Trace:
[  151.170423]  dump_stack+0x2bc/0x41a
[  151.182441]  debug_check_no_locks_freed+0x354/0x370
[  151.199065]  __raw_spin_lock_init+0x29/0x80
[  151.214099]  __init_waitqueue_head+0x2e/0x70
[  151.228615]  ? proc_tgid_base_lookup+0x40/0x40
[  151.243819]  proc_fill_cache+0x118/0x360
[  151.256974]  ? format_decode+0x1a6/0x890
[  151.270037]  ? format_decode+0x308/0x890
[  151.283679]  ? vsnprintf+0x622/0x860
[  151.293724]  proc_map_files_readdir+0x648/0x6a0
[  151.306619]  ? proc_tgid_base_lookup+0x40/0x40
[  151.320722]  iterate_dir+0x225/0x2a0
[  151.331637]  ? __fget_light+0x7f/0x100
[  151.342010]  ksys_getdents64+0x1ac/0x2f0
[  151.353610]  ? sys_old_readdir+0x160/0x160
[  151.366017]  sys_getdents64+0x24/0x40
[  151.377653]  do_fast_syscall_32+0x14b/0x780
[  151.392209]  entry_SYSENTER_32+0x53/0x86
[  151.404786] EIP: 0xa7fc4cd9
[  151.423581] Code: 08 8b 80 5c cd ff ff 85 d2 74 02 89 02 5d c3 8b 04 24 c3 8b 0c 24 c3 8b 1c 24 c3 8b 3c 24 c3 90 90 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d 76 00 58 b8 77 00 00 00 cd 80 90 8d 76 
[  151.547420] EAX: ffffffda EBX: 0000002b ECX: 08aefedc EDX: 00008000
[  151.586666] ESI: 08aefedc EDI: ffffffd0 EBP: 00000026 ESP: af88aac4
[  151.605753] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000246
[main] Added 10680 filenames from /proc
[main] Added 13148 filenames from /proc
[main] Added 13151 filenames from /proc
[  156.784347] init: tty4 main process (366) terminated with status 1
[  156.849880] init: tty4 main process ended, respawning

                                                          # HH:MM RESULT GOOD BAD GOOD_BUT_DIRTY DIRTY_NOT_BAD
git bisect start v4.18 v4.17 --
git bisect  bad c81b995f00c7a1c2ca9ad67f5bb4a50d02f98f84  # 23:06  B      6     1    0   0  Merge branch 'perf-urgent-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect good 2a70ea5cda00214a1d573acf19fa0cd06d947e38  # 23:43  G    205     0    9   9  Merge tag 'hsi-for-4.18' of git://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-hsi
git bisect good e7655d2b25466c534ed1f539367dae595bb0bd20  # 00:13  G    209     0   15  15  Merge tag 'for-4.18-part2-tag' of git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux
git bisect good 6d90eb7ba341b3eb035121eff0b69d370cbc251e  # 00:44  G    206     0   18  18  Merge tag 'dma-rename-4.18' of git://git.infradead.org/users/hch/dma-mapping
git bisect good 5e2204832b20ef9db859dd6a2e955ac3e33eef27  # 01:07  G    212     0    9   9  Merge tag 'powerpc-4.18-2' of git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux
git bisect good 6242258b6b472f8fdd8ed9b735cc1190c185d16d  # 01:37  G    206     0   24  24  Merge branch 'timers-urgent-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect  bad d4e860eaf0584dfcc1375e06eeb34f85f43c8d34  # 02:10  B     36     1    4   4  Merge branch 'x86-urgent-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect  bad 2da2ca24a38f0200111e3b8823c08d02cb59d362  # 03:07  B     90     1    7   7  Merge branch 'locking-urgent-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect good a43de489934cadcbc4cc08a6590fdcc833768461  # 04:05  G    302     0   21  21  Merge branch 'ras-urgent-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect good 7ea959c45769612aa92557fb6464679f5fec7d9e  # 04:37  G    306     0   18  18  locking/refcounts: Implement refcount_dec_and_lock_irqsave()
git bisect  bad fcc784be837714a9173b372ff9fb9b514590dad9  # 06:19  B     19     1    3   3  locking/lockdep: Do not record IRQ state within lockdep code
git bisect good 03eeafdd9ab06a770d42c2b264d50dff7e2f4eee  # 06:47  G    305     0   18  18  locking/rwsem: Fix up_read_non_owner() warning with DEBUG_RWSEMS
# first bad commit: [fcc784be837714a9173b372ff9fb9b514590dad9] locking/lockdep: Do not record IRQ state within lockdep code
git bisect good 03eeafdd9ab06a770d42c2b264d50dff7e2f4eee  # 07:23  G    904     0   40  58  locking/rwsem: Fix up_read_non_owner() warning with DEBUG_RWSEMS
# extra tests on HEAD of internal-eywa/master
git bisect  bad b4c6b079156ebc029114a45812d5e5298f51fa01  # 07:23  B      8     3    0   2  Intel Next: Add release files for v5.2-rc5 2019-06-17
# extra tests on tree/branch linus/master
git bisect  bad bed3c0d84e7e25c8e0964d297794f4c215b01f33  # 08:52  B      5     2    0   0  Merge tag 'for-5.2-rc5-tag' of git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux
# extra tests with first bad commit reverted
git bisect  bad b0f031ad2fd0758b5bb7c58afe7f8bbaab65c265  # 09:42  B    126     2   10  10  Revert "locking/lockdep: Do not record IRQ state within lockdep code"
# extra tests on tree/branch linux-next/master
git bisect  bad 1c6b40509daf5190b1fd2c758649f7df1da4827b  # 10:20  B      9     2    0   0  Add linux-next specific files for 20190618

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/lkp                          Intel Corporation

--itqfrb9Qq3wY07cp
Content-Type: application/gzip
Content-Disposition: attachment; filename="dmesg-quantal-vm-quantal-803:20190619061900:i386-randconfig-w0-06181652:4.17.0-09747-gfcc784b:1.gz"
Content-Transfer-Encoding: base64

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
KeKkV4vpfDBdpQky/zdtg2ijnYNquiCOVV2yrrhntQiwTDyB0Qm2IhOUp5Z/f9/IKg2t+vTi
7DTqu5V82jKddX3jOOPoMSAOimmPDhOWG5G0C7LqcHa3hXFQiowGJh2l4Zbp50vaOr2Ipkm8
lPShhI8bNRG79V3iMzpdl05AasRgGt2VVpN49rnSXflSLU5f3P8Tv+pJGh0gH+OryBxyFM3g
crge068uf88Ld/We+z2qIDVp6YjZaN/UvS/LeyiREkqkiN1Jk0OJlFAiJZRICSVSQomUUCLl
gQ5CiRQRSqRsMZtQIiWUSHF/JrsPi1Ai5SGYUCJlCz+USAklUkKJlFAiJZRICSVSds1QKJES
SqSEEimhRMqm/hNKpFSfLpRICSVSQomUUCIllEgJJVJCiZRQIqUBEEqkhBIpoUTK7xpTKJES
SqSEEiltyFAipd0slEgJJVJCiZRQIiWUSAklUkKJlCchhxIpoURKKJFyT9tQIiWUSAklUhxE
KJESSqSEEimhREookVKZJkOJlFAiJZRICSVSQomUUCIllEgJJVKqfkKJlFAiJZRICSVSQomU
UCIllEgJJVJCiZStWQklUkKJlFAiJZRICSVSQomUUCIllEgJJVJCiZRQIiWUSAklUkKJlAoo
lEgJJVJqeTKUSAklUkKJlFAiJZRICSVSQomU/2clUqidRVyuetaukR1a6H18SPJpCjnqluQq
4nAc8FDTZwahVPfTi/30mU0QH3OyvuWcUy7dRGkh61WtYMbCi++7ysxgJG2njw0FJAISADMI
paX1AKiynlBVT6h+/ISWY1heDjhJQsfYiP8IDos1WstMppr0XpoqeuOBe1XXeEQ/rK7BHHru
sOdjBH+VJsPrIbEhJyQYkpekEal61uFnUsbYto+cQoPIcPbG1wvgAzjXaI5g6lVeNcP5KiD0
zGedr3PcNbjxVRlKS/dXOhW5uZWk/JK4T6gcDNiZIjkSsSRsyytqO+NrtzmimV+de5I0Zi7W
n95MaZ1Eb4eXRXSseEtXETvR1y59B2qM3CoHx3yXfdtK7RDhlJcx3HFfcHjmy5dr01PRgRTp
3nMnztKtcwdgaSqxUXJ4ycrI+YP3L6KL9+9e4r8Q2I5+SjmQxtcsYKRk50vaOT8q3daEJ0un
Wom3eUVfZhnSaYnYR+gv6fUbYe0xwialxhe538VVXVzGiuJ7h45Uk35qLJgG973hqYzy1TWN
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
AQA=

--itqfrb9Qq3wY07cp
Content-Type: application/gzip
Content-Disposition: attachment; filename="dmesg-quantal-vm-quantal-09ce24fb9434:20190619064856:i386-randconfig-w0-06181652:4.17.0-09746-g03eeafd:1.gz"
Content-Transfer-Encoding: base64

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
6iD7dib4/p217IM/39keE/jL2e315fWP3377rUkOQMwC/l7YQUDfYxB/4D/ni9EMVudT87Ax
qJfHYDgPURpdlLMT4L/9yo7bq6vw5a5uMP/fiiwC8OVFFBzWwz5LhX4SpUp4EgeMnfSebPTx
gS+0R3dvC42OHfgq8R7fBWMh6V1AnhUiPLCH5OUerkZ4emAXh2HL4GXsn0ZLG2n8Z0Yv92I+
JusJXqGe4B0LWLMp9nZYT3ssWxFpkH5NTxTcd1gP+zDtcZaZw2S2QI8Zbr/NTvY/SeIwQsOa
O+DukIP0ZxhUvyzPbLz8gEa+drYY4UKL4SO95joMgzJ6XzGKrTJZKEHrXBh9uhIJDzgRD0J0
WFhTJ6U2QMaFt7CD3+UwZieYHPcNU6cUytjpdVcD+KdJpvbKJEChfs8cpArwLNzMl/BcwQ1f
rcpXqwrqM9j7alW+WpWvVuWrVflqVb5a1Qsd+GpVZQe+WpVp5qtV+WpV9s+w/qjw1apegvHV
qrbwfbUqX63KV6vy1ap8tSpfrapuhny1Kl+tyler8tWq1vUfX62q+HS+WpWvVuWrVflqVb5a
la9W5atV0Th9tSpfrcpXq/LVqo43Jl+tyler8tWqNiF9tarNZr5ala9W5atV+WpVvlqVr1bl
q1UdhOyrVflqVb5a1TNtfbUqX63KV6uyEL5ala9W5atV+WpVvlqVNU36alW+WtVGX75ala9W
5atV+WpVvlqVr1blq1X5alW+WpWvVrWO4atV+WpVvlqVr1blq1X5alW+WpWvVmVpfbUqX63K
V6vy1ap8tSpfrcpXq9pG89WqmK9W5atV+WpVvlqVr1ZVovhqVb5ala9W5atVWTRfrcpXq6ID
2Ver8tWqfLUqX63qoB58tSpfrer/dbUqbAcnMbqAj9W1wCDBOEDpfleqBmjGBYhn8efCKouN
uOtZuJ7l3j3zUCbHhgRlGB0017Np43GG14rGZRUW63175E3pmusY7zRQ2G9jhHnQQH7Eb38P
bad0wz7Diwtvrh1JHEQgy7VH4xFMGfvQ7eXsXNC6KWLz2GMThJiQNzGN0sk5pa3Y9pyViLDa
0SfyBbWJbPF6pdIA477jneq7TuIt9Z3Awggv2GV4tNlLMie3r1jr9uY1/hfeYcF+rEIP46sW
LBO88SVuXJ/Z6BfC01GkS7z1bBw8SZIGpeQoLuMs4PUrN1gAQHPBhfi8w+1e5CjAL09XjAvS
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
/4Zfv/j/tbNaCphiAwA=

--itqfrb9Qq3wY07cp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="reproduce-quantal-vm-quantal-803:20190619061900:i386-randconfig-w0-06181652:4.17.0-09747-gfcc784b:1"

#!/bin/bash

kernel=$1
initrd=quantal-trinity-i386.cgz

wget --no-clobber https://download.01.org/0day-ci/lkp-qemu/osimage/quantal/$initrd

kvm=(
	qemu-system-x86_64
	-enable-kvm
	-cpu kvm64
	-kernel $kernel
	-initrd $initrd
	-m 512
	-smp 2
	-device e1000,netdev=net0
	-netdev user,id=net0
	-boot order=nc
	-no-reboot
	-watchdog i6300esb
	-watchdog-action debug
	-rtc base=localtime
	-serial stdio
	-display none
	-monitor null
)

append=(
	root=/dev/ram0
	hung_task_panic=1
	debug
	apic=debug
	sysrq_always_enabled
	rcupdate.rcu_cpu_stall_timeout=100
	net.ifnames=0
	printk.devkmsg=on
	panic=-1
	softlockup_panic=1
	nmi_watchdog=panic
	oops=panic
	load_ramdisk=2
	prompt_ramdisk=0
	drbd.minor_count=8
	systemd.log_level=err
	ignore_loglevel
	console=tty0
	earlyprintk=ttyS0,115200
	console=ttyS0,115200
	vga=normal
	rw
	drbd.minor_count=8
	rcuperf.shutdown=0
)

"${kvm[@]}" -append "${append[*]}"

--itqfrb9Qq3wY07cp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-4.17.0-09747-gfcc784b"

#
# Automatically generated file; DO NOT EDIT.
# Linux/i386 4.17.0 Kernel Configuration
#

#
# Compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
#
CONFIG_X86_32=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf32-i386"
CONFIG_ARCH_DEFCONFIG="arch/x86/configs/i386_defconfig"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_BITS_MAX=16
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_FILTER_PGPROT=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_X86_32_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=2
CONFIG_CONSTRUCTORS=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_EXTABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
CONFIG_KERNEL_GZIP=y
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
# CONFIG_POSIX_MQUEUE is not set
# CONFIG_CROSS_MEMORY_ATTACH is not set
# CONFIG_USELIB is not set
# CONFIG_AUDIT is not set
CONFIG_HAVE_ARCH_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_GENERIC_IRQ_CHIP=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_DATA=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y

#
# Timers subsystem
#
CONFIG_HZ_PERIODIC=y
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ=y
# CONFIG_HIGH_RES_TIMERS is not set

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
CONFIG_IRQ_TIME_ACCOUNTING=y
# CONFIG_BSD_PROCESS_ACCT is not set
# CONFIG_TASKSTATS is not set
# CONFIG_CPU_ISOLATION is not set

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_BUILD_BIN2C=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_LOG_BUF_SHIFT=20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CGROUPS=y
# CONFIG_MEMCG is not set
# CONFIG_CGROUP_SCHED is not set
# CONFIG_CGROUP_PIDS is not set
# CONFIG_CGROUP_RDMA is not set
# CONFIG_CGROUP_FREEZER is not set
# CONFIG_CPUSETS is not set
# CONFIG_CGROUP_DEVICE is not set
# CONFIG_CGROUP_CPUACCT is not set
# CONFIG_CGROUP_PERF is not set
# CONFIG_CGROUP_BPF is not set
# CONFIG_CGROUP_DEBUG is not set
# CONFIG_NAMESPACES is not set
# CONFIG_SCHED_AUTOGROUP is not set
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SYSCTL=y
CONFIG_ANON_INODES=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_BPF=y
CONFIG_EXPERT=y
CONFIG_UID16=y
CONFIG_MULTIUSER=y
# CONFIG_SGETMASK_SYSCALL is not set
CONFIG_SYSFS_SYSCALL=y
# CONFIG_SYSCTL_SYSCALL is not set
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_PCSPKR_PLATFORM=y
# CONFIG_BASE_FULL is not set
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
# CONFIG_EVENTFD is not set
CONFIG_SHMEM=y
CONFIG_AIO=y
# CONFIG_ADVISE_SYSCALLS is not set
# CONFIG_MEMBARRIER is not set
# CONFIG_CHECKPOINT_RESTORE is not set
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_BPF_SYSCALL=y
CONFIG_USERFAULTFD=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
# CONFIG_RSEQ is not set
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_PC104=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# CONFIG_VM_EVENT_COUNTERS is not set
CONFIG_COMPAT_BRK=y
# CONFIG_SLAB is not set
# CONFIG_SLUB is not set
CONFIG_SLOB=y
# CONFIG_SLAB_MERGE_DEFAULT is not set
CONFIG_PROFILING=y
CONFIG_TRACEPOINTS=y
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_OPROFILE=m
CONFIG_OPROFILE_EVENT_MULTIPLEX=y
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
CONFIG_KPROBES=y
# CONFIG_JUMP_LABEL is not set
CONFIG_OPTPROBES=y
CONFIG_KPROBES_ON_FTRACE=y
CONFIG_UPROBES=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_KRETPROBES=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_RCU_TABLE_FREE=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_IPC_PARSE_VERSION=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP_FILTER=y
CONFIG_HAVE_GCC_PLUGINS=y
CONFIG_GCC_PLUGINS=y
# CONFIG_GCC_PLUGIN_CYC_COMPLEXITY is not set
CONFIG_GCC_PLUGIN_LATENT_ENTROPY=y
CONFIG_GCC_PLUGIN_STRUCTLEAK=y
# CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL is not set
# CONFIG_GCC_PLUGIN_STRUCTLEAK_VERBOSE is not set
CONFIG_GCC_PLUGIN_RANDSTRUCT=y
# CONFIG_GCC_PLUGIN_RANDSTRUCT_PERFORMANCE is not set
CONFIG_HAVE_CC_STACKPROTECTOR=y
# CONFIG_CC_STACKPROTECTOR_NONE is not set
# CONFIG_CC_STACKPROTECTOR_REGULAR is not set
# CONFIG_CC_STACKPROTECTOR_STRONG is not set
CONFIG_CC_STACKPROTECTOR_AUTO=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_REL=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=8
CONFIG_HAVE_COPY_THREAD_TLS=y
CONFIG_ISA_BUS_API=y
CONFIG_CLONE_BACKWARDS=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_OLD_SIGACTION=y
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_ARCH_HAS_REFCOUNT=y
# CONFIG_REFCOUNT_FULL is not set

#
# GCOV-based kernel profiling
#
CONFIG_GCOV_KERNEL=y
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
CONFIG_GCOV_PROFILE_ALL=y
CONFIG_GCOV_FORMAT_AUTODETECT=y
# CONFIG_GCOV_FORMAT_3_4 is not set
# CONFIG_GCOV_FORMAT_4_7 is not set
CONFIG_HAVE_GENERIC_DMA_COHERENT=y
CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=1
CONFIG_MODULES=y
CONFIG_MODULE_FORCE_LOAD=y
# CONFIG_MODULE_UNLOAD is not set
CONFIG_MODVERSIONS=y
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_MODULE_SIG is not set
# CONFIG_MODULE_COMPRESS is not set
CONFIG_MODULES_TREE_LOOKUP=y
# CONFIG_BLOCK is not set
CONFIG_ASN1=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y

#
# Processor type and features
#
CONFIG_ZONE_DMA=y
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_MPPARSE=y
CONFIG_GOLDFISH=y
CONFIG_RETPOLINE=y
# CONFIG_INTEL_RDT is not set
# CONFIG_X86_BIGSMP is not set
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_MID is not set
# CONFIG_X86_INTEL_QUARK is not set
# CONFIG_X86_INTEL_LPSS is not set
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
# CONFIG_IOSF_MBI is not set
# CONFIG_X86_RDC321X is not set
CONFIG_X86_32_NON_STANDARD=y
# CONFIG_STA2X11 is not set
CONFIG_X86_32_IRIS=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
CONFIG_PARAVIRT_DEBUG=y
# CONFIG_PARAVIRT_SPINLOCKS is not set
CONFIG_KVM_GUEST=y
# CONFIG_KVM_DEBUG_FS is not set
# CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
CONFIG_PARAVIRT_CLOCK=y
CONFIG_NO_BOOTMEM=y
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
CONFIG_M686=y
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUMM is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MEFFICEON is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MELAN is not set
# CONFIG_MGEODEGX1 is not set
# CONFIG_MGEODE_LX is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_MVIAC7 is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_X86_GENERIC=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=6
CONFIG_X86_DEBUGCTLMSR=y
# CONFIG_PROCESSOR_SELECT is not set
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_CYRIX_32=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_TRANSMETA_32=y
CONFIG_CPU_SUP_UMC_32=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
# CONFIG_DMI is not set
CONFIG_NR_CPUS_RANGE_BEGIN=2
CONFIG_NR_CPUS_RANGE_END=8
CONFIG_NR_CPUS_DEFAULT=8
CONFIG_NR_CPUS=8
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
CONFIG_SCHED_MC_PRIO=y
CONFIG_PREEMPT_NONE=y
# CONFIG_PREEMPT_VOLUNTARY is not set
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
# CONFIG_X86_MCE is not set

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=y
CONFIG_PERF_EVENTS_INTEL_RAPL=y
CONFIG_PERF_EVENTS_INTEL_CSTATE=y
CONFIG_PERF_EVENTS_AMD_POWER=y
CONFIG_X86_LEGACY_VM86=y
CONFIG_VM86=y
CONFIG_TOSHIBA=m
CONFIG_I8K=y
# CONFIG_X86_REBOOTFIXUPS is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set
# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=y
# CONFIG_HIGHMEM64G is not set
# CONFIG_VMSPLIT_3G is not set
CONFIG_VMSPLIT_3G_OPT=y
# CONFIG_VMSPLIT_2G is not set
# CONFIG_VMSPLIT_2G_OPT is not set
# CONFIG_VMSPLIT_1G is not set
CONFIG_PAGE_OFFSET=0xB0000000
CONFIG_HIGHMEM=y
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ILLEGAL_POINTER_VALUE=0
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_FLATMEM_MANUAL=y
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_FLATMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
CONFIG_SPARSEMEM_STATIC=y
CONFIG_HAVE_MEMBLOCK=y
CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
CONFIG_HAVE_GENERIC_GUP=y
CONFIG_ARCH_DISCARD_MEMBLOCK=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_MEMORY_BALLOON=y
# CONFIG_COMPACTION is not set
CONFIG_MIGRATION=y
CONFIG_VIRT_TO_BUS=y
# CONFIG_KSM is not set
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
# CONFIG_TRANSPARENT_HUGEPAGE is not set
# CONFIG_CLEANCACHE is not set
CONFIG_CMA=y
# CONFIG_CMA_DEBUG is not set
# CONFIG_CMA_DEBUGFS is not set
CONFIG_CMA_AREAS=7
CONFIG_ZPOOL=m
# CONFIG_ZBUD is not set
# CONFIG_Z3FOLD is not set
CONFIG_ZSMALLOC=y
# CONFIG_PGTABLE_MAPPING is not set
# CONFIG_ZSMALLOC_STAT is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
# CONFIG_IDLE_PAGE_TRACKING is not set
CONFIG_FRAME_VECTOR=y
CONFIG_PERCPU_STATS=y
# CONFIG_GUP_BENCHMARK is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
# CONFIG_HIGHPTE is not set
# CONFIG_X86_CHECK_BIOS_CORRUPTION is not set
CONFIG_X86_RESERVE_LOW=64
# CONFIG_MTRR is not set
CONFIG_ARCH_RANDOM=y
# CONFIG_X86_SMAP is not set
CONFIG_X86_INTEL_UMIP=y
# CONFIG_EFI is not set
CONFIG_SECCOMP=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
CONFIG_HZ_300=y
# CONFIG_HZ_1000 is not set
CONFIG_HZ=300
CONFIG_KEXEC=y
CONFIG_CRASH_DUMP=y
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
# CONFIG_RANDOMIZE_BASE is not set
CONFIG_X86_NEED_RELOCS=y
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_HOTPLUG_CPU=y
CONFIG_BOOTPARAM_HOTPLUG_CPU0=y
# CONFIG_DEBUG_HOTPLUG_CPU0 is not set
# CONFIG_COMPAT_VDSO is not set
# CONFIG_CMDLINE_BOOL is not set
# CONFIG_MODIFY_LDT_SYSCALL is not set
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y

#
# Power management and ACPI options
#
# CONFIG_SUSPEND is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
# CONFIG_PM_ADVANCED_DEBUG is not set
CONFIG_PM_CLK=y
CONFIG_WQ_POWER_EFFICIENT_DEFAULT=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
CONFIG_ACPI_DEBUGGER=y
# CONFIG_ACPI_DEBUGGER_USER is not set
# CONFIG_ACPI_SPCR_TABLE is not set
# CONFIG_ACPI_PROCFS_POWER is not set
# CONFIG_ACPI_REV_OVERRIDE_POSSIBLE is not set
# CONFIG_ACPI_EC_DEBUGFS is not set
CONFIG_ACPI_AC=m
# CONFIG_ACPI_BATTERY is not set
# CONFIG_ACPI_BUTTON is not set
CONFIG_ACPI_VIDEO=y
CONFIG_ACPI_FAN=m
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_IPMI=m
CONFIG_ACPI_HOTPLUG_CPU=y
CONFIG_ACPI_PROCESSOR_AGGREGATOR=y
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_CUSTOM_DSDT_FILE=""
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_DEBUG=y
# CONFIG_ACPI_PCI_SLOT is not set
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_SBS=y
CONFIG_ACPI_HED=y
CONFIG_ACPI_CUSTOM_METHOD=m
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
# CONFIG_ACPI_APEI is not set
# CONFIG_DPTF_POWER is not set
CONFIG_PMIC_OPREGION=y
# CONFIG_XPOWER_PMIC_OPREGION is not set
CONFIG_ACPI_CONFIGFS=m
CONFIG_X86_PM_TIMER=y
# CONFIG_SFI is not set

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
# CONFIG_CPU_FREQ_STAT is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
# CONFIG_CPU_FREQ_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_GOV_ONDEMAND is not set
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
# CONFIG_CPU_FREQ_GOV_SCHEDUTIL is not set

#
# CPU frequency scaling drivers
#
CONFIG_X86_INTEL_PSTATE=y
CONFIG_X86_PCC_CPUFREQ=y
CONFIG_X86_ACPI_CPUFREQ=y
CONFIG_X86_ACPI_CPUFREQ_CPB=y
CONFIG_X86_POWERNOW_K6=m
CONFIG_X86_POWERNOW_K7=m
CONFIG_X86_POWERNOW_K7_ACPI=y
# CONFIG_X86_POWERNOW_K8 is not set
# CONFIG_X86_GX_SUSPMOD is not set
CONFIG_X86_SPEEDSTEP_CENTRINO=m
CONFIG_X86_SPEEDSTEP_CENTRINO_TABLE=y
CONFIG_X86_SPEEDSTEP_ICH=y
# CONFIG_X86_SPEEDSTEP_SMI is not set
CONFIG_X86_P4_CLOCKMOD=y
CONFIG_X86_CPUFREQ_NFORCE2=y
CONFIG_X86_LONGRUN=y
# CONFIG_X86_LONGHAUL is not set
CONFIG_X86_E_POWERSAVER=y

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=y
# CONFIG_X86_SPEEDSTEP_RELAXED_CAP_CHECK is not set

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
# CONFIG_CPU_IDLE_GOV_LADDER is not set
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_INTEL_IDLE is not set

#
# Bus options (PCI etc.)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_DOMAINS=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
# CONFIG_PCIEPORTBUS is not set
# CONFIG_PCI_MSI is not set
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_STUB is not set
CONFIG_PCI_LOCKLESS_CONFIG=y
# CONFIG_PCI_IOV is not set
# CONFIG_PCI_PRI is not set
# CONFIG_PCI_PASID is not set
CONFIG_PCI_LABEL=y
# CONFIG_HOTPLUG_PCI is not set

#
# Cadence PCIe controllers support
#

#
# DesignWare PCI Core Support
#

#
# PCI host controller drivers
#

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
# CONFIG_ISA_BUS is not set
CONFIG_ISA_DMA_API=y
# CONFIG_ISA is not set
CONFIG_SCx200=y
CONFIG_SCx200HR_TIMER=y
# CONFIG_OLPC is not set
# CONFIG_ALIX is not set
CONFIG_NET5501=y
CONFIG_AMD_NB=y
CONFIG_PCCARD=y
CONFIG_PCMCIA=m
CONFIG_PCMCIA_LOAD_CIS=y
CONFIG_CARDBUS=y

#
# PC-card bridges
#
# CONFIG_YENTA is not set
# CONFIG_PD6729 is not set
# CONFIG_I82092 is not set
# CONFIG_RAPIDIO is not set
# CONFIG_X86_SYSFB is not set

#
# Executable file formats / Emulations
#
CONFIG_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_HAVE_AOUT=y
# CONFIG_BINFMT_AOUT is not set
CONFIG_BINFMT_MISC=y
CONFIG_COREDUMP=y
CONFIG_COMPAT_32=y
CONFIG_HAVE_ATOMIC_IOMAP=y
CONFIG_NET=y

#
# Networking options
#
# CONFIG_PACKET is not set
CONFIG_UNIX=y
# CONFIG_UNIX_DIAG is not set
# CONFIG_TLS is not set
CONFIG_XFRM=y
# CONFIG_XFRM_USER is not set
# CONFIG_XFRM_SUB_POLICY is not set
# CONFIG_XFRM_MIGRATE is not set
# CONFIG_XFRM_STATISTICS is not set
# CONFIG_NET_KEY is not set
# CONFIG_XDP_SOCKETS is not set
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE_DEMUX is not set
CONFIG_NET_IP_TUNNEL=y
# CONFIG_SYN_COOKIES is not set
# CONFIG_NET_IPVTI is not set
# CONFIG_NET_FOU is not set
# CONFIG_NET_FOU_IP_TUNNELS is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
CONFIG_INET_TUNNEL=y
CONFIG_INET_XFRM_MODE_TRANSPORT=y
CONFIG_INET_XFRM_MODE_TUNNEL=y
CONFIG_INET_XFRM_MODE_BEET=y
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
# CONFIG_INET_UDP_DIAG is not set
# CONFIG_INET_RAW_DIAG is not set
# CONFIG_INET_DIAG_DESTROY is not set
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_CUBIC=y
CONFIG_DEFAULT_TCP_CONG="cubic"
# CONFIG_TCP_MD5SIG is not set
CONFIG_IPV6=y
# CONFIG_IPV6_ROUTER_PREF is not set
# CONFIG_IPV6_OPTIMISTIC_DAD is not set
# CONFIG_INET6_AH is not set
# CONFIG_INET6_ESP is not set
# CONFIG_INET6_IPCOMP is not set
# CONFIG_IPV6_MIP6 is not set
CONFIG_INET6_XFRM_MODE_TRANSPORT=y
CONFIG_INET6_XFRM_MODE_TUNNEL=y
CONFIG_INET6_XFRM_MODE_BEET=y
# CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION is not set
# CONFIG_IPV6_VTI is not set
CONFIG_IPV6_SIT=y
# CONFIG_IPV6_SIT_6RD is not set
CONFIG_IPV6_NDISC_NODETYPE=y
# CONFIG_IPV6_TUNNEL is not set
# CONFIG_IPV6_MULTIPLE_TABLES is not set
# CONFIG_IPV6_MROUTE is not set
# CONFIG_IPV6_SEG6_LWTUNNEL is not set
# CONFIG_IPV6_SEG6_HMAC is not set
# CONFIG_NETWORK_SECMARK is not set
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
# CONFIG_NETFILTER is not set
# CONFIG_BPFILTER is not set
# CONFIG_IP_DCCP is not set
# CONFIG_IP_SCTP is not set
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_L2TP is not set
# CONFIG_BRIDGE is not set
CONFIG_HAVE_NET_DSA=y
# CONFIG_NET_DSA is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
# CONFIG_6LOWPAN is not set
# CONFIG_IEEE802154 is not set
# CONFIG_NET_SCHED is not set
# CONFIG_DCB is not set
CONFIG_DNS_RESOLVER=m
# CONFIG_BATMAN_ADV is not set
# CONFIG_OPENVSWITCH is not set
# CONFIG_VSOCKETS is not set
# CONFIG_NETLINK_DIAG is not set
# CONFIG_MPLS is not set
# CONFIG_NET_NSH is not set
# CONFIG_HSR is not set
# CONFIG_NET_SWITCHDEV is not set
# CONFIG_NET_L3_MASTER_DEV is not set
# CONFIG_NET_NCSI is not set
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_XPS=y
# CONFIG_CGROUP_NET_PRIO is not set
# CONFIG_CGROUP_NET_CLASSID is not set
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
# CONFIG_BPF_JIT is not set
# CONFIG_BPF_STREAM_PARSER is not set
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_NET_DROP_MONITOR is not set
# CONFIG_HAMRADIO is not set
# CONFIG_CAN is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_WIRELESS=y
# CONFIG_CFG80211 is not set

#
# CFG80211 needs to be enabled for MAC80211
#
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
# CONFIG_WIMAX is not set
# CONFIG_RFKILL is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_VIRTIO=m
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
# CONFIG_CEPH_LIB is not set
# CONFIG_NFC is not set
# CONFIG_PSAMPLE is not set
# CONFIG_NET_IFE is not set
# CONFIG_LWTUNNEL is not set
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
# CONFIG_NET_DEVLINK is not set
CONFIG_MAY_USE_DEVLINK=y
# CONFIG_FAILOVER is not set
CONFIG_HAVE_EBPF_JIT=y

#
# Device Drivers
#

#
# Generic Driver Options
#
# CONFIG_UEVENT_HELPER is not set
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
# CONFIG_STANDALONE is not set
# CONFIG_PREVENT_FIRMWARE_BUILD is not set

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
CONFIG_WANT_DEV_COREDUMP=y
CONFIG_ALLOW_DEV_COREDUMP=y
CONFIG_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
CONFIG_DEBUG_TEST_DRIVER_REMOVE=y
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SPMI=m
CONFIG_REGMAP_W1=m
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_DMA_SHARED_BUFFER=y
CONFIG_DMA_FENCE_TRACE=y
CONFIG_DMA_CMA=y

#
# Default contiguous memory area size:
#
CONFIG_CMA_SIZE_MBYTES=0
CONFIG_CMA_SIZE_SEL_MBYTES=y
# CONFIG_CMA_SIZE_SEL_PERCENTAGE is not set
# CONFIG_CMA_SIZE_SEL_MIN is not set
# CONFIG_CMA_SIZE_SEL_MAX is not set
CONFIG_CMA_ALIGNMENT=8

#
# Bus devices
#
# CONFIG_CONNECTOR is not set
CONFIG_MTD=y
CONFIG_MTD_TESTS=m
CONFIG_MTD_REDBOOT_PARTS=y
CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=-1
CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED=y
# CONFIG_MTD_REDBOOT_PARTS_READONLY is not set
# CONFIG_MTD_CMDLINE_PARTS is not set
CONFIG_MTD_AR7_PARTS=m

#
# Partition parsers
#

#
# User Modules And Translation Layers
#
CONFIG_MTD_OOPS=m
# CONFIG_MTD_PARTITIONED_MASTER is not set

#
# RAM/ROM/Flash chip drivers
#
CONFIG_MTD_CFI=m
CONFIG_MTD_JEDECPROBE=y
CONFIG_MTD_GEN_PROBE=y
CONFIG_MTD_CFI_ADV_OPTIONS=y
CONFIG_MTD_CFI_NOSWAP=y
# CONFIG_MTD_CFI_BE_BYTE_SWAP is not set
# CONFIG_MTD_CFI_LE_BYTE_SWAP is not set
CONFIG_MTD_CFI_GEOMETRY=y
# CONFIG_MTD_MAP_BANK_WIDTH_1 is not set
# CONFIG_MTD_MAP_BANK_WIDTH_2 is not set
# CONFIG_MTD_MAP_BANK_WIDTH_4 is not set
# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
CONFIG_MTD_MAP_BANK_WIDTH_16=y
# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
CONFIG_MTD_CFI_I4=y
CONFIG_MTD_CFI_I8=y
# CONFIG_MTD_OTP is not set
# CONFIG_MTD_CFI_INTELEXT is not set
CONFIG_MTD_CFI_AMDSTD=y
CONFIG_MTD_CFI_STAA=m
CONFIG_MTD_CFI_UTIL=y
CONFIG_MTD_RAM=y
CONFIG_MTD_ROM=m
CONFIG_MTD_ABSENT=y

#
# Mapping drivers for chip access
#
# CONFIG_MTD_COMPLEX_MAPPINGS is not set
# CONFIG_MTD_PHYSMAP is not set
CONFIG_MTD_SCx200_DOCFLASH=m
CONFIG_MTD_AMD76XROM=y
# CONFIG_MTD_ICHXROM is not set
# CONFIG_MTD_ESB2ROM is not set
# CONFIG_MTD_CK804XROM is not set
# CONFIG_MTD_SCB2_FLASH is not set
CONFIG_MTD_NETtel=m
CONFIG_MTD_L440GX=m
# CONFIG_MTD_INTEL_VR_NOR is not set
CONFIG_MTD_PLATRAM=y

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_PMC551 is not set
# CONFIG_MTD_SLRAM is not set
CONFIG_MTD_PHRAM=y
CONFIG_MTD_MTDRAM=y
CONFIG_MTDRAM_TOTAL_SIZE=4096
CONFIG_MTDRAM_ERASE_SIZE=128

#
# Disk-On-Chip Device Drivers
#
CONFIG_MTD_DOCG3=y
CONFIG_BCH_CONST_M=14
CONFIG_BCH_CONST_T=4
# CONFIG_MTD_ONENAND is not set
# CONFIG_MTD_NAND is not set

#
# LPDDR & LPDDR2 PCM memory drivers
#
# CONFIG_MTD_LPDDR is not set
CONFIG_MTD_SPI_NOR=y
# CONFIG_MTD_MT81xx_NOR is not set
# CONFIG_MTD_SPI_NOR_USE_4K_SECTORS is not set
CONFIG_SPI_INTEL_SPI=m
# CONFIG_SPI_INTEL_SPI_PCI is not set
CONFIG_SPI_INTEL_SPI_PLATFORM=m
CONFIG_MTD_UBI=y
CONFIG_MTD_UBI_WL_THRESHOLD=4096
CONFIG_MTD_UBI_BEB_LIMIT=20
# CONFIG_MTD_UBI_FASTMAP is not set
# CONFIG_MTD_UBI_GLUEBI is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
# CONFIG_PARPORT is not set
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_PNPACPI=y

#
# NVME Support
#

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=y
# CONFIG_AD525X_DPOT is not set
CONFIG_DUMMY_IRQ=y
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
# CONFIG_SGI_IOC4 is not set
# CONFIG_TIFM_CORE is not set
# CONFIG_ICS932S401 is not set
# CONFIG_ENCLOSURE_SERVICES is not set
# CONFIG_HP_ILO is not set
CONFIG_APDS9802ALS=y
# CONFIG_ISL29003 is not set
CONFIG_ISL29020=y
CONFIG_SENSORS_TSL2550=y
CONFIG_SENSORS_BH1770=y
CONFIG_SENSORS_APDS990X=m
CONFIG_HMC6352=y
CONFIG_DS1682=m
# CONFIG_PCH_PHUB is not set
CONFIG_USB_SWITCH_FSA9480=m
CONFIG_SRAM=y
# CONFIG_PCI_ENDPOINT_TEST is not set
CONFIG_MISC_RTSX=m
CONFIG_C2PORT=y
CONFIG_C2PORT_DURAMAR_2150=m

#
# EEPROM support
#
CONFIG_EEPROM_AT24=y
# CONFIG_EEPROM_LEGACY is not set
CONFIG_EEPROM_MAX6875=m
CONFIG_EEPROM_93CX6=m
# CONFIG_EEPROM_IDT_89HPESX is not set
# CONFIG_CB710_CORE is not set

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
CONFIG_SENSORS_LIS3_I2C=y
# CONFIG_ALTERA_STAPL is not set
# CONFIG_INTEL_MEI is not set
# CONFIG_INTEL_MEI_ME is not set
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_VMWARE_VMCI is not set

#
# Intel MIC & related support
#

#
# Intel MIC Bus Driver
#

#
# SCIF Bus Driver
#

#
# VOP Bus Driver
#

#
# Intel MIC Host Driver
#

#
# Intel MIC Card Driver
#

#
# SCIF Driver
#

#
# Intel MIC Coprocessor State Management (COSM) Drivers
#

#
# VOP Driver
#
CONFIG_ECHO=m
# CONFIG_MISC_RTSX_PCI is not set
CONFIG_MISC_RTSX_USB=m
CONFIG_HAVE_IDE=y

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_FIREWIRE is not set
# CONFIG_FIREWIRE_NOSY is not set
# CONFIG_MACINTOSH_DRIVERS is not set
CONFIG_NETDEVICES=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
# CONFIG_DUMMY is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_MACSEC is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_TUN is not set
# CONFIG_TUN_VNET_CROSS_LE is not set
# CONFIG_VETH is not set
# CONFIG_VIRTIO_NET is not set
# CONFIG_NLMON is not set
# CONFIG_ARCNET is not set

#
# CAIF transport drivers
#

#
# Distributed Switch Architecture drivers
#
CONFIG_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
# CONFIG_PCMCIA_3C574 is not set
# CONFIG_PCMCIA_3C589 is not set
# CONFIG_VORTEX is not set
# CONFIG_TYPHOON is not set
CONFIG_NET_VENDOR_ADAPTEC=y
# CONFIG_ADAPTEC_STARFIRE is not set
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
CONFIG_NET_VENDOR_ALACRITECH=y
# CONFIG_SLICOSS is not set
CONFIG_NET_VENDOR_ALTEON=y
# CONFIG_ACENIC is not set
# CONFIG_ALTERA_TSE is not set
CONFIG_NET_VENDOR_AMAZON=y
CONFIG_NET_VENDOR_AMD=y
# CONFIG_AMD8111_ETH is not set
# CONFIG_PCNET32 is not set
# CONFIG_PCMCIA_NMCLAN is not set
# CONFIG_AMD_XGBE is not set
CONFIG_NET_VENDOR_AQUANTIA=y
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ATHEROS=y
# CONFIG_ATL2 is not set
# CONFIG_ATL1 is not set
# CONFIG_ATL1E is not set
# CONFIG_ATL1C is not set
# CONFIG_ALX is not set
CONFIG_NET_VENDOR_AURORA=y
# CONFIG_AURORA_NB8800 is not set
CONFIG_NET_VENDOR_BROADCOM=y
# CONFIG_B44 is not set
# CONFIG_BNX2 is not set
# CONFIG_CNIC is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2X is not set
# CONFIG_BNXT is not set
CONFIG_NET_VENDOR_BROCADE=y
# CONFIG_BNA is not set
CONFIG_NET_CADENCE=y
# CONFIG_MACB is not set
CONFIG_NET_VENDOR_CAVIUM=y
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_NET_VENDOR_CISCO=y
# CONFIG_ENIC is not set
CONFIG_NET_VENDOR_CORTINA=y
# CONFIG_CX_ECAT is not set
# CONFIG_DNET is not set
CONFIG_NET_VENDOR_DEC=y
# CONFIG_NET_TULIP is not set
CONFIG_NET_VENDOR_DLINK=y
# CONFIG_DL2K is not set
# CONFIG_SUNDANCE is not set
CONFIG_NET_VENDOR_EMULEX=y
# CONFIG_BE2NET is not set
CONFIG_NET_VENDOR_EZCHIP=y
CONFIG_NET_VENDOR_FUJITSU=y
# CONFIG_PCMCIA_FMVJ18X is not set
CONFIG_NET_VENDOR_HP=y
# CONFIG_HP100 is not set
CONFIG_NET_VENDOR_HUAWEI=y
CONFIG_NET_VENDOR_I825XX=y
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
# CONFIG_E1000E is not set
# CONFIG_IGB is not set
# CONFIG_IGBVF is not set
# CONFIG_IXGB is not set
# CONFIG_IXGBE is not set
# CONFIG_I40E is not set
CONFIG_NET_VENDOR_EXAR=y
# CONFIG_S2IO is not set
# CONFIG_VXGE is not set
# CONFIG_JME is not set
CONFIG_NET_VENDOR_MARVELL=y
# CONFIG_MVMDIO is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
CONFIG_NET_VENDOR_MELLANOX=y
# CONFIG_MLX4_EN is not set
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
CONFIG_NET_VENDOR_MICREL=y
# CONFIG_KS8851_MLL is not set
# CONFIG_KSZ884X_PCI is not set
CONFIG_NET_VENDOR_MICROSEMI=y
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
# CONFIG_FEALNX is not set
CONFIG_NET_VENDOR_NATSEMI=y
# CONFIG_NATSEMI is not set
# CONFIG_NS83820 is not set
CONFIG_NET_VENDOR_NETRONOME=y
CONFIG_NET_VENDOR_NI=y
CONFIG_NET_VENDOR_8390=y
# CONFIG_PCMCIA_AXNET is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_PCMCIA_PCNET is not set
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
CONFIG_NET_VENDOR_OKI=y
# CONFIG_PCH_GBE is not set
# CONFIG_ETHOC is not set
CONFIG_NET_PACKET_ENGINE=y
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
CONFIG_NET_VENDOR_QLOGIC=y
# CONFIG_QLA3XXX is not set
# CONFIG_QLCNIC is not set
# CONFIG_QLGE is not set
# CONFIG_NETXEN_NIC is not set
# CONFIG_QED is not set
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_R8169 is not set
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
CONFIG_NET_VENDOR_SEEQ=y
CONFIG_NET_VENDOR_SOLARFLARE=y
# CONFIG_SFC is not set
# CONFIG_SFC_FALCON is not set
CONFIG_NET_VENDOR_SILAN=y
# CONFIG_SC92031 is not set
CONFIG_NET_VENDOR_SIS=y
# CONFIG_SIS900 is not set
# CONFIG_SIS190 is not set
CONFIG_NET_VENDOR_SMSC=y
# CONFIG_PCMCIA_SMC91C92 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SMSC911X is not set
# CONFIG_SMSC9420 is not set
CONFIG_NET_VENDOR_SOCIONEXT=y
CONFIG_NET_VENDOR_STMICRO=y
# CONFIG_STMMAC_ETH is not set
CONFIG_NET_VENDOR_SUN=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NIU is not set
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
CONFIG_NET_VENDOR_TEHUTI=y
# CONFIG_TEHUTI is not set
CONFIG_NET_VENDOR_TI=y
# CONFIG_TI_CPSW_ALE is not set
# CONFIG_TLAN is not set
CONFIG_NET_VENDOR_VIA=y
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_VELOCITY is not set
CONFIG_NET_VENDOR_WIZNET=y
# CONFIG_WIZNET_W5100 is not set
# CONFIG_WIZNET_W5300 is not set
CONFIG_NET_VENDOR_XIRCOM=y
# CONFIG_PCMCIA_XIRC2PS is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
# CONFIG_MDIO_DEVICE is not set
# CONFIG_PHYLIB is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
CONFIG_USB_NET_DRIVERS=y
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_RTL8152 is not set
# CONFIG_USB_LAN78XX is not set
# CONFIG_USB_USBNET is not set
# CONFIG_USB_IPHETH is not set
CONFIG_WLAN=y
# CONFIG_WIRELESS_WDS is not set
CONFIG_WLAN_VENDOR_ADMTEK=y
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K_PCI is not set
CONFIG_WLAN_VENDOR_ATMEL=y
CONFIG_WLAN_VENDOR_BROADCOM=y
CONFIG_WLAN_VENDOR_CISCO=y
CONFIG_WLAN_VENDOR_INTEL=y
CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
# CONFIG_PRISM54 is not set
CONFIG_WLAN_VENDOR_MARVELL=y
CONFIG_WLAN_VENDOR_MEDIATEK=y
CONFIG_WLAN_VENDOR_RALINK=y
CONFIG_WLAN_VENDOR_REALTEK=y
CONFIG_WLAN_VENDOR_RSI=y
CONFIG_WLAN_VENDOR_ST=y
CONFIG_WLAN_VENDOR_TI=y
CONFIG_WLAN_VENDOR_ZYDAS=y
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_PCMCIA_RAYCS is not set

#
# Enable WiMAX (Networking options) to see the WiMAX drivers
#
# CONFIG_WAN is not set
# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
# CONFIG_HYPERV_NET is not set
# CONFIG_NETDEVSIM is not set
# CONFIG_NET_FAILOVER is not set
# CONFIG_ISDN is not set

#
# Input device support
#
CONFIG_INPUT=y
# CONFIG_INPUT_LEDS is not set
CONFIG_INPUT_FF_MEMLESS=m
CONFIG_INPUT_POLLDEV=y
CONFIG_INPUT_SPARSEKMAP=y
CONFIG_INPUT_MATRIXKMAP=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=m
CONFIG_INPUT_EVBUG=y

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ADC=m
CONFIG_KEYBOARD_ADP5520=m
# CONFIG_KEYBOARD_ADP5588 is not set
CONFIG_KEYBOARD_ADP5589=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_KEYBOARD_QT1070=y
CONFIG_KEYBOARD_QT2160=m
CONFIG_KEYBOARD_DLINK_DIR685=m
CONFIG_KEYBOARD_LKKBD=m
CONFIG_KEYBOARD_GPIO=m
# CONFIG_KEYBOARD_GPIO_POLLED is not set
CONFIG_KEYBOARD_TCA6416=m
CONFIG_KEYBOARD_TCA8418=y
CONFIG_KEYBOARD_MATRIX=y
CONFIG_KEYBOARD_LM8323=m
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
CONFIG_KEYBOARD_MCS=y
CONFIG_KEYBOARD_MPR121=y
CONFIG_KEYBOARD_NEWTON=m
CONFIG_KEYBOARD_OPENCORES=y
# CONFIG_KEYBOARD_SAMSUNG is not set
CONFIG_KEYBOARD_GOLDFISH_EVENTS=m
# CONFIG_KEYBOARD_STOWAWAY is not set
CONFIG_KEYBOARD_SUNKBD=m
CONFIG_KEYBOARD_TM2_TOUCHKEY=y
CONFIG_KEYBOARD_XTKBD=y
CONFIG_INPUT_MOUSE=y
# CONFIG_MOUSE_PS2 is not set
# CONFIG_MOUSE_SERIAL is not set
CONFIG_MOUSE_APPLETOUCH=y
CONFIG_MOUSE_BCM5974=m
# CONFIG_MOUSE_CYAPA is not set
CONFIG_MOUSE_ELAN_I2C=m
CONFIG_MOUSE_ELAN_I2C_I2C=y
# CONFIG_MOUSE_ELAN_I2C_SMBUS is not set
# CONFIG_MOUSE_VSXXXAA is not set
CONFIG_MOUSE_GPIO=m
CONFIG_MOUSE_SYNAPTICS_I2C=m
# CONFIG_MOUSE_SYNAPTICS_USB is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set
CONFIG_RMI4_CORE=m
CONFIG_RMI4_I2C=m
CONFIG_RMI4_SMB=m
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=m
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
# CONFIG_RMI4_F34 is not set
# CONFIG_RMI4_F54 is not set
CONFIG_RMI4_F55=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=y
CONFIG_SERIO_ALTERA_PS2=m
CONFIG_SERIO_PS2MULT=y
# CONFIG_SERIO_ARC_PS2 is not set
CONFIG_HYPERV_KEYBOARD=y
CONFIG_SERIO_GPIO_PS2=y
# CONFIG_USERIO is not set
# CONFIG_GAMEPORT is not set

#
# Character devices
#
CONFIG_TTY=y
# CONFIG_VT is not set
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
# CONFIG_SERIAL_NONSTANDARD is not set
# CONFIG_NOZOMI is not set
# CONFIG_N_GSM is not set
# CONFIG_TRACE_SINK is not set
# CONFIG_GOLDFISH_TTY is not set
CONFIG_DEVMEM=y
# CONFIG_DEVKMEM is not set

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_DEPRECATED_OPTIONS=y
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
# CONFIG_SERIAL_8250_CS is not set
# CONFIG_SERIAL_8250_MEN_MCB is not set
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set
# CONFIG_SERIAL_8250_DW is not set
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
# CONFIG_SERIAL_8250_MOXA is not set

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_TIMBERDALE is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_PCH_UART is not set
# CONFIG_SERIAL_ARC is not set
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_MEN_Z135 is not set
CONFIG_SERIAL_DEV_BUS=m
# CONFIG_TTY_PRINTK is not set
# CONFIG_VIRTIO_CONSOLE is not set
CONFIG_IPMI_HANDLER=y
CONFIG_IPMI_PANIC_EVENT=y
# CONFIG_IPMI_PANIC_STRING is not set
CONFIG_IPMI_DEVICE_INTERFACE=y
CONFIG_IPMI_SI=y
CONFIG_IPMI_SSIF=m
CONFIG_IPMI_WATCHDOG=m
CONFIG_IPMI_POWEROFF=m
CONFIG_HW_RANDOM=m
CONFIG_HW_RANDOM_TIMERIOMEM=m
CONFIG_HW_RANDOM_INTEL=m
CONFIG_HW_RANDOM_AMD=m
CONFIG_HW_RANDOM_GEODE=m
CONFIG_HW_RANDOM_VIA=m
CONFIG_HW_RANDOM_VIRTIO=m
CONFIG_NVRAM=y
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# PCMCIA character devices
#
# CONFIG_SYNCLINK_CS is not set
CONFIG_CARDMAN_4000=m
CONFIG_CARDMAN_4040=m
CONFIG_SCR24X=m
# CONFIG_IPWIRELESS is not set
# CONFIG_MWAVE is not set
CONFIG_SCx200_GPIO=m
# CONFIG_PC8736x_GPIO is not set
CONFIG_NSC_GPIO=m
# CONFIG_HPET is not set
# CONFIG_HANGCHECK_TIMER is not set
CONFIG_TCG_TPM=y
CONFIG_TCG_TIS_CORE=m
CONFIG_TCG_TIS=m
CONFIG_TCG_TIS_I2C_ATMEL=m
CONFIG_TCG_TIS_I2C_INFINEON=m
# CONFIG_TCG_TIS_I2C_NUVOTON is not set
# CONFIG_TCG_NSC is not set
CONFIG_TCG_ATMEL=y
CONFIG_TCG_INFINEON=m
CONFIG_TCG_CRB=m
# CONFIG_TCG_VTPM_PROXY is not set
# CONFIG_TCG_TIS_ST33ZP24_I2C is not set
CONFIG_TELCLOCK=m
CONFIG_DEVPORT=y
# CONFIG_XILLYBUS is not set

#
# I2C support
#
CONFIG_I2C=y
# CONFIG_ACPI_I2C_OPREGION is not set
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=y
CONFIG_I2C_MUX=m

#
# Multiplexer I2C Chip support
#
# CONFIG_I2C_MUX_GPIO is not set
CONFIG_I2C_MUX_LTC4306=m
CONFIG_I2C_MUX_PCA9541=m
CONFIG_I2C_MUX_PCA954x=m
# CONFIG_I2C_MUX_REG is not set
# CONFIG_I2C_MUX_MLXCPLD is not set
CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=m
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCA=m

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_ISCH is not set
# CONFIG_I2C_ISMT is not set
# CONFIG_I2C_PIIX4 is not set
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_VIA is not set
# CONFIG_I2C_VIAPRO is not set

#
# ACPI drivers
#
CONFIG_I2C_SCMI=y

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
CONFIG_I2C_CBUS_GPIO=m
# CONFIG_I2C_DESIGNWARE_PLATFORM is not set
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_EG20T is not set
# CONFIG_I2C_EMEV2 is not set
CONFIG_I2C_GPIO=y
# CONFIG_I2C_GPIO_FAULT_INJECTOR is not set
CONFIG_I2C_OCORES=y
CONFIG_I2C_PCA_PLATFORM=m
CONFIG_I2C_SIMTEC=y
CONFIG_I2C_XILINX=y

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_DIOLAN_U2C is not set
# CONFIG_I2C_DLN2 is not set
CONFIG_I2C_PARPORT_LIGHT=m
CONFIG_I2C_ROBOTFUZZ_OSIF=y
# CONFIG_I2C_TAOS_EVM is not set
CONFIG_I2C_TINY_USB=m
CONFIG_I2C_VIPERBOARD=m

#
# Other I2C/SMBus bus drivers
#
# CONFIG_SCx200_ACB is not set
CONFIG_I2C_STUB=m
CONFIG_I2C_SLAVE=y
CONFIG_I2C_SLAVE_EEPROM=m
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_SPI is not set
CONFIG_SPMI=m
# CONFIG_HSI is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set
# CONFIG_NTP_PPS is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
# CONFIG_PPS_CLIENT_LDISC is not set
CONFIG_PPS_CLIENT_GPIO=y

#
# PPS generators support
#

#
# PTP clock support
#
# CONFIG_PTP_1588_CLOCK is not set

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
# CONFIG_PTP_1588_CLOCK_PCH is not set
CONFIG_PINCTRL=y
CONFIG_PINMUX=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
CONFIG_PINCTRL_AMD=y
CONFIG_PINCTRL_MCP23S08=y
# CONFIG_PINCTRL_SX150X is not set
# CONFIG_PINCTRL_BAYTRAIL is not set
# CONFIG_PINCTRL_CHERRYVIEW is not set
CONFIG_PINCTRL_INTEL=y
CONFIG_PINCTRL_BROXTON=y
CONFIG_PINCTRL_CANNONLAKE=y
# CONFIG_PINCTRL_CEDARFORK is not set
CONFIG_PINCTRL_DENVERTON=y
CONFIG_PINCTRL_GEMINILAKE=m
CONFIG_PINCTRL_LEWISBURG=y
# CONFIG_PINCTRL_SUNRISEPOINT is not set
CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_GENERIC=y
CONFIG_GPIO_MAX730X=m

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_AMDPT is not set
CONFIG_GPIO_DWAPB=y
# CONFIG_GPIO_EXAR is not set
# CONFIG_GPIO_GENERIC_PLATFORM is not set
# CONFIG_GPIO_ICH is not set
CONFIG_GPIO_LYNXPOINT=y
# CONFIG_GPIO_MB86S7X is not set
CONFIG_GPIO_MENZ127=y
CONFIG_GPIO_MOCKUP=y
# CONFIG_GPIO_VX855 is not set

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_104_DIO_48E is not set
# CONFIG_GPIO_104_IDIO_16 is not set
CONFIG_GPIO_104_IDI_48=y
CONFIG_GPIO_F7188X=m
CONFIG_GPIO_GPIO_MM=m
CONFIG_GPIO_IT87=y
# CONFIG_GPIO_SCH is not set
CONFIG_GPIO_SCH311X=y
CONFIG_GPIO_WINBOND=m
# CONFIG_GPIO_WS16C48 is not set

#
# I2C GPIO expanders
#
CONFIG_GPIO_ADP5588=y
CONFIG_GPIO_ADP5588_IRQ=y
CONFIG_GPIO_MAX7300=m
CONFIG_GPIO_MAX732X=y
# CONFIG_GPIO_MAX732X_IRQ is not set
# CONFIG_GPIO_PCA953X is not set
CONFIG_GPIO_PCF857X=y
# CONFIG_GPIO_TPIC2810 is not set

#
# MFD GPIO expanders
#
CONFIG_GPIO_ADP5520=y
CONFIG_GPIO_DA9052=y
# CONFIG_GPIO_DLN2 is not set
# CONFIG_GPIO_LP873X is not set
# CONFIG_GPIO_PALMAS is not set
# CONFIG_GPIO_WM831X is not set

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_BT8XX is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set

#
# USB GPIO expanders
#
# CONFIG_GPIO_VIPERBOARD is not set
CONFIG_W1=y

#
# 1-wire Bus Masters
#
# CONFIG_W1_MASTER_MATROX is not set
CONFIG_W1_MASTER_DS2490=y
CONFIG_W1_MASTER_DS2482=y
CONFIG_W1_MASTER_DS1WM=m
# CONFIG_W1_MASTER_GPIO is not set

#
# 1-wire Slaves
#
CONFIG_W1_SLAVE_THERM=y
CONFIG_W1_SLAVE_SMEM=m
CONFIG_W1_SLAVE_DS2405=m
# CONFIG_W1_SLAVE_DS2408 is not set
# CONFIG_W1_SLAVE_DS2413 is not set
# CONFIG_W1_SLAVE_DS2406 is not set
CONFIG_W1_SLAVE_DS2423=m
CONFIG_W1_SLAVE_DS2805=m
CONFIG_W1_SLAVE_DS2431=y
CONFIG_W1_SLAVE_DS2433=m
# CONFIG_W1_SLAVE_DS2433_CRC is not set
CONFIG_W1_SLAVE_DS2438=y
# CONFIG_W1_SLAVE_DS2760 is not set
CONFIG_W1_SLAVE_DS2780=m
CONFIG_W1_SLAVE_DS2781=y
CONFIG_W1_SLAVE_DS28E04=y
# CONFIG_W1_SLAVE_DS28E17 is not set
CONFIG_POWER_AVS=y
# CONFIG_POWER_RESET is not set
CONFIG_POWER_SUPPLY=y
CONFIG_POWER_SUPPLY_DEBUG=y
CONFIG_PDA_POWER=m
CONFIG_GENERIC_ADC_BATTERY=m
# CONFIG_MAX8925_POWER is not set
# CONFIG_WM831X_BACKUP is not set
CONFIG_WM831X_POWER=m
# CONFIG_TEST_POWER is not set
# CONFIG_BATTERY_DS2780 is not set
CONFIG_BATTERY_DS2781=y
CONFIG_BATTERY_DS2782=y
# CONFIG_BATTERY_SBS is not set
# CONFIG_CHARGER_SBS is not set
CONFIG_MANAGER_SBS=m
CONFIG_BATTERY_BQ27XXX=m
CONFIG_BATTERY_BQ27XXX_I2C=m
CONFIG_BATTERY_BQ27XXX_HDQ=m
CONFIG_BATTERY_BQ27XXX_DT_UPDATES_NVM=y
CONFIG_BATTERY_DA9052=y
CONFIG_CHARGER_AXP20X=m
CONFIG_BATTERY_AXP20X=m
CONFIG_AXP20X_POWER=m
CONFIG_AXP288_CHARGER=m
CONFIG_AXP288_FUEL_GAUGE=m
# CONFIG_BATTERY_MAX17040 is not set
CONFIG_BATTERY_MAX17042=m
CONFIG_BATTERY_MAX1721X=m
CONFIG_CHARGER_ISP1704=m
# CONFIG_CHARGER_MAX8903 is not set
CONFIG_CHARGER_LP8727=m
# CONFIG_CHARGER_GPIO is not set
# CONFIG_CHARGER_MANAGER is not set
# CONFIG_CHARGER_LTC3651 is not set
CONFIG_CHARGER_MAX14577=y
CONFIG_CHARGER_MAX77693=m
CONFIG_CHARGER_BQ2415X=m
CONFIG_CHARGER_BQ24190=m
# CONFIG_CHARGER_BQ24257 is not set
CONFIG_CHARGER_BQ24735=y
CONFIG_CHARGER_BQ25890=m
CONFIG_CHARGER_SMB347=m
CONFIG_CHARGER_TPS65090=m
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
CONFIG_BATTERY_GOLDFISH=m
CONFIG_CHARGER_RT9455=m
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_AD7414=m
CONFIG_SENSORS_AD7418=m
# CONFIG_SENSORS_ADM1021 is not set
# CONFIG_SENSORS_ADM1025 is not set
CONFIG_SENSORS_ADM1026=y
CONFIG_SENSORS_ADM1029=y
# CONFIG_SENSORS_ADM1031 is not set
# CONFIG_SENSORS_ADM9240 is not set
# CONFIG_SENSORS_ADT7410 is not set
CONFIG_SENSORS_ADT7411=y
CONFIG_SENSORS_ADT7462=m
CONFIG_SENSORS_ADT7470=y
# CONFIG_SENSORS_ADT7475 is not set
CONFIG_SENSORS_ASC7621=y
# CONFIG_SENSORS_K8TEMP is not set
# CONFIG_SENSORS_K10TEMP is not set
# CONFIG_SENSORS_FAM15H_POWER is not set
# CONFIG_SENSORS_APPLESMC is not set
CONFIG_SENSORS_ASB100=y
CONFIG_SENSORS_ASPEED=y
CONFIG_SENSORS_ATXP1=y
CONFIG_SENSORS_DS620=m
CONFIG_SENSORS_DS1621=m
CONFIG_SENSORS_DELL_SMM=y
CONFIG_SENSORS_DA9052_ADC=m
# CONFIG_SENSORS_I5K_AMB is not set
CONFIG_SENSORS_F71805F=y
CONFIG_SENSORS_F71882FG=m
CONFIG_SENSORS_F75375S=m
# CONFIG_SENSORS_MC13783_ADC is not set
# CONFIG_SENSORS_FSCHMD is not set
CONFIG_SENSORS_GL518SM=y
CONFIG_SENSORS_GL520SM=m
# CONFIG_SENSORS_G760A is not set
CONFIG_SENSORS_G762=m
CONFIG_SENSORS_HIH6130=y
CONFIG_SENSORS_IBMAEM=y
CONFIG_SENSORS_IBMPEX=y
# CONFIG_SENSORS_IIO_HWMON is not set
# CONFIG_SENSORS_I5500 is not set
CONFIG_SENSORS_CORETEMP=m
CONFIG_SENSORS_IT87=m
CONFIG_SENSORS_JC42=y
# CONFIG_SENSORS_POWR1220 is not set
CONFIG_SENSORS_LINEAGE=y
CONFIG_SENSORS_LTC2945=m
# CONFIG_SENSORS_LTC2990 is not set
CONFIG_SENSORS_LTC4151=y
CONFIG_SENSORS_LTC4215=m
CONFIG_SENSORS_LTC4222=m
# CONFIG_SENSORS_LTC4245 is not set
CONFIG_SENSORS_LTC4260=m
# CONFIG_SENSORS_LTC4261 is not set
# CONFIG_SENSORS_MAX16065 is not set
CONFIG_SENSORS_MAX1619=y
# CONFIG_SENSORS_MAX1668 is not set
CONFIG_SENSORS_MAX197=m
# CONFIG_SENSORS_MAX6621 is not set
CONFIG_SENSORS_MAX6639=m
CONFIG_SENSORS_MAX6642=m
CONFIG_SENSORS_MAX6650=m
CONFIG_SENSORS_MAX6697=m
CONFIG_SENSORS_MAX31790=y
CONFIG_SENSORS_MCP3021=m
CONFIG_SENSORS_TC654=y
CONFIG_SENSORS_MENF21BMC_HWMON=y
CONFIG_SENSORS_LM63=m
CONFIG_SENSORS_LM73=m
# CONFIG_SENSORS_LM75 is not set
CONFIG_SENSORS_LM77=y
CONFIG_SENSORS_LM78=m
# CONFIG_SENSORS_LM80 is not set
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=y
# CONFIG_SENSORS_LM87 is not set
# CONFIG_SENSORS_LM90 is not set
CONFIG_SENSORS_LM92=m
CONFIG_SENSORS_LM93=m
# CONFIG_SENSORS_LM95234 is not set
CONFIG_SENSORS_LM95241=m
CONFIG_SENSORS_LM95245=m
# CONFIG_SENSORS_PC87360 is not set
# CONFIG_SENSORS_PC87427 is not set
CONFIG_SENSORS_NTC_THERMISTOR=y
CONFIG_SENSORS_NCT6683=y
CONFIG_SENSORS_NCT6775=m
CONFIG_SENSORS_NCT7802=y
CONFIG_SENSORS_NCT7904=m
# CONFIG_SENSORS_PCF8591 is not set
CONFIG_PMBUS=y
CONFIG_SENSORS_PMBUS=y
# CONFIG_SENSORS_ADM1275 is not set
CONFIG_SENSORS_IBM_CFFPS=m
CONFIG_SENSORS_IR35221=y
CONFIG_SENSORS_LM25066=m
# CONFIG_SENSORS_LTC2978 is not set
# CONFIG_SENSORS_LTC3815 is not set
# CONFIG_SENSORS_MAX16064 is not set
CONFIG_SENSORS_MAX20751=y
CONFIG_SENSORS_MAX31785=y
CONFIG_SENSORS_MAX34440=m
# CONFIG_SENSORS_MAX8688 is not set
CONFIG_SENSORS_TPS40422=y
# CONFIG_SENSORS_TPS53679 is not set
CONFIG_SENSORS_UCD9000=m
# CONFIG_SENSORS_UCD9200 is not set
# CONFIG_SENSORS_ZL6100 is not set
CONFIG_SENSORS_SHT15=y
# CONFIG_SENSORS_SHT21 is not set
CONFIG_SENSORS_SHT3x=y
CONFIG_SENSORS_SHTC1=m
# CONFIG_SENSORS_SIS5595 is not set
CONFIG_SENSORS_DME1737=m
CONFIG_SENSORS_EMC1403=m
CONFIG_SENSORS_EMC2103=y
CONFIG_SENSORS_EMC6W201=m
CONFIG_SENSORS_SMSC47M1=y
# CONFIG_SENSORS_SMSC47M192 is not set
CONFIG_SENSORS_SMSC47B397=y
CONFIG_SENSORS_STTS751=y
CONFIG_SENSORS_SMM665=m
# CONFIG_SENSORS_ADC128D818 is not set
CONFIG_SENSORS_ADS1015=m
CONFIG_SENSORS_ADS7828=m
CONFIG_SENSORS_AMC6821=y
CONFIG_SENSORS_INA209=m
# CONFIG_SENSORS_INA2XX is not set
# CONFIG_SENSORS_INA3221 is not set
CONFIG_SENSORS_TC74=m
CONFIG_SENSORS_THMC50=y
CONFIG_SENSORS_TMP102=y
CONFIG_SENSORS_TMP103=y
# CONFIG_SENSORS_TMP108 is not set
# CONFIG_SENSORS_TMP401 is not set
CONFIG_SENSORS_TMP421=y
CONFIG_SENSORS_VIA_CPUTEMP=y
# CONFIG_SENSORS_VIA686A is not set
CONFIG_SENSORS_VT1211=m
# CONFIG_SENSORS_VT8231 is not set
# CONFIG_SENSORS_W83773G is not set
# CONFIG_SENSORS_W83781D is not set
CONFIG_SENSORS_W83791D=m
CONFIG_SENSORS_W83792D=m
# CONFIG_SENSORS_W83793 is not set
# CONFIG_SENSORS_W83795 is not set
CONFIG_SENSORS_W83L785TS=m
# CONFIG_SENSORS_W83L786NG is not set
# CONFIG_SENSORS_W83627HF is not set
# CONFIG_SENSORS_W83627EHF is not set
# CONFIG_SENSORS_WM831X is not set
CONFIG_SENSORS_XGENE=y

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=m
CONFIG_SENSORS_ATK0110=y
CONFIG_THERMAL=y
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
# CONFIG_THERMAL_HWMON is not set
# CONFIG_THERMAL_WRITABLE_TRIPS is not set
# CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE is not set
CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE=y
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
# CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
CONFIG_THERMAL_GOV_POWER_ALLOCATOR=y
# CONFIG_CLOCK_THERMAL is not set
CONFIG_DEVFREQ_THERMAL=y
# CONFIG_THERMAL_EMULATION is not set
CONFIG_INTEL_POWERCLAMP=y
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
# CONFIG_INTEL_PCH_THERMAL is not set
CONFIG_GENERIC_ADC_THERMAL=m
# CONFIG_WATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=m
CONFIG_SSB_SPROM=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
CONFIG_SSB_PCIHOST=y
CONFIG_SSB_PCMCIAHOST_POSSIBLE=y
# CONFIG_SSB_PCMCIAHOST is not set
# CONFIG_SSB_SILENT is not set
# CONFIG_SSB_DEBUG is not set
CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
# CONFIG_SSB_DRIVER_PCICORE is not set
# CONFIG_SSB_DRIVER_GPIO is not set
CONFIG_BCMA_POSSIBLE=y
# CONFIG_BCMA is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_CS5535 is not set
CONFIG_MFD_AS3711=y
CONFIG_PMIC_ADP5520=y
# CONFIG_MFD_AAT2870_CORE is not set
# CONFIG_MFD_BCM590XX is not set
# CONFIG_MFD_BD9571MWV is not set
CONFIG_MFD_AXP20X=m
CONFIG_MFD_AXP20X_I2C=m
# CONFIG_MFD_CROS_EC is not set
# CONFIG_PMIC_DA903X is not set
CONFIG_PMIC_DA9052=y
CONFIG_MFD_DA9052_I2C=y
# CONFIG_MFD_DA9055 is not set
# CONFIG_MFD_DA9062 is not set
CONFIG_MFD_DA9063=y
# CONFIG_MFD_DA9150 is not set
CONFIG_MFD_DLN2=m
CONFIG_MFD_MC13XXX=y
CONFIG_MFD_MC13XXX_I2C=y
CONFIG_HTC_PASIC3=y
CONFIG_HTC_I2CPLD=y
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
# CONFIG_LPC_ICH is not set
# CONFIG_LPC_SCH is not set
# CONFIG_INTEL_SOC_PMIC is not set
# CONFIG_INTEL_SOC_PMIC_CHTWC is not set
# CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
# CONFIG_MFD_INTEL_LPSS_ACPI is not set
# CONFIG_MFD_INTEL_LPSS_PCI is not set
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_KEMPLD is not set
# CONFIG_MFD_88PM800 is not set
CONFIG_MFD_88PM805=m
# CONFIG_MFD_88PM860X is not set
CONFIG_MFD_MAX14577=y
CONFIG_MFD_MAX77693=m
CONFIG_MFD_MAX77843=y
CONFIG_MFD_MAX8907=m
CONFIG_MFD_MAX8925=y
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
CONFIG_MFD_MT6397=m
CONFIG_MFD_MENF21BMC=y
CONFIG_MFD_VIPERBOARD=m
CONFIG_MFD_RETU=y
# CONFIG_MFD_PCF50633 is not set
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RT5033 is not set
# CONFIG_MFD_RC5T583 is not set
CONFIG_MFD_SEC_CORE=y
# CONFIG_MFD_SI476X_CORE is not set
CONFIG_MFD_SM501=m
CONFIG_MFD_SM501_GPIO=y
CONFIG_MFD_SKY81452=m
# CONFIG_MFD_SMSC is not set
CONFIG_ABX500_CORE=y
# CONFIG_AB3100_CORE is not set
CONFIG_MFD_SYSCON=y
# CONFIG_MFD_TI_AM335X_TSCADC is not set
# CONFIG_MFD_LP3943 is not set
# CONFIG_MFD_LP8788 is not set
CONFIG_MFD_TI_LMU=y
CONFIG_MFD_PALMAS=y
CONFIG_TPS6105X=m
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
# CONFIG_MFD_TPS65086 is not set
CONFIG_MFD_TPS65090=y
# CONFIG_MFD_TPS68470 is not set
CONFIG_MFD_TI_LP873X=y
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
# CONFIG_MFD_TPS65912_I2C is not set
# CONFIG_MFD_TPS80031 is not set
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
# CONFIG_MFD_WL1273_CORE is not set
CONFIG_MFD_LM3533=m
# CONFIG_MFD_TIMBERDALE is not set
# CONFIG_MFD_VX855 is not set
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_WM8400 is not set
CONFIG_MFD_WM831X=y
CONFIG_MFD_WM831X_I2C=y
# CONFIG_MFD_WM8350_I2C is not set
# CONFIG_MFD_WM8994 is not set
# CONFIG_RAVE_SP_CORE is not set
CONFIG_REGULATOR=y
# CONFIG_REGULATOR_DEBUG is not set
CONFIG_REGULATOR_FIXED_VOLTAGE=m
CONFIG_REGULATOR_VIRTUAL_CONSUMER=y
# CONFIG_REGULATOR_USERSPACE_CONSUMER is not set
# CONFIG_REGULATOR_88PG86X is not set
CONFIG_REGULATOR_ACT8865=y
CONFIG_REGULATOR_AD5398=m
CONFIG_REGULATOR_ANATOP=y
CONFIG_REGULATOR_AS3711=y
CONFIG_REGULATOR_AXP20X=m
CONFIG_REGULATOR_DA9052=y
CONFIG_REGULATOR_DA9063=y
# CONFIG_REGULATOR_DA9210 is not set
# CONFIG_REGULATOR_DA9211 is not set
CONFIG_REGULATOR_FAN53555=y
CONFIG_REGULATOR_GPIO=m
CONFIG_REGULATOR_ISL9305=m
# CONFIG_REGULATOR_ISL6271A is not set
# CONFIG_REGULATOR_LM363X is not set
# CONFIG_REGULATOR_LP3971 is not set
CONFIG_REGULATOR_LP3972=m
CONFIG_REGULATOR_LP872X=y
CONFIG_REGULATOR_LP8755=y
# CONFIG_REGULATOR_LTC3589 is not set
# CONFIG_REGULATOR_LTC3676 is not set
CONFIG_REGULATOR_MAX14577=y
CONFIG_REGULATOR_MAX1586=y
CONFIG_REGULATOR_MAX8649=y
# CONFIG_REGULATOR_MAX8660 is not set
CONFIG_REGULATOR_MAX8907=m
CONFIG_REGULATOR_MAX8925=m
CONFIG_REGULATOR_MAX8952=m
CONFIG_REGULATOR_MAX77693=m
CONFIG_REGULATOR_MC13XXX_CORE=y
CONFIG_REGULATOR_MC13783=y
# CONFIG_REGULATOR_MC13892 is not set
# CONFIG_REGULATOR_MT6311 is not set
CONFIG_REGULATOR_MT6323=m
CONFIG_REGULATOR_MT6397=m
CONFIG_REGULATOR_PALMAS=m
CONFIG_REGULATOR_PFUZE100=y
# CONFIG_REGULATOR_PV88060 is not set
CONFIG_REGULATOR_PV88080=y
CONFIG_REGULATOR_PV88090=y
CONFIG_REGULATOR_PWM=m
CONFIG_REGULATOR_QCOM_SPMI=m
# CONFIG_REGULATOR_S2MPA01 is not set
# CONFIG_REGULATOR_S2MPS11 is not set
CONFIG_REGULATOR_S5M8767=m
CONFIG_REGULATOR_SKY81452=m
CONFIG_REGULATOR_TPS51632=m
CONFIG_REGULATOR_TPS6105X=m
CONFIG_REGULATOR_TPS62360=m
CONFIG_REGULATOR_TPS65023=m
CONFIG_REGULATOR_TPS6507X=m
# CONFIG_REGULATOR_TPS65090 is not set
# CONFIG_REGULATOR_TPS65132 is not set
CONFIG_REGULATOR_WM831X=y
CONFIG_CEC_CORE=m
CONFIG_CEC_NOTIFIER=y
# CONFIG_RC_CORE is not set
CONFIG_MEDIA_SUPPORT=y

#
# Multimedia core support
#
# CONFIG_MEDIA_CAMERA_SUPPORT is not set
# CONFIG_MEDIA_ANALOG_TV_SUPPORT is not set
# CONFIG_MEDIA_DIGITAL_TV_SUPPORT is not set
CONFIG_MEDIA_RADIO_SUPPORT=y
CONFIG_MEDIA_SDR_SUPPORT=y
CONFIG_MEDIA_CEC_SUPPORT=y
CONFIG_VIDEO_DEV=y
CONFIG_VIDEO_V4L2=y
CONFIG_VIDEO_ADV_DEBUG=y
# CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
CONFIG_V4L2_FWNODE=y

#
# Media drivers
#
CONFIG_MEDIA_USB_SUPPORT=y

#
# Software defined radio USB devices
#
CONFIG_USB_AIRSPY=y
# CONFIG_USB_HACKRF is not set

#
# USB HDMI CEC adapters
#
# CONFIG_MEDIA_PCI_SUPPORT is not set
# CONFIG_CEC_PLATFORM_DRIVERS is not set
# CONFIG_SDR_PLATFORM_DRIVERS is not set

#
# Supported MMC/SDIO adapters
#
# CONFIG_RADIO_ADAPTERS is not set
CONFIG_CYPRESS_FIRMWARE=m
CONFIG_VIDEOBUF2_CORE=y
CONFIG_VIDEOBUF2_V4L2=y
CONFIG_VIDEOBUF2_MEMOPS=y
CONFIG_VIDEOBUF2_VMALLOC=y

#
# Media ancillary drivers (tuners, sensors, i2c, spi, frontends)
#
# CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set
CONFIG_MEDIA_ATTACH=y

#
# I2C Encoders, decoders, sensors and other helper chips
#

#
# Audio decoders, processors and mixers
#
CONFIG_VIDEO_TVAUDIO=y
CONFIG_VIDEO_TDA7432=y
CONFIG_VIDEO_TDA9840=y
CONFIG_VIDEO_TEA6415C=y
CONFIG_VIDEO_TEA6420=m
# CONFIG_VIDEO_MSP3400 is not set
# CONFIG_VIDEO_CS3308 is not set
# CONFIG_VIDEO_CS5345 is not set
# CONFIG_VIDEO_CS53L32A is not set
CONFIG_VIDEO_TLV320AIC23B=y
CONFIG_VIDEO_UDA1342=m
CONFIG_VIDEO_WM8775=y
CONFIG_VIDEO_WM8739=y
CONFIG_VIDEO_VP27SMPX=y
# CONFIG_VIDEO_SONY_BTF_MPX is not set

#
# RDS decoders
#
CONFIG_VIDEO_SAA6588=y

#
# Video decoders
#
CONFIG_VIDEO_ADV7183=m
CONFIG_VIDEO_BT819=m
# CONFIG_VIDEO_BT856 is not set
CONFIG_VIDEO_BT866=m
# CONFIG_VIDEO_KS0127 is not set
CONFIG_VIDEO_ML86V7667=m
CONFIG_VIDEO_SAA7110=y
# CONFIG_VIDEO_SAA711X is not set
# CONFIG_VIDEO_TVP514X is not set
# CONFIG_VIDEO_TVP5150 is not set
CONFIG_VIDEO_TVP7002=y
# CONFIG_VIDEO_TW2804 is not set
CONFIG_VIDEO_TW9903=m
CONFIG_VIDEO_TW9906=y
# CONFIG_VIDEO_TW9910 is not set
CONFIG_VIDEO_VPX3220=m

#
# Video and audio decoders
#
CONFIG_VIDEO_SAA717X=y
# CONFIG_VIDEO_CX25840 is not set

#
# Video encoders
#
CONFIG_VIDEO_SAA7127=y
# CONFIG_VIDEO_SAA7185 is not set
CONFIG_VIDEO_ADV7170=m
CONFIG_VIDEO_ADV7175=m
# CONFIG_VIDEO_ADV7343 is not set
CONFIG_VIDEO_ADV7393=m
# CONFIG_VIDEO_AK881X is not set
# CONFIG_VIDEO_THS8200 is not set

#
# Camera sensor devices
#
CONFIG_VIDEO_MT9M111=y

#
# Flash devices
#

#
# Video improvement chips
#
CONFIG_VIDEO_UPD64031A=m
CONFIG_VIDEO_UPD64083=y

#
# Audio/Video compression chips
#
# CONFIG_VIDEO_SAA6752HS is not set

#
# SDR tuner chips
#
# CONFIG_SDR_MAX2175 is not set

#
# Miscellaneous helper chips
#
CONFIG_VIDEO_THS7303=y
# CONFIG_VIDEO_M52790 is not set
# CONFIG_VIDEO_I2C is not set

#
# Sensors used on soc_camera driver
#

#
# SPI helper chips
#
CONFIG_MEDIA_TUNER=y

#
# Customize TV tuners
#
CONFIG_MEDIA_TUNER_SIMPLE=y
CONFIG_MEDIA_TUNER_TDA18250=y
# CONFIG_MEDIA_TUNER_TDA8290 is not set
# CONFIG_MEDIA_TUNER_TDA827X is not set
CONFIG_MEDIA_TUNER_TDA18271=y
CONFIG_MEDIA_TUNER_TDA9887=y
# CONFIG_MEDIA_TUNER_TEA5761 is not set
# CONFIG_MEDIA_TUNER_TEA5767 is not set
CONFIG_MEDIA_TUNER_MT20XX=y
CONFIG_MEDIA_TUNER_MT2060=m
CONFIG_MEDIA_TUNER_MT2063=m
CONFIG_MEDIA_TUNER_MT2266=y
# CONFIG_MEDIA_TUNER_MT2131 is not set
# CONFIG_MEDIA_TUNER_QT1010 is not set
CONFIG_MEDIA_TUNER_XC2028=m
CONFIG_MEDIA_TUNER_XC5000=y
CONFIG_MEDIA_TUNER_XC4000=y
CONFIG_MEDIA_TUNER_MXL5005S=m
CONFIG_MEDIA_TUNER_MXL5007T=m
# CONFIG_MEDIA_TUNER_MC44S803 is not set
CONFIG_MEDIA_TUNER_MAX2165=y
CONFIG_MEDIA_TUNER_TDA18218=y
# CONFIG_MEDIA_TUNER_FC0011 is not set
# CONFIG_MEDIA_TUNER_FC0012 is not set
CONFIG_MEDIA_TUNER_FC0013=y
CONFIG_MEDIA_TUNER_TDA18212=y
# CONFIG_MEDIA_TUNER_E4000 is not set
# CONFIG_MEDIA_TUNER_FC2580 is not set
CONFIG_MEDIA_TUNER_M88RS6000T=y
CONFIG_MEDIA_TUNER_TUA9001=y
CONFIG_MEDIA_TUNER_SI2157=m
# CONFIG_MEDIA_TUNER_IT913X is not set
# CONFIG_MEDIA_TUNER_R820T is not set
CONFIG_MEDIA_TUNER_MXL301RF=m
# CONFIG_MEDIA_TUNER_QM1D1C0042 is not set
CONFIG_MEDIA_TUNER_QM1D1B0004=m

#
# Customise DVB Frontends
#

#
# Tools to develop new frontends
#

#
# Graphics support
#
# CONFIG_AGP is not set
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
# CONFIG_VGA_SWITCHEROO is not set
CONFIG_DRM=m
CONFIG_DRM_DP_AUX_CHARDEV=y
CONFIG_DRM_DEBUG_SELFTEST=m
CONFIG_DRM_KMS_HELPER=m
CONFIG_DRM_KMS_FB_HELPER=y
# CONFIG_DRM_FBDEV_EMULATION is not set
# CONFIG_DRM_LOAD_EDID_FIRMWARE is not set
CONFIG_DRM_TTM=m
CONFIG_DRM_GEM_CMA_HELPER=y
CONFIG_DRM_KMS_CMA_HELPER=y
CONFIG_DRM_VM=y

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=m
CONFIG_DRM_I2C_SIL164=m
CONFIG_DRM_I2C_NXP_TDA998X=m
CONFIG_DRM_I2C_NXP_TDA9950=m
# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set

#
# ACP (Audio CoProcessor) Configuration
#

#
# AMD Library routines
#
# CONFIG_DRM_NOUVEAU is not set
# CONFIG_DRM_I915 is not set
CONFIG_DRM_VGEM=m
# CONFIG_DRM_VMWGFX is not set
# CONFIG_DRM_GMA500 is not set
CONFIG_DRM_UDL=m
# CONFIG_DRM_AST is not set
# CONFIG_DRM_MGAG200 is not set
# CONFIG_DRM_CIRRUS_QEMU is not set
# CONFIG_DRM_QXL is not set
# CONFIG_DRM_BOCHS is not set
CONFIG_DRM_VIRTIO_GPU=m
CONFIG_DRM_PANEL=y

#
# Display Panels
#
CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
CONFIG_DRM_ANALOGIX_ANX78XX=m
# CONFIG_DRM_HISI_HIBMC is not set
CONFIG_DRM_TINYDRM=m
CONFIG_DRM_LEGACY=y
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_R128 is not set
# CONFIG_DRM_MGA is not set
# CONFIG_DRM_VIA is not set
# CONFIG_DRM_SAVAGE is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=m
CONFIG_DRM_LIB_RANDOM=y

#
# Frame buffer Devices
#
CONFIG_FB=m
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB_CFB_FILLRECT=m
CONFIG_FB_CFB_COPYAREA=m
CONFIG_FB_CFB_IMAGEBLIT=m
CONFIG_FB_SYS_FILLRECT=m
CONFIG_FB_SYS_COPYAREA=m
CONFIG_FB_SYS_IMAGEBLIT=m
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=m
CONFIG_FB_DEFERRED_IO=y
# CONFIG_FB_MODE_HELPERS is not set
# CONFIG_FB_TILEBLITTING is not set

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_N411 is not set
# CONFIG_FB_HGA is not set
# CONFIG_FB_OPENCORES is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I740 is not set
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_VIA is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
# CONFIG_FB_GEODE is not set
# CONFIG_FB_SM501 is not set
# CONFIG_FB_SMSCUFX is not set
# CONFIG_FB_UDL is not set
# CONFIG_FB_IBM_GXT4500 is not set
# CONFIG_FB_GOLDFISH is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
# CONFIG_FB_BROADSHEET is not set
# CONFIG_FB_AUO_K190X is not set
# CONFIG_FB_HYPERV is not set
# CONFIG_FB_SM712 is not set
CONFIG_BACKLIGHT_LCD_SUPPORT=y
CONFIG_LCD_CLASS_DEVICE=m
CONFIG_LCD_PLATFORM=m
CONFIG_BACKLIGHT_CLASS_DEVICE=y
CONFIG_BACKLIGHT_GENERIC=m
CONFIG_BACKLIGHT_LM3533=m
CONFIG_BACKLIGHT_PWM=m
CONFIG_BACKLIGHT_DA9052=y
CONFIG_BACKLIGHT_MAX8925=m
CONFIG_BACKLIGHT_APPLE=m
# CONFIG_BACKLIGHT_PM8941_WLED is not set
CONFIG_BACKLIGHT_SAHARA=y
CONFIG_BACKLIGHT_WM831X=y
CONFIG_BACKLIGHT_ADP5520=y
# CONFIG_BACKLIGHT_ADP8860 is not set
CONFIG_BACKLIGHT_ADP8870=y
CONFIG_BACKLIGHT_LM3630A=m
CONFIG_BACKLIGHT_LM3639=y
CONFIG_BACKLIGHT_LP855X=y
# CONFIG_BACKLIGHT_SKY81452 is not set
CONFIG_BACKLIGHT_AS3711=y
CONFIG_BACKLIGHT_GPIO=m
CONFIG_BACKLIGHT_LV5207LP=m
CONFIG_BACKLIGHT_BD6107=m
# CONFIG_BACKLIGHT_ARCXCNN is not set
CONFIG_HDMI=y
# CONFIG_LOGO is not set
# CONFIG_SOUND is not set

#
# HID support
#
CONFIG_HID=m
# CONFIG_HID_BATTERY_STRENGTH is not set
# CONFIG_HIDRAW is not set
# CONFIG_UHID is not set
# CONFIG_HID_GENERIC is not set

#
# Special HID drivers
#
CONFIG_HID_A4TECH=m
CONFIG_HID_ACRUX=m
# CONFIG_HID_ACRUX_FF is not set
# CONFIG_HID_APPLE is not set
CONFIG_HID_ASUS=m
# CONFIG_HID_AUREAL is not set
CONFIG_HID_BELKIN=m
# CONFIG_HID_CHERRY is not set
CONFIG_HID_CHICONY=m
CONFIG_HID_CORSAIR=m
CONFIG_HID_CMEDIA=m
CONFIG_HID_CYPRESS=m
CONFIG_HID_DRAGONRISE=m
CONFIG_DRAGONRISE_FF=y
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELECOM is not set
CONFIG_HID_EZKEY=m
CONFIG_HID_GEMBIRD=m
CONFIG_HID_GFRM=m
# CONFIG_HID_KEYTOUCH is not set
# CONFIG_HID_KYE is not set
CONFIG_HID_WALTOP=m
CONFIG_HID_GYRATION=m
CONFIG_HID_ICADE=m
# CONFIG_HID_ITE is not set
# CONFIG_HID_JABRA is not set
# CONFIG_HID_TWINHAN is not set
CONFIG_HID_KENSINGTON=m
CONFIG_HID_LCPOWER=m
CONFIG_HID_LED=m
CONFIG_HID_LENOVO=m
# CONFIG_HID_LOGITECH is not set
CONFIG_HID_MAGICMOUSE=m
CONFIG_HID_MAYFLASH=m
CONFIG_HID_REDRAGON=m
# CONFIG_HID_MICROSOFT is not set
CONFIG_HID_MONTEREY=m
CONFIG_HID_MULTITOUCH=m
# CONFIG_HID_NTI is not set
CONFIG_HID_ORTEK=m
# CONFIG_HID_PANTHERLORD is not set
# CONFIG_HID_PETALYNX is not set
# CONFIG_HID_PICOLCD is not set
# CONFIG_HID_PLANTRONICS is not set
CONFIG_HID_PRIMAX=m
CONFIG_HID_SAITEK=m
CONFIG_HID_SAMSUNG=m
# CONFIG_HID_SPEEDLINK is not set
CONFIG_HID_STEAM=m
# CONFIG_HID_STEELSERIES is not set
# CONFIG_HID_SUNPLUS is not set
CONFIG_HID_RMI=m
CONFIG_HID_GREENASIA=m
CONFIG_GREENASIA_FF=y
CONFIG_HID_HYPERV_MOUSE=m
# CONFIG_HID_SMARTJOYPLUS is not set
CONFIG_HID_TIVO=m
CONFIG_HID_TOPSEED=m
CONFIG_HID_THINGM=m
CONFIG_HID_THRUSTMASTER=m
# CONFIG_THRUSTMASTER_FF is not set
CONFIG_HID_UDRAW_PS3=m
CONFIG_HID_WIIMOTE=m
# CONFIG_HID_XINMO is not set
# CONFIG_HID_ZEROPLUS is not set
CONFIG_HID_ZYDACRON=m
CONFIG_HID_SENSOR_HUB=m
CONFIG_HID_SENSOR_CUSTOM_SENSOR=m
# CONFIG_HID_ALPS is not set

#
# USB HID support
#
# CONFIG_USB_HID is not set
# CONFIG_HID_PID is not set

#
# USB HID Boot Protocol drivers
#
CONFIG_USB_KBD=y
# CONFIG_USB_MOUSE is not set

#
# I2C HID support
#
CONFIG_I2C_HID=m
CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_PCI=y
# CONFIG_USB_ANNOUNCE_NEW_DEVICES is not set

#
# Miscellaneous USB options
#
# CONFIG_USB_DEFAULT_PERSIST is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
CONFIG_USB_OTG=y
# CONFIG_USB_OTG_WHITELIST is not set
CONFIG_USB_OTG_BLACKLIST_HUB=y
# CONFIG_USB_OTG_FSM is not set
CONFIG_USB_LEDS_TRIGGER_USBPORT=m
CONFIG_USB_MON=m
CONFIG_USB_WUSB=m
CONFIG_USB_WUSB_CBAF=m
CONFIG_USB_WUSB_CBAF_DEBUG=y

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
CONFIG_USB_XHCI_HCD=y
# CONFIG_USB_XHCI_DBGCAP is not set
CONFIG_USB_XHCI_PCI=y
CONFIG_USB_XHCI_PLATFORM=y
# CONFIG_USB_EHCI_HCD is not set
# CONFIG_USB_OXU210HP_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_FOTG210_HCD is not set
# CONFIG_USB_OHCI_HCD is not set
# CONFIG_USB_UHCI_HCD is not set
# CONFIG_USB_SL811_HCD is not set
CONFIG_USB_R8A66597_HCD=y
# CONFIG_USB_WHCI_HCD is not set
CONFIG_USB_HWA_HCD=m
CONFIG_USB_HCD_SSB=m
CONFIG_USB_HCD_TEST_MODE=y

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
CONFIG_USB_PRINTER=m
# CONFIG_USB_WDM is not set
# CONFIG_USB_TMC is not set

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USBIP_CORE is not set
CONFIG_USB_MUSB_HDRC=y
CONFIG_USB_MUSB_HOST=y

#
# Platform Glue Layer
#

#
# MUSB DMA mode
#
CONFIG_MUSB_PIO_ONLY=y
CONFIG_USB_DWC3=m
# CONFIG_USB_DWC3_ULPI is not set
CONFIG_USB_DWC3_HOST=y

#
# Platform Glue Driver Support
#
CONFIG_USB_DWC3_PCI=m
CONFIG_USB_DWC2=m
CONFIG_USB_DWC2_HOST=y

#
# Gadget/Dual-role mode requires USB Gadget support to be enabled
#
# CONFIG_USB_DWC2_PCI is not set
CONFIG_USB_DWC2_DEBUG=y
# CONFIG_USB_DWC2_VERBOSE is not set
# CONFIG_USB_DWC2_TRACK_MISSED_SOFS is not set
CONFIG_USB_DWC2_DEBUG_PERIODIC=y
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
CONFIG_USB_EMI62=y
# CONFIG_USB_EMI26 is not set
CONFIG_USB_ADUTUX=y
CONFIG_USB_SEVSEG=y
CONFIG_USB_RIO500=m
CONFIG_USB_LEGOTOWER=m
CONFIG_USB_LCD=m
CONFIG_USB_CYPRESS_CY7C63=y
CONFIG_USB_CYTHERM=y
CONFIG_USB_IDMOUSE=y
# CONFIG_USB_FTDI_ELAN is not set
CONFIG_USB_APPLEDISPLAY=y
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TRANCEVIBRATOR is not set
# CONFIG_USB_IOWARRIOR is not set
CONFIG_USB_TEST=m
CONFIG_USB_EHSET_TEST_FIXTURE=y
# CONFIG_USB_ISIGHTFW is not set
CONFIG_USB_YUREX=y
CONFIG_USB_EZUSB_FX2=m
# CONFIG_USB_HUB_USB251XB is not set
CONFIG_USB_HSIC_USB3503=y
# CONFIG_USB_HSIC_USB4604 is not set
# CONFIG_USB_LINK_LAYER_TEST is not set
CONFIG_USB_CHAOSKEY=m

#
# USB Physical Layer drivers
#
CONFIG_USB_PHY=y
CONFIG_NOP_USB_XCEIV=y
CONFIG_USB_GPIO_VBUS=m
CONFIG_TAHVO_USB=m
# CONFIG_TAHVO_USB_HOST_BY_DEFAULT is not set
# CONFIG_USB_ISP1301 is not set
# CONFIG_USB_GADGET is not set
# CONFIG_TYPEC is not set
# CONFIG_USB_ROLES_INTEL_XHCI is not set
# CONFIG_USB_LED_TRIG is not set
CONFIG_USB_ULPI_BUS=y
CONFIG_USB_ROLE_SWITCH=m
CONFIG_UWB=m
CONFIG_UWB_HWA=m
# CONFIG_UWB_WHCI is not set
# CONFIG_UWB_I1480U is not set
# CONFIG_MMC is not set
CONFIG_MEMSTICK=m
# CONFIG_MEMSTICK_DEBUG is not set

#
# MemoryStick drivers
#
CONFIG_MEMSTICK_UNSAFE_RESUME=y

#
# MemoryStick Host Controller Drivers
#
# CONFIG_MEMSTICK_TIFM_MS is not set
# CONFIG_MEMSTICK_JMICRON_38X is not set
# CONFIG_MEMSTICK_R592 is not set
# CONFIG_MEMSTICK_REALTEK_USB is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_CLASS_FLASH=y
CONFIG_LEDS_BRIGHTNESS_HW_CHANGED=y

#
# LED drivers
#
# CONFIG_LEDS_AS3645A is not set
# CONFIG_LEDS_LM3530 is not set
# CONFIG_LEDS_LM3533 is not set
CONFIG_LEDS_LM3642=y
# CONFIG_LEDS_LM3601X is not set
CONFIG_LEDS_MT6323=m
# CONFIG_LEDS_NET48XX is not set
CONFIG_LEDS_WRAP=m
CONFIG_LEDS_PCA9532=y
# CONFIG_LEDS_PCA9532_GPIO is not set
# CONFIG_LEDS_GPIO is not set
CONFIG_LEDS_LP3944=y
# CONFIG_LEDS_LP3952 is not set
CONFIG_LEDS_LP55XX_COMMON=m
CONFIG_LEDS_LP5521=m
CONFIG_LEDS_LP5523=m
# CONFIG_LEDS_LP5562 is not set
CONFIG_LEDS_LP8501=m
CONFIG_LEDS_PCA955X=y
CONFIG_LEDS_PCA955X_GPIO=y
CONFIG_LEDS_PCA963X=y
CONFIG_LEDS_WM831X_STATUS=y
CONFIG_LEDS_DA9052=y
CONFIG_LEDS_PWM=y
# CONFIG_LEDS_REGULATOR is not set
CONFIG_LEDS_BD2802=y
# CONFIG_LEDS_LT3593 is not set
CONFIG_LEDS_ADP5520=y
CONFIG_LEDS_MC13783=m
CONFIG_LEDS_TCA6507=m
CONFIG_LEDS_TLC591XX=y
CONFIG_LEDS_LM355x=m
CONFIG_LEDS_OT200=y
# CONFIG_LEDS_MENF21BMC is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=m
CONFIG_LEDS_MLXREG=y
# CONFIG_LEDS_USER is not set
CONFIG_LEDS_NIC78BX=y

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
# CONFIG_LEDS_TRIGGER_TIMER is not set
CONFIG_LEDS_TRIGGER_ONESHOT=m
CONFIG_LEDS_TRIGGER_MTD=y
# CONFIG_LEDS_TRIGGER_HEARTBEAT is not set
CONFIG_LEDS_TRIGGER_BACKLIGHT=m
# CONFIG_LEDS_TRIGGER_CPU is not set
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
CONFIG_LEDS_TRIGGER_GPIO=m
# CONFIG_LEDS_TRIGGER_DEFAULT_ON is not set

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=y
CONFIG_LEDS_TRIGGER_CAMERA=y
# CONFIG_LEDS_TRIGGER_PANIC is not set
# CONFIG_LEDS_TRIGGER_NETDEV is not set
CONFIG_ACCESSIBILITY=y
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
# CONFIG_RTC_HCTOSYS is not set
# CONFIG_RTC_SYSTOHC is not set
CONFIG_RTC_DEBUG=y
CONFIG_RTC_NVMEM=y

#
# RTC interfaces
#
# CONFIG_RTC_INTF_SYSFS is not set
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
CONFIG_RTC_DRV_TEST=m

#
# I2C RTC drivers
#
CONFIG_RTC_DRV_ABB5ZES3=m
CONFIG_RTC_DRV_ABX80X=y
CONFIG_RTC_DRV_DS1307=y
CONFIG_RTC_DRV_DS1307_HWMON=y
# CONFIG_RTC_DRV_DS1307_CENTURY is not set
# CONFIG_RTC_DRV_DS1374 is not set
CONFIG_RTC_DRV_DS1672=m
CONFIG_RTC_DRV_MAX6900=m
CONFIG_RTC_DRV_MAX8907=m
CONFIG_RTC_DRV_MAX8925=y
CONFIG_RTC_DRV_RS5C372=y
CONFIG_RTC_DRV_ISL1208=y
CONFIG_RTC_DRV_ISL12022=m
# CONFIG_RTC_DRV_X1205 is not set
CONFIG_RTC_DRV_PCF8523=m
CONFIG_RTC_DRV_PCF85063=y
# CONFIG_RTC_DRV_PCF85363 is not set
CONFIG_RTC_DRV_PCF8563=y
# CONFIG_RTC_DRV_PCF8583 is not set
# CONFIG_RTC_DRV_M41T80 is not set
# CONFIG_RTC_DRV_BQ32K is not set
# CONFIG_RTC_DRV_PALMAS is not set
CONFIG_RTC_DRV_S35390A=y
CONFIG_RTC_DRV_FM3130=y
CONFIG_RTC_DRV_RX8010=m
CONFIG_RTC_DRV_RX8581=y
CONFIG_RTC_DRV_RX8025=m
# CONFIG_RTC_DRV_EM3027 is not set
CONFIG_RTC_DRV_RV8803=y
CONFIG_RTC_DRV_S5M=m

#
# SPI RTC drivers
#
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=y
CONFIG_RTC_DRV_DS3232_HWMON=y
CONFIG_RTC_DRV_PCF2127=m
CONFIG_RTC_DRV_RV3029C2=m
CONFIG_RTC_DRV_RV3029_HWMON=y

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=m
CONFIG_RTC_DRV_DS1286=y
CONFIG_RTC_DRV_DS1511=y
CONFIG_RTC_DRV_DS1553=y
CONFIG_RTC_DRV_DS1685_FAMILY=m
# CONFIG_RTC_DRV_DS1685 is not set
# CONFIG_RTC_DRV_DS1689 is not set
# CONFIG_RTC_DRV_DS17285 is not set
CONFIG_RTC_DRV_DS17485=y
# CONFIG_RTC_DRV_DS17885 is not set
# CONFIG_RTC_DS1685_PROC_REGS is not set
# CONFIG_RTC_DS1685_SYSFS_REGS is not set
CONFIG_RTC_DRV_DS1742=m
CONFIG_RTC_DRV_DS2404=m
CONFIG_RTC_DRV_DA9052=m
CONFIG_RTC_DRV_DA9063=m
CONFIG_RTC_DRV_STK17TA8=m
# CONFIG_RTC_DRV_M48T86 is not set
# CONFIG_RTC_DRV_M48T35 is not set
CONFIG_RTC_DRV_M48T59=y
CONFIG_RTC_DRV_MSM6242=y
# CONFIG_RTC_DRV_BQ4802 is not set
CONFIG_RTC_DRV_RP5C01=y
CONFIG_RTC_DRV_V3020=m
# CONFIG_RTC_DRV_WM831X is not set

#
# on-CPU RTC drivers
#
CONFIG_RTC_DRV_FTRTC010=m
CONFIG_RTC_DRV_MC13XXX=m
CONFIG_RTC_DRV_MT6397=m

#
# HID Sensor RTC drivers
#
# CONFIG_DMADEVICES is not set

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
# CONFIG_SW_SYNC is not set
# CONFIG_AUXDISPLAY is not set
CONFIG_UIO=m
# CONFIG_UIO_CIF is not set
# CONFIG_UIO_PDRV_GENIRQ is not set
CONFIG_UIO_DMEM_GENIRQ=m
# CONFIG_UIO_AEC is not set
# CONFIG_UIO_SERCOS3 is not set
# CONFIG_UIO_PCI_GENERIC is not set
# CONFIG_UIO_NETX is not set
# CONFIG_UIO_PRUSS is not set
# CONFIG_UIO_MF624 is not set
CONFIG_UIO_HV_GENERIC=m
CONFIG_VIRT_DRIVERS=y
# CONFIG_VBOXGUEST is not set
CONFIG_VIRTIO=m
CONFIG_VIRTIO_MENU=y
# CONFIG_VIRTIO_PCI is not set
CONFIG_VIRTIO_BALLOON=m
# CONFIG_VIRTIO_INPUT is not set
# CONFIG_VIRTIO_MMIO is not set

#
# Microsoft Hyper-V guest support
#
CONFIG_HYPERV=y
# CONFIG_HYPERV_BALLOON is not set
# CONFIG_STAGING is not set
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACER_WMI=m
CONFIG_ACER_WIRELESS=y
CONFIG_ACERHDF=y
CONFIG_ALIENWARE_WMI=m
CONFIG_ASUS_LAPTOP=m
CONFIG_DELL_SMBIOS=m
# CONFIG_DELL_SMBIOS_WMI is not set
# CONFIG_DELL_SMBIOS_SMM is not set
CONFIG_DELL_WMI_AIO=m
CONFIG_DELL_WMI_LED=m
# CONFIG_DELL_SMO8800 is not set
CONFIG_FUJITSU_LAPTOP=y
CONFIG_FUJITSU_TABLET=y
CONFIG_GPD_POCKET_FAN=m
CONFIG_TC1100_WMI=m
CONFIG_HP_ACCEL=y
# CONFIG_HP_WIRELESS is not set
CONFIG_HP_WMI=m
CONFIG_PANASONIC_LAPTOP=y
CONFIG_SENSORS_HDAPS=m
CONFIG_INTEL_MENLOW=m
CONFIG_ASUS_WIRELESS=y
CONFIG_ACPI_WMI=m
CONFIG_WMI_BMOF=m
CONFIG_INTEL_WMI_THUNDERBOLT=m
CONFIG_MSI_WMI=m
CONFIG_PEAQ_WMI=m
CONFIG_TOPSTAR_LAPTOP=y
# CONFIG_ACPI_TOSHIBA is not set
CONFIG_TOSHIBA_BT_RFKILL=y
# CONFIG_TOSHIBA_HAPS is not set
CONFIG_TOSHIBA_WMI=m
# CONFIG_ACPI_CMPC is not set
# CONFIG_INTEL_CHT_INT33FE is not set
# CONFIG_INTEL_INT0002_VGPIO is not set
CONFIG_INTEL_HID_EVENT=y
# CONFIG_INTEL_VBTN is not set
# CONFIG_INTEL_IPS is not set
# CONFIG_INTEL_PMC_CORE is not set
# CONFIG_IBM_RTL is not set
CONFIG_SAMSUNG_LAPTOP=y
CONFIG_MXM_WMI=m
# CONFIG_SAMSUNG_Q10 is not set
# CONFIG_APPLE_GMUX is not set
CONFIG_INTEL_RST=m
CONFIG_INTEL_SMARTCONNECT=y
CONFIG_PVPANIC=m
# CONFIG_INTEL_PMC_IPC is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
# CONFIG_SURFACE_3_BUTTON is not set
# CONFIG_INTEL_PUNIT_IPC is not set
# CONFIG_MLX_PLATFORM is not set
CONFIG_PMC_ATOM=y
# CONFIG_GOLDFISH_BUS is not set
CONFIG_GOLDFISH_PIPE=m
# CONFIG_CHROME_PLATFORMS is not set
CONFIG_MELLANOX_PLATFORM=y
# CONFIG_MLXREG_HOTPLUG is not set
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y

#
# Common Clock Framework
#
# CONFIG_COMMON_CLK_WM831X is not set
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI544 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_S2MPS11 is not set
# CONFIG_COMMON_CLK_PALMAS is not set
# CONFIG_COMMON_CLK_PWM is not set
CONFIG_HWSPINLOCK=y

#
# Clock Source drivers
#
CONFIG_CLKSRC_I8253=y
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
CONFIG_MAILBOX=y
CONFIG_PCC=y
CONFIG_ALTERA_MBOX=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#

#
# Remoteproc drivers
#
CONFIG_REMOTEPROC=m

#
# Rpmsg drivers
#
CONFIG_RPMSG=y
# CONFIG_RPMSG_CHAR is not set
CONFIG_RPMSG_QCOM_GLINK_NATIVE=y
CONFIG_RPMSG_QCOM_GLINK_RPM=y
# CONFIG_RPMSG_VIRTIO is not set
CONFIG_SOUNDWIRE=y

#
# SoundWire Devices
#

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#

#
# Broadcom SoC drivers
#

#
# i.MX SoC drivers
#

#
# Qualcomm SoC drivers
#
CONFIG_SOC_TI=y

#
# Xilinx SoC drivers
#
# CONFIG_XILINX_VCU is not set
CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
# CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND is not set
CONFIG_DEVFREQ_GOV_PERFORMANCE=m
CONFIG_DEVFREQ_GOV_POWERSAVE=m
CONFIG_DEVFREQ_GOV_USERSPACE=m
# CONFIG_DEVFREQ_GOV_PASSIVE is not set

#
# DEVFREQ Drivers
#
CONFIG_PM_DEVFREQ_EVENT=y
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
CONFIG_EXTCON_ADC_JACK=m
CONFIG_EXTCON_AXP288=m
CONFIG_EXTCON_GPIO=y
CONFIG_EXTCON_INTEL_INT3496=m
# CONFIG_EXTCON_MAX14577 is not set
CONFIG_EXTCON_MAX3355=m
CONFIG_EXTCON_MAX77693=m
# CONFIG_EXTCON_MAX77843 is not set
CONFIG_EXTCON_PALMAS=m
CONFIG_EXTCON_RT8973A=m
CONFIG_EXTCON_SM5502=y
# CONFIG_EXTCON_USB_GPIO is not set
# CONFIG_MEMORY is not set
CONFIG_IIO=m
CONFIG_IIO_BUFFER=y
CONFIG_IIO_BUFFER_CB=m
# CONFIG_IIO_BUFFER_HW_CONSUMER is not set
CONFIG_IIO_KFIFO_BUF=m
CONFIG_IIO_TRIGGERED_BUFFER=m
CONFIG_IIO_CONFIGFS=m
CONFIG_IIO_TRIGGER=y
CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
CONFIG_IIO_SW_DEVICE=m
CONFIG_IIO_SW_TRIGGER=m

#
# Accelerometers
#
CONFIG_ADXL345=m
CONFIG_ADXL345_I2C=m
CONFIG_BMA180=m
CONFIG_BMC150_ACCEL=m
CONFIG_BMC150_ACCEL_I2C=m
CONFIG_DA280=m
# CONFIG_DA311 is not set
# CONFIG_DMARD09 is not set
# CONFIG_DMARD10 is not set
CONFIG_HID_SENSOR_ACCEL_3D=m
CONFIG_IIO_CROS_EC_ACCEL_LEGACY=m
# CONFIG_KXSD9 is not set
# CONFIG_KXCJK1013 is not set
CONFIG_MC3230=m
CONFIG_MMA7455=m
CONFIG_MMA7455_I2C=m
CONFIG_MMA7660=m
CONFIG_MMA8452=m
CONFIG_MMA9551_CORE=m
CONFIG_MMA9551=m
# CONFIG_MMA9553 is not set
# CONFIG_MXC4005 is not set
CONFIG_MXC6255=m
CONFIG_STK8312=m
# CONFIG_STK8BA50 is not set

#
# Analog to digital converters
#
# CONFIG_AD7291 is not set
# CONFIG_AD799X is not set
CONFIG_AXP20X_ADC=m
CONFIG_AXP288_ADC=m
# CONFIG_CC10001_ADC is not set
CONFIG_DLN2_ADC=m
# CONFIG_HX711 is not set
CONFIG_INA2XX_ADC=m
CONFIG_LTC2471=m
# CONFIG_LTC2485 is not set
# CONFIG_LTC2497 is not set
CONFIG_MAX1363=m
CONFIG_MAX9611=m
# CONFIG_MCP3422 is not set
CONFIG_MEN_Z188_ADC=m
CONFIG_NAU7802=m
CONFIG_PALMAS_GPADC=m
CONFIG_QCOM_VADC_COMMON=m
CONFIG_QCOM_SPMI_IADC=m
CONFIG_QCOM_SPMI_VADC=m
CONFIG_STX104=m
CONFIG_TI_ADC081C=m
CONFIG_TI_ADS1015=m
CONFIG_VIPERBOARD_ADC=m

#
# Analog Front Ends
#

#
# Amplifiers
#

#
# Chemical Sensors
#
CONFIG_ATLAS_PH_SENSOR=m
CONFIG_CCS811=m
CONFIG_IAQCORE=m
CONFIG_VZ89X=m

#
# Hid Sensor IIO Common
#
CONFIG_HID_SENSOR_IIO_COMMON=m
CONFIG_HID_SENSOR_IIO_TRIGGER=m
CONFIG_IIO_MS_SENSORS_I2C=m

#
# SSP Sensor Common
#
CONFIG_IIO_ST_SENSORS_I2C=m
CONFIG_IIO_ST_SENSORS_CORE=m

#
# Counters
#
# CONFIG_104_QUAD_8 is not set

#
# Digital to analog converters
#
CONFIG_AD5064=m
CONFIG_AD5380=m
CONFIG_AD5446=m
# CONFIG_AD5593R is not set
# CONFIG_AD5696_I2C is not set
CONFIG_CIO_DAC=m
# CONFIG_DS4424 is not set
CONFIG_M62332=m
CONFIG_MAX517=m
CONFIG_MCP4725=m
CONFIG_TI_DAC5571=m

#
# IIO dummy driver
#
CONFIG_IIO_SIMPLE_DUMMY=m
# CONFIG_IIO_SIMPLE_DUMMY_EVENTS is not set
CONFIG_IIO_SIMPLE_DUMMY_BUFFER=y

#
# Frequency Synthesizers DDS/PLL
#

#
# Clock Generator/Distribution
#

#
# Phase-Locked Loop (PLL) frequency synthesizers
#

#
# Digital gyroscope sensors
#
CONFIG_BMG160=m
CONFIG_BMG160_I2C=m
CONFIG_HID_SENSOR_GYRO_3D=m
CONFIG_MPU3050=m
CONFIG_MPU3050_I2C=m
CONFIG_IIO_ST_GYRO_3AXIS=m
CONFIG_IIO_ST_GYRO_I2C_3AXIS=m
CONFIG_ITG3200=m

#
# Health Sensors
#

#
# Heart Rate Monitors
#
CONFIG_AFE4404=m
CONFIG_MAX30100=m
# CONFIG_MAX30102 is not set

#
# Humidity sensors
#
CONFIG_AM2315=m
CONFIG_DHT11=m
CONFIG_HDC100X=m
CONFIG_HID_SENSOR_HUMIDITY=m
CONFIG_HTS221=m
CONFIG_HTS221_I2C=m
CONFIG_HTU21=m
CONFIG_SI7005=m
CONFIG_SI7020=m

#
# Inertial measurement units
#
CONFIG_BMI160=m
CONFIG_BMI160_I2C=m
# CONFIG_KMX61 is not set
CONFIG_INV_MPU6050_IIO=m
CONFIG_INV_MPU6050_I2C=m
CONFIG_IIO_ST_LSM6DSX=m
CONFIG_IIO_ST_LSM6DSX_I2C=m

#
# Light sensors
#
CONFIG_ACPI_ALS=m
CONFIG_ADJD_S311=m
# CONFIG_AL3320A is not set
CONFIG_APDS9300=m
# CONFIG_APDS9960 is not set
CONFIG_BH1750=m
CONFIG_BH1780=m
# CONFIG_CM32181 is not set
# CONFIG_CM3232 is not set
# CONFIG_CM3323 is not set
# CONFIG_CM36651 is not set
# CONFIG_GP2AP020A00F is not set
# CONFIG_SENSORS_ISL29018 is not set
CONFIG_SENSORS_ISL29028=m
# CONFIG_ISL29125 is not set
CONFIG_HID_SENSOR_ALS=m
# CONFIG_HID_SENSOR_PROX is not set
CONFIG_JSA1212=m
CONFIG_RPR0521=m
CONFIG_SENSORS_LM3533=m
CONFIG_LTR501=m
CONFIG_LV0104CS=m
CONFIG_MAX44000=m
CONFIG_OPT3001=m
CONFIG_PA12203001=m
CONFIG_SI1145=m
CONFIG_STK3310=m
CONFIG_ST_UVIS25=m
CONFIG_ST_UVIS25_I2C=m
CONFIG_TCS3414=m
# CONFIG_TCS3472 is not set
# CONFIG_SENSORS_TSL2563 is not set
CONFIG_TSL2583=m
CONFIG_TSL2772=m
CONFIG_TSL4531=m
CONFIG_US5182D=m
CONFIG_VCNL4000=m
# CONFIG_VEML6070 is not set
# CONFIG_VL6180 is not set
CONFIG_ZOPT2201=m

#
# Magnetometer sensors
#
CONFIG_AK8975=m
CONFIG_AK09911=m
CONFIG_BMC150_MAGN=m
CONFIG_BMC150_MAGN_I2C=m
# CONFIG_MAG3110 is not set
# CONFIG_HID_SENSOR_MAGNETOMETER_3D is not set
CONFIG_MMC35240=m
CONFIG_IIO_ST_MAGN_3AXIS=m
CONFIG_IIO_ST_MAGN_I2C_3AXIS=m
CONFIG_SENSORS_HMC5843=m
CONFIG_SENSORS_HMC5843_I2C=m

#
# Multiplexers
#

#
# Inclinometer sensors
#
# CONFIG_HID_SENSOR_INCLINOMETER_3D is not set
CONFIG_HID_SENSOR_DEVICE_ROTATION=m

#
# Triggers - standalone
#
CONFIG_IIO_HRTIMER_TRIGGER=m
# CONFIG_IIO_INTERRUPT_TRIGGER is not set
# CONFIG_IIO_TIGHTLOOP_TRIGGER is not set
# CONFIG_IIO_SYSFS_TRIGGER is not set

#
# Digital potentiometers
#
CONFIG_AD5272=m
CONFIG_DS1803=m
CONFIG_MCP4018=m
CONFIG_MCP4531=m
# CONFIG_TPL0102 is not set

#
# Digital potentiostats
#
CONFIG_LMP91000=m

#
# Pressure sensors
#
CONFIG_ABP060MG=m
CONFIG_BMP280=m
CONFIG_BMP280_I2C=m
# CONFIG_HID_SENSOR_PRESS is not set
CONFIG_HP03=m
CONFIG_MPL115=m
CONFIG_MPL115_I2C=m
CONFIG_MPL3115=m
CONFIG_MS5611=m
CONFIG_MS5611_I2C=m
CONFIG_MS5637=m
CONFIG_IIO_ST_PRESS=m
CONFIG_IIO_ST_PRESS_I2C=m
CONFIG_T5403=m
# CONFIG_HP206C is not set
CONFIG_ZPA2326=m
CONFIG_ZPA2326_I2C=m

#
# Lightning sensors
#

#
# Proximity and distance sensors
#
CONFIG_LIDAR_LITE_V2=m
# CONFIG_RFD77402 is not set
# CONFIG_SRF04 is not set
CONFIG_SX9500=m
CONFIG_SRF08=m

#
# Resolver to digital converters
#

#
# Temperature sensors
#
CONFIG_HID_SENSOR_TEMP=m
# CONFIG_MLX90614 is not set
CONFIG_MLX90632=m
# CONFIG_TMP006 is not set
CONFIG_TMP007=m
CONFIG_TSYS01=m
CONFIG_TSYS02D=m
# CONFIG_NTB is not set
# CONFIG_VME_BUS is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_LPSS_PCI is not set
# CONFIG_PWM_LPSS_PLATFORM is not set
CONFIG_PWM_PCA9685=m

#
# IRQ chip support
#
CONFIG_ARM_GIC_MAX_NR=1
CONFIG_IPACK_BUS=m
# CONFIG_BOARD_TPCI200 is not set
# CONFIG_SERIAL_IPOCTAL is not set
# CONFIG_RESET_CONTROLLER is not set
# CONFIG_FMC is not set

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
CONFIG_BCM_KONA_USB2_PHY=m
CONFIG_PHY_PXA_28NM_HSIC=m
CONFIG_PHY_PXA_28NM_USB2=y
# CONFIG_PHY_CPCAP_USB is not set
CONFIG_PHY_QCOM_USB_HS=y
# CONFIG_PHY_QCOM_USB_HSIC is not set
CONFIG_PHY_SAMSUNG_USB2=m
CONFIG_PHY_TUSB1210=y
# CONFIG_POWERCAP is not set
CONFIG_MCB=y
# CONFIG_MCB_PCI is not set
CONFIG_MCB_LPC=m

#
# Performance monitor support
#
# CONFIG_RAS is not set
# CONFIG_THUNDERBOLT is not set

#
# Android
#
# CONFIG_ANDROID is not set
CONFIG_DAX=y
CONFIG_NVMEM=y

#
# HW tracing support
#
CONFIG_STM=y
# CONFIG_STM_DUMMY is not set
CONFIG_STM_SOURCE_CONSOLE=m
# CONFIG_STM_SOURCE_HEARTBEAT is not set
# CONFIG_STM_SOURCE_FTRACE is not set
CONFIG_INTEL_TH=y
# CONFIG_INTEL_TH_PCI is not set
CONFIG_INTEL_TH_ACPI=y
CONFIG_INTEL_TH_GTH=m
CONFIG_INTEL_TH_STH=m
CONFIG_INTEL_TH_MSU=y
CONFIG_INTEL_TH_PTI=y
CONFIG_INTEL_TH_DEBUG=y
CONFIG_FPGA=y
CONFIG_ALTERA_PR_IP_CORE=y
# CONFIG_FPGA_MGR_ALTERA_CVP is not set
CONFIG_FPGA_BRIDGE=y
CONFIG_XILINX_PR_DECOUPLER=y
CONFIG_FPGA_REGION=y
CONFIG_PM_OPP=y
# CONFIG_SIOX is not set
# CONFIG_SLIMBUS is not set

#
# Firmware Drivers
#
CONFIG_EDD=m
CONFIG_EDD_OFF=y
# CONFIG_FIRMWARE_MEMMAP is not set
CONFIG_DELL_RBU=m
CONFIG_DCDBAS=m
CONFIG_ISCSI_IBFT_FIND=y
# CONFIG_FW_CFG_SYSFS is not set
CONFIG_GOOGLE_FIRMWARE=y
# CONFIG_GOOGLE_COREBOOT_TABLE_ACPI is not set

#
# Tegra firmware driver
#

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
CONFIG_MANDATORY_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
CONFIG_QUOTA=y
# CONFIG_QUOTA_NETLINK_INTERFACE is not set
CONFIG_PRINT_QUOTA_WARNING=y
CONFIG_QUOTA_DEBUG=y
CONFIG_QFMT_V1=y
# CONFIG_QFMT_V2 is not set
CONFIG_QUOTACTL=y
CONFIG_AUTOFS_FS=m
CONFIG_FUSE_FS=y
CONFIG_CUSE=m
# CONFIG_OVERLAY_FS is not set

#
# Caches
#
CONFIG_FSCACHE=y
# CONFIG_FSCACHE_STATS is not set
# CONFIG_FSCACHE_HISTOGRAM is not set
CONFIG_FSCACHE_DEBUG=y
# CONFIG_FSCACHE_OBJECT_LIST is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_PROC_KCORE is not set
CONFIG_PROC_VMCORE=y
# CONFIG_PROC_VMCORE_DEVICE_DUMP is not set
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
# CONFIG_PROC_CHILDREN is not set
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
# CONFIG_HUGETLBFS is not set
CONFIG_MEMFD_CREATE=y
CONFIG_CONFIGFS_FS=y
CONFIG_MISC_FILESYSTEMS=y
CONFIG_ORANGEFS_FS=m
# CONFIG_ECRYPT_FS is not set
# CONFIG_JFFS2_FS is not set
# CONFIG_UBIFS_FS is not set
CONFIG_CRAMFS=m
# CONFIG_CRAMFS_MTD is not set
CONFIG_ROMFS_FS=m
CONFIG_ROMFS_BACKED_BY_MTD=y
CONFIG_ROMFS_ON_MTD=y
# CONFIG_PSTORE is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V2=y
CONFIG_NFS_V3=y
# CONFIG_NFS_V3_ACL is not set
CONFIG_NFS_V4=m
# CONFIG_NFS_SWAP is not set
# CONFIG_NFS_V4_1 is not set
# CONFIG_ROOT_NFS is not set
# CONFIG_NFS_FSCACHE is not set
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
# CONFIG_NFSD is not set
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=m
CONFIG_RPCSEC_GSS_KRB5=m
# CONFIG_SUNRPC_DEBUG is not set
# CONFIG_CEPH_FS is not set
CONFIG_CIFS=m
# CONFIG_CIFS_STATS is not set
# CONFIG_CIFS_WEAK_PW_HASH is not set
# CONFIG_CIFS_UPCALL is not set
# CONFIG_CIFS_XATTR is not set
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
# CONFIG_CIFS_DFS_UPCALL is not set
# CONFIG_CIFS_SMB311 is not set
# CONFIG_CIFS_FSCACHE is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
# CONFIG_NLS_CODEPAGE_437 is not set
CONFIG_NLS_CODEPAGE_737=m
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
CONFIG_NLS_CODEPAGE_855=y
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=y
CONFIG_NLS_CODEPAGE_861=m
# CONFIG_NLS_CODEPAGE_862 is not set
CONFIG_NLS_CODEPAGE_863=m
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
CONFIG_NLS_CODEPAGE_936=y
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=y
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
CONFIG_NLS_CODEPAGE_1250=y
# CONFIG_NLS_CODEPAGE_1251 is not set
# CONFIG_NLS_ASCII is not set
CONFIG_NLS_ISO8859_1=y
# CONFIG_NLS_ISO8859_2 is not set
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=y
# CONFIG_NLS_ISO8859_5 is not set
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=y
CONFIG_NLS_ISO8859_9=y
# CONFIG_NLS_ISO8859_13 is not set
CONFIG_NLS_ISO8859_14=y
CONFIG_NLS_ISO8859_15=y
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
CONFIG_NLS_MAC_ROMAN=y
CONFIG_NLS_MAC_CELTIC=m
CONFIG_NLS_MAC_CENTEURO=m
# CONFIG_NLS_MAC_CROATIAN is not set
CONFIG_NLS_MAC_CYRILLIC=y
CONFIG_NLS_MAC_GAELIC=y
# CONFIG_NLS_MAC_GREEK is not set
# CONFIG_NLS_MAC_ICELAND is not set
# CONFIG_NLS_MAC_INUIT is not set
CONFIG_NLS_MAC_ROMANIAN=y
CONFIG_NLS_MAC_TURKISH=m
CONFIG_NLS_UTF8=m
# CONFIG_DLM is not set

#
# Kernel hacking
#
CONFIG_TRACE_IRQFLAGS_SUPPORT=y

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
CONFIG_BOOT_PRINTK_DELAY=y
CONFIG_DYNAMIC_DEBUG=y

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_INFO_REDUCED=y
# CONFIG_DEBUG_INFO_SPLIT is not set
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_GDB_SCRIPTS is not set
CONFIG_ENABLE_WARN_DEPRECATED=y
CONFIG_ENABLE_MUST_CHECK=y
CONFIG_FRAME_WARN=2048
# CONFIG_STRIP_ASM_SYMS is not set
# CONFIG_READABLE_ASM is not set
CONFIG_UNUSED_SYMBOLS=y
CONFIG_PAGE_OWNER=y
CONFIG_DEBUG_FS=y
CONFIG_HEADERS_CHECK=y
# CONFIG_DEBUG_SECTION_MISMATCH is not set
# CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
CONFIG_FRAME_POINTER=y
CONFIG_DEBUG_FORCE_WEAK_PER_CPU=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_DEBUG_KERNEL=y

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
CONFIG_DEBUG_PAGEALLOC=y
# CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT is not set
CONFIG_PAGE_POISONING=y
# CONFIG_PAGE_POISONING_NO_SANITY is not set
CONFIG_PAGE_POISONING_ZERO=y
# CONFIG_DEBUG_PAGE_REF is not set
# CONFIG_DEBUG_RODATA_TEST is not set
# CONFIG_DEBUG_OBJECTS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
CONFIG_DEBUG_STACK_USAGE=y
CONFIG_DEBUG_VM=y
CONFIG_DEBUG_VM_VMACACHE=y
# CONFIG_DEBUG_VM_RB is not set
CONFIG_DEBUG_VM_PGFLAGS=y
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
CONFIG_DEBUG_VIRTUAL=y
CONFIG_DEBUG_MEMORY_INIT=y
# CONFIG_DEBUG_PER_CPU_MAPS is not set
# CONFIG_DEBUG_HIGHMEM is not set
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
CONFIG_DEBUG_SHIRQ=y

#
# Debug Lockups and Hangs
#
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=1
# CONFIG_DETECT_HUNG_TASK is not set
CONFIG_WQ_WATCHDOG=y
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# CONFIG_SCHED_STACK_END_CHECK is not set
CONFIG_DEBUG_TIMEKEEPING=y

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
# CONFIG_PROVE_LOCKING is not set
CONFIG_LOCK_STAT=y
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
CONFIG_DEBUG_RWSEMS=y
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_LOCKDEP=y
# CONFIG_DEBUG_LOCKDEP is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
CONFIG_LOCK_TORTURE_TEST=m
CONFIG_WW_MUTEX_SELFTEST=y
CONFIG_TRACE_IRQFLAGS=y
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_DEBUG_LIST=y
# CONFIG_DEBUG_PI_LIST is not set
CONFIG_DEBUG_SG=y
CONFIG_DEBUG_NOTIFIERS=y
# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_TORTURE_TEST=y
CONFIG_RCU_PERF_TEST=y
CONFIG_RCU_TORTURE_TEST=m
CONFIG_RCU_CPU_STALL_TIMEOUT=21
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
CONFIG_DEBUG_WQ_FORCE_RR_CPU=y
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
CONFIG_NOTIFIER_ERROR_INJECTION=m
CONFIG_PM_NOTIFIER_ERROR_INJECT=m
# CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
# CONFIG_FAULT_INJECTION is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
CONFIG_LATENCYTOP=y
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_RING_BUFFER_ALLOW_SWAP=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=y
# CONFIG_PREEMPTIRQ_EVENTS is not set
CONFIG_IRQSOFF_TRACER=y
CONFIG_SCHED_TRACER=y
CONFIG_HWLAT_TRACER=y
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP=y
CONFIG_TRACE_BRANCH_PROFILING=y
# CONFIG_BRANCH_PROFILE_NONE is not set
CONFIG_PROFILE_ANNOTATED_BRANCHES=y
# CONFIG_PROFILE_ALL_BRANCHES is not set
# CONFIG_BRANCH_TRACER is not set
CONFIG_STACK_TRACER=y
CONFIG_KPROBE_EVENTS=y
CONFIG_UPROBE_EVENTS=y
CONFIG_BPF_EVENTS=y
CONFIG_PROBE_EVENTS=y
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_FUNCTION_PROFILER=y
CONFIG_BPF_KPROBE_OVERRIDE=y
CONFIG_FTRACE_MCOUNT_RECORD=y
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_MMIOTRACE is not set
# CONFIG_HIST_TRIGGERS is not set
# CONFIG_TRACEPOINT_BENCHMARK is not set
CONFIG_RING_BUFFER_BENCHMARK=y
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
CONFIG_TRACE_EVAL_MAP_FILE=y
CONFIG_TRACING_EVENTS_GPIO=y
# CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
# CONFIG_DMA_API_DEBUG is not set
CONFIG_RUNTIME_TESTING_MENU=y
# CONFIG_TEST_LIST_SORT is not set
# CONFIG_TEST_SORT is not set
# CONFIG_KPROBES_SANITY_TEST is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_PERCPU_TEST is not set
CONFIG_ATOMIC64_SELFTEST=m
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_TEST_STRING_HELPERS is not set
# CONFIG_TEST_KSTRTOX is not set
# CONFIG_TEST_PRINTF is not set
CONFIG_TEST_BITMAP=y
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_OVERFLOW is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_HASH is not set
# CONFIG_TEST_LKM is not set
CONFIG_TEST_USER_COPY=m
# CONFIG_TEST_BPF is not set
# CONFIG_FIND_BIT_BENCHMARK is not set
CONFIG_TEST_FIRMWARE=y
# CONFIG_TEST_SYSCTL is not set
# CONFIG_TEST_UDELAY is not set
# CONFIG_TEST_STATIC_KEYS is not set
# CONFIG_TEST_DEBUG_VIRTUAL is not set
# CONFIG_MEMTEST is not set
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_UBSAN is not set
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
# CONFIG_STRICT_DEVMEM is not set
CONFIG_X86_VERBOSE_BOOTUP=y
# CONFIG_EARLY_PRINTK is not set
CONFIG_X86_PTDUMP_CORE=y
CONFIG_X86_PTDUMP=m
CONFIG_DEBUG_WX=y
CONFIG_DOUBLEFAULT=y
# CONFIG_DEBUG_TLBFLUSH is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
# CONFIG_X86_DECODER_SELFTEST is not set
CONFIG_IO_DELAY_TYPE_0X80=0
CONFIG_IO_DELAY_TYPE_0XED=1
CONFIG_IO_DELAY_TYPE_UDELAY=2
CONFIG_IO_DELAY_TYPE_NONE=3
# CONFIG_IO_DELAY_0X80 is not set
# CONFIG_IO_DELAY_0XED is not set
CONFIG_IO_DELAY_UDELAY=y
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEFAULT_IO_DELAY_TYPE=2
# CONFIG_DEBUG_BOOT_PARAMS is not set
# CONFIG_CPA_DEBUG is not set
# CONFIG_OPTIMIZE_INLINING is not set
# CONFIG_DEBUG_ENTRY is not set
CONFIG_DEBUG_NMI_SELFTEST=y
# CONFIG_X86_DEBUG_FPU is not set
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_FRAME_POINTER=y

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_PERSISTENT_KEYRINGS is not set
# CONFIG_BIG_KEYS is not set
# CONFIG_TRUSTED_KEYS is not set
CONFIG_ENCRYPTED_KEYS=y
CONFIG_KEY_DH_OPERATIONS=y
CONFIG_SECURITY_DMESG_RESTRICT=y
# CONFIG_SECURITY is not set
CONFIG_SECURITYFS=y
# CONFIG_FORTIFY_SOURCE is not set
CONFIG_STATIC_USERMODEHELPER=y
CONFIG_STATIC_USERMODEHELPER_PATH="/sbin/usermode-helper"
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_DEFAULT_SECURITY=""
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_BLKCIPHER=y
CONFIG_CRYPTO_BLKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=y
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=y
CONFIG_CRYPTO_ECDH=m
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
# CONFIG_CRYPTO_USER is not set
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
# CONFIG_CRYPTO_PCRYPT is not set
CONFIG_CRYPTO_WORKQUEUE=y
CONFIG_CRYPTO_CRYPTD=y
# CONFIG_CRYPTO_MCRYPTD is not set
# CONFIG_CRYPTO_AUTHENC is not set
CONFIG_CRYPTO_TEST=m
CONFIG_CRYPTO_SIMD=y
CONFIG_CRYPTO_GLUE_HELPER_X86=m
CONFIG_CRYPTO_ENGINE=m

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_CHACHA20POLY1305=y
# CONFIG_CRYPTO_AEGIS128 is not set
# CONFIG_CRYPTO_AEGIS128L is not set
CONFIG_CRYPTO_AEGIS256=m
# CONFIG_CRYPTO_MORUS640 is not set
CONFIG_CRYPTO_MORUS1280=y
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=m

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CFB=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=m
CONFIG_CRYPTO_PCBC=y
CONFIG_CRYPTO_XTS=y
# CONFIG_CRYPTO_KEYWRAP is not set

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=y
CONFIG_CRYPTO_VMAC=y

#
# Digest
#
CONFIG_CRYPTO_CRC32C=m
# CONFIG_CRYPTO_CRC32C_INTEL is not set
CONFIG_CRYPTO_CRC32=y
CONFIG_CRYPTO_CRC32_PCLMUL=m
CONFIG_CRYPTO_CRCT10DIF=m
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_POLY1305=y
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=y
CONFIG_CRYPTO_RMD128=y
CONFIG_CRYPTO_RMD160=y
CONFIG_CRYPTO_RMD256=y
CONFIG_CRYPTO_RMD320=y
CONFIG_CRYPTO_SHA1=m
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
# CONFIG_CRYPTO_SHA3 is not set
CONFIG_CRYPTO_SM3=y
CONFIG_CRYPTO_TGR192=m
# CONFIG_CRYPTO_WP512 is not set

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_AES_586=y
CONFIG_CRYPTO_AES_NI_INTEL=y
# CONFIG_CRYPTO_ANUBIS is not set
CONFIG_CRYPTO_ARC4=y
# CONFIG_CRYPTO_BLOWFISH is not set
CONFIG_CRYPTO_CAMELLIA=y
CONFIG_CRYPTO_CAST_COMMON=m
CONFIG_CRYPTO_CAST5=m
# CONFIG_CRYPTO_CAST6 is not set
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_FCRYPT=y
CONFIG_CRYPTO_KHAZAD=m
# CONFIG_CRYPTO_SALSA20 is not set
CONFIG_CRYPTO_CHACHA20=y
CONFIG_CRYPTO_SEED=y
CONFIG_CRYPTO_SERPENT=y
CONFIG_CRYPTO_SERPENT_SSE2_586=m
CONFIG_CRYPTO_SM4=y
# CONFIG_CRYPTO_SPECK is not set
CONFIG_CRYPTO_TEA=y
# CONFIG_CRYPTO_TWOFISH is not set
CONFIG_CRYPTO_TWOFISH_COMMON=m
CONFIG_CRYPTO_TWOFISH_586=m

#
# Compression
#
# CONFIG_CRYPTO_DEFLATE is not set
# CONFIG_CRYPTO_LZO is not set
# CONFIG_CRYPTO_842 is not set
CONFIG_CRYPTO_LZ4=y
CONFIG_CRYPTO_LZ4HC=m
# CONFIG_CRYPTO_ZSTD is not set

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=m
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
# CONFIG_CRYPTO_USER_API_HASH is not set
# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
# CONFIG_CRYPTO_USER_API_RNG is not set
# CONFIG_CRYPTO_USER_API_AEAD is not set
CONFIG_CRYPTO_HASH_INFO=y
CONFIG_CRYPTO_HW=y
CONFIG_CRYPTO_DEV_PADLOCK=m
CONFIG_CRYPTO_DEV_PADLOCK_AES=m
CONFIG_CRYPTO_DEV_PADLOCK_SHA=m
# CONFIG_CRYPTO_DEV_GEODE is not set
# CONFIG_CRYPTO_DEV_HIFN_795X is not set
# CONFIG_CRYPTO_DEV_CCP is not set
# CONFIG_CRYPTO_DEV_QAT_DH895xCC is not set
# CONFIG_CRYPTO_DEV_QAT_C3XXX is not set
# CONFIG_CRYPTO_DEV_QAT_C62X is not set
# CONFIG_CRYPTO_DEV_QAT_DH895xCCVF is not set
# CONFIG_CRYPTO_DEV_QAT_C3XXXVF is not set
# CONFIG_CRYPTO_DEV_QAT_C62XVF is not set
CONFIG_CRYPTO_DEV_VIRTIO=m
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
CONFIG_PKCS7_MESSAGE_PARSER=y

#
# Certificates for signature checking
#
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
CONFIG_SECONDARY_TRUSTED_KEYRING=y
# CONFIG_SYSTEM_BLACKLIST_KEYRING is not set
CONFIG_HAVE_KVM=y
CONFIG_VIRTUALIZATION=y
CONFIG_VHOST_CROSS_ENDIAN_LEGACY=y
CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_BITREVERSE=y
CONFIG_RATIONAL=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
# CONFIG_CRC_CCITT is not set
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=m
CONFIG_CRC_ITU_T=m
CONFIG_CRC32=y
CONFIG_CRC32_SELFTEST=m
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
CONFIG_CRC4=y
# CONFIG_CRC7 is not set
CONFIG_LIBCRC32C=m
CONFIG_CRC8=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_COMPRESS=y
CONFIG_LZ4HC_COMPRESS=m
CONFIG_LZ4_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_BCH=y
CONFIG_BCH_CONST_PARAMS=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_SGL_ALLOC=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_DMA_DIRECT_OPS=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_CORDIC=m
CONFIG_DDR=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_OID_REGISTRY=y
CONFIG_ARCH_HAS_SG_CHAIN=y
CONFIG_STACKDEPOT=y
CONFIG_PRIME_NUMBERS=m
CONFIG_STRING_SELFTEST=m

--itqfrb9Qq3wY07cp--
