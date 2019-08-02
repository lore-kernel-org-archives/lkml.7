Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA86EC19759
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 02:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B03A920665
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 02:38:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbfHBCiH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 22:38:07 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:49069 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbfHBCiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 22:38:07 -0400
Received: by mail-io1-f69.google.com with SMTP id z19so81582743ioi.15
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 19:38:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=rO6MbK94gQtYTmOiAsJqIF2aYQbASQz+L1wIGnaGIBI=;
        b=ruFbYwsHQMGSCJnykWfyJrbV4v4i9hjAjNa0OYTnQcuksRJ2mIanSNi5m/nLFxseZx
         PNMhLFsdmEywAv+CEylnjmuF0Uwi8gKYyo34KoqyPHZ5KK+cLgXqMynNAt+gcel0ucCf
         Lj6hNLf26y2TSgOzarTjgW6TIL8UjH9rhJ+lD6joIB00BsbRX5ZoVut2FEv6OHqO08Qd
         r4qTuTjAjfa5otySLIlDK6KXMX9MBqwc+tVLn37XP0jd+qvjf1feD2rDv+NAflLB8xGG
         c/noH61apEwc/4gkT5snjWF9wn/a8c0GSSixhveLfoWDkup8r+Xx/0hdgh/oGtAZM83E
         NgOA==
X-Gm-Message-State: APjAAAXewciVdk+TOCr7+DVqgcRxWnDJCtEyYwEzmylX2HNFe3tOAYyS
        BLRdsJQjCMJ5d5B9F3RHTBxdCLpZt1hb9whNbp7IlAgqOF+U
X-Google-Smtp-Source: APXvYqw4UbVp0XBzF5ccVCATxBEoJFs5z/rYI+i8vKJqCyFB1j877TyGerAHkt09pKyyg4l9Smm9pOYOzYsjdAIS8Rnb/bOX+RAc
MIME-Version: 1.0
X-Received: by 2002:a6b:3102:: with SMTP id j2mr8770688ioa.5.1564713486354;
 Thu, 01 Aug 2019 19:38:06 -0700 (PDT)
Date:   Thu, 01 Aug 2019 19:38:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000879057058f193fb5@google.com>
Subject: memory leak in tipc_group_create_member
From:   syzbot <syzbot+f95d90c454864b3b5bc9@syzkaller.appspotmail.com>
To:     davem@davemloft.net, jon.maloy@ericsson.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        tipc-discussion@lists.sourceforge.net, ying.xue@windriver.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    a9815a4f Merge branch 'x86-urgent-for-linus' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12a6dbf0600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=37c48fb52e3789e6
dashboard link: https://syzkaller.appspot.com/bug?extid=f95d90c454864b3b5bc9
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13be3ecc600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11c992b4600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+f95d90c454864b3b5bc9@syzkaller.appspotmail.com

executing program
BUG: memory leak
unreferenced object 0xffff888122bca200 (size 128):
   comm "syz-executor232", pid 7065, jiffies 4294943817 (age 8.880s)
   hex dump (first 32 bytes):
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
     00 00 00 00 00 00 00 00 18 a2 bc 22 81 88 ff ff  ..........."....
   backtrace:
     [<000000005bada299>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<000000005bada299>] slab_post_alloc_hook mm/slab.h:522 [inline]
     [<000000005bada299>] slab_alloc mm/slab.c:3319 [inline]
     [<000000005bada299>] kmem_cache_alloc_trace+0x145/0x2c0 mm/slab.c:3548
     [<00000000e7bcdc9f>] kmalloc include/linux/slab.h:552 [inline]
     [<00000000e7bcdc9f>] kzalloc include/linux/slab.h:748 [inline]
     [<00000000e7bcdc9f>] tipc_group_create_member+0x3c/0x190  
net/tipc/group.c:306
     [<0000000005f56f40>] tipc_group_add_member+0x34/0x40  
net/tipc/group.c:327
     [<0000000044406683>] tipc_nametbl_build_group+0x9b/0xf0  
net/tipc/name_table.c:600
     [<000000009f71e803>] tipc_sk_join net/tipc/socket.c:2901 [inline]
     [<000000009f71e803>] tipc_setsockopt+0x170/0x490 net/tipc/socket.c:3006
     [<000000007f61cbc2>] __sys_setsockopt+0x10f/0x220 net/socket.c:2084
     [<00000000cc630372>] __do_sys_setsockopt net/socket.c:2100 [inline]
     [<00000000cc630372>] __se_sys_setsockopt net/socket.c:2097 [inline]
     [<00000000cc630372>] __x64_sys_setsockopt+0x26/0x30 net/socket.c:2097
     [<00000000ec30be33>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:296
     [<00000000271be3e6>] entry_SYSCALL_64_after_hwframe+0x44/0xa9



---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
