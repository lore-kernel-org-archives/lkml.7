Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D67FBCA9EA0
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 11:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0C372184C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 11:44:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728762AbfKDLoL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 06:44:11 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:55313 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbfKDLoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 06:44:11 -0500
Received: by mail-io1-f71.google.com with SMTP id c67so12879518iof.22
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 03:44:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=6/ZpXaM+qq6hszn51R5GJMju7VQebT1P49v6AbLTouM=;
        b=pOCQTOuLudXBZvAX1IifRnMcl/9ol0h9SPCPOiBt6gh9o4rJWxZluU8/dXTtK7Cumk
         zClV7Xp3a9ejPrhFqtSJ6nBkTeIcPrNn1ubUyGB2DUCdNI8K9d5RcuDrLaF32cwDqJX3
         CKEPEHi5dfDRp9DXdZnxGqk1OFRLfr0cEIbVCi3LbPWCeO693Degrrmt8PDCG/22Hj7i
         Y9+xKXA3JMxB1BKSOZ0+EF0HmHeXYP0BXXr3D6l3JTnza7mt1sG/ctYSlYMtUjeYIqEy
         BYEfYSyqByrQxqEbj6ECKwB3Q6PYnPINhdVGCsl14X+NoeDAkATbovbJn3CaY8HtN3JU
         VAPw==
X-Gm-Message-State: APjAAAV644/5XO3VhWLNli2XCYKjWXxeJqHGwmM+XQyC90qPy8f6pe8H
        6fl+OCTsmghglIkLpx16wXqw7hea+cyimOcScqLAWQ5u31k8
X-Google-Smtp-Source: APXvYqzczd4RZ9n1It0l0mE4UMnBGkF2ehLSeQxFmThhGJNlUYQ70xzVwNMKd/amqQ0fXRc0zWYdMF3fnUtEMqWnJZXOSTakZv59
MIME-Version: 1.0
X-Received: by 2002:a5d:9385:: with SMTP id c5mr23968738iol.197.1572867848829;
 Mon, 04 Nov 2019 03:44:08 -0800 (PST)
Date:   Mon, 04 Nov 2019 03:44:08 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006881cf059683d5fb@google.com>
Subject: KCSAN: data-race in echo_char / n_tty_receive_buf_common
From:   syzbot <syzbot+e518b0df8f4e19495d3e@syzkaller.appspotmail.com>
To:     elver@google.com, gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    05f22368 x86, kcsan: Enable KCSAN for x86
git tree:       https://github.com/google/ktsan.git kcsan
console output: https://syzkaller.appspot.com/x/log.txt?x=106bdb60e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=87d111955f40591f
dashboard link: https://syzkaller.appspot.com/bug?extid=e518b0df8f4e19495d3e
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+e518b0df8f4e19495d3e@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in echo_char / n_tty_receive_buf_common

write to 0xffffc9000c433018 of 8 bytes by task 18008 on cpu 0:
  add_echo_byte drivers/tty/n_tty.c:845 [inline]
  echo_char+0x14e/0x1c0 drivers/tty/n_tty.c:948
  n_tty_receive_char_special+0xb5f/0x1c10 drivers/tty/n_tty.c:1339
  n_tty_receive_buf_fast drivers/tty/n_tty.c:1610 [inline]
  __receive_buf drivers/tty/n_tty.c:1644 [inline]
  n_tty_receive_buf_common+0x1844/0x1b00 drivers/tty/n_tty.c:1742
  n_tty_receive_buf+0x3a/0x50 drivers/tty/n_tty.c:1771
  tiocsti drivers/tty/tty_io.c:2197 [inline]
  tty_ioctl+0xb75/0xe10 drivers/tty/tty_io.c:2573
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:509 [inline]
  do_vfs_ioctl+0x991/0xc60 fs/ioctl.c:696
  ksys_ioctl+0xbd/0xe0 fs/ioctl.c:713
  __do_sys_ioctl fs/ioctl.c:720 [inline]
  __se_sys_ioctl fs/ioctl.c:718 [inline]
  __x64_sys_ioctl+0x4c/0x60 fs/ioctl.c:718
  do_syscall_64+0xcc/0x370 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x44/0xa9

read to 0xffffc9000c433018 of 8 bytes by task 7 on cpu 1:
  flush_echoes drivers/tty/n_tty.c:828 [inline]
  __receive_buf drivers/tty/n_tty.c:1648 [inline]
  n_tty_receive_buf_common+0xe3f/0x1b00 drivers/tty/n_tty.c:1742
  n_tty_receive_buf2+0x3d/0x60 drivers/tty/n_tty.c:1777
  tty_ldisc_receive_buf+0x71/0xf0 drivers/tty/tty_buffer.c:461
  tty_port_default_receive_buf+0x87/0xd0 drivers/tty/tty_port.c:38
  receive_buf drivers/tty/tty_buffer.c:481 [inline]
  flush_to_ldisc+0x1d5/0x260 drivers/tty/tty_buffer.c:533
  process_one_work+0x3d4/0x890 kernel/workqueue.c:2269
  worker_thread+0xa0/0x800 kernel/workqueue.c:2415
  kthread+0x1d4/0x200 drivers/block/aoe/aoecmd.c:1253
  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:352

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 PID: 7 Comm: kworker/u4:0 Not tainted 5.4.0-rc3+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events_unbound flush_to_ldisc
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
