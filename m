Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC41C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 10:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2712220663
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 10:37:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728761AbfLLKhM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 05:37:12 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:51654 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728713AbfLLKhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 05:37:10 -0500
Received: by mail-io1-f72.google.com with SMTP id t18so1208900iob.18
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 02:37:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Bms5KEZuCxqFIWyEcowNRHJS4NglBx1UsLruzo2i8fY=;
        b=l8HUx7N41o/NP57wT/Ptb7BjEmsqUXO5nQTKuiAAqFoKzkIFNMXIJ6yKoNDlv1/Ad8
         nNMbyrvxRxqcR4VsMdWWchVbiUDoDCK+QPm3+vaq/9QdPxLXhHf4YT3m9L369RxB/7UY
         uITzcI+rjOvdxBB4FyGbzhnvomoInBzud542W0n84wcEv84GRCaZTbGKCQqpMJtwGSXe
         BcZs5W++9g0vjSPDlOW/9jr33Xo0RyKsaKMrWtIX+xk+q92gCuMBrfidP2o1TGKMtj3g
         MJuwyKIgT+iA1ff5TiZnJ5lOKCSKLuAtIPVdv55oebRbjQft3QGH5v4Tj+OCVO4HEkxI
         q9VA==
X-Gm-Message-State: APjAAAU7wv8sMYjTHsMi4basbBXa0kM9Wl0V9W/nMclaafKD70OX/s5n
        0s2fn39lvXBOqqvx3X3KSQ4jid4GimGHlUS/wBXGcr+E629M
X-Google-Smtp-Source: APXvYqy3V5/Z6YXCyYGjeN1zP/bkuqwl/DOITmE9tCkoh2BwBIXnlE7K8Ykcmtcza36DFiVfMchVS6dRIlh/GPU7lyaARABcpFy1
MIME-Version: 1.0
X-Received: by 2002:a5e:8345:: with SMTP id y5mr2267186iom.122.1576147029859;
 Thu, 12 Dec 2019 02:37:09 -0800 (PST)
Date:   Thu, 12 Dec 2019 02:37:09 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d424a205997f53bd@google.com>
Subject: INFO: task hung in fb_compat_ioctl
From:   syzbot <syzbot+061df5e46ec99b40552c@syzkaller.appspotmail.com>
To:     b.zolnierkie@samsung.com, daniel.vetter@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com,
        peda@axentia.se, sam@ravnborg.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    687dec9b Merge tag 'erofs-for-5.5-rc2-fixes' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16979cfae00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=79f79de2a27d3e3d
dashboard link: https://syzkaller.appspot.com/bug?extid=061df5e46ec99b40552c
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
userspace arch: i386

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+061df5e46ec99b40552c@syzkaller.appspotmail.com

INFO: task syz-executor.2:25386 blocked for more than 143 seconds.
       Not tainted 5.5.0-rc1-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor.2  D29712 25386   9095 0x20020004
Call Trace:
  context_switch kernel/sched/core.c:3385 [inline]
  __schedule+0x934/0x1f90 kernel/sched/core.c:4081
  schedule+0xdc/0x2b0 kernel/sched/core.c:4155
  schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:4214
  __mutex_lock_common kernel/locking/mutex.c:1036 [inline]
  __mutex_lock+0x7ab/0x13c0 kernel/locking/mutex.c:1106
  mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1121
  lock_fb_info include/linux/fb.h:637 [inline]
  fb_get_fscreeninfo drivers/video/fbdev/core/fbmem.c:1283 [inline]
  fb_compat_ioctl+0x6ed/0xc50 drivers/video/fbdev/core/fbmem.c:1314
  __do_compat_sys_ioctl fs/compat_ioctl.c:214 [inline]
  __se_compat_sys_ioctl fs/compat_ioctl.c:142 [inline]
  __ia32_compat_sys_ioctl+0x233/0x610 fs/compat_ioctl.c:142
  do_syscall_32_irqs_on arch/x86/entry/common.c:337 [inline]
  do_fast_syscall_32+0x27b/0xe16 arch/x86/entry/common.c:408
  entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat.S:139
RIP: 0023:0xf7f41a39
Code: Bad RIP value.
RSP: 002b:00000000f5d1c0cc EFLAGS: 00000296 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 0000000000004602
RDX: 0000000020000080 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
INFO: task syz-executor.2:25392 blocked for more than 143 seconds.
       Not tainted 5.5.0-rc1-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor.2  D28520 25392   9095 0x20020004
Call Trace:
  context_switch kernel/sched/core.c:3385 [inline]
  __schedule+0x934/0x1f90 kernel/sched/core.c:4081
  schedule+0xdc/0x2b0 kernel/sched/core.c:4155
  schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:4214
  __mutex_lock_common kernel/locking/mutex.c:1036 [inline]
  __mutex_lock+0x7ab/0x13c0 kernel/locking/mutex.c:1106
  mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1121
  lock_fb_info include/linux/fb.h:637 [inline]
  fb_open+0xd7/0x450 drivers/video/fbdev/core/fbmem.c:1406
  chrdev_open+0x245/0x6b0 fs/char_dev.c:414
  do_dentry_open+0x4e6/0x1380 fs/open.c:797
  vfs_open+0xa0/0xd0 fs/open.c:914
  do_last fs/namei.c:3420 [inline]
  path_openat+0x10df/0x4500 fs/namei.c:3537
  do_filp_open+0x1a1/0x280 fs/namei.c:3567
  do_sys_open+0x3fe/0x5d0 fs/open.c:1097
  __do_compat_sys_openat fs/open.c:1143 [inline]
  __se_compat_sys_openat fs/open.c:1141 [inline]
  __ia32_compat_sys_openat+0x98/0xf0 fs/open.c:1141
  do_syscall_32_irqs_on arch/x86/entry/common.c:337 [inline]
  do_fast_syscall_32+0x27b/0xe16 arch/x86/entry/common.c:408
  entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat.S:139
RIP: 0023:0xf7f41a39
Code: Bad RIP value.
RSP: 002b:00000000f5cda0cc EFLAGS: 00000296 ORIG_RAX: 0000000000000127
RAX: ffffffffffffffda RBX: 00000000ffffff9c RCX: 0000000020000180
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000

Showing all locks held in the system:
1 lock held by khungtaskd/1113:
  #0: ffffffff899a56c0 (rcu_read_lock){....}, at:  
debug_show_all_locks+0x5f/0x279 kernel/locking/lockdep.c:5334
1 lock held by rsyslogd/8960:
  #0: ffff88808c2640e0 (&f->f_pos_lock){+.+.}, at: __fdget_pos+0xee/0x110  
fs/file.c:801
2 locks held by getty/9050:
  #0: ffff88809b3bf090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffffc900017cb2e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x220/0x1bf0 drivers/tty/n_tty.c:2156
2 locks held by getty/9051:
  #0: ffff888095020090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffffc9000184b2e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x220/0x1bf0 drivers/tty/n_tty.c:2156
2 locks held by getty/9052:
  #0: ffff8880a322a090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffffc9000182b2e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x220/0x1bf0 drivers/tty/n_tty.c:2156
2 locks held by getty/9053:
  #0: ffff88809a312090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffffc9000183b2e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x220/0x1bf0 drivers/tty/n_tty.c:2156
2 locks held by getty/9054:
  #0: ffff8880935fc090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffffc900017eb2e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x220/0x1bf0 drivers/tty/n_tty.c:2156
2 locks held by getty/9055:
  #0: ffff88809edd6090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffffc9000181b2e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x220/0x1bf0 drivers/tty/n_tty.c:2156
2 locks held by getty/9056:
  #0: ffff8880959b2090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffffc9000178b2e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x220/0x1bf0 drivers/tty/n_tty.c:2156
2 locks held by syz-executor.2/25382:
1 lock held by syz-executor.2/25386:
  #0: ffff888218cbf070 (&fb_info->lock){+.+.}, at: lock_fb_info  
include/linux/fb.h:637 [inline]
  #0: ffff888218cbf070 (&fb_info->lock){+.+.}, at: fb_get_fscreeninfo  
drivers/video/fbdev/core/fbmem.c:1283 [inline]
  #0: ffff888218cbf070 (&fb_info->lock){+.+.}, at:  
fb_compat_ioctl+0x6ed/0xc50 drivers/video/fbdev/core/fbmem.c:1314
1 lock held by syz-executor.2/25392:
  #0: ffff888218cbf070 (&fb_info->lock){+.+.}, at: lock_fb_info  
include/linux/fb.h:637 [inline]
  #0: ffff888218cbf070 (&fb_info->lock){+.+.}, at: fb_open+0xd7/0x450  
drivers/video/fbdev/core/fbmem.c:1406

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 1113 Comm: khungtaskd Not tainted 5.5.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x197/0x210 lib/dump_stack.c:118
  nmi_cpu_backtrace.cold+0x70/0xb2 lib/nmi_backtrace.c:101
  nmi_trigger_cpumask_backtrace+0x23b/0x28b lib/nmi_backtrace.c:62
  arch_trigger_cpumask_backtrace+0x14/0x20 arch/x86/kernel/apic/hw_nmi.c:38
  trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
  check_hung_uninterruptible_tasks kernel/hung_task.c:205 [inline]
  watchdog+0xb11/0x10c0 kernel/hung_task.c:289
  kthread+0x361/0x430 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 25382 Comm: syz-executor.2 Not tainted 5.5.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:__writeq arch/x86/include/asm/io.h:98 [inline]
RIP: 0010:bitfill_aligned drivers/video/fbdev/core/cfbfillrect.c:50 [inline]
RIP: 0010:bitfill_aligned+0xaa/0x210  
drivers/video/fbdev/core/cfbfillrect.c:35
Code: 31 ff 4c 89 fe e8 46 9b c0 fd 4d 85 ff 74 09 e8 9c 99 c0 fd 4c 21 7d  
d0 e8 93 99 c0 fd 49 8b 06 48 31 c3 48 23 5d d0 48 31 c3 <49> 89 1e e8 7e  
99 c0 fd 48 83 c4 18 5b 41 5c 41 5d 41 5e 41 5f 5d
RSP: 0018:ffffc90001567388 EFLAGS: 00000246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffc9000daef000
RDX: 0000000000040000 RSI: ffffffff83b491fd RDI: 0000000000000007
RBP: ffffc900015673c8 R08: ffff88808cdf4100 R09: 0000000000000040
R10: ffffed10147ab25b R11: ffff8880a3d592df R12: 0000000000000040
R13: 0000000000000040 R14: ffff8880000a0000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880ae900000(0063) knlGS:00000000f5d3db40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 00007f793125b140 CR3: 00000000a520a000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  cfb_fillrect+0x423/0x7c0 drivers/video/fbdev/core/cfbfillrect.c:327
  vga16fb_fillrect+0x6ce/0x19b0 drivers/video/fbdev/vga16fb.c:951
  bit_clear_margins+0x30b/0x530 drivers/video/fbdev/core/bitblit.c:232
  fbcon_clear_margins+0x1e9/0x250 drivers/video/fbdev/core/fbcon.c:1372
  fbcon_switch+0xd7f/0x17f0 drivers/video/fbdev/core/fbcon.c:2354
  redraw_screen+0x2b6/0x7d0 drivers/tty/vt/vt.c:997
  fbcon_modechanged+0x5c3/0x790 drivers/video/fbdev/core/fbcon.c:2991
  fbcon_update_vcs+0x42/0x50 drivers/video/fbdev/core/fbcon.c:3038
  fb_set_var+0xb32/0xdd0 drivers/video/fbdev/core/fbmem.c:1051
  do_fb_ioctl+0x390/0x7d0 drivers/video/fbdev/core/fbmem.c:1104
  fb_compat_ioctl+0x305/0xc50 drivers/video/fbdev/core/fbmem.c:1310
  __do_compat_sys_ioctl fs/compat_ioctl.c:214 [inline]
  __se_compat_sys_ioctl fs/compat_ioctl.c:142 [inline]
  __ia32_compat_sys_ioctl+0x233/0x610 fs/compat_ioctl.c:142
  do_syscall_32_irqs_on arch/x86/entry/common.c:337 [inline]
  do_fast_syscall_32+0x27b/0xe16 arch/x86/entry/common.c:408
  entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat.S:139
RIP: 0023:0xf7f41a39
Code: 00 00 00 89 d3 5b 5e 5f 5d c3 b8 80 96 98 00 eb c4 8b 04 24 c3 8b 1c  
24 c3 8b 34 24 c3 8b 3c 24 c3 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90  
90 90 90 eb 0d 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 002b:00000000f5d3d0cc EFLAGS: 00000296 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 0000000000004601
RDX: 0000000020000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
