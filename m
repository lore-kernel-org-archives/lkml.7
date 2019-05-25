Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_DIGITS,
	FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ADA3C282E5
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 17:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 064EA20863
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 17:38:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbfEYRiW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 13:38:22 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:56418 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbfEYRiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 13:38:06 -0400
Received: by mail-io1-f70.google.com with SMTP id n24so10070686ioo.23
        for <linux-kernel@vger.kernel.org>; Sat, 25 May 2019 10:38:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=daCvjD3J7wMyiJrWqqsu0uiaOYAVZbEq3QSXAOr1WXw=;
        b=N6rnZF5HBd6xjMX6maLenF9wSRESgnLg5uZPZURH6AaQIvAle9ixt2W8usyhqbWT1/
         VjWWLvVLVUl4q1jrndaRiN7ssaajCWxpPH3a+tYPCaCf5VVijYjgXHAIHusztdFG6hVM
         LsGufmatRwnObFqYd2TLHzI84umADUdoR/cLfzmaZ/npwCKr3g4/F8tCmw6Vw7irEBuh
         O/DgmPCYXhUUqX6OQ2uaDp6UJigb1jVDleBkZx9PSy75ZZnhHaekuuMHqy/DgWcmNzSq
         S2EWsqMv/heBG07QrYNq4ZjSc54whE13YKuX6DuvuDQBRBlVwvPOrAAjEMhqhCVIoc/Y
         IJlQ==
X-Gm-Message-State: APjAAAWwPVk775ksLZYRjqgzM/u48SB7rKDuC8AQscsKodz8W4+IHEhW
        e3eUU8mo4tpxTKPEOYSzwaJ/yt0/suQBGhs+u9IZasapvDEF
X-Google-Smtp-Source: APXvYqzq6J2zKPiYBmhNgYgxVXGNgSLl9jCqWbQ4eJlvEEIoaaVoiii7pTHvpU8vtGOm/EI7tUcV7dliZUXxXdazaYTJd+9DF8nn
MIME-Version: 1.0
X-Received: by 2002:a05:660c:7cd:: with SMTP id e13mr21734037itl.40.1558805885654;
 Sat, 25 May 2019 10:38:05 -0700 (PDT)
Date:   Sat, 25 May 2019 10:38:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000016cb560589b9c7c4@google.com>
Subject: KASAN: slab-out-of-bounds Read in class_equal
From:   syzbot <syzbot+3d04999521633dceb439@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    af5136f9 selftests/net: SO_TXTIME with ETF and FQ
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13164ee4a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fc045131472947d7
dashboard link: https://syzkaller.appspot.com/bug?extid=3d04999521633dceb439
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1661b6e4a00000

Bisection is inconclusive: the first bad commit could be any of:

7c00e8ae Merge tag 'armsoc-soc' of  
git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc
a2b7ab45 Merge tag 'linux-watchdog-4.18-rc1' of  
git://www.linux-watchdog.org/linux-watchdog
721afaa2 Merge tag 'armsoc-dt' of  
git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1062daaaa00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+3d04999521633dceb439@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in class_equal+0x40/0x50  
kernel/locking/lockdep.c:1527
Read of size 8 at addr ffff8880813cdab0 by task syz-executor.0/9147

CPU: 0 PID: 9147 Comm: syz-executor.0 Not tainted 5.2.0-rc1+ #6
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:

Allocated by task 2266519551:
------------[ cut here ]------------
kernel BUG at mm/slab.c:4178!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 9147 Comm: syz-executor.0 Not tainted 5.2.0-rc1+ #6
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:__check_heap_object+0xa5/0xb3 mm/slab.c:4178
Code: 2b 48 c7 c7 4d fc 61 88 e8 28 ad 07 00 5d c3 41 8b 91 04 01 00 00 48  
29 c7 48 39 d7 77 bd 48 01 d0 48 29 c8 4c 39 c0 72 b2 c3 <0f> 0b 48 c7 c7  
4d fc 61 88 e8 3c b2 07 00 44 89 e1 48 c7 c7 08 fd
RSP: 0018:ffff8880813cd370 EFLAGS: 00010046
RAX: 0000000000000001 RBX: 0000000000000001 RCX: 000000000000000c
RDX: ffff8880813cc340 RSI: 0000000000000000 RDI: ffff8880813cd468
RBP: ffff8880813cd3c0 R08: 0000000000000001 R09: ffff8880aa594c40
R10: 0000000000000f23 R11: 0000000000000000 R12: ffff8880813cd468
R13: ffffea000204f300 R14: ffff8880813cd469 R15: 0000000000000001
FS:  00005555564e1940(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffff8c046bd8 CR3: 000000009a952000 CR4: 00000000001406f0
Call Trace:
Modules linked in:
---[ end trace e78aeeb619bc791b ]---
RIP: 0010:__check_heap_object+0xa5/0xb3 mm/slab.c:4178
Code: 2b 48 c7 c7 4d fc 61 88 e8 28 ad 07 00 5d c3 41 8b 91 04 01 00 00 48  
29 c7 48 39 d7 77 bd 48 01 d0 48 29 c8 4c 39 c0 72 b2 c3 <0f> 0b 48 c7 c7  
4d fc 61 88 e8 3c b2 07 00 44 89 e1 48 c7 c7 08 fd
RSP: 0018:ffff8880813cd370 EFLAGS: 00010046
RAX: 0000000000000001 RBX: 0000000000000001 RCX: 000000000000000c
RDX: ffff8880813cc340 RSI: 0000000000000000 RDI: ffff8880813cd468
RBP: ffff8880813cd3c0 R08: 0000000000000001 R09: ffff8880aa594c40
R10: 0000000000000f23 R11: 0000000000000000 R12: ffff8880813cd468
R13: ffffea000204f300 R14: ffff8880813cd469 R15: 0000000000000001
FS:  00005555564e1940(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffff8c046bd8 CR3: 000000009a952000 CR4: 00000000001406f0


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
