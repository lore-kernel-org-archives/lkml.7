Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2129C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 18:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D6E020665
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 18:49:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390572AbfIPStO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 14:49:14 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:48849 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730182AbfIPStN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 14:49:13 -0400
Received: by mail-io1-f69.google.com with SMTP id w16so1119649ioc.15
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 11:49:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=BWUhYr5I0gvS0fShhXckcm/OWj5Paob17MJ2Hn7ceY0=;
        b=K2e1ErtuDTP2+2AkCpSaAxJnIcSZ/FUiVSa1uLwUnBIHjfIMs0GaFsSt02rxwnnW37
         Z4xWoGgfEefAjiHQO27PjGM21oVjybjStrtmjjrx9uXv1s2wwaj1msmiItDBoeQkPtPa
         t+jCFFimwWSbyrANCVOmUQ9rw5kBW8147khpP5JDAGWR5ic2L+JTE7712d+OlAeC4SBP
         ZEuMyGT4VlsyvEtXgK2K458l2UjdieaxYhT1hTaMe55LU+1nKHZq4tuzOZh708vFC++A
         Je5drR3FstKpqgSPLomICz7PWwjvrrNJ1fLRtsOc+ewcmRoHsUbGEvDxKilErza92F2h
         tJRg==
X-Gm-Message-State: APjAAAWNPEy8VIbronK2nR06qQcJSHg9RhG2kLxwhngpu0vCnVr3dKc3
        13nO+f/CHVPTt/4DhNXJkwEwmlSL9TgViFzbqSHc/afNS/fT
X-Google-Smtp-Source: APXvYqzrwpCm3kJA+hdMmImrFj68ACD9mAM46xaSDIDY3qjyC6nMnP08/1pttdOsVqlNT4T8pgKOYv3WkxPiQNbBU6CSFaZJKm24
MIME-Version: 1.0
X-Received: by 2002:a02:245:: with SMTP id 66mr1506031jau.30.1568659750909;
 Mon, 16 Sep 2019 11:49:10 -0700 (PDT)
Date:   Mon, 16 Sep 2019 11:49:10 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003a00b70592b00f85@google.com>
Subject: BUG: bad usercopy in ld_usb_read (2)
From:   syzbot <syzbot+4cd8c1b2445d0ffe05f6@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, andreyknvl@google.com, cai@lca.pw,
        info@metux.net, isaacm@codeaurora.org, keescook@chromium.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, william.kucharski@oracle.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    f0df5c1b usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=1681c9c1600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5c6633fa4ed00be5
dashboard link: https://syzkaller.appspot.com/bug?extid=4cd8c1b2445d0ffe05f6
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+4cd8c1b2445d0ffe05f6@syzkaller.appspotmail.com

ldusb 5-1:0.98: Read buffer overflow, 4466454212372071848 bytes dropped
usercopy: Kernel memory exposure attempt detected from process stack  
(offset 0, size 536871625)!
------------[ cut here ]------------
kernel BUG at mm/usercopy.c:98!
invalid opcode: 0000 [#1] SMP KASAN
CPU: 1 PID: 17170 Comm: syz-executor.4 Not tainted 5.3.0-rc7+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:usercopy_abort+0xb9/0xbb mm/usercopy.c:98
Code: e8 62 f0 d6 ff 49 89 d9 4d 89 e8 4c 89 e1 41 56 48 89 ee 48 c7 c7 c0  
f7 cd 85 ff 74 24 08 41 57 48 8b 54 24 20 e8 c6 91 c1 ff <0f> 0b e8 36 f0  
d6 ff e8 a1 90 fd ff 8b 54 24 04 49 89 d8 4c 89 e1
RSP: 0018:ffff8881d308fc40 EFLAGS: 00010282
RAX: 0000000000000060 RBX: ffffffff85cdf4e0 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff81288ddd RDI: ffffed103a611f7a
RBP: ffffffff85cdf6a0 R08: 0000000000000060 R09: fffffbfff11ad7a3
R10: fffffbfff11ad7a2 R11: ffffffff88d6bd17 R12: ffffffff85cdf8c0
R13: ffffffff85cdf4e0 R14: 00000000200002c9 R15: ffffffff85cdf4e0
FS:  00007fc613f93700(0000) GS:ffff8881db300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f983cbbf000 CR3: 00000001cc33e000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  __check_object_size mm/usercopy.c:276 [inline]
  __check_object_size.cold+0x91/0xbb mm/usercopy.c:250
  check_object_size include/linux/thread_info.h:119 [inline]
  check_copy_size include/linux/thread_info.h:150 [inline]
  copy_to_user include/linux/uaccess.h:151 [inline]
  ld_usb_read+0x304/0x780 drivers/usb/misc/ldusb.c:495
  __vfs_read+0x76/0x100 fs/read_write.c:425
  vfs_read+0x1ea/0x430 fs/read_write.c:461
  ksys_read+0x1e8/0x250 fs/read_write.c:587
  do_syscall_64+0xb7/0x580 arch/x86/entry/common.c:296
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4598e9
Code: fd b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fc613f92c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00000000004598e9
RDX: 00000000200002c9 RSI: 0000000020000280 RDI: 0000000000000004
RBP: 000000000075bf20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fc613f936d4
R13: 00000000004c6d1a R14: 00000000004dc0c0 R15: 00000000ffffffff
Modules linked in:
---[ end trace b440da0257bb7015 ]---
RIP: 0010:usercopy_abort+0xb9/0xbb mm/usercopy.c:98
Code: e8 62 f0 d6 ff 49 89 d9 4d 89 e8 4c 89 e1 41 56 48 89 ee 48 c7 c7 c0  
f7 cd 85 ff 74 24 08 41 57 48 8b 54 24 20 e8 c6 91 c1 ff <0f> 0b e8 36 f0  
d6 ff e8 a1 90 fd ff 8b 54 24 04 49 89 d8 4c 89 e1
RSP: 0018:ffff8881d308fc40 EFLAGS: 00010282
RAX: 0000000000000060 RBX: ffffffff85cdf4e0 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff81288ddd RDI: ffffed103a611f7a
RBP: ffffffff85cdf6a0 R08: 0000000000000060 R09: fffffbfff11ad7a3
R10: fffffbfff11ad7a2 R11: ffffffff88d6bd17 R12: ffffffff85cdf8c0
R13: ffffffff85cdf4e0 R14: 00000000200002c9 R15: ffffffff85cdf4e0
FS:  00007fc613f93700(0000) GS:ffff8881db300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f983cbbf000 CR3: 00000001cc33e000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
