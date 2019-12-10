Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AFAFC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 04:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EA6720637
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 04:35:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbfLJEfJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 23:35:09 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:38963 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbfLJEfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 23:35:08 -0500
Received: by mail-io1-f70.google.com with SMTP id u13so12366956iol.6
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 20:35:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=ojUsEZmdHCxS3AxxhdmlegdxZox/znL15KjV4PQzpWY=;
        b=qZU/9qsS+1NDjxVF4YKjQHEUH7iMvG2l8XelaIP0IT2IiH1St/5Hw4yYLtl+pBHUpA
         Pkm5xVPBw3NwedHdt2owxz0MxvWSgqZ78x3aUp4lgyPzouPyZtj5v6nELfSsOz3ExG9F
         c2FP/ZzwcUV4ZDgiG90644nxxAYW2j+Uj8GSibFFsFbYNCD+meUEBN3ofl+nPfaL+aTi
         wK+esiyxdRHKzVx11vdlme4C7JmAL/v6/oOBNRCrfGBjm0cOqD/NOfSx+JXfWA46Rpqx
         R+1YNEu9G+P9CWISIRcWbpQBy9SLwjpMzphPuV3ejuABjf11uwuYP1lxATSKEDfIxcN9
         ZEqw==
X-Gm-Message-State: APjAAAUfspquVo+P9khr+PVcfB8lF1AzVebprnpkw/QQLsTMyghb2HIf
        V3Kgmak3HPyv3qGh1ieXUnOONo5hsduY1v7Vsj9CesLXXfhn
X-Google-Smtp-Source: APXvYqxtY4ucMI2e+tz8tCQDhxmqZLWTzAv+U0BPSTC6krA/zKqyEzVTXXPPyX9XbROjO707XOsxABLM7n78xjcpZIous7+eq2US
MIME-Version: 1.0
X-Received: by 2002:a92:9f9c:: with SMTP id z28mr32065504ilk.239.1575952507966;
 Mon, 09 Dec 2019 20:35:07 -0800 (PST)
Date:   Mon, 09 Dec 2019 20:35:07 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006b9e8d059952095e@google.com>
Subject: KASAN: global-out-of-bounds Read in fbcon_get_font
From:   syzbot <syzbot+29d4ed7f3bdedf2aa2fd@syzkaller.appspotmail.com>
To:     b.zolnierkie@samsung.com, daniel.vetter@ffwll.ch,
        dri-devel@lists.freedesktop.org, ghalat@redhat.com,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        maarten.lankhorst@linux.intel.com, sam@ravnborg.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    6cf8298d Add linux-next specific files for 20191209
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=168bbb7ae00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=682fc0ce6c86e3c7
dashboard link: https://syzkaller.appspot.com/bug?extid=29d4ed7f3bdedf2aa2fd
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12fff061e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+29d4ed7f3bdedf2aa2fd@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: global-out-of-bounds in memcpy include/linux/string.h:425  
[inline]
BUG: KASAN: global-out-of-bounds in fbcon_get_font+0x2b2/0x5e0  
drivers/video/fbdev/core/fbcon.c:2465
Read of size 32 at addr ffffffff88729d80 by task syz-executor.3/9100

CPU: 1 PID: 9100 Comm: syz-executor.3 Not tainted  
5.5.0-rc1-next-20191209-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x197/0x210 lib/dump_stack.c:118
  print_address_description.constprop.0.cold+0x5/0x30b mm/kasan/report.c:374
  __kasan_report.cold+0x1b/0x41 mm/kasan/report.c:506
  kasan_report+0x12/0x20 mm/kasan/common.c:639
  check_memory_region_inline mm/kasan/generic.c:185 [inline]
  check_memory_region+0x134/0x1a0 mm/kasan/generic.c:192
  memcpy+0x24/0x50 mm/kasan/common.c:125
  memcpy include/linux/string.h:425 [inline]
  fbcon_get_font+0x2b2/0x5e0 drivers/video/fbdev/core/fbcon.c:2465
  con_font_get drivers/tty/vt/vt.c:4446 [inline]
  con_font_op+0x20b/0x1270 drivers/tty/vt/vt.c:4605
  vt_ioctl+0xd2e/0x26d0 drivers/tty/vt/vt_ioctl.c:913
  tty_ioctl+0xa37/0x14f0 drivers/tty/tty_io.c:2660
  vfs_ioctl fs/ioctl.c:47 [inline]
  file_ioctl fs/ioctl.c:545 [inline]
  do_vfs_ioctl+0x977/0x14e0 fs/ioctl.c:732
  ksys_ioctl+0xab/0xd0 fs/ioctl.c:749
  __do_sys_ioctl fs/ioctl.c:756 [inline]
  __se_sys_ioctl fs/ioctl.c:754 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:754
  do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x45a6f9
Code: ad b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f30314dcc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 000000000045a6f9
RDX: 0000000000713000 RSI: 0000000000004b60 RDI: 0000000000000004
RBP: 000000000075bf20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f30314dd6d4
R13: 00000000004c6d87 R14: 00000000004dd3e0 R15: 00000000ffffffff

The buggy address belongs to the variable:
  fontdata_8x16+0x1000/0x1120

Memory state around the buggy address:
  ffffffff88729c80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  ffffffff88729d00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ffffffff88729d80: fa fa fa fa 06 fa fa fa fa fa fa fa 05 fa fa fa
                    ^
  ffffffff88729e00: fa fa fa fa 06 fa fa fa fa fa fa fa 00 00 03 fa
  ffffffff88729e80: fa fa fa fa 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
