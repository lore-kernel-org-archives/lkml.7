Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B2BEC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 12:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EEB52084E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 12:57:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbfFUM5K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 08:57:10 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:48480 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbfFUM5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 08:57:09 -0400
Received: by mail-io1-f69.google.com with SMTP id z19so10600088ioi.15
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 05:57:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=78tsIkS+lSlJ2Qg9EpWFnHiL10KOQKlqa3jVgJ57mtQ=;
        b=gbuXE26oAKb/jtrS9YeRGGmOpa5vuJfWjC6p2tA+SA63reAy3mpKX60Kh+v9BBE851
         3rb5uAOIk8I/LCj2J6HGeeUwBvTT05yGsPx9MnCg5mt1J/g7mH6CzWfAvPHx+ce6tx0y
         Hkh82HBzv2TQhEZ4VeCaRUYZ2ITz4TFEoGVdQHdBoNH64ZjPTYLAzlvQ9jtaUfaVmyHf
         pUvJ9f0nsNLXXjUVoy8Hlh9P6K05vt9jc8CyjjPq1AsOCI+mFAVaWWOhph8pJ15pZfuO
         eIjVMRRvvdJ/3Ga+K1xguKOwgoAS/yi24UCaeYwdwI+8tWYmj3Vu6Y0QtaAOzMsXKKFx
         rjVw==
X-Gm-Message-State: APjAAAU4FuPgQH+qfokhvoisz5b5768r0pws4aAub9kVNz07XvjY3YhI
        4wjjlLMe5BcHf4+w1U1bYBEM9opqzZ1VcMsOMcj3DgT98lnM
X-Google-Smtp-Source: APXvYqzoY34g/RAfwBy624pHE+aWyayxBonvBmNr10muWigm7v+WgW6nhfDp8GzIsUBQy7P5bBt3DYuV8wT0FuwtL3cTyMHdY83/
MIME-Version: 1.0
X-Received: by 2002:a6b:bf01:: with SMTP id p1mr3310137iof.181.1561121828652;
 Fri, 21 Jun 2019 05:57:08 -0700 (PDT)
Date:   Fri, 21 Jun 2019 05:57:08 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000c4e3e058bd5008d@google.com>
Subject: KASAN: use-after-free Write in validate_chain
From:   syzbot <syzbot+55c548ad445cef6063ab@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    abf02e29 Merge tag 'pm-5.2-rc6' of git://git.kernel.org/pu..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=128b8be6a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=28ec3437a5394ee0
dashboard link: https://syzkaller.appspot.com/bug?extid=55c548ad445cef6063ab
compiler:       clang version 9.0.0 (/home/glider/llvm/clang  
80fee25776c2fb61e74c1ecb1a523375c2500b69)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=128ce13aa00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+55c548ad445cef6063ab@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in check_prev_add kernel/locking/lockdep.c:2298  
[inline]
BUG: KASAN: use-after-free in check_prevs_add kernel/locking/lockdep.c:2418  
[inline]
BUG: KASAN: use-after-free in validate_chain+0x1a35/0x84f0  
kernel/locking/lockdep.c:2800
Write of size 8 at addr ffff8880972652b0 by task syz-executor.3/9443

CPU: 1 PID: 9443 Comm: syz-executor.3 Not tainted 5.2.0-rc5+ #4
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:

Allocated by task 1172321806:
(stack is not available)

Freed by task 2287698508:
------------[ cut here ]------------
kernel BUG at mm/slab.c:4178!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 9443 Comm: syz-executor.3 Not tainted 5.2.0-rc5+ #4
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:__check_heap_object+0xcb/0xd0 mm/slab.c:4202
Code: 4c 89 d1 4d 89 c8 e8 44 4d 07 00 5b 41 5e 5d c3 49 8b 73 58 41 0f b6  
d0 48 c7 c7 15 78 5d 88 4c 89 d1 4d 89 c8 e8 e5 4d 07 00 <0f> 0b 0f 1f 00  
55 48 89 e5 41 56 53 48 83 ff 10 74 4a 48 89 fb 48
RSP: 0018:ffff8880972638b0 EFLAGS: 00010046
RAX: 0000000000000fa9 RBX: 00000000000011c0 RCX: 000000000000000c
RDX: 000000000000000c RSI: 0000000000000002 RDI: 0000000000000001
RBP: ffff8880972638c0 R08: 0000000000000000 R09: ffffffff81b5ce7a
R10: ffff8880972639c0 R11: ffff8880aa58f940 R12: ffff8880972639c2
R13: 0000000000000200 R14: ffff888097262800 R15: ffff8880972639c0
FS:  0000555556169940(0000) GS:ffff8880aeb00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffff8adea628 CR3: 00000000a5dc4000 CR4: 00000000001406e0
Call Trace:
Modules linked in:
---[ end trace 8685358c22a34005 ]---
RIP: 0010:__check_heap_object+0xcb/0xd0 mm/slab.c:4202
Code: 4c 89 d1 4d 89 c8 e8 44 4d 07 00 5b 41 5e 5d c3 49 8b 73 58 41 0f b6  
d0 48 c7 c7 15 78 5d 88 4c 89 d1 4d 89 c8 e8 e5 4d 07 00 <0f> 0b 0f 1f 00  
55 48 89 e5 41 56 53 48 83 ff 10 74 4a 48 89 fb 48
RSP: 0018:ffff8880972638b0 EFLAGS: 00010046
RAX: 0000000000000fa9 RBX: 00000000000011c0 RCX: 000000000000000c
RDX: 000000000000000c RSI: 0000000000000002 RDI: 0000000000000001
RBP: ffff8880972638c0 R08: 0000000000000000 R09: ffffffff81b5ce7a
R10: ffff8880972639c0 R11: ffff8880aa58f940 R12: ffff8880972639c2
R13: 0000000000000200 R14: ffff888097262800 R15: ffff8880972639c0
FS:  0000555556169940(0000) GS:ffff8880aeb00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffff8adea628 CR3: 00000000a5dc4000 CR4: 00000000001406e0


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
