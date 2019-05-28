Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18799C04AB3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 00:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E66E220717
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 00:08:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727538AbfE1AIH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 20:08:07 -0400
Received: from mail-it1-f197.google.com ([209.85.166.197]:60135 "EHLO
        mail-it1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726931AbfE1AIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 20:08:06 -0400
Received: by mail-it1-f197.google.com with SMTP id h133so871369ith.9
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 17:08:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=UzrRoJDsqm3s3sNbqFQbEqYkqi8sj9n6NPmUFV5w7no=;
        b=MwWEzwyaPNWLPCtN7o0eP+VmzP66rYA3GXGqJ8oTVHd+x92W5/s6lzJ3EsToOmvIB1
         oSFBKa5GPyPhc8ndzChxEDXhRWIiwQ/yObJgv1ODdztkwM3SpYh2C4X0GO/eMit/oxd9
         LwrifPibTTTAdc3DsjrAUE3fsOKm4lxQz0tPToyJBEXcN460K4ADaijvSp3wYIThNqmu
         z4KQHzx4t0jNzI2FZjEAVxCXeuVubfqwwSCPZSTMcBsxMnPEiGnpR8tXks+02xRMNn9y
         Oajg8kyaEjmZy2/uhrU6aQYeDllpfd6L38ugWEdBylaXurxGjcYtfnWjCvrnKYTZHB0L
         okag==
X-Gm-Message-State: APjAAAUYWu+DdWNkfGGXMwtGfo5sH6u/dChQA2oKNXpK8hK5dBNcjgew
        MGBWJbqnPxgARjNbskzDoQtcDmAyvfaaIGIivfSj9t9G+ufn
X-Google-Smtp-Source: APXvYqw8ScaK06niO2HaDzQtZDNUeaojgIpeDHpSYB1sdBmsKW1jtnZhTCcNAO4AGPo6lvvKwWvmRBdK1C36uog0zB4WEPj+f9mn
MIME-Version: 1.0
X-Received: by 2002:a24:e3cb:: with SMTP id d194mr1220488ith.100.1559002086169;
 Mon, 27 May 2019 17:08:06 -0700 (PDT)
Date:   Mon, 27 May 2019 17:08:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008ce4fd0589e77508@google.com>
Subject: memory leak in process_preds
From:   syzbot <syzbot+6b8e0fb820e570c59e19@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        rostedt@goodmis.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    cd6c84d8 Linux 5.2-rc2
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14039c36a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=64479170dcaf0e11
dashboard link: https://syzkaller.appspot.com/bug?extid=6b8e0fb820e570c59e19
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11f0a64ca00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13c64526a00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+6b8e0fb820e570c59e19@syzkaller.appspotmail.com

e list of known hosts.
executing program
BUG: memory leak
unreferenced object 0xffff88811fb1ee00 (size 512):
   comm "syz-executor320", pid 7159, jiffies 4294942553 (age 7.920s)
   hex dump (first 32 bytes):
     90 09 31 81 ff ff ff ff 00 00 00 00 00 00 00 00  ..1.............
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<0000000038eacd1e>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:55 [inline]
     [<0000000038eacd1e>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<0000000038eacd1e>] slab_alloc mm/slab.c:3326 [inline]
     [<0000000038eacd1e>] kmem_cache_alloc_trace+0x13d/0x280 mm/slab.c:3553
     [<0000000074de3f6b>] kmalloc include/linux/slab.h:547 [inline]
     [<0000000074de3f6b>] kzalloc include/linux/slab.h:742 [inline]
     [<0000000074de3f6b>] parse_pred kernel/trace/trace_events_filter.c:1208  
[inline]
     [<0000000074de3f6b>] predicate_parse  
kernel/trace/trace_events_filter.c:474 [inline]
     [<0000000074de3f6b>] process_preds+0x653/0x1780  
kernel/trace/trace_events_filter.c:1525
     [<0000000007c6ed68>] create_filter+0xa7/0x110  
kernel/trace/trace_events_filter.c:1739
     [<00000000a0b5fc40>] ftrace_profile_set_filter+0x76/0x120  
kernel/trace/trace_events_filter.c:2066
     [<000000001229a861>] perf_event_set_filter kernel/events/core.c:9403  
[inline]
     [<000000001229a861>] _perf_ioctl+0x5b6/0x830 kernel/events/core.c:5086
     [<00000000fd2b26bf>] perf_ioctl+0x3b/0x60 kernel/events/core.c:5137
     [<000000005c40f91e>] vfs_ioctl fs/ioctl.c:46 [inline]
     [<000000005c40f91e>] file_ioctl fs/ioctl.c:509 [inline]
     [<000000005c40f91e>] do_vfs_ioctl+0x62a/0x810 fs/ioctl.c:696
     [<00000000f34a3a21>] ksys_ioctl+0x86/0xb0 fs/ioctl.c:713
     [<00000000c96e9e33>] __do_sys_ioctl fs/ioctl.c:720 [inline]
     [<00000000c96e9e33>] __se_sys_ioctl fs/ioctl.c:718 [inline]
     [<00000000c96e9e33>] __x64_sys_ioctl+0x1e/0x30 fs/ioctl.c:718
     [<0000000039965898>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<00000000a08c0d8e>] entry_SYSCALL_64_after_hwframe+0x44/0xa9



---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
