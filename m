Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9788BC43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 09:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73C63224F8
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 09:55:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729564AbfLEJzK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 04:55:10 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:37356 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729180AbfLEJzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 04:55:10 -0500
Received: by mail-io1-f72.google.com with SMTP id p2so2031658iof.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 01:55:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=UEstprLMXsCJ/HcpDk+4IwZmvggk9j9Se+yVTAfNs9w=;
        b=PKGA2OutywOLhVrLiWRtuovv8HFesPPMOmSPhjjHt6zRt0Xf9d0rmvqizucS31IAWl
         1zQK1ct/2l8bdwlBiyg1bvkLTmGV4I9X/2xFVxcZv8D6uFJ+NjVtTwbufaGeXH7Wz8iX
         ZbqMCtFW7rIQskH3HDKv/QBfkglJ3qPtVizOI/K7dkwdwIzMZt/r/dpn3v3MEQcjrAND
         v7znKizmg7W8FhHSXmEYP9KkC3H8R0ClfMTnj/cHuwBgdA95ODQ2+F0V9T4R4Z5qjNr8
         BxSuJOb+jvcLTiithl+UJ9zPSOU8yMBXXqNQXRpEZ+9ekrzbmbVR7aQwH2ZfcUpkT4/z
         TFYQ==
X-Gm-Message-State: APjAAAUo8ivHdJnAMvVGxU+XEUCQfM3RNX0pT7CiqvZNECiU//6UbRCD
        f2qtXcsquCNwgvcFL7yLFGu78IFRdT3+9LHkngN9NwUaXSPj
X-Google-Smtp-Source: APXvYqxEC5Hd+oGaUcY0dxSeF8ga0fUvD8JgCnawrnQBgpnq74Q3Bc3hsmSle+e1lMUiawGmo49tPO6f/EJzGkzv5s9tyC1W32Sd
MIME-Version: 1.0
X-Received: by 2002:a02:ca42:: with SMTP id i2mr7387961jal.87.1575539709420;
 Thu, 05 Dec 2019 01:55:09 -0800 (PST)
Date:   Thu, 05 Dec 2019 01:55:09 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b5aff60598f1ec45@google.com>
Subject: memory leak in genl_rcv_msg
From:   syzbot <syzbot+21f04f481f449c8db840@syzkaller.appspotmail.com>
To:     davem@davemloft.net, jakub.kicinski@netronome.com,
        jiri@mellanox.com, johannes.berg@intel.com,
        linux-kernel@vger.kernel.org, marcel@holtmann.org,
        mkubecek@suse.cz, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, yuehaibing@huawei.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    32ef9553 Merge tag 'fsnotify_for_v5.5-rc1' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10e778eae00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3ceab2bd652d6555
dashboard link: https://syzkaller.appspot.com/bug?extid=21f04f481f449c8db840
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11808adae00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=137058eae00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+21f04f481f449c8db840@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff888121379340 (size 32):
   comm "syz-executor138", pid 7118, jiffies 4294943875 (age 7.840s)
   hex dump (first 32 bytes):
     40 e9 11 84 ff ff ff ff d8 0a b4 83 ff ff ff ff  @...............
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<000000005c57b8f8>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<000000005c57b8f8>] slab_post_alloc_hook mm/slab.h:586 [inline]
     [<000000005c57b8f8>] slab_alloc mm/slab.c:3319 [inline]
     [<000000005c57b8f8>] kmem_cache_alloc_trace+0x145/0x2c0 mm/slab.c:3548
     [<000000005e5d1167>] kmalloc include/linux/slab.h:556 [inline]
     [<000000005e5d1167>] genl_dumpit_info_alloc net/netlink/genetlink.c:463  
[inline]
     [<000000005e5d1167>] genl_family_rcv_msg_dumpit  
net/netlink/genetlink.c:597 [inline]
     [<000000005e5d1167>] genl_family_rcv_msg net/netlink/genetlink.c:714  
[inline]
     [<000000005e5d1167>] genl_rcv_msg+0x385/0x580  
net/netlink/genetlink.c:734
     [<00000000f3f6d30b>] netlink_rcv_skb+0x61/0x170  
net/netlink/af_netlink.c:2477
     [<000000007bebabc8>] genl_rcv+0x29/0x40 net/netlink/genetlink.c:745
     [<0000000013f3b7b9>] netlink_unicast_kernel  
net/netlink/af_netlink.c:1302 [inline]
     [<0000000013f3b7b9>] netlink_unicast+0x223/0x310  
net/netlink/af_netlink.c:1328
     [<00000000bd3e2e68>] netlink_sendmsg+0x29f/0x550  
net/netlink/af_netlink.c:1917
     [<0000000061329f0f>] sock_sendmsg_nosec net/socket.c:638 [inline]
     [<0000000061329f0f>] sock_sendmsg+0x54/0x70 net/socket.c:658
     [<000000006ede6ef7>] ____sys_sendmsg+0x2d0/0x300 net/socket.c:2329
     [<000000008306e582>] ___sys_sendmsg+0x9c/0x100 net/socket.c:2383
     [<00000000194a34f7>] __sys_sendmsg+0x80/0xf0 net/socket.c:2429
     [<00000000a228fcfc>] __do_sys_sendmsg net/socket.c:2438 [inline]
     [<00000000a228fcfc>] __se_sys_sendmsg net/socket.c:2436 [inline]
     [<00000000a228fcfc>] __x64_sys_sendmsg+0x23/0x30 net/socket.c:2436
     [<0000000035c29044>] do_syscall_64+0x73/0x220  
arch/x86/entry/common.c:294
     [<000000005e1aef5b>] entry_SYSCALL_64_after_hwframe+0x44/0xa9



---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
