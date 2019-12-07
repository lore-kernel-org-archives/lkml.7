Return-Path: <SRS0=Iet2=Z5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB283C2D0BE
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 06:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1FA82173E
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 06:25:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbfLGGZK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Dec 2019 01:25:10 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:54835 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbfLGGZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Dec 2019 01:25:09 -0500
Received: by mail-io1-f70.google.com with SMTP id h10so4918638iov.21
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 22:25:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=j9m3lrvCXCpzSxM+tW4QOf6zVSZBLzxbD4R9FIlfwe8=;
        b=Vzxsu+UGSFLOx1UwJA+fOum6ypYh2I/g0C0Eb838ELyZ6hPcT2k2c7VOvGhea9WVc0
         5m/nME3jtaW+65Fjx9n1KWraUNIk1foSKZCUm2Ds6Qg1ZXSJjchKxfPGU1n9HC1Zdsj7
         Ef7iSym/0t3kWjpjLbbyd4hsCgdY9YhHiWGryfMyKWf1aMG8TNRTDHa+EhHmDDbZiEX7
         4qp45p8VvL/GdxDyX5MJ8yoNl46QnzunbojKG4o0izjQdsyKq0GgB03maPIoefZysciz
         4tYaDMso01IwR5tSMvgC0Oo5RBZvIKbGixcEhf35UZY69rMYvyHvMNc5yUkMF7pv8Dgt
         nENQ==
X-Gm-Message-State: APjAAAVlgALUXN1I+33uOHDaQndvqn9fnWKmBFIEtW5RqslQBm1KfDru
        xTxvNhQONbu+K7/YtQP1SVdiSaA5B4UWN8OJGjauN+OMfKpn
X-Google-Smtp-Source: APXvYqzcbP1i5iXtWa0x3COTXPqct38u54GHio/056rYZdiiYwd85nUttqGVNSnG+wxuaygr4c8dTn2O91+AImlAt7jLwipkZ4GK
MIME-Version: 1.0
X-Received: by 2002:a05:6638:a2c:: with SMTP id 12mr17810458jao.60.1575699908609;
 Fri, 06 Dec 2019 22:25:08 -0800 (PST)
Date:   Fri, 06 Dec 2019 22:25:08 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000053539a0599173973@google.com>
Subject: BUG: unable to handle kernel NULL pointer dereference in mem_serial_out
From:   syzbot <syzbot+f4f1e871965064ae689e@syzkaller.appspotmail.com>
To:     andriy.shevchenko@linux.intel.com, asierra@xes-inc.com,
        ext-kimmo.rautkoski@vaisala.com, gregkh@linuxfoundation.org,
        jslaby@suse.com, kai.heng.feng@canonical.com,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        mika.westerberg@linux.intel.com, o.barta89@gmail.com,
        paulburton@kernel.org, sr@denx.de, syzkaller-bugs@googlegroups.com,
        yegorslists@googlemail.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    7ada90eb Merge tag 'drm-next-2019-12-06' of git://anongit...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=123ec282e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f07a23020fd7d21a
dashboard link: https://syzkaller.appspot.com/bug?extid=f4f1e871965064ae689e
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17ab090ee00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17f127f2e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+f4f1e871965064ae689e@syzkaller.appspotmail.com

BUG: kernel NULL pointer dereference, address: 0000000000000002
#PF: supervisor write access in kernel mode
#PF: error_code(0x0002) - not-present page
PGD 9764a067 P4D 9764a067 PUD 9f995067 PMD 0
Oops: 0002 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 9687 Comm: syz-executor433 Not tainted 5.4.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:writeb arch/x86/include/asm/io.h:65 [inline]
RIP: 0010:mem_serial_out+0x70/0x90 drivers/tty/serial/8250/8250_port.c:408
Code: e9 00 00 00 49 8d 7c 24 40 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48  
c1 ea 03 d3 e3 80 3c 02 00 75 19 48 63 db 49 03 5c 24 40 <44> 88 2b 5b 41  
5c 41 5d 5d c3 e8 81 ed cf fd eb c0 e8 da ed cf fd
RSP: 0018:ffffc90001de78e8 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 0000000000000002 RCX: 0000000000000000
RDX: 1ffffffff181f40e RSI: ffffffff83e28776 RDI: ffffffff8c0fa070
RBP: ffffc90001de7900 R08: ffff8880919dc340 R09: ffffed10431ee1c6
R10: ffffed10431ee1c5 R11: ffff888218f70e2b R12: ffffffff8c0fa030
R13: 0000000000000001 R14: ffffc90001de7a40 R15: ffffffff8c0fa188
FS:  0000000001060880(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000002 CR3: 000000009e6b8000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  serial_out drivers/tty/serial/8250/8250.h:118 [inline]
  serial8250_clear_fifos.part.0+0x3a/0xb0  
drivers/tty/serial/8250/8250_port.c:557
  serial8250_clear_fifos drivers/tty/serial/8250/8250_port.c:556 [inline]
  serial8250_do_startup+0x426/0x1cf0 drivers/tty/serial/8250/8250_port.c:2121
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
RSP: 002b:00007ffced648c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 0000000000440219
RDX: 0000000020000240 RSI: 000000000000541f RDI: 0000000000000003
RBP: 00000000006ca018 R08: 0000000000000000 R09: 00000000004002c8
R10: 0000000000401b30 R11: 0000000000000246 R12: 0000000000401aa0
R13: 0000000000401b30 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
CR2: 0000000000000002
---[ end trace eaa11ffe82f3a763 ]---
RIP: 0010:writeb arch/x86/include/asm/io.h:65 [inline]
RIP: 0010:mem_serial_out+0x70/0x90 drivers/tty/serial/8250/8250_port.c:408
Code: e9 00 00 00 49 8d 7c 24 40 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48  
c1 ea 03 d3 e3 80 3c 02 00 75 19 48 63 db 49 03 5c 24 40 <44> 88 2b 5b 41  
5c 41 5d 5d c3 e8 81 ed cf fd eb c0 e8 da ed cf fd
RSP: 0018:ffffc90001de78e8 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 0000000000000002 RCX: 0000000000000000
RDX: 1ffffffff181f40e RSI: ffffffff83e28776 RDI: ffffffff8c0fa070
RBP: ffffc90001de7900 R08: ffff8880919dc340 R09: ffffed10431ee1c6
R10: ffffed10431ee1c5 R11: ffff888218f70e2b R12: ffffffff8c0fa030
R13: 0000000000000001 R14: ffffc90001de7a40 R15: ffffffff8c0fa188
FS:  0000000001060880(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000002 CR3: 000000009e6b8000 CR4: 00000000001406f0
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
