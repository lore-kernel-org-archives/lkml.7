Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2343AC46460
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 13:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01BFF207E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 13:52:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728581AbfFFNwN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 09:52:13 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:53283 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727391AbfFFNwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 09:52:11 -0400
Received: by mail-io1-f72.google.com with SMTP id h3so174800iob.20
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 06:52:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=wneqzP3d0PW2LTZStXoFilCV51Gt+yiKWkkPCTpQsqY=;
        b=flPGx2OKYsWSrsf5g5Hg0zHCy3D+8JipfwEriUojJpUuZYPFFNJZFKXnt6WqJx5EkS
         55DcXbNP8J285e/xB0xPBzktvouslpjZGaJU4W+Ik1GUXRJNWoY+B6Q20jzd/VoH9QDN
         asa8UnmBppyQcP7QdRr1TFbGNStEfyCPRX6S4LW7C0WMpaPNc3qPHCwSpO0rYDRRkGPM
         2E24vmu9wSLTudBEnoPUIwx2ZBl3usSKTdRK+THfcuc9FTZDxTn1iRJYNRbX22k0Wq8Z
         rWL8SoT6D4g2XDHFiz4ROsexvfROVTMLV0/Wqezcx6F13nD5J89zPOxvF61OdkL13Wip
         6Wqw==
X-Gm-Message-State: APjAAAVaYneG1SOXwhaS3kpPgE34VcZxkIQNgiChx/aEqEuF+vO7Bqln
        Hyc0ev3pCw339ikl6U24JIYqa2skmByEI1xLH/bk0TYPQV9A
X-Google-Smtp-Source: APXvYqym7g5oGrUxftDXW2GP9FRoD6N8krcXf+5fCb8yEEpafRX07r4GJ6iyxgw/NPxqjkvn7gXogTEQi2UbfRMfm+am788jUGhu
MIME-Version: 1.0
X-Received: by 2002:a6b:4f15:: with SMTP id d21mr5248371iob.210.1559829131114;
 Thu, 06 Jun 2019 06:52:11 -0700 (PDT)
Date:   Thu, 06 Jun 2019 06:52:11 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000454279058aa80535@google.com>
Subject: KASAN: slab-out-of-bounds Read in usage_accumulate
From:   syzbot <syzbot+b0d730107e2ca6cb952f@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    156c0591 Merge tag 'linux-kselftest-5.2-rc4' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15f2095aa00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=60564cb52ab29d5b
dashboard link: https://syzkaller.appspot.com/bug?extid=b0d730107e2ca6cb952f
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11a8fb61a00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+b0d730107e2ca6cb952f@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in usage_accumulate+0x9e/0xb0  
kernel/locking/lockdep.c:1676
Read of size 8 at addr ffff8880a59cfed0 by task syz-executor.1/9366

CPU: 1 PID: 9366 Comm: syz-executor.1 Not tainted 5.2.0-rc3+ #20
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:

Allocated by task 0:
(stack is not available)

Freed by task 0:
(stack is not available)

The buggy address belongs to the object at ffff8880a59ce6c0
  which belongs to the cache kmalloc-4k of size 4096
The buggy address is located 2064 bytes to the right of
  4096-byte region [ffff8880a59ce6c0, ffff8880a59cf6c0)
The buggy address belongs to the page:
page:ffffea0002967380 refcount:1 mapcount:0 mapping:ffff8880aa400dc0  
index:0x0 compound_mapcount: 0
flags: 0x1fffc0000010200(slab|head)
raw: 01fffc0000010200 ffffea000296a008 ffffea000233fe08 ffff8880aa400dc0
raw: 0000000000000000 ffff8880a59ce6c0 0000000100000001 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8880a59cfd80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff8880a59cfe00: fc fc fc fc f1 f1 f1 f1 00 f2 f2 f2 00 f2 f2 f2
> ffff8880a59cfe80: 00 f2 f2 f2 00 f2 f2 f2 fc fc fc fc 00 00 00 f2
                                                  ^
  ffff8880a59cff00: f2 f2 f2 f2 fc fc fc fc 00 00 00 f3 f3 f3 f3 f3
  ffff8880a59cff80: 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
