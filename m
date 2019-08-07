Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D2DC32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 19:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 124AA2086D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 19:28:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730534AbfHGT2I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 15:28:08 -0400
Received: from mail-ot1-f70.google.com ([209.85.210.70]:43322 "EHLO
        mail-ot1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730145AbfHGT2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 15:28:07 -0400
Received: by mail-ot1-f70.google.com with SMTP id r2so56861436oti.10
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 12:28:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=w5+ZZXPLrYilAe0aqDXTkBC/GqPRvDxPL53VSFC0vZU=;
        b=dy+v6So9gatW57cCERkjxkiUCP/l2TnqdXW2WUWDhysEYNYqPgYzgS4feiMj4bTUJv
         2tjP+F66WicMe3ViIRQQ6sLDdd4YcTc2TJURdc1kNRN5f/02derdftM1LDlsxIkr0BKK
         Lyqwafi9LRW8optvzz5/kLNMuqulHmIYF5Miphc+w/UQj/3YkXNfecxJ8aMHkolHUare
         PDQMg8h5C39V7AUv2SKd82+6SJmyj5fjUeneXfy01Zqql+JCo8rKRbHQcpOOt+wVlw2p
         cRoJ+st2rPPCNOFbZzqrMMFZa069bhEQwvlQJunMDWKgaARq4m3EcHEL+ohy4JnG34WS
         eqEw==
X-Gm-Message-State: APjAAAWXRwVPqSW2C3lHkVnFYk6CCYEUxU665JL5Vuh+Z6vDsZb7Lv1S
        qK53bhUhFPXDB141PhI8J6JRzdvmWxUQ2cjhBZeH5xohO2Bc
X-Google-Smtp-Source: APXvYqzWFAeV6uoAFycl78fTQ3T72cR+IUURMNDJiOnPKmxKVI2gfHSlCZd8ux2hugQqW/BL43kXyl7OoBmXBnR2biwXk5qdQOSr
MIME-Version: 1.0
X-Received: by 2002:a02:9644:: with SMTP id c62mr6449158jai.45.1565206086834;
 Wed, 07 Aug 2019 12:28:06 -0700 (PDT)
Date:   Wed, 07 Aug 2019 12:28:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ce6527058f8bf0d0@google.com>
Subject: BUG: bad usercopy in hidraw_ioctl
From:   syzbot <syzbot+3de312463756f656b47d@syzkaller.appspotmail.com>
To:     allison@lohutok.net, andreyknvl@google.com, cai@lca.pw,
        gregkh@linuxfoundation.org, keescook@chromium.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    e96407b4 usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=151b2926600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cfa2c18fb6a8068e
dashboard link: https://syzkaller.appspot.com/bug?extid=3de312463756f656b47d
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+3de312463756f656b47d@syzkaller.appspotmail.com

usercopy: Kernel memory exposure attempt detected from wrapped address  
(offset 0, size 0)!
------------[ cut here ]------------
kernel BUG at mm/usercopy.c:98!
invalid opcode: 0000 [#1] SMP KASAN
CPU: 1 PID: 2968 Comm: syz-executor.1 Not tainted 5.3.0-rc2+ #25
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:usercopy_abort+0xb9/0xbb mm/usercopy.c:98
Code: e8 c1 f7 d6 ff 49 89 d9 4d 89 e8 4c 89 e1 41 56 48 89 ee 48 c7 c7 e0  
f3 cd 85 ff 74 24 08 41 57 48 8b 54 24 20 e8 15 98 c1 ff <0f> 0b e8 95 f7  
d6 ff e8 80 9f fd ff 8b 54 24 04 49 89 d8 4c 89 e1
RSP: 0018:ffff8881b0f37be8 EFLAGS: 00010282
RAX: 000000000000005a RBX: ffffffff85cdf100 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8128a0fd RDI: ffffed10361e6f6f
RBP: ffffffff85cdf2c0 R08: 000000000000005a R09: ffffed103b665d58
R10: ffffed103b665d57 R11: ffff8881db32eabf R12: ffffffff85cdf460
R13: ffffffff85cdf100 R14: 0000000000000000 R15: ffffffff85cdf100
FS:  00007f539a2a9700(0000) GS:ffff8881db300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000021237d0 CR3: 00000001d6ac6000 CR4: 00000000001406e0
Call Trace:
  check_bogus_address mm/usercopy.c:151 [inline]
  __check_object_size mm/usercopy.c:260 [inline]
  __check_object_size.cold+0xb2/0xba mm/usercopy.c:250
  check_object_size include/linux/thread_info.h:119 [inline]
  check_copy_size include/linux/thread_info.h:150 [inline]
  copy_to_user include/linux/uaccess.h:151 [inline]
  hidraw_ioctl+0x38c/0xae0 drivers/hid/hidraw.c:392
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:509 [inline]
  do_vfs_ioctl+0xd2d/0x1330 fs/ioctl.c:696
  ksys_ioctl+0x9b/0xc0 fs/ioctl.c:713
  __do_sys_ioctl fs/ioctl.c:720 [inline]
  __se_sys_ioctl fs/ioctl.c:718 [inline]
  __x64_sys_ioctl+0x6f/0xb0 fs/ioctl.c:718
  do_syscall_64+0xb7/0x580 arch/x86/entry/common.c:296
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x459829
Code: fd b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f539a2a8c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000459829
RDX: 0000000020000800 RSI: 0000000090044802 RDI: 0000000000000004
RBP: 000000000075c268 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f539a2a96d4
R13: 00000000004c21f3 R14: 00000000004d55b8 R15: 00000000ffffffff
Modules linked in:
---[ end trace 24b9968555bf4653 ]---
RIP: 0010:usercopy_abort+0xb9/0xbb mm/usercopy.c:98
Code: e8 c1 f7 d6 ff 49 89 d9 4d 89 e8 4c 89 e1 41 56 48 89 ee 48 c7 c7 e0  
f3 cd 85 ff 74 24 08 41 57 48 8b 54 24 20 e8 15 98 c1 ff <0f> 0b e8 95 f7  
d6 ff e8 80 9f fd ff 8b 54 24 04 49 89 d8 4c 89 e1
RSP: 0018:ffff8881b0f37be8 EFLAGS: 00010282
RAX: 000000000000005a RBX: ffffffff85cdf100 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8128a0fd RDI: ffffed10361e6f6f
RBP: ffffffff85cdf2c0 R08: 000000000000005a R09: ffffed103b665d58
R10: ffffed103b665d57 R11: ffff8881db32eabf R12: ffffffff85cdf460
R13: ffffffff85cdf100 R14: 0000000000000000 R15: ffffffff85cdf100
FS:  00007f539a2a9700(0000) GS:ffff8881db300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000021237d0 CR3: 00000001d6ac6000 CR4: 00000000001406e0


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
