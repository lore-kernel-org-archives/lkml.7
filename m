Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_DIGITS,
	FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D193C10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 16:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 264892084E
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 16:48:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbfDNQsG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 12:48:06 -0400
Received: from mail-it1-f200.google.com ([209.85.166.200]:55774 "EHLO
        mail-it1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfDNQsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 12:48:06 -0400
Received: by mail-it1-f200.google.com with SMTP id g184so14323452ita.5
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2019 09:48:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=mTd7FlO4DVld4dGiRikhCQg6Ozanh+a6KILDmEGiA9g=;
        b=BWnvo/t0RyDSs7S0xnuJLWLDrf8wFoxlLv7LCRmR6cYYq4U5ef9+YQM81ikhi2Y4Xo
         biAz+ubyEYioia/JQ6pAf9zMh2JQjK6NWedrRXzYhAJiwm6xt08RF9BTNZoEXaFtSUWP
         SSnGwpWjoMr4du4RIaLr6InMtxNKYx9EDmKP6rmRVcq7uPgkR0IRcN6vdFSRlmlRSAKr
         LjIPPjzxC6MnICVH29KSlFGkB7+kUZ0G61OIGZTP9AQxfz5aSrcexj47Yu6M6IGPJtk9
         aTYeKgbId+hLyul6su1ylyG5ANr9TjaHAT4rYSDKyzBQPFP7qc+Lre2nfDwBigpyoDc0
         BDgA==
X-Gm-Message-State: APjAAAUkPBkkJo08eeAyDVKoDvHkoXB4SV7sYzvg/82TAyZo/wHh5L2A
        TdCfOn241shbJoS8V5jag9i1Q+Tn9eTG+t3fZiX8ldct8Can
X-Google-Smtp-Source: APXvYqzEXO1IN1w+fzMp4vmi4LX+LFQsCs/wTEIfM9bUOnyCXKl/3RB0weMxeQbc4kY3wrr4swQcvKWBIEW+MxZOFm15oe6eZt8E
MIME-Version: 1.0
X-Received: by 2002:a5e:8b44:: with SMTP id z4mr1026481iom.1.1555260485497;
 Sun, 14 Apr 2019 09:48:05 -0700 (PDT)
Date:   Sun, 14 Apr 2019 09:48:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c57e110586804ce9@google.com>
Subject: WARNING in lockdep_unregister_key (2)
From:   syzbot <syzbot+800069ac21123326861a@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    6d0a5984 Merge branch 'x86-urgent-for-linus' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=178c986b200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4fb64439e07a1ec0
dashboard link: https://syzkaller.appspot.com/bug?extid=800069ac21123326861a
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+800069ac21123326861a@syzkaller.appspotmail.com

WARNING: CPU: 0 PID: 7126 at kernel/locking/lockdep.c:4920  
lockdep_unregister_key+0x3bf/0x510 kernel/locking/lockdep.c:4906
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 7126 Comm: kworker/0:1 Not tainted 5.1.0-rc4+ #65
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events pwq_unbound_release_workfn
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  panic+0x2cb/0x65c kernel/panic.c:214
  __warn.cold+0x20/0x45 kernel/panic.c:571
  report_bug+0x263/0x2b0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:179 [inline]
  fixup_bug arch/x86/kernel/traps.c:174 [inline]
  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:272
  do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:291
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:973
RIP: 0010:lockdep_unregister_key+0x3bf/0x510 kernel/locking/lockdep.c:4920
Code: 00 00 00 00 48 8b 45 d0 65 48 33 04 25 28 00 00 00 0f 85 48 01 00 00  
48 83 c4 70 5b 41 5c 41 5d 41 5e 41 5f 5d c3 0f 0b eb c7 <0f> 0b e9 e9 fe  
ff ff 0f 0b 0f 0b 48 c7 c2 e0 97 92 88 89 43 c0 48
RSP: 0018:ffff888059cbfc50 EFLAGS: 00010046
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff8156dfd8
RDX: 1ffffffff1467ac7 RSI: 0000000000000004 RDI: ffffffff8a33d638
RBP: ffff888059cbfce8 R08: 0000000000002010 R09: ffffed100b397f91
R10: ffffed100b397f90 R11: 0000000000000003 R12: ffff88808d893dd8
R13: 1ffff1100b397f8c R14: ffffffff8a0b9788 R15: dffffc0000000000
  wq_unregister_lockdep kernel/workqueue.c:3455 [inline]
  pwq_unbound_release_workfn+0x233/0x2f0 kernel/workqueue.c:3675
  process_one_work+0x98e/0x1790 kernel/workqueue.c:2269
  worker_thread+0x98/0xe40 kernel/workqueue.c:2415
  kthread+0x357/0x430 kernel/kthread.c:253
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
