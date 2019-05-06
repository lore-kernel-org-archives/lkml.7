Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 459BEC04AAB
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 11:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2142420830
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 11:16:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbfEFLQ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 07:16:27 -0400
Received: from mail-it1-f200.google.com ([209.85.166.200]:44647 "EHLO
        mail-it1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbfEFLQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 07:16:07 -0400
Received: by mail-it1-f200.google.com with SMTP id v193so11233161itv.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 04:16:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=wfo46abTbmuRXvxeTUG8sMq7sgvtISG77eUoUAEQFR8=;
        b=hvSt/92RHdPaTeBqKumiNtOC2kPK+HnrrSsPxnU8B0dupbk9yTzNHgL8iyltF88PNf
         hLdsIhMhmgwLNlWAzaW6YDWjsvSun5eU2PfCsdCpg463Sw1Q9WtrwEo3XSDnAJSZoxF1
         +wW9PhQpDUxP6yzkqbFOkYqkotXHACI23+FIlXHQSspqqDejkXI6bcJapPS270Ohedgk
         siM5/CBU+WLe9P0EC6XxuJprGn61/4K69tVNFVa+3XbFZdEBIFWn5p66t+zlesM8sv/6
         X5kTYbTawWxcUfI9Ujaf33f87z/Z1rSn4oDK3ZOlryJY69fFMPgz1FJHjue+HUohLbZR
         G++g==
X-Gm-Message-State: APjAAAXZ8FZz9y1LuwtiHuoW5YX+xrDGFeuZnv1yDT2uktLB7NjoNHbR
        BOEuhqvNerHjdBCjSq9D1BplLxAdy9rkU8uS1j7LgVgH4+6L
X-Google-Smtp-Source: APXvYqzztlzlI6lMg9dhbdBE2nMsatxOpEwiQJkKfQh2hgdzj0WiGZDn2eO24DJhUe9O8pBYwusHdq0rIw///dxTCUPu68EKeRG3
MIME-Version: 1.0
X-Received: by 2002:a6b:3ac3:: with SMTP id h186mr12861180ioa.63.1557141366572;
 Mon, 06 May 2019 04:16:06 -0700 (PDT)
Date:   Mon, 06 May 2019 04:16:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000050c5f0588363ad6@google.com>
Subject: KASAN: use-after-free Read in p54u_load_firmware_cb
From:   syzbot <syzbot+200d4bb11b23d929335f@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, chunkeey@googlemail.com,
        davem@davemloft.net, kvalo@codeaurora.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    43151d6c usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=142b312ca00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4183eeef650d1234
dashboard link: https://syzkaller.appspot.com/bug?extid=200d4bb11b23d929335f
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+200d4bb11b23d929335f@syzkaller.appspotmail.com

usb 4-1: Direct firmware load for isl3887usb failed with error -2
usb 4-1: Firmware not found.
==================================================================
BUG: KASAN: use-after-free in p54u_load_firmware_cb.cold+0x97/0x13a  
drivers/net/wireless/intersil/p54/p54usb.c:936
Read of size 8 at addr ffff888098bf3588 by task kworker/0:1/12

CPU: 0 PID: 12 Comm: kworker/0:1 Not tainted 5.1.0-rc3-319004-g43151d6 #6
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events request_firmware_work_func
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0xe8/0x16e lib/dump_stack.c:113
  print_address_description+0x6c/0x236 mm/kasan/report.c:187
  kasan_report.cold+0x1a/0x3c mm/kasan/report.c:317
  p54u_load_firmware_cb.cold+0x97/0x13a  
drivers/net/wireless/intersil/p54/p54usb.c:936
  request_firmware_work_func+0x12d/0x249  
drivers/base/firmware_loader/main.c:785
  process_one_work+0x90f/0x1580 kernel/workqueue.c:2269
  worker_thread+0x9b/0xe20 kernel/workqueue.c:2415
  kthread+0x313/0x420 kernel/kthread.c:253
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352

The buggy address belongs to the page:
page:ffffea000262fcc0 count:0 mapcount:0 mapping:0000000000000000 index:0x0
flags: 0xfff00000000000()
raw: 00fff00000000000 0000000000000000 ffffffff02620101 0000000000000000
raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff888098bf3480: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
  ffff888098bf3500: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> ffff888098bf3580: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                       ^
  ffff888098bf3600: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
  ffff888098bf3680: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
