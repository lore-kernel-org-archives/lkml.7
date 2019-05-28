Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6ADAC04AB3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 00:48:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93D412081C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 00:48:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbfE1AsT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 20:48:19 -0400
Received: from mail-it1-f200.google.com ([209.85.166.200]:50748 "EHLO
        mail-it1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727649AbfE1AsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 20:48:07 -0400
Received: by mail-it1-f200.google.com with SMTP id o128so979966ita.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 17:48:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=B8TLbNnekm690lD0gw+CWGYXJ9HPtvnhpzUnBpwMz+4=;
        b=aINgmkKjN9eI0sUBjhNJ+VHVrRafYnWYWwmlTud5hmdF58D2J+P3ErC9PFAcSFi6EI
         ndLqxOEMiKweoup67ZCZYwLRpZLm5BYZqicbL+9X9ywA0IX6C+Zp9i+4eX/ew3V6CrV6
         eRbRIrE3SQ8WwfKxUkKIRCB/+cC9prU0y1ylY6GKUft77FUSvWN9vKByRj7iC6LDFuvX
         CAms9oxe0Pxgg0C6oL5F/VguKdwHiGhlDtQsnoKwcQL+h29yjGutH830dTYNx6EA9Ztf
         B6k6HUJTivFB6L6y7XUsV2zuyoaToJohlDmA8cN3dZoh/hQ2KBWnNOjoKPVyx6Jne7ec
         pbDQ==
X-Gm-Message-State: APjAAAUFp0ofrOW5Hwfhg/+LIeu5aGqnFoybJACWc0bu7b9u9tlYoSsG
        fKbQDrP8tkVaXR6pFO06RdydBg7SEDiPDfqXrRYiSpc5hTMM
X-Google-Smtp-Source: APXvYqxk76tkYBlrLMKsfqr4G+r4h5pxL2KBmGEGYoNWdpXqnAe7YCR//Wh/T/Mbc8/XQz3xb2rGbhA6ApQFiHm75U0GHtc+3cmw
MIME-Version: 1.0
X-Received: by 2002:a24:7592:: with SMTP id y140mr1343744itc.47.1559004486272;
 Mon, 27 May 2019 17:48:06 -0700 (PDT)
Date:   Mon, 27 May 2019 17:48:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009b950f0589e804b3@google.com>
Subject: memory leak in get_device_parent
From:   syzbot <syzbot+02e97e2ad931a981e568@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    35efb51e Merge tag 'ext4_for_linus_stable' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16577182a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=61dd9e15a761691d
dashboard link: https://syzkaller.appspot.com/bug?extid=02e97e2ad931a981e568
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12dd6b06a00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1128ae9aa00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+02e97e2ad931a981e568@syzkaller.appspotmail.com

8.129630][ T6979] RDX: 0000000000000000 RSI: 00000000400455c8 RDI:  
0000000000000003
BUG: memory leak
unreferenced object 0xffff88812a7a6a80 (size 96):
   comm "syz-executor898", pid 6976, jiffies 4295010285 (age 25.620s)
   hex dump (first 32 bytes):
     88 e0 e8 83 ff ff ff ff 88 6a 7a 2a 81 88 ff ff  .........jz*....
     88 6a 7a 2a 81 88 ff ff 00 00 00 00 00 00 00 00  .jz*............
   backtrace:
     [<00000000b0c40ba3>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:55 [inline]
     [<00000000b0c40ba3>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<00000000b0c40ba3>] slab_alloc mm/slab.c:3326 [inline]
     [<00000000b0c40ba3>] kmem_cache_alloc_trace+0x13d/0x280 mm/slab.c:3553
     [<00000000799c79a9>] kmalloc include/linux/slab.h:547 [inline]
     [<00000000799c79a9>] kzalloc include/linux/slab.h:742 [inline]
     [<00000000799c79a9>] class_dir_create_and_add drivers/base/core.c:1723  
[inline]
     [<00000000799c79a9>] get_device_parent.isra.0+0x1a8/0x240  
drivers/base/core.c:1787
     [<00000000b241fc22>] device_add+0x136/0x890 drivers/base/core.c:2048
     [<00000000ee099a63>] hci_register_dev+0x166/0x380  
net/bluetooth/hci_core.c:3305
     [<00000000c362a920>] hci_uart_register_dev  
drivers/bluetooth/hci_ldisc.c:676 [inline]
     [<00000000c362a920>] hci_uart_set_proto  
drivers/bluetooth/hci_ldisc.c:700 [inline]
     [<00000000c362a920>] hci_uart_tty_ioctl+0x221/0x350  
drivers/bluetooth/hci_ldisc.c:754
     [<00000000de259614>] tty_ioctl+0x6e2/0xa30 drivers/tty/tty_io.c:2664
     [<00000000f5bde6a4>] vfs_ioctl fs/ioctl.c:46 [inline]
     [<00000000f5bde6a4>] file_ioctl fs/ioctl.c:509 [inline]
     [<00000000f5bde6a4>] do_vfs_ioctl+0x62a/0x810 fs/ioctl.c:696
     [<0000000040a4c505>] ksys_ioctl+0x86/0xb0 fs/ioctl.c:713
     [<00000000e454fe0b>] __do_sys_ioctl fs/ioctl.c:720 [inline]
     [<00000000e454fe0b>] __se_sys_ioctl fs/ioctl.c:718 [inline]
     [<00000000e454fe0b>] __x64_sys_ioctl+0x1e/0x30 fs/ioctl.c:718
     [<00000000475478db>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<00000000708a3428>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88811893cf00 (size 96):
   comm "syz-executor898", pid 6978, jiffies 4295011473 (age 13.740s)
   hex dump (first 32 bytes):
     88 e0 e8 83 ff ff ff ff 08 cf 93 18 81 88 ff ff  ................
     08 cf 93 18 81 88 ff ff 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<00000000b0c40ba3>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:55 [inline]
     [<00000000b0c40ba3>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<00000000b0c40ba3>] slab_alloc mm/slab.c:3326 [inline]
     [<00000000b0c40ba3>] kmem_cache_alloc_trace+0x13d/0x280 mm/slab.c:3553
     [<00000000799c79a9>] kmalloc include/linux/slab.h:547 [inline]
     [<00000000799c79a9>] kzalloc include/linux/slab.h:742 [inline]
     [<00000000799c79a9>] class_dir_create_and_add drivers/base/core.c:1723  
[inline]
     [<00000000799c79a9>] get_device_parent.isra.0+0x1a8/0x240  
drivers/base/core.c:1787
     [<00000000b241fc22>] device_add+0x136/0x890 drivers/base/core.c:2048
     [<00000000ee099a63>] hci_register_dev+0x166/0x380  
net/bluetooth/hci_core.c:3305
     [<00000000c362a920>] hci_uart_register_dev  
drivers/bluetooth/hci_ldisc.c:676 [inline]
     [<00000000c362a920>] hci_uart_set_proto  
drivers/bluetooth/hci_ldisc.c:700 [inline]
     [<00000000c362a920>] hci_uart_tty_ioctl+0x221/0x350  
drivers/bluetooth/hci_ldisc.c:754
     [<00000000de259614>] tty_ioctl+0x6e2/0xa30 drivers/tty/tty_io.c:2664
     [<00000000f5bde6a4>] vfs_ioctl fs/ioctl.c:46 [inline]
     [<00000000f5bde6a4>] file_ioctl fs/ioctl.c:509 [inline]
     [<00000000f5bde6a4>] do_vfs_ioctl+0x62a/0x810 fs/ioctl.c:696
     [<0000000040a4c505>] ksys_ioctl+0x86/0xb0 fs/ioctl.c:713
     [<00000000e454fe0b>] __do_sys_ioctl fs/ioctl.c:720 [inline]
     [<00000000e454fe0b>] __se_sys_ioctl fs/ioctl.c:718 [inline]
     [<00000000e454fe0b>] __x64_sys_ioctl+0x1e/0x30 fs/ioctl.c:718
     [<00000000475478db>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<00000000708a3428>] entry_SYSCALL_64_after_hwframe+0x44/0xa9



---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
