Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8448CC3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 14:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B0D020644
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 14:10:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j5WhHLYU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729249AbfHUOKe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 10:10:34 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42476 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729082AbfHUOKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 10:10:33 -0400
Received: by mail-pg1-f196.google.com with SMTP id p3so1375417pgb.9
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 07:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ue/4IYoQeL9A0W6aMybGXh4qABvjCO5qT8fbkA5W6Ss=;
        b=j5WhHLYUGwLKS9upchIWKEpAgy5jRiUMwq8mXlxg+J/Xe9OGcwkasDe51SvBqKJMwr
         NHtbScjIi/KiA0+TXOYAx4xNnTyY5XiIIvPMNcC5zDI9tytfaTNZCD3ER/KaqfTKrJDb
         60Mhq4RIn1m7ohQItoDHQZVRrPYHUgeyXGX9z5u2WQB/lLZDrG7FwbsFiHNfwCv6H/0E
         mopSMWpaxVJRqcg5k9hIqoJhznUpoa32gqG+vhlWQePEi3Bjs6RCUN9bmhhdxGvWHQdx
         8y/wT8Zw44uNt5iK8KnAe0qz5teGhrt3IRBBpGgoeYH34afiMIRh7ZRu9WdQ2At2JjVB
         UQuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ue/4IYoQeL9A0W6aMybGXh4qABvjCO5qT8fbkA5W6Ss=;
        b=htLTO3QrruaMPxoiEWDpZFHGv1E7T/POaBcIUlT5q+6zrrnsAMKsQnAM3N+tkpPKit
         y/NM8Kr4lZ8kWZgACZJJ0zG7V7G8rSB90AGhjNJe+3VNi56vnltYGhds2YEJrqF2tSn7
         kDDpp3JZBQbfXRU4LHuO52XgTAxXvcPESFBDLCYSGGkBcAE7xcD7Kdulellwqog//Azh
         Jp39Bbu7dD85zfrCEMWGRgKToV+EiUjcEe9HttQ38BozY57a6VpgI/XDz+FF11gIU5Ri
         yEd/mdZHsXgTCEpAwBkpCPRwHM6lLxJAqUGTXSOrb7JsTND0Np7GZ3Bppo47BcZukEFB
         FhLQ==
X-Gm-Message-State: APjAAAU5OU/OXddNw6TkmKC8mtBt/3pOFQfs+c+Y5SpGaHe8gMVWWahU
        eoBGsjWjofimYv8fRZMOtKFdk0r7qGl0s63jIfYKrQ==
X-Google-Smtp-Source: APXvYqzNZG8TIxZBCA3evuvZ1lpzdFqGvUjIwf3tWPeEEg19EDstl6hIXS5CNuyFPm6UFNZyThxfwitkaDoA4CktRqA=
X-Received: by 2002:aa7:9e0a:: with SMTP id y10mr35469611pfq.93.1566396631737;
 Wed, 21 Aug 2019 07:10:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAAeHK+x-q8u_-qyc6=5QjuLAtQafOftdmK_JEFVrvzjmowf2Ow@mail.gmail.com>
 <000000000000ed58060590a0aa30@google.com>
In-Reply-To: <000000000000ed58060590a0aa30@google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Wed, 21 Aug 2019 16:10:20 +0200
Message-ID: <CAAeHK+xQc5Ce6TwtERTmQ+6qSbuAmGikxCU5SNTdcDAynDEiig@mail.gmail.com>
Subject: Re: KASAN: slab-out-of-bounds Read in hidraw_ioctl
To:     syzbot <syzbot+5a6c4ec678a0c6ee84ba@syzkaller.appspotmail.com>
Cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 3:37 PM syzbot
<syzbot+5a6c4ec678a0c6ee84ba@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot has tested the proposed patch but the reproducer still triggered
> crash:
> KASAN: slab-out-of-bounds Read in hidraw_ioctl

Same here, a different bug.

>
> ==================================================================
> BUG: KASAN: slab-out-of-bounds in strlen+0x79/0x90 lib/string.c:525
> Read of size 1 at addr ffff8881c8035f38 by task syz-executor.4/2833
>
> CPU: 1 PID: 2833 Comm: syz-executor.4 Not tainted 5.3.0-rc2+ #1
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>   __dump_stack lib/dump_stack.c:77 [inline]
>   dump_stack+0xca/0x13e lib/dump_stack.c:113
>   print_address_description+0x6a/0x32c mm/kasan/report.c:351
>   __kasan_report.cold+0x1a/0x33 mm/kasan/report.c:482
>   kasan_report+0xe/0x12 mm/kasan/common.c:612
>   strlen+0x79/0x90 lib/string.c:525
>   strlen include/linux/string.h:281 [inline]
>   hidraw_ioctl+0x245/0xae0 drivers/hid/hidraw.c:446
>   vfs_ioctl fs/ioctl.c:46 [inline]
>   file_ioctl fs/ioctl.c:509 [inline]
>   do_vfs_ioctl+0xd2d/0x1330 fs/ioctl.c:696
>   ksys_ioctl+0x9b/0xc0 fs/ioctl.c:713
>   __do_sys_ioctl fs/ioctl.c:720 [inline]
>   __se_sys_ioctl fs/ioctl.c:718 [inline]
>   __x64_sys_ioctl+0x6f/0xb0 fs/ioctl.c:718
>   do_syscall_64+0xb7/0x580 arch/x86/entry/common.c:296
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x459829
> Code: fd b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7
> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff
> ff 0f 83 cb b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007f7a68f6dc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000459829
> RDX: 0000000000000000 RSI: 0000000080404805 RDI: 0000000000000004
> RBP: 000000000075bf20 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007f7a68f6e6d4
> R13: 00000000004c21de R14: 00000000004d5620 R15: 00000000ffffffff
>
> Allocated by task 0:
> (stack is not available)
>
> Freed by task 0:
> (stack is not available)
>
> The buggy address belongs to the object at ffff8881c8035e60
>   which belongs to the cache shmem_inode_cache of size 1168
> The buggy address is located 216 bytes inside of
>   1168-byte region [ffff8881c8035e60, ffff8881c80362f0)
> The buggy address belongs to the page:
> page:ffffea0007200d00 refcount:1 mapcount:0 mapping:ffff8881da115180
> index:0x0 compound_mapcount: 0
> flags: 0x200000000010200(slab|head)
> raw: 0200000000010200 dead000000000100 dead000000000122 ffff8881da115180
> raw: 0000000000000000 00000000800c000c 00000001ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
>
> Memory state around the buggy address:
>   ffff8881c8035e00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>   ffff8881c8035e80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> > ffff8881c8035f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>                                          ^
>   ffff8881c8035f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>   ffff8881c8036000: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> ==================================================================
>
>
> Tested on:
>
> commit:         e96407b4 usb-fuzzer: main usb gadget fuzzer driver
> git tree:       https://github.com/google/kasan.git
> console output: https://syzkaller.appspot.com/x/log.txt?x=14f14a1e600000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=cfa2c18fb6a8068e
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> patch:          https://syzkaller.appspot.com/x/patch.diff?x=171cd95a600000
>
