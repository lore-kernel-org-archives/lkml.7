Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DAD6C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 19:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6494C206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 19:39:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729169AbfJGTjI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 15:39:08 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:50904 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728330AbfJGTjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 15:39:08 -0400
Received: by mail-io1-f70.google.com with SMTP id f5so28401269iob.17
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 12:39:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=kKDb/JioBJlC3ZSH7Ra1D6u0wPhnpnLccidK2R6RBOc=;
        b=gAgwYyok8wAhjPjfB9RqdVY/TVnDEnUNSz1It1o+Zw2P0bAohmTj3pO5wtqV1Xp/f3
         DuYlYK4BjRzNcQffsl3rdBo0/N+tShWV5yDDrKScQXx50bwXo2pXGhKlE4+UC3xdjqqj
         WO9dcMUkIQqqZIg8lsgpXNe1IcyvvYDV1qyvAGbxIstt7y9DS8A4Wm1DAJP2VjnAwRPn
         DmWnXWMqNvja7kyGHjCteAwISygzdcNy85urr5F8fnbxbbltSsd43BeC1c/FJlDPksaX
         3p7E7pieAfESBU809RYwj5CQSM21Z2qHGC7no4ya+O6QGWDIDuDbag/Gui1kXBADl70H
         /7QQ==
X-Gm-Message-State: APjAAAUqF8oKayoJPOOan5Se2Ks2L3s8AkLFuHw9rhykt3DYB2fM0C3e
        WNV4kXbnqQe4EKxu2ODOwRouCa8pKhAxfC4qZ7pY8nDV1hB8
X-Google-Smtp-Source: APXvYqxldHRIjyw1O4EjayR7Y53v5Fqnw/B/xW7orK7MItW9khT42lcNa9DPDqCKODNcniseUWxW2QA80sICOI8pqFH/Y0jO79O1
MIME-Version: 1.0
X-Received: by 2002:a92:5855:: with SMTP id m82mr31630600ilb.136.1570477147233;
 Mon, 07 Oct 2019 12:39:07 -0700 (PDT)
Date:   Mon, 07 Oct 2019 12:39:07 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007d25ff059457342d@google.com>
Subject: KMSAN: uninit-value in alauda_check_media
From:   syzbot <syzbot+e7d46eb426883fb97efd@syzkaller.appspotmail.com>
To:     glider@google.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        stern@rowland.harvard.edu, syzkaller-bugs@googlegroups.com,
        usb-storage@lists.one-eyed-alien.net
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    1e76a3e5 kmsan: replace __GFP_NO_KMSAN_SHADOW with kmsan_i..
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=1204cc63600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f03c659d0830ab8d
dashboard link: https://syzkaller.appspot.com/bug?extid=e7d46eb426883fb97efd
compiler:       clang version 9.0.0 (/home/glider/llvm/clang  
80fee25776c2fb61e74c1ecb1a523375c2500b69)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=123c860d600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=110631b7600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+e7d46eb426883fb97efd@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in alauda_transport+0x462/0x57f0  
drivers/usb/storage/alauda.c:1137
CPU: 0 PID: 12279 Comm: usb-storage Not tainted 5.3.0-rc7+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x191/0x1f0 lib/dump_stack.c:113
  kmsan_report+0x13a/0x2b0 mm/kmsan/kmsan_report.c:108
  __msan_warning+0x73/0xe0 mm/kmsan/kmsan_instr.c:250
  alauda_check_media+0x344/0x3310 drivers/usb/storage/alauda.c:460
  alauda_transport+0x462/0x57f0 drivers/usb/storage/alauda.c:1137
  usb_stor_invoke_transport+0xf5/0x27e0 drivers/usb/storage/transport.c:606
  usb_stor_transparent_scsi_command+0x5d/0x70  
drivers/usb/storage/protocol.c:108
  usb_stor_control_thread+0xca6/0x11a0 drivers/usb/storage/usb.c:380
  kthread+0x4b5/0x4f0 kernel/kthread.c:256
  ret_from_fork+0x35/0x40 arch/x86/entry/entry_64.S:355

Local variable description: ----status@alauda_check_media
Variable was created at:
  alauda_check_media+0x8e/0x3310 drivers/usb/storage/alauda.c:454
  alauda_transport+0x462/0x57f0 drivers/usb/storage/alauda.c:1137
=====================================================
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 12279 Comm: usb-storage Tainted: G    B             5.3.0-rc7+  
#0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x191/0x1f0 lib/dump_stack.c:113
  panic+0x3c9/0xc1e kernel/panic.c:219
  kmsan_report+0x2a2/0x2b0 mm/kmsan/kmsan_report.c:131
  __msan_warning+0x73/0xe0 mm/kmsan/kmsan_instr.c:250
  alauda_check_media+0x344/0x3310 drivers/usb/storage/alauda.c:460
  alauda_transport+0x462/0x57f0 drivers/usb/storage/alauda.c:1137
  usb_stor_invoke_transport+0xf5/0x27e0 drivers/usb/storage/transport.c:606
  usb_stor_transparent_scsi_command+0x5d/0x70  
drivers/usb/storage/protocol.c:108
  usb_stor_control_thread+0xca6/0x11a0 drivers/usb/storage/usb.c:380
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
