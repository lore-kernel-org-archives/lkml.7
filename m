Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B764C31E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 15:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BA952187F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 15:57:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729874AbfFSP5K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 11:57:10 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:54810 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfFSP5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 11:57:09 -0400
Received: by mail-io1-f72.google.com with SMTP id n8so21761905ioo.21
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 08:57:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=MGvBmLiBNh+C4+wwdFS/TTKkg1E7EQ8Skztj3YqExG8=;
        b=V+FspX4fAOFVjwvHEWyGrJydsI52csau6GqFnBSCzbw1ByArUJTE8AYeOaeIKCWS0m
         e8dxuedAHPGJt1i9X3XyxuFrThJOWPVQe6SYKDVAFWafdJXNb0kTWoc+QyNK3Srci24V
         jzC9hcXRrFmEXSj8+84yDnLZewoJRnKixtYy/o0JN26beb/i1wK+CwCutNVlznWjcRW7
         4CcFpKZ3JZpxxkjMhIJnVhddbVdbZr2kXlPncYUYqw2JBEN11iCr4CUo0lTo9VRZURuJ
         xT6UM+IqH92DTJR3OiqqJwoN0LYP5JoZJvdDAYUA0iYimnUZtJOKHk7hdLvV0TkHyVVB
         w2kQ==
X-Gm-Message-State: APjAAAW+fWCtTqpCxNi55qIpFhLJmRubYIwRtcwD2/K7vaLx8inJ3Lzx
        ecYS6W7Nt0KzB9nY9W2zhLxoQCKPd43Y1pdwPrQamRXMo9g8
X-Google-Smtp-Source: APXvYqwy3jlTWkzep4C7eEUdiRgCjyCM7AL+gOyGCmyWMyoS6tuYdLGT59ANozFBE0rq+3jURdPRilgwQILtYs8AX77T3ZXpMepY
MIME-Version: 1.0
X-Received: by 2002:a05:6638:cf:: with SMTP id w15mr2319925jao.136.1560959828884;
 Wed, 19 Jun 2019 08:57:08 -0700 (PDT)
Date:   Wed, 19 Jun 2019 08:57:08 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001c03bf058baf488a@google.com>
Subject: BUG: unable to handle kernel paging request in hrtimer_interrupt
From:   syzbot <syzbot+037e18398ba8c655a652@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    29f785ff Merge branch 'fixes' of git://git.kernel.org/pub/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10539ceaa00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e5c77f8090a3b96b
dashboard link: https://syzkaller.appspot.com/bug?extid=037e18398ba8c655a652
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16da8cc9a00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+037e18398ba8c655a652@syzkaller.appspotmail.com

kernel tried to execute NX-protected page - exploit attempt? (uid: 0)
BUG: unable to handle page fault for address: ffff88807a92fb10
#PF: supervisor instruction fetch in kernel mode
#PF: error_code(0x0011) - permissions violation
PGD b401067 P4D b401067 PUD 80000000400001e3
Thread overran stack, or stack corrupted
Oops: 0011 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 9205 Comm: syz-executor.0 Not tainted 5.2.0-rc5+ #2
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:0xffff88807a92fb10
Code: ff ff 15 b8 0d 86 ff ff ff ff 00 b5 0d 86 ff ff ff ff 40 8c f0 89 80  
88 ff ff 00 00 00 00 00 00 00 00 a0 a9 1d 8b ff ff ff ff <40> fb 92 7a 80  
88 ff ff 15 b8 0d 86 ff ff ff ff 00 b5 0d 86 ff ff
RSP: 0018:ffff8880ae909e10 EFLAGS: 00010006
RAX: ffff88807a92fb10 RBX: 0000000000000000 RCX: ffffffff816162e2
RDX: 0000000000010000 RSI: ffffffff81615cdf RDI: ffff88807a92fab8
RBP: ffff8880ae909f08 R08: ffff888092914180 R09: ffffed1015d26c70
R10: ffffed1015d26c6f R11: ffff8880ae93637b R12: ffff8880ae926d80
R13: ffffffff8b1da9a0 R14: ffff88807a92fab8 R15: dffffc0000000000
FS:  0000555557401940(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff88807a92fb10 CR3: 000000009016a000 CR4: 00000000001406e0
Call Trace:
  <IRQ>
  hrtimer_interrupt+0x314/0x770 kernel/time/hrtimer.c:1509
  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1041 [inline]
  smp_apic_timer_interrupt+0x111/0x550 arch/x86/kernel/apic/apic.c:1066
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:806
  </IRQ>
Modules linked in:
CR2: ffff88807a92fb10
---[ end trace f7934f1b1fe3f476 ]---
RIP: 0010:0xffff88807a92fb10
Code: ff ff 15 b8 0d 86 ff ff ff ff 00 b5 0d 86 ff ff ff ff 40 8c f0 89 80  
88 ff ff 00 00 00 00 00 00 00 00 a0 a9 1d 8b ff ff ff ff <40> fb 92 7a 80  
88 ff ff 15 b8 0d 86 ff ff ff ff 00 b5 0d 86 ff ff
RSP: 0018:ffff8880ae909e10 EFLAGS: 00010006
RAX: ffff88807a92fb10 RBX: 0000000000000000 RCX: ffffffff816162e2
RDX: 0000000000010000 RSI: ffffffff81615cdf RDI: ffff88807a92fab8
RBP: ffff8880ae909f08 R08: ffff888092914180 R09: ffffed1015d26c70
R10: ffffed1015d26c6f R11: ffff8880ae93637b R12: ffff8880ae926d80
R13: ffffffff8b1da9a0 R14: ffff88807a92fab8 R15: dffffc0000000000
FS:  0000555557401940(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff88807a92fb10 CR3: 000000009016a000 CR4: 00000000001406e0


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
