Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA67C282E2
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 11:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1894F20850
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 11:13:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727761AbfDTLNH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 07:13:07 -0400
Received: from mail-it1-f199.google.com ([209.85.166.199]:43301 "EHLO
        mail-it1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbfDTLNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 07:13:06 -0400
Received: by mail-it1-f199.google.com with SMTP id m192so7910069ita.8
        for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2019 04:13:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=C3OsLnpDhNMTzXLUemQZ7plH6zAEsAJYSauXVjZ0yDY=;
        b=VwNou9tM8DrgxOthdpJB5+Q+7wmQiAjM3lXFN1leCDX7aw0jsZzk05ocz9wpjnGT8k
         TR3BkOIgqXYw5Je+9tUZ3+Xrf430yQ3sWFfoX9V686IIEBj4UGW+tBvpYsaM3Jnpjr+w
         tTB9UEnTdIQ7AGIrbHDwYqEr1weHm/0uz6AoacrEyKTYGqdW+1SdxsKNjKv65NBhrf73
         2sASD5iGk2S3AfggB1l69HHCwCZXjnMolsrfF2g6tZjdtiNV6vmscyy7Scc/HBeY7ODZ
         QkdaThiUboTHzqVfRM8JqusL7be+nYmVwoTmQoZaC2BnEiXvrD3+Ywze2cnYW/EYuZ/I
         aFuw==
X-Gm-Message-State: APjAAAUOCdodjA+AdOWBVCwghIQyg67YASQ+F9fjkp8kfU3zeh4BIeGA
        n1kO0jYko1HiSRyAJ0jPybd7fHlmCdMlTs6z9MGpzDC2q019
X-Google-Smtp-Source: APXvYqwUEY3GZRL5L05qVD82iOt5lzMCgyU9cDXmJVQHZlzDziI5g1GB8McKjYJYLsEDkWut18Zzz1oVJdp3pcGJN9uhl9q7zi5T
MIME-Version: 1.0
X-Received: by 2002:a5d:8441:: with SMTP id w1mr5052355ior.99.1555758785897;
 Sat, 20 Apr 2019 04:13:05 -0700 (PDT)
Date:   Sat, 20 Apr 2019 04:13:05 -0700
In-Reply-To: <000000000000e8cf3805867bd715@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ca2fee0586f451c5@google.com>
Subject: Re: WARNING: locking bug in lock_sock_nested
From:   syzbot <syzbot+605a69fff339d9cc221e@syzkaller.appspotmail.com>
To:     davem@davemloft.net, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    d7cc399e tcp: properly reset skb->truesize for tx recycling
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=168bd7b7200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=54210acf3a9ad2ad
dashboard link: https://syzkaller.appspot.com/bug?extid=605a69fff339d9cc221e
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=119fb72d200000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+605a69fff339d9cc221e@syzkaller.appspotmail.com

WARNING: CPU: 1 PID: 21195 at kernel/locking/lockdep.c:746  
arch_local_save_flags arch/x86/include/asm/paravirt.h:762 [inline]
WARNING: CPU: 1 PID: 21195 at kernel/locking/lockdep.c:746  
arch_local_save_flags arch/x86/include/asm/paravirt.h:760 [inline]
WARNING: CPU: 1 PID: 21195 at kernel/locking/lockdep.c:746  
look_up_lock_class kernel/locking/lockdep.c:737 [inline]
WARNING: CPU: 1 PID: 21195 at kernel/locking/lockdep.c:746  
register_lock_class+0xe10/0x1860 kernel/locking/lockdep.c:1090
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 21195 Comm: syz-executor.0 Not tainted 5.1.0-rc5+ #146
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  panic+0x2cb/0x65c kernel/panic.c:214
  __warn.cold+0x20/0x45 kernel/panic.c:571
  report_bug+0x263/0x2b0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:179 [inline]
  fixup_bug arch/x86/kernel/traps.c:174 [inline]
  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:272
  do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:291
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:973
RIP: 0010:look_up_lock_class kernel/locking/lockdep.c:746 [inline]
RIP: 0010:register_lock_class+0xe10/0x1860 kernel/locking/lockdep.c:1090
Code: 00 48 89 da 4d 8b 76 c0 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 80  
3c 02 00 0f 85 23 07 00 00 4c 89 33 e9 e3 f4 ff ff 0f 0b <0f> 0b e9 ea f3  
ff ff 44 89 e0 4c 8b 95 50 ff ff ff 83 c0 01 4c 8b
RSP: 0018:ffff8880977675e0 EFLAGS: 00010087
RAX: dffffc0000000000 RBX: ffff8880900aa7e0 RCX: 0000000000000000
RDX: 1ffff110120154ff RSI: 0000000000000000 RDI: ffff8880900aa7f8
RBP: ffff8880977676a8 R08: 1ffff11012eecec4 R09: ffffffff8a5d0a20
R10: ffffffff8a0b8408 R11: 0000000000000000 R12: ffffffff8a126780
R13: 0000000000000000 R14: 0000000000000000 R15: ffffffff87fbbe60
  __lock_acquire+0xf9/0x3fb0 kernel/locking/lockdep.c:3582
  lock_acquire+0x16f/0x3f0 kernel/locking/lockdep.c:4211
  __raw_spin_lock_bh include/linux/spinlock_api_smp.h:135 [inline]
  _raw_spin_lock_bh+0x33/0x50 kernel/locking/spinlock.c:168
  spin_lock_bh include/linux/spinlock.h:334 [inline]
  lock_sock_nested+0x41/0x120 net/core/sock.c:2912
  lock_sock include/net/sock.h:1520 [inline]
  do_ipv6_setsockopt.isra.0+0x27e/0x49e0 net/ipv6/ipv6_sockglue.c:167
  ipv6_setsockopt+0xfc/0x170 net/ipv6/ipv6_sockglue.c:946
  udpv6_setsockopt+0x68/0xb0 net/ipv6/udp.c:1570
  sock_common_setsockopt+0x9a/0xe0 net/core/sock.c:3125
  __sys_setsockopt+0x180/0x280 net/socket.c:2065
  __do_sys_setsockopt net/socket.c:2076 [inline]
  __se_sys_setsockopt net/socket.c:2073 [inline]
  __x64_sys_setsockopt+0xbe/0x150 net/socket.c:2073
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x458c29
Code: ad b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fdce1d99c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 0000000000458c29
RDX: 0000000000000023 RSI: 0000000000000029 RDI: 0000000000000004
RBP: 000000000073bfa0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fdce1d9a6d4
R13: 00000000004cd628 R14: 00000000004db978 R15: 00000000ffffffff
Kernel Offset: disabled
Rebooting in 86400 seconds..

