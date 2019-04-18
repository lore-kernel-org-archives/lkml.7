Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C17FC10F0B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 05:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C7712083D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 05:08:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbfDRFIH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 01:08:07 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:40212 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbfDRFIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 01:08:06 -0400
Received: by mail-io1-f72.google.com with SMTP id e72so1078794iof.7
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 22:08:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=LNT9q1mpdVjlYljQ/uS4EASw5ben7mI0WsQ6X1o2pu0=;
        b=P6oCJizQgGpzoaMLmYOKV7GWKDXA4+JZzkTpoNyIBZrrcgddedEsqyorc4HgI6IlBa
         eVK3iuFg6GEVBbM49VoVgm7GuxmgQaDzQljuFhLRML9nSlWpafZm5eBnuaHLuYjndDrE
         QwPua/3UJXAr0ohjbPoNXBiiVJwUxE60A9564hybZuM8r2cnSdD4u4D8yn1g/8DYbcrK
         Y9W7hL7YEW21KBT9zEfCZOnHw6OEkft1/YR2sVfkyDA6ad/Pm/OkoN4+S79ocpkxoQKl
         GVFSPv0z2VbKwVX9hUZrxjKjGow7W8BHPE4B+1c0a+QQ7OqofC7cND+Jl6n2WJqjkn/j
         Losw==
X-Gm-Message-State: APjAAAXEUWJVqNzWiOpNxjmgZUBLzvWcQ/r6N26qVQ/zCV2c42e+vquv
        wqWbuT0zY8fSn079AirqOarPPZF2R0LOknqZalOJCYIa4LHx
X-Google-Smtp-Source: APXvYqxJB4Dupo7HsgXvgSbDSJRKNttG0lpMiOiqO4ysdvnE5Qh+LvOJWSY4hSq9D0PCS3+A56nyseVkb+71fdbDR2/WdwXFLUhO
MIME-Version: 1.0
X-Received: by 2002:a5e:a710:: with SMTP id b16mr33189783iod.233.1555564086125;
 Wed, 17 Apr 2019 22:08:06 -0700 (PDT)
Date:   Wed, 17 Apr 2019 22:08:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c770710586c6fc92@google.com>
Subject: BUG: unable to handle kernel paging request in free_block (5)
From:   syzbot <syzbot+438a5abd4f53adb1c073@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    e6986423 socket: fix compat SO_RCVTIMEO_NEW/SO_SNDTIMEO_NEW
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=17356e67200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4fb64439e07a1ec0
dashboard link: https://syzkaller.appspot.com/bug?extid=438a5abd4f53adb1c073
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12adddbf200000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+438a5abd4f53adb1c073@syzkaller.appspotmail.com

BUG: unable to handle kernel paging request at 0000000100000000
#PF error: [WRITE]
PGD 94a7e067 P4D 94a7e067 PUD 0
Oops: 0002 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 7806 Comm: kworker/1:3 Not tainted 5.1.0-rc4+ #171
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events cache_reap
RIP: 0010:slab_put_obj mm/slab.c:2622 [inline]
RIP: 0010:free_block+0x149/0x250 mm/slab.c:3420
Code: b6 4c 24 1c 48 c1 ee 20 29 f0 d3 e8 41 0f b6 4c 24 1d 01 f0 49 8b 75  
20 d3 e8 8d 4f ff 48 85 f6 41 89 4d 30 0f 84 f0 00 00 00 <88> 04 0e 41 8b  
45 30 85 c0 0f 84 fa fe ff ff 49 8b 76 40 4c 89 ff
RSP: 0018:ffff888098c17c00 EFLAGS: 00010002
RAX: 0000000000000004 RBX: ffffe8ffffd62810 RCX: 00000000fffffffe
RDX: ffff8880a0d4d4e0 RSI: 0000000000000002 RDI: 00000000ffffffff
RBP: ffff888098c17c50 R08: ffff8880a830e300 R09: ffffed1013182f80
R10: ffffed1013182f7f R11: 0000000000000003 R12: ffff88821670d680
R13: ffffea0002835340 R14: ffff88809af7b000 R15: ffffea0002835348
FS:  0000000000000000(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000100000000 CR3: 0000000094a56000 CR4: 00000000001406e0
Call Trace:
  drain_array_locked+0x36/0x90 mm/slab.c:2203
  drain_array+0x8c/0xb0 mm/slab.c:4028
  cache_reap+0xf4/0x280 mm/slab.c:4069
  process_one_work+0x98e/0x1790 kernel/workqueue.c:2269
  worker_thread+0x98/0xe40 kernel/workqueue.c:2415
  kthread+0x357/0x430 kernel/kthread.c:253
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
Modules linked in:
CR2: 0000000100000000
---[ end trace b44d468fe865ba2d ]---
RIP: 0010:slab_put_obj mm/slab.c:2622 [inline]
RIP: 0010:free_block+0x149/0x250 mm/slab.c:3420
Code: b6 4c 24 1c 48 c1 ee 20 29 f0 d3 e8 41 0f b6 4c 24 1d 01 f0 49 8b 75  
20 d3 e8 8d 4f ff 48 85 f6 41 89 4d 30 0f 84 f0 00 00 00 <88> 04 0e 41 8b  
45 30 85 c0 0f 84 fa fe ff ff 49 8b 76 40 4c 89 ff
RSP: 0018:ffff888098c17c00 EFLAGS: 00010002
RAX: 0000000000000004 RBX: ffffe8ffffd62810 RCX: 00000000fffffffe
RDX: ffff8880a0d4d4e0 RSI: 0000000000000002 RDI: 00000000ffffffff
RBP: ffff888098c17c50 R08: ffff8880a830e300 R09: ffffed1013182f80
R10: ffffed1013182f7f R11: 0000000000000003 R12: ffff88821670d680
R13: ffffea0002835340 R14: ffff88809af7b000 R15: ffffea0002835348
FS:  0000000000000000(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000100000000 CR3: 0000000094a56000 CR4: 00000000001406e0


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
