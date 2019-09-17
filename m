Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F6C6C4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 11:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 757B0214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 11:58:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Sk5LOn4t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbfIQL6w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 07:58:52 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46094 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfIQL6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 07:58:52 -0400
Received: by mail-pg1-f196.google.com with SMTP id a3so1884786pgm.13
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 04:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9+3/vjaV0IWTxBoNe94DezuOhB6FcrK/HEtk3iyE7N0=;
        b=Sk5LOn4tPNUQTCYrLnF9Zwie2r98LDzj+cOTTsmD5iwDYicXunnON8V6/Lf0wB1x7U
         ekQJEjwb7XL4AlLAn1z+meS/nWZE0EwxIgU0GDKH0CoiNRavcO603ra2wuLe15C4mPr3
         Q5w+2CrmXCRErL6F95M/1rR6G/zttfeBl4BkJXFi4ncg2T//aiAKIO3GXbQeS8gEIy2H
         FfqyFHOvNR30fICmWcaznBKiE9lUbr0xnW7udTovETVztTeIltjTwCS9ZD5Bibb9mwuQ
         qDMjrw8IZcwUUl8XFWUne5K9HEVB9bjvEMPg8zRf3BLnGDNfQ2CXTODdtNnWQWumgUBq
         POsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9+3/vjaV0IWTxBoNe94DezuOhB6FcrK/HEtk3iyE7N0=;
        b=OQvFLzIVY406DSrP88enuSxFZKFseaK8Mv1GrEa8Z7zZ0vFAHcg68X2rU1sAC83xM8
         fH4uwLFOuq0JX//R2Iz+LfCSIXRDfuG6+wYjUB87tVKKY2Ov4FlnqBFZlQu72mO6nQDc
         +R79nRdPA9rdBnLoiuTeWyaDi8ZCx7fUEziJgM+faz1x1T8c7nAqJOC8tXVPuXt/byEn
         zFF2h2PX7Yyakf8c+j9GpCp+kAE8BM5oh9V1VDHR3pO7HJckJQ6qkobfvV3dQz/4C2Gm
         Sq47WsjBDNdNH+qd55Ndl82XQdBWMEuHIzv3KeIhU2O6RmH2iGn+aMkQBvY2sIa6v3mo
         /6cA==
X-Gm-Message-State: APjAAAU2cTm9Q1x7G7KqsQR6oTrSF0pPloMfvRfBKRFLFGqwcIlehlyR
        JqyFAvGWXZPalFI6Sj3LYBgO9gIe1a/ya7dCWfVu6WZeL2uW3Q==
X-Google-Smtp-Source: APXvYqxF3ZfYV0cXjxOZ8tHr0RWrIO+lH6gpMI9XRwlY5xwQOrV1WMoqXmNrUv778OvcHTM4NSIUGCXnFMaCvxcc4nM=
X-Received: by 2002:a17:90a:ff18:: with SMTP id ce24mr4405409pjb.123.1568721531234;
 Tue, 17 Sep 2019 04:58:51 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000d58eb90592add24e@google.com> <20190917080119.3940-1-hdanton@sina.com>
In-Reply-To: <20190917080119.3940-1-hdanton@sina.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 17 Sep 2019 13:58:40 +0200
Message-ID: <CAAeHK+xgZ0=Y32NAjGfGnXpZh=832opkRnmiq2_nZO5dgMNLSw@mail.gmail.com>
Subject: Re: possible deadlock in usb_deregister_dev (2)
To:     Hillf Danton <hdanton@sina.com>
Cc:     syzbot <syzbot+f9549f5ee8a5416f0b95@syzkaller.appspotmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 17, 2019 at 10:01 AM Hillf Danton <hdanton@sina.com> wrote:
>
>
> On Mon, 16 Sep 2019 14:42:06 -0700
> >
> > syzbot has found a reproducer for the following crash on:
> >
> > HEAD commit:    f0df5c1b usb-fuzzer: main usb gadget fuzzer driver
> > git tree:       https://github.com/google/kasan.git usb-fuzzer
> > console output: https://syzkaller.appspot.com/x/log.txt?x=175cdb95600000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=5c6633fa4ed00be5
> > dashboard link: https://syzkaller.appspot.com/bug?extid=f9549f5ee8a5416f0b95
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13961369600000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=139c811d600000
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+f9549f5ee8a5416f0b95@syzkaller.appspotmail.com
> >
> > ======================================================
> > WARNING: possible circular locking dependency detected
> > 5.3.0-rc7+ #0 Not tainted
> > ------------------------------------------------------
> > kworker/0:1/12 is trying to acquire lock:
> > 0000000098630ee4 (minor_rwsem){++++}, at: usb_deregister_dev+0x95/0x230
> > drivers/usb/core/file.c:239
> >
> > but task is already holding lock:
> > 00000000d9ad5b6f (open_disc_mutex){+.+.}, at: tower_disconnect+0x45/0x300
> > drivers/usb/misc/legousbtower.c:945
> >
> > which lock already depends on the new lock.
> >
> >
> > the existing dependency chain (in reverse order) is:
> >
> > -> #1 (open_disc_mutex){+.+.}:
> >         __mutex_lock_common kernel/locking/mutex.c:930 [inline]
> >         __mutex_lock+0x158/0x1360 kernel/locking/mutex.c:1077
> >         tower_open+0xce/0x9b0 drivers/usb/misc/legousbtower.c:335
> >         usb_open+0x1df/0x270 drivers/usb/core/file.c:48
> >         chrdev_open+0x219/0x5c0 fs/char_dev.c:414
> >         do_dentry_open+0x494/0x1120 fs/open.c:797
> >         do_last fs/namei.c:3416 [inline]
> >         path_openat+0x1430/0x3f50 fs/namei.c:3533
> >         do_filp_open+0x1a1/0x280 fs/namei.c:3563
> >         do_sys_open+0x3c0/0x580 fs/open.c:1089
> >         do_syscall_64+0xb7/0x580 arch/x86/entry/common.c:296
> >         entry_SYSCALL_64_after_hwframe+0x49/0xbe
> >
> > -> #0 (minor_rwsem){++++}:
> >         check_prev_add kernel/locking/lockdep.c:2405 [inline]
> >         check_prevs_add kernel/locking/lockdep.c:2507 [inline]
> >         validate_chain kernel/locking/lockdep.c:2897 [inline]
> >         __lock_acquire+0x1f7c/0x3b50 kernel/locking/lockdep.c:3880
> >         lock_acquire+0x127/0x320 kernel/locking/lockdep.c:4412
> >         down_write+0x92/0x150 kernel/locking/rwsem.c:1500
> >         usb_deregister_dev+0x95/0x230 drivers/usb/core/file.c:239
> >         tower_disconnect+0xa8/0x300 drivers/usb/misc/legousbtower.c:951
> >         usb_unbind_interface+0x1bd/0x8a0 drivers/usb/core/driver.c:423
> >         __device_release_driver drivers/base/dd.c:1134 [inline]
> >         device_release_driver_internal+0x42f/0x500 drivers/base/dd.c:1165
> >         bus_remove_device+0x2dc/0x4a0 drivers/base/bus.c:556
> >         device_del+0x420/0xb10 drivers/base/core.c:2339
> >         usb_disable_device+0x211/0x690 drivers/usb/core/message.c:1237
> >         usb_disconnect+0x284/0x8d0 drivers/usb/core/hub.c:2199
> >         hub_port_connect drivers/usb/core/hub.c:4949 [inline]
> >         hub_port_connect_change drivers/usb/core/hub.c:5213 [inline]
> >         port_event drivers/usb/core/hub.c:5359 [inline]
> >         hub_event+0x1454/0x3640 drivers/usb/core/hub.c:5441
> >         process_one_work+0x92b/0x1530 kernel/workqueue.c:2269
> >         worker_thread+0x96/0xe20 kernel/workqueue.c:2415
> >         kthread+0x318/0x420 kernel/kthread.c:255
> >         ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
> >
> > other info that might help us debug this:
> >
> >   Possible unsafe locking scenario:
> >
> >         CPU0                    CPU1
> >         ----                    ----
> >    lock(open_disc_mutex);
> >                                 lock(minor_rwsem);
> >                                 lock(open_disc_mutex);
> >    lock(minor_rwsem);
> >
> >   *** DEADLOCK ***
>
> Fix 78663ecc344b

Hi Hillf,

Thanks for looking at these bugs. This bug has a reproducer, so you
can ask syzbot to test the fix by issuing a syz test command as
described here:

https://github.com/google/syzkaller/blob/master/docs/syzbot.md#usb-bugs

Thanks!

>
> --- a/drivers/usb/misc/legousbtower.c
> +++ b/drivers/usb/misc/legousbtower.c
> @@ -941,17 +941,31 @@ static void tower_disconnect (struct usb
>         struct lego_usb_tower *dev;
>         int minor;
>
> -       dev = usb_get_intfdata (interface);
>         mutex_lock(&open_disc_mutex);
> +       dev = usb_get_intfdata (interface);
>         usb_set_intfdata (interface, NULL);
>
>         minor = dev->minor;
>
> -       /* give back our minor */
> -       usb_deregister_dev (interface, &tower_class);
> -
>         mutex_lock(&dev->lock);
>         mutex_unlock(&open_disc_mutex);
> +       /*
> +        * give back our minor out of open_disc_mutex to shun deadlock like
> +
> +               Possible unsafe locking scenario:
> +
> +               CPU0                    CPU1
> +               ----                    ----
> +               disconnect path         open path
> +
> +               lock(open_disc_mutex);
> +                                       lock(minor_rwsem);
> +                                       lock(open_disc_mutex);
> +               lock(minor_rwsem);
> +
> +        * and we can do this since intfdata is reset with lock held.
> +        */
> +       usb_deregister_dev (interface, &tower_class);
>
>         /* if the device is not opened, then we clean up right now */
>         if (!dev->open_count) {
>
