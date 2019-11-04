Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 959AFCA9EA0
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 11:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 705B221744
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 11:27:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728444AbfKDL1J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 06:27:09 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:55273 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbfKDL1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 06:27:09 -0500
Received: by mail-il1-f199.google.com with SMTP id t67so6137946ill.21
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 03:27:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=qF9HR4qzS9jnBK+P00Rhbp1bfWzTAJEf2Ve1RRYuzX4=;
        b=L0HsIOB94/iNACiJOGp1wqf3IolM8e6HxC1SZfgHMmtShiyCV4Q85W1me9ppMF3kny
         50C3WhTnazR/a6yMSl0CG0Bp5wmWqWO0R99n7TSC8Z3Prqr3mZaXs10t1hkvPVXlwZV6
         39ZU+bcpwdbq6cS319c/z/6f1JpvYOx9ZLqPEU6ZHVA6SbrY+kmcIpIcYkfPTEKHZpSV
         FO1S4uRuH585lyrpojEGv51UeV2Ws+76CjX5lzToVk+dXK3l5xz5yqUwW/w83Ahq85/3
         YubK5HHDhdWMzUsXRQx54mm/STOGjCT/CmCjpBg4PKcDYtf59c0plfjAXfBwWZo0B1Se
         1RoQ==
X-Gm-Message-State: APjAAAVKz28y69Esj3AOXUcPdfzC60RcMul/HmTpHBifmjB5BZqrekoU
        9nh4gC2i5k7mScdD6NVxDupmQkbFdpq5KELDULjc0I6a97T1
X-Google-Smtp-Source: APXvYqw8Ad//aE67c6FaVCE42SnBm/lXPgXLQ09URqePH9Tj+lqgsbdFJJhIjdUkshVKcnjmmf7XG67UIzdUEYO8HqkrLTZIIK8f
MIME-Version: 1.0
X-Received: by 2002:a5d:8789:: with SMTP id f9mr1078590ion.237.1572866828188;
 Mon, 04 Nov 2019 03:27:08 -0800 (PST)
Date:   Mon, 04 Nov 2019 03:27:08 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000092c2f10596839808@google.com>
Subject: KCSAN: data-race in mem_cgroup_select_victim_node / mem_cgroup_select_victim_node
From:   syzbot <syzbot+234d50ad314ef67bcd16@syzkaller.appspotmail.com>
To:     cgroups@vger.kernel.org, elver@google.com, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mhocko@kernel.org, syzkaller-bugs@googlegroups.com,
        vdavydov.dev@gmail.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    05f22368 x86, kcsan: Enable KCSAN for x86
git tree:       https://github.com/google/ktsan.git kcsan
console output: https://syzkaller.appspot.com/x/log.txt?x=1774c6c0e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=87d111955f40591f
dashboard link: https://syzkaller.appspot.com/bug?extid=234d50ad314ef67bcd16
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+234d50ad314ef67bcd16@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in mem_cgroup_select_victim_node /  
mem_cgroup_select_victim_node

write to 0xffff88809fade9b0 of 4 bytes by task 8603 on cpu 0:
  mem_cgroup_select_victim_node+0xb5/0x3d0 mm/memcontrol.c:1686
  try_to_free_mem_cgroup_pages+0x175/0x4c0 mm/vmscan.c:3376
  reclaim_high.constprop.0+0xf7/0x140 mm/memcontrol.c:2349
  mem_cgroup_handle_over_high+0x96/0x180 mm/memcontrol.c:2430
  tracehook_notify_resume include/linux/tracehook.h:197 [inline]
  exit_to_usermode_loop+0x20c/0x2c0 arch/x86/entry/common.c:163
  prepare_exit_to_usermode+0x180/0x1a0 arch/x86/entry/common.c:194
  swapgs_restore_regs_and_return_to_usermode+0x0/0x40

read to 0xffff88809fade9b0 of 4 bytes by task 7290 on cpu 1:
  mem_cgroup_select_victim_node+0x92/0x3d0 mm/memcontrol.c:1675
  try_to_free_mem_cgroup_pages+0x175/0x4c0 mm/vmscan.c:3376
  reclaim_high.constprop.0+0xf7/0x140 mm/memcontrol.c:2349
  mem_cgroup_handle_over_high+0x96/0x180 mm/memcontrol.c:2430
  tracehook_notify_resume include/linux/tracehook.h:197 [inline]
  exit_to_usermode_loop+0x20c/0x2c0 arch/x86/entry/common.c:163
  prepare_exit_to_usermode+0x180/0x1a0 arch/x86/entry/common.c:194
  swapgs_restore_regs_and_return_to_usermode+0x0/0x40

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 PID: 7290 Comm: syz-executor.1 Not tainted 5.4.0-rc3+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
==================================================================
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 7290 Comm: syz-executor.1 Not tainted 5.4.0-rc3+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0xf5/0x159 lib/dump_stack.c:113
  panic+0x210/0x640 kernel/panic.c:221
  kcsan_report.cold+0xc/0x10 kernel/kcsan/report.c:302
  __kcsan_setup_watchpoint+0x32e/0x4a0 kernel/kcsan/core.c:411
  __tsan_read4 kernel/kcsan/kcsan.c:35 [inline]
  __tsan_read4+0x2c/0x30 kernel/kcsan/kcsan.c:35
  mem_cgroup_select_victim_node+0x92/0x3d0 mm/memcontrol.c:1675
  try_to_free_mem_cgroup_pages+0x175/0x4c0 mm/vmscan.c:3376
  reclaim_high.constprop.0+0xf7/0x140 mm/memcontrol.c:2349
  mem_cgroup_handle_over_high+0x96/0x180 mm/memcontrol.c:2430
  tracehook_notify_resume include/linux/tracehook.h:197 [inline]
  exit_to_usermode_loop+0x20c/0x2c0 arch/x86/entry/common.c:163
  prepare_exit_to_usermode+0x180/0x1a0 arch/x86/entry/common.c:194
  retint_user+0x8/0x8
RIP: 0033:0x45862a
Code: 48 85 db 74 b6 41 bc ca 00 00 00 eb 0c 0f 1f 00 48 8b 5b 08 48 85 db  
74 a2 48 8b 3b 48 8b 47 10 48 85 c0 74 05 ff d0 48 8b 3b <f0> ff 4f 28 0f  
94 c0 84 c0 74 db 8b 47 2c 85 c0 74 d4 45 31 d2 ba
RSP: 002b:00007ffec3569600 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 00007ffec3569600 RCX: 00000000004584ca
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000a76d48
RBP: 00007ffec3569640 R08: 0000000000000001 R09: 000000000269f940
R10: 000000000269fc10 R11: 0000000000000246 R12: 00000000000000ca
R13: 0000000000000079 R14: 0000000000000000 R15: 00007ffec3569690
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
