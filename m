Return-Path: <SRS0=XJun=WH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2494C433FF
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 20:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6C662084D
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 20:46:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbfHKUqH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Aug 2019 16:46:07 -0400
Received: from mail-ot1-f72.google.com ([209.85.210.72]:50283 "EHLO
        mail-ot1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbfHKUqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Aug 2019 16:46:07 -0400
Received: by mail-ot1-f72.google.com with SMTP id a21so80989213otk.17
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2019 13:46:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=hIIaaiKdPwn2kEBr134a1PjxuPX6cL63tidde0GvFDE=;
        b=aDXqwy9Vlcvk1SlwmsTyoOVPWSc4vXRR76SKScjY8z3KJ7ftx7DTBe0oK2QCuYmnlm
         ZykTynwqjPWVFJ4LIaSgmnUQYwbGLpIf+MOUhm8cIZug3nH9jkPvcYqT8YJvsQIXlRfN
         bpRbDV86Hp39difGCsCCfmsW055KGZBmfoWAxPjeaSoPyX2BxuAq2gl1t4NUxKq1F78d
         j4hZWfPgyU8g3YuGX9pRKclpF3zTE1HwpDk5l0oAyg+Epl0KldOHYP1yOnFYRNqEpT3+
         809CBJ/fYC6KLbmM/2H2LJHQZ7ftIia7On+hlFHfJF8hO1Db7bCh5N9AAp/zXju6taiy
         cASg==
X-Gm-Message-State: APjAAAWmWx/AnChewZvWCKwwG1g+9ftGL77gTVR2RXU/uXjoC7Bz1bhD
        RLOA+3bGrbuCIDnKW44NumtbdxXvw8ynzPfC+egbGkHq8Nru
X-Google-Smtp-Source: APXvYqwyP/uubKN/gLvfhN2Ek5wd27rQuzspLmz6GAD+gMd5MOWy4cAo7hTu8OvMxmVTFn1KciGX+0Vlz+d9yEORr4Kv6Fq+9sKq
MIME-Version: 1.0
X-Received: by 2002:a5d:9ad6:: with SMTP id x22mr5710467ion.136.1565556366293;
 Sun, 11 Aug 2019 13:46:06 -0700 (PDT)
Date:   Sun, 11 Aug 2019 13:46:06 -0700
In-Reply-To: <00000000000008b8c6058ee52407@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000016c09c058fdd7faa@google.com>
Subject: Re: KASAN: slab-out-of-bounds Read in hidraw_ioctl
From:   syzbot <syzbot+5a6c4ec678a0c6ee84ba@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, benjamin.tissoires@redhat.com,
        jikos@kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    e96407b4 usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=150426ba600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cfa2c18fb6a8068e
dashboard link: https://syzkaller.appspot.com/bug?extid=5a6c4ec678a0c6ee84ba
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12725c02600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=162163c2600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+5a6c4ec678a0c6ee84ba@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in strlen+0x79/0x90 lib/string.c:525
Read of size 1 at addr ffff8881d29bdf38 by task syz-executor201/1726

CPU: 1 PID: 1726 Comm: syz-executor201 Not tainted 5.3.0-rc2+ #25
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0xca/0x13e lib/dump_stack.c:113
  print_address_description+0x6a/0x32c mm/kasan/report.c:351
  __kasan_report.cold+0x1a/0x33 mm/kasan/report.c:482
  kasan_report+0xe/0x12 mm/kasan/common.c:612
  strlen+0x79/0x90 lib/string.c:525
  strlen include/linux/string.h:281 [inline]
  hidraw_ioctl+0x245/0xae0 drivers/hid/hidraw.c:446
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:509 [inline]
  do_vfs_ioctl+0xd2d/0x1330 fs/ioctl.c:696
  ksys_ioctl+0x9b/0xc0 fs/ioctl.c:713
  __do_sys_ioctl fs/ioctl.c:720 [inline]
  __se_sys_ioctl fs/ioctl.c:718 [inline]
  __x64_sys_ioctl+0x6f/0xb0 fs/ioctl.c:718
  do_syscall_64+0xb7/0x580 arch/x86/entry/common.c:296
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x445679
Code: e8 5c ad 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 9b cd fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffc8514f3a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000445679
RDX: 0000000000000000 RSI: 0000000080404805 RDI: 0000000000000004
RBP: 00000000006d0018 R08: 000000000000000b R09: 00000000004002e0
R10: 000000000000000f R11: 0000000000000246 R12: 00000000004028a0
R13: 0000000000402930 R14: 0000000000000000 R15: 0000000000000000

Allocated by task 0:
(stack is not available)

Freed by task 0:
(stack is not available)

The buggy address belongs to the object at ffff8881d29bde60
  which belongs to the cache shmem_inode_cache of size 1168
The buggy address is located 216 bytes inside of
  1168-byte region [ffff8881d29bde60, ffff8881d29be2f0)
The buggy address belongs to the page:
page:ffffea00074a6f00 refcount:1 mapcount:0 mapping:ffff8881da115180  
index:0x0 compound_mapcount: 0
flags: 0x200000000010200(slab|head)
raw: 0200000000010200 dead000000000100 dead000000000122 ffff8881da115180
raw: 0000000000000000 00000000800c000c 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8881d29bde00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff8881d29bde80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> ffff8881d29bdf00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                                         ^
  ffff8881d29bdf80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff8881d29be000: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================

