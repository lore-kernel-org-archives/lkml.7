Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C4E2C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 14:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C95CC2183F
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 14:18:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K8bfn1rO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730911AbfC3OSq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 10:18:46 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51909 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730838AbfC3OSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 10:18:45 -0400
Received: by mail-wm1-f66.google.com with SMTP id 4so5410664wmf.1;
        Sat, 30 Mar 2019 07:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=46wkvm0w5QxqlVYof1WHt4ADpelrKMDMx5zOPv8wNxk=;
        b=K8bfn1rO3MaJLqejsWAwv0YGYA7F3ebPmKxOMAHptXXij3D/TZar+YqBWHELV28Z+w
         IFmQyGZz7OEsX1UkBO37+olpmYe/y0f0wEuZAB97JjE++l9S4/NNrQONTrZBbfrpLlWy
         Yo4PZsNVEF1jw3QcwqgtB3M6lQH00fo51aCur40RC4aOH33elzxizUJI4h9QVDRY0IbK
         RtcjDPtctM8Nr5XGDpWw6zBjHywudoWbSCLcoAU6vHsN9muimk46FH8uRvcGmeVY1fSh
         sHDZh9NymZfypuqXmikYsL3vgAuJ5XjkTQIJ8WUMOltGJtmVxiZcaI00X5c6mnW2dhLU
         J6Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=46wkvm0w5QxqlVYof1WHt4ADpelrKMDMx5zOPv8wNxk=;
        b=TWj+yU0u0wONkhcBJoBssvXloDLGLpm7HLoR/OtE2t7kJOHWDQKSFDUZi9RdY5wCks
         vs0oPSkxZLpUrsirtXb+n1guasxyvneVu3k3S31lqx8oTbRkS8VBeU+15K+z6/KPz8sV
         HlZKJ641EVR30RGvQ51Td1amkdXRk8EVYcfJFsEBnjoNZxGrIy8Bf9mxsFhrxtR94o56
         bYPWh1ZvuWAfeex31gxf2b6FLccfy3kC3kD7Ze+emdKcO6j9LfyQ71KKZw1ewGsEh73P
         LTQjx77VGBCK46plwJPKUyp3CPkLxWByN4P9VrdgE0kdHkiLE3j9k8wSC/F+XVq4Klc5
         TTqw==
X-Gm-Message-State: APjAAAVDgGRksFh3N/tKwY2qUtxRDWoHrDPl05We5RaOneWJGCimnTEu
        h0VVYqej3z4rwkINZpLrp8QFFHz8koZ2X9ebAfo=
X-Google-Smtp-Source: APXvYqzN17hDQf0Q2OFsteCv0+4GfSx91BujUEMNw3r5Ugp5mqhxGHq7RPJoFGD77wyMU8adcpsy16amK9Pvs4e0iJ4=
X-Received: by 2002:a1c:c401:: with SMTP id u1mr6622777wmf.129.1553955523267;
 Sat, 30 Mar 2019 07:18:43 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000cfda050585171f3b@google.com>
In-Reply-To: <000000000000cfda050585171f3b@google.com>
From:   Xin Long <lucien.xin@gmail.com>
Date:   Sat, 30 Mar 2019 22:18:32 +0800
Message-ID: <CADvbK_d47Ac6VqRiCoHE4xi0OfGHiSKoyVEZ9AXgVtAS8ObTQg@mail.gmail.com>
Subject: Re: KMSAN: uninit-value in tipc_nl_compat_bearer_enable (2)
To:     syzbot <syzbot+8b707430713eb46e1e45@syzkaller.appspotmail.com>
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

On Thu, Mar 28, 2019 at 1:55 AM syzbot
<syzbot+8b707430713eb46e1e45@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    9536b452 kmsan: uaccess.h: fix variable name conflicts
> git tree:       kmsan
> console output: https://syzkaller.appspot.com/x/log.txt?x=15f5d583200000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a5675814e8eae69e
> dashboard link: https://syzkaller.appspot.com/bug?extid=8b707430713eb46e1e45
> compiler:       clang version 8.0.0 (trunk 350509)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16438e1b200000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16898cd7200000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+8b707430713eb46e1e45@syzkaller.appspotmail.com
>
> ==================================================================
> BUG: KMSAN: uninit-value in memchr+0xce/0x110 lib/string.c:961
> CPU: 0 PID: 10526 Comm: syz-executor961 Not tainted 5.0.0+ #13
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>   __dump_stack lib/dump_stack.c:77 [inline]
>   dump_stack+0x173/0x1d0 lib/dump_stack.c:113
>   kmsan_report+0x12e/0x2a0 mm/kmsan/kmsan.c:600
>   __msan_warning+0x82/0xf0 mm/kmsan/kmsan_instr.c:313
>   memchr+0xce/0x110 lib/string.c:961
>   string_is_valid net/tipc/netlink_compat.c:176 [inline]
>   tipc_nl_compat_bearer_enable+0x2c4/0x910 net/tipc/netlink_compat.c:401
It's using the wrong length to check if b->name is valid when
b->name size < TIPC_MAX_BEARER_NAME. The right count
should start from tipc_bearer_config->name.

diff --git a/net/tipc/netlink_compat.c b/net/tipc/netlink_compat.c
index 4ad3586..895f368 100644
--- a/net/tipc/netlink_compat.c
+++ b/net/tipc/netlink_compat.c
@@ -397,7 +397,9 @@ static int tipc_nl_compat_bearer_enable(struct
tipc_nl_compat_cmd_doit *cmd,
        if (!bearer)
                return -EMSGSIZE;

-       len = min_t(int, TLV_GET_DATA_LEN(msg->req), TIPC_MAX_BEARER_NAME);
+       len = TLV_GET_DATA_LEN(msg->req);
+       len -= offsetof(struct tipc_bearer_config, name);
+       len = min_t(int, len, TIPC_MAX_BEARER_NAME);
        if (!string_is_valid(b->name, len))
                return -EINVAL;

The simliar thing should be done in:
tipc_nl_compat_media_set()
tipc_nl_compat_bearer_set()
tipc_nl_compat_link_set()

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
> RIP: 0033:0x440209
> Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7
> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff
> ff 0f 83 fb 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007ffc77bfd0a8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 0000000000440209
> RDX: 0000000000000000 RSI: 0000000020000140 RDI: 0000000000000003
> RBP: 00000000006ca018 R08: 0000000000000000 R09: 00000000004002c8
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000401a90
> R13: 0000000000401b20 R14: 0000000000000000 R15: 0000000000000000
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
