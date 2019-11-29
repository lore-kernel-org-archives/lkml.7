Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D341C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 08:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B4D12176D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 08:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbfK2IUO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 03:20:14 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:36115 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726909AbfK2IUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 03:20:13 -0500
Received: by mail-il1-f199.google.com with SMTP id m16so24253432ilh.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2019 00:20:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=vjspGYepEUR6pZ8vT7qVoJ/IfPfMJI8Mx0BSPaQjIZk=;
        b=LTSGtrlgwSox/Qyo6kMQ+EH+xwi9rS8e1IJnQ8EnihxzqK0YbkRQm1EZuDYYy9JVRQ
         mkflEI5YcXP06xrzVm6qWehR9uxlrXr8lUjm0OVKLYFs+HWMPG2yVuCXimFRzc3kAUbe
         bb/bkuXuKkOuVEosAdtwIFJfE0MC5QVViAz5HFzpyzMWnhxTy4C7XR6RUSfLvpAOlmie
         dC3TAbHqe/0w2a1c7hLNZpMIBmifbGJEUo7adescqCgAYfxwMXD9iaIi3d12e6JLrkxx
         Y2Sp9EwXkEBfYlrpm9IpqEIrm4BlF3unfx7/5U2uC5n5rKg9XX4h36FmDU1jOWtb7dkq
         Jowg==
X-Gm-Message-State: APjAAAUAC6C3mISl8Yg0nXeEQvpaQhUugDuEIAKAArGIrMMHEQ5LV8hr
        C9J65TobhjHHCK3szIf0rsGkP+STzdVweGhbIsfEQ2McaBCg
X-Google-Smtp-Source: APXvYqwVlLtjSI2A2n52aoq+SrPW8AWwjECV2sSmcqTbVF6MhZo0nfTrJws3vW8mkGJrJkOhvpiqnbgcV/RPoZKLyd3ZqUKrzOJe
MIME-Version: 1.0
X-Received: by 2002:a6b:d20f:: with SMTP id q15mr5854014iob.78.1575015610652;
 Fri, 29 Nov 2019 00:20:10 -0800 (PST)
Date:   Fri, 29 Nov 2019 00:20:10 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fd1f29059877e56a@google.com>
Subject: KASAN: use-after-free Write in ext4_mark_inode_dirty
From:   syzbot <syzbot+1e407c24e65e1fca3ecf@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    a2d79c71 Merge tag 'for-5.3/io_uring-20190711' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1632a03fa00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bf58f4f254e2639
dashboard link: https://syzkaller.appspot.com/bug?extid=1e407c24e65e1fca3ecf
compiler:       clang version 9.0.0 (/home/glider/llvm/clang  
80fee25776c2fb61e74c1ecb1a523375c2500b69)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+1e407c24e65e1fca3ecf@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in __ext4_expand_extra_isize  
fs/ext4/inode.c:5948 [inline]
BUG: KASAN: use-after-free in ext4_try_to_expand_extra_isize  
fs/ext4/inode.c:6000 [inline]
BUG: KASAN: use-after-free in ext4_mark_inode_dirty+0x63c/0x790  
fs/ext4/inode.c:6076
Write of size 2147483615 at addr ffff88807da230a0 by task  
syz-executor.3/8139

CPU: 1 PID: 8139 Comm: syz-executor.3 Not tainted 5.2.0+ #27
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1d8/0x2f8 lib/dump_stack.c:113
  print_address_description+0x75/0x5b0 mm/kasan/report.c:351
  __kasan_report+0x14b/0x1c0 mm/kasan/report.c:482
  kasan_report+0x26/0x50 mm/kasan/common.c:612
  check_memory_region_inline mm/kasan/generic.c:182 [inline]
  check_memory_region+0x2cf/0x2e0 mm/kasan/generic.c:192
  memset+0x23/0x40 mm/kasan/common.c:105
  __ext4_expand_extra_isize fs/ext4/inode.c:5948 [inline]
  ext4_try_to_expand_extra_isize fs/ext4/inode.c:6000 [inline]
  ext4_mark_inode_dirty+0x63c/0x790 fs/ext4/inode.c:6076
  ext4_evict_inode+0x1186/0x17e0 fs/ext4/inode.c:282
  evict+0x2a1/0x6c0 fs/inode.c:571
  iput_final fs/inode.c:1560 [inline]
  iput+0x508/0x690 fs/inode.c:1586
  do_unlinkat+0x4b8/0x920 fs/namei.c:4069
  __do_sys_unlink fs/namei.c:4110 [inline]
  __se_sys_unlink fs/namei.c:4108 [inline]
  __x64_sys_unlink+0x49/0x50 fs/namei.c:4108
  do_syscall_64+0xfe/0x140 arch/x86/entry/common.c:296
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x459567
Code: 00 66 90 b8 58 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 9d ba fb ff c3  
66 2e 0f 1f 84 00 00 00 00 00 66 90 b8 57 00 00 00 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7d ba fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fffc1d9e6d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000057
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000459567
RDX: 00007fffc1d9e6f0 RSI: 00007fffc1d9e6f0 RDI: 00007fffc1d9e780
RBP: 000000000000094f R08: 0000000000000000 R09: 000000000000000d
R10: 0000000000000006 R11: 0000000000000246 R12: 00007fffc1d9f810
R13: 0000555556beb940 R14: 0000000000000000 R15: 00007fffc1d9f810

The buggy address belongs to the page:
page:ffffea0001f688c0 refcount:2 mapcount:0 mapping:ffff8880a291fb18  
index:0x43e
def_blk_aops
flags: 0x1fffc000000203a(referenced|dirty|lru|active|private)
raw: 01fffc000000203a ffffea0001f6d3c8 ffffea000205bac8 ffff8880a291fb18
raw: 000000000000043e ffff88809481f150 00000002ffffffff ffff888069d500c0
page dumped because: kasan: bad access detected
page->mem_cgroup:ffff888069d500c0

Memory state around the buggy address:
  ffff88807da23f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  ffff88807da23f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ffff88807da24000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                    ^
  ffff88807da24080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
  ffff88807da24100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
