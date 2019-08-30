Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B6AC3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 19:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CFB722CE9
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 19:40:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbfH3TkQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 15:40:16 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:42275 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728079AbfH3TkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 15:40:08 -0400
Received: by mail-io1-f69.google.com with SMTP id x9so9732942ior.9
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 12:40:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=us9ii8ZPiq49/zJdpQsDAPG5tE/hCtulCu7G+qMfvuM=;
        b=f2piPoW5Nm5Py3dySyazGM3c1pY/nkX4gg9TM0RYFB1Dn2g+5ps6pOuU/9s/yr6bou
         X8i5uFQi7lLBAHBeYBrE0Z6ehlKvdlIwcmKJ21TahwRFCAJ0o8TBR3Z70NKE3oe2FgHg
         HM8cr5wSsF9wQonkzah0RAY9KwaHioLTjLuNZQNwDBwE2dCc7VQM0ITExGTNzHcwsjAC
         J/7v91HxMDqUmMqN5i6UhpiSKBlZUgWYBDjw4aGzJ+8CWtcz4QFy9Zrh/fMEz3FNjZ6k
         vN39Lk48HZQ8t15eJ/zLFQykMg4Pz9XcXgKQVamztO57vf0wVRwmpv6oHKLbM8v33eUc
         6FeQ==
X-Gm-Message-State: APjAAAUOUxxgUz7HvcFLnKOAEnSaOJZ+0vLcdIyfctHPM3T0QmZB9E1Q
        yE+4Axc5+KQ7CkVCHf2F886KZiNKNVXaVRSccFBJPAR8lZoI
X-Google-Smtp-Source: APXvYqwbAV339fEZpw1x6sMt2R0cuvpx5axDRScvc+Q8sjM2KVT0b/bEevGBGZWlMkTRpgt7RvtHxKimJg7OoiOUXp4akGZoFAep
MIME-Version: 1.0
X-Received: by 2002:a5e:8344:: with SMTP id y4mr12305637iom.213.1567194007543;
 Fri, 30 Aug 2019 12:40:07 -0700 (PDT)
Date:   Fri, 30 Aug 2019 12:40:07 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001d284f05915acaa9@google.com>
Subject: INFO: trying to register non-static key in hci_uart_tty_receive
From:   syzbot <syzbot+13a3ab5c28d3fb67bacc@syzkaller.appspotmail.com>
To:     johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, marcel@holtmann.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    ed2393ca Add linux-next specific files for 20190827
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16350e7a600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2ef5940a07ed45f4
dashboard link: https://syzkaller.appspot.com/bug?extid=13a3ab5c28d3fb67bacc
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+13a3ab5c28d3fb67bacc@syzkaller.appspotmail.com

INFO: trying to register non-static key.
the code is fine but needs lockdep annotation.
turning off the locking correctness validator.
CPU: 1 PID: 562 Comm: kworker/u4:3 Not tainted 5.3.0-rc6-next-20190827 #74
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events_unbound flush_to_ldisc
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  assign_lock_key kernel/locking/lockdep.c:881 [inline]
  register_lock_class+0x179e/0x1850 kernel/locking/lockdep.c:1190
  __lock_acquire+0xf4/0x4a00 kernel/locking/lockdep.c:3837
  lock_acquire+0x190/0x410 kernel/locking/lockdep.c:4487
  percpu_down_read include/linux/percpu-rwsem.h:40 [inline]
  hci_uart_tty_receive+0xcf/0x6e0 drivers/bluetooth/hci_ldisc.c:603
  tty_ldisc_receive_buf+0x15f/0x1c0 drivers/tty/tty_buffer.c:465
  tty_port_default_receive_buf+0x7d/0xb0 drivers/tty/tty_port.c:38
  receive_buf drivers/tty/tty_buffer.c:481 [inline]
  flush_to_ldisc+0x222/0x390 drivers/tty/tty_buffer.c:533
  process_one_work+0x9af/0x1740 kernel/workqueue.c:2269
  worker_thread+0x98/0xe40 kernel/workqueue.c:2415
  kthread+0x361/0x430 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
