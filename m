Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB27C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 15:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 720A820674
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 15:25:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbfKUPZN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 10:25:13 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:36715 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbfKUPZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 10:25:12 -0500
Received: by mail-il1-f198.google.com with SMTP id m16so3241817ilh.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 07:25:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=5/Y0Vx39t23ptU6jPQhVbmYRjMhm1ty9Ei09eq/gC9A=;
        b=MT6x3HmEvBUVyFh9J/DgpBuFRTLAvllNDkwfY4zVEocihOqZnsmeBZXzNLeuVI/T7F
         dUPRSfLOSyH3rsiOFAHaBw6oShBP/2glkaTybOXzVRkxz4cXEQQ5Ol1SbgKezgTvZWip
         LCCicg9dabXujY+uwlpb0aFEJJ3KVdJR5Uvs5QXURInylSu5nr0PEhcTnL57bBwTFejZ
         lmqJ6pTIZ7X9iiIjTgYD+kVOeXDnGzU8+fsz+PgMZLS68RPSU1go2Hxc9pxDmSgRj3ID
         BnDPV/WSZyjf2fVned97mO7VEoQBDHLUaByGOvkd8GeSx5RU99Cn3CrfEpb7AaK5Eu27
         ojZA==
X-Gm-Message-State: APjAAAWMFKoKZr7fVKm5w3c/mXWs7F/g3bcARLn4aW92H0WaWDOb3qfN
        e+OowQPLJIbtZWstXftMiXJnG3zrQ1Mx38a57yHGrxSV9wRS
X-Google-Smtp-Source: APXvYqx24QzbX7sKyq85/7BIRL34ERuzFmfT0f4o2upQazdDIQDaiWYBiXJvRiaFLTa7nbXlURC2Xd8wrVjbHDvIHveClSU3Tblu
MIME-Version: 1.0
X-Received: by 2002:a5e:c314:: with SMTP id a20mr8275088iok.300.1574349909859;
 Thu, 21 Nov 2019 07:25:09 -0800 (PST)
Date:   Thu, 21 Nov 2019 07:25:09 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002129080597dce70d@google.com>
Subject: general protection fault in snd_usb_create_mixer
From:   syzbot <syzbot+a36ab65c6653d7ccdd62@syzkaller.appspotmail.com>
To:     alsa-devel@alsa-project.org, andreyknvl@google.com,
        benquike@gmail.com, dan.carpenter@oracle.com, g@b4.vu,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, perex@perex.cz,
        syzkaller-bugs@googlegroups.com, tiwai@suse.com, wang6495@umn.edu
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    46178223 usb: gadget: add raw-gadget interface
git tree:       https://github.com/google/kasan.git usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=176f9836e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=99c88c44660624e7
dashboard link: https://syzkaller.appspot.com/bug?extid=a36ab65c6653d7ccdd62
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1447d3bae00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17ef3a86e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+a36ab65c6653d7ccdd62@syzkaller.appspotmail.com

usb 1-1: 208:241 : does not exist
usb 1-1: 208:242 : does not exist
usb 1-1: 208:243 : does not exist
usb 1-1: 208:244 : does not exist
usb 1-1: 208:245 : does not exist
usb 1-1: 208:246 : does not exist
usb 1-1: 208:247 : does not exist
usb 1-1: 208:248 : does not exist
usb 1-1: 208:249 : does not exist
usb 1-1: 208:250 : does not exist
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] SMP KASAN
CPU: 1 PID: 22 Comm: kworker/1:1 Not tainted 5.4.0-rc6+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: usb_hub_wq hub_event
RIP: 0010:snd_usb_mixer_controls_badd sound/usb/mixer.c:2931 [inline]
RIP: 0010:snd_usb_create_mixer+0xbb9/0x1890 sound/usb/mixer.c:3441
Code: ee e8 9b 23 a6 fc 41 39 ee 74 a4 e8 a1 22 a6 fc 48 8b 7c 24 28 89 ee  
e8 25 59 b4 fe 48 8d 78 10 48 89 c3 48 89 f8 48 c1 e8 03 <42> 0f b6 04 28  
84 c0 74 08 3c 03 0f 8e 2f 09 00 00 8b 6b 10 bf 01
RSP: 0018:ffff8881d932f0a0 EFLAGS: 00010202
RAX: 0000000000000002 RBX: 0000000000000000 RCX: ffffffff834c5dac
RDX: 0000000000000000 RSI: ffffffff834c5e1b RDI: 0000000000000010
RBP: 0000000000000021 R08: ffff8881da24e000 R09: fffffbfff11aadb5
R10: fffffbfff11aadb4 R11: ffffffff88d56da7 R12: 00000000000000da
R13: dffffc0000000000 R14: 00000000000000d0 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8881db300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000043f100 CR3: 0000000006c21000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  usb_audio_probe+0xc76/0x2010 sound/usb/card.c:653
  usb_probe_interface+0x305/0x7a0 drivers/usb/core/driver.c:361
  really_probe+0x281/0x6d0 drivers/base/dd.c:548
  driver_probe_device+0x104/0x210 drivers/base/dd.c:721
  __device_attach_driver+0x1c2/0x220 drivers/base/dd.c:828
  bus_for_each_drv+0x162/0x1e0 drivers/base/bus.c:430
  __device_attach+0x217/0x360 drivers/base/dd.c:894
  bus_probe_device+0x1e4/0x290 drivers/base/bus.c:490
  device_add+0xae6/0x16f0 drivers/base/core.c:2202
  usb_set_configuration+0xdf6/0x1670 drivers/usb/core/message.c:2023
  generic_probe+0x9d/0xd5 drivers/usb/core/generic.c:210
  usb_probe_device+0x99/0x100 drivers/usb/core/driver.c:266
  really_probe+0x281/0x6d0 drivers/base/dd.c:548
  driver_probe_device+0x104/0x210 drivers/base/dd.c:721
  __device_attach_driver+0x1c2/0x220 drivers/base/dd.c:828
  bus_for_each_drv+0x162/0x1e0 drivers/base/bus.c:430
  __device_attach+0x217/0x360 drivers/base/dd.c:894
  bus_probe_device+0x1e4/0x290 drivers/base/bus.c:490
  device_add+0xae6/0x16f0 drivers/base/core.c:2202
  usb_new_device.cold+0x6a4/0xe79 drivers/usb/core/hub.c:2537
  hub_port_connect drivers/usb/core/hub.c:5184 [inline]
  hub_port_connect_change drivers/usb/core/hub.c:5324 [inline]
  port_event drivers/usb/core/hub.c:5470 [inline]
  hub_event+0x1df8/0x3800 drivers/usb/core/hub.c:5552
  process_one_work+0x92b/0x1530 kernel/workqueue.c:2269
  worker_thread+0x96/0xe20 kernel/workqueue.c:2415
  kthread+0x318/0x420 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
Modules linked in:
---[ end trace 1d30a29898ec11e8 ]---
RIP: 0010:snd_usb_mixer_controls_badd sound/usb/mixer.c:2931 [inline]
RIP: 0010:snd_usb_create_mixer+0xbb9/0x1890 sound/usb/mixer.c:3441
Code: ee e8 9b 23 a6 fc 41 39 ee 74 a4 e8 a1 22 a6 fc 48 8b 7c 24 28 89 ee  
e8 25 59 b4 fe 48 8d 78 10 48 89 c3 48 89 f8 48 c1 e8 03 <42> 0f b6 04 28  
84 c0 74 08 3c 03 0f 8e 2f 09 00 00 8b 6b 10 bf 01
RSP: 0018:ffff8881d932f0a0 EFLAGS: 00010202
RAX: 0000000000000002 RBX: 0000000000000000 RCX: ffffffff834c5dac
RDX: 0000000000000000 RSI: ffffffff834c5e1b RDI: 0000000000000010
RBP: 0000000000000021 R08: ffff8881da24e000 R09: fffffbfff11aadb5
R10: fffffbfff11aadb4 R11: ffffffff88d56da7 R12: 00000000000000da
R13: dffffc0000000000 R14: 00000000000000d0 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8881db300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000043f100 CR3: 0000000006c21000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
