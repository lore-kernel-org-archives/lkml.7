Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F098C4CECD
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 10:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65B02205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 10:06:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s17gJ4lq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438003AbfITKGC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 06:06:02 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34692 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437990AbfITKGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 06:06:02 -0400
Received: by mail-qk1-f193.google.com with SMTP id q203so6752237qke.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 03:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mqz6p6f3gQZREp4wRBwqV1CXY4CFc2wJXeVDbpZwnRo=;
        b=s17gJ4lqim6Yex+7ZbeyBwTOV5zQRVncDPzcNKA7j+xdCMNuqhecn9u5KhYrQe0jpK
         hrVnN1yIG94MWyq8hCLVRuwl8ThIEXpAKCeYcDuGoFeRTSftk50vJC6zaISWg9FROQ4V
         CRukDqnIkzDCMFtjh39sSn6QhsqxjvEfG1yCuBwoEavDPSXM19qNQTIc1NzGhYrlPirb
         uduKHT06dptUz9BPSgkkzXKYLewu2z3AI/nbEUMw3OxxA0kWB0KZwmCA+har+H2CDfIj
         LrCg7kXZzz70Wy9zVFq8wm6yl2Pcvz4pQfoEOqbN/DS+NTtrT6NRkCQ+pWwsNYRdX3ib
         lDEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mqz6p6f3gQZREp4wRBwqV1CXY4CFc2wJXeVDbpZwnRo=;
        b=V7NuXTn/DwvuufaxlTZCUgg2A/sVWofSLKI7BpnwoCWADw167zXbmmPOROtrmB5Mxv
         TgbDxBm15knVvYgUGznaKMGHzq59Ko7CUttlbF1utFSqrAg7gKHw6ItxnktEJamiBuoq
         Ns3JQkxa5WGCLsJnjsQBmxzOSib3qJohyHKDOROaW29lNqxIpQUIXyglfkVNkcnDPAEV
         KXRFLmtXwFpYbCg6pF71DDtEBmkzetPI1/uZILpMH232ycQBkYWkKncsx9yNBuXXfjNh
         ZOqvE8hIThXkCovTGOk/iC/ZxXIRlJUVfnuvZ4XzLPsp00MNdoTxr7XS0lLP865gLsoB
         ciZQ==
X-Gm-Message-State: APjAAAX6heCDyrL7pEiODxWzDAcwemldXXtQvgtxOq6FCNcIxkhyyNQZ
        zry8GgIiZwd59o0hK+eGefH8zw/iQwUA8Uj1plSAkQ==
X-Google-Smtp-Source: APXvYqxgN5OeGDPaGyFPR+r1Wy/FBEwQrFtw92p5x9iifhQ0Ah/boYVFOOZFtbEccVbyFwbOVWF4lNCKen/JdK/BOQw=
X-Received: by 2002:a37:9c57:: with SMTP id f84mr2943928qke.250.1568973960048;
 Fri, 20 Sep 2019 03:06:00 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000d12d24058f5d6b65@google.com> <000000000000a12822058fb4f408@google.com>
 <20190920090803.GM30545@localhost> <CACT4Y+Yg5wTsMUGRmTwexKUMzi1ZxrH3k3yaMaJvLaEp7qnjSw@mail.gmail.com>
 <20190920092153.GN30545@localhost> <CACT4Y+aLCfq_eJ0w9EnWN-kiTR7qxgtq+8osCqdNw7L4NYCASg@mail.gmail.com>
 <20190920093557.GO30545@localhost>
In-Reply-To: <20190920093557.GO30545@localhost>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 20 Sep 2019 12:05:47 +0200
Message-ID: <CACT4Y+bHYp7Sd76PYxPtw3oxfxA-1yFp=4bXQW7an6iy_qdthQ@mail.gmail.com>
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

On Fri, Sep 20, 2019 at 11:35 AM Johan Hovold <johan@kernel.org> wrote:
>
> On Fri, Sep 20, 2019 at 11:28:22AM +0200, Dmitry Vyukov wrote:
> > On Fri, Sep 20, 2019 at 11:21 AM Johan Hovold <johan@kernel.org> wrote:
> > >
> > > On Fri, Sep 20, 2019 at 11:13:14AM +0200, Dmitry Vyukov wrote:
> > > > On Fri, Sep 20, 2019 at 11:08 AM Johan Hovold <johan@kernel.org> wrote:
> > > > >
> > > > > On Fri, Aug 09, 2019 at 01:24:04PM -0700, syzbot wrote:
> > > > > > syzbot has found a reproducer for the following crash on:
> > > > > >
> > > > > > HEAD commit:    e96407b4 usb-fuzzer: main usb gadget fuzzer driver
> > > > > > git tree:       https://github.com/google/kasan.git usb-fuzzer
> > > > > > console output: https://syzkaller.appspot.com/x/log.txt?x=13871a4a600000
> > > > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=cfa2c18fb6a8068e
> > > > > > dashboard link: https://syzkaller.appspot.com/bug?extid=0243cb250a51eeefb8cc
> > > > > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > > > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11c4c8e2600000
> > > > > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11d80d2c600000
> > > > > >
> > > > > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > > > > Reported-by: syzbot+0243cb250a51eeefb8cc@syzkaller.appspotmail.com
> > > > > >
> > > > > > usb 1-1: USB disconnect, device number 4
> > > > > > ==================================================================
> > > > > > BUG: KASAN: use-after-free in atomic64_read
> > > > > > include/asm-generic/atomic-instrumented.h:836 [inline]
> > > > > > BUG: KASAN: use-after-free in atomic_long_read
> > > > > > include/asm-generic/atomic-long.h:28 [inline]
> > > > > > BUG: KASAN: use-after-free in __mutex_unlock_slowpath+0x96/0x670
> > > > > > kernel/locking/mutex.c:1211
> > > > > > Read of size 8 at addr ffff8881d1d0aa00 by task kworker/0:1/12
> > > > >
> > > > > Let's resend and retest with commit id from latest report to make sure
> > > > > the patch was actually applied during the last run:
> > > >
> > > > The reply contains:
> > > > patch:          https://syzkaller.appspot.com/x/patch.diff?x=1440268d600000
> > > > that's what's being parsed and applied during testing.
> > >
> > > Thanks for confirming, but I can't seem to find that link in the report
> > > from syzbot:
> > >
> > >         https://lkml.kernel.org/r/000000000000b05ce40592f8521a@google.com
> > >
> > > Is it supposed to be there?
> >
> > I meant the previous one:
> > https://lore.kernel.org/linux-usb/000000000000d290e00592e5c17d@google.com/
> >
> > The one that you pointed to indeed does not have a patch (was tested
> > without any patches). But you did not include any in the request, so
> > this WAI.
>
> Ok, that was what I thought. I first tried retriggering the test by
> responding to the mail with the patch and a new test directive, but when
> that test failed, I figured the patch had not been applied and that I
> had to include it directly in the mail when retesting.
>
> Apparently misremembered someone from google responding to a patch with
> a test directive, but perhaps they also included the patch in that mail.

Yes, they probably included. But some developers point to own git
tree/branch with the fix (e.g. on github), and then they don't need to
attach patch separately.
Note the first time you included the patch inline in the email. syzbot
understands that too: you can either include inline or attach. So it
tested with your patch.
