Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 390E6C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 03:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16FDF207E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 03:59:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbfFFD7G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 23:59:06 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:48438 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbfFFD7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 23:59:05 -0400
Received: by mail-io1-f70.google.com with SMTP id z19so634034ioi.15
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 20:59:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=+S8g62Dh5ga94HzMhnVEYC1gCeAUzOGCxrkc9unPHgw=;
        b=dMxp0fLAnfZNFSKlRDjx4yZ7fBigk2EQxBTwvq1R0nhWvo/1lyMxv9hMNHblvyiSoK
         Nd3kOOcuq1VgRc86BymvzySIYdmtANdib4eKoA0mV+aMluVpU7/8lbx23YI57/Df+rS0
         q0mp8xw0pBy/2wyxo+9ovkTM9EFAABtC2mRL3mtVE7bWC/KkzlFhYdnF+r10CcXWlDcP
         F6tzr1A3Rc28SQ5ZpdQPOfgVZ7bq+ZjXGH2c3RvRXdYPOBXq11N2oI7xbR9sK5K560d5
         eS+u28abI9J7mZd8KPlM5K4EQ5PPp++kXXJiTDKxTD/nlgQQT+PYx9zoAqMQytlBRj64
         lu3A==
X-Gm-Message-State: APjAAAUH/xGDAHqRCZbDTZmubhe9tINqh7nj3aikY6LSSfmUvc0LwB8D
        XvxuB7rt9g8UufqMo9IZrhKOI96yRIRfJbBIsR1sD8VYBw86
X-Google-Smtp-Source: APXvYqxgMfFulz0xchCtSRx8vNVHuuZKhVmM0Iei9ifgk9wUHSSfoIUYZAOko0N6aVYBS2Q4UtOp7O6opxlAUbT5YCP9XYrkmGMw
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2104:: with SMTP id x4mr887540iox.260.1559793544869;
 Wed, 05 Jun 2019 20:59:04 -0700 (PDT)
Date:   Wed, 05 Jun 2019 20:59:04 -0700
In-Reply-To: <0000000000008ab3c0057e8b747f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002a500c058a9fbcf8@google.com>
Subject: Re: general protection fault in rb_erase (2)
From:   syzbot <syzbot+e8c40862180d8949d624@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    156c0591 Merge tag 'linux-kselftest-5.2-rc4' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15790062a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=60564cb52ab29d5b
dashboard link: https://syzkaller.appspot.com/bug?extid=e8c40862180d8949d624
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11f031fea00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+e8c40862180d8949d624@syzkaller.appspotmail.com

kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 9547 Comm: syz-executor.4 Not tainted 5.2.0-rc3+ #20
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:rb_set_parent_color include/linux/rbtree_augmented.h:119 [inline]
RIP: 0010:____rb_erase_color lib/rbtree.c:363 [inline]
RIP: 0010:rb_erase+0x715/0x1c10 lib/rbtree.c:450
Code: 00 00 4c 89 f1 49 89 44 24 10 48 c1 e9 03 80 3c 19 00 0f 85 77 14 00  
00 48 89 c1 4d 89 e5 4d 89 67 08 48 c1 e9 03 49 83 cd 01 <80> 3c 19 00 0f  
85 63 0f 00 00 4c 89 e1 4c 89 28 48 c1 e9 03 80 3c
RSP: 0018:ffff8880ae809d50 EFLAGS: 00010082
RAX: a252000010b71f27 RBX: dffffc0000000000 RCX: 144a40000216e3e4
RDX: ffffed1015d04db8 RSI: ffff8880ae826dc0 RDI: ffff888079b6fac0
RBP: ffff8880ae809d98 R08: ffff888079b6fac8 R09: ffffed1015d06be0
R10: ffffed1015d06bdf R11: ffff8880ae835efb R12: ffff888079b6fab8
R13: ffff888079b6fab9 R14: ffff8880852c6048 R15: ffff8880852c6040
FS:  00005555563c1940(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000022f2e80 CR3: 000000008d675000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  <IRQ>
  timerqueue_del+0x86/0x150 lib/timerqueue.c:74
  __remove_hrtimer+0xa8/0x1c0 kernel/time/hrtimer.c:975
  __run_hrtimer kernel/time/hrtimer.c:1371 [inline]
  __hrtimer_run_queues+0x2a8/0xdd0 kernel/time/hrtimer.c:1451
  hrtimer_interrupt+0x314/0x770 kernel/time/hrtimer.c:1509
  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1041 [inline]
  smp_apic_timer_interrupt+0x111/0x550 arch/x86/kernel/apic/apic.c:1066
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:806
  </IRQ>
Modules linked in:

======================================================

