Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6667DC10F00
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 09:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3472E20866
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 09:38:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YdSHnZco"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726035AbfCCJih (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 04:38:37 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:35015 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbfCCJig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 04:38:36 -0500
Received: by mail-it1-f196.google.com with SMTP id 188so3338926itb.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2019 01:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Un0vf29LMkEfpXBA4SObsU1TOfaMdoff5ox9TFR/hYA=;
        b=YdSHnZcokQsDZR+YYtY30S8ngEiddj+30Rp+74kCsP9+WdIj4foRi50581EqVjnpgD
         1J3CyXkTWUo9jio14s7nTvTrmf8NrrKyUwIdMjxVGvHX5jtS2B6t2e0xy7VIvCp0su5V
         0NU73bPmACaZS1/2GW3BiXYz3UnIMIJqVA5Kka5cVzKXBjGxmscOFfWkALdPFz9uxdUM
         VthXpTh30b2lHmbMfF/afhabOR7EdM0KW6j7vJNybclBMm2s+U5XBrtxmZHzbDNOo/wq
         F4aYlUoyM1ImrhvKntOD5jpJ1/zpJlawOZ5JO3TKVOBROF6wV+V1VMkx/P7LUfV5w8t6
         KNHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Un0vf29LMkEfpXBA4SObsU1TOfaMdoff5ox9TFR/hYA=;
        b=Qa8RALePILKf8Qx6TgOU/Uw5x0JPaPCtg1Ej9cLbtEuTWwVqMiiVfcJRS7I19y+o3d
         Obn7dhjgf2swd89Lrg+0rgNjUxlYgToUv3CTCVg15upDaMxT5den5EIPUzZ/ghKdxGJT
         BkDTilMgggKIw8PT/GV0/4lKDcOfWu9ROemSevHV8A+u25TU8WQMIJD+3jevyv3fvpQy
         O3b26u/htZmgfhnAjp8oEGwAsXOPaklEJumoNRpM/WsSTq5QCnHCm2VGC90egg5YAkfI
         4tVDnOMFYSKW53lsLLaMlQ6YpWjXdk7yXMKaY+QToT87hwYw9o8wI4zSSKfxpcfGlzKk
         eueA==
X-Gm-Message-State: AHQUAuYd6mIepJagfJlNAS9ft3MFzLboqlcztwCCwCIJUgVhHEahTmXC
        iXSJwXrnMPhszqbQZCpINI8eaLGicJwohIHWicJwuA==
X-Google-Smtp-Source: APXvYqwuSd4qVB6W0w1KY+t2ZIU/SGlkU43Mx9B22ee50iyTw+WsrIihVpLij3k1prjYj6DXtSvz48BnZRfH1xlkZ74=
X-Received: by 2002:a24:3b01:: with SMTP id c1mr6939829ita.144.1551605914737;
 Sun, 03 Mar 2019 01:38:34 -0800 (PST)
MIME-Version: 1.0
References: <0000000000009af83005831724a4@google.com> <20190302200543.GA18446@sol.localdomain>
In-Reply-To: <20190302200543.GA18446@sol.localdomain>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sun, 3 Mar 2019 10:38:23 +0100
Message-ID: <CACT4Y+b2Wv18yB5WVQY8R4Jm9B9R_8BAvCJkt_WPACS6ZXqQrw@mail.gmail.com>
Subject: Re: kernel BUG at include/linux/mm.h:LINE! (4)
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     syzbot <syzbot+cc252aa9d2d3b576246f@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 2, 2019 at 9:05 PM Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Fri, Mar 01, 2019 at 11:05:05PM -0800, syzbot wrote:
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    42fd8df9d1d9 Add linux-next specific files for 20190228
> > git tree:       linux-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=16c3cd5cc00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=c0f38652d28b522f
> > dashboard link: https://syzkaller.appspot.com/bug?extid=cc252aa9d2d3b576246f
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> >
> > Unfortunately, I don't have any reproducer for this crash yet.
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+cc252aa9d2d3b576246f@syzkaller.appspotmail.com
> >
> > page dumped because: VM_BUG_ON_PAGE(page_ref_count(page) == 0)
> > page->mem_cgroup:ffff888059786cc0
> > ------------[ cut here ]------------
> > kernel BUG at include/linux/mm.h:579!
> > invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> > CPU: 0 PID: 22405 Comm: syz-executor.3 Not tainted 5.0.0-rc8-next-20190228
> > #45
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> > Google 01/01/2011
> > RIP: 0010:put_page_testzero include/linux/mm.h:579 [inline]
> > RIP: 0010:put_page include/linux/mm.h:1025 [inline]
> > RIP: 0010:generic_pipe_buf_release+0x120/0x160 fs/pipe.c:224
> > Code: bd ff 4c 89 e7 e8 90 43 db ff e8 5b 07 bd ff 5b 41 5c 41 5d 5d c3 e8
> > 4f 07 bd ff 48 c7 c6 60 98 75 87 4c 89 e7 e8 c0 db e4 ff <0f> 0b e8 39 07 bd
> > ff 4d 8d 65 ff e9 3d ff ff ff 48 89 df e8 e8 f8
> > RSP: 0018:ffff888056c57920 EFLAGS: 00010246
> > RAX: 0000000000040000 RBX: ffffea0002283db4 RCX: ffffc9000c456000
> > RDX: 0000000000040000 RSI: ffffffff81984e72 RDI: ffffed100ad8af08
> > RBP: ffff888056c57938 R08: 0000000000000021 R09: ffffed1015d05011
> > R10: ffffed1015d05010 R11: ffff8880ae828087 R12: ffffea0002283d80
> > R13: 0000000000000000 R14: ffff88809ad3c800 R15: ffff8880592ac928
> > FS:  00007fb53aaf2700(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007fff65e0fdb8 CR3: 0000000093a2f000 CR4: 00000000001406f0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >  pipe_buf_release include/linux/pipe_fs_i.h:129 [inline]
> >  iter_file_splice_write+0x7d1/0xbe0 fs/splice.c:759
> >  do_splice_from fs/splice.c:847 [inline]
> >  direct_splice_actor+0x126/0x1a0 fs/splice.c:1019
> >  splice_direct_to_actor+0x369/0x970 fs/splice.c:974
> >  do_splice_direct+0x1da/0x2a0 fs/splice.c:1062
> >  do_sendfile+0x597/0xd00 fs/read_write.c:1442
> >  __do_sys_sendfile64 fs/read_write.c:1503 [inline]
> >  __se_sys_sendfile64 fs/read_write.c:1489 [inline]
> >  __x64_sys_sendfile64+0x1dd/0x220 fs/read_write.c:1489
> >  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
> >  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > RIP: 0033:0x457e29
> > Code: ad b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7
> > 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff
> > 0f 83 7b b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00
> > RSP: 002b:00007fb53aaf1c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
> > RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 0000000000457e29
> > RDX: 0000000000000000 RSI: 0000000000000003 RDI: 0000000000000003
> > RBP: 000000000073bf00 R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000102000000 R11: 0000000000000246 R12: 00007fb53aaf26d4
> > R13: 00000000004c4dce R14: 00000000004d8af8 R15: 00000000ffffffff
> > Modules linked in:
> > ---[ end trace ce17ea3937b628f2 ]---
> > RIP: 0010:put_page_testzero include/linux/mm.h:579 [inline]
> > RIP: 0010:put_page include/linux/mm.h:1025 [inline]
> > RIP: 0010:generic_pipe_buf_release+0x120/0x160 fs/pipe.c:224
> > Code: bd ff 4c 89 e7 e8 90 43 db ff e8 5b 07 bd ff 5b 41 5c 41 5d 5d c3 e8
> > 4f 07 bd ff 48 c7 c6 60 98 75 87 4c 89 e7 e8 c0 db e4 ff <0f> 0b e8 39 07 bd
> > ff 4d 8d 65 ff e9 3d ff ff ff 48 89 df e8 e8 f8
> > RSP: 0018:ffff888056c57920 EFLAGS: 00010246
> > RAX: 0000000000040000 RBX: ffffea0002283db4 RCX: ffffc9000c456000
> > RDX: 0000000000040000 RSI: ffffffff81984e72 RDI: ffffed100ad8af08
> > RBP: ffff888056c57938 R08: 0000000000000021 R09: ffffed1015d05011
> > R10: ffffed1015d05010 R11: ffff8880ae828087 R12: ffffea0002283d80
> > R13: 0000000000000000 R14: ffff88809ad3c800 R15: ffff8880592ac928
> > FS:  00007fb53aaf2700(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 0000001b30225000 CR3: 0000000093a2f000 CR4: 00000000001406e0
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
> > https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with
> > syzbot.
> >
> > --
> > You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/0000000000009af83005831724a4%40google.com.
> > For more options, visit https://groups.google.com/d/optout.
>
> Well it's probably the same as this:
> https://groups.google.com/forum/#!topic/syzkaller-bugs/GTzYqK1FaPI, just
> reported a day too late as it was already fixed in next-20190301 by the change
> folded into "block: introduce mp_bvec_for_each_page() for iterating over page".
>
> #syz invalid
>
> Also Dmitry, I thought that syzbot is only supposed to report bugs on linux-next
> when they have a reproducer?

+syzkaller mailing list for more general discussion of linux-next handling

This special support for linux-next was never implemented.
As of now _all_ bugs without reproducers are moderated manually:
https://github.com/google/syzkaller/blob/master/docs/syzbot.md#moderation-queue
So the result is better then reporting only bugs with reproducers.
Experience with linux-next to date shows that linux-next does not need
any special handling. If anything it seems to be easier to root cause
bugs in linux-next, because they are usually very fresh and there are
usually only one/few commits that touched a particular part of code in
non-trivial way recently. So frequently developers are like "oh, that
must be that commit" without reproducers/bisection/etc.
One of the original concerns with linux-next was that there can be
lots of non-actionable reports if linux-next contains some memory
corruption that is not detected by KASAN. And we indeed had such case
about 1.5 years ago. However, there were no such cases in linux-next
since then. There were few such cases in other trees. And in general
if the corruption is not detected in linux-next and reaches upstream,
then the impact will be no better (actually worse because at that
point it will be harder to root cause and will take much longer to
fix, especially if it will be backported to all trees by then).
So at this point I don't have any plans for any special support for linux-next.
When we have fix bisection, linux-next will probably need some special
support because the tree is rebuilt and old HEADs are abandoned, so
fixed can't be bisected.
