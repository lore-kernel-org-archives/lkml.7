Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 829F5C2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 14:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 635F4206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 14:45:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfLWOpO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 09:45:14 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:48148 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726682AbfLWOpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 09:45:12 -0500
Received: by mail-il1-f200.google.com with SMTP id u14so5118071ilq.15
        for <linux-kernel@vger.kernel.org>; Mon, 23 Dec 2019 06:45:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=E1dfYnJ0CQPxTAiikTk/x4mwscwQfRR0zv4xREHntWw=;
        b=hOGec816FxCVOd2yYtACu52SdeGinY5IeaVRC1yS84x7cgGP9HzkAzWiv62FbGD5KE
         s9XE/YFOulXoG8sH8sAyLtHeEqjPcu8jS67ug91QRedng7bJAyxsDXbFyDk5TarrITQs
         kr4E4E4oRrtHcyBB6FH8plcbrYv1DNPX0e1SHDRyUAJbCLWn3A4EiIR+zDqiMbpv8ETt
         yD2J2/iPtPjKrW3cf3ug5J4R0Z/uGwoClJpueg25h2OakB9S1YQGz1BNRoBhM0I0YLGY
         cGwqRBXJAjJT5X7cABHMfx1WxXdDoSC++pcnmcbHxLN/cMH0aqfrmFd/KETcTJi5pa+V
         4dvw==
X-Gm-Message-State: APjAAAXYD+yZWXKHslgR+XVOJskS8HCvuZzi5jkRFAStNsS9Mcm3f4YQ
        KvSBN245i/vlC8ymXtF/wICWIJR3C87JJ5J/kPmMkp5VsHX9
X-Google-Smtp-Source: APXvYqz41xFGP7fF07FMNvH+pKDsVosn/A5WDX5JjciwCT+hEJtDa04HXGVjzUnZcQ89+XSVLQIKMnT7+tqh2Bmpxq9j81/1kFhQ
MIME-Version: 1.0
X-Received: by 2002:a02:13ca:: with SMTP id 193mr16132575jaz.54.1577112310433;
 Mon, 23 Dec 2019 06:45:10 -0800 (PST)
Date:   Mon, 23 Dec 2019 06:45:10 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000008d45f059a601393@google.com>
Subject: KASAN: vmalloc-out-of-bounds Read in srcu_invoke_callbacks
From:   syzbot <syzbot+e8574d6a7b2172d6d2a6@syzkaller.appspotmail.com>
To:     jmattson@google.com, junaids@google.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, pbonzini@redhat.com,
        rkrcmar@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    6398b9fc Merge tag 'char-misc-5.5-rc3' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=140da2b9e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1b59a3066828ac4c
dashboard link: https://syzkaller.appspot.com/bug?extid=e8574d6a7b2172d6d2a6
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=152f4a49e00000

The bug was bisected to:

commit 9121923c457d1d8667a6e3a67302c29e5c5add6b
Author: Jim Mattson <jmattson@google.com>
Date:   Thu Oct 24 23:03:26 2019 +0000

     kvm: Allocate memslots and buses before calling kvm_arch_init_vm

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15bf9ac1e00000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=17bf9ac1e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=13bf9ac1e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+e8574d6a7b2172d6d2a6@syzkaller.appspotmail.com
Fixes: 9121923c457d ("kvm: Allocate memslots and buses before calling  
kvm_arch_init_vm")

==================================================================
BUG: KASAN: vmalloc-out-of-bounds in __read_once_size  
include/linux/compiler.h:199 [inline]
BUG: KASAN: vmalloc-out-of-bounds in rcu_seq_current kernel/rcu/rcu.h:99  
[inline]
BUG: KASAN: vmalloc-out-of-bounds in srcu_invoke_callbacks+0x338/0x360  
kernel/rcu/srcutree.c:1169
Read of size 8 at addr ffffc90004c18c78 by task kworker/0:2/9307

CPU: 0 PID: 9307 Comm: kworker/0:2 Not tainted 5.5.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: rcu_gp srcu_invoke_callbacks
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x197/0x210 lib/dump_stack.c:118
  print_address_description.constprop.0.cold+0x5/0x30b mm/kasan/report.c:374
  __kasan_report.cold+0x1b/0x41 mm/kasan/report.c:506
  kasan_report+0x12/0x20 mm/kasan/common.c:639
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/generic_report.c:135
  __read_once_size include/linux/compiler.h:199 [inline]
  rcu_seq_current kernel/rcu/rcu.h:99 [inline]
  srcu_invoke_callbacks+0x338/0x360 kernel/rcu/srcutree.c:1169
  process_one_work+0x9af/0x1740 kernel/workqueue.c:2264
  worker_thread+0x98/0xe40 kernel/workqueue.c:2410
  kthread+0x361/0x430 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352


Memory state around the buggy address:
  ffffc90004c18b00: f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9
  ffffc90004c18b80: f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9
> ffffc90004c18c00: f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9
                                                                 ^
  ffffc90004c18c80: f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9
  ffffc90004c18d00: f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
