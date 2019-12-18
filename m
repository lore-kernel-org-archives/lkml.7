Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F780C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 14:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29A5821582
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 14:45:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbfLROpO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 09:45:14 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:38480 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726856AbfLROpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 09:45:13 -0500
Received: by mail-il1-f199.google.com with SMTP id i67so1918844ilf.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 06:45:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=0bdlNmaxCD5fqq7L78Z2fQzwkj/o9Hs5/Lv+Ota1nxg=;
        b=eh/Gyux/N+l7I7GknK6OGbJjcmZOS3Q/+BmGlCO3LGoL+s49rYPMXyZP0wIXgPx8gh
         Tg2yLj+8bFSOJee/SJ0Hys8AsJSNvNepWkwDDL1AWvRGd012+TowQpwIg8AU9Yc6YS2K
         a/zUE7DUkfy6mv7WgaDDTUz4ai13F71oT9LCwh6i0BIqcJDHnor37Y1FfaGcv/BsSt1k
         QjZU5dzZ3oIhTZxYLJrrTPYKSzk7ZESizAAlY9KKyd2hDtVnFdI4LgFauqrMF3WXQVlS
         H/TllY/3qVSrEYwyXJOV5tborUloR3Hh2FcW64VJuNbbER45RXJQ972soZ+p7tJVSlsf
         ECcw==
X-Gm-Message-State: APjAAAWmwvj8vN78aJFDmYBcp6c9iyDaz6pmDe1GhXM44URLfftrMmU7
        PWJ+BACfH2gIq/AvDAOln7ueVq8lRrZ2vmnkoFv2SMGhKD6Y
X-Google-Smtp-Source: APXvYqybjSYiAZFu7Xg50IBunoKwYwK5lK7Rqh2qMNJUI3t/FMi22e3PBYDNnKJGOQCWh8l6rLjB8I4xhB4jf6mlSAy+b4MqVyNO
MIME-Version: 1.0
X-Received: by 2002:a92:5855:: with SMTP id m82mr2170777ilb.302.1576680310849;
 Wed, 18 Dec 2019 06:45:10 -0800 (PST)
Date:   Wed, 18 Dec 2019 06:45:10 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000daea9f0599fb7da6@google.com>
Subject: KASAN: slab-out-of-bounds Read in hidinput_hid_event
From:   syzbot <syzbot+00eaa791c74b27f5e7b1@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, benjamin.tissoires@redhat.com,
        jikos@kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        rydberg@bitmath.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    d533c992 usb: core: kcov: collect coverage from usb comple..
git tree:       https://github.com/google/kasan.git usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=11e440aee00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=743b91162e9f9496
dashboard link: https://syzkaller.appspot.com/bug?extid=00eaa791c74b27f5e7b1
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1445d9fae00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12557049e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+00eaa791c74b27f5e7b1@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in test_bit  
include/asm-generic/bitops/instrumented-non-atomic.h:110 [inline]
BUG: KASAN: slab-out-of-bounds in hidinput_hid_event+0x1111/0x15d3  
drivers/hid/hid-input.c:1381
Read of size 8 at addr ffff8881cf4d2cd0 by task swapper/1/0

CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.5.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  <IRQ>
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0xef/0x16e lib/dump_stack.c:118
  print_address_description.constprop.0+0x16/0x200 mm/kasan/report.c:374
  __kasan_report.cold+0x37/0x7f mm/kasan/report.c:506
  kasan_report+0xe/0x20 mm/kasan/common.c:639
  check_memory_region_inline mm/kasan/generic.c:185 [inline]
  check_memory_region+0x152/0x1c0 mm/kasan/generic.c:192
  test_bit include/asm-generic/bitops/instrumented-non-atomic.h:110 [inline]
  hidinput_hid_event+0x1111/0x15d3 drivers/hid/hid-input.c:1381
  hid_process_event+0x4a0/0x580 drivers/hid/hid-core.c:1506
  hid_input_field drivers/hid/hid-core.c:1550 [inline]
  hid_report_raw_event+0xabb/0xed0 drivers/hid/hid-core.c:1757
  hid_input_report+0x315/0x3f0 drivers/hid/hid-core.c:1824
  hid_irq_in+0x50e/0x690 drivers/hid/usbhid/hid-core.c:284



---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
