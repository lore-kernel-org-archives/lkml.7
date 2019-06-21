Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A04C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 17:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE3962070B
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 17:57:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ifzEym2r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbfFUR5T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 13:57:19 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34919 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbfFUR5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 13:57:19 -0400
Received: by mail-lj1-f195.google.com with SMTP id x25so6746670ljh.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 10:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KDhlKJiGaVj++G8gqDMBvH/QxdSMWIztjFlMRVLweWA=;
        b=ifzEym2rY24UWUo4k/GaFS21AZQZjEz7Eekh8v3/3ZKmxkCBUS01HoEzK4XgS3SDEz
         KGSNw8FlRCyHxtk5NT6V+XPxNlGDJbQDjQPD7b9pMg3Ya10LtINbkzGBjDaNIx4JFtrk
         lr4wtApsvOhCIbO6DqVTa6YCkKTOdUEfUoST6YuRBjpw4aUtBfi/moX1OstYe9Bp/vJ1
         ykV7z4l5DD1KRfWw6+NM5vlhCzLypqLv2EBdJxyq6H79y/YwVUtnRQO/g3ROzDv/z5Eh
         4pi9//q/pHdRaad/GmpAvyZ0KIXkD0oujMyIXKcH0prENWjqDQROnCoYRxRhtO6vAyH0
         CFGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KDhlKJiGaVj++G8gqDMBvH/QxdSMWIztjFlMRVLweWA=;
        b=jOUfqAUjtw0C5iRi22fNs92ZMYKe8xrmQkSLRQ3iJoXdmebmR1xD1imCtxX6K6Mow1
         PgU3MkducoQ0Q9ZfNjLdqvrGMQ2Jb9nko/+LlPRt0NvEyy5oQuHjllMk4VRA77DxNj/F
         kNJqNdIltlbgAimLyW1I4cJvC0Ti9lpa+RrJTjcZEW1YAbTxQQzfdmQgBAl2FfcRfsog
         otGRwdffqojy2c23L1F2HmOlmRZVpcxSuPhK7yhuJSEMdfKSgf6gJkju7V0q7r93liVy
         So58au2eB5WPoPAhTZ72g7gPYiJkx0xbOkT62C233M8HXVxJW/cMn7F+I8GQXAAf+gja
         giUw==
X-Gm-Message-State: APjAAAX5Z77u8ljNxY/mc/wsqDEs0hBoEoZd6sYGR46zzTd0yQETV1Px
        9nISwfU3EhRkZMV9cdZeH3ZOPb4Zu1cuXbHLlMiVUg==
X-Google-Smtp-Source: APXvYqyvj6pAiJquwNnSvuvotAmnzfzsdgO3ROk5Ckam5CgS9lRzWIUGh+GGAxEqYmGqn2j3ZM+RjMt6YtwUJmislKw=
X-Received: by 2002:a2e:9a87:: with SMTP id p7mr25110501lji.133.1561139836177;
 Fri, 21 Jun 2019 10:57:16 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000bb6d57058b3b98eb@google.com>
In-Reply-To: <000000000000bb6d57058b3b98eb@google.com>
From:   Todd Kjos <tkjos@google.com>
Date:   Fri, 21 Jun 2019 10:57:04 -0700
Message-ID: <CAHRSSEy34c=jN--pm+hp3DeMw2Q2465TohCdSoL-XoKc-wXc0A@mail.gmail.com>
Subject: Re: memory leak in binder_transaction
To:     syzbot <syzbot+182ce46596c3f2e1eb24@syzkaller.appspotmail.com>
Cc:     =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Christian Brauner <christian@brauner.io>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Martijn Coenen <maco@android.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Todd Kjos <tkjos@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 2:56 PM syzbot
<syzbot+182ce46596c3f2e1eb24@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    d1fdb6d8 Linux 5.2-rc4
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=15e5ce1ea00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=cb38d33cd06d8d48
> dashboard link: https://syzkaller.appspot.com/bug?extid=182ce46596c3f2e1eb24
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1181703ea00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14e14392a00000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+182ce46596c3f2e1eb24@syzkaller.appspotmail.com
>
> -executor774" scontext=unconfined_u:system_r:insmod_t:s0-s0:c0.c1023
> tcontext=unconfined_u:system_r:insmod_t:s0-s0:c0.c1023 tclass=binder
> permissive=1
> BUG: memory leak

Fix sent: https://lore.kernel.org/patchwork/patch/1092398/

>
> unreferenced object 0xffff888123934800 (size 32):
>    comm "syz-executor774", pid 7083, jiffies 4294941834 (age 7.970s)
>    hex dump (first 32 bytes):
>      00 48 93 23 81 88 ff ff 00 48 93 23 81 88 ff ff  .H.#.....H.#....
>      02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>    backtrace:
>      [<0000000038ba7202>] kmemleak_alloc_recursive
> include/linux/kmemleak.h:43 [inline]
>      [<0000000038ba7202>] slab_post_alloc_hook mm/slab.h:439 [inline]
>      [<0000000038ba7202>] slab_alloc mm/slab.c:3326 [inline]
>      [<0000000038ba7202>] kmem_cache_alloc_trace+0x13d/0x280 mm/slab.c:3553
>      [<0000000004e63839>] kmalloc include/linux/slab.h:547 [inline]
>      [<0000000004e63839>] kzalloc include/linux/slab.h:742 [inline]
>      [<0000000004e63839>] binder_transaction+0x28b/0x2eb0
> drivers/android/binder.c:3072
>      [<0000000050997ec4>] binder_thread_write+0x357/0x1430
> drivers/android/binder.c:3794
>      [<00000000ab2de227>] binder_ioctl_write_read
> drivers/android/binder.c:4827 [inline]
>      [<00000000ab2de227>] binder_ioctl+0x8bc/0xbb4
> drivers/android/binder.c:5004
>      [<000000002eec2b63>] vfs_ioctl fs/ioctl.c:46 [inline]
>      [<000000002eec2b63>] file_ioctl fs/ioctl.c:509 [inline]
>      [<000000002eec2b63>] do_vfs_ioctl+0x62a/0x810 fs/ioctl.c:696
>      [<0000000048cfc9e6>] ksys_ioctl+0x86/0xb0 fs/ioctl.c:713
>      [<0000000030bf392d>] __do_sys_ioctl fs/ioctl.c:720 [inline]
>      [<0000000030bf392d>] __se_sys_ioctl fs/ioctl.c:718 [inline]
>      [<0000000030bf392d>] __x64_sys_ioctl+0x1e/0x30 fs/ioctl.c:718
>      [<000000007dec438c>] do_syscall_64+0x76/0x1a0
> arch/x86/entry/common.c:301
>      [<00000000ae043c96>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
>
>
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> syzbot can test patches for this bug, for details see:
> https://goo.gl/tpsmEJ#testing-patches
