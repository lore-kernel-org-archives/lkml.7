Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,
	RCVD_ILLEGAL_IP,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40841CA9EB9
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 02:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F159920684
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 02:17:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436904AbfJXCRt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 22:17:49 -0400
Received: from nl101-4.vfemail.net ([149.210.219.37]:22058 "EHLO
        nl101-3.vfemail.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2406401AbfJXCRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 22:17:49 -0400
Received: (qmail 1522 invoked from network); 24 Oct 2019 02:17:24 -0000
Received: by simscan 1.4.0 ppid: 1103, pid: 1517, t: 0.1114s
         scanners:none
Received: from nl101-2.vfemail.net (bmE=@149.210.219.31)
  by localhost with (DHE-RSA-AES256-SHA encrypted) SMTP; 24 Oct 2019 02:17:24 -0000
Received: (qmail 1101 invoked from network); 24 Oct 2019 02:17:06 -0000
Received: by simscan 1.4.0 ppid: 659, pid: 803, t: 1.5748s
         scanners:none
Received: from unknown (HELO Phenom-II-x6.niklas.com) (SGdudGt3aXNAdmZlbWFpbC5uZXQ=@192.168.1.192)
  by nl101.vfemail.net with ESMTPA; 24 Oct 2019 02:17:05 -0000
X-Assp-Version: 2.6.1(19007) on ASSP.nospam
X-Assp-ID: ASSP.nospam m1-83441-12908
X-Assp-Session: 7FA118A75420 (mail 1)
X-Assp-Envelope-From: Hgntkwis@vfemail.net
X-Assp-Intended-For: linux-kernel@vger.kernel.org
X-Assp-Client-TLS: yes
Received: from unknown ([0.0.0.0] noname) by ASSP.nospam with SMTPSA(TLSv1_2
         ECDHE-RSA-AES256-GCM-SHA384) (2.6.1); 24 Oct 2019 02:17:16 +0000
Date:   Wed, 23 Oct 2019 22:16:46 -0400
From:   David Niklas <Hgntkwis@vfemail.net>
To:     linux-kernel@vger.kernel.org
Subject: Bug report: Kernel IO lockup. Hard reboot required.
Message-ID: <20191023221646.3c3dbd57@Phenom-II-x6.niklas.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ever since I started using Linux I've had problems with freezing.
Sometimes this has been the HW, sometimes its the FS being dirty.
This time I know, having checked, that the FS is clean, and having
verified that the disks are accessible, I managed to finally get a report
on this lockup before the entire system became unresponsive. When I say
unresponsive I mean the even the sysreq keys cease to work (Yes, its that
serious).
I've no idea what causes this lockup, or what I can do to trigger it
again, only that a lockup will happen sooner or latter.
The FS that the kernel was having trouble addressing was an MD array. Its
named /dev/md7p1. There is only one partition on it. Its formated
reiserfs. The version of the array is 1.2.
My kernel is using a custom config. I'm running Devuan (Debian) linux on
kernel 4.14.146. This is a desktop system running on an AMD 1090T
processor.
mdadm - v3.4 - 28th January 2016
GPT fdisk (gdisk) version 1.0.1
parted (GNU parted) 3.2
The system is not running any other special parts that I compiled that
might cause a crash (I use discord and the yuoa game engine now and
again, etc.). These are sand-boxed by apparmor.
I was not using the system when it locked-up. I happened to be looking at
it from a distance to see how it was progressing on the tasks it was
carrying out. It was downloading some stuff. I don't recall what exactly.
I noticed, because htop was running on my terminal, that the amount of IO
was extreme. I sat down and scrolled through the list of processes
waiting on IO and noticed that they were trying to access my MD array.
They were all stuck. I decided to sit down for a moment and tried to
switch to my desktop from my tty. That failed and the desktop couldn't
do any IO, which it wanted to for some reason (Its Icewm). I verified
using smartctl that all the disks were accessible. I walked away
and came back later to recored the dmesg output for our edification.

If you need more details just ask, I am subscribed.
Dmesg below: 

Thanks,
David

PS: The kernel was compiled in the normal way with gcc, make clean, make
prepare, make modules_prepare, make, make modules, make modules_install,
make install.

[    0.000000] Linux version 4.14.146-nopreempt-AMDGPU-dav9 (Snip host
name) (gcc version 6.3.0 20170516 (Debian 6.3.0-18+deb9u1)) #1 SMP Mon
Sep 30 00:49:45 EDT 2019 [    0.000000] Command line:
BOOT_IMAGE=Linux_AMDGPU2 ro root=824 root=/dev/sdc4 rootfstype=ext4
splash=verbose iommu=soft elevator=deadline ...<snip>... [190299.658191]
md: md7: data-check done. [193601.094230] usb 6-1: USB disconnect, device
number 5 [193601.617854] usb 6-1: new full-speed USB device number 6
using ohci-pci [193601.802333] usb 6-1: New USB device found,
idVendor=258a, idProduct=0012 [193601.802335] usb 6-1: New USB device
strings: Mfr=1, Product=2, SerialNumber=0 [193601.802337] usb 6-1:
Product: USBGamingMouse [193601.802337] usb 6-1: Manufacturer: SN TECH
[193601.809199] input: SN TECH      USBGamingMouse
as /devices/pci0000:00/0000:00:12.0/usb6/6-1/6-1:1.0/0003:258A:0012.0009/input/input24
[193601.864756] hid-generic 0003:258A:0012.0009: input,hidraw0: USB HID
v1.11 Mouse [SN TECH      USBGamingMouse] on usb-0000:00:12.0-1/input0
[193601.870103] input: SN TECH      USBGamingMouse
as /devices/pci0000:00/0000:00:12.0/usb6/6-1/6-1:1.1/0003:258A:0012.000A/input/input25
[193601.925117] hid-generic 0003:258A:0012.000A: input,hiddev0,hidraw1:
USB HID v1.11 Keyboard [SN TECH      USBGamingMouse] on
usb-0000:00:12.0-1/input1 [193602.008004] elogind[3860]: Watching system
buttons on /dev/input/event16 (SN TECH      USBGamingMouse)
[216672.407021] elogind[3860]: Removed session 9. [252149.611801] INFO:
task icewm:7918 blocked for more than 480 seconds. [252149.613376]
Not tainted 4.14.146-nopreempt-AMDGPU-dav9 #1 [252149.614771] "echo 0
> /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [252149.616255] icewm           D    0  7918   3491 0x00000080
> [252149.616258] Call Trace: [252149.617735]  ? __schedule+0x29e/0x6c0
> [252149.619206]  schedule+0x32/0x80 [252149.620641]
> schedule_preempt_disabled+0xa/0x10 [252149.622106]
> __mutex_lock.isra.1+0x26b/0x4e0
[252149.623566]  ? __wake_up_common_lock+0x89/0xc0
[252149.625025]  ? do_journal_begin_r+0xbe/0x390 [reiserfs]
[252149.626535]  do_journal_begin_r+0xbe/0x390 [reiserfs]
[252149.627993]  journal_begin+0x80/0x140 [reiserfs]
[252149.629402]  reiserfs_dirty_inode+0x3d/0xa0 [reiserfs]
[252149.630803]  ? unix_state_double_lock+0x60/0x60
[252149.632289]  __mark_inode_dirty+0x163/0x350
[252149.633757]  generic_update_time+0x79/0xc0
[252149.635156]  ? current_time+0x38/0x70
[252149.636572]  file_update_time+0xbe/0x110
[252149.637967]  __generic_file_write_iter+0x99/0x1b0
[252149.639362]  generic_file_write_iter+0xe2/0x1c0
[252149.640734]  __vfs_write+0x102/0x180
[252149.642170]  vfs_write+0xb0/0x190
[252149.643549]  SyS_write+0x5a/0xd0
[252149.644898]  do_syscall_64+0x6e/0x110
[252149.646261]  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
[252149.647610] RIP: 0033:0x7f1be1ea4970
[252149.648964] RSP: 002b:00007fff27baa2c8 EFLAGS: 00000246 ORIG_RAX:
0000000000000001 [252149.650388] RAX: ffffffffffffffda RBX:
0000000000000007 RCX: 00007f1be1ea4970 [252149.651752] RDX:
0000000000000007 RSI: 00007fff27baa490 RDI: 0000000000000002
[252149.653136] RBP: 00007fff27baa490 R08: 00007f1be42ca880 R09:
0000000000000007 [252149.654487] R10: 0000000000000073 R11:
0000000000000246 R12: 0000000000000007 [252149.655849] R13:
0000000000000001 R14: 00007f1be2163520 R15: 0000000000000007
[252149.657205] INFO: task claws-mail:8342 blocked for more than 480
seconds. [252149.658625]       Not tainted 4.14.146-nopreempt-AMDGPU-dav9
#1 [252149.660037] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message. [252149.661399] claws-mail      D    0  8342
8293 0x00000080 [252149.661400] Call Trace: [252149.662761]  ?
__schedule+0x29e/0x6c0 [252149.664255]  schedule+0x32/0x80
[252149.665700]  schedule_preempt_disabled+0xa/0x10 [252149.667117]
__mutex_lock.isra.1+0x26b/0x4e0 [252149.668481]  ?
__wake_up_common_lock+0x89/0xc0 [252149.669905]  ?
do_journal_begin_r+0xbe/0x390 [reiserfs] [252149.671268]
do_journal_begin_r+0xbe/0x390 [reiserfs] [252149.672726]  ?
copyout+0x22/0x30 [252149.674081]  ? _copy_to_iter+0x8d/0x3f0
[252149.675501]  journal_begin+0x80/0x140 [reiserfs]
[252149.676846]  reiserfs_dirty_inode+0x3d/0xa0 [reiserfs]
[252149.678188]  ? release_sock+0x43/0x90
[252149.679534]  __mark_inode_dirty+0x163/0x350
[252149.680874]  generic_update_time+0x79/0xc0
[252149.682291]  ? current_time+0x38/0x70
[252149.683672]  file_update_time+0xbe/0x110
[252149.685042]  __generic_file_write_iter+0x99/0x1b0
[252149.686376]  generic_file_write_iter+0xe2/0x1c0
[252149.687700]  __vfs_write+0x102/0x180
[252149.689031]  vfs_write+0xb0/0x190
[252149.690342]  SyS_write+0x5a/0xd0
[252149.691767]  do_syscall_64+0x6e/0x110
[252149.693091]  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
[252149.694372] RIP: 0033:0x7f457d7ef98d
[252149.695657] RSP: 002b:00007ffd3a42c8a0 EFLAGS: 00000293 ORIG_RAX:
0000000000000001 [252149.696960] RAX: ffffffffffffffda RBX:
000000000000002a RCX: 00007f457d7ef98d [252149.698268] RDX:
000000000000002a RSI: 0000000001fa3e30 RDI: 0000000000000009
[252149.699733] RBP: 0000000001fa3e30 R08: 0000000000b17560 R09:
00007f4582dc8a00 [252149.701036] R10: 000824f7579ca466 R11:
0000000000000293 R12: 000000000000002a [252149.702354] R13:
0000000000000001 R14: 0000000000b17480 R15: 000000000000002a
[252149.703667] INFO: task Cache2 I/O:8456 blocked for more than 480
seconds. [252149.704995]       Not tainted 4.14.146-nopreempt-AMDGPU-dav9
#1 [252149.706325] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message. [252149.707733] Cache2 I/O      D    0  8456
8293 0x00000080 [252149.707734] Call Trace: [252149.709091]  ?
__schedule+0x29e/0x6c0 [252149.710489]  schedule+0x32/0x80
[252149.711870]  schedule_preempt_disabled+0xa/0x10 [252149.713329]
__mutex_lock.isra.1+0x26b/0x4e0 [252149.714773]  ?
do_journal_begin_r+0xbe/0x390 [reiserfs] [252149.716198]
do_journal_begin_r+0xbe/0x390 [reiserfs] [252149.717545]
journal_begin+0x80/0x140 [reiserfs] [252149.718900]
reiserfs_rename+0x282/0x990 [reiserfs] [252149.720416]  ?
__wake_up_common_lock+0x89/0xc0 [252149.721812]  ? lookup_fast+0xc8/0x2c0
[252149.723203]  ? lookup_fast+0xc8/0x2c0
[252149.724662]  ? vfs_rename+0x6c9/0x900
[252149.725991]  vfs_rename+0x6c9/0x900
[252149.727314]  SyS_rename+0x3ce/0x3f0
[252149.728644]  do_syscall_64+0x6e/0x110
[252149.729967]  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
[252149.731293] RIP: 0033:0x7f8927562d47
[252149.732671] RSP: 002b:00007f892872ec38 EFLAGS: 00000202 ORIG_RAX:
0000000000000052 [252149.734077] RAX: ffffffffffffffda RBX:
0000000000000000 RCX: 00007f8927562d47 [252149.735404] RDX:
0000000000000000 RSI: 00007f8733d47f08 RDI: 00007f87320d6b88
[252149.736767] RBP: 00007f872cb84c40 R08: 0000000000000000 R09:
0000000000000000 [252149.738066] R10: 0000000000000000 R11:
0000000000000202 R12: 00007f872cb84ce8 [252149.739380] R13:
00007f87322ada00 R14: 00007f892872ed50 R15: 00007f892872ec40
[252149.740773] INFO: task StreamT~ns #751:29976 blocked for more than
480 seconds. [252149.742093]       Not tainted
4.14.146-nopreempt-AMDGPU-dav9 #1 [252149.743475] "echo 0
> /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [252149.744805] StreamT~ns #751 D    0 29976   8293 0x00000080
> [252149.744806] Call Trace: [252149.746141]  ? __schedule+0x29e/0x6c0
[252149.747465]  schedule+0x32/0x80
[252149.748833]  schedule_preempt_disabled+0xa/0x10
[252149.750271]  __mutex_lock.isra.1+0x26b/0x4e0
[252149.751597]  ? do_journal_begin_r+0xbe/0x390 [reiserfs]
[252149.752918]  do_journal_begin_r+0xbe/0x390 [reiserfs]
[252149.754239]  ? reiserfs_lookup+0xb5/0x160 [reiserfs]
[252149.755573]  journal_begin+0x80/0x140 [reiserfs]
[252149.756959]  reiserfs_create+0xfc/0x210 [reiserfs]
[252149.758300]  path_openat+0x13e1/0x1490
[252149.759627]  ? futex_wake+0x91/0x170
[252149.760949]  do_filp_open+0x99/0x110
[252149.762309]  ? __check_object_size+0xfa/0x1a0
[252149.763688]  ? strncpy_from_user+0x48/0x130
[252149.765023]  ? __check_object_size+0xfa/0x1a0
[252149.766477]  ? __alloc_fd+0x3d/0x160
[252149.767800]  ? do_sys_open+0x12e/0x210
[252149.769126]  do_sys_open+0x12e/0x210
[252149.770432]  do_syscall_64+0x6e/0x110
[252149.771734]  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
[252149.773084] RIP: 0033:0x7f892834e85d
[252149.774377] RSP: 002b:00007f87203aaa50 EFLAGS: 00000293 ORIG_RAX:
0000000000000002 [252149.775700] RAX: ffffffffffffffda RBX:
0000000000000241 RCX: 00007f892834e85d [252149.777059] RDX:
0000000000000180 RSI: 0000000000000241 RDI: 00007f8732bf4d08
[252149.778385] RBP: 00007f8732bf4d08 R08: 00007f89272290e0 R09:
00007f8732bf4d08 [252149.779759] R10: 00007f8732bfd0d0 R11:
0000000000000293 R12: 0000000000000180 [252149.781059] R13:
00007f87203aab70 R14: 00007f891d350f40 R15: 0000000000000001
[252149.782408] INFO: task CacheThread_Blo:8552 blocked for more than 480
seconds. [252149.783727]       Not tainted 4.14.146-nopreempt-AMDGPU-dav9
#1 [252149.785086] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message. [252149.786521] CacheThread_Blo D    0  8552
8293 0x00000080 [252149.786522] Call Trace: [252149.787842]  ?
__schedule+0x29e/0x6c0 [252149.789169]  schedule+0x32/0x80
[252149.790581]  schedule_preempt_disabled+0xa/0x10 [252149.791905]
__mutex_lock.isra.1+0x26b/0x4e0 [252149.793221]  ?
do_journal_begin_r+0xbe/0x390 [reiserfs] [252149.794544]
do_journal_begin_r+0xbe/0x390 [reiserfs] [252149.795932]  ?
__switch_to_asm+0x35/0x70 [252149.797304]  ? __switch_to_asm+0x41/0x70
[252149.798618]  ? __switch_to_asm+0x35/0x70
[252149.800025]  ? __switch_to_asm+0x41/0x70
[252149.801381]  ? __switch_to_asm+0x35/0x70
[252149.802674]  ? __switch_to_asm+0x41/0x70
[252149.803983]  ? __switch_to_asm+0x35/0x70
[252149.805257]  journal_begin+0x80/0x140 [reiserfs]
[252149.806659]  reiserfs_dirty_inode+0x3d/0xa0 [reiserfs]
[252149.807935]  ? __switch_to+0x1ee/0x3f0
[252149.809317]  ? __switch_to+0x1ee/0x3f0
[252149.810709]  __mark_inode_dirty+0x163/0x350
[252149.812074]  generic_update_time+0x79/0xc0
[252149.813416]  ? current_time+0x38/0x70
[252149.814831]  file_update_time+0xbe/0x110
[252149.816272]  __generic_file_write_iter+0x99/0x1b0
[252149.817596]  generic_file_write_iter+0xe2/0x1c0
[252149.818920]  __vfs_write+0x102/0x180
[252149.820324]  vfs_write+0xb0/0x190
[252149.821693]  SyS_pwrite64+0x90/0xb0
[252149.822998]  do_syscall_64+0x6e/0x110
[252149.824280]  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
[252149.825630] RIP: 0033:0x7f45af7db983
[252149.826955] RSP: 002b:00007f4594c43620 EFLAGS: 00000293 ORIG_RAX:
0000000000000012 [252149.828200] RAX: ffffffffffffffda RBX:
00007f4594c43630 RCX: 00007f45af7db983 [252149.829558] RDX:
0000000000000128 RSI: 00000eb793a78e00 RDI: 0000000000000037
[252149.830889] RBP: 00007f4594c436b0 R08: 0000000000000008 R09:
00000eb793a78e90 [252149.832277] R10: 0000000000002000 R11:
0000000000000293 R12: 0000000000002000 [252149.833606] R13:
00000eb793a90c90 R14: 00000eb793a78e00 R15: 0000000000000128
[252149.834982] INFO: task Chrome_HistoryT:8874 blocked for more than 480
seconds. [252149.836374]       Not tainted 4.14.146-nopreempt-AMDGPU-dav9
#1 [252149.837737] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message. [252149.839077] Chrome_HistoryT D    0  8874
8293 0x00000080 [252149.839078] Call Trace: [252149.840406]  ?
__schedule+0x29e/0x6c0 [252149.841751]  schedule+0x32/0x80
[252149.843090]  schedule_preempt_disabled+0xa/0x10 [252149.844389]
__mutex_lock.isra.1+0x26b/0x4e0 [252149.845793]  ?
flush_commit_list+0x1fa/0x670 [reiserfs] [252149.847226]
flush_commit_list+0x1fa/0x670 [reiserfs] [252149.848600]
flush_commit_list+0x11f/0x670 [reiserfs] [252149.850009]
do_journal_end+0xc81/0xda0 [reiserfs] [252149.851306]
reiserfs_commit_for_inode+0x201/0x220 [reiserfs] [252149.852715]
reiserfs_sync_file+0x6b/0xe0 [reiserfs] [252149.854058]
do_fsync+0x38/0x60 [252149.855435]  SyS_fdatasync+0xf/0x20
[252149.856832]  do_syscall_64+0x6e/0x110
[252149.858155]  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
[252149.859480] RIP: 0033:0x7f45a970f84d
[252149.860805] RSP: 002b:00007f45929e00e0 EFLAGS: 00000293 ORIG_RAX:
000000000000004b [252149.862149] RAX: ffffffffffffffda RBX:
00000eb795860e80 RCX: 00007f45a970f84d [252149.863511] RDX:
0000000000000008 RSI: 0000000000000002 RDI: 0000000000000257
[252149.864771] RBP: 00007f45929e0120 R08: 0000000000000000 R09:
0000000000001fdf [252149.866183] R10: 0000000000002400 R11:
0000000000000293 R12: 0000000000000000 [252149.867558] R13:
d763a120f905d5d9 R14: 0000000000000000 R15: 0000000000001000
[252149.868933] INFO: task ThreadPoolSingl:8875 blocked for more than 480
seconds. [252149.870329]       Not tainted 4.14.146-nopreempt-AMDGPU-dav9
#1 [252149.871652] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message. [252149.873063] ThreadPoolSingl D    0  8875
8293 0x00000080 [252149.873064] Call Trace: [252149.874335]  ?
__schedule+0x29e/0x6c0 [252149.875688]  schedule+0x32/0x80
[252149.877028]  schedule_preempt_disabled+0xa/0x10 [252149.878409]
__mutex_lock.isra.1+0x26b/0x4e0 [252149.879748]  ?
do_journal_begin_r+0xbe/0x390 [reiserfs] [252149.881139]
do_journal_begin_r+0xbe/0x390 [reiserfs] [252149.882572]  ?
reiserfs_lookup+0xb5/0x160 [reiserfs] [252149.883968]
journal_begin+0x80/0x140 [reiserfs] [252149.885272]
reiserfs_create+0xfc/0x210 [reiserfs] [252149.886663]
path_openat+0x13e1/0x1490 [252149.888017]  ? futex_wake+0x91/0x170
[252149.889372]  do_filp_open+0x99/0x110
[252149.890824]  ? __check_object_size+0xfa/0x1a0
[252149.892220]  ? __alloc_fd+0x3d/0x160
[252149.893644]  ? do_sys_open+0x12e/0x210
[252149.894914]  do_sys_open+0x12e/0x210
[252149.896294]  do_syscall_64+0x6e/0x110
[252149.897633]  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
[252149.898986] RIP: 0033:0x7f45a970970d
[252149.900339] RSP: 002b:00007f459213f2c0 EFLAGS: 00000293 ORIG_RAX:
0000000000000002 [252149.901757] RAX: ffffffffffffffda RBX:
0000000000000000 RCX: 00007f45a970970d [252149.903135] RDX:
0000000000000180 RSI: 00000000000000c2 RDI: 00000eb7ae7f17e0
[252149.904463] RBP: 000000000003a2f8 R08: 0000000000000001 R09:
00000eb7ad9bbac0 [252149.905792] R10: 0000000000000000 R11:
0000000000000293 R12: 00000eb7ae7f181a [252149.907105] R13:
8421084210842109 R14: 00000000000000c2 R15: 00007f45a9797540
[252149.908413] INFO: task ThreadPoolForeg:28571 blocked for more than
480 seconds. [252149.909742]       Not tainted
4.14.146-nopreempt-AMDGPU-dav9 #1 [252149.911031] "echo 0
> /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [252149.912453] ThreadPoolForeg D    0 28571   8293 0x00000080
> [252149.912467] Call Trace: [252149.913820]  ? __schedule+0x29e/0x6c0
[252149.915128]  ? __switch_to_asm+0x35/0x70
[252149.916585]  schedule+0x32/0x80
[252149.917895]  schedule_preempt_disabled+0xa/0x10
[252149.919332]  __mutex_lock.isra.1+0x26b/0x4e0
[252149.920746]  ? __switch_to_asm+0x35/0x70
[252149.922180]  ? do_journal_begin_r+0xbe/0x390 [reiserfs]
[252149.923613]  do_journal_begin_r+0xbe/0x390 [reiserfs]
[252149.925010]  ? __remove_hrtimer+0x35/0x70
[252149.926474]  ? hrtimer_try_to_cancel+0xbd/0x110
[252149.927893]  journal_begin+0x80/0x140 [reiserfs]
[252149.929282]  reiserfs_dirty_inode+0x3d/0xa0 [reiserfs]
[252149.930623]  ? get_futex_key+0x4a0/0x4d0
[252149.932006]  __mark_inode_dirty+0x163/0x350
[252149.933434]  generic_update_time+0x79/0xc0
[252149.934769]  ? current_time+0x38/0x70
[252149.936158]  file_update_time+0xbe/0x110
[252149.937490]  __generic_file_write_iter+0x99/0x1b0
[252149.938936]  generic_file_write_iter+0xe2/0x1c0
[252149.940271]  __vfs_write+0x102/0x180
[252149.941618]  vfs_write+0xb0/0x190
[252149.943012]  SyS_write+0x5a/0xd0
[252149.944342]  do_syscall_64+0x6e/0x110
[252149.945726]  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
[252149.947056] RIP: 0033:0x7f45af7db1cd
[252149.948402] RSP: 002b:00007f456a563af0 EFLAGS: 00000293 ORIG_RAX:
0000000000000001 [252149.949785] RAX: ffffffffffffffda RBX:
00007f456a563b08 RCX: 00007f45af7db1cd [252149.951154] RDX:
0000000000000007 RSI: 00007f456a563c18 RDI: 00000000000000f4
[252149.952596] RBP: 00007f456a563b80 R08: 0000000000000000 R09:
00005641a9f0b790 [252149.953937] R10: 0000cb689851cb28 R11:
0000000000000293 R12: 00000eb7aeb1d650 [252149.955335] R13:
00007f456a563c18 R14: 0000000000000007 R15: 0000000000000000
[252149.956727] INFO: task ThreadPoolForeg:27436 blocked for more than
480 seconds. [252149.958056]       Not tainted
4.14.146-nopreempt-AMDGPU-dav9 #1 [252149.959491] "echo 0
> /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [252149.960820] ThreadPoolForeg D    0 27436   8514 0x00000080
> [252149.960821] Call Trace: [252149.962253]  ? __schedule+0x29e/0x6c0
[252149.963600]  ? __switch_to_asm+0x41/0x70
[252149.964933]  schedule+0x32/0x80
[252149.966441]  schedule_preempt_disabled+0xa/0x10
[252149.967768]  __mutex_lock.isra.1+0x26b/0x4e0
[252149.969162]  ? __switch_to_asm+0x41/0x70
[252149.970492]  ? find_get_entry+0x21/0x180
[252149.971860]  ? flush_commit_list+0x1fa/0x670 [reiserfs]
[252149.973289]  flush_commit_list+0x1fa/0x670 [reiserfs]
[252149.974621]  get_list_bitmap+0x81/0xd0 [reiserfs]
[252149.976016]  do_journal_end+0xbce/0xda0 [reiserfs]
[252149.977414]  reiserfs_commit_for_inode+0x201/0x220 [reiserfs]
[252149.978813]  reiserfs_sync_file+0x6b/0xe0 [reiserfs]
[252149.980157]  do_fsync+0x38/0x60
[252149.981488]  SyS_fdatasync+0xf/0x20
[252149.982883]  do_syscall_64+0x6e/0x110
[252149.984191]  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
[252149.985592] RIP: 0033:0x7f11f546884d
[252149.986901] RSP: 002b:00007f11e8f2a430 EFLAGS: 00000293 ORIG_RAX:
000000000000004b [252149.988234] RAX: ffffffffffffffda RBX:
00007f11e8f2a440 RCX: 00007f11f546884d [252149.989700] RDX:
00001c4f0a409e28 RSI: 0000000000000000 RDI: 0000000000000054
[252149.991098] RBP: 00007f11e8f2a490 R08: 0000000000000000 R09:
00001c4f0f5ea0c0 [252149.992484] R10: 00347354bacab6d5 R11:
0000000000000293 R12: 0000000000000000 [252149.993861] R13:
000000000002276a R14: 00007f11e8f2a528 R15: 00007f11e8f2a528
[252149.995216] INFO: task ThreadPoolForeg:29152 blocked for more than
480 seconds. [252149.996626]       Not tainted
4.14.146-nopreempt-AMDGPU-dav9 #1 [252149.997955] "echo 0
> /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [252149.999431] ThreadPoolForeg D    0 29152   8514 0x00000080
> [252149.999432] Call Trace: [252150.000867]  ? __schedule+0x29e/0x6c0
[252150.002282]  ? __switch_to_asm+0x41/0x70
[252150.003708]  schedule+0x32/0x80
[252150.005064]  schedule_preempt_disabled+0xa/0x10
[252150.006459]  __mutex_lock.isra.1+0x26b/0x4e0
[252150.007795]  ? __switch_to_asm+0x41/0x70
[252150.009192]  ? flush_commit_list+0x1fa/0x670 [reiserfs]
[252150.010638]  flush_commit_list+0x1fa/0x670 [reiserfs]
[252150.012050]  flush_commit_list+0x11f/0x670 [reiserfs]
[252150.013390]  do_journal_end+0xc81/0xda0 [reiserfs]
[252150.014734]  reiserfs_commit_for_inode+0x201/0x220 [reiserfs]
[252150.016196]  reiserfs_sync_file+0x6b/0xe0 [reiserfs]
[252150.017549]  do_fsync+0x38/0x60
[252150.018961]  SyS_fdatasync+0xf/0x20
[252150.020311]  do_syscall_64+0x6e/0x110
[252150.021670]  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
[252150.023047] RIP: 0033:0x7f11f546884d
[252150.024376] RSP: 002b:00007f11e7726ea0 EFLAGS: 00000293 ORIG_RAX:
000000000000004b [252150.025788] RAX: ffffffffffffffda RBX:
00001c4f0af8fa00 RCX: 00007f11f546884d [252150.027150] RDX:
0000000000000008 RSI: 0000000000000002 RDI: 000000000000004f
[252150.028584] RBP: 00007f11e7726ee0 R08: 0000000000000001 R09:
0000000000001fdf [252150.029981] R10: 0000000000001000 R11:
0000000000000293 R12: 0000000000000000 [252150.031334] R13:
d763a120f905d5d9 R14: 0000000000000000 R15: 0000000000001000
[252207.504644] elogind[3860]: Removed session 5. [252212.001258]
elogind[3860]: Removed session 4. [252216.542880] elogind[3860]: Removed
session 6.
