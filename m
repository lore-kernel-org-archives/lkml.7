Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D279ECE587
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 10:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 394BC2084B
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 10:44:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sB3rDE7S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731580AbfJNKoH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 06:44:07 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36432 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731305AbfJNKoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 06:44:06 -0400
Received: by mail-qk1-f196.google.com with SMTP id y189so15448384qkc.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 03:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hZ6xMa94AS5QlI8ci1K/Yz8o4zIwG3w9pkZ7+6EtReM=;
        b=sB3rDE7Swl2hX5dz5I/j7rX6iaUWYtlql5y6kZf1gn6zgUFovOlSnnriP+bxGOD/nM
         dhe0IUzKxAf5ay7lUcV/EDw4tsklCpEKNJKCfYm42HuK/mQuFp0gYIz+WZBTjHsHpjMh
         DDyPeR+fFdSyccAMn2mDcYYIqKhTUVFlhTxSapHDBWspZr9lfunoc0+03EEPlFviBwYP
         BlXCiJOzp0v3jvjzNcDoYpSwunohhzmE5BDgWSyxyG/UMrYSjDDwrZrHdc1HD3cGINZY
         gd8LNMShYyp2UNUBnaQSgdRTDWkf1DRCa+lPZyqKUUa6nAlbIJOkwqqaisy2Owliaws1
         E5sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hZ6xMa94AS5QlI8ci1K/Yz8o4zIwG3w9pkZ7+6EtReM=;
        b=tMg4/wLfZFu5Rog3qiE7BtWEF8jhqpjwt/URz5SrNRGecfGuQQmfAdooyczBwtJ5g2
         gVuTj99GZoWonNrI3j44/t9uyN24mXHtWcTS4MtBoMRxhTdEEnAqQ+DWAhGOPMqcy/zA
         myjLMHFuqKMARwQf2dC1Ryuj2phBDp9K9j6M3z9YTyz98BTCKtGB6uS0pD/9A5+w3xHb
         RuPVhTK2PJ4etV+9lUN2VejE38XFtaKo5IMf8Gwt327jo8qEJ+pkmZ614+p8GYJl/f1o
         2nhzpZl3c45AU03yY5q2+Ta5ijVIok/9NB0ZRiaClJRBUYcXdtm1hIc5BRQPJnAafXw4
         nttQ==
X-Gm-Message-State: APjAAAX3utcrbHpkBRnsaWw+yif57hnSDngiBovD7nelSPF2g/yH+pqX
        nm67alX1ed3ac07VTJFehlZGYh3fKvb3MN48u3VAmQ==
X-Google-Smtp-Source: APXvYqz1j7lTaYwJ0HZz1RrYi2yfP0grb1iw+jimVx49JwQjKeCLRYbQGZkC/3sl/N3pc5VBzK0dW9/OQaxPUjPBIWw=
X-Received: by 2002:a05:620a:2158:: with SMTP id m24mr29467199qkm.250.1571049844763;
 Mon, 14 Oct 2019 03:44:04 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000b2de3a0594d8b4ca@google.com> <20191014091635.GI11828@phenom.ffwll.local>
 <67fb1a91-7ef3-9036-2d1b-877e394bcab2@linux.intel.com>
In-Reply-To: <67fb1a91-7ef3-9036-2d1b-877e394bcab2@linux.intel.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 14 Oct 2019 12:43:53 +0200
Message-ID: <CACT4Y+YYJbTGi4GW5n1qdcUp_5ACyPYGvRLdrp02wXEWrUZ6wg@mail.gmail.com>
Subject: Re: WARNING in drm_mode_createblob_ioctl
To:     syzbot <syzbot+fb77e97ebf0612ee6914@syzkaller.appspotmail.com>
Cc:     David Airlie <airlied@linux.ie>,
        DRI <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, mripard@kernel.org,
        sean@poorly.run, syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2019 at 11:39 AM syzbot
<syzbot+fb77e97ebf0612ee6914@syzkaller.appspotmail.com> wrote:
>
> Op 14-10-2019 om 11:16 schreef Daniel Vetter:
> > On Sun, Oct 13, 2019 at 11:09:09PM -0700, syzbot wrote:
> >> Hello,
> >>
> >> syzbot found the following crash on:
> >>
> >> HEAD commit:    8ada228a Add linux-next specific files for 20191011
> >> git tree:       linux-next
> >> console output: https://syzkaller.appspot.com/x/log.txt?x=1423a87f600000
> >> kernel config:  https://syzkaller.appspot.com/x/.config?x=7cf4eed5fe42c31a
> >> dashboard link: https://syzkaller.appspot.com/bug?extid=fb77e97ebf0612ee6914
> >> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> >>
> >> Unfortunately, I don't have any reproducer for this crash yet.
> > Hm only thing that could go wrong is how we allocate the target for the
> > user_copy, which is an argument directly from the ioctl parameter struct.
> > Does syzbot not track that? We use the standard linux ioctl struct
> > encoding in drm.
> >
> > Otherwise I have no idea why it can't create a reliable reproducer for
> > this ... I'm also not seeing the bug, all the input validation we have
> > seems correct :-/
>
> I would like to see the entire dmesg?
>
> in particular because it's likely WARN(1, "Buffer overflow detected (%d < %lu)!\n", size, count),
>
> so I'd like to see the size it thinks for both..

And who are "you"? :) The email as if comes from syzbot:

From: syzbot <syzbot+fb77e97ebf0612ee6914@syzkaller.appspotmail.com>

But it is clearly not generated by syzbot code. Or is it some kind of
a glitch?...

Anyway, full console output is always referenced on every syzbot bug
report as "console output:" link.



> > -Daniel
> >> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> >> Reported-by: syzbot+fb77e97ebf0612ee6914@syzkaller.appspotmail.com
> >>
> >> ------------[ cut here ]------------
> >> WARNING: CPU: 1 PID: 30449 at include/linux/thread_info.h:150
> >> check_copy_size include/linux/thread_info.h:150 [inline]
> >> WARNING: CPU: 1 PID: 30449 at include/linux/thread_info.h:150 copy_from_user
> >> include/linux/uaccess.h:143 [inline]
> >> WARNING: CPU: 1 PID: 30449 at include/linux/thread_info.h:150
> >> drm_mode_createblob_ioctl+0x398/0x490 drivers/gpu/drm/drm_property.c:800
> >> Kernel panic - not syncing: panic_on_warn set ...
> >> CPU: 1 PID: 30449 Comm: syz-executor.5 Not tainted 5.4.0-rc2-next-20191011
> >> #0
> >> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> >> Google 01/01/2011
> >> Call Trace:
> >>  __dump_stack lib/dump_stack.c:77 [inline]
> >>  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
> >>  panic+0x2e3/0x75c kernel/panic.c:221
> >>  __warn.cold+0x2f/0x35 kernel/panic.c:582
> >>  report_bug+0x289/0x300 lib/bug.c:195
> >>  fixup_bug arch/x86/kernel/traps.c:174 [inline]
> >>  fixup_bug arch/x86/kernel/traps.c:169 [inline]
> >>  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:267
> >>  do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:286
> >>  invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1028
> >> RIP: 0010:check_copy_size include/linux/thread_info.h:150 [inline]
> >> RIP: 0010:copy_from_user include/linux/uaccess.h:143 [inline]
> >> RIP: 0010:drm_mode_createblob_ioctl+0x398/0x490
> >> drivers/gpu/drm/drm_property.c:800
> >> Code: c1 ea 03 80 3c 02 00 0f 85 ed 00 00 00 49 89 5d 00 e8 3c 28 cb fd 4c
> >> 89 f7 e8 64 92 9e 03 31 c0 e9 75 fd ff ff e8 28 28 cb fd <0f> 0b e8 21 28 cb
> >> fd 4d 85 e4 b8 f2 ff ff ff 0f 84 5b fd ff ff 89
> >> RSP: 0018:ffff8880584efaa8 EFLAGS: 00010246
> >> RAX: 0000000000040000 RBX: ffff8880a3a90000 RCX: ffffc900109da000
> >> RDX: 0000000000040000 RSI: ffffffff83a7eaf8 RDI: 0000000000000007
> >> RBP: ffff8880584efae8 R08: ffff888096c40080 R09: ffffed1014752110
> >> R10: ffffed101475210f R11: ffff8880a3a9087f R12: ffffc90014907000
> >> R13: ffff888028aa0000 R14: 000000009a6c7969 R15: ffffc90014907058
> >>
> >>
> >> ---
> >> This bug is generated by a bot. It may contain errors.
> >> See https://goo.gl/tpsmEJ for more information about syzbot.
> >> syzbot engineers can be reached at syzkaller@googlegroups.com.
> >>
> >> syzbot will keep track of this bug report. See:
> >> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/67fb1a91-7ef3-9036-2d1b-877e394bcab2%40linux.intel.com.
