Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F5DAC76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 16:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61A71206BF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 16:18:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728416AbfGWQSH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 12:18:07 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:46564 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730480AbfGWQSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 12:18:07 -0400
Received: by mail-io1-f69.google.com with SMTP id s83so47728112iod.13
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 09:18:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=kQSG0beHyO6uv0xVHKgcfkX+wkja0UWMo+b5ugy8hC8=;
        b=jHLo6zhOLdD7zyhCU0XXSj5pj3mhBhpFRbYKEtMLNuiLgu34A2qtKdZS4WSCP7IyEq
         ZrorV1L4P3U7m44/DOKFPv42rRWlU0jqJHWBDOdauVOrtKYGnBKXotTkPBE7/jWVlo7R
         7zx5r4iIWUMshJU60z4JCRd4KXXqLO3eaVUfsJHfZxYOt7lqHPN1Aq/v1gsuoc5qXjh1
         UWXznVDJ9jKgNsJydi/odllEKfIBUM9UgDpg1SMz8NRq4xCWwx/B9NNAH/xJU6mpvg02
         rErHVK5/ZmGn6iOnYB/Uzp6+HTuSN4JkJcvSh7wJ81ePzSxXvsqfEC++HiQD7TLKaWh6
         KiXA==
X-Gm-Message-State: APjAAAUMxzdDX39zXQFPdfY3wtMD9v1jufAiViLSpOThNjuVv8ZsKEFW
        tC9lXvCO7CtPyvInjuuB78mwAUkcO/uj6j1CVE1bOzGap0aY
X-Google-Smtp-Source: APXvYqz5H3uVOWGK8GQuU9zEBEhD8aFl6f6mDaeAPKJq0g+44A03rgs1+DiLao4BJImt1K2EC4ta0HhztrxP1kHh0xSLVfpnzD+e
MIME-Version: 1.0
X-Received: by 2002:a6b:f406:: with SMTP id i6mr1490130iog.110.1563898686541;
 Tue, 23 Jul 2019 09:18:06 -0700 (PDT)
Date:   Tue, 23 Jul 2019 09:18:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ad1dfe058e5b89ab@google.com>
Subject: memory leak in rds_send_probe
From:   syzbot <syzbot+5134cdf021c4ed5aaa5f@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    c6dd78fc Merge branch 'x86-urgent-for-linus' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14be98c8600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8de7d700ea5ac607
dashboard link: https://syzkaller.appspot.com/bug?extid=5134cdf021c4ed5aaa5f
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=145df0c8600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=170001f4600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+5134cdf021c4ed5aaa5f@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff8881234e9c00 (size 512):
   comm "kworker/u4:2", pid 286, jiffies 4294948041 (age 7.750s)
   hex dump (first 32 bytes):
     01 00 00 00 00 00 00 00 08 9c 4e 23 81 88 ff ff  ..........N#....
     08 9c 4e 23 81 88 ff ff 18 9c 4e 23 81 88 ff ff  ..N#......N#....
   backtrace:
     [<0000000032e378fa>] kmemleak_alloc_recursive  
/./include/linux/kmemleak.h:43 [inline]
     [<0000000032e378fa>] slab_post_alloc_hook /mm/slab.h:522 [inline]
     [<0000000032e378fa>] slab_alloc /mm/slab.c:3319 [inline]
     [<0000000032e378fa>] __do_kmalloc /mm/slab.c:3653 [inline]
     [<0000000032e378fa>] __kmalloc+0x16d/0x2d0 /mm/slab.c:3664
     [<0000000015bc9536>] kmalloc /./include/linux/slab.h:557 [inline]
     [<0000000015bc9536>] kzalloc /./include/linux/slab.h:748 [inline]
     [<0000000015bc9536>] rds_message_alloc+0x3e/0xc0 /net/rds/message.c:291
     [<00000000a806d18d>] rds_send_probe.constprop.0+0x42/0x2f0  
/net/rds/send.c:1419
     [<00000000794a00cc>] rds_send_pong+0x1e/0x23 /net/rds/send.c:1482
     [<00000000b2a248d0>] rds_recv_incoming+0x27e/0x460 /net/rds/recv.c:343
     [<00000000ea1503db>] rds_loop_xmit+0x86/0x100 /net/rds/loop.c:96
     [<00000000a9857f5a>] rds_send_xmit+0x524/0x9a0 /net/rds/send.c:355
     [<00000000557b0101>] rds_send_worker+0x3c/0xd0 /net/rds/threads.c:200
     [<000000004ba94868>] process_one_work+0x23f/0x490  
/kernel/workqueue.c:2269
     [<00000000e793f811>] worker_thread+0x195/0x580 /kernel/workqueue.c:2415
     [<000000003ee8c1a1>] kthread+0x13e/0x160 /kernel/kthread.c:255
     [<000000004cd53c81>] ret_from_fork+0x1f/0x30  
/arch/x86/entry/entry_64.S:352



---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
