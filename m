Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F57C4360C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 00:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E07ED222C0
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 00:19:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729488AbfJCATJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 20:19:09 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:32892 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729403AbfJCATI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 20:19:08 -0400
Received: by mail-io1-f70.google.com with SMTP id g15so2232947ioc.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 17:19:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=peIUdpB0uufhb2WaI0hkt8u3mVPMxGwg5KAkuWXKJEM=;
        b=tlF1mTql75tAOcAP/kd+dLBLkS5A5QgkwHhNfCXCni2ITRjdKt/cRcz+j/+ZLXczkY
         8msRT80OPoZS/8gpY7xZwzTrqsnHm5qRaE6BhczxkHTovmoe3Ryo/eOnx4csW9vsP7/m
         KBFFaVZJGtjaXuy/QjnhsOTZlk6fmavV9f+d8xAK46RiHnqJ/si5CzUTyqfSlOE51ZcE
         ol5kYYFyNDPyUHvcFOBuTbVLERQzIysEfU8dnVlqYvoOfhDf5XZ3lkgHoi9u04n1mb7R
         Vmtpl5L1XoQY5JxOPfyGBoxiXCFi4pQFgRCLZrvkDWkEaW0s6bnJETbXJ6T7vmIOGoEE
         qQRw==
X-Gm-Message-State: APjAAAXiiQn8kH5GC4sRMhddQgmswBzy3uXsCERHnO03rF4sw+x11uRz
        T7xZo4+UD8mp6UGn24z1/tOd7/zwzRdOYB1qIfGPLMI20rkC
X-Google-Smtp-Source: APXvYqyDPxvxHfZLOmI4rcw7jNQszi606WcLVjtl/4QRIX2H67TfAThskc/5+vGFskM40Iac4RX5Nh5xvZCdimiWlmK447iG2BST
MIME-Version: 1.0
X-Received: by 2002:a02:7405:: with SMTP id o5mr6859365jac.44.1570061948007;
 Wed, 02 Oct 2019 17:19:08 -0700 (PDT)
Date:   Wed, 02 Oct 2019 17:19:08 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000afc1b40593f68888@google.com>
Subject: memory leak in gfs2_init_fs_context
From:   syzbot <syzbot+c2fdfd2b783754878fb6@syzkaller.appspotmail.com>
To:     agruenba@redhat.com, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org, rpeterso@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    f1f2f614 Merge branch 'next-integrity' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15569c05600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4e93436f92b0cfde
dashboard link: https://syzkaller.appspot.com/bug?extid=c2fdfd2b783754878fb6
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10327c05600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=105c9fd5600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+c2fdfd2b783754878fb6@syzkaller.appspotmail.com

udit: type=1400 audit(1569701659.045:64): avc:  denied  { map } for   
pid=6842 comm="syz-executor375" path="/root/syz-executor375626622"  
dev="sda1" ino=16502 scontext=unconfined_u:system_r:insmod_t:s0-s0:c0.c1023  
tcontext=unconfined_u:object_r:user_home_t:s0 tclass=file permissive=1
executing program
executing program
BUG: memory leak
unreferenced object 0xffff88810fd9a500 (size 256):
   comm "syz-executor375", pid 6845, jiffies 4294941255 (age 13.550s)
   hex dump (first 32 bytes):
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<00000000462ab467>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<00000000462ab467>] slab_post_alloc_hook mm/slab.h:586 [inline]
     [<00000000462ab467>] slab_alloc mm/slab.c:3319 [inline]
     [<00000000462ab467>] kmem_cache_alloc_trace+0x145/0x2c0 mm/slab.c:3548
     [<00000000b1a62211>] kmalloc include/linux/slab.h:552 [inline]
     [<00000000b1a62211>] kzalloc include/linux/slab.h:686 [inline]
     [<00000000b1a62211>] gfs2_init_fs_context+0x25/0x90  
fs/gfs2/ops_fstype.c:1543
     [<00000000db94ecb4>] gfs2_meta_init_fs_context+0x17/0x40  
fs/gfs2/ops_fstype.c:1608
     [<0000000077df5577>] alloc_fs_context+0x174/0x200 fs/fs_context.c:293
     [<000000008d5e3681>] fs_context_for_mount+0x25/0x30 fs/fs_context.c:307
     [<0000000030bafbdb>] __do_sys_fsopen fs/fsopen.c:137 [inline]
     [<0000000030bafbdb>] __se_sys_fsopen fs/fsopen.c:115 [inline]
     [<0000000030bafbdb>] __x64_sys_fsopen+0xa9/0x1a0 fs/fsopen.c:115
     [<00000000974fed69>] do_syscall_64+0x73/0x1f0  
arch/x86/entry/common.c:290
     [<00000000299e0e1b>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88810fd9a200 (size 256):
   comm "syz-executor375", pid 6846, jiffies 4294941838 (age 7.720s)
   hex dump (first 32 bytes):
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<00000000462ab467>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<00000000462ab467>] slab_post_alloc_hook mm/slab.h:586 [inline]
     [<00000000462ab467>] slab_alloc mm/slab.c:3319 [inline]
     [<00000000462ab467>] kmem_cache_alloc_trace+0x145/0x2c0 mm/slab.c:3548
     [<00000000b1a62211>] kmalloc include/linux/slab.h:552 [inline]
     [<00000000b1a62211>] kzalloc include/linux/slab.h:686 [inline]
     [<00000000b1a62211>] gfs2_init_fs_context+0x25/0x90  
fs/gfs2/ops_fstype.c:1543
     [<00000000db94ecb4>] gfs2_meta_init_fs_context+0x17/0x40  
fs/gfs2/ops_fstype.c:1608
     [<0000000077df5577>] alloc_fs_context+0x174/0x200 fs/fs_context.c:293
     [<000000008d5e3681>] fs_context_for_mount+0x25/0x30 fs/fs_context.c:307
     [<0000000030bafbdb>] __do_sys_fsopen fs/fsopen.c:137 [inline]
     [<0000000030bafbdb>] __se_sys_fsopen fs/fsopen.c:115 [inline]
     [<0000000030bafbdb>] __x64_sys_fsopen+0xa9/0x1a0 fs/fsopen.c:115
     [<00000000974fed69>] do_syscall_64+0x73/0x1f0  
arch/x86/entry/common.c:290
     [<00000000299e0e1b>] entry_SYSCALL_64_after_hwframe+0x44/0xa9



---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
