Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60983C43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 07:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B3A92086D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 07:17:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404225AbfFKHRG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 03:17:06 -0400
Received: from mail-it1-f198.google.com ([209.85.166.198]:44461 "EHLO
        mail-it1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403989AbfFKHRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 03:17:05 -0400
Received: by mail-it1-f198.google.com with SMTP id o83so1568583itc.9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 00:17:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=QjZO4tpNW3xfQ7G62g/3e8FGmq0plm8GqMkIHwnW2ss=;
        b=Muen+EovHAppnAZK42mDVfCrWaO5OOcq+PtML7KB3TBNF29fGSBuuQ30i9rxGnvrY9
         cUO4qDRdkY9nnjHAeUJRIVP9XpnLS+w3Gigetenay8eauVNJIxiQJzA95swp9HIZ2QGX
         TPhFjw558AJ1wyGOEKtBfmsXc8V+I080x2rj3t8vxyGGwOELjVPG4MKQzAWzpAZCkqRj
         buzYpmohSsakQSf2SaQGMJTWDpR1uJg5HQy21r9nYisG57i+pxCGajlC4ftFG11XCQz8
         dT3mExwpLuBuZg6tFllJcrp0iOZ8KibcuRwJSDeaa6vyCiYgRhOiskOyH5Lhhei+KMF2
         FX0g==
X-Gm-Message-State: APjAAAXbA4mhrqXZm9cVwI5XWOlxBX/LkyScsiyQGQt8+Ye9NIEUCZXO
        Dx7/RrtHIbUxqLgK9yj5FkmKJ2ZxqEJc03fYBXQxXxpcv6nN
X-Google-Smtp-Source: APXvYqwQezJk91zRFz6a6YDfa+lnroxvsrETeBHfG7tYh5e1W7/oZ+Y5SGs9hTUEPrRoXRgDP4pWjntKridoWafqjBSebc+La7Hj
MIME-Version: 1.0
X-Received: by 2002:a02:1948:: with SMTP id b69mr26512965jab.55.1560237425090;
 Tue, 11 Jun 2019 00:17:05 -0700 (PDT)
Date:   Tue, 11 Jun 2019 00:17:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007ce6f5058b0715ea@google.com>
Subject: KASAN: null-ptr-deref Read in x25_connect
From:   syzbot <syzbot+777a2aab6ffd397407b5@syzkaller.appspotmail.com>
To:     allison@lohutok.net, andrew.hendry@gmail.com, arnd@arndb.de,
        davem@davemloft.net, edumazet@google.com,
        linux-kernel@vger.kernel.org, linux-x25@vger.kernel.org,
        ms@dev.tdt.de, netdev@vger.kernel.org, nhorman@tuxdriver.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    f4cfcfbd net: dsa: sja1105: Fix link speed not working at ..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=16815cd2a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4f721a391cd46ea
dashboard link: https://syzkaller.appspot.com/bug?extid=777a2aab6ffd397407b5
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+777a2aab6ffd397407b5@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: null-ptr-deref in atomic_read  
include/asm-generic/atomic-instrumented.h:26 [inline]
BUG: KASAN: null-ptr-deref in refcount_sub_and_test_checked+0x87/0x200  
lib/refcount.c:182
Read of size 4 at addr 00000000000000c8 by task syz-executor.2/16959

CPU: 0 PID: 16959 Comm: syz-executor.2 Not tainted 5.2.0-rc2+ #40
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  __kasan_report.cold+0x5/0x40 mm/kasan/report.c:321
  kasan_report+0x12/0x20 mm/kasan/common.c:614
  check_memory_region_inline mm/kasan/generic.c:185 [inline]
  check_memory_region+0x123/0x190 mm/kasan/generic.c:191
  kasan_check_read+0x11/0x20 mm/kasan/common.c:94
  atomic_read include/asm-generic/atomic-instrumented.h:26 [inline]
  refcount_sub_and_test_checked+0x87/0x200 lib/refcount.c:182
  refcount_dec_and_test_checked+0x1b/0x20 lib/refcount.c:220
  x25_neigh_put include/net/x25.h:252 [inline]
  x25_connect+0x8d8/0xea0 net/x25/af_x25.c:820
  __sys_connect+0x264/0x330 net/socket.c:1840
  __do_sys_connect net/socket.c:1851 [inline]
  __se_sys_connect net/socket.c:1848 [inline]
  __x64_sys_connect+0x73/0xb0 net/socket.c:1848
  do_syscall_64+0xfd/0x680 arch/x86/entry/common.c:301
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x459279
Code: fd b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f09776b4c78 EFLAGS: 00000246 ORIG_RAX: 000000000000002a
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000459279
RDX: 0000000000000012 RSI: 0000000020000280 RDI: 0000000000000004
RBP: 000000000075bfc0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f09776b56d4
R13: 00000000004bf854 R14: 00000000004d0e08 R15: 00000000ffffffff
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
