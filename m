Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57CE3C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 12:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3081020656
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 12:06:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728207AbfD2MGJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 08:06:09 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:40906 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728164AbfD2MGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 08:06:07 -0400
Received: by mail-io1-f70.google.com with SMTP id y10so8592115ioj.7
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 05:06:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=2OKFrl0iztzbP3p1e8FXflIAxnOKYTyuwdcHCmFUgac=;
        b=i471bWS247OEQwqGdMLI/aR0UtAqCP+4Re5bF0yk6Mzofq9bevSSP3abT7UzmJD7YG
         vwbJWrGqKl7MVUGYo3C9rLFeToU9Wo1enUfffR/tXjkHblQSEIC2YvstgEnuOIs2pN4f
         Htd8KH1iIKqU/SD+MLZDU5pwZTu3KouyGGkImdeSfK7GR0o877s7wpObw0jHdyDsn05r
         uRUns8hqVx94YA4xc6/7dpICw/lMbxUV98wdHwELwXVvJkPMFrxHr7ptJmfvYRYHPQ4X
         7bRV0U034y405VLYllrV401/ptOwkltzVx/maU5v31D38Zx7s7sADpASFKsRWIaM7Ofm
         c1nw==
X-Gm-Message-State: APjAAAVmCoq1RkrAgkLuCs7xSYYX0g5Y2VFglrbdfXxlTvWwjKnqzLfP
        p29R1hIQVaoOqrH3hRnM2Hks2wD/Yfs1CjNvCBdEuruzhs3g
X-Google-Smtp-Source: APXvYqz3NyLk2zuX1NNIYhzXyOJdTnzzQK8nJWPItWhEO6u50uRLlD1ulqcMVxkBABBeJtBlBPqoKfN0cH4pgG/s9bH2v3X/xKSD
MIME-Version: 1.0
X-Received: by 2002:a5d:9489:: with SMTP id v9mr31225502ioj.129.1556539566644;
 Mon, 29 Apr 2019 05:06:06 -0700 (PDT)
Date:   Mon, 29 Apr 2019 05:06:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f2e3f90587aa1b2b@google.com>
Subject: KASAN: null-ptr-deref Read in zr364xx_vidioc_querycap
From:   syzbot <syzbot+66010012fd4c531a1a96@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-usb@vger.kernel.org,
        mchehab@kernel.org, royale@zerezo.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    43151d6c usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan/tree/usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=139fc338a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4183eeef650d1234
dashboard link: https://syzkaller.appspot.com/bug?extid=66010012fd4c531a1a96
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1661d17ca00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=177d7262a00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+66010012fd4c531a1a96@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: null-ptr-deref in read_word_at_a_time+0xe/0x20  
include/linux/compiler.h:274
Read of size 1 at addr 0000000000000000 by task v4l_id/5287

CPU: 1 PID: 5287 Comm: v4l_id Not tainted 5.1.0-rc3-319004-g43151d6 #6
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0xe8/0x16e lib/dump_stack.c:113
  kasan_report.cold+0x5/0x3c mm/kasan/report.c:321
  read_word_at_a_time+0xe/0x20 include/linux/compiler.h:274
  strscpy+0x8a/0x280 lib/string.c:207
  zr364xx_vidioc_querycap+0xb5/0x210 drivers/media/usb/zr364xx/zr364xx.c:706
  v4l_querycap+0x12b/0x340 drivers/media/v4l2-core/v4l2-ioctl.c:1062
  __video_do_ioctl+0x5bb/0xb40 drivers/media/v4l2-core/v4l2-ioctl.c:2874
  video_usercopy+0x44e/0xf00 drivers/media/v4l2-core/v4l2-ioctl.c:3056
  v4l2_ioctl+0x14e/0x1a0 drivers/media/v4l2-core/v4l2-dev.c:364
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:509 [inline]
  do_vfs_ioctl+0xced/0x12f0 fs/ioctl.c:696
  ksys_ioctl+0xa0/0xc0 fs/ioctl.c:713
  __do_sys_ioctl fs/ioctl.c:720 [inline]
  __se_sys_ioctl fs/ioctl.c:718 [inline]
  __x64_sys_ioctl+0x74/0xb0 fs/ioctl.c:718
  do_syscall_64+0xcf/0x4f0 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x7f3b56d8b347
Code: 90 90 90 48 8b 05 f1 fa 2a 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff  
ff c3 90 90 90 90 90 90 90 90 90 90 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff  
ff 73 01 c3 48 8b 0d c1 fa 2a 00 31 d2 48 29 c2 64
RSP: 002b:00007ffe005d5d68 EFLAGS: 00000202 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f3b56d8b347
RDX: 00007ffe005d5d70 RSI: 0000000080685600 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000400884
R13: 00007ffe005d5ec0 R14: 0000000000000000 R15: 0000000000000000
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
