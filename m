Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C09C4360C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 03:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB67321D81
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 03:39:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728534AbfJCDjI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 23:39:08 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:57064 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727664AbfJCDjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 23:39:08 -0400
Received: by mail-io1-f69.google.com with SMTP id a22so2865366ioq.23
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 20:39:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=mvJOaHk+FTZL9FNb7UAf3Jmr8rKxImWpF0+2sR45UOw=;
        b=CeTioO8HN//EQzh1cjV1kfv0iZ2q223oYO8//95ekL1liMpZqPzF2tsWi27K5ZbJoM
         RwrineuXIVHjOZUrhUphUOxdTsJzJjRkcbVojtAIMG96MpDaK9Qkqrsijrucp4GZrexG
         /tQiwo5cL6m4hQ/XakiBMrjioohlnhA0EOe9cS/H4aQyoh98/DmCAgJdklkFl0KXXuh3
         0ddLKecfJNEI+/urDsyd99U14ZrkkmIGS3t53ZcbY6Jlv17b3LAPid6ye1+xCHEQuWLz
         O490hJJE4GL8fTNxoVOWMhksdknaPFWWeLWWmmpIgLZOuvhGy0b89gf7uJyDV5AiGWr8
         wvHw==
X-Gm-Message-State: APjAAAXb1kpDj9jmXoBo8qYLEfw7vksAcZDMHwGGZ5JAgm1f7uUxusRY
        7uXRnD0XiyrTiszevEB4gQ3wpQnNSGfwG6HUt/fflLmvKX0f
X-Google-Smtp-Source: APXvYqyVfwzpbA6LMRrTu2ruIncppD+gfoB8uXriSv6YxjGTpOn6O9m0rZxAdq57PC7sPCzETPZKKSadSKsz/qGlMoKjB4wXdv4h
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:683:: with SMTP id o3mr7342118ils.58.1570073947326;
 Wed, 02 Oct 2019 20:39:07 -0700 (PDT)
Date:   Wed, 02 Oct 2019 20:39:07 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e6d0f70593f953dd@google.com>
Subject: KMSAN: uninit-value in cxusb_rc_query
From:   syzbot <syzbot+98730b985cad4931a552@syzkaller.appspotmail.com>
To:     glider@google.com, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, mchehab@kernel.org,
        mkrufky@linuxtv.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    cebbfdbc kmsan: merge set_no_shadow_page() and set_no_orig..
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=1277527e600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f03c659d0830ab8d
dashboard link: https://syzkaller.appspot.com/bug?extid=98730b985cad4931a552
compiler:       clang version 9.0.0 (/home/glider/llvm/clang  
80fee25776c2fb61e74c1ecb1a523375c2500b69)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10a648e5600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=156af545600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+98730b985cad4931a552@syzkaller.appspotmail.com

dvb-usb: bulk message failed: -22 (1/-30591)
==================================================================
BUG: KMSAN: uninit-value in cxusb_rc_query+0x2f7/0x360  
drivers/media/usb/dvb-usb/cxusb.c:547
CPU: 0 PID: 761 Comm: kworker/0:2 Not tainted 5.3.0-rc7+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events dvb_usb_read_remote_control
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x191/0x1f0 lib/dump_stack.c:113
  kmsan_report+0x162/0x2d0 mm/kmsan/kmsan_report.c:109
  __msan_warning+0x75/0xe0 mm/kmsan/kmsan_instr.c:294
  cxusb_rc_query+0x2f7/0x360 drivers/media/usb/dvb-usb/cxusb.c:547
  dvb_usb_read_remote_control+0xf9/0x290  
drivers/media/usb/dvb-usb/dvb-usb-remote.c:261
  process_one_work+0x1572/0x1ef0 kernel/workqueue.c:2269
  worker_thread+0x111b/0x2460 kernel/workqueue.c:2415
  kthread+0x4b5/0x4f0 kernel/kthread.c:256
  ret_from_fork+0x35/0x40 arch/x86/entry/entry_64.S:355

Local variable description: ----ircode@cxusb_rc_query
Variable was created at:
  cxusb_rc_query+0x4d/0x360 drivers/media/usb/dvb-usb/cxusb.c:543
  dvb_usb_read_remote_control+0xf9/0x290  
drivers/media/usb/dvb-usb/dvb-usb-remote.c:261
==================================================================
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 761 Comm: kworker/0:2 Tainted: G    B             5.3.0-rc7+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events dvb_usb_read_remote_control
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x191/0x1f0 lib/dump_stack.c:113
  panic+0x3c9/0xc1e kernel/panic.c:219
  kmsan_report+0x2ca/0x2d0 mm/kmsan/kmsan_report.c:129
  __msan_warning+0x75/0xe0 mm/kmsan/kmsan_instr.c:294
  cxusb_rc_query+0x2f7/0x360 drivers/media/usb/dvb-usb/cxusb.c:547
  dvb_usb_read_remote_control+0xf9/0x290  
drivers/media/usb/dvb-usb/dvb-usb-remote.c:261
  process_one_work+0x1572/0x1ef0 kernel/workqueue.c:2269
  worker_thread+0x111b/0x2460 kernel/workqueue.c:2415
  kthread+0x4b5/0x4f0 kernel/kthread.c:256
  ret_from_fork+0x35/0x40 arch/x86/entry/entry_64.S:355
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
