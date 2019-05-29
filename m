Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A55FC28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 16:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69D2923D90
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 16:28:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbfE2Q2H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 12:28:07 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:50010 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfE2Q2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 12:28:07 -0400
Received: by mail-io1-f72.google.com with SMTP id l9so2225000iok.16
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 09:28:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=MG6c9S6QGevsn/1H898oyz6b7y7QuLfAW413DTwZQBs=;
        b=Iu4SW7+XZOewQynrROnYWuI55BObOPz7Oq+iIh+AtUz1282R8c5/1yh8Y9YdvBomSr
         j7alE1guQ3rUN4dsvCcnAQ51v5tnRPMniEBXGvomzqHKiAdoeLt4/uLC6TFiqLW8iubY
         FnNoi8t0VcE5COrdC0PTL0e3f4B3Q1yrnhnrIp2iCCnwJaJEkboOo08etz6Na7ot5FGo
         SpY7bqtQTXYBS3Z++2kE6yMCjrNReGMv7NXpsa+Nnnz8UPlbfHPlCSOhc4/ReooucMDB
         N8RgesGTeccFKUaRG1o44IgQ72+6OL8q64PSn6miHZp6V3lKnJAFePq1hw9dIzuJAsuo
         l7tA==
X-Gm-Message-State: APjAAAWTTVYrHRenYNeTzqitX/k0ty3hhHPoScCiNkM0v1r5f7Xlejja
        yoEKGNqnZlxTiia4Y1RKL5dZRBnrZL589CbZrzVneF0uP3q+
X-Google-Smtp-Source: APXvYqxiIoEYFPXnh0juqE44qs+a4zgzFM3bIyymTGMqgWThjU+fJI16KL8qP3aMlI/1EbAT1DMSYXQINIRIXvuvuUBkJT2UHJwr
MIME-Version: 1.0
X-Received: by 2002:a24:9ac7:: with SMTP id l190mr5038236ite.100.1559147286294;
 Wed, 29 May 2019 09:28:06 -0700 (PDT)
Date:   Wed, 29 May 2019 09:28:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000026f98d058a0944ed@google.com>
Subject: memory leak in kobject_set_name_vargs
From:   syzbot <syzbot+7fddca22578bc67c3fe4@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    9fb67d64 Merge tag 'pinctrl-v5.2-2' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11929a5ca00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=64479170dcaf0e11
dashboard link: https://syzkaller.appspot.com/bug?extid=7fddca22578bc67c3fe4
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1260e44aa00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13014582a00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+7fddca22578bc67c3fe4@syzkaller.appspotmail.com

ffffffffda RBX: 0000000000000003 RCX: 00000000004426c9
BUG: memory leak
unreferenced object 0xffff88811d8a84e0 (size 32):
   comm "syz-executor542", pid 6993, jiffies 4294943975 (age 8.330s)
   hex dump (first 32 bytes):
     70 68 79 33 00 74 61 73 6b 2f 36 39 39 33 00 de  phy3.task/6993..
     33 33 ff aa aa 28 00 00 00 00 00 00 00 00 00 00  33...(..........
   backtrace:
     [<000000007298dac3>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:55 [inline]
     [<000000007298dac3>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<000000007298dac3>] slab_alloc mm/slab.c:3326 [inline]
     [<000000007298dac3>] __do_kmalloc mm/slab.c:3658 [inline]
     [<000000007298dac3>] __kmalloc_track_caller+0x15d/0x2c0 mm/slab.c:3675
     [<000000002d35f1ca>] kvasprintf+0x6d/0xe0 lib/kasprintf.c:25
     [<00000000a242e8c2>] kvasprintf_const+0x96/0xe0 lib/kasprintf.c:49
     [<000000009923ecab>] kobject_set_name_vargs+0x40/0xe0 lib/kobject.c:289
     [<0000000031da656f>] dev_set_name+0x63/0x90 drivers/base/core.c:1915
     [<00000000cb933060>] wiphy_new_nm+0x2d9/0x820 net/wireless/core.c:470
     [<00000000fe076c30>] ieee80211_alloc_hw_nm+0x158/0x770  
net/mac80211/main.c:551
     [<000000002d397aa1>] mac80211_hwsim_new_radio+0xad/0x1150  
drivers/net/wireless/mac80211_hwsim.c:2655
     [<00000000de4d0f50>] hwsim_new_radio_nl+0x369/0x50a  
drivers/net/wireless/mac80211_hwsim.c:3490
     [<00000000c2565b18>] genl_family_rcv_msg+0x2ab/0x5b0  
net/netlink/genetlink.c:629
     [<00000000dbd164a1>] genl_rcv_msg+0x54/0x9c net/netlink/genetlink.c:654
     [<00000000cfe4f152>] netlink_rcv_skb+0x61/0x170  
net/netlink/af_netlink.c:2486
     [<000000001803b485>] genl_rcv+0x29/0x40 net/netlink/genetlink.c:665
     [<000000008f236552>] netlink_unicast_kernel  
net/netlink/af_netlink.c:1311 [inline]
     [<000000008f236552>] netlink_unicast+0x1ec/0x2d0  
net/netlink/af_netlink.c:1337
     [<0000000030d22a07>] netlink_sendmsg+0x26a/0x480  
net/netlink/af_netlink.c:1926
     [<00000000b09b44f1>] sock_sendmsg_nosec net/socket.c:652 [inline]
     [<00000000b09b44f1>] sock_sendmsg+0x54/0x70 net/socket.c:671



---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
