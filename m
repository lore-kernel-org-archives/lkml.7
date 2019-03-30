Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43996C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 16:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F12CA2173C
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 16:11:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aCqoldsj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730956AbfC3QL2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 12:11:28 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33941 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730576AbfC3QL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 12:11:27 -0400
Received: by mail-wr1-f68.google.com with SMTP id p10so6319196wrq.1;
        Sat, 30 Mar 2019 09:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B48DbFikVh/bS2F8k2Dni+JlTT8Ha8+Qs1c6d58TaXk=;
        b=aCqoldsjnRPG5KGfyy4LzVc4uRx3t7ISboA8AYOpdfdT1FCnxVQbQqv2P3RZkwWMac
         H+NeOAxLamnXM/I/a34QyKenti13yxNkValr1uQMcmnaNp20sKS/ioSRMbRAvOk1hW76
         /TSzJJyZYP/nqLfoaKtg/OlL4/542NyGOO19dSiJeuCQnQ1ulyin7ZUSLZnNOIGUoNQ6
         TAtda9pbby2INveS/KIB4RgUfD+2ct+6z1ERxWHK3HzFk/Mh3zJKOibWiKtE9zzL6zK7
         RAVTaXf0LQaBKWBuEgunUJYIBmCcms9buYb7UEKjZR3pNESOe8FIPXJr13uljr+2ZMQL
         jDsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B48DbFikVh/bS2F8k2Dni+JlTT8Ha8+Qs1c6d58TaXk=;
        b=CM+JxRPlOWGU0dTwWdhRmuDlw3BylV9dzTgp3PZdkzNC3oMRAVdLUdCXbABGiUhunL
         FM5aF8iDfQNhb1aFIsnPtvVTS5dDF/cLxbN97RCd8SdzhCMypT8US+jqfgLyrr2gdu+T
         aKBJpOTv1yrstdy9zK5agA7nLHB8RaSLByRpOlbjwd+opzQek9yQCU5tRUiN5/5Mej6Y
         Ax2182PCytkEo3ORzBqEEHy7W6NYz008cx32xrqmh25guVrqUJNF6mSoz3ECgXsDsWDW
         w7QFzoCvGPniF37WZ43qGQWy91uIEYdqTO9oJf/+SGM7Xw0ItpRCK6EQqmX8P3/NZv7g
         2Jrw==
X-Gm-Message-State: APjAAAW/Dc8R+R66SEDlEhzMQ68CHSzeTyAgTnC41ca2X7Z5wFlZ3Cfm
        wze2yZxlzoH0Y32EPZ/LYNRDYEyvKAPNMICYRD4=
X-Google-Smtp-Source: APXvYqzC+3Zfmde40EF68hc14aYKDTEzbNWBHLv5tF2zFHJFSGiEzh+Yy5q+EBn4D745r2o0X2wKAh5PJcIGc6fSQGw=
X-Received: by 2002:adf:e889:: with SMTP id d9mr11646366wrm.162.1553962285168;
 Sat, 30 Mar 2019 09:11:25 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000d462bb0585171f84@google.com>
In-Reply-To: <000000000000d462bb0585171f84@google.com>
From:   Xin Long <lucien.xin@gmail.com>
Date:   Sun, 31 Mar 2019 00:11:13 +0800
Message-ID: <CADvbK_dY0-LcHFe1+Hdv=410Dnn=C5qmS9va3tXHybtug-9yXQ@mail.gmail.com>
Subject: Re: KMSAN: uninit-value in tipc_nl_compat_link_set (3)
To:     syzbot <syzbot+de00a87b8644a582ae79@syzkaller.appspotmail.com>
Cc:     davem <davem@davemloft.net>,
        Alexander Potapenko <glider@google.com>,
        Jon Maloy <jon.maloy@ericsson.com>,
        LKML <linux-kernel@vger.kernel.org>,
        network dev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        tipc-discussion@lists.sourceforge.net,
        Ying Xue <ying.xue@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 1:54 AM syzbot
<syzbot+de00a87b8644a582ae79@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    c530a275 kmsan: call vmap hooks from vmalloc and ioremap f..
> git tree:       kmsan
> console output: https://syzkaller.appspot.com/x/log.txt?x=13bd4733200000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a5675814e8eae69e
> dashboard link: https://syzkaller.appspot.com/bug?extid=de00a87b8644a582ae79
> compiler:       clang version 8.0.0 (trunk 350509)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12c534d7200000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10f9e733200000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+de00a87b8644a582ae79@syzkaller.appspotmail.com
>
> ==================================================================
> BUG: KMSAN: uninit-value in memchr+0xce/0x110 lib/string.c:961
> CPU: 1 PID: 10538 Comm: syz-executor101 Not tainted 5.0.0+ #12
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>   __dump_stack lib/dump_stack.c:77 [inline]
>   dump_stack+0x173/0x1d0 lib/dump_stack.c:113
>   kmsan_report+0x12e/0x2a0 mm/kmsan/kmsan.c:600
>   __msan_warning+0x82/0xf0 mm/kmsan/kmsan_instr.c:313
>   memchr+0xce/0x110 lib/string.c:961
>   string_is_valid net/tipc/netlink_compat.c:176 [inline]
>   tipc_nl_compat_link_set+0x121/0x1550 net/tipc/netlink_compat.c:770
@@ -766,8 +775,10 @@ static int tipc_nl_compat_link_set(struct
tipc_nl_compat_cmd_doit *cmd,

        lc = (struct tipc_link_config *)TLV_DATA(msg->req);

-       len = min_t(int, TLV_GET_DATA_LEN(msg->req), TIPC_MAX_LINK_NAME);
-       if (!string_is_valid(lc->name, len))
+       len = TLV_GET_DATA_LEN(msg->req) -
+             offsetof(struct tipc_link_config, name);
+       if (len <= 0 ||
+           !string_is_valid(lc->name, min_t(int, len, TIPC_MAX_BEARER_NAME)))
                return -EINVAL;

>   __tipc_nl_compat_doit net/tipc/netlink_compat.c:321 [inline]
>   tipc_nl_compat_doit+0x3aa/0xaf0 net/tipc/netlink_compat.c:354
>   tipc_nl_compat_handle net/tipc/netlink_compat.c:1162 [inline]
>   tipc_nl_compat_recv+0x1ae7/0x2750 net/tipc/netlink_compat.c:1265
>   genl_family_rcv_msg net/netlink/genetlink.c:601 [inline]
>   genl_rcv_msg+0x185f/0x1a60 net/netlink/genetlink.c:626
>   netlink_rcv_skb+0x431/0x620 net/netlink/af_netlink.c:2477
>   genl_rcv+0x63/0x80 net/netlink/genetlink.c:637
>   netlink_unicast_kernel net/netlink/af_netlink.c:1310 [inline]
>   netlink_unicast+0xf3e/0x1020 net/netlink/af_netlink.c:1336
>   netlink_sendmsg+0x127f/0x1300 net/netlink/af_netlink.c:1917
>   sock_sendmsg_nosec net/socket.c:622 [inline]
>   sock_sendmsg net/socket.c:632 [inline]
>   ___sys_sendmsg+0xdb9/0x11b0 net/socket.c:2115
>   __sys_sendmsg net/socket.c:2153 [inline]
>   __do_sys_sendmsg net/socket.c:2162 [inline]
>   __se_sys_sendmsg+0x305/0x460 net/socket.c:2160
>   __x64_sys_sendmsg+0x4a/0x70 net/socket.c:2160
>   do_syscall_64+0xbc/0xf0 arch/x86/entry/common.c:291
>   entry_SYSCALL_64_after_hwframe+0x63/0xe7
> RIP: 0033:0x440259
> Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7
> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff
> ff 0f 83 fb 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007ffcb435a248 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 0000000000440259
> RDX: 0000000000000000 RSI: 00000000200000c0 RDI: 0000000000000003
> RBP: 00000000006ca018 R08: 0000000000000000 R09: 00000000004002c8
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000401ae0
> R13: 0000000000401b70 R14: 0000000000000000 R15: 0000000000000000
>
> Uninit was created at:
>   kmsan_save_stack_with_flags mm/kmsan/kmsan.c:205 [inline]
>   kmsan_internal_poison_shadow+0x92/0x150 mm/kmsan/kmsan.c:159
>   kmsan_kmalloc+0xa6/0x130 mm/kmsan/kmsan_hooks.c:176
>   kmsan_slab_alloc+0xe/0x10 mm/kmsan/kmsan_hooks.c:185
>   slab_post_alloc_hook mm/slab.h:445 [inline]
>   slab_alloc_node mm/slub.c:2773 [inline]
>   __kmalloc_node_track_caller+0xe9e/0xff0 mm/slub.c:4398
>   __kmalloc_reserve net/core/skbuff.c:140 [inline]
>   __alloc_skb+0x309/0xa20 net/core/skbuff.c:208
>   alloc_skb include/linux/skbuff.h:1012 [inline]
>   netlink_alloc_large_skb net/netlink/af_netlink.c:1182 [inline]
>   netlink_sendmsg+0xb82/0x1300 net/netlink/af_netlink.c:1892
>   sock_sendmsg_nosec net/socket.c:622 [inline]
>   sock_sendmsg net/socket.c:632 [inline]
>   ___sys_sendmsg+0xdb9/0x11b0 net/socket.c:2115
>   __sys_sendmsg net/socket.c:2153 [inline]
>   __do_sys_sendmsg net/socket.c:2162 [inline]
>   __se_sys_sendmsg+0x305/0x460 net/socket.c:2160
>   __x64_sys_sendmsg+0x4a/0x70 net/socket.c:2160
>   do_syscall_64+0xbc/0xf0 arch/x86/entry/common.c:291
>   entry_SYSCALL_64_after_hwframe+0x63/0xe7
> ==================================================================
>
>
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> syzbot can test patches for this bug, for details see:
> https://goo.gl/tpsmEJ#testing-patches
