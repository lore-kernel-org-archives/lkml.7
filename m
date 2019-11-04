Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5945DCA9EA0
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 11:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A87A21D81
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 11:30:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728819AbfKDLaL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 06:30:11 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:42742 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727236AbfKDLaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 06:30:10 -0500
Received: by mail-il1-f199.google.com with SMTP id n16so1499972ilm.9
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 03:30:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=PGnkPBzgn5LmUkN96S1poOO8RfhEZz6HijmQ5U4KxFw=;
        b=Th1qMoVvPkD9A3OEL0IONwkj5hxsT5iejIow9i/HWSz7gHhYEQnLtu7CkjZ7zLgorq
         xTukRAmYun80XgUvD7Up6qg6zXIOW4ttfFHxObAU2WmIkz8HhuY3C7vbSfhE+nieleQ+
         n5HkMeqUieYPeatFl83FFCPISMa2Cuz1peW/qyh+hNmsbthlZe3Bltvk5sb1bwHYea6F
         aPXefnsi3Yeo/sbIuDnzvsKEy4jx8Y3uqe2+m8r/EC32nI0kFlZYwxRd4Ktxk+GksB6w
         iEBv3Lln06cDA5oWq6Juk3nqS2A28Bn8DtR+OZiDd3hTOxXof99j+Qx2LIMBGO+YeIxN
         7VkQ==
X-Gm-Message-State: APjAAAVKnkoec2nPGetD9fLfl7uO8IWoe4cfjU97wB92pkYawCLWLX6/
        7Qn6dd1uQfspjLtzH1qKtY5iJ8+0W53hBfby1Yl81mx9AvvK
X-Google-Smtp-Source: APXvYqzu8uQP43ZnaMlWwe2TwTKUyzfmUm24k/yeAUsm4lu6yL/sgmawV98ygiq6sXibrPclby0QzvtGx8vRB2vV3rBBofsWprCB
MIME-Version: 1.0
X-Received: by 2002:a92:d80e:: with SMTP id y14mr888463ilm.267.1572867007375;
 Mon, 04 Nov 2019 03:30:07 -0800 (PST)
Date:   Mon, 04 Nov 2019 03:30:07 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000411e4b059683a39c@google.com>
Subject: KCSAN: data-race in __rcu_read_unlock / sync_rcu_exp_select_cpus
From:   syzbot <syzbot+99f4ddade3c22ab0cf23@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, amir73il@gmail.com,
        darrick.wong@oracle.com, elver@google.com, hannes@cmpxchg.org,
        jack@suse.cz, josef@toxicpanda.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    05f22368 x86, kcsan: Enable KCSAN for x86
git tree:       https://github.com/google/ktsan.git kcsan
console output: https://syzkaller.appspot.com/x/log.txt?x=1296ff50e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=87d111955f40591f
dashboard link: https://syzkaller.appspot.com/bug?extid=99f4ddade3c22ab0cf23
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+99f4ddade3c22ab0cf23@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in __rcu_read_unlock / sync_rcu_exp_select_cpus

read to 0xffffffff85a7d440 of 8 bytes by task 7624 on cpu 0:
  rcu_read_unlock_special kernel/rcu/tree_plugin.h:615 [inline]
  __rcu_read_unlock+0x381/0x3c0 kernel/rcu/tree_plugin.h:383
  rcu_read_unlock include/linux/rcupdate.h:652 [inline]
  filemap_map_pages+0x5b3/0x990 mm/filemap.c:2687
  do_fault_around mm/memory.c:3450 [inline]
  do_read_fault mm/memory.c:3484 [inline]
  do_fault mm/memory.c:3618 [inline]
  handle_pte_fault mm/memory.c:3849 [inline]
  __handle_mm_fault+0x2554/0x2cb0 mm/memory.c:3973
  handle_mm_fault+0x21b/0x530 mm/memory.c:4010
  do_user_addr_fault arch/x86/mm/fault.c:1441 [inline]
  __do_page_fault+0x3fb/0x9e0 arch/x86/mm/fault.c:1506
  do_page_fault+0x54/0x233 arch/x86/mm/fault.c:1530
  page_fault+0x34/0x40 arch/x86/entry/entry_64.S:1202

write to 0xffffffff85a7d440 of 8 bytes by task 7353 on cpu 1:
  sync_exp_reset_tree kernel/rcu/tree_exp.h:137 [inline]
  sync_rcu_exp_select_cpus+0xd5/0x590 kernel/rcu/tree_exp.h:427
  rcu_exp_sel_wait_wake kernel/rcu/tree_exp.h:575 [inline]
  wait_rcu_exp_gp+0x25/0x40 kernel/rcu/tree_exp.h:589
  process_one_work+0x3d4/0x890 kernel/workqueue.c:2269
  worker_thread+0xa0/0x800 kernel/workqueue.c:2415
  kthread+0x1d4/0x200 drivers/block/aoe/aoecmd.c:1253
  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:352

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 PID: 7353 Comm: kworker/1:0 Not tainted 5.4.0-rc3+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: rcu_gp wait_rcu_exp_gp
==================================================================
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 7353 Comm: kworker/1:0 Not tainted 5.4.0-rc3+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: rcu_gp wait_rcu_exp_gp
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0xf5/0x159 lib/dump_stack.c:113
  panic+0x210/0x640 kernel/panic.c:221
  kcsan_report.cold+0xc/0x10 kernel/kcsan/report.c:302
  __kcsan_setup_watchpoint+0x32e/0x4a0 kernel/kcsan/core.c:411
  __tsan_write8 kernel/kcsan/kcsan.c:36 [inline]
  __tsan_write8+0x32/0x40 kernel/kcsan/kcsan.c:36
  sync_exp_reset_tree kernel/rcu/tree_exp.h:137 [inline]
  sync_rcu_exp_select_cpus+0xd5/0x590 kernel/rcu/tree_exp.h:427
  rcu_exp_sel_wait_wake kernel/rcu/tree_exp.h:575 [inline]
  wait_rcu_exp_gp+0x25/0x40 kernel/rcu/tree_exp.h:589
  process_one_work+0x3d4/0x890 kernel/workqueue.c:2269
  worker_thread+0xa0/0x800 kernel/workqueue.c:2415
  kthread+0x1d4/0x200 drivers/block/aoe/aoecmd.c:1253
  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:352
Shutting down cpus with NMI
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
