Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC8EC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 09:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F51F22C7E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 09:28:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbfGZJ2M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 05:28:12 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:51187 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbfGZJ2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 05:28:06 -0400
Received: by mail-io1-f70.google.com with SMTP id m26so58102751ioh.17
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 02:28:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=6davJOYz8NFOOdWsY5H1NvS4PxoFkTXvVpfk5Cm4qBE=;
        b=MzyMfuQbtuSd0GDHWOP+9H1t6+UI6UmjnP4N+I36aj0FqSnXVZKp++Crw+u0QGQ26T
         p7UE9+nNA3OQiyHcvrBP7Js8MFZQdYHx95OqorIs6csibWBRTmiq7ZvT7UOXCAUQYkEG
         i+miNnydnQFbSauYjNE2bCBd8RBS95HSK/QyxH3u0Sd186ZkQ0MauppHMu54ITgjVD93
         g7IaMqeL8I7ocfxLQv5mHEK8/ouWG01uG38bjFfv6LjVN1Pu0qSB+QI9mcMo9u1xqsOm
         sQz9XjtqMidjFdpovTLwUwXOVxeFm8VUcy34z5C5CQFWj1msVplVRlWc3RIXm/NNH+Ac
         SeSw==
X-Gm-Message-State: APjAAAXJNt+BIU7Z5nclhn7rYQHZWQMSuJN4jgqT70NcPAU+dLbBK9YP
        ctweibnE8XNY81TWhiRDdMLDbcyzalHmz9BqR3m7VhyUYpws
X-Google-Smtp-Source: APXvYqxFwdBHIFL4jYOt6rFHQ+cmxmrkxCIZEIZznM0dTKOWBgCT2oVFgIqjeKqMaGUtGf98TsimqOV1imyM+Sgd2xJfVoqJC0R1
MIME-Version: 1.0
X-Received: by 2002:a05:6638:c8:: with SMTP id w8mr99608159jao.52.1564133285664;
 Fri, 26 Jul 2019 02:28:05 -0700 (PDT)
Date:   Fri, 26 Jul 2019 02:28:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000df9d48058e9228cd@google.com>
Subject: KASAN: use-after-free Read in psi_task_change
From:   syzbot <syzbot+f17ba6f9b8d9cc0498d0@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    bed38c3e Merge tag 'powerpc-5.3-2' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=160b9ef0600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9aec8cb13b5f7389
dashboard link: https://syzkaller.appspot.com/bug?extid=f17ba6f9b8d9cc0498d0
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10dc7b34600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+f17ba6f9b8d9cc0498d0@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in raw_write_seqcount_begin  
include/linux/seqlock.h:228 [inline]
BUG: KASAN: use-after-free in write_seqcount_begin_nested  
include/linux/seqlock.h:376 [inline]
BUG: KASAN: use-after-free in write_seqcount_begin  
include/linux/seqlock.h:382 [inline]
BUG: KASAN: use-after-free in psi_group_change kernel/sched/psi.c:689  
[inline]
BUG: KASAN: use-after-free in psi_task_change+0x89b/0x9d0  
kernel/sched/psi.c:780
Read of size 4 at addr ffff888039cd9460 by task syz-executor.3/9140

CPU: 1 PID: 9140 Comm: syz-executor.3 Not tainted 5.3.0-rc1+ #83
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  print_address_description.cold+0xd4/0x306 mm/kasan/report.c:351
  __kasan_report.cold+0x1b/0x36 mm/kasan/report.c:482
  kasan_report+0x12/0x17 mm/kasan/common.c:612
  __asan_report_load4_noabort+0x14/0x20 mm/kasan/generic_report.c:131
  raw_write_seqcount_begin include/linux/seqlock.h:228 [inline]
  write_seqcount_begin_nested include/linux/seqlock.h:376 [inline]
  write_seqcount_begin include/linux/seqlock.h:382 [inline]
  psi_group_change kernel/sched/psi.c:689 [inline]
  psi_task_change+0x89b/0x9d0 kernel/sched/psi.c:780
  psi_dequeue kernel/sched/stats.h:100 [inline]
  dequeue_task kernel/sched/core.c:1191 [inline]
  deactivate_task+0x2f3/0x420 kernel/sched/core.c:1215
  __schedule+0xecc/0x1580 kernel/sched/core.c:3844
  schedule+0xa8/0x270 kernel/sched/core.c:3944
  freezable_schedule include/linux/freezer.h:172 [inline]
  do_nanosleep+0x201/0x6a0 kernel/time/hrtimer.c:1679
  hrtimer_nanosleep+0x2a6/0x570 kernel/time/hrtimer.c:1733
  __do_sys_nanosleep kernel/time/hrtimer.c:1767 [inline]
  __se_sys_nanosleep kernel/time/hrtimer.c:1754 [inline]
  __x64_sys_nanosleep+0x1a6/0x220 kernel/time/hrtimer.c:1754
  do_syscall_64+0xfd/0x6a0 arch/x86/entry/common.c:296
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457cd0
Code: c0 5b 5d c3 66 0f 1f 44 00 00 8b 04 24 48 83 c4 18 5b 5d c3 66 0f 1f  
44 00 00 83 3d 81 ea 61 00 00 75 14 b8 23 00 00 00 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 24 d3 fb ff c3 48 83 ec 08 e8 ea 46 00 00
RSP: 002b:00007fff3ad23fa8 EFLAGS: 00000246 ORIG_RAX: 0000000000000023
RAX: ffffffffffffffda RBX: 000000000001555c RCX: 0000000000457cd0
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00007fff3ad23fb0
RBP: 0000000000000038 R08: 0000000000000001 R09: 00005555557ca940
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000008
R13: 00007fff3ad24000 R14: 0000000000015503 R15: 00007fff3ad24010

The buggy address belongs to the page:
page:ffffea0000e73640 refcount:0 mapcount:0 mapping:0000000000000000  
index:0x0
flags: 0x1fffc0000000000()
raw: 01fffc0000000000 ffffea0000e73648 ffffea0000e73648 0000000000000000
raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff888039cd9300: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
  ffff888039cd9380: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> ffff888039cd9400: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                                                        ^
  ffff888039cd9480: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
  ffff888039cd9500: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
