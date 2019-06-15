Return-Path: <SRS0=HtuS=UO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C8A4C46477
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 01:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 015EC21850
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 01:08:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbfFOBIH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 21:08:07 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:32903 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbfFOBIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 21:08:07 -0400
Received: by mail-io1-f72.google.com with SMTP id n4so4841845ioc.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 18:08:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=IKofd7RHJhk+pIKkDBZALv0kZ2Od6ZKscGY3dV4q92s=;
        b=tBBftSV1xrGhJVekZmG46gHKAiY9tCYCGRX9yBZwYJxNGG1EXz8/EmHz1Ci0tJgRfQ
         oUVogmHuyYrzArRXcFNcmmeml0olpVHCUbM4Ib6gnxWDeJOd+RPmxa7J0SbERaz5MZJu
         WCwLwCX+PyrT2WljZhV2HDPFWQyD8MKW6CXpVm4AedCiUYL5Wq2XLN2u//MXu5qbjKtz
         AWsmIoJkBMf69aMBf/eDueIMDEfrvoRahR8YhIRo5rLNCKAlsA5tByLsK/9YJ824S1tI
         sCJ0ddHqR2cXhq40YwB/LhIm3zanpFRSWdAiwXJB6HDPAo8Mi9GqFmDEPMYYPER6/Sx/
         gUBg==
X-Gm-Message-State: APjAAAXF2dz0OAV3pk3ekd6Su9kzYpkEJag5f2+be5PLyqc8bt6UEsMK
        nj6Z3cZ3wWqgileOxAypiwkHGJ6z6SUph6/KADbVjqeJLrmi
X-Google-Smtp-Source: APXvYqwEvHhPTBIc5MoZalq7u2YzYSvFj3n/HWPr7RCJY1d4GeLHQsg9TNnQr9unTyiNA1T4bLY3+D5XpILkbfcrxIer+4Gwn3IK
MIME-Version: 1.0
X-Received: by 2002:a6b:4107:: with SMTP id n7mr5849490ioa.12.1560560885906;
 Fri, 14 Jun 2019 18:08:05 -0700 (PDT)
Date:   Fri, 14 Jun 2019 18:08:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004143a5058b526503@google.com>
Subject: general protection fault in oom_unkillable_task
From:   syzbot <syzbot+d0fc9d3c166bc5e4a94b@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, ebiederm@xmission.com, guro@fb.com,
        hannes@cmpxchg.org, jglisse@redhat.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mhocko@kernel.org, penguin-kernel@I-love.SAKURA.ne.jp,
        shakeelb@google.com, syzkaller-bugs@googlegroups.com,
        yuzhoujian@didichuxing.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    3f310e51 Add linux-next specific files for 20190607
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15ab8771a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5d176e1849bbc45
dashboard link: https://syzkaller.appspot.com/bug?extid=d0fc9d3c166bc5e4a94b
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+d0fc9d3c166bc5e4a94b@syzkaller.appspotmail.com

kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 28426 Comm: syz-executor.5 Not tainted 5.2.0-rc3-next-20190607  
#11
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:__read_once_size include/linux/compiler.h:194 [inline]
RIP: 0010:has_intersects_mems_allowed mm/oom_kill.c:84 [inline]
RIP: 0010:oom_unkillable_task mm/oom_kill.c:168 [inline]
RIP: 0010:oom_unkillable_task+0x180/0x400 mm/oom_kill.c:155
Code: c1 ea 03 80 3c 02 00 0f 85 80 02 00 00 4c 8b a3 10 07 00 00 48 b8 00  
00 00 00 00 fc ff df 4d 8d 74 24 10 4c 89 f2 48 c1 ea 03 <80> 3c 02 00 0f  
85 67 02 00 00 49 8b 44 24 10 4c 8d a0 68 fa ff ff
RSP: 0018:ffff888000127490 EFLAGS: 00010a03
RAX: dffffc0000000000 RBX: ffff8880a4cd5438 RCX: ffffffff818dae9c
RDX: 100000000c3cc602 RSI: ffffffff818dac8d RDI: 0000000000000001
RBP: ffff8880001274d0 R08: ffff888000086180 R09: ffffed1015d26be0
R10: ffffed1015d26bdf R11: ffff8880ae935efb R12: 8000000061e63007
R13: 0000000000000000 R14: 8000000061e63017 R15: 1ffff11000024ea6
FS:  00005555561f5940(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000607304 CR3: 000000009237e000 CR4: 00000000001426f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600
Call Trace:
  oom_evaluate_task+0x49/0x520 mm/oom_kill.c:321
  mem_cgroup_scan_tasks+0xcc/0x180 mm/memcontrol.c:1169
  select_bad_process mm/oom_kill.c:374 [inline]
  out_of_memory mm/oom_kill.c:1088 [inline]
  out_of_memory+0x6b2/0x1280 mm/oom_kill.c:1035
  mem_cgroup_out_of_memory+0x1ca/0x230 mm/memcontrol.c:1573
  mem_cgroup_oom mm/memcontrol.c:1905 [inline]
  try_charge+0xfbe/0x1480 mm/memcontrol.c:2468
  mem_cgroup_try_charge+0x24d/0x5e0 mm/memcontrol.c:6073
  mem_cgroup_try_charge_delay+0x1f/0xa0 mm/memcontrol.c:6088
  do_huge_pmd_wp_page_fallback+0x24f/0x1680 mm/huge_memory.c:1201
  do_huge_pmd_wp_page+0x7fc/0x2160 mm/huge_memory.c:1359
  wp_huge_pmd mm/memory.c:3793 [inline]
  __handle_mm_fault+0x164c/0x3eb0 mm/memory.c:4006
  handle_mm_fault+0x3b7/0xa90 mm/memory.c:4053
  do_user_addr_fault arch/x86/mm/fault.c:1455 [inline]
  __do_page_fault+0x5ef/0xda0 arch/x86/mm/fault.c:1521
  do_page_fault+0x71/0x57d arch/x86/mm/fault.c:1552
  page_fault+0x1e/0x30 arch/x86/entry/entry_64.S:1156
RIP: 0033:0x400590
Code: 06 e9 49 01 00 00 48 8b 44 24 10 48 0b 44 24 28 75 1f 48 8b 14 24 48  
8b 7c 24 20 be 04 00 00 00 e8 f5 56 00 00 48 8b 74 24 08 <89> 06 e9 1e 01  
00 00 48 8b 44 24 08 48 8b 14 24 be 04 00 00 00 8b
RSP: 002b:00007fff7bc49780 EFLAGS: 00010206
RAX: 0000000000000001 RBX: 0000000000760000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 000000002000cffc RDI: 0000000000000001
RBP: fffffffffffffffe R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000075 R11: 0000000000000246 R12: 0000000000760008
R13: 00000000004c55f2 R14: 0000000000000000 R15: 00007fff7bc499b0
Modules linked in:
---[ end trace a65689219582ffff ]---
RIP: 0010:__read_once_size include/linux/compiler.h:194 [inline]
RIP: 0010:has_intersects_mems_allowed mm/oom_kill.c:84 [inline]
RIP: 0010:oom_unkillable_task mm/oom_kill.c:168 [inline]
RIP: 0010:oom_unkillable_task+0x180/0x400 mm/oom_kill.c:155
Code: c1 ea 03 80 3c 02 00 0f 85 80 02 00 00 4c 8b a3 10 07 00 00 48 b8 00  
00 00 00 00 fc ff df 4d 8d 74 24 10 4c 89 f2 48 c1 ea 03 <80> 3c 02 00 0f  
85 67 02 00 00 49 8b 44 24 10 4c 8d a0 68 fa ff ff
RSP: 0018:ffff888000127490 EFLAGS: 00010a03
RAX: dffffc0000000000 RBX: ffff8880a4cd5438 RCX: ffffffff818dae9c
RDX: 100000000c3cc602 RSI: ffffffff818dac8d RDI: 0000000000000001
RBP: ffff8880001274d0 R08: ffff888000086180 R09: ffffed1015d26be0
R10: ffffed1015d26bdf R11: ffff8880ae935efb R12: 8000000061e63007
R13: 0000000000000000 R14: 8000000061e63017 R15: 1ffff11000024ea6
FS:  00005555561f5940(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2f823000 CR3: 000000009237e000 CR4: 00000000001426f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
