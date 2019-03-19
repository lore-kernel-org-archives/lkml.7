Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CECBC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 09:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E25722133D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 09:22:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725934AbfCSJWH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 05:22:07 -0400
Received: from mail-it1-f197.google.com ([209.85.166.197]:59398 "EHLO
        mail-it1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfCSJWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 05:22:07 -0400
Received: by mail-it1-f197.google.com with SMTP id q192so16892575itb.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 02:22:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=68PR9i057fb2VeUJEDF2IpnYp6Zs2c3XuTUvDbQkTG4=;
        b=ZaMJCWZzTTC9bglVUEZApkE58TMkRyjPB6b5ZruFi28NzXhr1m2/cONyXYjAG3Souq
         WS1nMBTFhcvFP6mSaWodK1+eMGaWvMCpsE5o0uov+rPKyCVvAVo3k919gSPx+ANKCJvf
         9TgfH67rNXMhceKpqFKLcqoR8Un+iiax7gHkod4fHq0fEPbwx4EPfI51uyoxcrKf9HDX
         PCw/Ljpcews7IS+v5fAde1bjjdzuFrBcDJRHIzEKBOiK6c/OZV1b60kfr2LtkiVwL0+b
         MC1uUuse5ytM3V27RooWVM6Q4p4T11pWiSPX6paBtO3Z+bkopR68nY7uoVai9DjDWJ8Z
         Mjgw==
X-Gm-Message-State: APjAAAUQ4F5wIzLvjJaYHhrTzONifbo3K1ETsqdv+9PaCQvAME03ORNp
        8DSKtJ6v++NtdiwSDujI/Pz2PzwyIX0GURRDQDEKLXgFK0eE
X-Google-Smtp-Source: APXvYqyaPxkoRayzP3cxej1RX1MgxId799XnT2gRR+rJM0MwPPtX+JzNgB7pkREOwgQEh8Pl4QFfoE3nIHlzC4+qrZea+o815Ngk
MIME-Version: 1.0
X-Received: by 2002:a24:21c8:: with SMTP id e191mr891962ita.25.1552987325434;
 Tue, 19 Mar 2019 02:22:05 -0700 (PDT)
Date:   Tue, 19 Mar 2019 02:22:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000df93f705846f0963@google.com>
Subject: general protection fault in ip6_dst_hoplimit
From:   syzbot <syzbot+4c869fc20129562c53fa@syzkaller.appspotmail.com>
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

HEAD commit:    d9862cfb Merge tag 'mips_5.1' of git://git.kernel.org/pub/..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12747c93200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=73d88a42238825ad
dashboard link: https://syzkaller.appspot.com/bug?extid=4c869fc20129562c53fa
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+4c869fc20129562c53fa@syzkaller.appspotmail.com

dst_release: dst:00000000f3b89511 refcnt:-2120685656
dst_release: dst:00000000f3b89511 refcnt:-2120685656
IPVS: set_ctl: invalid protocol: 46 0.0.4.1:20003
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 14303 Comm: syz-executor.2 Not tainted 5.0.0+ #97
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:ip6_dst_hoplimit+0x26/0x3f0 net/ipv6/output_core.c:127
Code: 00 00 00 00 55 48 89 e5 41 55 41 54 53 48 89 fb e8 0f 2e 4b fb 48 8d  
7b 10 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f  
85 7d 03 00 00 48 b8 00 00 00 00 00 fc ff df 4c 8b
RSP: 0018:ffff888029bb77c8 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: 0000000000004a58 RCX: ffffc9000a21d000
RDX: 000000000000094d RSI: ffffffff86248861 RDI: 0000000000004a68
RBP: ffff888029bb77e0 R08: ffff888096e1e400 R09: ffffed1015d25021
R10: ffffed1015d25bcf R11: ffff8880ae928107 R12: ffff888064f31880
R13: 0000000000004a58 R14: 0000000000000000 R15: ffff888029bb7e20
FS:  00007f66dbd52700(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f5833499000 CR3: 000000009ae87000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  ip6_sk_dst_hoplimit include/net/ipv6.h:765 [inline]
  udpv6_sendmsg+0x23af/0x28d0 net/ipv6/udp.c:1459
  inet_sendmsg+0x147/0x5d0 net/ipv4/af_inet.c:798
  sock_sendmsg_nosec net/socket.c:622 [inline]
  sock_sendmsg+0xdd/0x130 net/socket.c:632
  ___sys_sendmsg+0x806/0x930 net/socket.c:2137
  __sys_sendmsg+0x105/0x1d0 net/socket.c:2175
  __do_sys_sendmsg net/socket.c:2184 [inline]
  __se_sys_sendmsg net/socket.c:2182 [inline]
  __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2182
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
kobject: 'loop5' (000000000bae834e): kobject_uevent_env
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x458079
Code: ad b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f66dbd51c78 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
kobject: 'loop5' (000000000bae834e): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000458079
RDX: 0000000000000000 RSI: 0000000020002b80 RDI: 0000000000000003
RBP: 000000000073bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f66dbd526d4
R13: 00000000004c5601 R14: 00000000004d94a8 R15: 00000000ffffffff
Modules linked in:
kobject: 'loop4' (0000000057f28e01): kobject_uevent_env
---[ end trace ad1e9a18c63dc6fd ]---
kobject: 'ip6gre0' (00000000482f98f6): kobject_cleanup, parent            
(null)
RIP: 0010:ip6_dst_hoplimit+0x26/0x3f0 net/ipv6/output_core.c:127
kobject: 'loop4' (0000000057f28e01): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
Code: 00 00 00 00 55 48 89 e5 41 55 41 54 53 48 89 fb e8 0f 2e 4b fb 48 8d  
7b 10 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f  
85 7d 03 00 00 48 b8 00 00 00 00 00 fc ff df 4c 8b
kobject: 'ip6gre0' (00000000482f98f6): auto cleanup 'remove' event
RSP: 0018:ffff888029bb77c8 EFLAGS: 00010206
kobject: 'loop3' (000000006d432d43): kobject_uevent_env
RAX: dffffc0000000000 RBX: 0000000000004a58 RCX: ffffc9000a21d000
kobject: 'ip6gre0' (00000000482f98f6): kobject_uevent_env
RDX: 000000000000094d RSI: ffffffff86248861 RDI: 0000000000004a68
kobject: 'loop3' (000000006d432d43): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
RBP: ffff888029bb77e0 R08: ffff888096e1e400 R09: ffffed1015d25021
kobject: 'ip6gre0' (00000000482f98f6): kobject_uevent_env: uevent_suppress  
caused the event to drop!
R10: ffffed1015d25bcf R11: ffff8880ae928107 R12: ffff888064f31880
kobject: 'ip6gre0' (00000000482f98f6): calling ktype release
R13: 0000000000004a58 R14: 0000000000000000 R15: ffff888029bb7e20
kobject: 'ip6gre0': free name
FS:  00007f66dbd52700(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000625208 CR3: 000000009ae87000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
kobject: 'rx-0' (00000000e6299323): kobject_cleanup, parent 000000006ae1d517
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
