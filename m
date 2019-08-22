Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D34BFC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 14:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B066721726
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 14:28:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388442AbfHVO2I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 10:28:08 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:39043 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbfHVO2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 10:28:08 -0400
Received: by mail-io1-f70.google.com with SMTP id g12so6577637iok.6
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 07:28:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=5NvkY5It9Uka5k6hXhl6v+ALtKFYcEQyT3YtILLNu4M=;
        b=CesWi5eMSVfExhhMq2/7VzvAdFwAxB7rFU7ZZZOBsXJqlJjyx9EH43CRYtt0f93t4k
         l0nnkUzLgo85BABJTFjwYz1i+3Kk//Zgrxj6JxMMA3dXC/OSKZdSsqpe5qACyJ/aczjI
         eyRmmsJSe+1Lpmx/izZmtPibe8/RSGJNwfrPrN7YpbUpnGcvvPFxhkB+oVpTwHWkonDl
         h0Wg66DtotlbwmCbNX9UBo+OwNDaKCGooKxDNEHV7DEY0J8rpUkE20LrZzhb+DpeoteK
         T45jMi6YVrDhq7MuhPXm32ECpLg8n4AtaT7ptDsv/PpVYjQaz3SmxgRAVX238TvhmR3k
         eHaA==
X-Gm-Message-State: APjAAAXWfQDPQgv5/wsdgfYrEBe93StcT16f83HBnfhBOZP6tiWY0v2P
        Kwy8T2UUXUTVIQXxF/LuTzh8njMIHBw081yp7tcQ6pFV+m+T
X-Google-Smtp-Source: APXvYqzN6ymuNx0ogqNZhxC7kEt34nHfmwQ5+feN2ljRuL3CTyxxSGlk5zpjneuzyG3g7Juk+k7MRQ1vNqGK43Npb73Whw71s3Ml
MIME-Version: 1.0
X-Received: by 2002:a02:cc6c:: with SMTP id j12mr409661jaq.29.1566484087115;
 Thu, 22 Aug 2019 07:28:07 -0700 (PDT)
Date:   Thu, 22 Aug 2019 07:28:07 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008f1a550590b57f9a@google.com>
Subject: WARNING in r871xu_dev_remove
From:   syzbot <syzbot+80899a8a8efe8968cde7@syzkaller.appspotmail.com>
To:     Larry.Finger@lwfinger.net, andreyknvl@google.com,
        devel@driverdev.osuosl.org, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org, himadri18.07@gmail.com,
        kai.heng.feng@canonical.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux.dkm@gmail.com,
        straube.linux@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    eea39f24 usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=163ae012600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d0c62209eedfd54e
dashboard link: https://syzkaller.appspot.com/bug?extid=80899a8a8efe8968cde7
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1739cb0e600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=154fcc2e600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+80899a8a8efe8968cde7@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 83 at net/core/dev.c:8167  
rollback_registered_many.cold+0x41/0x1bc net/core/dev.c:8167
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 83 Comm: kworker/1:2 Not tainted 5.3.0-rc5+ #28
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: usb_hub_wq hub_event
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0xca/0x13e lib/dump_stack.c:113
  panic+0x2a3/0x6da kernel/panic.c:219
  __warn.cold+0x20/0x4a kernel/panic.c:576
  report_bug+0x262/0x2a0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:179 [inline]
  fixup_bug arch/x86/kernel/traps.c:174 [inline]
  do_error_trap+0x12b/0x1e0 arch/x86/kernel/traps.c:272
  do_invalid_op+0x32/0x40 arch/x86/kernel/traps.c:291
  invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1028
RIP: 0010:rollback_registered_many.cold+0x41/0x1bc net/core/dev.c:8167
Code: ff e8 c7 26 90 fc 48 c7 c7 40 ec 63 86 e8 24 c8 7a fc 0f 0b e9 93 be  
ff ff e8 af 26 90 fc 48 c7 c7 40 ec 63 86 e8 0c c8 7a fc <0f> 0b 4c 89 e7  
e8 f9 12 34 fd 31 ff 41 89 c4 89 c6 e8 bd 27 90 fc
RSP: 0018:ffff8881d938f6a8 EFLAGS: 00010286
RAX: 0000000000000024 RBX: ffff8881d2a10000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff81288cfd RDI: ffffed103b271ec7
RBP: ffff8881d938f7d8 R08: 0000000000000024 R09: fffffbfff11ad794
R10: fffffbfff11ad793 R11: ffffffff88d6bc9f R12: ffff8881d2a10070
R13: ffff8881d938f768 R14: dffffc0000000000 R15: 0000000000000000
  rollback_registered+0xf2/0x1c0 net/core/dev.c:8243
  unregister_netdevice_queue net/core/dev.c:9290 [inline]
  unregister_netdevice_queue+0x1d7/0x2b0 net/core/dev.c:9283
  unregister_netdevice include/linux/netdevice.h:2631 [inline]
  unregister_netdev+0x18/0x20 net/core/dev.c:9331
  r871xu_dev_remove+0xe2/0x215 drivers/staging/rtl8712/usb_intf.c:604
  usb_unbind_interface+0x1bd/0x8a0 drivers/usb/core/driver.c:423
  __device_release_driver drivers/base/dd.c:1134 [inline]
  device_release_driver_internal+0x42f/0x500 drivers/base/dd.c:1165
  bus_remove_device+0x2dc/0x4a0 drivers/base/bus.c:556
  device_del+0x420/0xb10 drivers/base/core.c:2339
  usb_disable_device+0x211/0x690 drivers/usb/core/message.c:1237
  usb_disconnect+0x284/0x8d0 drivers/usb/core/hub.c:2199
  hub_port_connect drivers/usb/core/hub.c:4949 [inline]
  hub_port_connect_change drivers/usb/core/hub.c:5213 [inline]
  port_event drivers/usb/core/hub.c:5359 [inline]
  hub_event+0x1454/0x3640 drivers/usb/core/hub.c:5441
  process_one_work+0x92b/0x1530 kernel/workqueue.c:2269
  process_scheduled_works kernel/workqueue.c:2331 [inline]
  worker_thread+0x7ab/0xe20 kernel/workqueue.c:2417
  kthread+0x318/0x420 kernel/kthread.c:255
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
