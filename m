Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A56CC7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 16:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E33E206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 16:38:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729273AbfG2QiL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 12:38:11 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:54631 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729159AbfG2QiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 12:38:07 -0400
Received: by mail-io1-f72.google.com with SMTP id n8so68052057ioo.21
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 09:38:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=64wPHD2ub5C9dTsMGHD0dC6MBn1HBlNLnJVwhPQmaw0=;
        b=lb67hbgwLWGwk/XdMdbavCn4axwxnAUl+e5tT5VJuxzJw0SYR2K69JHMOGyHjLR7tH
         l+4wDdPpBha1tXne/8MjaWEQ+VA9biL3Q3PzsBNPdWvrmhbTPDToTIsgedlphoLXKLsj
         QErK8ltG03hTO8yUbS15jRQP24HmjwFN7Bd0O/+iat0cmiKtRbbUnpsqifDq0vSxF7EO
         bx/olhw8Mqzm9kuaeCewEPXjUUeevUCxZIRSsowXKIIPz8Hr5EFMwz6vukxQLmvAdp/f
         7dhDEkXeqei2+7+vQr3+/8x7bBad9NnEhuKMQW4joL2azpj+BtGvODV7Df97pm1AuOze
         AgJQ==
X-Gm-Message-State: APjAAAUVjSn+k2kQHNdLIiP2iM2qbBz4u8Fe7/yg21xWfP8v1UGDirtT
        upP/XNhuHjM/1lOEEZ+qJzA8cumxdCPd+qGtfc+PbATnNITz
X-Google-Smtp-Source: APXvYqxzFMhYbEwKIncPaiNMzBUEdjZ57ZVTF1OhCLo4KLuAdkXvyFewG439cG6kUJaLkhfKqw3JQ+/Wr6msXYv1wiapA58de+BX
MIME-Version: 1.0
X-Received: by 2002:a02:cc8e:: with SMTP id s14mr25813979jap.142.1564418286421;
 Mon, 29 Jul 2019 09:38:06 -0700 (PDT)
Date:   Mon, 29 Jul 2019 09:38:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003e112b058ed484c4@google.com>
Subject: general protection fault in snd_usb_pipe_sanity_check
From:   syzbot <syzbot+d59c4387bfb6eced94e2@syzkaller.appspotmail.com>
To:     allison@lohutok.net, alsa-devel@alsa-project.org,
        andreyknvl@google.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        perex@perex.cz, rfontana@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, tiwai@suse.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    7f7867ff usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=12befdc8600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=792eb47789f57810
dashboard link: https://syzkaller.appspot.com/bug?extid=d59c4387bfb6eced94e2
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16efc49fa00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13245854600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+d59c4387bfb6eced94e2@syzkaller.appspotmail.com

usb 1-1: New USB device found, idVendor=07fd, idProduct=0004,  
bcdDevice=d5.ac
usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
usb 1-1: config 0 descriptor??
usb 1-1: string descriptor 0 read error: -71
usb 1-1: Waiting for MOTU Microbook II to boot up...
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] SMP KASAN
CPU: 1 PID: 21 Comm: kworker/1:1 Not tainted 5.3.0-rc2+ #23
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: usb_hub_wq hub_event
RIP: 0010:snd_usb_pipe_sanity_check+0x80/0x130 sound/usb/helper.c:75
Code: 48 c1 ea 03 80 3c 02 00 0f 85 b3 00 00 00 48 8b 6d 00 c1 eb 1e 48 b8  
00 00 00 00 00 fc ff df 48 8d 7d 03 48 89 fa 48 c1 ea 03 <0f> b6 04 02 48  
89 fa 83 e2 07 38 d0 7f 04 84 c0 75 7b 48 b8 00 00
RSP: 0018:ffff8881da2f7010 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: 0000000000000001 RCX: ffffffff8484d252
RDX: 0000000000000000 RSI: ffffffff8484d26c RDI: 0000000000000003
RBP: 0000000000000000 R08: ffff8881da22e000 R09: ffffed103b665d58
R10: ffffed103b665d57 R11: ffff8881db32eabf R12: 0000000000000000
R13: ffff8881d400ba80 R14: 1ffff1103b45ee06 R15: ffff8881c79244a0
FS:  0000000000000000(0000) GS:ffff8881db300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f31b2a87000 CR3: 00000001d3fd4000 CR4: 00000000001406e0
Call Trace:
  snd_usb_motu_microbookii_communicate.constprop.0+0xa0/0x2fb  
sound/usb/quirks.c:1007
  snd_usb_motu_microbookii_boot_quirk sound/usb/quirks.c:1051 [inline]
  snd_usb_apply_boot_quirk.cold+0x163/0x370 sound/usb/quirks.c:1280
  usb_audio_probe+0x2ec/0x2010 sound/usb/card.c:576
  usb_probe_interface+0x305/0x7a0 drivers/usb/core/driver.c:361
  really_probe+0x281/0x650 drivers/base/dd.c:548
  driver_probe_device+0x101/0x1b0 drivers/base/dd.c:709
  __device_attach_driver+0x1c2/0x220 drivers/base/dd.c:816
  bus_for_each_drv+0x15c/0x1e0 drivers/base/bus.c:454
  __device_attach+0x217/0x360 drivers/base/dd.c:882
  bus_probe_device+0x1e4/0x290 drivers/base/bus.c:514
  device_add+0xae6/0x16f0 drivers/base/core.c:2114
  usb_set_configuration+0xdf6/0x1670 drivers/usb/core/message.c:2023
  generic_probe+0x9d/0xd5 drivers/usb/core/generic.c:210
  usb_probe_device+0x99/0x100 drivers/usb/core/driver.c:266
  really_probe+0x281/0x650 drivers/base/dd.c:548
  driver_probe_device+0x101/0x1b0 drivers/base/dd.c:709
  __device_attach_driver+0x1c2/0x220 drivers/base/dd.c:816
  bus_for_each_drv+0x15c/0x1e0 drivers/base/bus.c:454
  __device_attach+0x217/0x360 drivers/base/dd.c:882
  bus_probe_device+0x1e4/0x290 drivers/base/bus.c:514
  device_add+0xae6/0x16f0 drivers/base/core.c:2114
  usb_new_device.cold+0x6a4/0xe79 drivers/usb/core/hub.c:2536
  hub_port_connect drivers/usb/core/hub.c:5098 [inline]
  hub_port_connect_change drivers/usb/core/hub.c:5213 [inline]
  port_event drivers/usb/core/hub.c:5359 [inline]
  hub_event+0x1b5c/0x3640 drivers/usb/core/hub.c:5441
  process_one_work+0x92b/0x1530 kernel/workqueue.c:2269
  worker_thread+0x96/0xe20 kernel/workqueue.c:2415
  kthread+0x318/0x420 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
Modules linked in:
---[ end trace 41e8577a8c48635e ]---
RIP: 0010:snd_usb_pipe_sanity_check+0x80/0x130 sound/usb/helper.c:75
Code: 48 c1 ea 03 80 3c 02 00 0f 85 b3 00 00 00 48 8b 6d 00 c1 eb 1e 48 b8  
00 00 00 00 00 fc ff df 48 8d 7d 03 48 89 fa 48 c1 ea 03 <0f> b6 04 02 48  
89 fa 83 e2 07 38 d0 7f 04 84 c0 75 7b 48 b8 00 00
RSP: 0018:ffff8881da2f7010 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: 0000000000000001 RCX: ffffffff8484d252
RDX: 0000000000000000 RSI: ffffffff8484d26c RDI: 0000000000000003
RBP: 0000000000000000 R08: ffff8881da22e000 R09: ffffed103b665d58
R10: ffffed103b665d57 R11: ffff8881db32eabf R12: 0000000000000000
R13: ffff8881d400ba80 R14: 1ffff1103b45ee06 R15: ffff8881c79244a0
FS:  0000000000000000(0000) GS:ffff8881db300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f31b2a87000 CR3: 00000001d3fd4000 CR4: 00000000001406e0


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
