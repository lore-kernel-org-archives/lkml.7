Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 812C3C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 14:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A4D72464B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 14:24:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n8KiQmLA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729932AbfLKOYI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 09:24:08 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34309 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729671AbfLKOYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 09:24:06 -0500
Received: by mail-pg1-f195.google.com with SMTP id r11so10865732pgf.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 06:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8KnatWRJvggnUcJXHtww4qB6FhD522LG/aumBjl9qUs=;
        b=n8KiQmLAc8ZK5BVSQV+k0zHdgmk5QcojzmqCuPP/G5EqqLmvGvd/31aA+vmLC/jxZS
         D9actdnYEsJTGtzyAfpwFJ+EO7OzKmTNsuYhUUA2Sf0aDwNEXRIPCKDHdEL8nYaGDa3W
         /HE6WWnq5KaY8J5umcqmXMhwV3cL8LV/BnQfGYW4jLPSSpKwMKD+HTht8w0ritIwvQln
         eT8p9O4f7MbrVxn/QaAa7EdIbzuNyCe4DDWYEtIlH0HUO8AbgYcdpLebuxmyAG3J1Ep8
         TKAvqkqCy5IG5X3069ZSxgRaOfGYuDc3qiVHKmOccCrWRq/CbYIMEJVQ2W2avARRdHnU
         RBFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8KnatWRJvggnUcJXHtww4qB6FhD522LG/aumBjl9qUs=;
        b=gAjmgIZ14DlSk6aGHrRIhPeZ1FOMWbgG8ooYTPD0DaIQ4lxTPhF4eOJoW1vv8PoAOO
         O7cpKiyDj6CkFc1Rqb7WP/XC800hrzIinr1iO6WvNVk5fG/NTejNeG2Kg0GhxLZBeBkh
         Zf1mrtzp7g595/Z1eHoHY4dSYDOUwY9prS9Hrlu14GeiMixt4+v3PGVCKoHSnaZmxwP9
         6tSp3uwHPnpXAmXISV85238qBwIcOypDa75MHqaJF8Fpx+Su23Rhdbr7uO8zDJUNfBIQ
         6SpUu8Go7kpX+5PXYjoDDTHscOIsWangjpb+IBxDfZ4hmaj4phvCBUprblAAgR08TR6d
         XUrw==
X-Gm-Message-State: APjAAAWYbhk5BE16K0WX3elRDEUNTM8cOIua9UbhfXK1u/x4yArcJPw9
        VQTd8xVUiQlDsyvUa9HxvsenUNYJtPe09+uNDK4SSQ==
X-Google-Smtp-Source: APXvYqwojB6kioMBHsLADT9ILNBxNH7/MTlgZ1GSprzRXFq+DanmmA7iuwQxb1WHEBhmTIgofpA1k5SqXdkf60aysjo=
X-Received: by 2002:a63:c804:: with SMTP id z4mr4450211pgg.440.1576074244845;
 Wed, 11 Dec 2019 06:24:04 -0800 (PST)
MIME-Version: 1.0
References: <00000000000031a0af05995eca0b@google.com> <Pine.LNX.4.44L0.1912101513580.1647-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1912101513580.1647-100000@iolanthe.rowland.org>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Wed, 11 Dec 2019 15:23:53 +0100
Message-ID: <CAAeHK+wFBYX8-L-D8w_nep3W=QjYoLAZbc=-0eoWK684wnuayA@mail.gmail.com>
Subject: Re: Re: KASAN: use-after-free Read in usbvision_v4l2_open
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     syzbot <syzbot+7fa38a608b1075dfd634@syzkaller.appspotmail.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        linux-media@vger.kernel.org, USB list <linux-usb@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Richard Fontana <rfontana@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2019 at 9:17 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Tue, 10 Dec 2019, syzbot wrote:
>
> > > On Mon, 9 Dec 2019, syzbot wrote:
> >
> > >> Hello,
> >
> > >> syzbot found the following crash on:
> >
> > >> HEAD commit:    1f22d15c usb: gadget: add raw-gadget interface
> > >> git tree:       https://github.com/google/kasan.git usb-fuzzer
> > >> console output: https://syzkaller.appspot.com/x/log.txt?x=1296f42ae00000
> > >> kernel config:
> > >> https://syzkaller.appspot.com/x/.config?x=8ccee2968018adcb
> > >> dashboard link:
> > >> https://syzkaller.appspot.com/bug?extid=c7b0ec009a216143df30
> > >> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> >
> > >> Unfortunately, I don't have any reproducer for this crash yet.
> >
> > >> IMPORTANT: if you fix the bug, please add the following tag to the
> > >> commit:
> > >> Reported-by: syzbot+c7b0ec009a216143df30@syzkaller.appspotmail.com
> >
> > >> ==================================================================
> > >> BUG: KASAN: use-after-free in __mutex_lock_common
> > >> kernel/locking/mutex.c:1043 [inline]
> > >> BUG: KASAN: use-after-free in __mutex_lock+0x124d/0x1360
> > >> kernel/locking/mutex.c:1106
> > >> Read of size 8 at addr ffff8881cad4d8b8 by task v4l_id/4526
> >
> > >> CPU: 0 PID: 4526 Comm: v4l_id Not tainted 5.4.0-syzkaller #0
> > >> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> > >> Google 01/01/2011
> > >> Call Trace:
> > >>    __dump_stack lib/dump_stack.c:77 [inline]
> > >>    dump_stack+0xef/0x16e lib/dump_stack.c:118
> > >>    print_address_description.constprop.0+0x36/0x50 mm/kasan/report.c:374
> > >>    __kasan_report.cold+0x1a/0x33 mm/kasan/report.c:506
> > >>    kasan_report+0xe/0x20 mm/kasan/common.c:638
> > >>    __mutex_lock_common kernel/locking/mutex.c:1043 [inline]
> > >>    __mutex_lock+0x124d/0x1360 kernel/locking/mutex.c:1106
> > >>    usbvision_v4l2_open+0x77/0x340
> > >> drivers/media/usb/usbvision/usbvision-video.c:314
> > >>    v4l2_open+0x20f/0x3d0 drivers/media/v4l2-core/v4l2-dev.c:423
> > >>    chrdev_open+0x219/0x5c0 fs/char_dev.c:414
> > >>    do_dentry_open+0x494/0x1120 fs/open.c:797
> > >>    do_last fs/namei.c:3412 [inline]
> > >>    path_openat+0x142b/0x4030 fs/namei.c:3529
> > >>    do_filp_open+0x1a1/0x280 fs/namei.c:3559
> > >>    do_sys_open+0x3c0/0x580 fs/open.c:1097
> > >>    do_syscall_64+0xb7/0x5b0 arch/x86/entry/common.c:294
> > >>    entry_SYSCALL_64_after_hwframe+0x49/0xbe
> >
> > > This looks like a race in v4l2_open(): The function drops the
> > > videodev_lock mutex before calling the video driver's open routine, and
> > > the device can be unregistered during the short time between.
> >
> > > This patch tries to make the race much more likely to happen, for
> > > testing and verification.
> >
> > > Andrey, will syzbot run the same test with this patch, even though it
> > > says it doesn't have a reproducer?
> >
> > > Alan Stern
> >
> > > #syz test: https://github.com/google/kasan.git 1f22d15c
> >
> > This crash does not have a reproducer. I cannot test it.
>
> Let's try the same patch with a different bug report -- one that has a
> reproducer.  I assume that syzbot gets the bug identity from the
> email's From: line (which has been updated acoordingly) rather than the
> Subject: line.

Did you get a response for this test? I see the test attempt on the
dashboard (the patch failed to build), but I didn't get an email with
the result.

>
> #syz test: https://github.com/google/kasan.git 1f22d15c
>
> Index: usb-devel/drivers/media/usb/usbvision/usbvision-video.c
> ===================================================================
> --- usb-devel.orig/drivers/media/usb/usbvision/usbvision-video.c
> +++ usb-devel/drivers/media/usb/usbvision/usbvision-video.c
> @@ -1585,6 +1585,7 @@ static void usbvision_disconnect(struct
>                 wake_up_interruptible(&usbvision->wait_frame);
>                 wake_up_interruptible(&usbvision->wait_stream);
>         } else {
> +               msleep(100);
>                 usbvision_release(usbvision);
>         }
>
> Index: usb-devel/drivers/media/v4l2-core/v4l2-dev.c
> ===================================================================
> --- usb-devel.orig/drivers/media/v4l2-core/v4l2-dev.c
> +++ usb-devel/drivers/media/v4l2-core/v4l2-dev.c
> @@ -419,9 +419,10 @@ static int v4l2_open(struct inode *inode
>         video_get(vdev);
>         mutex_unlock(&videodev_lock);
>         if (vdev->fops->open) {
> -               if (video_is_registered(vdev))
> +               if (video_is_registered(vdev)) {
> +                       msleep(200);
>                         ret = vdev->fops->open(filp);
> -               else
> +               } else
>                         ret = -ENODEV;
>         }
>
>
