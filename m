Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EC1BC5B578
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 05:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5E0F20B7C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 05:40:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbfGAFkC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 01:40:02 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:45845 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbfGAFkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 01:40:01 -0400
Received: by mail-io1-f69.google.com with SMTP id b197so13948659iof.12
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2019 22:40:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=ptsMXgNaVhslud9hqVayVuxLWUP4eJpRRHdiW1OrvIE=;
        b=mS6g9fajFhmt8cIhQX98agGt/ZtnXhOwF8bVf/vdrAbMKBb98r1t73ZXz46rO+gtP+
         inBjf4WzfZPOfoVfZ1j/hqbNbQnTRoA8mID2naV635tEA5HKaOL37oEyQYLy7FCcqBRt
         b0C8DlhHRd+Nrd/xJVPdFjHJ6zVK8sg0OrPsHU3p1J3YZjMzA5474/cFWQilQTmYE/uZ
         ZhgUqMBMt1wi9ck6bUybMhaK4ffQguVNZn2pd83gXIVKEF4P4UrHWA7Vkt4zxFIVMI4J
         8umCmt6unJwiIs+lyYbUpKdYusD+ExLpNxDDuYuFK/K4JWURl1ydKduNwDwssrNiwVGZ
         yRpQ==
X-Gm-Message-State: APjAAAWivqj5OJ4lhwuUfy8nWr1zfzUmbCJjsuXOObuGYkHHWHVlhS/s
        /p3FsF4TQ8BpsWD0LAhgW0JwbUsB2VMcy/Ky3j3OAyMbQ27z
X-Google-Smtp-Source: APXvYqx4h2M+CVjiTqKY30se1fgbpSi69aMuAdEwcUB+0tkIGtLUtx/ZujFOHRNGIzM+gtR6Hsrz+GIyDcu5efl/FlABcSYjUPA2
MIME-Version: 1.0
X-Received: by 2002:a6b:f406:: with SMTP id i6mr23856819iog.110.1561959600575;
 Sun, 30 Jun 2019 22:40:00 -0700 (PDT)
Date:   Sun, 30 Jun 2019 22:40:00 -0700
In-Reply-To: <5d1999ff323f_18a42abda71925b4cf@john-XPS-13-9370.notmuch>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000255dbd058c980f22@google.com>
Subject: Re: memory leak in create_ctx
From:   syzbot <syzbot+06537213db7ba2745c4a@syzkaller.appspotmail.com>
To:     aviadye@mellanox.com, borisp@mellanox.com, daniel@iogearbox.net,
        davejwatson@fb.com, davem@davemloft.net, john.fastabend@gmail.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer still triggered  
crash:
memory leak in create_ctx

2019/07/01 05:38:26 executed programs: 23
BUG: memory leak
unreferenced object 0xffff888102914e00 (size 512):
   comm "syz-executor.4", pid 7333, jiffies 4294944085 (age 13.950s)
   hex dump (first 32 bytes):
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<000000002f2bb8be>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:55 [inline]
     [<000000002f2bb8be>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<000000002f2bb8be>] slab_alloc mm/slab.c:3326 [inline]
     [<000000002f2bb8be>] kmem_cache_alloc_trace+0x13d/0x280 mm/slab.c:3553
     [<00000000b76aef16>] kmalloc include/linux/slab.h:547 [inline]
     [<00000000b76aef16>] kzalloc include/linux/slab.h:742 [inline]
     [<00000000b76aef16>] create_ctx+0x25/0x70 net/tls/tls_main.c:648
     [<00000000dc9c9d2e>] tls_init net/tls/tls_main.c:837 [inline]
     [<00000000dc9c9d2e>] tls_init+0x97/0x1f0 net/tls/tls_main.c:819
     [<000000009d663c39>] __tcp_set_ulp net/ipv4/tcp_ulp.c:126 [inline]
     [<000000009d663c39>] tcp_set_ulp+0xe2/0x190 net/ipv4/tcp_ulp.c:147
     [<00000000551f7621>] do_tcp_setsockopt.isra.0+0x19a/0xd60  
net/ipv4/tcp.c:2789
     [<00000000d02c41d7>] tcp_setsockopt+0x71/0x80 net/ipv4/tcp.c:3103
     [<0000000085d221c1>] sock_common_setsockopt+0x38/0x50  
net/core/sock.c:3129
     [<00000000d294eeda>] __sys_setsockopt+0x98/0x120 net/socket.c:2072
     [<00000000f1f1d607>] __do_sys_setsockopt net/socket.c:2083 [inline]
     [<00000000f1f1d607>] __se_sys_setsockopt net/socket.c:2080 [inline]
     [<00000000f1f1d607>] __x64_sys_setsockopt+0x26/0x30 net/socket.c:2080
     [<00000000fbd4f794>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<000000007383b736>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888103860c00 (size 512):
   comm "syz-executor.0", pid 7342, jiffies 4294944115 (age 13.650s)
   hex dump (first 32 bytes):
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<000000002f2bb8be>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:55 [inline]
     [<000000002f2bb8be>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<000000002f2bb8be>] slab_alloc mm/slab.c:3326 [inline]
     [<000000002f2bb8be>] kmem_cache_alloc_trace+0x13d/0x280 mm/slab.c:3553
     [<00000000b76aef16>] kmalloc include/linux/slab.h:547 [inline]
     [<00000000b76aef16>] kzalloc include/linux/slab.h:742 [inline]
     [<00000000b76aef16>] create_ctx+0x25/0x70 net/tls/tls_main.c:648
     [<00000000dc9c9d2e>] tls_init net/tls/tls_main.c:837 [inline]
     [<00000000dc9c9d2e>] tls_init+0x97/0x1f0 net/tls/tls_main.c:819
     [<000000009d663c39>] __tcp_set_ulp net/ipv4/tcp_ulp.c:126 [inline]
     [<000000009d663c39>] tcp_set_ulp+0xe2/0x190 net/ipv4/tcp_ulp.c:147
     [<00000000551f7621>] do_tcp_setsockopt.isra.0+0x19a/0xd60  
net/ipv4/tcp.c:2789
     [<00000000d02c41d7>] tcp_setsockopt+0x71/0x80 net/ipv4/tcp.c:3103
     [<0000000085d221c1>] sock_common_setsockopt+0x38/0x50  
net/core/sock.c:3129
     [<00000000d294eeda>] __sys_setsockopt+0x98/0x120 net/socket.c:2072
     [<00000000f1f1d607>] __do_sys_setsockopt net/socket.c:2083 [inline]
     [<00000000f1f1d607>] __se_sys_setsockopt net/socket.c:2080 [inline]
     [<00000000f1f1d607>] __x64_sys_setsockopt+0x26/0x30 net/socket.c:2080
     [<00000000fbd4f794>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<000000007383b736>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88810e3e1c00 (size 512):
   comm "syz-executor.5", pid 7384, jiffies 4294944151 (age 13.290s)
   hex dump (first 32 bytes):
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<000000002f2bb8be>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:55 [inline]
     [<000000002f2bb8be>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<000000002f2bb8be>] slab_alloc mm/slab.c:3326 [inline]
     [<000000002f2bb8be>] kmem_cache_alloc_trace+0x13d/0x280 mm/slab.c:3553
     [<00000000b76aef16>] kmalloc include/linux/slab.h:547 [inline]
     [<00000000b76aef16>] kzalloc include/linux/slab.h:742 [inline]
     [<00000000b76aef16>] create_ctx+0x25/0x70 net/tls/tls_main.c:648
     [<00000000dc9c9d2e>] tls_init net/tls/tls_main.c:837 [inline]
     [<00000000dc9c9d2e>] tls_init+0x97/0x1f0 net/tls/tls_main.c:819
     [<000000009d663c39>] __tcp_set_ulp net/ipv4/tcp_ulp.c:126 [inline]
     [<000000009d663c39>] tcp_set_ulp+0xe2/0x190 net/ipv4/tcp_ulp.c:147
     [<00000000551f7621>] do_tcp_setsockopt.isra.0+0x19a/0xd60  
net/ipv4/tcp.c:2789
     [<00000000d02c41d7>] tcp_setsockopt+0x71/0x80 net/ipv4/tcp.c:3103
     [<0000000085d221c1>] sock_common_setsockopt+0x38/0x50  
net/core/sock.c:3129
     [<00000000d294eeda>] __sys_setsockopt+0x98/0x120 net/socket.c:2072
     [<00000000f1f1d607>] __do_sys_setsockopt net/socket.c:2083 [inline]
     [<00000000f1f1d607>] __se_sys_setsockopt net/socket.c:2080 [inline]
     [<00000000f1f1d607>] __x64_sys_setsockopt+0x26/0x30 net/socket.c:2080
     [<00000000fbd4f794>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<000000007383b736>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88811a0a7200 (size 512):
   comm "syz-executor.0", pid 7423, jiffies 4294944702 (age 7.780s)
   hex dump (first 32 bytes):
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<000000002f2bb8be>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:55 [inline]
     [<000000002f2bb8be>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<000000002f2bb8be>] slab_alloc mm/slab.c:3326 [inline]
     [<000000002f2bb8be>] kmem_cache_alloc_trace+0x13d/0x280 mm/slab.c:3553
     [<00000000b76aef16>] kmalloc include/linux/slab.h:547 [inline]
     [<00000000b76aef16>] kzalloc include/linux/slab.h:742 [inline]
     [<00000000b76aef16>] create_ctx+0x25/0x70 net/tls/tls_main.c:648
     [<00000000dc9c9d2e>] tls_init net/tls/tls_main.c:837 [inline]
     [<00000000dc9c9d2e>] tls_init+0x97/0x1f0 net/tls/tls_main.c:819
     [<000000009d663c39>] __tcp_set_ulp net/ipv4/tcp_ulp.c:126 [inline]
     [<000000009d663c39>] tcp_set_ulp+0xe2/0x190 net/ipv4/tcp_ulp.c:147
     [<00000000551f7621>] do_tcp_setsockopt.isra.0+0x19a/0xd60  
net/ipv4/tcp.c:2789
     [<00000000d02c41d7>] tcp_setsockopt+0x71/0x80 net/ipv4/tcp.c:3103
     [<0000000085d221c1>] sock_common_setsockopt+0x38/0x50  
net/core/sock.c:3129
     [<00000000d294eeda>] __sys_setsockopt+0x98/0x120 net/socket.c:2072
     [<00000000f1f1d607>] __do_sys_setsockopt net/socket.c:2083 [inline]
     [<00000000f1f1d607>] __se_sys_setsockopt net/socket.c:2080 [inline]
     [<00000000f1f1d607>] __x64_sys_setsockopt+0x26/0x30 net/socket.c:2080
     [<00000000fbd4f794>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<000000007383b736>] entry_SYSCALL_64_after_hwframe+0x44/0xa9



Tested on:

commit:         0b58d013 bpf: tls, implement unhash to avoid transition ou..
git tree:       git://github.com/cilium/linux ktls-unhash
console output: https://syzkaller.appspot.com/x/log.txt?x=134f2e0ba00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3bd5897d1df43b97
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

