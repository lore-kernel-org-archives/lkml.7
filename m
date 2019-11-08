Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB6AEFA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 14:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CA12222C2
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 14:28:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbfKHO2M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 09:28:12 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:56677 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbfKHO2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 09:28:12 -0500
Received: by mail-il1-f199.google.com with SMTP id e5so6973393ile.23
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 06:28:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Fc1AeehNUTfKl/ssy9FjKjLKkl1fuRqIqy43NB+5sHo=;
        b=pMG2izoyE+1DoW/YrWagjkc7BjUnhLaGe99cgsb/iVzGDnHr+YsARwmqQGB/DE2fqV
         c7lv0hQ4AuOLmZfrJmFOpfIm98evs+3feSPdHC8P8wG9f1KQxv94IKNLPyD+1VAQqHKl
         SOl3gE0jXOwhidPhvipsLbg9kSy8sXbCzrq1LWFPvlx1PFEtd2dr8sKlbGqc41Pl4kxt
         4dbDugyJbmBrhNNV0KKjsinc4ubvcrU91xvZNtIL3zT9cgOZqXzk5tpwryXdFBX+QXG1
         pqTgdiQORSzOWGFMbC5DNRJuLje8GqA2ZhmuTsSTFQ60IYBinL0DHB9sihiWpnqdd4ll
         Kj8A==
X-Gm-Message-State: APjAAAX+pR+TCS+F5tYeJniQLTJ5Ly3yHxI/oj67qITZeGPhAUiYTkB7
        B3oacaOa20YupRckvhFKXqgyF6idi72iIuTVMugJfQVg6goK
X-Google-Smtp-Source: APXvYqz+GUs/qSBf9Rk2PflrXCYjo2fZBhJeXHTaoeYr9Pwgzk5CdLXlg5K4ytx+w1iK/Rh4YNNi2GUdwdnyaeumKqxb4jvNtCt6
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1223:: with SMTP id z3mr319283iot.92.1573223290084;
 Fri, 08 Nov 2019 06:28:10 -0800 (PST)
Date:   Fri, 08 Nov 2019 06:28:10 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005ba74a0596d697be@google.com>
Subject: KCSAN: data-race in batadv_tt_local_add / batadv_tt_local_add
From:   syzbot <syzbot+1d5dadec56d9e87f0aac@syzkaller.appspotmail.com>
To:     a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org,
        davem@davemloft.net, elver@google.com,
        linux-kernel@vger.kernel.org, mareklindner@neomailbox.ch,
        netdev@vger.kernel.org, sven@narfation.org, sw@simonwunderlich.de,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    05f22368 x86, kcsan: Enable KCSAN for x86
git tree:       https://github.com/google/ktsan.git kcsan
console output: https://syzkaller.appspot.com/x/log.txt?x=1195a0d4e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=87d111955f40591f
dashboard link: https://syzkaller.appspot.com/bug?extid=1d5dadec56d9e87f0aac
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+1d5dadec56d9e87f0aac@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in batadv_tt_local_add / batadv_tt_local_add

write to 0xffff8880a8e19698 of 2 bytes by task 10064 on cpu 0:
  batadv_tt_local_add+0x21b/0x1020 net/batman-adv/translation-table.c:799
  batadv_interface_tx+0x398/0xae0 net/batman-adv/soft-interface.c:249
  __netdev_start_xmit include/linux/netdevice.h:4420 [inline]
  netdev_start_xmit include/linux/netdevice.h:4434 [inline]
  xmit_one net/core/dev.c:3280 [inline]
  dev_hard_start_xmit+0xef/0x430 net/core/dev.c:3296
  __dev_queue_xmit+0x14c9/0x1b60 net/core/dev.c:3873
  dev_queue_xmit+0x21/0x30 net/core/dev.c:3906
  __bpf_tx_skb net/core/filter.c:2060 [inline]
  __bpf_redirect_common net/core/filter.c:2099 [inline]
  __bpf_redirect+0x4b4/0x710 net/core/filter.c:2106
  ____bpf_clone_redirect net/core/filter.c:2139 [inline]
  bpf_clone_redirect+0x1a5/0x1f0 net/core/filter.c:2111
  bpf_prog_bb15b996d00816f9+0x71c/0x1000
  bpf_test_run+0x1c3/0x490 net/bpf/test_run.c:44
  bpf_prog_test_run_skb+0x4da/0x840 net/bpf/test_run.c:310
  bpf_prog_test_run kernel/bpf/syscall.c:2108 [inline]
  __do_sys_bpf+0x1664/0x2b90 kernel/bpf/syscall.c:2884
  __se_sys_bpf kernel/bpf/syscall.c:2825 [inline]
  __x64_sys_bpf+0x4c/0x60 kernel/bpf/syscall.c:2825
  do_syscall_64+0xcc/0x370 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x44/0xa9

read to 0xffff8880a8e19698 of 2 bytes by task 9969 on cpu 1:
  batadv_tt_local_add+0x3d1/0x1020 net/batman-adv/translation-table.c:801
  batadv_interface_tx+0x398/0xae0 net/batman-adv/soft-interface.c:249
  __netdev_start_xmit include/linux/netdevice.h:4420 [inline]
  netdev_start_xmit include/linux/netdevice.h:4434 [inline]
  xmit_one net/core/dev.c:3280 [inline]
  dev_hard_start_xmit+0xef/0x430 net/core/dev.c:3296
  __dev_queue_xmit+0x14c9/0x1b60 net/core/dev.c:3873
  dev_queue_xmit+0x21/0x30 net/core/dev.c:3906
  __bpf_tx_skb net/core/filter.c:2060 [inline]
  __bpf_redirect_common net/core/filter.c:2099 [inline]
  __bpf_redirect+0x4b4/0x710 net/core/filter.c:2106
  ____bpf_clone_redirect net/core/filter.c:2139 [inline]
  bpf_clone_redirect+0x1a5/0x1f0 net/core/filter.c:2111
  bpf_prog_bb15b996d00816f9+0x312/0x1000
  bpf_test_run+0x1c3/0x490 net/bpf/test_run.c:44
  bpf_prog_test_run_skb+0x4da/0x840 net/bpf/test_run.c:310
  bpf_prog_test_run kernel/bpf/syscall.c:2108 [inline]
  __do_sys_bpf+0x1664/0x2b90 kernel/bpf/syscall.c:2884
  __se_sys_bpf kernel/bpf/syscall.c:2825 [inline]
  __x64_sys_bpf+0x4c/0x60 kernel/bpf/syscall.c:2825
  do_syscall_64+0xcc/0x370 arch/x86/entry/common.c:290

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 PID: 9969 Comm: syz-executor.2 Not tainted 5.4.0-rc3+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
