Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_DIGITS,
	FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35442C282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 15:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 160CE20879
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 15:58:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730015AbfEVP6L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 11:58:11 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:38150 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729588AbfEVP6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 11:58:07 -0400
Received: by mail-io1-f70.google.com with SMTP id w3so2102563iot.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 08:58:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=erwCwLi/IMGQgqdgz2IK51VTR3OAaKII4qxB+lqID+g=;
        b=OqgNLV4sYoZWwxCOG1T8l19yU5rHqUv1et1iRU+zG4zOiKBZo2k5GV61tNR8pPiqxw
         BNvI2cd1sJ6chJw5CTzubn9WBPjBixCRGLHFjDyxtOs08yKXokHVfMECGzZ08u4f1mFv
         NgF8yqhIBePsX1lCuOAbisIVfVL6TbDxh8GRHUTwrxMZu5BPKH5OvzE+8ZBrY5wDG41U
         vU4pAVh/97tHzHxD8XNlsMIyXbm989yTyFXgqEe8iBaghh7g+5RZwwn8OHj8iC3iO9HX
         TAbM0/rd2wnz3rkhYmGV9E2BH+HjW2yAtWaZSm/06lX3GtTjKnreL6kOltoNE5XE+gsy
         2ADw==
X-Gm-Message-State: APjAAAU9pwIdssd/1L0cCa7N+6QfH+wVVrsXSNbsvZN6FUQD06CVeg7s
        dSFOhhsznqjQOssQQOZu5QoIuHLC/+DPI1ZMRF8WCq6r2nSK
X-Google-Smtp-Source: APXvYqzH9M01QETYOFX4ylwR0pwMC43Y5tbfd7IU5YF/nedV3ZoEwPV7/8eBoUaroTkUl+y1yHJxF2PlT/04o48SKoW4DBCH8cle
MIME-Version: 1.0
X-Received: by 2002:a6b:b3c5:: with SMTP id c188mr54147098iof.203.1558540686350;
 Wed, 22 May 2019 08:58:06 -0700 (PDT)
Date:   Wed, 22 May 2019 08:58:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fa662405897c0774@google.com>
Subject: memory leak in sock_hash_update_common
From:   syzbot <syzbot+30c7a1fc662026545124@syzkaller.appspotmail.com>
To:     ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
        davem@davemloft.net, john.fastabend@gmail.com, kafai@fb.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        songliubraving@fb.com, syzkaller-bugs@googlegroups.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    9c7db500 Merge tag 'selinux-pr-20190521' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1287358aa00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=61dd9e15a761691d
dashboard link: https://syzkaller.appspot.com/bug?extid=30c7a1fc662026545124
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1284fb9ca00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+30c7a1fc662026545124@syzkaller.appspotmail.com

dy
BUG: memory leak
unreferenced object 0xffff88810dc30340 (size 64):
   comm "softirq", pid 0, jiffies 4294949769 (age 8.870s)
   hex dump (first 32 bytes):
     00 70 f4 14 81 88 ff ff 00 2a c3 1b 82 88 ff ff  .p.......*......
     bf 84 c1 58 00 00 00 00 c0 f2 cc 0d 81 88 ff ff  ...X............
   backtrace:
     [<0000000059c77455>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:55 [inline]
     [<0000000059c77455>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<0000000059c77455>] slab_alloc_node mm/slab.c:3269 [inline]
     [<0000000059c77455>] kmem_cache_alloc_node_trace+0x15b/0x2a0  
mm/slab.c:3597
     [<00000000a3eee734>] __do_kmalloc_node mm/slab.c:3619 [inline]
     [<00000000a3eee734>] __kmalloc_node+0x38/0x50 mm/slab.c:3627
     [<00000000869e2762>] kmalloc_node include/linux/slab.h:590 [inline]
     [<00000000869e2762>] sock_hash_alloc_elem net/core/sock_map.c:639  
[inline]
     [<00000000869e2762>] sock_hash_update_common+0x301/0x540  
net/core/sock_map.c:690
     [<00000000ae16fa93>] sock_hash_update_elem+0xf0/0x130  
net/core/sock_map.c:739
     [<0000000047230865>] map_update_elem kernel/bpf/syscall.c:925 [inline]
     [<0000000047230865>] __do_sys_bpf+0x19b7/0x1dd0  
kernel/bpf/syscall.c:2801
     [<00000000fb5f3bec>] __se_sys_bpf kernel/bpf/syscall.c:2772 [inline]
     [<00000000fb5f3bec>] __x64_sys_bpf+0x1e/0x30 kernel/bpf/syscall.c:2772
     [<000000007b931104>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<00000000e7e5ff7d>] entry_SYSCALL_64_after_hwframe+0x44/0xa9



---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
