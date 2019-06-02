Return-Path: <SRS0=BIzH=UB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B78C282DC
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 20:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 236B027950
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 20:22:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbfFBUWG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Jun 2019 16:22:06 -0400
Received: from mail-it1-f198.google.com ([209.85.166.198]:51771 "EHLO
        mail-it1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbfFBUWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 16:22:06 -0400
Received: by mail-it1-f198.google.com with SMTP id g1so13411359itd.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2019 13:22:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=nm/6ER+q3h3p7sTnyVJsppuDHKrbGzPwoUfMZCDiitU=;
        b=LetNtJzT5umyDjL35XgGve7rsvRxdiQDt4vwyn6dG3AUWgzeo39AdAXznYGuZq9Kc9
         3RvRZLOKlKXCk//KyYoxe5nzg6wKRiYD4f6DLESChJYSDuogAlhbRN3ufI75vcCypH+m
         npFeJKiV8noJLS6h/nZvr0eWCOmPOCFzmJzVvxGhGwvlG3ymDtxNJ/cHD/Ke76sh+hRF
         oECqeypUkuE1xcpbz/ispao78n4YwRdgRo8vX2nM5Z+XLVxX+D7dlPYSFtHQ2jfkDnXc
         kI0uG++lHkJcBIlZrQ33A8RyqHcW1RrvgnDS9S6HUGxOu+0MDN81mMhEY4gqql9f30dU
         Pm/A==
X-Gm-Message-State: APjAAAXBm3G3FHUTyKaRDvO/RO4ogOyCubyx5blVqcRCxR1k3RQs/sQ1
        Kbe74m9fqga9BX/mGF12xOVkS45Ak4X45E8HSpqxp0vJlHGd
X-Google-Smtp-Source: APXvYqxQFrUTlp580iEffCW3xPsgRer1omtAU0nI1TGqhLahdWMMLa63xxmOMwAlI+JCxnE0Es2ID4rmw2ObF6bcoZb4nORmgJNi
MIME-Version: 1.0
X-Received: by 2002:a6b:6006:: with SMTP id r6mr13572641iog.231.1559506925129;
 Sun, 02 Jun 2019 13:22:05 -0700 (PDT)
Date:   Sun, 02 Jun 2019 13:22:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004c134d058a5d0096@google.com>
Subject: memory leak in sctp_v6_create_accept_sk
From:   syzbot <syzbot+276ca1c77a19977c0130@syzkaller.appspotmail.com>
To:     davem@davemloft.net, linux-kernel@vger.kernel.org,
        linux-sctp@vger.kernel.org, marcelo.leitner@gmail.com,
        netdev@vger.kernel.org, nhorman@tuxdriver.com,
        syzkaller-bugs@googlegroups.com, vyasevich@gmail.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    3ab4436f Merge tag 'nfsd-5.2-1' of git://linux-nfs.org/~bf..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=153c64a6a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=50393f7bfe444ff6
dashboard link: https://syzkaller.appspot.com/bug?extid=276ca1c77a19977c0130
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16195636a00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1717d286a00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+276ca1c77a19977c0130@syzkaller.appspotmail.com

ffffffffda RBX: 00000000006fbc38 RCX: 0000000000446b59
BUG: memory leak
unreferenced object 0xffff88812382ec40 (size 1512):
   comm "syz-executor098", pid 7138, jiffies 4294945165 (age 7.780s)
   hex dump (first 32 bytes):
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
     0a 00 07 40 00 00 00 00 00 00 00 00 00 00 00 00  ...@............
   backtrace:
     [<0000000006e93bd5>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:55 [inline]
     [<0000000006e93bd5>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<0000000006e93bd5>] slab_alloc mm/slab.c:3326 [inline]
     [<0000000006e93bd5>] kmem_cache_alloc+0x134/0x270 mm/slab.c:3488
     [<000000007da542cd>] sk_prot_alloc+0x41/0x170 net/core/sock.c:1596
     [<00000000a4eabe8a>] sk_alloc+0x35/0x2f0 net/core/sock.c:1656
     [<0000000053fa015e>] sctp_v6_create_accept_sk+0x5c/0x1b0  
net/sctp/ipv6.c:711
     [<000000008c31091c>] sctp_accept+0x1df/0x290 net/sctp/socket.c:4913
     [<00000000ec8d71b8>] inet_accept+0x4e/0x1d0 net/ipv4/af_inet.c:734
     [<000000001f5fe485>] __sys_accept4+0x12a/0x280 net/socket.c:1760
     [<0000000070a98ea5>] __do_sys_accept net/socket.c:1801 [inline]
     [<0000000070a98ea5>] __se_sys_accept net/socket.c:1798 [inline]
     [<0000000070a98ea5>] __x64_sys_accept+0x20/0x30 net/socket.c:1798
     [<000000004a076fbd>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<00000000d752b65c>] entry_SYSCALL_64_after_hwframe+0x44/0xa9



---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
