Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E72C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 10:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A9B120684
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 10:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lZU9csRJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729604AbfCFKoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 05:44:04 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35222 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbfCFKoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 05:44:03 -0500
Received: by mail-wm1-f65.google.com with SMTP id y15so5421549wma.0;
        Wed, 06 Mar 2019 02:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i8T3mD8h2P+pNsSZDN7aVSuLfGuHznIr8wZq5vwvtTc=;
        b=lZU9csRJD8c0BtN/JKN2hbLvWUPC/M3EJK47ro9RZaWgwhpqVaHfemrhui+H155qzB
         hOTU4GKiExz79wlgZ4cpPyuX4GVw1qM8daMD7PDtShy7aECaZywm03CfaieuewluWrJ8
         nEoUEincQqF18owKlbpSrRwCLVNPYurqC1qsYRVGECjq/4EWc3ubsz3QdK2Y3HIIp+AP
         QCNjV/8WMqA5x8ZHFjslGPjMNgednD0Snpgi/W8t9q9DKqgohsWePiJXQ1thJqSPzKex
         qp2u64oAJMqzp7r419+53d0pBKv5keG/VD6eAc/abNFCUYAK91FJMYUkjVzM2QlLPD/f
         AB1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i8T3mD8h2P+pNsSZDN7aVSuLfGuHznIr8wZq5vwvtTc=;
        b=Yd5Hlnb92yCnD87YxWpZtanUFm1kBCtofxEwYnHUtQikypMd8X8xx9kpg4C5uOYogK
         g9SnCGvNIrUvEj90Z64FcND17GezTMLRAbKxtRbN65LCsTP/V2JxJ7qMEGqq3g/Ys9p3
         xZ4raBI2qAJR8Da38IwJB/+vWOaN+sShMlF9OGaGCA32xW6HDqeM6vtoUCdOyW5QmXXG
         Tpw1w4mX69TRFeZHK95MKfSfEWEze+fwHuNWdDnSZPehMY8lUdUhhn9lnPIaWJwxiSmH
         Et+Ri3X08o09fs394h77nwugT0H4E+xir3ngqpKyKSZ+28rOc+GNpE8ef+bpOIk+/iFf
         qOiQ==
X-Gm-Message-State: APjAAAXtLLV20ImXw0CY2eL1EVm3GhpsU8Aoncyc+mLZOWl/sm1S3EJM
        8eSDLwqasEotmIegviW5hA5/5+XVaUU1RzccwZw=
X-Google-Smtp-Source: APXvYqz1zU9Rb2X9P4QLtAVA4yBqT5BlSGyEtpkjVOuRuNE2RvZD/bECcUX9XrrWpkRY1rvYxEWH2TqD0U2mLn4yvp8=
X-Received: by 2002:a1c:9ed5:: with SMTP id h204mr1946537wme.140.1551869040208;
 Wed, 06 Mar 2019 02:44:00 -0800 (PST)
MIME-Version: 1.0
References: <000000000000cc734405836318dc@google.com>
In-Reply-To: <000000000000cc734405836318dc@google.com>
From:   Xin Long <lucien.xin@gmail.com>
Date:   Wed, 6 Mar 2019 18:43:48 +0800
Message-ID: <CADvbK_fJ8R0WmQaFcz0sOhL_AXH3AdO2zLeqMD38X22izEAMNg@mail.gmail.com>
Subject: Re: general protection fault in sctp_sched_rr_dequeue
To:     syzbot <syzbot+4c9934f20522c0efd657@syzkaller.appspotmail.com>
Cc:     davem <davem@davemloft.net>, LKML <linux-kernel@vger.kernel.org>,
        linux-sctp@vger.kernel.org,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        network dev <netdev@vger.kernel.org>,
        Neil Horman <nhorman@tuxdriver.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Vlad Yasevich <vyasevich@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 6, 2019 at 9:42 AM syzbot
<syzbot+4c9934f20522c0efd657@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    63bdf4284c38 Merge branch 'linus' of git://git.kernel.org/..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=100347cb200000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=872be05707464aaa
> dashboard link: https://syzkaller.appspot.com/bug?extid=4c9934f20522c0efd657
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11cd9b03200000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=127de8e7200000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+4c9934f20522c0efd657@syzkaller.appspotmail.com
>
> kauditd_printk_skb: 2 callbacks suppressed
> audit: type=1400 audit(1551833288.424:35): avc:  denied  { map } for
> pid=8035 comm="bash" path="/bin/bash" dev="sda1" ino=1457
> scontext=unconfined_u:system_r:insmod_t:s0-s0:c0.c1023
> tcontext=system_u:object_r:file_t:s0 tclass=file permissive=1
> audit: type=1400 audit(1551833294.934:36): avc:  denied  { map } for
> pid=8047 comm="syz-executor778" path="/root/syz-executor778173561"
> dev="sda1" ino=16484 scontext=unconfined_u:system_r:insmod_t:s0-s0:c0.c1023
> tcontext=unconfined_u:object_r:user_home_t:s0 tclass=file permissive=1
> kasan: CONFIG_KASAN_INLINE enabled
> kasan: GPF could be caused by NULL-ptr deref or user memory access
> general protection fault: 0000 [#1] PREEMPT SMP KASAN
> CPU: 1 PID: 8047 Comm: syz-executor778 Not tainted 5.0.0+ #7
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> RIP: 0010:sctp_sched_rr_dequeue+0xd3/0x170 net/sctp/stream_sched_rr.c:141
The panic was caused by sched->init() reset stream->rr_next = NULL, even
if outq->out_chunk_list is not empty.

We should remove the sched->init() from sctp_stream_init(), since
all sched info was moved into sout->ext and sctp_stream_alloc_out()
will not afffect it.

> Code: ea 03 80 3c 02 00 0f 85 a2 00 00 00 48 8b 5b 08 e8 62 20 ee fa 48 8d
> 7b 30 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 75
> 53 4c 8b 6b 30 4c 89 e7 49 83 ed 18 4c 89 ee e8 b4
> RSP: 0018:ffff88809eacf040 EFLAGS: 00010206
> RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff8679cd9f
> RDX: 0000000000000006 RSI: ffffffff8681c41e RDI: 0000000000000030
> RBP: ffff88809eacf058 R08: ffff8880a12bc300 R09: 0000000000000002
> R10: ffffed1015d25bcf R11: ffff8880ae92de7b R12: ffff88807cae6ca0
> R13: ffff88807cae6580 R14: dffffc0000000000 R15: ffff88809eacf198
> FS:  0000000001865880(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000055af2d491150 CR3: 000000008dd7b000 CR4: 00000000001406e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   sctp_outq_dequeue_data net/sctp/outqueue.c:90 [inline]
>   sctp_outq_flush_data net/sctp/outqueue.c:1079 [inline]
>   sctp_outq_flush+0xba2/0x2790 net/sctp/outqueue.c:1205
>   sctp_outq_uncork+0x6c/0x80 net/sctp/outqueue.c:772
>   sctp_cmd_interpreter net/sctp/sm_sideeffect.c:1820 [inline]
>   sctp_side_effects net/sctp/sm_sideeffect.c:1220 [inline]
>   sctp_do_sm+0x513/0x5390 net/sctp/sm_sideeffect.c:1191
>   sctp_assoc_bh_rcv+0x343/0x660 net/sctp/associola.c:1074
>   sctp_inq_push+0x1ea/0x290 net/sctp/inqueue.c:95
>   sctp_backlog_rcv+0x189/0xbc0 net/sctp/input.c:354
>   sk_backlog_rcv include/net/sock.h:937 [inline]
>   __release_sock+0x12e/0x3a0 net/core/sock.c:2413
>   release_sock+0x59/0x1c0 net/core/sock.c:2929
>   sctp_wait_for_connect+0x316/0x540 net/sctp/socket.c:8999
>   sctp_sendmsg_to_asoc+0x13e2/0x17d0 net/sctp/socket.c:1968
>   sctp_sendmsg+0x10a9/0x17e0 net/sctp/socket.c:2114
>   inet_sendmsg+0x147/0x5d0 net/ipv4/af_inet.c:798
>   sock_sendmsg_nosec net/socket.c:622 [inline]
>   sock_sendmsg+0xdd/0x130 net/socket.c:632
>   ___sys_sendmsg+0x806/0x930 net/socket.c:2137
>   __sys_sendmsg+0x105/0x1d0 net/socket.c:2175
>   __do_sys_sendmsg net/socket.c:2184 [inline]
>   __se_sys_sendmsg net/socket.c:2182 [inline]
>   __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2182
>   do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x440159
> Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7
> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff
> ff 0f 83 fb 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007fff8801fd38 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 0000000000440159
> RDX: 0000000000000000 RSI: 000000002001afc8 RDI: 0000000000000003
> RBP: 00000000006ca018 R08: 0000000000000002 R09: 00000000004002c8
> R10: 0000000000000008 R11: 0000000000000246 R12: 00000000004019e0
> R13: 0000000000401a70 R14: 0000000000000000 R15: 0000000000000000
> Modules linked in:
> ---[ end trace 7cc5803525726c53 ]---
> RIP: 0010:sctp_sched_rr_dequeue+0xd3/0x170 net/sctp/stream_sched_rr.c:141
> Code: ea 03 80 3c 02 00 0f 85 a2 00 00 00 48 8b 5b 08 e8 62 20 ee fa 48 8d
> 7b 30 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 75
> 53 4c 8b 6b 30 4c 89 e7 49 83 ed 18 4c 89 ee e8 b4
> RSP: 0018:ffff88809eacf040 EFLAGS: 00010206
> RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff8679cd9f
> RDX: 0000000000000006 RSI: ffffffff8681c41e RDI: 0000000000000030
> RBP: ffff88809eacf058 R08: ffff8880a12bc300 R09: 0000000000000002
> R10: ffffed1015d25bcf R11: ffff8880ae92de7b R12: ffff88807cae6ca0
> R13: ffff88807cae6580 R14: dffffc0000000000 R15: ffff88809eacf198
> FS:  0000000001865880(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000055af2d491150 CR3: 000000008dd7b000 CR4: 00000000001406e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>
>
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with
> syzbot.
> syzbot can test patches for this bug, for details see:
> https://goo.gl/tpsmEJ#testing-patches
