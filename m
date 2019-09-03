Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 161C2C3A5A5
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 16:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC5CF215EA
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 16:38:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731193AbfICQiL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 12:38:11 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:49717 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730418AbfICQiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 12:38:08 -0400
Received: by mail-io1-f70.google.com with SMTP id j23so13053930iog.16
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 09:38:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=6951hsx/JflbcnHJ38448inFnROH/ckXY2OtbJ5vDFE=;
        b=V/+OcJ7xIiKib0cDEqjNC0mE+wmyWeO7yI/F2gBrkg7oxniUYfi7MMcxbnpM4vcwMM
         r+QmqlO+VAMEOW9nBu22VIwONJJYUs6IHlWFWX8eEH1w323suubH+w4WytyLDCa6UecK
         aVznF6eaYo+EY9gtAXj0iE7Ah+drG8dIGyOkUBXuvfMmiduhxPGKagQ5zAZV45W+qsaW
         qCU8MSH2KasuGfDF72JKmkbPKqPmdr0VCyXyxvdOiYhrQ+dlXH20kDL+2z+Jzr/TC8KK
         HiWek/AgGtFkZAiwbzl/8aKKzKq+haz8YB67IfQMjYVthT4MDX0NbE0reMN3CEOgjbKf
         09UA==
X-Gm-Message-State: APjAAAWohz70bWh01ZMm+31xCdeyKkzCJNskMHFA4bCDyxj3gdU+2RQh
        zy5ZpxJmVMVd65BEV04hnYrDhmqkjfJbzrIQlL9/36KHGTXE
X-Google-Smtp-Source: APXvYqwrU6A8cwbVDiefeDbG61BgxpLVwJThXBg0CYPw9OE/gQx+fwY2U7wsQYTgYqSjABN+gvG8aW/NDEw/iSL4rXBccyWNsVTY
MIME-Version: 1.0
X-Received: by 2002:a6b:f307:: with SMTP id m7mr13064789ioh.84.1567528687722;
 Tue, 03 Sep 2019 09:38:07 -0700 (PDT)
Date:   Tue, 03 Sep 2019 09:38:07 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009b6b880591a8b697@google.com>
Subject: WARNING in posix_cpu_timer_del (3)
From:   syzbot <syzbot+dabf3198a30ed5a2158f@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    6d028043 Add linux-next specific files for 20190830
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=179e59de600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=82a6bec43ab0cb69
dashboard link: https://syzkaller.appspot.com/bug?extid=dabf3198a30ed5a2158f
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13bb4546600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13af4356600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+dabf3198a30ed5a2158f@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 9805 at kernel/time/posix-cpu-timers.c:401  
posix_cpu_timer_del+0x2f0/0x3b0 kernel/time/posix-cpu-timers.c:401
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 9805 Comm: syz-executor380 Not tainted 5.3.0-rc6-next-20190830  
#75
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  panic+0x2dc/0x755 kernel/panic.c:220
  __warn.cold+0x2f/0x3c kernel/panic.c:581
  report_bug+0x289/0x300 lib/bug.c:195
  fixup_bug arch/x86/kernel/traps.c:179 [inline]
  fixup_bug arch/x86/kernel/traps.c:174 [inline]
  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:272
  do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:291
  invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1028
RIP: 0010:posix_cpu_timer_del+0x2f0/0x3b0 kernel/time/posix-cpu-timers.c:401
Code: 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85  
b5 00 00 00 48 83 bb c8 00 00 00 00 74 16 e8 00 58 0d 00 <0f> 0b e9 87 fe  
ff ff e8 c4 38 48 00 e9 dd fd ff ff e8 ea 57 0d 00
RSP: 0018:ffff88809ac87a30 EFLAGS: 00010093
RAX: ffff888090a6e0c0 RBX: ffff88809ae762e0 RCX: 1ffff1101214dd2a
RDX: 0000000000000000 RSI: ffffffff8164fe10 RDI: ffff88809ae763a8
RBP: ffff88809ac87ac0 R08: 0000000000000002 R09: ffff888090a6e958
R10: fffffbfff138aef8 R11: ffffffff89c577c7 R12: ffff88809b326100
R13: 1ffff11013590f47 R14: ffff88809ac87a98 R15: ffff88809ae76338
  timer_delete_hook kernel/time/posix-timers.c:978 [inline]
  itimer_delete kernel/time/posix-timers.c:1021 [inline]
  exit_itimers+0xdb/0x2e0 kernel/time/posix-timers.c:1041
  do_exit+0x1980/0x2e60 kernel/exit.c:853
  do_group_exit+0x135/0x360 kernel/exit.c:983
  get_signal+0x47c/0x2500 kernel/signal.c:2734
  do_signal+0x87/0x1700 arch/x86/kernel/signal.c:815
  exit_to_usermode_loop+0x286/0x380 arch/x86/entry/common.c:159
  prepare_exit_to_usermode arch/x86/entry/common.c:194 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:274 [inline]
  do_syscall_64+0x65f/0x760 arch/x86/entry/common.c:300
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x446679
Code: e8 5c b3 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 0b 08 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffff909e168 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: 0000000000000000 RBX: 0000000000017a92 RCX: 0000000000446679
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00000000006dbc2c
RBP: 00000000006dbc2c R08: 000000037ffffa00 R09: 000000037ffffa00
R10: 00007ffff909e180 R11: 0000000000000246 R12: 00000000006dbc20
R13: 0000000000000000 R14: 000000000000002d R15: 20c49ba5e353f7cf
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
