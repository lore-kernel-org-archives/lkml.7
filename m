Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF5AFC00523
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 08:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B998B20692
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 08:54:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbgAHIyJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 03:54:09 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:51030 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbgAHIyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 03:54:08 -0500
Received: by mail-io1-f71.google.com with SMTP id e13so1584357iob.17
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 00:54:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=CFhRXBAPkp3HOw0zFSFHjSLWMRlV6H8zc3Zr+P2zvJI=;
        b=fdILmE7wb9z7c3VpuNVqMj/uDkuvvEayTOZpMMwM1faC7BM1i38YmTNtVDjmOSb9xY
         DNEApY3UN7EYafCNHxJcXwn6tv+beAJOzpimfxtZm9MsqTnH0KafS2vALZacHnnZPKws
         phljTw820wfO2x35NvWk1zWJwN9pwU4wg10NaMaVLsi2obTHt85hl3C9jClc/+7N4RwL
         IVkX6e5bHPL62OpeVBIjYJQsFWtPub3aR/zp+5UI+YYHH0ye9JjPyk2+jnJesfQhDy3U
         rIVVFqpVMKg8SLkoeFDH1LcBhZnfC28tA2XZa8lapoVoKqeKLrC9TrPofDi58QJiHGri
         nyrQ==
X-Gm-Message-State: APjAAAVIyVNXPtA/lTM8QPdvAQUaVbT5suKIBbAGRNozkGpXJTXG75F1
        IwRJgE+334D/bWk4I7lU7V/ldcPLWBeE4wC/3c3+SW2Zdwjb
X-Google-Smtp-Source: APXvYqxIMvUyuBh2ReGUwTb13pBBDUHNhkCI9ta1jVx8scKpG3zpnYjyuai5epnORcO/yAcLDUyDVBlxcFJ9nZCb+1MGOIJjnxeW
MIME-Version: 1.0
X-Received: by 2002:a02:b703:: with SMTP id g3mr3187063jam.101.1578473647870;
 Wed, 08 Jan 2020 00:54:07 -0800 (PST)
Date:   Wed, 08 Jan 2020 00:54:07 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000119c91059b9d092f@google.com>
Subject: KASAN: null-ptr-deref Write in video_usercopy
From:   syzbot <syzbot+9240c422be249a8422bd@syzkaller.appspotmail.com>
To:     arnd@arndb.de, hverkuil-cisco@xs4all.nl,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        mchehab+huawei@kernel.org, mchehab@kernel.org,
        sakari.ailus@linux.intel.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    26467385 Add linux-next specific files for 20200107
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14160915e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2265a716722be976
dashboard link: https://syzkaller.appspot.com/bug?extid=9240c422be249a8422bd
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15d162aee00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16b9c469e00000

The bug was bisected to:

commit c8ef1a6076bfb986052ff8fd8f5eb3b3a3f1048e
Author: Arnd Bergmann <arnd@arndb.de>
Date:   Mon Dec 16 14:15:02 2019 +0000

     media: v4l2-core: split out data copy from video_usercopy

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13442bc1e00000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=10c42bc1e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=17442bc1e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+9240c422be249a8422bd@syzkaller.appspotmail.com
Fixes: c8ef1a6076bf ("media: v4l2-core: split out data copy from  
video_usercopy")

==================================================================
BUG: KASAN: null-ptr-deref in memset include/linux/string.h:411 [inline]
BUG: KASAN: null-ptr-deref in video_get_user+0x67f/0x890  
drivers/media/v4l2-core/v4l2-ioctl.c:3053
Write of size 512 at addr 0000000000000000 by task syz-executor806/9573

CPU: 0 PID: 9573 Comm: syz-executor806 Not tainted  
5.5.0-rc5-next-20200107-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x197/0x210 lib/dump_stack.c:118
  __kasan_report.cold+0x5/0x32 mm/kasan/report.c:510
  kasan_report+0x12/0x20 mm/kasan/common.c:641
  check_memory_region_inline mm/kasan/generic.c:185 [inline]
  check_memory_region+0x134/0x1a0 mm/kasan/generic.c:192
  memset+0x24/0x40 mm/kasan/common.c:108
  memset include/linux/string.h:411 [inline]
  video_get_user+0x67f/0x890 drivers/media/v4l2-core/v4l2-ioctl.c:3053
  video_usercopy+0x21f/0x10b0 drivers/media/v4l2-core/v4l2-ioctl.c:3210
  video_ioctl2+0x2d/0x35 drivers/media/v4l2-core/v4l2-ioctl.c:3274
  v4l2_ioctl+0x1ac/0x230 drivers/media/v4l2-core/v4l2-dev.c:360
  vfs_ioctl fs/ioctl.c:47 [inline]
  ksys_ioctl+0x123/0x180 fs/ioctl.c:747
  __do_sys_ioctl fs/ioctl.c:756 [inline]
  __se_sys_ioctl fs/ioctl.c:754 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:754
  do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x440189
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 fb 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffffba225e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 0000000000440189
RDX: 0000000000000000 RSI: 0000001002008914 RDI: 0000000000000003
RBP: 00000000006ca018 R08: 00000000004002c8 R09: 00000000004002c8
R10: 00000000004002c8 R11: 0000000000000246 R12: 0000000000401a10
R13: 0000000000401aa0 R14: 0000000000000000 R15: 0000000000000000
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
