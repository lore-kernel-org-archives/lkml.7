Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 216DAC76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 16:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E443F206BF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 16:18:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732191AbfGWQSI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 12:18:08 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:36026 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728180AbfGWQSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 12:18:07 -0400
Received: by mail-io1-f70.google.com with SMTP id k21so47762531ioj.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 09:18:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=nZEEJ+SBipYBLPseSY9qEfn4LDUPVqo49FD1oEm/DsE=;
        b=kHqmiKHpQYvXb67CUuYcCT+Eax2gsRfvY+ZUUB6gdkQ00VKBr4gN166k3Uxe8QzGWp
         w+qcdYPycOiAZ4tWg9AzfijSzjUgPLXOTN86VfiVmBQJq8k7NAA4a+hWYSJBC1Sbfsuo
         +TfAo/61izqZgsQfmU3bFhSudyoyW5orrnhNvMLCqwMC9MKSuclJD5+vpJL8as/qZUSi
         d/Sgved75jV5FV7n8/2EuTKjWBVRFYQhs2xY52ERe7vJfnKu6CS9JvpIXg8M2cP/ppys
         Gaow9GJbKMi9QxOcvhdLBijEf21tzGAF/w5sE081in9+MD6tIQhwjeigf/X0h9XbCas4
         8alA==
X-Gm-Message-State: APjAAAV3m7Ip00X2raGT8ZPZwahp1gxQsKsUixwef1E98Jks2iVPuIZM
        B8WplKESm1RNCCXtxST2frxmdbHAlR6NQFyA8utGjmCkWMlZ
X-Google-Smtp-Source: APXvYqyZuD04LlMPL9oLob3V+JcXlBpELa/qka6pqB/Vpmw5GN2ngRgR6M7goXzKzV488ujQcRv1LB24LQsjqR9U2BUE3JsS4xqs
MIME-Version: 1.0
X-Received: by 2002:a02:914c:: with SMTP id b12mr34286348jag.105.1563898686120;
 Tue, 23 Jul 2019 09:18:06 -0700 (PDT)
Date:   Tue, 23 Jul 2019 09:18:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a6ab6b058e5b899b@google.com>
Subject: KASAN: slab-out-of-bounds Read in do_jit
From:   syzbot <syzbot+6b40f58c6d280fa23b40@syzkaller.appspotmail.com>
To:     andriin@fb.com, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, kafai@fb.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    89099d85 Merge branch 'flow_offload-fixes'
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=17169bb7a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4dba67bf8b8c9ad7
dashboard link: https://syzkaller.appspot.com/bug?extid=6b40f58c6d280fa23b40
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=117364f0600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11fcbaafa00000

The bug was bisected to:

commit 2589726d12a1b12eaaa93c7f1ea64287e383c7a5
Author: Alexei Starovoitov <ast@kernel.org>
Date:   Sat Jun 15 19:12:20 2019 +0000

     bpf: introduce bounded loops

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15d38fa4600000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=17d38fa4600000
console output: https://syzkaller.appspot.com/x/log.txt?x=13d38fa4600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+6b40f58c6d280fa23b40@syzkaller.appspotmail.com
Fixes: 2589726d12a1 ("bpf: introduce bounded loops")

==================================================================
BUG: KASAN: slab-out-of-bounds in do_jit.isra.0+0x4c35/0x5630  
/arch/x86/net/bpf_jit_comp.c:966
Read of size 4 at addr ffff8880a654ec3c by task syz-executor906/8876

CPU: 0 PID: 8876 Comm: syz-executor906 Not tainted 5.2.0+ #95
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack /lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 /lib/dump_stack.c:113
  print_address_description.cold+0xd4/0x306 /mm/kasan/report.c:351
  __kasan_report.cold+0x1b/0x36 /mm/kasan/report.c:482
  kasan_report+0x12/0x17 /mm/kasan/common.c:612
  __asan_report_load4_noabort+0x14/0x20 /mm/kasan/generic_report.c:131
  do_jit.isra.0+0x4c35/0x5630 /arch/x86/net/bpf_jit_comp.c:966
  bpf_int_jit_compile+0x374/0xda0 /arch/x86/net/bpf_jit_comp.c:1132
  bpf_prog_select_runtime+0x4cd/0x7d0 /kernel/bpf/core.c:1726
  bpf_prog_load+0xe9b/0x1670 /kernel/bpf/syscall.c:1702
  __do_sys_bpf+0xa46/0x42f0 /kernel/bpf/syscall.c:2849
  __se_sys_bpf /kernel/bpf/syscall.c:2808 [inline]
  __x64_sys_bpf+0x73/0xb0 /kernel/bpf/syscall.c:2808
  do_syscall_64+0xfd/0x6a0 /arch/x86/entry/common.c:296
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4402c9
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 fb 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffc7d7bb638 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 00000000004402c9
RDX: 0000000000000046 RSI: 0000000020000180 RDI: 0000000000000005
RBP: 00000000006ca018 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 0000000000401b50
R13: 0000000000401be0 R14: 0000000000000000 R15: 0000000000000000

Allocated by task 8388:
  save_stack+0x23/0x90 /mm/kasan/common.c:69
  set_track /mm/kasan/common.c:77 [inline]
  __kasan_kmalloc /mm/kasan/common.c:487 [inline]
  __kasan_kmalloc.constprop.0+0xcf/0xe0 /mm/kasan/common.c:460
  kasan_kmalloc+0x9/0x10 /mm/kasan/common.c:501
  __do_kmalloc /mm/slab.c:3655 [inline]
  __kmalloc+0x163/0x770 /mm/slab.c:3664
  kmalloc /./include/linux/slab.h:557 [inline]
  kzalloc /./include/linux/slab.h:748 [inline]
  lsm_cred_alloc /security/security.c:466 [inline]
  security_prepare_creds+0x11d/0x190 /security/security.c:1514
  prepare_creds+0x2f5/0x3f0 /kernel/cred.c:281
  do_faccessat+0xa2/0x7f0 /fs/open.c:360
  __do_sys_access /fs/open.c:431 [inline]
  __se_sys_access /fs/open.c:429 [inline]
  __x64_sys_access+0x59/0x80 /fs/open.c:429
  do_syscall_64+0xfd/0x6a0 /arch/x86/entry/common.c:296
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 8372:
  save_stack+0x23/0x90 /mm/kasan/common.c:69
  set_track /mm/kasan/common.c:77 [inline]
  __kasan_slab_free+0x102/0x150 /mm/kasan/common.c:449
  kasan_slab_free+0xe/0x10 /mm/kasan/common.c:457
  __cache_free /mm/slab.c:3425 [inline]
  kfree+0x10a/0x2c0 /mm/slab.c:3756
  security_cred_free+0xa9/0x110 /security/security.c:1508
  put_cred_rcu+0x129/0x4b0 /kernel/cred.c:114
  __rcu_reclaim /kernel/rcu/rcu.h:222 [inline]
  rcu_do_batch /kernel/rcu/tree.c:2114 [inline]
  rcu_core+0x67f/0x1580 /kernel/rcu/tree.c:2314
  rcu_core_si+0x9/0x10 /kernel/rcu/tree.c:2323
  __do_softirq+0x262/0x98c /kernel/softirq.c:292

The buggy address belongs to the object at ffff8880a654ec00
  which belongs to the cache kmalloc-32 of size 32
The buggy address is located 28 bytes to the right of
  32-byte region [ffff8880a654ec00, ffff8880a654ec20)
The buggy address belongs to the page:
page:ffffea0002995380 refcount:1 mapcount:0 mapping:ffff8880aa4001c0  
index:0xffff8880a654efc1
flags: 0x1fffc0000000200(slab)
raw: 01fffc0000000200 ffffea000290f1c8 ffffea0002a154c8 ffff8880aa4001c0
raw: ffff8880a654efc1 ffff8880a654e000 0000000100000027 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8880a654eb00: fb fb fb fb fc fc fc fc 00 04 fc fc fc fc fc fc
  ffff8880a654eb80: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
> ffff8880a654ec00: fb fb fb fb fc fc fc fc 00 00 fc fc fc fc fc fc
                                         ^
  ffff8880a654ec80: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
  ffff8880a654ed00: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
