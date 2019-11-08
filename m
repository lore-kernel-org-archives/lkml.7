Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D62D2FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 16:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB16F2178F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 16:15:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbfKHQPS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 11:15:18 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:38868 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbfKHQPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 11:15:16 -0500
Received: by mail-io1-f70.google.com with SMTP id q4so4831357ion.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 08:15:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to:cc;
        bh=EntwwLODpyY62XQRYlVLnbG2S7/f1rAzhT5hFJTJSbM=;
        b=fsf9Hqiz/xr0yKpcCXGtaq3l/K0SnX5mNia1fPcibwuvNEvH0OsLAovoZ0+o21BepB
         /e5vewWgkUT8fpb8KgoA4Djy/5tDcietlw5moCtvc6kXsGCuqsg8swOBI2LyW6YsNOlj
         fhSsI6juVfkNS3ArY0hQ/iwi2OCHpyO0AMf5AjITHer9bKdtQt9EepmoI06kytdqNd5C
         4p//z0qAbug4/YnHOkGWMyPmjybmbAP5ktw87nfiC51RyYtF480d+8hqIAbgGJPUE+RD
         8ie2F/vGmV9a65gSyxxKL54qSuFyTZ0y5wHd7ZurtW538w+FJhccGLuNe2o4cJTZ+9v/
         +daA==
X-Gm-Message-State: APjAAAVEAyufi0XKkTPV2h5ej1wpZ4vRDZYuxodSuIzEDgltc8+bW6Cs
        d5BcgTCxVctyg2aTTdDQpli8yd1iM1hJ7O/rB/1N01Yugib0
X-Google-Smtp-Source: APXvYqxBtgpBDe6GetQ1LkAJ95G+0MLSgVJj1ZlffQlRsU/gy09LNV9oamAfIrswACaI1WBRzGA/KiG0AmyFOpKmSXnH4nhe0XDO
MIME-Version: 1.0
X-Received: by 2002:a5d:8b0c:: with SMTP id k12mr10971583ion.115.1573229714011;
 Fri, 08 Nov 2019 08:15:14 -0800 (PST)
Date:   Fri, 08 Nov 2019 08:15:14 -0800
In-Reply-To: <CACT4Y+bOy+OOp2h=jNYJB8xBhQ9x_=MEgP-XcU7KHs7v1v0YPA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000040fb360596d81689@google.com>
Subject: Re: Re: KMSAN: uninit-value in kernel_sendmsg
From:   syzbot <syzbot+4b6f070bb7a8ea5420d4@syzkaller.appspotmail.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     davem@davemloft.net, dhowells@redhat.com, dvyukov@google.com,
        glider@google.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, Nov 8, 2019 at 4:54 PM syzbot
> <syzbot+4b6f070bb7a8ea5420d4@syzkaller.appspotmail.com> wrote:

>> Hello,

>> syzbot found the following crash on:

>> HEAD commit:    124037e0 kmsan: drop inlines, rename  
>> do_kmsan_task_create()
>> git tree:       https://github.com/google/kmsan.git master
>> console output: https://syzkaller.appspot.com/x/log.txt?x=1648eb9d600000
>> kernel config:   
>> https://syzkaller.appspot.com/x/.config?x=f03c659d0830ab8d
>> dashboard link:  
>> https://syzkaller.appspot.com/bug?extid=4b6f070bb7a8ea5420d4
>> compiler:       clang version 9.0.0 (/home/glider/llvm/clang
>> 80fee25776c2fb61e74c1ecb1a523375c2500b69)

>> Unfortunately, I don't have any reproducer for this crash yet.

>> IMPORTANT: if you fix the bug, please add the following tag to the  
>> commit:
>> Reported-by: syzbot+4b6f070bb7a8ea5420d4@syzkaller.appspotmail.com

> I think this is:

> #syz dup: KMSAN: use-after-free in rxrpc_send_keepalive

Can't dup bug to a bug in different reporting (upstream->moderation).Please  
dup syzbot bugs only onto syzbot bugs for the same kernel/reporting.


> https://syzkaller.appspot.com/bug?id=428e72dc175d0f4b23a1fb9b7d3d16fad7ef2a4b

>> =====================================================
>> BUG: KMSAN: uninit-value in rxrpc_send_keepalive+0x2fa/0x830
>> net/rxrpc/output.c:655
>> CPU: 0 PID: 3367 Comm: kworker/0:2 Not tainted 5.3.0-rc7+ #0
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
>> Google 01/01/2011
>> Workqueue: krxrpcd rxrpc_peer_keepalive_worker
>> Call Trace:
>>    __dump_stack lib/dump_stack.c:77 [inline]
>>    dump_stack+0x191/0x1f0 lib/dump_stack.c:113
>>    kmsan_report+0x13a/0x2b0 mm/kmsan/kmsan_report.c:108
>>    __msan_warning+0x73/0xe0 mm/kmsan/kmsan_instr.c:250
>>    sock_sendmsg_nosec net/socket.c:637 [inline]
>>    sock_sendmsg net/socket.c:657 [inline]
>>    kernel_sendmsg+0x2c9/0x440 net/socket.c:677
>>    rxrpc_send_keepalive+0x2fa/0x830 net/rxrpc/output.c:655
>>    rxrpc_peer_keepalive_dispatch net/rxrpc/peer_event.c:369 [inline]
>>    rxrpc_peer_keepalive_worker+0xb82/0x1510 net/rxrpc/peer_event.c:430
>>    process_one_work+0x1572/0x1ef0 kernel/workqueue.c:2269
>>    worker_thread+0x111b/0x2460 kernel/workqueue.c:2415
>>    kthread+0x4b5/0x4f0 kernel/kthread.c:256
>>    ret_from_fork+0x35/0x40 arch/x86/entry/entry_64.S:355

>> Uninit was created at:
>>    kmsan_save_stack_with_flags mm/kmsan/kmsan.c:150 [inline]
>>    kmsan_internal_poison_shadow+0x53/0x100 mm/kmsan/kmsan.c:134
>>    kmsan_slab_alloc+0xaa/0x120 mm/kmsan/kmsan_hooks.c:103
>>    slab_alloc_node mm/slub.c:2790 [inline]
>>    slab_alloc mm/slub.c:2799 [inline]
>>    kmem_cache_alloc_trace+0x8c5/0xd20 mm/slub.c:2816
>>    kmalloc include/linux/slab.h:552 [inline]
>>    __hw_addr_create_ex net/core/dev_addr_lists.c:30 [inline]
>>    __hw_addr_add_ex net/core/dev_addr_lists.c:76 [inline]
>>    __hw_addr_add net/core/dev_addr_lists.c:84 [inline]
>>    dev_addr_init+0x152/0x700 net/core/dev_addr_lists.c:464
>>    alloc_netdev_mqs+0x2a9/0x1650 net/core/dev.c:9150
>>    rtnl_create_link+0x559/0x1190 net/core/rtnetlink.c:2931
>>    __rtnl_newlink net/core/rtnetlink.c:3186 [inline]
>>    rtnl_newlink+0x2757/0x38d0 net/core/rtnetlink.c:3254
>>    rtnetlink_rcv_msg+0x115a/0x1580 net/core/rtnetlink.c:5223
>>    netlink_rcv_skb+0x431/0x620 net/netlink/af_netlink.c:2477
>>    rtnetlink_rcv+0x50/0x60 net/core/rtnetlink.c:5241
>>    netlink_unicast_kernel net/netlink/af_netlink.c:1302 [inline]
>>    netlink_unicast+0xf6c/0x1050 net/netlink/af_netlink.c:1328
>>    netlink_sendmsg+0x110f/0x1330 net/netlink/af_netlink.c:1917
>>    sock_sendmsg_nosec net/socket.c:637 [inline]
>>    sock_sendmsg net/socket.c:657 [inline]
>>    ___sys_sendmsg+0x14ff/0x1590 net/socket.c:2311
>>    __sys_sendmsg net/socket.c:2356 [inline]
>>    __do_sys_sendmsg net/socket.c:2365 [inline]
>>    __se_sys_sendmsg+0x305/0x460 net/socket.c:2363
>>    __x64_sys_sendmsg+0x4a/0x70 net/socket.c:2363
>>    do_syscall_64+0xbc/0xf0 arch/x86/entry/common.c:297
>>    entry_SYSCALL_64_after_hwframe+0x63/0xe7
>> =====================================================


>> ---
>> This bug is generated by a bot. It may contain errors.
>> See https://goo.gl/tpsmEJ for more information about syzbot.
>> syzbot engineers can be reached at syzkaller@googlegroups.com.

>> syzbot will keep track of this bug report. See:
>> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

>> --
>> You received this message because you are subscribed to the Google  
>> Groups "syzkaller-bugs" group.
>> To unsubscribe from this group and stop receiving emails from it, send  
>> an email to syzkaller-bugs+unsubscribe@googlegroups.com.
>> To view this discussion on the web visit  
>> https://groups.google.com/d/msgid/syzkaller-bugs/000000000000e3a8e00596d7ca32%40google.com.
