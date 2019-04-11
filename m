Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD0CC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 16:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F3812146F
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 16:56:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbfDKQ4L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 12:56:11 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:48363 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbfDKQ4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 12:56:11 -0400
Received: by mail-io1-f69.google.com with SMTP id 186so5377107iox.15
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 09:56:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=lLqElqC0m4XZ0+jrm0tolRXN3tBjnF42xKr6PQb6rUg=;
        b=Hh1loLRwlDXBs1W8RKMFmVdNdYJps7zx++GycIeRMnhkLip+Bx8c/AGCJ+1QTX2Ku0
         mBUQrciKQ/OjgcKwBrjt7GU8gG52dCI360z0mvByIEkk7C0bVUUgvu9iZLcFpAvKpdRJ
         q4KvQwyqI8y+AYzhW5fXpsPmicaQ7Q5zF/5sYIBaD4fR9cuDDr2T9x2gKCiVP/f0gcsk
         bcLh01ld8D6LiwuNi4wNYuXfB2NaOnKlga9gXGZeF3UMpJVYcm2eCd37m54C9Ro2ag4S
         m88LcqCJB20yhouWOfX9ih/XiKO57hAslvAbb4Izihd1b7nFyegeyI33HBA29vZwo6EP
         yicQ==
X-Gm-Message-State: APjAAAXzN5B2LUaMW4TMtOlXrwLjQqYshLMH4OZEzesTsfRtgeUCYEsm
        5XNJww7VjCK8K7LhRLXVXAVeweEqv56jTvG8w3MuQ7msIWrb
X-Google-Smtp-Source: APXvYqzy46TzZftNoE9hRg0nfs7bLbQBgSG/JPpnjZVk//QGpp2Vvk13ReEkr4pPfthDbqx/9bxVg1tJRjTvLz2dhkEVDJSJXaKl
MIME-Version: 1.0
X-Received: by 2002:a6b:6f0e:: with SMTP id k14mr8672894ioc.11.1555001770075;
 Thu, 11 Apr 2019 09:56:10 -0700 (PDT)
Date:   Thu, 11 Apr 2019 09:56:10 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000216cff05864410ea@google.com>
Subject: INFO: task hung in snd_seq_kernel_client_ctl
From:   syzbot <syzbot+47ded6c0f23016cde310@syzkaller.appspotmail.com>
To:     alsa-devel@alsa-project.org, groeck@chromium.org,
        linux-kernel@vger.kernel.org, perex@perex.cz,
        syzkaller-bugs@googlegroups.com, tiwai@suse.com, tiwai@suse.de,
        zsm@chromium.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    2f4c4d83 Add linux-next specific files for 20190411
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1261f42d200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bfc6a0294e6babef
dashboard link: https://syzkaller.appspot.com/bug?extid=47ded6c0f23016cde310
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=130cecb7200000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13c0efab200000

The bug was bisected to:

commit feb689025fbb6f0aa6297d3ddf97de945ea4ad32
Author: Takashi Iwai <tiwai@suse.de>
Date:   Tue Apr 9 15:35:22 2019 +0000

     ALSA: seq: Protect in-kernel ioctl calls with mutex

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=178552b7200000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=144552b7200000
console output: https://syzkaller.appspot.com/x/log.txt?x=104552b7200000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+47ded6c0f23016cde310@syzkaller.appspotmail.com
Fixes: feb689025fbb ("ALSA: seq: Protect in-kernel ioctl calls with mutex")

INFO: task syz-executor971:9265 blocked for more than 143 seconds.
       Not tainted 5.1.0-rc4-next-20190411 #23
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor971 D28264  9265   9263 0x80000002
Call Trace:
  context_switch kernel/sched/core.c:2877 [inline]
  __schedule+0x817/0x1cc0 kernel/sched/core.c:3518
  schedule+0x92/0x180 kernel/sched/core.c:3562
  schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:3620
  __mutex_lock_common kernel/locking/mutex.c:1002 [inline]
  __mutex_lock+0x726/0x1310 kernel/locking/mutex.c:1072
  mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1087
  snd_seq_kernel_client_ctl+0xe5/0x170 sound/core/seq/seq_clientmgr.c:2345
  snd_seq_oss_control sound/core/seq/oss/seq_oss_device.h:157 [inline]
  snd_seq_oss_writeq_clear+0xe0/0x140 sound/core/seq/oss/seq_oss_writeq.c:85
  snd_seq_oss_writeq_delete+0x20/0x40 sound/core/seq/oss/seq_oss_writeq.c:69
  free_devinfo+0x66/0xc0 sound/core/seq/oss/seq_oss_init.c:406
  port_delete+0xe8/0x1c0 sound/core/seq/seq_ports.c:272
  snd_seq_delete_port+0x266/0x330 sound/core/seq/seq_ports.c:301
  snd_seq_ioctl_delete_port+0xba/0x190 sound/core/seq/seq_clientmgr.c:1321
  snd_seq_kernel_client_ctl+0x112/0x170 sound/core/seq/seq_clientmgr.c:2346
  snd_seq_event_port_detach+0xba/0x100 sound/core/seq/seq_ports.c:705
  delete_port+0x87/0xd0 sound/core/seq/oss/seq_oss_init.c:354
  snd_seq_oss_release+0xf5/0x150 sound/core/seq/oss/seq_oss_init.c:433
  odev_release+0x54/0x80 sound/core/seq/oss/seq_oss.c:153
  __fput+0x2e5/0x8d0 fs/file_table.c:278
  ____fput+0x16/0x20 fs/file_table.c:309
  task_work_run+0x14a/0x1c0 kernel/task_work.c:113
  exit_task_work include/linux/task_work.h:22 [inline]
  do_exit+0x90a/0x2fa0 kernel/exit.c:876
  do_group_exit+0x135/0x370 kernel/exit.c:980
  __do_sys_exit_group kernel/exit.c:991 [inline]
  __se_sys_exit_group kernel/exit.c:989 [inline]
  __x64_sys_exit_group+0x44/0x50 kernel/exit.c:989
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x43ed98
Code: Bad RIP value.
RSP: 002b:00007fff4f4de2a8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 000000000043ed98
RDX: 0000000000000000 RSI: 000000000000003c RDI: 0000000000000000
RBP: 00000000004be5a8 R08: 00000000000000e7 R09: ffffffffffffffd0
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00000000006d0180 R14: 0000000000000000 R15: 0000000000000000
INFO: lockdep is turned off.
NMI backtrace for cpu 1
CPU: 1 PID: 1038 Comm: khungtaskd Not tainted 5.1.0-rc4-next-20190411 #23
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  nmi_cpu_backtrace.cold+0x63/0xa4 lib/nmi_backtrace.c:101
  nmi_trigger_cpumask_backtrace+0x1be/0x236 lib/nmi_backtrace.c:62
  arch_trigger_cpumask_backtrace+0x14/0x20 arch/x86/kernel/apic/hw_nmi.c:38
  trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
  check_hung_uninterruptible_tasks kernel/hung_task.c:204 [inline]
  watchdog+0x9b7/0xec0 kernel/hung_task.c:288
  kthread+0x357/0x430 kernel/kthread.c:254
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
Sending NMI from CPU 1 to CPUs 0:


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
