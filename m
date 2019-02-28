Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F50C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 10:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3B362171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 10:32:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731274AbfB1KcF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 05:32:05 -0500
Received: from mail-it1-f198.google.com ([209.85.166.198]:59620 "EHLO
        mail-it1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731144AbfB1KcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 05:32:05 -0500
Received: by mail-it1-f198.google.com with SMTP id q192so7521007itb.9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 02:32:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=JK81IFg0QPmqh7vyMbarPMg8i/QYg0mBKNUqOI6CU9k=;
        b=S20lmWG41GoySFZRwcCi7CpAjApKorGScmdw2oG0ViUxyYZJUtbnZXlJOHFoLKIRHD
         BOSprylkMRZU9qCnR/WHMCoXTklO17NT0IO/RcTyuxNL0ivDLMon4vhcokej0T8Ki5yQ
         8gP9r+oqfl7Kw3Vu+8sFVNWkhdjknZMPWpxS9hKpCuQDDjRI1+fT1e++0is/srkjxcjH
         Z7iU3HG2HMqqMATAiHD4AbA/UqAbayWrC/+RuaMzAM0Nv1EVMI/gogWpp7t6hYz6tCxP
         Lksw0PtoA4ZV4qqBO+QBlcGgzPW6c0cGBR7QcyweZqVGMR8Vx9/r1o8k3if1yO96BEU/
         vIhQ==
X-Gm-Message-State: AHQUAuZ+Y9jWC4BMb1ihVZ2oKE2fGx23P7PGG19H60KMveWYZvFUMpFl
        XuOA/M+bIGcOswykr3+QuJxsZ9jXaFnv6nMtuwS6plLsKZ/b
X-Google-Smtp-Source: APXvYqxfRs2VVyEeQVLCM7MVHNfnNYG8+VxwPX5JyMjGCNiHDsQz5kX0nkDY6nMWyIWPndxNkqPJ03/dwGdMzYQ8dWIdZCK0HuiT
MIME-Version: 1.0
X-Received: by 2002:a24:5a04:: with SMTP id v4mr2594190ita.37.1551349924014;
 Thu, 28 Feb 2019 02:32:04 -0800 (PST)
Date:   Thu, 28 Feb 2019 02:32:04 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000024b3aa0582f1cde7@google.com>
Subject: BUG: Bad page state (6)
From:   syzbot <syzbot+6f5a9b79b75b66078bf0@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, arunks@codeaurora.org,
        dan.j.williams@intel.com, ldr709@gmail.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com,
        nborisov@suse.com, rppt@linux.vnet.ibm.com,
        syzkaller-bugs@googlegroups.com, vbabka@suse.cz,
        willy@infradead.org, yuehaibing@huawei.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    42fd8df9d1d9 Add linux-next specific files for 20190228
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=179ba9e0c00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c0f38652d28b522f
dashboard link: https://syzkaller.appspot.com/bug?extid=6f5a9b79b75b66078bf0
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12ed6bd0c00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10690c8ac00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+6f5a9b79b75b66078bf0@syzkaller.appspotmail.com

BUG: Bad page state in process syz-executor193  pfn:9225a
page:ffffea0002489680 count:0 mapcount:0 mapping:ffff88808652fd80 index:0x81
shmem_aops
name:"memfd:cgroup2"
flags: 0x1fffc000008000e(referenced|uptodate|dirty|swapbacked)
raw: 01fffc000008000e ffff88809277fac0 ffff88809277fac0 ffff88808652fd80
raw: 0000000000000081 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: non-NULL mapping
Modules linked in:
CPU: 0 PID: 7659 Comm: syz-executor193 Not tainted 5.0.0-rc8-next-20190228  
#45
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  bad_page.cold+0xda/0xff mm/page_alloc.c:586
  free_pages_check_bad+0x142/0x1a0 mm/page_alloc.c:1013
  free_pages_check mm/page_alloc.c:1022 [inline]
  free_pages_prepare mm/page_alloc.c:1112 [inline]
  free_pcp_prepare mm/page_alloc.c:1137 [inline]
  free_unref_page_prepare mm/page_alloc.c:3001 [inline]
  free_unref_page_list+0x31d/0xc40 mm/page_alloc.c:3070
  release_pages+0x60d/0x1940 mm/swap.c:794
  pagevec_lru_move_fn+0x218/0x2a0 mm/swap.c:213
  activate_page_drain mm/swap.c:297 [inline]
  lru_add_drain_cpu+0x3b1/0x520 mm/swap.c:596
  lru_add_drain+0x20/0x60 mm/swap.c:647
  exit_mmap+0x290/0x530 mm/mmap.c:3134
  __mmput kernel/fork.c:1047 [inline]
  mmput+0x15f/0x4c0 kernel/fork.c:1068
  exit_mm kernel/exit.c:546 [inline]
  do_exit+0x816/0x2fa0 kernel/exit.c:863
  do_group_exit+0x135/0x370 kernel/exit.c:980
  __do_sys_exit_group kernel/exit.c:991 [inline]
  __se_sys_exit_group kernel/exit.c:989 [inline]
  __x64_sys_exit_group+0x44/0x50 kernel/exit.c:989
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x442a58
Code: 00 00 be 3c 00 00 00 eb 19 66 0f 1f 84 00 00 00 00 00 48 89 d7 89 f0  
0f 05 48 3d 00 f0 ff ff 77 21 f4 48 89 d7 44 89 c0 0f 05 <48> 3d 00 f0 ff  
ff 76 e0 f7 d8 64 41 89 01 eb d8 0f 1f 84 00 00 00
RSP: 002b:00007ffe99e2faf8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000442a58
RDX: 0000000000000000 RSI: 000000000000003c RDI: 0000000000000000
RBP: 00000000004c2468 R08: 00000000000000e7 R09: ffffffffffffffd0
R10: 0000000002000005 R11: 0000000000000246 R12: 0000000000000001
R13: 00000000006d4180 R14: 0000000000000000 R15: 0000000000000000


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
