Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECBF6C41514
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 08:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3939229ED
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 08:25:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YVfKR2ER"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbfGXIZg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 04:25:36 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:42818 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbfGXIZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 04:25:33 -0400
Received: by mail-io1-f66.google.com with SMTP id e20so57415946iob.9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 01:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rthB7TuLsrrexVORz8jX/4Y6bSbkbA/CLCm06dzoX3Q=;
        b=YVfKR2ERODUww+Ppa6Ui+D9VCr6s4Ik4GFYDy9CFHAScAT3PzbFHqh6SScM2k7blFY
         qIQGgTQBVZnL/o++BflPx1V0xSWmLSnIVuVs6keND0wK1OJpMtQZ6lFVbgzXOKvBO3ZR
         hUz03IWbyQgttxi4Y3xBES73lVMq1S/JgqHPAeomYOcjyBepdhBuLr38pJfQZLVcYBcL
         Q56VvhbWXS6rU1/uPYUA5qDdln3I8rnpA3Qe7uuk7N8sLai12tJMITxKJn+zq+k3s5PZ
         R7AuqwZifzsQJRbSubOMiNSTCM3Ao93Bbzyk3HOVHZ3VknMMDnfVBNzofk3NuWEF2BRE
         CD5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rthB7TuLsrrexVORz8jX/4Y6bSbkbA/CLCm06dzoX3Q=;
        b=mpTLPDEwol4l1dvCCBUNzYODcDbglaq6o+XzuurNAur9siveQkqcPHcAL76U+purDl
         c8gmGxvdSiS2eIpUO9vN1KabKsEj8T0oCYO1qgkng8LZTCQ3zrJEkt6AQO8wYeseCpih
         J6AyxzcUgPstqqhdWdyIRhWTQVplalq8sQeDKwHaLzwMxNwAxNQY8vkQh9jbF2o7BymZ
         wD5q95uorf8rFyt93bYlKD6p7OKDDIx4gxWb+ZJor7ovbiri5pgQIug6GBnOEzMZqgJE
         ed3fFZcZGYZanLhAv8QEVffZQybZSLZ5L9lugXTf0bE1kU0LLYvSriJ5RoqjbT1GpxHK
         OLQA==
X-Gm-Message-State: APjAAAVQVRjAq57B5fwjCGgwkceg3/kJ1xICV34VR3lcIXMuS/tRFR+X
        B9lShDodCaiHVKIYJBzErJKEfFnRmETH9Tb0AnpbIg==
X-Google-Smtp-Source: APXvYqz+ofRXz1OnoH0hWv3X77gZsDjqYbcnA8dpRve1lPmDLdB7KDa+1wUPQZxxs2yEi/Oq616FDj32EerPEwY/ipY=
X-Received: by 2002:a5e:c241:: with SMTP id w1mr70815812iop.58.1563956732813;
 Wed, 24 Jul 2019 01:25:32 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000edcb3c058e6143d5@google.com>
In-Reply-To: <000000000000edcb3c058e6143d5@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 24 Jul 2019 10:25:21 +0200
Message-ID: <CACT4Y+a=phN5-2DCAAEZYit01HoSsfWTyw5CHCtjbPtQ20e4Xg@mail.gmail.com>
Subject: Re: memory leak in kobject_set_name_vargs (2)
To:     Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        David Miller <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        netdev <netdev@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        syzbot <syzbot+ad8ca40ecd77896d51e2@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 1:08 AM syzbot
<syzbot+ad8ca40ecd77896d51e2@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    3bfe1fc4 Merge tag 'for-5.3/dm-changes-2' of git://git.ker..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=130322afa00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=dcfc65ee492509c6
> dashboard link: https://syzkaller.appspot.com/bug?extid=ad8ca40ecd77896d51e2
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=135cbed0600000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14dd4e34600000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+ad8ca40ecd77896d51e2@syzkaller.appspotmail.com

+net/ipv6/ip6_vti.c maintainers

> BUG: memory leak
> unreferenced object 0xffff88810cc5d860 (size 32):
>    comm "syz-executor938", pid 7153, jiffies 4294945400 (age 8.020s)
>    hex dump (first 32 bytes):
>      69 70 36 5f 76 74 69 31 00 2f 37 31 35 33 00 00  ip6_vti1./7153..
>      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>    backtrace:
>      [<000000000800471f>] kmemleak_alloc_recursive
> /./include/linux/kmemleak.h:43 [inline]
>      [<000000000800471f>] slab_post_alloc_hook /mm/slab.h:522 [inline]
>      [<000000000800471f>] slab_alloc /mm/slab.c:3319 [inline]
>      [<000000000800471f>] __do_kmalloc /mm/slab.c:3653 [inline]
>      [<000000000800471f>] __kmalloc_track_caller+0x165/0x300 /mm/slab.c:3670
>      [<000000007a2eef8e>] kstrdup+0x3a/0x70 /mm/util.c:53
>      [<00000000a309e483>] kstrdup_const+0x48/0x60 /mm/util.c:75
>      [<00000000cf8dc39b>] kvasprintf_const+0x7e/0xe0 /lib/kasprintf.c:48
>      [<000000005a964730>] kobject_set_name_vargs+0x40/0xe0 /lib/kobject.c:289
>      [<00000000e2a9ccdf>] dev_set_name+0x63/0x90 /drivers/base/core.c:1915
>      [<000000007bc7b1da>] netdev_register_kobject+0x5a/0x1b0
> /net/core/net-sysfs.c:1727
>      [<00000000637b4645>] register_netdevice+0x397/0x600 /net/core/dev.c:8723
>      [<0000000038b21fdc>] vti6_tnl_create2+0x47/0xb0 /net/ipv6/ip6_vti.c:189
>      [<0000000023231475>] vti6_tnl_create /net/ipv6/ip6_vti.c:229 [inline]
>      [<0000000023231475>] vti6_locate /net/ipv6/ip6_vti.c:277 [inline]
>      [<0000000023231475>] vti6_locate+0x244/0x2c0 /net/ipv6/ip6_vti.c:255
>      [<000000006ebf0a44>] vti6_ioctl+0x17f/0x390 /net/ipv6/ip6_vti.c:802
>      [<00000000077406fa>] dev_ifsioc+0x324/0x460 /net/core/dev_ioctl.c:322
>      [<00000000465d817c>] dev_ioctl+0x157/0x45e /net/core/dev_ioctl.c:514
>      [<00000000e2472af6>] sock_ioctl+0x394/0x480 /net/socket.c:1099
>      [<0000000024234c3b>] vfs_ioctl /fs/ioctl.c:46 [inline]
>      [<0000000024234c3b>] file_ioctl /fs/ioctl.c:509 [inline]
>      [<0000000024234c3b>] do_vfs_ioctl+0x62a/0x810 /fs/ioctl.c:696
>      [<0000000015b52ca4>] ksys_ioctl+0x86/0xb0 /fs/ioctl.c:713
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
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/000000000000edcb3c058e6143d5%40google.com.
