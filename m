Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B6D8CA9EB7
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 22:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB02E20B7C
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 22:44:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389447AbfJVWoN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 18:44:13 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:47427 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388779AbfJVWoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 18:44:13 -0400
Received: by mail-io1-f69.google.com with SMTP id r84so2669598ior.14
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 15:44:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=n8AthPz5EJS+41jvmzMtDwkf5FjVXZx9cmlJKclfd/M=;
        b=P6kUYRS65oAkxlPsG3bpoV439Ee0AvQOxWgM9SYCiBHdnbe6CPAs5sLErWowDwQ51x
         wSp3YUeEyMNGWEUS6WFJ+aPwWIhrDjOM108t6qA6dw4e+nJ7wTuvJbtxe3cqsTzwVe5W
         axr0s5wgP+zuYXsBDCicw8/bQlnLd9WgGjWwGLctQpTWAcY3W8mdkMVSzUI2D9gbUOGB
         yi49HyXCHYahBFQGQLdRrYyVUgscIzIM90D2tltC1bfTeVym74Nos4mYDIUtDza9lcnc
         PQbmmZF9tm45fcHdd3di1SRCBnFs61sOL/Lm3xBbZPoKuujZQWkBWw/OXTU7QPT2oFJg
         WzIA==
X-Gm-Message-State: APjAAAU54PjeyIu29dQtQUjbLLJ3vIJOqJXpYsKFVVK6PcdNWHuBEMKE
        tDNNKF2mcNGsJAWRLQDlyqdl7f2R7n/fw/SVclXQFnRdRv3M
X-Google-Smtp-Source: APXvYqy8SHCJO8nVqDVFjtRO0viqI7sq50268hI2BxRPY53Spf82Y2/LvjiTliYN9zGkl6aZIGnO0+zVoltc7aACBjopLIVrFuUr
MIME-Version: 1.0
X-Received: by 2002:a92:9c94:: with SMTP id x20mr1571289ill.149.1571784252347;
 Tue, 22 Oct 2019 15:44:12 -0700 (PDT)
Date:   Tue, 22 Oct 2019 15:44:12 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000065d240595878a92@google.com>
Subject: memory leak in rxrpc_lookup_local
From:   syzbot <syzbot+305326672fed51b205f7@syzkaller.appspotmail.com>
To:     davem@davemloft.net, dhowells@redhat.com,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    4fe34d61 Merge branch 'x86-urgent-for-linus' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11b21d40e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cd7f8e43c7bdf83a
dashboard link: https://syzkaller.appspot.com/bug?extid=305326672fed51b205f7
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10e692ff600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10af816b600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+305326672fed51b205f7@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff888121f35e00 (size 256):
   comm "syz-executor362", pid 6892, jiffies 4294941791 (age 7.710s)
   hex dump (first 32 bytes):
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
     00 00 00 00 09 00 00 00 00 80 e7 21 81 88 ff ff  ...........!....
   backtrace:
     [<000000006221752a>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<000000006221752a>] slab_post_alloc_hook mm/slab.h:586 [inline]
     [<000000006221752a>] slab_alloc mm/slab.c:3319 [inline]
     [<000000006221752a>] kmem_cache_alloc_trace+0x145/0x2c0 mm/slab.c:3548
     [<000000006ee28c35>] kmalloc include/linux/slab.h:556 [inline]
     [<000000006ee28c35>] kzalloc include/linux/slab.h:690 [inline]
     [<000000006ee28c35>] rxrpc_alloc_local net/rxrpc/local_object.c:79  
[inline]
     [<000000006ee28c35>] rxrpc_lookup_local+0x1aa/0x750  
net/rxrpc/local_object.c:277
     [<000000009255b1c3>] rxrpc_bind+0x131/0x1e0 net/rxrpc/af_rxrpc.c:149
     [<00000000d7bcf378>] __sys_bind+0x11c/0x140 net/socket.c:1647
     [<00000000c269c3cb>] __do_sys_bind net/socket.c:1658 [inline]
     [<00000000c269c3cb>] __se_sys_bind net/socket.c:1656 [inline]
     [<00000000c269c3cb>] __x64_sys_bind+0x1e/0x30 net/socket.c:1656
     [<000000000444b7d1>] do_syscall_64+0x73/0x1f0  
arch/x86/entry/common.c:290
     [<000000001700d564>] entry_SYSCALL_64_after_hwframe+0x44/0xa9



---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
