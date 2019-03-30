Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BCD7C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 15:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2D93218A6
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 15:35:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u3o7DZZb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730882AbfC3PfZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 11:35:25 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36585 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730576AbfC3PfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 11:35:25 -0400
Received: by mail-wm1-f67.google.com with SMTP id h18so6166087wml.1;
        Sat, 30 Mar 2019 08:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zIVvvNksvDTQoqbLqDaGPx147jDcH43JaZs+AJ97nwQ=;
        b=u3o7DZZbwYROVYB4UBFyHQyXA0Obsj8OAGSUGu7cST8fKVQV7WxheZZPtohdRQ1E2H
         Fk3vcdjJ3H4r2VznzbXY/1vJn5EAHVIr/Qqp1CVhxvb3hijV23amAPS8K9aItlxeqWyp
         m97Qh5akBDbl3ekhFvXooASCHdlDGZeLYgiFzaYdfHB830tF2pa1WimeDzO9P/KcquIQ
         Plm+CF1p2i+JHZRTsaOaBz7Nq+5z0Wz3BrL1AFq26TRQzGZe30rCfe7H2XIlgps6k5X5
         4g8OSWGy8+4o4JVRwwupcVxc+0K8t+i6t9hs0s+v691an59OmIiPgwfEFeL1ftOlfYeP
         tbrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zIVvvNksvDTQoqbLqDaGPx147jDcH43JaZs+AJ97nwQ=;
        b=QWkLhHbDgp/Zx0O2TzdS/l6DINxc7kVtccqWbTKXXgKXSpb5J7dZ9YAv6+FzuUtNqP
         KEgrY2ObHtw0LMpEn97532x59JieP2m8mfXoBRpgd4f3klvbgJj0iqG+DJHAIjdptjTm
         /FMk9gmb8i8HrwH96Cejaz/LIw4tjD5Qs7aCDXky72MuUJoJx5YtAt+E/lw7C7XQmp9c
         ewcOl+6yNYtdo93LNbl8Id6DvWDx+Ome0dwNRH+6/dG2JwlIxrbriJsH9GauKjNTyDU7
         Z5TzwrFovVdYWKKy6IFcDT3rl073kevLmhNL1ey1UA14LskSivTtSMROgCp7AwFqrDfB
         pKiA==
X-Gm-Message-State: APjAAAX/ZQA7SsWhmMoAQXsNZ4QMNRFrgT/Y93NUQsfcwD/0oFFUJ3bq
        l1dhS6MFvCEnGyekOANi3fo9tBHDddrhwqz8gFQ=
X-Google-Smtp-Source: APXvYqxCAGADIhXf1z0hL18uJLz3K7g2xtKMSex0fnQbv3Tv4pLYtl3tvGgXyB87GTZT6ExkkeYdAM34FFjPtYgkYns=
X-Received: by 2002:a05:600c:2293:: with SMTP id 19mr6887390wmf.77.1553960123081;
 Sat, 30 Mar 2019 08:35:23 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000003cca5a058529ffe6@google.com>
In-Reply-To: <0000000000003cca5a058529ffe6@google.com>
From:   Xin Long <lucien.xin@gmail.com>
Date:   Sat, 30 Mar 2019 23:35:11 +0800
Message-ID: <CADvbK_cny3bo-=QYwLNYuHGPdtzCLEM2BoOJrS3YXx_Vdweo2g@mail.gmail.com>
Subject: Re: KMSAN: uninit-value in tipc_nl_compat_name_table_dump (2)
To:     syzbot <syzbot+3ce8520484b0d4e260a5@syzkaller.appspotmail.com>
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

On Fri, Mar 29, 2019 at 12:26 AM syzbot
<syzbot+3ce8520484b0d4e260a5@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    a695dc5e kmsan: fixup mm/sl[au]b.[ch] after rebase
> git tree:       kmsan
> console output: https://syzkaller.appspot.com/x/log.txt?x=1683e04d200000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a5675814e8eae69e
> dashboard link: https://syzkaller.appspot.com/bug?extid=3ce8520484b0d4e260a5
> compiler:       clang version 8.0.0 (trunk 350509)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15bdf95f200000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11b5a4cf200000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+3ce8520484b0d4e260a5@syzkaller.appspotmail.com
>
> sshd (11234) used greatest stack depth: 54160 bytes left
> ==================================================================
> BUG: KMSAN: uninit-value in __arch_swab32
> arch/x86/include/uapi/asm/swab.h:10 [inline]
> BUG: KMSAN: uninit-value in __fswab32 include/uapi/linux/swab.h:59 [inline]
> BUG: KMSAN: uninit-value in tipc_nl_compat_name_table_dump+0x54f/0xcd0
> net/tipc/netlink_compat.c:872
> CPU: 1 PID: 11248 Comm: syz-executor646 Not tainted 5.0.0+ #11
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>   __dump_stack lib/dump_stack.c:77 [inline]
>   dump_stack+0x173/0x1d0 lib/dump_stack.c:113
>   kmsan_report+0x12e/0x2a0 mm/kmsan/kmsan.c:600
>   __msan_warning+0x82/0xf0 mm/kmsan/kmsan_instr.c:313
>   __arch_swab32 arch/x86/include/uapi/asm/swab.h:10 [inline]
>   __fswab32 include/uapi/linux/swab.h:59 [inline]
>   tipc_nl_compat_name_table_dump+0x54f/0xcd0 net/tipc/netlink_compat.c:872
commit 974cb0e3e7c963ced06c4e32c5b2884173fa5e01
Author: Ying Xue <ying.xue@windriver.com>
Date:   Mon Jan 14 17:22:28 2019 +0800

    tipc: fix uninit-value in tipc_nl_compat_name_table_dump

This patch tried to fix it in tipc_nl_compat_name_table_dump_header().
But it forgot to handler the err returned from cmd->header():

diff --git a/net/tipc/netlink_compat.c b/net/tipc/netlink_compat.c
index 4ad3586..25bc39b 100644
--- a/net/tipc/netlink_compat.c
+++ b/net/tipc/netlink_compat.c
@@ -267,8 +267,14 @@ static int tipc_nl_compat_dumpit(struct
tipc_nl_compat_cmd_dump *cmd,
        if (msg->rep_type)
                tipc_tlv_init(msg->rep, msg->rep_type);

-       if (cmd->header)
-               (*cmd->header)(msg);
+       if (cmd->header) {
+               err = (*cmd->header)(msg);
+               if (err) {
+                       kfree_skb(msg->rep);
+                       msg->rep = NULL;
+                       return err;
+               }
+       }

>   __tipc_nl_compat_dumpit+0x59e/0xda0 net/tipc/netlink_compat.c:215
>   tipc_nl_compat_dumpit+0x63a/0x820 net/tipc/netlink_compat.c:280
>   tipc_nl_compat_handle net/tipc/netlink_compat.c:1226 [inline]
>   tipc_nl_compat_recv+0x1b5f/0x2750 net/tipc/netlink_compat.c:1265
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
> RIP: 0033:0x444069
> Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7
> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff
> ff 0f 83 1b d8 fb ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007ffda17b3718 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 00000000004002e0 RCX: 0000000000444069
> RDX: 0000000000000000 RSI: 00000000200001c0 RDI: 0000000000000003
> RBP: 00000000006ce018 R08: 0000000000000000 R09: 00000000004002e0
> R10: 0000000000001900 R11: 0000000000000246 R12: 0000000000401d10
> R13: 0000000000401da0 R14: 0000000000000000 R15: 0000000000000000
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
