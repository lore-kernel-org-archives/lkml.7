Return-Path: <SRS0=daYT=YG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C008FC4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 20:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97CD620673
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 20:55:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729419AbfJMUzK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Oct 2019 16:55:10 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:48998 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727492AbfJMUzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Oct 2019 16:55:10 -0400
Received: by mail-io1-f71.google.com with SMTP id w16so23338109ioc.15
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2019 13:55:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=zhDjj24S80iGMjvukKDlOLStu3vUnLHYlWHFoMmucEo=;
        b=tYyf+ouRbWB5IwXlewiCeaIrJ5zTzmTKYqc2ZYEaYRURmcrdOCICRnH1grhpKQikvi
         UEBD+Pgm/Pm/3rSLIf9UXkfrr9d0azonSIXms+KIC6FTQPeOyOiESjZEl+yktBkRnTZJ
         ho1X11zaPsMPctJ0miurabF8FgloTdPDhnEhW0k+QTidCcz9YpLH67e3bU3u88XBdj2j
         iIszAaLMRKV6PacghksmbPlaO1fA20l3E5mEnhShQ1pAvGltKGOn+EmAtPyfVMfYpTZP
         LioPg6TWxv1ZCV93DT26z+1MasI66gJRXry4K02pjq9WM3tGniO6/SdnRsB1MFcZc/7T
         PDGA==
X-Gm-Message-State: APjAAAVH5NSv85DJMGaFHCOEOHk5EqPqgV8xxyBynOlF/CfqivTFt2ZV
        4Pbc05pAht4zLy3P6iZXXIGbyXeQp5bc9x5Zr4r9zte6Rkv4
X-Google-Smtp-Source: APXvYqz0WjRImbT8SyTkaSHDJnUm1/KIj6wfqSNyNsrgmspeG/zdV/BEREv3xTA//bGaaWOosDUe5Y+pK15m5vTa/h8enfhdUoGK
MIME-Version: 1.0
X-Received: by 2002:a02:698d:: with SMTP id e135mr34071295jac.128.1571000107511;
 Sun, 13 Oct 2019 13:55:07 -0700 (PDT)
Date:   Sun, 13 Oct 2019 13:55:07 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000059b6d40594d0f776@google.com>
Subject: WARNING in batadv_iv_send_outstanding_bat_ogm_packet
From:   syzbot <syzbot+c0b807de416427ff3dd1@syzkaller.appspotmail.com>
To:     a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org,
        davem@davemloft.net, linux-kernel@vger.kernel.org,
        mareklindner@neomailbox.ch, netdev@vger.kernel.org,
        sven@narfation.org, sw@simonwunderlich.de,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    da940012 Merge tag 'char-misc-5.4-rc3' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13ffd808e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2d2fd92a28d3e50
dashboard link: https://syzkaller.appspot.com/bug?extid=c0b807de416427ff3dd1
compiler:       clang version 9.0.0 (/home/glider/llvm/clang  
80fee25776c2fb61e74c1ecb1a523375c2500b69)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=141ffd77600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11edd580e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+c0b807de416427ff3dd1@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 30 at net/batman-adv/bat_iv_ogm.c:382  
batadv_iv_ogm_emit net/batman-adv/bat_iv_ogm.c:382 [inline]
WARNING: CPU: 1 PID: 30 at net/batman-adv/bat_iv_ogm.c:382  
batadv_iv_send_outstanding_bat_ogm_packet+0x6b4/0x770  
net/batman-adv/bat_iv_ogm.c:1663
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 30 Comm: kworker/u4:2 Not tainted 5.4.0-rc2+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: bat_events batadv_iv_send_outstanding_bat_ogm_packet
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1d8/0x2f8 lib/dump_stack.c:113
  panic+0x264/0x7a9 kernel/panic.c:221
  __warn+0x20e/0x210 kernel/panic.c:582
  report_bug+0x1b6/0x2f0 lib/bug.c:195
  fixup_bug arch/x86/kernel/traps.c:179 [inline]
  do_error_trap+0xd7/0x440 arch/x86/kernel/traps.c:272
  do_invalid_op+0x36/0x40 arch/x86/kernel/traps.c:291
  invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1028
RIP: 0010:batadv_iv_ogm_emit net/batman-adv/bat_iv_ogm.c:382 [inline]
RIP: 0010:batadv_iv_send_outstanding_bat_ogm_packet+0x6b4/0x770  
net/batman-adv/bat_iv_ogm.c:1663
Code: 66 05 00 eb 05 e8 9c 48 23 fa 48 83 c4 68 5b 41 5c 41 5d 41 5e 41 5f  
5d c3 e8 88 48 23 fa 0f 0b e9 34 ff ff ff e8 7c 48 23 fa <0f> 0b e9 28 ff  
ff ff 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c c1 f9 ff
RSP: 0018:ffff8880a9abfc48 EFLAGS: 00010293
RAX: ffffffff874fe8a4 RBX: ffff888094160870 RCX: ffff8880a9ab2080
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000002
RBP: ffff8880a9abfcd8 R08: ffffffff874fe28e R09: ffffed10123e6969
R10: ffffed10123e6969 R11: 0000000000000000 R12: ffff888091f34000
R13: dffffc0000000000 R14: ffff8880a80c5000 R15: ffff8880a4481400
  process_one_work+0x7ef/0x10e0 kernel/workqueue.c:2269
  worker_thread+0xc01/0x1630 kernel/workqueue.c:2415
  kthread+0x332/0x350 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
