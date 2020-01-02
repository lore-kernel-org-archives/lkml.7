Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 650A1C2D0DC
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 12:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 404E5215A4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 12:35:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbgABMfL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 07:35:11 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:51026 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728274AbgABMfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 07:35:11 -0500
Received: by mail-il1-f198.google.com with SMTP id z12so34782809ilh.17
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jan 2020 04:35:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=y0iE5KleJVXXmUFvao8OvB4WDNhb1+wejlM/yNViWB0=;
        b=kPcNMhqGlBX0Dac7yS9GJ1YfgK6HVg35E5nZAenC2y41fyFYIbBgsh3MDhtJkDngQq
         XTCfJecIyh61E43BnwFJB+mGi5HF8u1A2w1/6vUnYjPWLwuDOHJwrndz+I88CXKJ0oRg
         AQJ9fWukHEbYswcyUprx/CT7bgekV3prgy0oPWRzSrDYTVWn4Bfa/HZTDxdI0Q8HG5LD
         CEzLGKX4BVxPkl1hrxcJugJ4tTt1kXKfgo02gpL3tKbrfnJjin8A5TJXVfS6XJYqJfoK
         3aRrCwueJNqP+FOkeHI1oiE44kuspdPIL+aKqV/hlER7sUP2JX28TXbrgp4gbt0rncgG
         9K1A==
X-Gm-Message-State: APjAAAViksVOIJmpe4+m+qsKfPd/PCEdzmwLsF2nDM8cUAnccZmjmX/5
        aQS3u/5qw4fu688j6VZqr9SoI2OByeXNWVQ0grVYL92EyTa2
X-Google-Smtp-Source: APXvYqxFR/nfC87By5t8MAevHYJSM4hc9KgEMxwcIzCAhJzxWn8oF64cx9dgEtwx2oDUqZyG7pTghhJ6gs+7Doo5hyjT/2qCnXoB
MIME-Version: 1.0
X-Received: by 2002:a92:d2:: with SMTP id 201mr72802259ila.22.1577968509084;
 Thu, 02 Jan 2020 04:35:09 -0800 (PST)
Date:   Thu, 02 Jan 2020 04:35:09 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000736cbb059b276cd4@google.com>
Subject: memory leak in path_openat
From:   syzbot <syzbot+9c064b9ab4dbb724c806@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    bf8d1cd4 Merge tag 'scsi-fixes' of git://git.kernel.org/pu..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16386971e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=328af7338803d39a
dashboard link: https://syzkaller.appspot.com/bug?extid=9c064b9ab4dbb724c806
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17f4ce15e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=153c8971e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+9c064b9ab4dbb724c806@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff88811f95b400 (size 256):
   comm "syz-executor609", pid 6975, jiffies 4294945087 (age 7.980s)
   hex dump (first 32 bytes):
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
     a0 2b ab 1b 82 88 ff ff c0 3c 80 2b 81 88 ff ff  .+.......<.+....
   backtrace:
     [<00000000aa112990>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<00000000aa112990>] slab_post_alloc_hook mm/slab.h:586 [inline]
     [<00000000aa112990>] slab_alloc mm/slab.c:3320 [inline]
     [<00000000aa112990>] kmem_cache_alloc+0x13f/0x2c0 mm/slab.c:3484
     [<00000000a62a216f>] kmem_cache_zalloc include/linux/slab.h:660 [inline]
     [<00000000a62a216f>] __alloc_file+0x28/0x130 fs/file_table.c:101
     [<00000000db4f5560>] alloc_empty_file+0x50/0xd0 fs/file_table.c:151
     [<00000000178121b2>] path_openat+0x52/0x1dd0 fs/namei.c:3526
     [<00000000b9f51901>] do_filp_open+0xaa/0x130 fs/namei.c:3567
     [<000000008b6c278b>] do_sys_open+0x253/0x330 fs/open.c:1097
     [<00000000de529158>] __do_sys_openat fs/open.c:1124 [inline]
     [<00000000de529158>] __se_sys_openat fs/open.c:1118 [inline]
     [<00000000de529158>] __x64_sys_openat+0x24/0x30 fs/open.c:1118
     [<000000002f0aeb7b>] do_syscall_64+0x73/0x220  
arch/x86/entry/common.c:294
     [<00000000720f3b5c>] entry_SYSCALL_64_after_hwframe+0x44/0xa9



---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
