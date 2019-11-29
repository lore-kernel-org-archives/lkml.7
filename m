Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A8BC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 08:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5F78217BC
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 08:19:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbfK2ITJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 03:19:09 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:34033 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbfK2ITJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 03:19:09 -0500
Received: by mail-il1-f199.google.com with SMTP id l13so8408952ils.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2019 00:19:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=ATHqrDMMYpwPTPk6Jt4XTE81Xx+Gkl0gPlHjVabuzl0=;
        b=B8NsByzsHl42T1L6bWR+QIdfQcQ+unsrW9pe7+8ZF/163MfNV/E2I2MluodWvti9dF
         bLE4BHmHXq7YNWHCvSjrrZgSaD4ACIEIJ9PtUxq2YlpJTtCIfBtbzyTi+3zofXICTdEU
         1Q0NIyiL8FGJzPA3w2KF27xQQfcJUzLQDwNV+47HOU4OPtrNb497mIzRKQ4g6E16NVSG
         5vRckGwfaLwvGL6DKfbY5aCb6ZOqWVYixWdx9DVjVSS1WsHrxXbzOHSmfJVhjH/mMC0b
         7IwO5lOcmTnZUUmDonz1k7KZ0aQTw+lwZt/YZranrSzUm7nQ9pkPM7MJBw3Yq6LhGPei
         3y7w==
X-Gm-Message-State: APjAAAWTPd4xr3PC8CZ6n2hyxVY5g8jIXfNM1TZnTgPgAS7zQhY4v9UK
        RO3Zz5NQ7wx5mvUhS8+SRXdYH0p0MzfINCCupEIymlO6tCBG
X-Google-Smtp-Source: APXvYqyZ3b467DIQFVq5WE04MDSIETnlwzAxvPxf1LiO6lm1Q8/HFuPaMlMz5ahhfZ+hflrrOYtkI/etfts/M9VA4Xddbq+JqbTu
MIME-Version: 1.0
X-Received: by 2002:a92:aa98:: with SMTP id p24mr37992663ill.125.1575015548383;
 Fri, 29 Nov 2019 00:19:08 -0800 (PST)
Date:   Fri, 29 Nov 2019 00:19:08 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000046fd2f059877e20e@google.com>
Subject: WARNING in unaccount_page_cache_page
From:   syzbot <syzbot+fe601f9e887449d40112@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, amir73il@gmail.com,
        darrick.wong@oracle.com, dchinner@redhat.com, hannes@cmpxchg.org,
        josef@toxicpanda.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
        willy@infradead.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    089cf7f6 Linux 5.3-rc7
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1210a761600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b89bb446a3faaba4
dashboard link: https://syzkaller.appspot.com/bug?extid=fe601f9e887449d40112
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+fe601f9e887449d40112@syzkaller.appspotmail.com

WARNING: CPU: 0 PID: 12560 at mm/filemap.c:220  
unaccount_page_cache_page+0x65b/0xda0 mm/filemap.c:220
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 12560 Comm: syz-executor.2 Not tainted 5.3.0-rc7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  panic+0x2dc/0x755 kernel/panic.c:219
  __warn.cold+0x20/0x4c kernel/panic.c:576
  report_bug+0x263/0x2b0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:179 [inline]
  fixup_bug arch/x86/kernel/traps.c:174 [inline]
  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:272
  do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:291
  invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1028
RIP: 0010:unaccount_page_cache_page+0x65b/0xda0 mm/filemap.c:220
Code: 00 0f 85 be 06 00 00 49 8b 5d 00 31 ff 48 c1 eb 03 83 e3 01 48 89 de  
e8 c3 25 e4 ff 48 85 db 0f 84 c0 fb ff ff e8 15 24 e4 ff <0f> 0b 48 b8 00  
00 00 00 00 fc ff df 48 8b 55 d0 48 c1 ea 03 80 3c
RSP: 0018:ffff888060b7f9b8 EFLAGS: 00010016
RAX: 0000000000040000 RBX: 0000000000000001 RCX: ffffc9000a781000
RDX: 0000000000001dcb RSI: ffffffff818e513b RDI: 0000000000000007
RBP: ffff888060b7f9f8 R08: ffff8880584de400 R09: fffff940003f9169
R10: fffff940003f9168 R11: ffffea0001fc8b47 R12: ffffea0001fc8b40
R13: ffffea0001fc8b40 R14: ffffea0001fc8b40 R15: ffffea0001fc8b88
  delete_from_page_cache_batch+0x1e9/0x1170 mm/filemap.c:350
  truncate_inode_pages_range+0x622/0x1740 mm/truncate.c:366
  blkdev_fallocate+0x23a/0x410 fs/block_dev.c:2081
  vfs_fallocate+0x4aa/0xa50 fs/open.c:309
  ksys_fallocate+0x58/0xa0 fs/open.c:332
  __do_sys_fallocate fs/open.c:340 [inline]
  __se_sys_fallocate fs/open.c:338 [inline]
  __x64_sys_fallocate+0x97/0xf0 fs/open.c:338
  do_syscall_64+0xfd/0x6a0 arch/x86/entry/common.c:296
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x459879
Code: fd b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fd75e4bfc78 EFLAGS: 00000246 ORIG_RAX: 000000000000011d
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 0000000000459879
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000004
RBP: 000000000075c070 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000369e5d84 R11: 0000000000000246 R12: 00007fd75e4c06d4
R13: 00000000004bffbd R14: 00000000004d1fc0 R15: 00000000ffffffff
Shutting down cpus with NMI
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
