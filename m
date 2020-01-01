Return-Path: <SRS0=1Df5=2W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69902C2D0DE
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 20:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F2D2208C3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 20:45:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbgAAUpM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jan 2020 15:45:12 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:40847 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727171AbgAAUpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 15:45:11 -0500
Received: by mail-il1-f199.google.com with SMTP id e4so22095850ilm.7
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jan 2020 12:45:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=z+jsKNGUzjt/Tpqke4OmDDsYKTN4pul5W1pYZG8/BBY=;
        b=PYobUJQtQVZQQhSdq4gtdQxWFhsVGkXN71BsNh+AzWg0ll4laqjLqjmMJ6TYPZY2tg
         j09AhiI34CKOLkJ2xMH96hoBYTb2o7V4PPFR5YJDCEsVAzZyfP7vpkL3uyAMOtBOYHX7
         nWqS99Yo9qfnZWl5NbAKOIUAdbD0NoVcJaX7X0SIPo3fN9tKwiagNEsaoSj1caPXw7/i
         wRtd/8j90ag9e/+ta23JaxZa5C2ius0CA22ZhmY2nclhW/lgUYwxLO0uTZa/OCp9Z5G2
         v6TwU5QX69V2404ppck9jeDRgOlH66VtivE/1bFEQheULVKxevnES+FBrp0uEH211CHp
         KLQg==
X-Gm-Message-State: APjAAAWrtdn8up+iafU9iQ7Si5K1dXDpbJUmWqMCqpvD7Dmh30iIHO6V
        nWlnAejJNzkw5Mvf6Lhil16KotXtWgdmIzKhtLS0NtUHTUsL
X-Google-Smtp-Source: APXvYqzNntUpuD88rPgWm026143NyG+44VcTmTmQURJJ4twSQsdtL2eI83QcL799Ngw5X9TKdolBogXQxgSgEULdbOMvG7AYb5Yp
MIME-Version: 1.0
X-Received: by 2002:a02:ba91:: with SMTP id g17mr63504219jao.106.1577911511029;
 Wed, 01 Jan 2020 12:45:11 -0800 (PST)
Date:   Wed, 01 Jan 2020 12:45:11 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001a1ef1059b1a27c7@google.com>
Subject: INFO: task hung in __generic_file_fsync (2)
From:   syzbot <syzbot+44c32606d8669fb0d45c@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, axboe@kernel.dk, dave@stgolabs.net,
        hch@lst.de, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        ming.lei@redhat.com, osandov@fb.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    bf8d1cd4 Merge tag 'scsi-fixes' of git://git.kernel.org/pu..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11b80869e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ed9d672709340e35
dashboard link: https://syzkaller.appspot.com/bug?extid=44c32606d8669fb0d45c
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=137e2615e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11306971e00000

The bug was bisected to:

commit 6dc4f100c175dd0511ae8674786e7c9006cdfbfa
Author: Ming Lei <ming.lei@redhat.com>
Date:   Fri Feb 15 11:13:19 2019 +0000

     block: allow bio_for_each_segment_all() to iterate over multi-page bvec

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=130c5e49e00000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=108c5e49e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=170c5e49e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+44c32606d8669fb0d45c@syzkaller.appspotmail.com
Fixes: 6dc4f100c175 ("block: allow bio_for_each_segment_all() to iterate  
over multi-page bvec")

INFO: task syz-executor072:10629 blocked for more than 143 seconds.
       Not tainted 5.5.0-rc3-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor072 D25264 10629  10066 0x00004004
Call Trace:
  context_switch kernel/sched/core.c:3385 [inline]
  __schedule+0x934/0x1f90 kernel/sched/core.c:4081
  schedule+0xdc/0x2b0 kernel/sched/core.c:4155
  io_schedule+0x1c/0x70 kernel/sched/core.c:5799
  wait_on_page_bit_common mm/filemap.c:1175 [inline]
  wait_on_page_bit+0x27c/0xa60 mm/filemap.c:1224
  wait_on_page_writeback+0x1b2/0x4f0 mm/page-writeback.c:2822
  __filemap_fdatawait_range+0x145/0x340 mm/filemap.c:526
  file_write_and_wait_range+0x1ac/0x210 mm/filemap.c:786
  __generic_file_fsync+0x79/0x200 fs/libfs.c:1000
  fat_file_fsync+0x78/0x210 fs/fat/file.c:190
  vfs_fsync_range+0x141/0x230 fs/sync.c:197
  generic_write_sync include/linux/fs.h:2856 [inline]
  generic_file_write_iter+0x4ea/0x68e mm/filemap.c:3474
  call_write_iter include/linux/fs.h:1902 [inline]
  do_iter_readv_writev+0x5f8/0x8f0 fs/read_write.c:693
  do_iter_write fs/read_write.c:970 [inline]
  do_iter_write+0x184/0x610 fs/read_write.c:951
  vfs_iter_write+0x77/0xb0 fs/read_write.c:983
  iter_file_splice_write+0x717/0xc10 fs/splice.c:760
  do_splice_from fs/splice.c:863 [inline]
  direct_splice_actor+0x123/0x190 fs/splice.c:1037
  splice_direct_to_actor+0x3b4/0xa30 fs/splice.c:992
  do_splice_direct+0x1da/0x2a0 fs/splice.c:1080
  do_sendfile+0x597/0xd00 fs/read_write.c:1464
  __do_sys_sendfile64 fs/read_write.c:1525 [inline]
  __se_sys_sendfile64 fs/read_write.c:1511 [inline]
  __x64_sys_sendfile64+0x1dd/0x220 fs/read_write.c:1511
  do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x445e59
Code: Bad RIP value.
RSP: 002b:00007ffc4bfab018 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000445e59
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000004
RBP: 0000000000000000 R08: 0000000000402fe0 R09: 0000000000402fe0
R10: 00008080fffffffe R11: 0000000000000246 R12: 0000000000000082
R13: 0000000000402fe0 R14: 0000000000000000 R15: 0000000000000000

Showing all locks held in the system:
1 lock held by khungtaskd/1116:
  #0: ffffffff899a5680 (rcu_read_lock){....}, at:  
debug_show_all_locks+0x5f/0x279 kernel/locking/lockdep.c:5334
1 lock held by rs:main Q:Reg/9913:
  #0: ffff8880ae937358 (&rq->lock){-.-.}, at: newidle_balance+0xa28/0xe80  
kernel/sched/fair.c:10177
1 lock held by rsyslogd/9915:
  #0: ffff888087f713e0 (&f->f_pos_lock){+.+.}, at: __fdget_pos+0xee/0x110  
fs/file.c:801
2 locks held by getty/10037:
  #0: ffff8880a2d26090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffffc900018132e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x220/0x1bf0 drivers/tty/n_tty.c:2156
2 locks held by getty/10038:
  #0: ffff88809f419090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffffc900018932e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x220/0x1bf0 drivers/tty/n_tty.c:2156
2 locks held by getty/10039:
  #0: ffff8880a2725090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffffc900018732e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x220/0x1bf0 drivers/tty/n_tty.c:2156
2 locks held by getty/10040:
  #0: ffff8880966a2090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffffc900018832e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x220/0x1bf0 drivers/tty/n_tty.c:2156
2 locks held by getty/10041:
  #0: ffff88809e168090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffffc900017f32e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x220/0x1bf0 drivers/tty/n_tty.c:2156
2 locks held by getty/10042:
  #0: ffff8880a7c45090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffffc900018332e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x220/0x1bf0 drivers/tty/n_tty.c:2156
2 locks held by getty/10043:
  #0: ffff88809958e090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffffc900011402e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x220/0x1bf0 drivers/tty/n_tty.c:2156
1 lock held by syz-executor072/10629:
  #0: ffff88809a52a428 (sb_writers#9){.+.+}, at: file_start_write  
include/linux/fs.h:2885 [inline]
  #0: ffff88809a52a428 (sb_writers#9){.+.+}, at: do_sendfile+0x9b9/0xd00  
fs/read_write.c:1463

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 1116 Comm: khungtaskd Not tainted 5.5.0-rc3-syzkaller #0
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
NMI backtrace for cpu 1 skipped: idling at native_safe_halt+0xe/0x10  
arch/x86/include/asm/irqflags.h:60


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
