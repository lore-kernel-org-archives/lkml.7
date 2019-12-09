Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACAA8C00454
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 19:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6685C206E0
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 19:35:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfLITfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 14:35:10 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:56054 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbfLITfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 14:35:09 -0500
Received: by mail-io1-f71.google.com with SMTP id z21so11423142iob.22
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 11:35:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=E10f5qzd5KyYdQlZXYbO1fJdYSUgZRfua7S1F+8CoFE=;
        b=NSGjh5EzQymDJzniqqAyOhuLv0GCUusZVeGiUDPkyIhCCOepIByWrJFuLhDIEU+mFO
         HavnN9pz1po1i98gysvyZ/qWS6VARxyInyF14M4AmwybiUYq/eE9pscLyHD4X6LHJg4S
         nAPkeRq41MMJRBpXi4YKRpokcDjBwc8WL7Md3muJojWwWbNdk3zGXqeI9gQvawq6Y9jd
         BZfvmYx1cWzUuaqgcLC+A18/maZeLPRvVKIMoRNgtDZ6IWh0fIq/iDHA+vZNbbMXyfzW
         JudaK5caaHAX8mfU/fJ39GXMXtWrXPqiDDb9b9mwLqCXqvSjbHXespjkOdkKLxploLkJ
         9Y1A==
X-Gm-Message-State: APjAAAX724CcRLh5EUnCZBmgN9tIP93DKww6FVW6y7Rcj8AXC7UhIUB7
        H1fpVTMtZFTP27dF6A74bdvQudyUYU2izuf/+WyAcUGssM9G
X-Google-Smtp-Source: APXvYqxNYJHGiYdka47X23jHa0Gk72PNQafSYRuj7NfhwdlepjdJRWslX6GV+x7FFZQjeayn1HLNKsJLo7iKw55HwRyPngMqPbmr
MIME-Version: 1.0
X-Received: by 2002:a05:6638:c9:: with SMTP id w9mr28058415jao.30.1575920108608;
 Mon, 09 Dec 2019 11:35:08 -0800 (PST)
Date:   Mon, 09 Dec 2019 11:35:08 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000044a65205994a7e13@google.com>
Subject: BUG: unable to handle kernel NULL pointer dereference in mem16_serial_out
From:   syzbot <syzbot+92f32d4e21fb246d31a2@syzkaller.appspotmail.com>
To:     andriy.shevchenko@linux.intel.com, asierra@xes-inc.com,
        ext-kimmo.rautkoski@vaisala.com, gregkh@linuxfoundation.org,
        jslaby@suse.com, kai.heng.feng@canonical.com,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        mika.westerberg@linux.intel.com, paulburton@kernel.org, sr@denx.de,
        syzkaller-bugs@googlegroups.com, yegorslists@googlemail.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    e42617b8 Linux 5.5-rc1
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1157cd41e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3754e2c78c1adb82
dashboard link: https://syzkaller.appspot.com/bug?extid=92f32d4e21fb246d31a2
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=136f7e41e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=112b7c82e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+92f32d4e21fb246d31a2@syzkaller.appspotmail.com

BUG: kernel NULL pointer dereference, address: 0000000000000003
#PF: supervisor write access in kernel mode
#PF: error_code(0x0002) - not-present page
PGD a9a61067 P4D a9a61067 PUD 8fa24067 PMD 0
Oops: 0002 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 9054 Comm: syz-executor150 Not tainted 5.5.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:writew arch/x86/include/asm/io.h:66 [inline]
RIP: 0010:mem16_serial_out+0x6c/0x90 drivers/tty/serial/8250/8250_port.c:414
Code: b6 8d e9 00 00 00 49 8d 7d 40 48 b8 00 00 00 00 00 fc ff df 48 89 fa  
48 c1 ea 03 d3 e3 80 3c 02 00 75 19 48 63 db 49 03 5d 40 <66> 44 89 23 5b  
41 5c 41 5d 5d c3 e8 d4 44 cf fd eb c2 e8 2d 45 cf
RSP: 0018:ffffc90001cf7908 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: 0000000000000003 RCX: 0000000000000000
RDX: 1ffffffff182080e RSI: ffffffff83e38106 RDI: ffffffff8c104070
RBP: ffffc90001cf7920 R08: ffff88808ffac040 R09: ffffed10431421c6
R10: ffffed10431421c5 R11: ffff888218a10e2b R12: 00000000000000bf
R13: ffffffff8c104030 R14: ffffc90001cf7a40 R15: ffffffff8c104188
FS:  0000000000866880(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000003 CR3: 00000000a64a2000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  serial_port_out include/linux/serial_core.h:265 [inline]
  serial8250_do_startup+0x12b9/0x1cf0  
drivers/tty/serial/8250/8250_port.c:2077
  serial8250_startup+0x62/0x80 drivers/tty/serial/8250/8250_port.c:2329
  uart_port_startup drivers/tty/serial/serial_core.c:219 [inline]
  uart_startup drivers/tty/serial/serial_core.c:258 [inline]
  uart_startup+0x452/0x980 drivers/tty/serial/serial_core.c:249
  uart_set_info drivers/tty/serial/serial_core.c:998 [inline]
  uart_set_info_user+0x13b4/0x1cf0 drivers/tty/serial/serial_core.c:1023
  tty_tiocsserial drivers/tty/tty_io.c:2506 [inline]
  tty_ioctl+0xf60/0x14f0 drivers/tty/tty_io.c:2648
  vfs_ioctl fs/ioctl.c:47 [inline]
  file_ioctl fs/ioctl.c:545 [inline]
  do_vfs_ioctl+0x977/0x14e0 fs/ioctl.c:732
  ksys_ioctl+0xab/0xd0 fs/ioctl.c:749
  __do_sys_ioctl fs/ioctl.c:756 [inline]
  __se_sys_ioctl fs/ioctl.c:754 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:754
  do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x440219
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 fb 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffc99622388 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 0000000000440219
RDX: 0000000020000240 RSI: 000000000000541f RDI: 0000000000000003
RBP: 00000000006ca018 R08: 0000000000000000 R09: 00000000004002c8
R10: 0000000000401b30 R11: 0000000000000246 R12: 0000000000401aa0
R13: 0000000000401b30 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
CR2: 0000000000000003
---[ end trace 2e0575eb0019173e ]---
RIP: 0010:writew arch/x86/include/asm/io.h:66 [inline]
RIP: 0010:mem16_serial_out+0x6c/0x90 drivers/tty/serial/8250/8250_port.c:414
Code: b6 8d e9 00 00 00 49 8d 7d 40 48 b8 00 00 00 00 00 fc ff df 48 89 fa  
48 c1 ea 03 d3 e3 80 3c 02 00 75 19 48 63 db 49 03 5d 40 <66> 44 89 23 5b  
41 5c 41 5d 5d c3 e8 d4 44 cf fd eb c2 e8 2d 45 cf
RSP: 0018:ffffc90001cf7908 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: 0000000000000003 RCX: 0000000000000000
RDX: 1ffffffff182080e RSI: ffffffff83e38106 RDI: ffffffff8c104070
RBP: ffffc90001cf7920 R08: ffff88808ffac040 R09: ffffed10431421c6
R10: ffffed10431421c5 R11: ffff888218a10e2b R12: 00000000000000bf
R13: ffffffff8c104030 R14: ffffc90001cf7a40 R15: ffffffff8c104188
FS:  0000000000866880(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000003 CR3: 00000000a64a2000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
