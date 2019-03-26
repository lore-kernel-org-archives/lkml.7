Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B702BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 08:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D5BF2084B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 08:35:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gui1H5E3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731149AbfCZIf2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 04:35:28 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:51083 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730625AbfCZIf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 04:35:27 -0400
Received: by mail-it1-f194.google.com with SMTP id m137so18236451ita.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 01:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/ti02XYG/lKudXM1qFwSpA4R201b7rMNqsh8rJiO4+o=;
        b=Gui1H5E3T/mijVChyLfEL455bQgFz2jFmkzGeFej3MybxyucMTFD0gbz8oGw9PdAPT
         UIXADw31dgdKiU5PlehpeJ1rXCF1CV2wykud9/yaMb+OhAdzj0OwqNTvnM1yP81CxLbI
         K1xQMTXpkIQyluN4BboPM4WooVA6uPWolSPNb6VdfmsbjzyCNvAB0yHh3AtDiO9uFltw
         3yJ7igHBWD73QtzqIWyMvuoyw6Bl4dlcp1mQXdjA83J2B1adc1gqmDqcjax78CrPPfSI
         NAAjNjsXbM2x6NQ2f8O042D6QOGJGuqnJ5zbjmyBc7xfNtvnta+Rb0Jf+Wf6D7cuDlQu
         ibEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/ti02XYG/lKudXM1qFwSpA4R201b7rMNqsh8rJiO4+o=;
        b=BspYoDK1Sg7AQ8z7AqBzXjHnlB5fFP6alNnNEtz3G2gI1G57yDL/kwQ6DeoI7GDtHn
         pGtR3F6ihQfYfl9mqR61NI1mpc0Oz+8ZMlHkbH6IRxnVfWY5HoFduamRN/Yuh0t8vwNu
         0ViknPPQr87UCWdIlHGrqzjRLaZUpQRfYA8UKCNCTVQSHDg542noP8DE8MQuSDof39Ka
         RT4QGtEs9rbx+3ob/xCw8o8pYGQbW2JOXT6nFI41DB9JuwCPj4glaUgXRXzWRYaNFpYq
         GVpE8NrUDEfx3MQ8y5I+tBHvzdeDSIL+rfIbZgBpOKVC41ums/s0Pemkmmtf+UopK4bA
         HE+w==
X-Gm-Message-State: APjAAAXUkr8hfmvAig7tkMZZIQlbEh5osA5MIY2hq+8uijos46V1Fqr8
        W80i4qTmapUc7y0hs09NkjQ1E/iGehD9KK43YaOzCA==
X-Google-Smtp-Source: APXvYqzkqddDX7Shy1VQ747VRWPJTk9gDSBw5QHKsrQn9ksGbf0LYJNLk65MqfirU9Is0Qg/v+kwZSTz8v6HtgyVTaw=
X-Received: by 2002:a24:9a86:: with SMTP id l128mr2578827ite.12.1553589325868;
 Tue, 26 Mar 2019 01:35:25 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000003ba80905783e9189@google.com> <0000000000005d37e60584e6db01@google.com>
 <CANn89iJ9SiaFHU7pdjyapGCD330wvH5JKuWLGyLo422tJcO1gA@mail.gmail.com>
In-Reply-To: <CANn89iJ9SiaFHU7pdjyapGCD330wvH5JKuWLGyLo422tJcO1gA@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 26 Mar 2019 09:35:14 +0100
Message-ID: <CACT4Y+ZR5yYsXsnAq_cRke_zSR2Stbg3njno_xGhYLgmDtia8g@mail.gmail.com>
Subject: Re: KASAN: use-after-free Write in skb_release_data (2)
To:     Eric Dumazet <edumazet@google.com>
Cc:     syzbot <syzbot+580be3953ed99133804f@syzkaller.appspotmail.com>,
        Alexander Duyck <alexander.h.duyck@intel.com>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Miller <davem@davemloft.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        LKML <linux-kernel@vger.kernel.org>,
        Li RongQing <lirongqing@baidu.com>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>,
        maximmi@mellanox.com, netdev <netdev@vger.kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        Song Liu <songliubraving@fb.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        vincent.whitchurch@axis.com, Willem de Bruijn <willemb@google.com>,
        Yonghong Song <yhs@fb.com>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 9:36 AM Eric Dumazet <edumazet@google.com> wrote:
>
> On Mon, Mar 25, 2019 at 1:19 AM syzbot
> <syzbot+580be3953ed99133804f@syzkaller.appspotmail.com> wrote:
> >
> > syzbot has bisected this bug to:
> >
> > commit 472c2e07eef045145bc1493cc94a01c87140780a
> > Author: Eric Dumazet <edumazet@google.com>
> > Date:   Fri Mar 22 15:56:39 2019 +0000
> >
> >      tcp: add one skb cache for tx
> >
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17abf52b200000
> > start commit:   68cc2999 Merge branch 'devlink-small-spring-cleanup'
> > git tree:       net-next
> > final crash:    https://syzkaller.appspot.com/x/report.txt?x=146bf52b200000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=106bf52b200000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=9ab5bbbbf283c99a
> > dashboard link: https://syzkaller.appspot.com/bug?extid=580be3953ed99133804f
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=123a3d3b200000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11d34f93200000
> >
> > Reported-by: syzbot+580be3953ed99133804f@syzkaller.appspotmail.com
> > Fixes: 472c2e07eef0 ("tcp: add one skb cache for tx")
> >
> > For information about bisection process see: https://goo.gl/tpsmEJ#bisection
>
> This bisection makes no sense, the original bug report was in in
> October last year.


But the bisection log itself looks legit and seem to point to a legit
bug, right?. If so, let's fix the new bug in the context of this
report. Or the old one. Both. Any.
The more we let hundreds of kernel bugs pile up without attention,
then more of such glued bugs we will unavoidably have...



> This was :
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    e40a826a6cbc qed: Add support for virtual link.
> git tree:       net-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=168954a5400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=7e7e2279c0020d5f
> dashboard link: https://syzkaller.appspot.com/bug?extid=580be3953ed99133804f
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>
> Unfortunately, I don't have any reproducer for this crash yet.
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+580be3953ed99133804f@syzkaller.appspotmail.com
>
> ==================================================================
> BUG: KASAN: use-after-free in atomic_sub_return
> include/asm-generic/atomic-instrumented.h:305 [inline]
> BUG: KASAN: use-after-free in skb_release_data+0x1a3/0x880 net/core/skbuff.c:559
> Write of size 4 at addr ffff8801d8cb4120 by task syz-executor0/8395
>
> CPU: 0 PID: 8395 Comm: syz-executor0 Not tainted 4.19.0-rc6+ #254
> Hardware name: Google Google Compute Engine/Google Compute Engine,
> BIOS Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x1c4/0x2b4 lib/dump_stack.c:113
>  print_address_description.cold.8+0x9/0x1ff mm/kasan/report.c:256
>  kasan_report_error mm/kasan/report.c:354 [inline]
>  kasan_report.cold.9+0x242/0x309 mm/kasan/report.c:412
>  check_memory_region_inline mm/kasan/kasan.c:260 [inline]
>  check_memory_region+0x13e/0x1b0 mm/kasan/kasan.c:267
>  kasan_check_write+0x14/0x20 mm/kasan/kasan.c:278
>  atomic_sub_return include/asm-generic/atomic-instrumented.h:305 [inline]
>  skb_release_data+0x1a3/0x880 net/core/skbuff.c:559
>  skb_release_all+0x4a/0x60 net/core/skbuff.c:627
>  __kfree_skb net/core/skbuff.c:641 [inline]
>  kfree_skb+0x1bb/0x580 net/core/skbuff.c:659
>  sit_tunnel_xmit+0x173/0x30d0 net/ipv6/sit.c:1044
>  __netdev_start_xmit include/linux/netdevice.h:4328 [inline]
>  netdev_start_xmit include/linux/netdevice.h:4337 [inline]
>  xmit_one net/core/dev.c:3219 [inline]
>  dev_hard_start_xmit+0x295/0xc90 net/core/dev.c:3235
>  __dev_queue_xmit+0x2f0d/0x3950 net/core/dev.c:3805
>  dev_queue_xmit+0x17/0x20 net/core/dev.c:3838
>  packet_sendmsg_spkt+0xf44/0x16f0 net/packet/af_packet.c:1975
>  sock_sendmsg_nosec net/socket.c:621 [inline]
>  sock_sendmsg+0xd5/0x120 net/socket.c:631
>  ___sys_sendmsg+0x7fd/0x930 net/socket.c:2116
>  __sys_sendmsg+0x11d/0x280 net/socket.c:2154
>  __do_sys_sendmsg net/socket.c:2163 [inline]
>  __se_sys_sendmsg net/socket.c:2161 [inline]
>  __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2161
>  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x457519
> Code: 1d b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48
> 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
> 01 f0 ff ff 0f 83 eb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007f2a52d30c78 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457519
> RDX: 0000000000000000 RSI: 00000000200003c0 RDI: 0000000000000003
> RBP: 000000000072bf00 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007f2a52d316d4
> R13: 00000000004c34d5 R14: 00000000004d52c8 R15: 00000000ffffffff
>
> Allocated by task 8395:
>  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
>  set_track mm/kasan/kasan.c:460 [inline]
>  kasan_kmalloc+0xc7/0xe0 mm/kasan/kasan.c:553
>  __do_kmalloc_node mm/slab.c:3682 [inline]
>  __kmalloc_node_track_caller+0x47/0x70 mm/slab.c:3696
>  __kmalloc_reserve.isra.39+0x41/0xe0 net/core/skbuff.c:137
>  __alloc_skb+0x155/0x770 net/core/skbuff.c:205
>  alloc_skb include/linux/skbuff.h:997 [inline]
>  sock_wmalloc+0x16d/0x1f0 net/core/sock.c:1934
>  packet_sendmsg_spkt+0x48a/0x16f0 net/packet/af_packet.c:1922
>  sock_sendmsg_nosec net/socket.c:621 [inline]
>  sock_sendmsg+0xd5/0x120 net/socket.c:631
>  ___sys_sendmsg+0x7fd/0x930 net/socket.c:2116
>  __sys_sendmsg+0x11d/0x280 net/socket.c:2154
>  __do_sys_sendmsg net/socket.c:2163 [inline]
>  __se_sys_sendmsg net/socket.c:2161 [inline]
>  __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2161
>  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>
> Freed by task 8395:
>  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
>  set_track mm/kasan/kasan.c:460 [inline]
>  __kasan_slab_free+0x102/0x150 mm/kasan/kasan.c:521
>  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
>  __cache_free mm/slab.c:3498 [inline]
>  kfree+0xcf/0x230 mm/slab.c:3813
>  skb_free_head+0x99/0xc0 net/core/skbuff.c:550
>  skb_release_data+0x6a4/0x880 net/core/skbuff.c:570
>  skb_release_all+0x4a/0x60 net/core/skbuff.c:627
>  __kfree_skb net/core/skbuff.c:641 [inline]
>  consume_skb+0x1ae/0x570 net/core/skbuff.c:701
>  packet_rcv+0x172/0x1820 net/packet/af_packet.c:2139
>  dev_queue_xmit_nit+0x8ae/0xb30 net/core/dev.c:2020
>  xmit_one net/core/dev.c:3215 [inline]
>  dev_hard_start_xmit+0x186/0xc90 net/core/dev.c:3235
>  __dev_queue_xmit+0x2f0d/0x3950 net/core/dev.c:3805
>  dev_queue_xmit+0x17/0x20 net/core/dev.c:3838
>  packet_sendmsg_spkt+0xf44/0x16f0 net/packet/af_packet.c:1975
>  sock_sendmsg_nosec net/socket.c:621 [inline]
>  sock_sendmsg+0xd5/0x120 net/socket.c:631
>  ___sys_sendmsg+0x7fd/0x930 net/socket.c:2116
>  __sys_sendmsg+0x11d/0x280 net/socket.c:2154
>  __do_sys_sendmsg net/socket.c:2163 [inline]
>  __se_sys_sendmsg net/socket.c:2161 [inline]
>  __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2161
>  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>
> The buggy address belongs to the object at ffff8801d8cb4040
>  which belongs to the cache kmalloc-512 of size 512
> The buggy address is located 224 bytes inside of
>  512-byte region [ffff8801d8cb4040, ffff8801d8cb4240)
> The buggy address belongs to the page:
> page:ffffea0007632d00 count:1 mapcount:0 mapping:ffff8801da800940
> index:0xffff8801d8cb42c0
> flags: 0x2fffc0000000100(slab)
> raw: 02fffc0000000100 ffffea00070baf08 ffffea000736a788 ffff8801da800940
> raw: ffff8801d8cb42c0 ffff8801d8cb4040 0000000100000005 0000000000000000
> page dumped because: kasan: bad access detected
>
> Memory state around the buggy address:
>  ffff8801d8cb4000: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
>  ffff8801d8cb4080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>
> ffff8801d8cb4100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>
>                                ^
>  ffff8801d8cb4180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ffff8801d8cb4200: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
> ==================================================================
>
>
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with syzbot.
