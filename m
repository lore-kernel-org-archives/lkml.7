Return-Path: <SRS0=X3/1=2E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 773A4C43603
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 21:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DAF5214AF
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 21:04:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbfLNVEN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Dec 2019 16:04:13 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:50655 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbfLNVEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 16:04:11 -0500
Received: by mail-il1-f198.google.com with SMTP id l63so2816272ili.17
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2019 13:04:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=5oMQhE5HOZJYBQ6RqbQJx/czIjoLVj+jVnaKVFlcXMU=;
        b=f5QeluflIOB3P/Qs7cIvw7W1cFZsn9Lf2RCyq5j4VNKFDRUtLhNWdw5Gmzbwv+gd+X
         A7NWHenA6Xqyoko91Z+Xr5dQfum5i/ZULM2mkhDHsxMON+TLXZHNrCVJIs1mPWyow5yj
         9ckJZrrMSPJ4PDqjslRqcD8HycvGU9OsXFfebORr5/z0ai0/1T3MIBKecXAGdvdbw36t
         L3GSO23xYS3afMj8PVWpLC9lvZr7hklk8PZQxEbc2Tsu7cOEOSrrdWWB2zEoKEUjlLXg
         oEXrgJ1JhtiRp46yyJm4USh+G6feleXqYoM2iSrRyFPZU6WE8ZU+q13yntr1LVd2p9i5
         NvWQ==
X-Gm-Message-State: APjAAAXI0K2/v4kU/nmo0E9ySUF/a/dLTjA5QApYjVDY+yJD9qrMp/p2
        /GQLSIUQray/ibOoQxKQze9ChD5FNuUBpBDj0TNiAo72DqCu
X-Google-Smtp-Source: APXvYqzIIvNB75c9O/IyF97cbZfnfUqtNQ0qJre+iGIKqCUtcPv+ZK7OT/QHSYMbv+9zpuk/V6aVH27j12HBKzI6ORM/Rl2bVUyo
MIME-Version: 1.0
X-Received: by 2002:a92:910b:: with SMTP id t11mr5568680ild.195.1576357449273;
 Sat, 14 Dec 2019 13:04:09 -0800 (PST)
Date:   Sat, 14 Dec 2019 13:04:09 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cd9e600599b051e5@google.com>
Subject: KASAN: vmalloc-out-of-bounds Read in compat_copy_entries
From:   syzbot <syzbot+f68108fed972453a0ad4@syzkaller.appspotmail.com>
To:     bridge@lists.linux-foundation.org, coreteam@netfilter.org,
        davem@davemloft.net, fw@strlen.de, kadlec@netfilter.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        netfilter-devel@vger.kernel.org, nikolay@cumulusnetworks.com,
        pablo@netfilter.org, roopa@cumulusnetworks.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    e31736d9 Merge tag 'nios2-v5.5-rc2' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14a4f5dee00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=79f79de2a27d3e3d
dashboard link: https://syzkaller.appspot.com/bug?extid=f68108fed972453a0ad4
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11c105dee00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12f1e32ee00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+f68108fed972453a0ad4@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: vmalloc-out-of-bounds in size_entry_mwt  
net/bridge/netfilter/ebtables.c:2063 [inline]
BUG: KASAN: vmalloc-out-of-bounds in compat_copy_entries+0x128b/0x1380  
net/bridge/netfilter/ebtables.c:2155
Read of size 4 at addr ffffc900004461f4 by task syz-executor267/7937

CPU: 1 PID: 7937 Comm: syz-executor267 Not tainted 5.5.0-rc1-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS  
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x197/0x210 lib/dump_stack.c:118
  print_address_description.constprop.0.cold+0x5/0x30b mm/kasan/report.c:374
  __kasan_report.cold+0x1b/0x41 mm/kasan/report.c:506
  kasan_report+0x12/0x20 mm/kasan/common.c:639
  __asan_report_load4_noabort+0x14/0x20 mm/kasan/generic_report.c:134
  size_entry_mwt net/bridge/netfilter/ebtables.c:2063 [inline]
  compat_copy_entries+0x128b/0x1380 net/bridge/netfilter/ebtables.c:2155
  compat_do_replace+0x344/0x720 net/bridge/netfilter/ebtables.c:2249
  compat_do_ebt_set_ctl+0x22f/0x27e net/bridge/netfilter/ebtables.c:2333
  compat_nf_sockopt net/netfilter/nf_sockopt.c:144 [inline]
  compat_nf_setsockopt+0x98/0x140 net/netfilter/nf_sockopt.c:156
  compat_ip_setsockopt net/ipv4/ip_sockglue.c:1286 [inline]
  compat_ip_setsockopt+0x106/0x140 net/ipv4/ip_sockglue.c:1267
  compat_udp_setsockopt+0x68/0xb0 net/ipv4/udp.c:2649
  compat_sock_common_setsockopt+0xb2/0x140 net/core/sock.c:3160
  __compat_sys_setsockopt+0x185/0x380 net/compat.c:384
  __do_compat_sys_setsockopt net/compat.c:397 [inline]
  __se_compat_sys_setsockopt net/compat.c:394 [inline]
  __ia32_compat_sys_setsockopt+0xbd/0x150 net/compat.c:394
  do_syscall_32_irqs_on arch/x86/entry/common.c:337 [inline]
  do_fast_syscall_32+0x27b/0xe16 arch/x86/entry/common.c:408
  entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat.S:139
RIP: 0023:0xf7fc3a39
Code: 00 00 00 89 d3 5b 5e 5f 5d c3 b8 80 96 98 00 eb c4 8b 04 24 c3 8b 1c  
24 c3 8b 34 24 c3 8b 3c 24 c3 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90  
90 90 90 eb 0d 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 002b:00000000ffab2b4c EFLAGS: 00000296 ORIG_RAX: 000000000000016e
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000000000
RDX: 0000000000000080 RSI: 0000000020000240 RDI: 0000000000000212
RBP: 0000000000000012 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000


Memory state around the buggy address:
  ffffc90000446080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  ffffc90000446100: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ffffc90000446180: 00 00 00 00 00 00 00 00 02 f9 f9 f9 f9 f9 f9 f9
                                                              ^
  ffffc90000446200: f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9
  ffffc90000446280: f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
