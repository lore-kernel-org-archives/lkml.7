Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30362C4360C
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 21:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F417218DE
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 21:50:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729450AbfJBVuQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 17:50:16 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:48363 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbfJBVuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 17:50:14 -0400
Received: by mail-io1-f69.google.com with SMTP id w16so1315684ioc.15
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 14:50:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=EaD4hPrd8RVzckGPGHICifgUp2cDYNo0SWfmeyPd01c=;
        b=ieGV//Nn86WqJfmicDgUtBf7SSEClJUwFrtR2M2BF3sJ4lo2L9SLfr4r/aE/Eb+TXc
         GhPYwwZw32OMkfER4xfOvwe7hW/U+exXy1J1ddtWeU1OOzRi+bv2cwmtRJUw0Qv5ZfTF
         Qg7PfEuyCsWiLW0wPqWc/a2r9g+fsh44kjtPViVRnFwIHpZiNxe8/Xzly8nM7I20IH/O
         34HTOZy9i0xOOmKYKOX/xs3UiZexONIDqLhwlss4zR+R1hFNSMw/X46GQX2UYzJTL3Ib
         8bg6L2/Hkwo2sC7YetCmtekwMET2+PMPn65OZrFqtmOtrZ6FK3cQ7DgUGXYh6HyrioYJ
         i3aw==
X-Gm-Message-State: APjAAAVPKP/3Iz+z8kkCrd2XBWVpcjj8L2UaaxGSOHo/MURyTH0FMJ94
        9kAkEVBSLUW0XmX7b2/u7JjCmJ6ctwMgBy6ebCgNkwhVZ0m5
X-Google-Smtp-Source: APXvYqx4oOzu5t//LshFFaGh6KBOFeEHIHJYyBx9jm6FsErNxXc3DvJ35+y9V2zd917afxvZ1ZlLSOUTyPj9SXJupZ68Z5PZW5Lx
MIME-Version: 1.0
X-Received: by 2002:a5d:8143:: with SMTP id f3mr5612914ioo.294.1570053012399;
 Wed, 02 Oct 2019 14:50:12 -0700 (PDT)
Date:   Wed, 02 Oct 2019 14:50:12 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001530e00593f47496@google.com>
Subject: general protection fault in sit_exit_batch_net
From:   syzbot <syzbot+1695af5ca559927e2db8@syzkaller.appspotmail.com>
To:     davem@davemloft.net, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    c01ebd6c r8152: Use guard clause and fix comment typos
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10329447600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6ffbfa7e4a36190f
dashboard link: https://syzkaller.appspot.com/bug?extid=1695af5ca559927e2db8
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1156242b600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17253b19600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+1695af5ca559927e2db8@syzkaller.appspotmail.com

kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 21 Comm: kworker/u4:1 Not tainted 5.3.0+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: netns cleanup_net
RIP: 0010:dev_net include/linux/netdevice.h:2186 [inline]
RIP: 0010:sit_destroy_tunnels net/ipv6/sit.c:1831 [inline]
RIP: 0010:sit_exit_batch_net+0x3b1/0x750 net/ipv6/sit.c:1894
Code: fb 49 8d 7c 24 18 48 89 f8 48 c1 e8 03 80 3c 18 00 0f 85 27 02 00 00  
4d 8b 44 24 18 49 8d b8 80 05 00 00 48 89 f8 48 c1 e8 03 <80> 3c 18 00 0f  
85 f2 01 00 00 4d 3b a8 80 05 00 00 4c 89 85 58 ff
RSP: 0018:ffff8880a9a07b50 EFLAGS: 00010202
RAX: 00000000000000b0 RBX: dffffc0000000000 RCX: ffffffff865ad59f
RDX: 0000000000000000 RSI: ffffffff865ad488 RDI: 0000000000000580
RBP: ffff8880a9a07c08 R08: 0000000000000000 R09: fffffbfff1332f89
R10: fffffbfff1332f88 R11: ffffffff89997c47 R12: ffff88808b711140
R13: ffff88808f206300 R14: 0000000000000006 R15: ffff88808a9e8e50
FS:  0000000000000000(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000f8e000 CR3: 00000000980db000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  ops_exit_list.isra.0+0xfc/0x150 net/core/net_namespace.c:175
  cleanup_net+0x4e2/0xa60 net/core/net_namespace.c:594
  process_one_work+0x9af/0x1740 kernel/workqueue.c:2269
  worker_thread+0x98/0xe40 kernel/workqueue.c:2415
  kthread+0x361/0x430 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
Modules linked in:
---[ end trace 279fb1eb05d15843 ]---
RIP: 0010:dev_net include/linux/netdevice.h:2186 [inline]
RIP: 0010:sit_destroy_tunnels net/ipv6/sit.c:1831 [inline]
RIP: 0010:sit_exit_batch_net+0x3b1/0x750 net/ipv6/sit.c:1894
Code: fb 49 8d 7c 24 18 48 89 f8 48 c1 e8 03 80 3c 18 00 0f 85 27 02 00 00  
4d 8b 44 24 18 49 8d b8 80 05 00 00 48 89 f8 48 c1 e8 03 <80> 3c 18 00 0f  
85 f2 01 00 00 4d 3b a8 80 05 00 00 4c 89 85 58 ff
RSP: 0018:ffff8880a9a07b50 EFLAGS: 00010202
RAX: 00000000000000b0 RBX: dffffc0000000000 RCX: ffffffff865ad59f
RDX: 0000000000000000 RSI: ffffffff865ad488 RDI: 0000000000000580
RBP: ffff8880a9a07c08 R08: 0000000000000000 R09: fffffbfff1332f89
R10: fffffbfff1332f88 R11: ffffffff89997c47 R12: ffff88808b711140
R13: ffff88808f206300 R14: 0000000000000006 R15: ffff88808a9e8e50
FS:  0000000000000000(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000f8e000 CR3: 00000000980db000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
