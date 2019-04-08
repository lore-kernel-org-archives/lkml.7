Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7495EC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 11:34:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F8822070D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 11:34:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbfDHLeH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 07:34:07 -0400
Received: from mail-it1-f199.google.com ([209.85.166.199]:43718 "EHLO
        mail-it1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbfDHLeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 07:34:06 -0400
Received: by mail-it1-f199.google.com with SMTP id m192so12306368ita.8
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 04:34:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=4FHDGWhg5RwCK9ZwuEezLemDJHvTfXR6zS4859cRb7Q=;
        b=sb1Xnn/P//pK/hAzlAxYR1RNtGKoF4ZitWDoJKvMCHJNmPUu1PlzQoYR9Spo01b9KT
         Qtwk7C9bfWV1dEjht6dhAanapAwO3vgJFA8BUokO04nRQDqBoyX+zqSe3J3r3Tnb7YE9
         kB2SZxk1DtlddCj1yRZ1wUk32vD/Fs4hW/6H3z0e3Er06Rh3IagwXk+7cjb0e7LpOtAO
         FSo2BXWIGuPaZ5rp22CZCV599lC8TYqD8RCLpblSHTGSbV70Tcd71Gfjfcyc51nRUhp3
         pb5HB3/aas3hLg+t150sgCPSZH4AO02YW5te0HexDBEQfhkNz2X8Zicb3V0ayQ+VzKpC
         kSAA==
X-Gm-Message-State: APjAAAVlC97V3GepLa/cuj7N7XC+2eB6mMJPYGi8h7hS4//r+iNLx3y7
        9NXU1eu/ufoqQJjapz67BJ02HjiUYpFhI04nw4H5juDRNEqe
X-Google-Smtp-Source: APXvYqwHh+oNvB6q2L/gE/XHd4zC81wUNc2Yz+k/AENyPS9uc1BM4P7+rmmu4E5w0ayCUKBzqMlj+z4tEy6vXT7puA9qz7xJeOl0
MIME-Version: 1.0
X-Received: by 2002:a24:3d8c:: with SMTP id n134mr4374074itn.14.1554723245480;
 Mon, 08 Apr 2019 04:34:05 -0700 (PDT)
Date:   Mon, 08 Apr 2019 04:34:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c56c2305860336fd@google.com>
Subject: general protection fault in d_alloc_pseudo
From:   syzbot <syzbot+57dc50baaee299931092@syzkaller.appspotmail.com>
To:     adilger@dilger.ca, amir73il@gmail.com, corbet@lwn.net,
        darrick.wong@oracle.com, david@fromorbit.com,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, longman@redhat.com,
        mszeredi@redhat.com, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    ac5b84a1 Add linux-next specific files for 20190408
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=155bbd9b200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=42a33a21877c9c95
dashboard link: https://syzkaller.appspot.com/bug?extid=57dc50baaee299931092
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=121029c3200000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13aa44fd200000

The bug was bisected to:

commit 56deac897903018e2672de8b784749f948e44be1
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Sat Mar 16 02:23:19 2019 +0000

     dcache: sort the freeing-without-RCU-delay mess for good.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1550bda7200000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=1750bda7200000
console output: https://syzkaller.appspot.com/x/log.txt?x=1350bda7200000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+57dc50baaee299931092@syzkaller.appspotmail.com
Fixes: 56deac897903 ("dcache: sort the freeing-without-RCU-delay mess for  
good.")

kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 7543 Comm: syz-executor982 Not tainted 5.1.0-rc3-next-20190408  
#20
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:d_alloc_pseudo+0x33/0x70 fs/dcache.c:1752
Code: 41 54 49 89 fc 48 83 ec 08 e8 39 d9 b7 ff 4c 89 ee 4c 89 e7 e8 1e f1  
ff ff 48 ba 00 00 00 00 00 fc ff df 48 89 c1 48 c1 e9 03 <0f> b6 14 11 84  
d2 74 05 80 fa 03 7e 10 81 08 00 00 00 40 48 83 c4
RSP: 0018:ffff88808e77fd28 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 1ffff11011ceffad RCX: 0000000000000000
RDX: dffffc0000000000 RSI: ffffffff81b8a01f RDI: 0000000000000282
RBP: ffff88808e77fd40 R08: ffff8880913c2380 R09: ffffed1015d25bc8
R10: ffffed1015d25bc7 R11: ffff8880ae92de3b R12: ffff88821b742cc0
R13: ffff88808e77fd88 R14: ffff88821b6a0628 R15: ffff888095d1f0f0
FS:  000000000195e880(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000004b6058 CR3: 000000008dafa000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  alloc_file_pseudo+0xe2/0x280 fs/file_table.c:224
  sock_alloc_file+0x4d/0x170 net/socket.c:406
  sock_map_fd net/socket.c:429 [inline]
  __sys_socket+0x150/0x220 net/socket.c:1495
  __do_sys_socket net/socket.c:1500 [inline]
  __se_sys_socket net/socket.c:1498 [inline]
  __x64_sys_socket+0x73/0xb0 net/socket.c:1498
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4412e9
Code: e8 ac e8 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 0b 0a fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffdb62abef8 EFLAGS: 00000246 ORIG_RAX: 0000000000000029
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00000000004412e9
RDX: 0000000000000073 RSI: 0000000000000002 RDI: 0000000000000002
RBP: 00000000006cc018 R08: 0000000000000001 R09: 00000000004002c8
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000402180
R13: 0000000000402210 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
---[ end trace 8205b4b5db42318a ]---
RIP: 0010:d_alloc_pseudo+0x33/0x70 fs/dcache.c:1752
Code: 41 54 49 89 fc 48 83 ec 08 e8 39 d9 b7 ff 4c 89 ee 4c 89 e7 e8 1e f1  
ff ff 48 ba 00 00 00 00 00 fc ff df 48 89 c1 48 c1 e9 03 <0f> b6 14 11 84  
d2 74 05 80 fa 03 7e 10 81 08 00 00 00 40 48 83 c4
RSP: 0018:ffff88808e77fd28 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 1ffff11011ceffad RCX: 0000000000000000
RDX: dffffc0000000000 RSI: ffffffff81b8a01f RDI: 0000000000000282
RBP: ffff88808e77fd40 R08: ffff8880913c2380 R09: ffffed1015d25bc8
R10: ffffed1015d25bc7 R11: ffff8880ae92de3b R12: ffff88821b742cc0
R13: ffff88808e77fd88 R14: ffff88821b6a0628 R15: ffff888095d1f0f0
FS:  000000000195e880(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000004b6058 CR3: 000000008dafa000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
