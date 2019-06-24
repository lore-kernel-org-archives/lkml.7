Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B855C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 07:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E813204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 07:27:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbfFXH1J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 03:27:09 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:52513 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726516AbfFXH1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 03:27:09 -0400
Received: by mail-io1-f70.google.com with SMTP id p12so20867873iog.19
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 00:27:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Iupi8DOKHDcSSlu87q2pfPMCXoPDN4x3nXpdzN2NyMQ=;
        b=KZJyVfLEh3mkLEcgMDRvAfm7oiOzE3PNXkItNDtw6Se+COt/64sOALRc+tOcjRw02M
         57SgLoPc5BO517/PYiyWgdY1nlxUFNjrxxc841Ps801bO5YxThrNqIY0yluyGkuzQwKV
         lEXrjH6W3mBKxpL1jc11xO64tn+E/MXlB4ZtsSgwEERMRabhHdn6uT7xd3xKZ7Mt8qiS
         0Lxv2I0j07GUWJ41KSdBYALd8rpIxP8TQq6RNvNvemy5rQMdqipygno2A4tENKtz6C3f
         DcczFOBVMdl9SVinsYEY+X3jXXREfV0Y68pZrvOAFoZmjYyBrzidLrwvB2gAEGbix/hY
         B+aw==
X-Gm-Message-State: APjAAAWrTksQlGJ3A/1euP8VVT7AievRTg+awvjLndGqR4gkDXp4PNty
        pq0Xp6/WDwgtXeoOX9gViLz7HdNUIW5ICmbTlpZHYDWdQ85I
X-Google-Smtp-Source: APXvYqxeGV620buUz0aPb2+Oqval4tymsKZZilxKrwLaNYS/Nod4djMLtWlaFmOVev18aExDa9BRLfJkWKbYX/1+mnSH+50izSU3
MIME-Version: 1.0
X-Received: by 2002:a05:6602:218b:: with SMTP id b11mr39471009iob.264.1561361228329;
 Mon, 24 Jun 2019 00:27:08 -0700 (PDT)
Date:   Mon, 24 Jun 2019 00:27:08 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000617b4a058c0cbd60@google.com>
Subject: memory leak in mpihelp_mul_karatsuba_case
From:   syzbot <syzbot+f7baccc38dcc1e094e77@syzkaller.appspotmail.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    abf02e29 Merge tag 'pm-5.2-rc6' of git://git.kernel.org/pu..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17a8bfeaa00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=56f1da14935c3cce
dashboard link: https://syzkaller.appspot.com/bug?extid=f7baccc38dcc1e094e77
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=171aa7e6a00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=153306cea00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+f7baccc38dcc1e094e77@syzkaller.appspotmail.com

ffffffffda RBX: 0000000000000000 RCX: 0000000000441ac9
BUG: memory leak
unreferenced object 0xffff88811f4da200 (size 512):
   comm "syz-executor301", pid 7045, jiffies 4294955450 (age 7.850s)
   hex dump (first 32 bytes):
     ad dc f4 43 66 b0 1a 88 8f 0c 17 d5 86 34 3a 85  ...Cf........4:.
     e3 63 c8 bf 2e 3b f5 0d 1c ab 63 30 15 fe a1 e9  .c...;....c0....
   backtrace:
     [<00000000d5589961>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<00000000d5589961>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<00000000d5589961>] slab_alloc mm/slab.c:3326 [inline]
     [<00000000d5589961>] __do_kmalloc mm/slab.c:3658 [inline]
     [<00000000d5589961>] __kmalloc+0x161/0x2c0 mm/slab.c:3669
     [<00000000022eaa00>] kmalloc include/linux/slab.h:552 [inline]
     [<00000000022eaa00>] mpi_alloc_limb_space+0x29/0x50 lib/mpi/mpiutil.c:64
     [<00000000d637c699>] mpihelp_mul_karatsuba_case+0x67/0x460  
lib/mpi/mpih-mul.c:331
     [<00000000401dc6f9>] mpi_powm+0x7b0/0xdd0 lib/mpi/mpi-pow.c:225
     [<00000000be8dcb84>] _compute_val crypto/dh.c:39 [inline]
     [<00000000be8dcb84>] dh_compute_value+0x160/0x220 crypto/dh.c:178
     [<00000000471846ad>] crypto_kpp_generate_public_key  
include/crypto/kpp.h:315 [inline]
     [<00000000471846ad>] __keyctl_dh_compute+0x447/0x970  
security/keys/dh.c:367
     [<000000002f6d650d>] keyctl_dh_compute+0x67/0xa6 security/keys/dh.c:422
     [<00000000b798bc7f>] __do_sys_keyctl security/keys/keyctl.c:1737  
[inline]
     [<00000000b798bc7f>] __se_sys_keyctl security/keys/keyctl.c:1633  
[inline]
     [<00000000b798bc7f>] __x64_sys_keyctl+0xa5/0x330  
security/keys/keyctl.c:1633
     [<000000007a6f9515>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<00000000057f2768>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88811f4dac00 (size 512):
   comm "syz-executor301", pid 7045, jiffies 4294955450 (age 7.850s)
   hex dump (first 32 bytes):
     62 72 c4 ae ac af a3 ba e5 24 da a5 30 5e cb c4  br.......$..0^..
     a6 46 44 39 76 2e 42 f6 85 6a 5b ad ae 97 4e 83  .FD9v.B..j[...N.
   backtrace:
     [<00000000d5589961>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<00000000d5589961>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<00000000d5589961>] slab_alloc mm/slab.c:3326 [inline]
     [<00000000d5589961>] __do_kmalloc mm/slab.c:3658 [inline]
     [<00000000d5589961>] __kmalloc+0x161/0x2c0 mm/slab.c:3669
     [<00000000022eaa00>] kmalloc include/linux/slab.h:552 [inline]
     [<00000000022eaa00>] mpi_alloc_limb_space+0x29/0x50 lib/mpi/mpiutil.c:64
     [<0000000025804541>] mpihelp_mul_karatsuba_case+0x394/0x460  
lib/mpi/mpih-mul.c:346
     [<00000000401dc6f9>] mpi_powm+0x7b0/0xdd0 lib/mpi/mpi-pow.c:225
     [<00000000be8dcb84>] _compute_val crypto/dh.c:39 [inline]
     [<00000000be8dcb84>] dh_compute_value+0x160/0x220 crypto/dh.c:178
     [<00000000471846ad>] crypto_kpp_generate_public_key  
include/crypto/kpp.h:315 [inline]
     [<00000000471846ad>] __keyctl_dh_compute+0x447/0x970  
security/keys/dh.c:367
     [<000000002f6d650d>] keyctl_dh_compute+0x67/0xa6 security/keys/dh.c:422
     [<00000000b798bc7f>] __do_sys_keyctl security/keys/keyctl.c:1737  
[inline]
     [<00000000b798bc7f>] __se_sys_keyctl security/keys/keyctl.c:1633  
[inline]
     [<00000000b798bc7f>] __x64_sys_keyctl+0xa5/0x330  
security/keys/keyctl.c:1633
     [<000000007a6f9515>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<00000000057f2768>] entry_SYSCALL_64_after_hwframe+0x44/0xa9



---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
