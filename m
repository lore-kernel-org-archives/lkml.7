Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A0EDC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 17:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB29B20643
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 17:54:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jVgHsyJV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730794AbfCERye (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 12:54:34 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46289 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730776AbfCERyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 12:54:33 -0500
Received: by mail-pf1-f194.google.com with SMTP id g6so6256563pfh.13;
        Tue, 05 Mar 2019 09:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=8F1FmymjK0Tf2LUay5y+wZDuLQaa/D1etQXxlPvv9rQ=;
        b=jVgHsyJVLXt3X9cukSYMxYlyfxbhiDRzzy8qMNVxlqOEmvBEP8prKFvP02megTcUh4
         rxOfG8Dze7+ni3pTOcStQ++Tq3U0YyhFRUePXZoJLPbuE/NDpwXBExMqpxw8RCEq0Cs3
         kkpa0oFeaE3UF+Xxkygq6nbrwepKaFoRbj2cvXe2uxbKUAPl4uVIuII/Y0nqwMAI6EEd
         TR1Qxn/5mIuyFPtUPLhKmDGpzD/s45W5PUElD5k1yvDw9c5JyRCPcveynu7Ez0t+yz2S
         LTjheegP3atunA+HS0AmP8wjT3GR/po4Jur0rFaLPu5BuHG6Ow60hVkrvUuYl9Pxb9Lg
         r8Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8F1FmymjK0Tf2LUay5y+wZDuLQaa/D1etQXxlPvv9rQ=;
        b=T0SnAOnI4zXuD67XFKogQaF8m18cxjT3pnrXSvd9H1Ki73F7GucdC9BPoLIOCDCcBW
         nzeUu7GkUYrqs2/O049ZBdMsu42a6VaAwD2woJ2XWyuhygTiW+prV40XmESQkOmXX6QJ
         L53UVNJmqwGaAEsfVMfnIWcae0+RcttV7tlFFk5PkEB5+hz8IbKSBrq2P3e6ULBjmzk7
         kRkRAarcPl+imZ9OgZg9eKrYqW8vzi6D9YEJfhYnfJDBCuNCAwaD7JSlw9gEn430IBjb
         c9E84DhMa+tAadT557rJlBKV5v0xCxjALVESR/rRxIQzdIQE5MnoR0KcMdsbTQi7dvIQ
         69Gg==
X-Gm-Message-State: APjAAAVathMD7b42aqcscOQ6vC6VRH3Qfuuk8G7TaoeueNtatVnqGfD2
        dEaWaucYRVfIATvEI+6Sg1Q=
X-Google-Smtp-Source: APXvYqwVfbGAJ6cz7gw7IZkD74fSCmi+ztM62cGLFIryMtkSC4qQOvvPZ7G3kOwQ+0esTA+n8MO1rg==
X-Received: by 2002:a63:4509:: with SMTP id s9mr2439039pga.420.1551808472332;
        Tue, 05 Mar 2019 09:54:32 -0800 (PST)
Received: from ?IPv6:2620:15c:2c1:200:55c7:81e6:c7d8:94b? ([2620:15c:2c1:200:55c7:81e6:c7d8:94b])
        by smtp.gmail.com with ESMTPSA id g69sm24431520pfd.168.2019.03.05.09.54.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2019 09:54:31 -0800 (PST)
Subject: Re: kernel BUG at include/linux/mm.h:LINE! (5)
To:     syzbot <syzbot+5013d47539cdd43e7098@syzkaller.appspotmail.com>,
        ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
        davem@davemloft.net, edumazet@google.com, kafai@fb.com,
        kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, yhs@fb.com,
        Boris Pismenny <borisp@mellanox.com>,
        Aviad Yehezkel <aviadye@mellanox.com>,
        Dave Watson <davejwatson@fb.com>,
        John Fastabend <john.fastabend@gmail.com>
References: <00000000000054cc6d05834c33d7@google.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <9da74ea0-6f41-48e2-6dc8-91e75783839c@gmail.com>
Date:   Tue, 5 Mar 2019 09:54:30 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <00000000000054cc6d05834c33d7@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/04/2019 02:23 PM, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    9e9322e5d28e selftest/net: Remove duplicate header
> git tree:       net-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=13516233200000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=47f2db597668ac40
> dashboard link: https://syzkaller.appspot.com/bug?extid=5013d47539cdd43e7098
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=148763eb200000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1416ff3d200000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+5013d47539cdd43e7098@syzkaller.appspotmail.com
> 
> flags: 0x1fffc0000000000()
> raw: 01fffc0000000000 ffffea00025f6208 ffff88812fffc878 0000000000000000
> raw: 0000000000000000 0000000000000003 00000000ffffff7f 0000000000000000
> page dumped because: VM_BUG_ON_PAGE(page_ref_count(page) == 0)
> ------------[ cut here ]------------
> kernel BUG at include/linux/mm.h:546!
> invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> CPU: 0 PID: 7872 Comm: syz-executor445 Not tainted 5.0.0-rc7+ #95
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:put_page_testzero include/linux/mm.h:546 [inline]
> RIP: 0010:put_page include/linux/mm.h:992 [inline]
> RIP: 0010:__skb_frag_unref include/linux/skbuff.h:2837 [inline]
> RIP: 0010:skb_release_data+0x5a5/0x7b0 net/core/skbuff.c:571
> Code: f0 fe ff e9 b6 fb ff ff e8 38 b9 01 fc 4c 8d 63 ff e9 c8 fc ff ff e8 2a b9 01 fc 48 c7 c6 80 c2 fe 87 4c 89 e7 e8 bb c6 2a fc <0f> 0b e8 14 b9 01 fc 4d 8d 66 0e 48 b8 00 00 00 00 00 fc ff df 4c
> RSP: 0018:ffff888086a0f708 EFLAGS: 00010293
> RAX: ffff8880a3590440 RBX: ffffea00025dfa34 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: ffffffff81990662 RDI: ffffea00025dfa38
> RBP: ffff888086a0f770 R08: 000000000000003e R09: ffffed1015d03ef9
> R10: ffffed1015d03ef8 R11: ffff8880ae81f7c7 R12: ffffea00025dfa00
> R13: ffff8880a4398c40 R14: 0000000000000001 R15: dffffc0000000000
> FS:  00007fba67236700(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fba67235e78 CR3: 0000000099c9f000 CR4: 00000000001406f0
> Call Trace:
>  skb_release_all+0x4d/0x60 net/core/skbuff.c:631
>  __kfree_skb+0x16/0x30 net/core/skbuff.c:645
>  sk_wmem_free_skb include/net/sock.h:1463 [inline]
>  tcp_write_queue_purge+0x253/0x7d0 net/ipv4/tcp.c:2543
>  tcp_disconnect+0x402/0x1890 net/ipv4/tcp.c:2583
>  tcp_close+0xe37/0x10c0 net/ipv4/tcp.c:2384
>  tls_sk_proto_close+0x40d/0x7a0 net/tls/tls_main.c:291
>  inet_release+0x105/0x1f0 net/ipv4/af_inet.c:428
>  inet6_release+0x53/0x80 net/ipv6/af_inet6.c:473
>  __sock_release+0xd3/0x2b0 net/socket.c:579
>  sock_close+0x1b/0x30 net/socket.c:1162
>  __fput+0x2df/0x8d0 fs/file_table.c:278
>  ____fput+0x16/0x20 fs/file_table.c:309
>  task_work_run+0x14a/0x1c0 kernel/task_work.c:113
>  exit_task_work include/linux/task_work.h:22 [inline]
>  do_exit+0x92c/0x2fd0 kernel/exit.c:875
>  do_group_exit+0x135/0x370 kernel/exit.c:979
>  get_signal+0x399/0x1d50 kernel/signal.c:2575
>  do_signal+0x87/0x1940 arch/x86/kernel/signal.c:816
>  exit_to_usermode_loop+0x244/0x2c0 arch/x86/entry/common.c:162
>  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
>  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
>  do_syscall_64+0x52d/0x610 arch/x86/entry/common.c:293
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x447589
> Code: 6e 4d 6f 64 65 00 69 43 75 72 72 4f 66 66 73 00 69 4d 61 78 46 69 6c 65 53 69 7a 65 00 69 4d 61 78 46 69 6c 65 73 00 69 46 69 <6c> 65 4e 75 6d 44 69 67 69 74 73 00 62 44 65 6c 65 74 65 4f 6e 43
> RSP: 002b:00007fba67235d98 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
> RAX: fffffffffffffe00 RBX: 00000000006ddc68 RCX: 0000000000447589
> RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00000000006ddc68
> RBP: 00000000006ddc60 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006ddc6c
> R13: 0030656c69662f2e R14: 0000000000000000 R15: 0000000000000000
> Modules linked in:
> ---[ end trace 3c84b12f07d7d40a ]---
> RIP: 0010:put_page_testzero include/linux/mm.h:546 [inline]
> RIP: 0010:put_page include/linux/mm.h:992 [inline]
> RIP: 0010:__skb_frag_unref include/linux/skbuff.h:2837 [inline]
> RIP: 0010:skb_release_data+0x5a5/0x7b0 net/core/skbuff.c:571
> Code: f0 fe ff e9 b6 fb ff ff e8 38 b9 01 fc 4c 8d 63 ff e9 c8 fc ff ff e8 2a b9 01 fc 48 c7 c6 80 c2 fe 87 4c 89 e7 e8 bb c6 2a fc <0f> 0b e8 14 b9 01 fc 4d 8d 66 0e 48 b8 00 00 00 00 00 fc ff df 4c
> RSP: 0018:ffff888086a0f708 EFLAGS: 00010293
> RAX: ffff8880a3590440 RBX: ffffea00025dfa34 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: ffffffff81990662 RDI: ffffea00025dfa38
> RBP: ffff888086a0f770 R08: 000000000000003e R09: ffffed1015d03ef9
> R10: ffffed1015d03ef8 R11: ffff8880ae81f7c7 R12: ffffea00025dfa00
> R13: ffff8880a4398c40 R14: 0000000000000001 R15: dffffc0000000000
> FS:  00007fba67236700(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fba67235e78 CR3: 0000000099c9f000 CR4: 00000000001406f0
> 
> 
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with syzbot.
> syzbot can test patches for this bug, for details see:
> https://goo.gl/tpsmEJ#testing-patches

This looks like a TLS issue to me ?

There is a C repro on this bug report (  https://syzkaller.appspot.com/x/repro.c?x=1416ff3d200000 )


