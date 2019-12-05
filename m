Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	PDS_BTC_ID,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE75FC43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 05:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE9F02077B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 05:45:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbfLEFpK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 00:45:10 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:43461 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbfLEFpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 00:45:08 -0500
Received: by mail-il1-f197.google.com with SMTP id j17so1653334ilc.10
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 21:45:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=hbk8dpEVaqWWM6KdvtUeNGp8UKgFEwT9m36xDP3TGQA=;
        b=l3OAJniGyhrd3cdjgP8pBEbLW1CKcnZ/IPYSq3AJuSS0yCi0EGHEyHHFC5BNKXI8/i
         FM6z/YicmvaRlHIpnEivIDqjCTN3MWc8HWXI4bf8jAVrjrvyc3Sl1Pu8c1t3CzFqeQd7
         p7f8KwSFO25xn+Z7gfasKEyWGRcoElY9nF/9cWMiK8un0h4IxpojRxbdhivgV33j1tpx
         s2FygWOasT13d7wVnR3C5GTPcfUtFm1gfWPSWbTr+GEyeMxKFYAeTqREKHzakXsZYBoW
         Kg1xr7IMgpGNF/KIx5pT2Dnyp7OFgzzpQLE7a4l2df9h5TuRhuN1EwCq/+zpnJ5ztrko
         0adw==
X-Gm-Message-State: APjAAAUtT7OnxmFvU3O4mFkRUJr2c+C1e4Vg5Z5OoJqmT1LdtGbNsNS9
        BPfpoY8I2Jic3uc35mvt+4OIDWDinVF6+n+PLUJAXuTxLVN0
X-Google-Smtp-Source: APXvYqxp6JgOevX+srs+s+AdEBdfEoYzH4Gg1/DnrUSa+a/pBQVGvsUt92hQfgW1QyQclDsAhqZtEwNWTOvJG2eWVBgLImOt6d9R
MIME-Version: 1.0
X-Received: by 2002:a6b:7846:: with SMTP id h6mr4866164iop.33.1575524707888;
 Wed, 04 Dec 2019 21:45:07 -0800 (PST)
Date:   Wed, 04 Dec 2019 21:45:07 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008c72510598ee6ee7@google.com>
Subject: kmsan boot error: KMSAN: uninit-value in proc_task_name
From:   syzbot <syzbot+c0d17fd100b00692b701@syzkaller.appspotmail.com>
To:     adobriyan@gmail.com, akpm@linux-foundation.org,
        bigeasy@linutronix.de, glider@google.com,
        john.ogness@linutronix.de, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, mhocko@suse.com, mingo@kernel.org,
        syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    818fcf71 Revert "kmsan: disable strscpy() optimization und..
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=11b8bb7ae00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fde150fb1e865232
dashboard link: https://syzkaller.appspot.com/bug?extid=c0d17fd100b00692b701
compiler:       clang version 9.0.0 (/home/glider/llvm/clang  
80fee25776c2fb61e74c1ecb1a523375c2500b69)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+c0d17fd100b00692b701@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in seq_commit include/linux/seq_file.h:89 [inline]
BUG: KMSAN: uninit-value in proc_task_name+0x574/0x590 fs/proc/array.c:121
CPU: 1 PID: 5202 Comm: ps Not tainted 5.4.0-rc8-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x220 lib/dump_stack.c:118
  kmsan_report+0x128/0x220 mm/kmsan/kmsan_report.c:108
  __msan_warning+0x57/0xa0 mm/kmsan/kmsan_instr.c:245
  seq_commit include/linux/seq_file.h:89 [inline]
  proc_task_name+0x574/0x590 fs/proc/array.c:121
  do_task_stat+0x1a7b/0x3090 fs/proc/array.c:540
  proc_tgid_stat+0xbe/0xf0 fs/proc/array.c:632
  proc_single_show+0x1a8/0x2b0 fs/proc/base.c:756
  seq_read+0xac6/0x1d90 fs/seq_file.c:229
  __vfs_read+0x1a9/0xc90 fs/read_write.c:425
  vfs_read+0x359/0x6f0 fs/read_write.c:461
  ksys_read+0x265/0x430 fs/read_write.c:587
  __do_sys_read fs/read_write.c:597 [inline]
  __se_sys_read+0x92/0xb0 fs/read_write.c:595
  __x64_sys_read+0x4a/0x70 fs/read_write.c:595
  do_syscall_64+0xb6/0x160 arch/x86/entry/common.c:291
  entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7fd34fa40310
Code: 73 01 c3 48 8b 0d 28 4b 2b 00 31 d2 48 29 c2 64 89 11 48 83 c8 ff eb  
ea 90 90 83 3d e5 a2 2b 00 00 75 10 b8 00 00 00 00 0f 05 <48> 3d 01 f0 ff  
ff 73 31 c3 48 83 ec 08 e8 6e 8a 01 00 48 89 04 24
RSP: 002b:00007ffc157facf8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 0000000000000006 RCX: 00007fd34fa40310
RDX: 0000000000000fff RSI: 00007fd34ff0dd00 RDI: 0000000000000006
RBP: 0000000000000fff R08: 0000000000000000 R09: 00007fd34fd08a10
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fd34ff0dd00
R13: 0000000001a59150 R14: 0000000000000005 R15: 0000000000000000

Local variable description: ----tcomm@proc_task_name
Variable was created at:
  proc_task_name+0x8d/0x590 fs/proc/array.c:103
  proc_task_name+0x8d/0x590 fs/proc/array.c:103
=====================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
