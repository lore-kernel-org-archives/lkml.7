Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16EACC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 17:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE4A020851
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 17:59:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbfCHR7H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 12:59:07 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:35717 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727016AbfCHR7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 12:59:06 -0500
Received: by mail-io1-f70.google.com with SMTP id s9so16078592ioj.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 09:59:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=akIbWxugt/bxGxCb+VSxkCYQ054e8TlMOmMbTTBccgY=;
        b=e3F+2LTWvNFpibh18wA2GYw4RxmucLRpxst/Gquh7LV7hNpyIZsh0E5y1hcj0M80f/
         e2YeysatF1DZo1efUVTa0oBtyVxiRhoMyWVIPGk9++osEdC+Y8dJ+6icWa6uLCdbGVmq
         C2xmb16GcI6bff01HpGy7YLl0JRQirAhaw7j2ZlGVd1OPduUYKWqAtIUf+KapAK2Bk7h
         GJh7GJSB45Na4cdv65TAA3TaIfO2Df3F3LxBRXjApYjj5tv5PPPYFVVC8cgIEoYXpq/e
         i4W4LiAtpSermrEWRcxy8DqucGpeBbH0Zwmxh9LVzH52Ss1I19EFgTamRoU+ePjydLWI
         sqYg==
X-Gm-Message-State: APjAAAUVvrC7suk66WLo8+aJrrq8H/eB64lRvTFzQktHcTKKG2WbUnZu
        sQpohJvTekQyU9gXj7mDUEBF2/hf9Qi49Q9SlfHCF2y9CYPb
X-Google-Smtp-Source: APXvYqz9BLEWYQ07xEGez/Nf8YUyvv+FV+M2KBZqXzsxCnBPJIbxCinRs0rFJv3jzSAH9ajAMnGWt2SOGw4BkBjTdBJPRbKQU+gJ
MIME-Version: 1.0
X-Received: by 2002:a24:4d8e:: with SMTP id l136mr13173466itb.5.1552067945222;
 Fri, 08 Mar 2019 09:59:05 -0800 (PST)
Date:   Fri, 08 Mar 2019 09:59:05 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008adf52058398fa93@google.com>
Subject: kernel BUG at arch/x86/kvm/x86.c:LINE! (3)
From:   syzbot <syzbot+83a3e122f8c1b25b3111@syzkaller.appspotmail.com>
To:     bp@alien8.de, hpa@zytor.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        pbonzini@redhat.com, rkrcmar@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    cf08baa2 Add linux-next specific files for 20190306
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12f3819d200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c8b6073d992e8217
dashboard link: https://syzkaller.appspot.com/bug?extid=83a3e122f8c1b25b3111
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
userspace arch: amd64

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+83a3e122f8c1b25b3111@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at arch/x86/kvm/x86.c:357!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 2530 Comm: kworker/u4:4 Not tainted 5.0.0-next-20190306 #4
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: bat_events batadv_nc_worker
RIP: 0010:kvm_spurious_fault+0x9/0x10 arch/x86/kvm/x86.c:357
Code: e8 bc 7d 66 00 41 bd 03 00 00 00 5b 44 89 e8 41 5c 41 5d 5d c3 66 90  
66 2e 0f 1f 84 00 00 00 00 00 55 48 89 e5 e8 97 7d 66 00 <0f> 0b 0f 1f 44  
00 00 55 48 89 e5 41 57 41 56 49 89 d6 41 55 41 54
RSP: 0018:ffff8880ae907e80 EFLAGS: 00010006
RAX: ffff8880a1650200 RBX: ffff888053363f68 RCX: ffffffff8132bc7a
RDX: 0000000000010000 RSI: ffffffff810a1699 RDI: 0000000000000007
RBP: ffff8880ae907e80 R08: ffff8880a1650200 R09: ffffed1015d25be9
R10: ffffed1015d25be8 R11: ffff8880ae92df47 R12: 1ffff11015d20fd3
R13: ffff888098456000 R14: ffff8880ae907ef8 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff8880ae907eb8 CR3: 000000005bdae000 CR4: 00000000001426e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  <IRQ>
  vmcs_clear arch/x86/kvm/vmx/ops.h:185 [inline]
  loaded_vmcs_init+0x95/0x250 arch/x86/kvm/vmx/vmx.c:570
  __loaded_vmcs_clear+0x229/0x360 arch/x86/kvm/vmx/vmx.c:637
  flush_smp_call_function_queue+0x14a/0x500 kernel/smp.c:243
  generic_smp_call_function_single_interrupt+0x13/0x2b kernel/smp.c:192
  smp_call_function_single_interrupt+0xa3/0x460 arch/x86/kernel/smp.c:296
  call_function_single_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:829
  </IRQ>
RIP: 0010:arch_local_irq_restore arch/x86/include/asm/paravirt.h:767  
[inline]
RIP: 0010:lock_acquire+0x1ea/0x3f0 kernel/locking/lockdep.c:4205
Code: 7c 08 00 00 00 00 00 00 48 c1 e8 03 80 3c 10 00 0f 85 c7 01 00 00 48  
83 3d d2 fa 3a 07 00 0f 84 3b 01 00 00 48 8b 7d c8 57 9d <0f> 1f 44 00 00  
48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f 5d c3 65 8b
RSP: 0018:ffff8880a165fc80 EFLAGS: 00000286 ORIG_RAX: ffffffffffffff04
RAX: 1ffffffff11252b6 RBX: ffff8880a1650200 RCX: 0000000000000000
RDX: dffffc0000000000 RSI: 0000000000000001 RDI: 0000000000000286
RBP: ffff8880a165fcc8 R08: 0000000069c38c2d R09: ffffffff895e57b4
R10: ffff8880a1650ad0 R11: ffff8880a1650200 R12: ffffffff889a5b00
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000002
  rcu_lock_acquire include/linux/rcupdate.h:210 [inline]
  rcu_read_lock include/linux/rcupdate.h:595 [inline]
  batadv_nc_purge_orig_hash net/batman-adv/network-coding.c:419 [inline]
  batadv_nc_worker+0x117/0x760 net/batman-adv/network-coding.c:730
  process_one_work+0x98e/0x1790 kernel/workqueue.c:2269
  worker_thread+0x98/0xe40 kernel/workqueue.c:2415
  kthread+0x357/0x430 kernel/kthread.c:253
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
Modules linked in:
---[ end trace 909e627acbdd0177 ]---
RIP: 0010:kvm_spurious_fault+0x9/0x10 arch/x86/kvm/x86.c:357
Code: e8 bc 7d 66 00 41 bd 03 00 00 00 5b 44 89 e8 41 5c 41 5d 5d c3 66 90  
66 2e 0f 1f 84 00 00 00 00 00 55 48 89 e5 e8 97 7d 66 00 <0f> 0b 0f 1f 44  
00 00 55 48 89 e5 41 57 41 56 49 89 d6 41 55 41 54
RSP: 0018:ffff8880ae907e80 EFLAGS: 00010006
RAX: ffff8880a1650200 RBX: ffff888053363f68 RCX: ffffffff8132bc7a
RDX: 0000000000010000 RSI: ffffffff810a1699 RDI: 0000000000000007
RBP: ffff8880ae907e80 R08: ffff8880a1650200 R09: ffffed1015d25be9
R10: ffffed1015d25be8 R11: ffff8880ae92df47 R12: 1ffff11015d20fd3
R13: ffff888098456000 R14: ffff8880ae907ef8 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff8880ae907eb8 CR3: 000000005bdae000 CR4: 00000000001426e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
