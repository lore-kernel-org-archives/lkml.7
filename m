Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3535BC10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 22:29:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 159A820873
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 22:29:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbfJHW3J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 18:29:09 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:40141 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbfJHW3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 18:29:09 -0400
Received: by mail-io1-f69.google.com with SMTP id r20so932002ioh.7
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 15:29:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=jVNpj39i7xvK8MWgtKNyHcAmTmAx0cA9HUYpZ02atfs=;
        b=oL2kzy9pXik/zNBRo8n+qHyOrDqDU2EpGvGwwMJZJwWdHOukA8W8/TWny+b3b0KpFR
         foB/Ox4+qjqtyqgFV7GNDs7VdIMsDlekKHAH/o9CKOgwfqQTk8Wq2X9RJaOvDqfBTXwd
         zSiEDA2HbJrYKb9n8TPxsqi93f2V9euPKvlSoqCCPMgaM0eU468e6fPYrLLMk4nwo54G
         NECG/uh6n2JdBkvRaZmwUF1XUfpJVWoHfmARqkCn5Om2kKnli7+FOranWSaP8X8ToRXr
         +tuMT2kORqk6M8f9MhLEi9rf/Ckwd5OpV+iMwwsMSSCpwkOpwIndXfhXVm6/QZmYAFHY
         V/6g==
X-Gm-Message-State: APjAAAVLL/fThz6I4zg6pVpzZlBddYNJyLukFWHRhfb5PfIMu/zGhl8o
        sBj4Jhudr0L/ow8a+VnfztoLteM+VVP9BGMBqIMZffQQ4A93
X-Google-Smtp-Source: APXvYqwL0qHuZSap+ExhhuRbTa9K5CfNjcj8eimDFS5NP3QrMmCUb4Dk1KGAKMjlKfYDqC4T4wxdh0NGmkoVr8VnUQ9eu9IByaJ/
MIME-Version: 1.0
X-Received: by 2002:a92:17c4:: with SMTP id 65mr704706ilx.28.1570573748770;
 Tue, 08 Oct 2019 15:29:08 -0700 (PDT)
Date:   Tue, 08 Oct 2019 15:29:08 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000639e6005946db2ed@google.com>
Subject: KMSAN: uninit-value in bsearch
From:   syzbot <syzbot+427ce10b72235583ef69@syzkaller.appspotmail.com>
To:     benpicco@googlemail.com, glider@google.com, hias@horus.com,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        mchehab@kernel.org, patrick9876@free.fr, sean@mess.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    1e76a3e5 kmsan: replace __GFP_NO_KMSAN_SHADOW with kmsan_i..
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=130b16fd600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f03c659d0830ab8d
dashboard link: https://syzkaller.appspot.com/bug?extid=427ce10b72235583ef69
compiler:       clang version 9.0.0 (/home/glider/llvm/clang  
80fee25776c2fb61e74c1ecb1a523375c2500b69)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+427ce10b72235583ef69@syzkaller.appspotmail.com

dvb-usb: bulk message failed: -22 (1/-30591)
=====================================================
BUG: KMSAN: uninit-value in ir_lookup_by_scancode  
drivers/media/rc/rc-main.c:494 [inline]
BUG: KMSAN: uninit-value in rc_g_keycode_from_table  
drivers/media/rc/rc-main.c:582 [inline]
BUG: KMSAN: uninit-value in rc_keydown+0x1a6/0x6f0  
drivers/media/rc/rc-main.c:816
CPU: 1 PID: 11436 Comm: kworker/1:2 Not tainted 5.3.0-rc7+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events dvb_usb_read_remote_control
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x191/0x1f0 lib/dump_stack.c:113
  kmsan_report+0x13a/0x2b0 mm/kmsan/kmsan_report.c:108
  __msan_warning+0x73/0xe0 mm/kmsan/kmsan_instr.c:250
  bsearch+0x1dd/0x250 lib/bsearch.c:41
  ir_lookup_by_scancode drivers/media/rc/rc-main.c:494 [inline]
  rc_g_keycode_from_table drivers/media/rc/rc-main.c:582 [inline]
  rc_keydown+0x1a6/0x6f0 drivers/media/rc/rc-main.c:816
  cxusb_rc_query+0x2e1/0x360 drivers/media/usb/dvb-usb/cxusb.c:548
  dvb_usb_read_remote_control+0xf9/0x290  
drivers/media/usb/dvb-usb/dvb-usb-remote.c:261
  process_one_work+0x1572/0x1ef0 kernel/workqueue.c:2269
  worker_thread+0x111b/0x2460 kernel/workqueue.c:2415
  kthread+0x4b5/0x4f0 kernel/kthread.c:256
  ret_from_fork+0x35/0x40 arch/x86/entry/entry_64.S:355

Uninit was stored to memory at:
  kmsan_save_stack_with_flags mm/kmsan/kmsan.c:150 [inline]
  kmsan_internal_chain_origin+0xd2/0x170 mm/kmsan/kmsan.c:314
  __msan_chain_origin+0x6b/0xe0 mm/kmsan/kmsan_instr.c:184
  rc_g_keycode_from_table drivers/media/rc/rc-main.c:583 [inline]
  rc_keydown+0x2c4/0x6f0 drivers/media/rc/rc-main.c:816
  cxusb_rc_query+0x2e1/0x360 drivers/media/usb/dvb-usb/cxusb.c:548
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
=====================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
