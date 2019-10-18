Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E80CA9EA9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 14:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85C74222BD
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 14:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571409598;
	bh=KEeMWcWazyiDRPv/ISngltovQNsVFbSkCY6wvhP2aWs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=D/v0IaX8UFTk8BrJSqOmqKugDdGIH2vGoWueEVjXGzcTZFVbrCJ/hZ2IfY+8OqPGR
	 bAHRYdwZ4mLJYbhOM4zjAgLLL6WDOyX+R0AL14v+gfinZy4Bkwg7UIoypXLsuDKx6r
	 IVMTtQJe2AKy6zIYK6jQrVJ5Ai1TpcIE2UqBJzy8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505089AbfJROj5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 10:39:57 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44556 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389378AbfJROj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 10:39:56 -0400
Received: by mail-lj1-f193.google.com with SMTP id m13so6459267ljj.11;
        Fri, 18 Oct 2019 07:39:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QJnMOlscwxXW+QzeaNmoSRBDe1oMqPCOEpK7Arddsgs=;
        b=TAw1AkJJUYFOhaKjHxnY0b8yi3ietJl3ugPDhCQgtRilSGr8lH/LtZDOIPhkOq5WAU
         CKvVXI1njIi4fNbHAlibcEW/CP79nucpApYZ9kmLfr2q7dlBsnbyVvw4v5BHZhp62jt2
         /r7nYwaYwzySxqXErsVZxSghktU/NLuXWBmpQyfWwtVnpkQ5jULVdPNRaLtQVYitquu+
         mj4QvOr2kctNtaJ62Ysn3Q8dw4p0qqjCmWwnX+qlMWq2SnFmnk9svjtI4/PtykLIRgk1
         XD18k2Oz9H6/vb9ufYjwja6x5O3+WCA8/gD1XF09lGPRcymBpL2frHUXLw2hogvXppYg
         rHoA==
X-Gm-Message-State: APjAAAU0qvEEnpdJH1Usc0VjrhtuSvfze7BTiCzTtbowcm8wju81M+Kb
        JefVp6e0OjivClqx5yPvv6I=
X-Google-Smtp-Source: APXvYqxZOk7/P77LDg5/nI0IyFYUjbGv7SI0M+A5MdC70kVAKNbP/1r7jj5fzlbP3+0tybV9RCxgCg==
X-Received: by 2002:a2e:2b91:: with SMTP id r17mr6573277ljr.1.1571409592485;
        Fri, 18 Oct 2019 07:39:52 -0700 (PDT)
Received: from xi.terra (c-51f1e055.07-184-6d6c6d4.bbcust.telenor.se. [85.224.241.81])
        by smtp.gmail.com with ESMTPSA id a8sm2822024ljf.47.2019.10.18.07.39.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Oct 2019 07:39:51 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.92.2)
        (envelope-from <johan@kernel.org>)
        id 1iLTQB-0006Ql-UA; Fri, 18 Oct 2019 16:40:04 +0200
Date:   Fri, 18 Oct 2019 16:40:03 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     syzbot <syzbot+4cd8c1b2445d0ffe05f6@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Qian Cai <cai@lca.pw>, info@metux.net, isaacm@codeaurora.org,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        USB list <linux-usb@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        william.kucharski@oracle.com
Subject: Re: BUG: bad usercopy in ld_usb_read (2)
Message-ID: <20191018144003.GG21827@localhost>
References: <0000000000003a00b70592b00f85@google.com>
 <CAAeHK+xUbG1pvgjU2jRogtS8GjtdyZebgJQzrSHW80rjYsTx7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAeHK+xUbG1pvgjU2jRogtS8GjtdyZebgJQzrSHW80rjYsTx7A@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 17, 2019 at 02:20:55PM +0200, Andrey Konovalov wrote:
> On Mon, Sep 16, 2019 at 8:49 PM syzbot
> <syzbot+4cd8c1b2445d0ffe05f6@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    f0df5c1b usb-fuzzer: main usb gadget fuzzer driver
> > git tree:       https://github.com/google/kasan.git usb-fuzzer
> > console output: https://syzkaller.appspot.com/x/log.txt?x=1681c9c1600000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=5c6633fa4ed00be5
> > dashboard link: https://syzkaller.appspot.com/bug?extid=4cd8c1b2445d0ffe05f6
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> >
> > Unfortunately, I don't have any reproducer for this crash yet.
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+4cd8c1b2445d0ffe05f6@syzkaller.appspotmail.com
> >
> > ldusb 5-1:0.98: Read buffer overflow, 4466454212372071848 bytes dropped
> > usercopy: Kernel memory exposure attempt detected from process stack
> > (offset 0, size 536871625)!
> > ------------[ cut here ]------------
> > kernel BUG at mm/usercopy.c:98!
> > invalid opcode: 0000 [#1] SMP KASAN
> > CPU: 1 PID: 17170 Comm: syz-executor.4 Not tainted 5.3.0-rc7+ #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> > Google 01/01/2011
> > RIP: 0010:usercopy_abort+0xb9/0xbb mm/usercopy.c:98
> > Code: e8 62 f0 d6 ff 49 89 d9 4d 89 e8 4c 89 e1 41 56 48 89 ee 48 c7 c7 c0
> > f7 cd 85 ff 74 24 08 41 57 48 8b 54 24 20 e8 c6 91 c1 ff <0f> 0b e8 36 f0
> > d6 ff e8 a1 90 fd ff 8b 54 24 04 49 89 d8 4c 89 e1
> > RSP: 0018:ffff8881d308fc40 EFLAGS: 00010282
> > RAX: 0000000000000060 RBX: ffffffff85cdf4e0 RCX: 0000000000000000
> > RDX: 0000000000000000 RSI: ffffffff81288ddd RDI: ffffed103a611f7a
> > RBP: ffffffff85cdf6a0 R08: 0000000000000060 R09: fffffbfff11ad7a3
> > R10: fffffbfff11ad7a2 R11: ffffffff88d6bd17 R12: ffffffff85cdf8c0
> > R13: ffffffff85cdf4e0 R14: 00000000200002c9 R15: ffffffff85cdf4e0
> > FS:  00007fc613f93700(0000) GS:ffff8881db300000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007f983cbbf000 CR3: 00000001cc33e000 CR4: 00000000001406e0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >   __check_object_size mm/usercopy.c:276 [inline]
> >   __check_object_size.cold+0x91/0xbb mm/usercopy.c:250
> >   check_object_size include/linux/thread_info.h:119 [inline]
> >   check_copy_size include/linux/thread_info.h:150 [inline]
> >   copy_to_user include/linux/uaccess.h:151 [inline]
> >   ld_usb_read+0x304/0x780 drivers/usb/misc/ldusb.c:495
> >   __vfs_read+0x76/0x100 fs/read_write.c:425
> >   vfs_read+0x1ea/0x430 fs/read_write.c:461
> >   ksys_read+0x1e8/0x250 fs/read_write.c:587
> >   do_syscall_64+0xb7/0x580 arch/x86/entry/common.c:296
> >   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > RIP: 0033:0x4598e9
> > Code: fd b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7
> > 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff
> > ff 0f 83 cb b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
> > RSP: 002b:00007fc613f92c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> > RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00000000004598e9
> > RDX: 00000000200002c9 RSI: 0000000020000280 RDI: 0000000000000004
> > RBP: 000000000075bf20 R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000246 R12: 00007fc613f936d4
> > R13: 00000000004c6d1a R14: 00000000004dc0c0 R15: 00000000ffffffff
> > Modules linked in:
> > ---[ end trace b440da0257bb7015 ]---
> > RIP: 0010:usercopy_abort+0xb9/0xbb mm/usercopy.c:98
> > Code: e8 62 f0 d6 ff 49 89 d9 4d 89 e8 4c 89 e1 41 56 48 89 ee 48 c7 c7 c0
> > f7 cd 85 ff 74 24 08 41 57 48 8b 54 24 20 e8 c6 91 c1 ff <0f> 0b e8 36 f0
> > d6 ff e8 a1 90 fd ff 8b 54 24 04 49 89 d8 4c 89 e1
> > RSP: 0018:ffff8881d308fc40 EFLAGS: 00010282
> > RAX: 0000000000000060 RBX: ffffffff85cdf4e0 RCX: 0000000000000000
> > RDX: 0000000000000000 RSI: ffffffff81288ddd RDI: ffffed103a611f7a
> > RBP: ffffffff85cdf6a0 R08: 0000000000000060 R09: fffffbfff11ad7a3
> > R10: fffffbfff11ad7a2 R11: ffffffff88d6bd17 R12: ffffffff85cdf8c0
> > R13: ffffffff85cdf4e0 R14: 00000000200002c9 R15: ffffffff85cdf4e0
> > FS:  00007fc613f93700(0000) GS:ffff8881db300000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007f983cbbf000 CR3: 00000001cc33e000 CR4: 00000000001406e0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> >
> >
> > ---
> > This bug is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> > syzbot will keep track of this bug report. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> Need to wait until all HID fixes are upstream, before we can actually
> tell if this is a new issue or not. Duping to the Logitech bug for
> now.
> 
> #syz dup: general protection fault in __pm_runtime_resume

Different bug (and driver). 

#syz dup: KASAN: slab-out-of-bounds Read in ld_usb_read (3)
