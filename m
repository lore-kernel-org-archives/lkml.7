Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,LONGWORDS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E633FC04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 19:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF92A26F21
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 19:02:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbfFCTCL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 15:02:11 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:42399 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbfFCTCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 15:02:08 -0400
Received: by mail-io1-f71.google.com with SMTP id v187so14536508ioe.9
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 12:02:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=tVgPoobM7Oo9LTGFbXaSPG5Ov/YRiSpSyFpAsWktw8U=;
        b=G/PK4thjoqjddJWONMiXX+1OnrdSJJ635N+16ApWjTXbYsmZr6RQIX8nnD4ATC9Siu
         7/+EmTOijzGVHh7JX5OgHMfrXYUF75aWhu1vjBDFq2Wk8hYPevlgAAE9zWFP8f49B0Bc
         JWlsWnkXDAkNCg9BLQsdbNGM05eh4l+Y95NoEr6nJUdtOqlsVxZAXIy1LTbRygZfCa4J
         JCE/7UfLnsQAYEjIzQQ8ycTkPJZmFZBpzrFnjm6heIdKI7F7I9uBanxddazcTDrR5wqc
         xi4chvzpRS6feGXnvfO7D0aDKTK8NeGcq7ZzJYtGMLdcq2/+ByVPRsFafnBNfP6qU2sH
         Fcaw==
X-Gm-Message-State: APjAAAX9xjZq+C7D6X4MBBUEm45OnQy7VZOeB1fu1aF7cqylmG9TwBiB
        vobJvv/aSYzhxFaoDbjknhfX4bsW2M/BHAnHLxQq+qASovyC
X-Google-Smtp-Source: APXvYqyhgyk+SWMa20MA650AGoKTo/AvsKNKDl+JQOj39E2nZgecdxAsZSzDcNhZKWppHsRGQsBSFcxwVcAZ+Cz8QFVtDqRV5RwT
MIME-Version: 1.0
X-Received: by 2002:a5d:8ad0:: with SMTP id e16mr12704860iot.106.1559588527564;
 Mon, 03 Jun 2019 12:02:07 -0700 (PDT)
Date:   Mon, 03 Jun 2019 12:02:07 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002e72eb058a7000d0@google.com>
Subject: memory leak in proc_register
From:   syzbot <syzbot+06780effeefb578dcbfa@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    9221dced Merge tag 'for-linus-20190601' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=179a80f2a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=50393f7bfe444ff6
dashboard link: https://syzkaller.appspot.com/bug?extid=06780effeefb578dcbfa
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12155636a00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=126f1042a00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+06780effeefb578dcbfa@syzkaller.appspotmail.com

m
executing program
executing program
executing program
BUG: memory leak
unreferenced object 0xffff88821b68d780 (size 128):
   comm "swapper/0", pid 1, jiffies 4294937320 (age 1363.880s)
   hex dump (first 32 bytes):
     ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
     ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
   backtrace:
     [<000000005ff104f1>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:55 [inline]
     [<000000005ff104f1>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<000000005ff104f1>] slab_alloc mm/slab.c:3326 [inline]
     [<000000005ff104f1>] kmem_cache_alloc_trace+0x13d/0x280 mm/slab.c:3553
     [<000000008feae05f>] kmalloc include/linux/slab.h:547 [inline]
     [<000000008feae05f>] kzalloc include/linux/slab.h:742 [inline]
     [<000000008feae05f>] ida_alloc_range+0x2d6/0x520 lib/idr.c:416
     [<00000000dd09fe3e>] proc_alloc_inum fs/proc/generic.c:209 [inline]
     [<00000000dd09fe3e>] proc_register+0x34/0x200 fs/proc/generic.c:354
     [<00000000433ed329>] proc_mkdir_data+0x89/0xc0 fs/proc/generic.c:476
     [<0000000040802aab>] proc_mkdir+0x22/0x30 fs/proc/generic.c:494
     [<00000000a4ab923e>] register_irq_proc+0xbe/0x1d0 kernel/irq/proc.c:352
     [<00000000204292a9>] init_irq_proc+0x74/0xb0 kernel/irq/proc.c:438
     [<000000002b246fb2>] do_basic_setup init/main.c:1006 [inline]
     [<000000002b246fb2>] kernel_init_freeable+0x12b/0x26c init/main.c:1169
     [<00000000cc140f05>] kernel_init+0x10/0x155 init/main.c:1087
     [<00000000d18604ff>] ret_from_fork+0x1f/0x30  
arch/x86/entry/entry_64.S:352

BUG: memory leak
unreferenced object 0xffff888113775d00 (size 96):
   comm "syz-executor225", pid 7540, jiffies 4295072562 (age 11.510s)
   hex dump (first 32 bytes):
     02 00 00 00 00 00 00 00 70 87 bb 82 ff ff ff ff  ........p.......
     00 00 00 00 00 00 00 00 50 9b bb 82 ff ff ff ff  ........P.......
   backtrace:
     [<000000001a48c6be>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:55 [inline]
     [<000000001a48c6be>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<000000001a48c6be>] slab_alloc_node mm/slab.c:3269 [inline]
     [<000000001a48c6be>] kmem_cache_alloc_node_trace+0x15b/0x2a0  
mm/slab.c:3597
     [<00000000a81e20d3>] __do_kmalloc_node mm/slab.c:3619 [inline]
     [<00000000a81e20d3>] __kmalloc_node+0x38/0x50 mm/slab.c:3627
     [<0000000017e61fcc>] kmalloc_node include/linux/slab.h:590 [inline]
     [<0000000017e61fcc>] kvmalloc_node+0x4a/0xd0 mm/util.c:431
     [<000000005df86337>] kvmalloc include/linux/mm.h:637 [inline]
     [<000000005df86337>] kvzalloc include/linux/mm.h:645 [inline]
     [<000000005df86337>] allocate_hook_entries_size+0x3b/0x60  
net/netfilter/core.c:61
     [<00000000c5768c2c>] __nf_hook_entries_try_shrink+0xbd/0x190  
net/netfilter/core.c:248
     [<00000000ce18e0f8>] __nf_unregister_net_hook+0x12f/0x1b0  
net/netfilter/core.c:416
     [<0000000026fee9e8>] nf_unregister_net_hook+0x32/0x70  
net/netfilter/core.c:431
     [<00000000479d68cf>] nf_unregister_net_hooks+0x3d/0x50  
net/netfilter/core.c:499
     [<0000000079ad6bc5>] selinux_nf_unregister+0x22/0x30  
security/selinux/hooks.c:7089
     [<0000000010f43268>] ops_exit_list.isra.0+0x4c/0x80  
net/core/net_namespace.c:154
     [<000000008c4f29b7>] setup_net+0x14a/0x230 net/core/net_namespace.c:333
     [<0000000055c17b35>] copy_net_ns+0xf0/0x1e0 net/core/net_namespace.c:439
     [<00000000a1ddcf1a>] create_new_namespaces+0x141/0x2a0  
kernel/nsproxy.c:107
     [<00000000d179cbd0>] unshare_nsproxy_namespaces+0x7f/0x100  
kernel/nsproxy.c:206
     [<000000009640569f>] ksys_unshare+0x236/0x490 kernel/fork.c:2692
     [<00000000722273f8>] __do_sys_unshare kernel/fork.c:2760 [inline]
     [<00000000722273f8>] __se_sys_unshare kernel/fork.c:2758 [inline]
     [<00000000722273f8>] __x64_sys_unshare+0x16/0x20 kernel/fork.c:2758

BUG: memory leak
unreferenced object 0xffff888113a5e680 (size 96):
   comm "syz-executor225", pid 7540, jiffies 4295072562 (age 11.510s)
   hex dump (first 32 bytes):
     02 00 00 00 00 00 00 00 90 9b bb 82 ff ff ff ff  ................
     00 00 00 00 00 00 00 00 40 87 bb 82 ff ff ff ff  ........@.......
   backtrace:
     [<000000001a48c6be>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:55 [inline]
     [<000000001a48c6be>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<000000001a48c6be>] slab_alloc_node mm/slab.c:3269 [inline]
     [<000000001a48c6be>] kmem_cache_alloc_node_trace+0x15b/0x2a0  
mm/slab.c:3597
     [<00000000a81e20d3>] __do_kmalloc_node mm/slab.c:3619 [inline]
     [<00000000a81e20d3>] __kmalloc_node+0x38/0x50 mm/slab.c:3627
     [<0000000017e61fcc>] kmalloc_node include/linux/slab.h:590 [inline]
     [<0000000017e61fcc>] kvmalloc_node+0x4a/0xd0 mm/util.c:431
     [<000000005df86337>] kvmalloc include/linux/mm.h:637 [inline]
     [<000000005df86337>] kvzalloc include/linux/mm.h:645 [inline]
     [<000000005df86337>] allocate_hook_entries_size+0x3b/0x60  
net/netfilter/core.c:61
     [<00000000c5768c2c>] __nf_hook_entries_try_shrink+0xbd/0x190  
net/netfilter/core.c:248
     [<00000000ce18e0f8>] __nf_unregister_net_hook+0x12f/0x1b0  
net/netfilter/core.c:416
     [<0000000026fee9e8>] nf_unregister_net_hook+0x32/0x70  
net/netfilter/core.c:431
     [<00000000479d68cf>] nf_unregister_net_hooks+0x3d/0x50  
net/netfilter/core.c:499
     [<0000000079ad6bc5>] selinux_nf_unregister+0x22/0x30  
security/selinux/hooks.c:7089
     [<0000000010f43268>] ops_exit_list.isra.0+0x4c/0x80  
net/core/net_namespace.c:154
     [<000000008c4f29b7>] setup_net+0x14a/0x230 net/core/net_namespace.c:333
     [<0000000055c17b35>] copy_net_ns+0xf0/0x1e0 net/core/net_namespace.c:439
     [<00000000a1ddcf1a>] create_new_namespaces+0x141/0x2a0  
kernel/nsproxy.c:107
     [<00000000d179cbd0>] unshare_nsproxy_namespaces+0x7f/0x100  
kernel/nsproxy.c:206
     [<000000009640569f>] ksys_unshare+0x236/0x490 kernel/fork.c:2692
     [<00000000722273f8>] __do_sys_unshare kernel/fork.c:2760 [inline]
     [<00000000722273f8>] __se_sys_unshare kernel/fork.c:2758 [inline]
     [<00000000722273f8>] __x64_sys_unshare+0x16/0x20 kernel/fork.c:2758

BUG: memory leak
unreferenced object 0xffff888113775d00 (size 96):
   comm "syz-executor225", pid 7540, jiffies 4295072562 (age 14.060s)
   hex dump (first 32 bytes):
     02 00 00 00 00 00 00 00 70 87 bb 82 ff ff ff ff  ........p.......
     00 00 00 00 00 00 00 00 50 9b bb 82 ff ff ff ff  ........P.......
   backtrace:
     [<000000001a48c6be>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:55 [inline]
     [<000000001a48c6be>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<000000001a48c6be>] slab_alloc_node mm/slab.c:3269 [inline]
     [<000000001a48c6be>] kmem_cache_alloc_node_trace+0x15b/0x2a0  
mm/slab.c:3597
     [<00000000a81e20d3>] __do_kmalloc_node mm/slab.c:3619 [inline]
     [<00000000a81e20d3>] __kmalloc_node+0x38/0x50 mm/slab.c:3627
     [<0000000017e61fcc>] kmalloc_node include/linux/slab.h:590 [inline]
     [<0000000017e61fcc>] kvmalloc_node+0x4a/0xd0 mm/util.c:431
     [<000000005df86337>] kvmalloc include/linux/mm.h:637 [inline]
     [<000000005df86337>] kvzalloc include/linux/mm.h:645 [inline]
     [<000000005df86337>] allocate_hook_entries_size+0x3b/0x60  
net/netfilter/core.c:61
     [<00000000c5768c2c>] __nf_hook_entries_try_shrink+0xbd/0x190  
net/netfilter/core.c:248
     [<00000000ce18e0f8>] __nf_unregister_net_hook+0x12f/0x1b0  
net/netfilter/core.c:416
     [<0000000026fee9e8>] nf_unregister_net_hook+0x32/0x70  
net/netfilter/core.c:431
     [<00000000479d68cf>] nf_unregister_net_hooks+0x3d/0x50  
net/netfilter/core.c:499
     [<0000000079ad6bc5>] selinux_nf_unregister+0x22/0x30  
security/selinux/hooks.c:7089
     [<0000000010f43268>] ops_exit_list.isra.0+0x4c/0x80  
net/core/net_namespace.c:154
     [<000000008c4f29b7>] setup_net+0x14a/0x230 net/core/net_namespace.c:333
     [<0000000055c17b35>] copy_net_ns+0xf0/0x1e0 net/core/net_namespace.c:439
     [<00000000a1ddcf1a>] create_new_namespaces+0x141/0x2a0  
kernel/nsproxy.c:107
     [<00000000d179cbd0>] unshare_nsproxy_namespaces+0x7f/0x100  
kernel/nsproxy.c:206
     [<000000009640569f>] ksys_unshare+0x236/0x490 kernel/fork.c:2692
     [<00000000722273f8>] __do_sys_unshare kernel/fork.c:2760 [inline]
     [<00000000722273f8>] __se_sys_unshare kernel/fork.c:2758 [inline]
     [<00000000722273f8>] __x64_sys_unshare+0x16/0x20 kernel/fork.c:2758

BUG: memory leak
unreferenced object 0xffff888113a5e680 (size 96):
   comm "syz-executor225", pid 7540, jiffies 4295072562 (age 14.060s)
   hex dump (first 32 bytes):
     02 00 00 00 00 00 00 00 90 9b bb 82 ff ff ff ff  ................
     00 00 00 00 00 00 00 00 40 87 bb 82 ff ff ff ff  ........@.......
   backtrace:
     [<000000001a48c6be>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:55 [inline]
     [<000000001a48c6be>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<000000001a48c6be>] slab_alloc_node mm/slab.c:3269 [inline]
     [<000000001a48c6be>] kmem_cache_alloc_node_trace+0x15b/0x2a0  
mm/slab.c:3597
     [<00000000a81e20d3>] __do_kmalloc_node mm/slab.c:3619 [inline]
     [<00000000a81e20d3>] __kmalloc_node+0x38/0x50 mm/slab.c:3627
     [<0000000017e61fcc>] kmalloc_node include/linux/slab.h:590 [inline]
     [<0000000017e61fcc>] kvmalloc_node+0x4a/0xd0 mm/util.c:431
     [<000000005df86337>] kvmalloc include/linux/mm.h:637 [inline]
     [<000000005df86337>] kvzalloc include/linux/mm.h:645 [inline]
     [<000000005df86337>] allocate_hook_entries_size+0x3b/0x60  
net/netfilter/core.c:61
     [<00000000c5768c2c>] __nf_hook_entries_try_shrink+0xbd/0x190  
net/netfilter/core.c:248
     [<00000000ce18e0f8>] __nf_unregister_net_hook+0x12f/0x1b0  
net/netfilter/core.c:416
     [<0000000026fee9e8>] nf_unregister_net_hook+0x32/0x70  
net/netfilter/core.c:431
     [<00000000479d68cf>] nf_unregister_net_hooks+0x3d/0x50  
net/netfilter/core.c:499
     [<0000000079ad6bc5>] selinux_nf_unregister+0x22/0x30  
security/selinux/hooks.c:7089
     [<0000000010f43268>] ops_exit_list.isra.0+0x4c/0x80  
net/core/net_namespace.c:154
     [<000000008c4f29b7>] setup_net+0x14a/0x230 net/core/net_namespace.c:333
     [<0000000055c17b35>] copy_net_ns+0xf0/0x1e0 net/core/net_namespace.c:439
     [<00000000a1ddcf1a>] create_new_namespaces+0x141/0x2a0  
kernel/nsproxy.c:107
     [<00000000d179cbd0>] unshare_nsproxy_namespaces+0x7f/0x100  
kernel/nsproxy.c:206
     [<000000009640569f>] ksys_unshare+0x236/0x490 kernel/fork.c:2692
     [<00000000722273f8>] __do_sys_unshare kernel/fork.c:2760 [inline]
     [<00000000722273f8>] __se_sys_unshare kernel/fork.c:2758 [inline]
     [<00000000722273f8>] __x64_sys_unshare+0x16/0x20 kernel/fork.c:2758

BUG: memory leak
unreferenced object 0xffff88811491e580 (size 96):
   comm "syz-executor225", pid 7540, jiffies 4295072562 (age 14.060s)
   hex dump (first 32 bytes):
     02 00 00 00 00 00 00 00 80 66 bb 82 ff ff ff ff  .........f......
     00 00 00 00 00 00 00 00 e0 9a bb 82 ff ff ff ff  ................
   backtrace:
     [<000000001a48c6be>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:55 [inline]
     [<000000001a48c6be>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<000000001a48c6be>] slab_alloc_node mm/slab.c:3269 [inline]
     [<000000001a48c6be>] kmem_cache_alloc_node_trace+0x15b/0x2a0  
mm/slab.c:3597
     [<00000000a81e20d3>] __do_kmalloc_node mm/slab.c:3619 [inline]
     [<00000000a81e20d3>] __kmalloc_node+0x38/0x50 mm/slab.c:3627
     [<0000000017e61fcc>] kmalloc_node include/linux/slab.h:590 [inline]
     [<0000000017e61fcc>] kvmalloc_node+0x4a/0xd0 mm/util.c:431
     [<000000005df86337>] kvmalloc include/linux/mm.h:637 [inline]
     [<000000005df86337>] kvzalloc include/linux/mm.h:645 [inline]
     [<000000005df86337>] allocate_hook_entries_size+0x3b/0x60  
net/netfilter/core.c:61
     [<00000000c5768c2c>] __nf_hook_entries_try_shrink+0xbd/0x190  
net/netfilter/core.c:248
     [<00000000ce18e0f8>] __nf_unregister_net_hook+0x12f/0x1b0  
net/netfilter/core.c:416
     [<0000000026fee9e8>] nf_unregister_net_hook+0x32/0x70  
net/netfilter/core.c:431
     [<00000000479d68cf>] nf_unregister_net_hooks+0x3d/0x50  
net/netfilter/core.c:499
     [<0000000079ad6bc5>] selinux_nf_unregister+0x22/0x30  
security/selinux/hooks.c:7089
     [<0000000010f43268>] ops_exit_list.isra.0+0x4c/0x80  
net/core/net_namespace.c:154
     [<000000008c4f29b7>] setup_net+0x14a/0x230 net/core/net_namespace.c:333
     [<0000000055c17b35>] copy_net_ns+0xf0/0x1e0 net/core/net_namespace.c:439
     [<00000000a1ddcf1a>] create_new_namespaces+0x141/0x2a0  
kernel/nsproxy.c:107
     [<00000000d179cbd0>] unshare_nsproxy_namespaces+0x7f/0x100  
kernel/nsproxy.c:206
     [<000000009640569f>] ksys_unshare+0x236/0x490 kernel/fork.c:2692
     [<00000000722273f8>] __do_sys_unshare kernel/fork.c:2760 [inline]
     [<00000000722273f8>] __se_sys_unshare kernel/fork.c:2758 [inline]
     [<00000000722273f8>] __x64_sys_unshare+0x16/0x20 kernel/fork.c:2758

executing program
executing program
executing program
executing program
executing program


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
