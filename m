Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60AA1C04AB1
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 01:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2832321841
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 01:07:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbfEJBHH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 21:07:07 -0400
Received: from mail-it1-f199.google.com ([209.85.166.199]:59405 "EHLO
        mail-it1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726716AbfEJBHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 21:07:07 -0400
Received: by mail-it1-f199.google.com with SMTP id x143so3738605itb.9
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 18:07:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=kejkzFyuQrMvV/WzWbMJYKz3xvR/PLqJ5goEOCzhWCY=;
        b=bqtc3fPMkgDTgk5Lyw0mPoQ/ntivXD/EpP03ciGnaKHeayC2GHXqzh6YuX/5hn9KLW
         OW+TzyA9laZkDrzzEWmmsG2JZvcExsIDmWmPqjgAgfIdEaz9qs/2AIo7RnD41JS9K88K
         3a3Sim0PM0ipcBc6KrD2Da9VMSUqqH0OTwFnhnxRIMM7hTuusy3l/ruNwr5S6+urci+Z
         UEMrlGFJY5DfO1HTL9RxHkYLnrMaX5C3LfoJUqoHkSYUKChBt6gZ8S0rWV78uvzSZvsy
         MlRfqBTtWcrz8GP5vpmI9vDW9sovJ8xhAz00Wbs2VrgyPtGQ64MtQKSXkSHfexRKiNrY
         KLGA==
X-Gm-Message-State: APjAAAWxR6oz6YW7jTWqlDTFgeEtNyqKHzGo740+Zf2akWtX5vkNtqYB
        S/5norRVlw1dtdE6ddRSaXuC7fYs1v4tuAhKURnsrURgNnBc
X-Google-Smtp-Source: APXvYqyY1rC7/xw+NMIgzsmvFEnLkQkM7v1xbzByaRCpFSQneOGZ6spoP22GP2HKUjtWRrsxxBfvVi9svNF9aKK37w8mRLyWKXaq
MIME-Version: 1.0
X-Received: by 2002:a24:9289:: with SMTP id l131mr5305535itd.45.1557450425775;
 Thu, 09 May 2019 18:07:05 -0700 (PDT)
Date:   Thu, 09 May 2019 18:07:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000062436a05887e2f72@google.com>
Subject: WARNING: locking bug in copy_process
From:   syzbot <syzbot+3286e58549edc479faae@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, arnd@arndb.de, arunks@codeaurora.org,
        christian@brauner.io, cyphar@cyphar.com, dhowells@redhat.com,
        ebiederm@xmission.com, elena.reshetova@intel.com, guro@fb.com,
        jannh@google.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, luto@amacapital.net, luto@kernel.org,
        mhocko@suse.com, mingo@kernel.org, mtk.manpages@gmail.com,
        namit@vmware.com, oleg@redhat.com, peterz@infradead.org,
        riel@surriel.com, shakeelb@google.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        wad@chromium.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    a2d635de Merge tag 'drm-next-2019-05-09' of git://anongit...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12b36dd0a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2ef407aed78c3758
dashboard link: https://syzkaller.appspot.com/bug?extid=3286e58549edc479faae
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12d85ec8a00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11df8778a00000

The bug was bisected to:

commit b3e5838252665ee4cfa76b82bdf1198dca81e5be
Author: Christian Brauner <christian@brauner.io>
Date:   Wed Mar 27 12:04:15 2019 +0000

     clone: add CLONE_PIDFD

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14fe77b4a00000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=16fe77b4a00000
console output: https://syzkaller.appspot.com/x/log.txt?x=12fe77b4a00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+3286e58549edc479faae@syzkaller.appspotmail.com
Fixes: b3e583825266 ("clone: add CLONE_PIDFD")

  entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat.S:139
RIP: 0023:0xf7fec849
Code: 85 d2 74 02 89 0a 5b 5d c3 8b 04 24 c3 8b 14 24 c3 8b 3c 24 c3 90 90  
90 90 90 90 90 90 90 90 90 90 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90  
90 90 90 eb 0d 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 002b:00000000ffed5a8c EFLAGS: 00000246 ORIG_RAX: 0000000000000078
RAX: ffffffffffffffda RBX: 0000000000003ffc RCX: 0000000000000000
RDX: 00000000200005c0 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000012 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(depth <= 0)
WARNING: CPU: 1 PID: 7744 at kernel/locking/lockdep.c:4052 __lock_release  
kernel/locking/lockdep.c:4052 [inline]
WARNING: CPU: 1 PID: 7744 at kernel/locking/lockdep.c:4052  
lock_release+0x667/0xa00 kernel/locking/lockdep.c:4321
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 7744 Comm: syz-executor007 Not tainted 5.1.0+ #4
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  panic+0x2cb/0x65c kernel/panic.c:214
  __warn.cold+0x20/0x45 kernel/panic.c:566
  report_bug+0x263/0x2b0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:179 [inline]
  fixup_bug arch/x86/kernel/traps.c:174 [inline]
  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:272
  do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:291
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:972
RIP: 0010:__lock_release kernel/locking/lockdep.c:4052 [inline]
RIP: 0010:lock_release+0x667/0xa00 kernel/locking/lockdep.c:4321
Code: 0f 85 a0 03 00 00 8b 35 77 66 08 08 85 f6 75 23 48 c7 c6 a0 55 6b 87  
48 c7 c7 40 25 6b 87 4c 89 85 70 ff ff ff e8 b7 a9 eb ff <0f> 0b 4c 8b 85  
70 ff ff ff 4c 89 ea 4c 89 e6 4c 89 c7 e8 52 63 ff
RSP: 0018:ffff888094117b48 EFLAGS: 00010086
RAX: 0000000000000000 RBX: 1ffff11012822f6f RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff815af236 RDI: ffffed1012822f5b
RBP: ffff888094117c00 R08: ffff888092bfc400 R09: fffffbfff113301d
R10: fffffbfff113301c R11: ffffffff889980e3 R12: ffffffff8a451df8
R13: ffffffff8142e71f R14: ffffffff8a44cc80 R15: ffff888094117bd8
  percpu_up_read.constprop.0+0xcb/0x110 include/linux/percpu-rwsem.h:92
  cgroup_threadgroup_change_end include/linux/cgroup-defs.h:712 [inline]
  copy_process.part.0+0x47ff/0x6710 kernel/fork.c:2222
  copy_process kernel/fork.c:1772 [inline]
  _do_fork+0x25d/0xfd0 kernel/fork.c:2338
  __do_compat_sys_x86_clone arch/x86/ia32/sys_ia32.c:240 [inline]
  __se_compat_sys_x86_clone arch/x86/ia32/sys_ia32.c:236 [inline]
  __ia32_compat_sys_x86_clone+0xbc/0x140 arch/x86/ia32/sys_ia32.c:236
  do_syscall_32_irqs_on arch/x86/entry/common.c:334 [inline]
  do_fast_syscall_32+0x281/0xd54 arch/x86/entry/common.c:405
  entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat.S:139
RIP: 0023:0xf7fec849
Code: 85 d2 74 02 89 0a 5b 5d c3 8b 04 24 c3 8b 14 24 c3 8b 3c 24 c3 90 90  
90 90 90 90 90 90 90 90 90 90 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90  
90 90 90 eb 0d 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 002b:00000000ffed5a8c EFLAGS: 00000246 ORIG_RAX: 0000000000000078
RAX: ffffffffffffffda RBX: 0000000000003ffc RCX: 0000000000000000
RDX: 00000000200005c0 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000012 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
