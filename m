Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 844BEC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 09:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F80C20665
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 09:13:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bh7rAcJ+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405593AbfITJN3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 05:13:29 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44890 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391415AbfITJN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 05:13:29 -0400
Received: by mail-qt1-f193.google.com with SMTP id u40so7803056qth.11
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 02:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VlblYw9TvKcNF0r0/4U6mzJHTJUBEAcX9p89G4lUkMM=;
        b=Bh7rAcJ+Z8M9KMVeylsz3VmDTlxHaB+4J1UJzH75O8ctOEE7pvI7o7aGTJx27ANulU
         p67tLmA8zJynklmNRg6wzuesm55ZyhY1xPOOzsOqtK8EtTSOjKmpV/gtDucYg/RJDvdP
         VWx6LZnUVW8BCjLSdUKHVFgzfb+56ORYKPQiWMc+g1MHcO2jVCSMFWuE6yaX0f63pOSw
         zvpqn7iHJtTa1SClJbkV9vgRWmShinm3+jiii5PBAZo/vVf0JfBwzYpkBiyV60jVA6JS
         auV5oyOLd31/JN/LdqLA6e3ud17fk1+C0jr+WRW7FySVEemqoMKIm/Xe0mMfg2S3VB2c
         Sd/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VlblYw9TvKcNF0r0/4U6mzJHTJUBEAcX9p89G4lUkMM=;
        b=VS1VoIcHXf80maivxjVTzJrK7//NI6gAwSh56i1H6G6khWNABUaa9i+B1tKgW418gF
         O0z8Fftv8dx1n/I3hMoiScbJyL4ht6riq3P6oi5bqd/G9FYJAh8jU7fJrt1+qGT3VHFZ
         j/i+zslOw2Eye8HnOKS/xjlChJyVW+JhDUi/YCy0MRYaLFCfgkl1RKc1X/PxvDITHGVI
         vbztIlQEMOVVY46Fo/XZjzC006ak9BJXXGb6Ze2nAjpsbR/uAKsexS3QUWF7m9X7buXt
         U5oTd1Itz5n7YaEP+IWrzveML5wzMxDDKk7qbCBVs5n8LKw5r5I7VJ08ttG4fi6FWJxI
         r72g==
X-Gm-Message-State: APjAAAVIRabvZhdzFerxZgjZ+16nEzCApU+bhP6CSZPZ8W20pnph0eW/
        qIl5GHkcAbT4XpxZOIbWxVKk1KssPUNKj7t1gs/NZg==
X-Google-Smtp-Source: APXvYqznVzhQy/Ch1GCHLQCgO3zRcYq+M3+/6Epf0aN0IiVeQKkuBw0n4Oj+NkjQca5yuIyFu5gxNYJSw33yFfMIhHA=
X-Received: by 2002:ac8:4a8d:: with SMTP id l13mr2205266qtq.158.1568970807239;
 Fri, 20 Sep 2019 02:13:27 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000d12d24058f5d6b65@google.com> <000000000000a12822058fb4f408@google.com>
 <20190920090803.GM30545@localhost>
In-Reply-To: <20190920090803.GM30545@localhost>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 20 Sep 2019 11:13:14 +0200
Message-ID: <CACT4Y+Yg5wTsMUGRmTwexKUMzi1ZxrH3k3yaMaJvLaEp7qnjSw@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in adu_disconnect
To:     Johan Hovold <johan@kernel.org>
Cc:     syzbot <syzbot+0243cb250a51eeefb8cc@syzkaller.appspotmail.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        dmg@turingmachine.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2019 at 11:08 AM Johan Hovold <johan@kernel.org> wrote:
>
> On Fri, Aug 09, 2019 at 01:24:04PM -0700, syzbot wrote:
> > syzbot has found a reproducer for the following crash on:
> >
> > HEAD commit:    e96407b4 usb-fuzzer: main usb gadget fuzzer driver
> > git tree:       https://github.com/google/kasan.git usb-fuzzer
> > console output: https://syzkaller.appspot.com/x/log.txt?x=13871a4a600000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=cfa2c18fb6a8068e
> > dashboard link: https://syzkaller.appspot.com/bug?extid=0243cb250a51eeefb8cc
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11c4c8e2600000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11d80d2c600000
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+0243cb250a51eeefb8cc@syzkaller.appspotmail.com
> >
> > usb 1-1: USB disconnect, device number 4
> > ==================================================================
> > BUG: KASAN: use-after-free in atomic64_read
> > include/asm-generic/atomic-instrumented.h:836 [inline]
> > BUG: KASAN: use-after-free in atomic_long_read
> > include/asm-generic/atomic-long.h:28 [inline]
> > BUG: KASAN: use-after-free in __mutex_unlock_slowpath+0x96/0x670
> > kernel/locking/mutex.c:1211
> > Read of size 8 at addr ffff8881d1d0aa00 by task kworker/0:1/12
>
> Let's resend and retest with commit id from latest report to make sure
> the patch was actually applied during the last run:

The reply contains:
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1440268d600000
that's what's being parsed and applied during testing.


> #syz test: https://github.com/google/kasan.git e96407b4
>
> Johan
>
>
> From 6f09430ae18085a1552fc641e53d3a3e678db6f3 Mon Sep 17 00:00:00 2001
> From: Johan Hovold <johan@kernel.org>
> Date: Thu, 19 Sep 2019 11:48:38 +0200
> Subject: [PATCH] USB: adutux: fix use-after-free on disconnect
>
> The driver was clearing its struct usb_device pointer, which it uses as
> an inverted disconnected flag, before deregistering the character device
> and without serialising against racing release().
>
> This could lead to a use-after-free if a racing release() callback
> observes the cleared pointer and frees the driver data before
> disconnect() is finished with it.
>
> This could also lead to NULL-pointer dereferences in a racing open().
>
> Fixes: f08812d5eb8f ("USB: FIx locks and urb->status in adutux (updated)")
> Reported-by: syzbot+0243cb250a51eeefb8cc@syzkaller.appspotmail.com
> Cc: stable <stable@vger.kernel.org>     # 2.6.24
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>
>  drivers/usb/misc/adutux.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/usb/misc/adutux.c b/drivers/usb/misc/adutux.c
> index 344d523b0502..bcc138990e2f 100644
> --- a/drivers/usb/misc/adutux.c
> +++ b/drivers/usb/misc/adutux.c
> @@ -762,14 +762,15 @@ static void adu_disconnect(struct usb_interface *interface)
>
>         dev = usb_get_intfdata(interface);
>
> -       mutex_lock(&dev->mtx);  /* not interruptible */
> -       dev->udev = NULL;       /* poison */
>         usb_deregister_dev(interface, &adu_class);
> -       mutex_unlock(&dev->mtx);
>
>         mutex_lock(&adutux_mutex);
>         usb_set_intfdata(interface, NULL);
>
> +       mutex_lock(&dev->mtx);  /* not interruptible */
> +       dev->udev = NULL;       /* poison */
> +       mutex_unlock(&dev->mtx);
> +
>         /* if the device is not opened, then we clean up right now */
>         if (!dev->open_count)
>                 adu_delete(dev);
> --
> 2.23.0
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/20190920090803.GM30545%40localhost.
