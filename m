Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F54C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 11:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83F7A214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 11:23:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N4HP+e2O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730014AbfIRLXC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 07:23:02 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38345 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729986AbfIRLXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 07:23:02 -0400
Received: by mail-pf1-f193.google.com with SMTP id h195so4228426pfe.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 04:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dPa/Nd4Xm9egVVca3WCKvHDpOUWuA07121LqF/L0skA=;
        b=N4HP+e2OMzdxyU3nrf6Wx1pXWulBYlFahBpxy3oBvwxTFSlM3vysv8oUKhMLbZafd9
         jYn8gTWWBw04GKgdtECW18DNyF2ItFAb+13VFeaEy7VAWQMsmDw/cpnTDdfaFGdclFXY
         FM5yJV4PdXHbbld+3MWth/b/gODMGcAjf1+lxfSQdkTSbnThW6eMRgZqgU5C7RTc2qov
         Vy2grXb0h3B90KV4acvuYrEhQC7brTfNyBv5iiXEsvKAz54/fNr6SoylzXYqtxcq71Op
         rM+QAiZS5LMFMOWfFQr83i7p5rGhYS5VrQeZQappZ3xR8J5YL7d61PYs8dExnwwMjUjv
         pNHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dPa/Nd4Xm9egVVca3WCKvHDpOUWuA07121LqF/L0skA=;
        b=lzIa6f3eQiuE+znkiescvHvVpBy9CaCiuV6BdQA1zVyELjntDxPIBf/rkm8hjELoGz
         v8xhceGapLCbRYTNMhefJ6xX4HAqbAgdC6dcsykIBpfxCLE/gcHL89nMEVkVVLHDEIJp
         5s0uQ16DbIWVg+TC7hMIlRpa3r1TEewVVC8zLHGng6nfDnH3Pj9dsjGuGdN0M6hZXrwv
         AtzsrJK2IbABcBRDKyukncxxsdL1qul7RkoDiTPAqkzY4Z8cNXyt9jQ2jFYJjsMFOaQT
         40fLwHNwSKzI+wGEoGkHuHFKGLK48ffUEmI+0+GAm159yt5lhW1ufBrBerCjTqTziXPX
         fAdw==
X-Gm-Message-State: APjAAAUwlYNnXn4TPsHv8YIyDfnR7YGrue10yt31uo/YYCMvw2IS1DlE
        nC5qGNYahpoM1UcAAdQUqgTDJ0PNGRFm/FiH5vo6s2L1hgA=
X-Google-Smtp-Source: APXvYqwFjjmeCQQKrh6wpxNWJ3ampLnBhouMCf47XtUZ5EJ84Q0sV4PtV3qs2cO4Q0kI12jdMJjJeb9Mc4IMcgjUCO0=
X-Received: by 2002:a17:90a:ff18:: with SMTP id ce24mr3122051pjb.123.1568805781151;
 Wed, 18 Sep 2019 04:23:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAAeHK+zrR3pB2R3yyyUdGM4Vrv77o47MHsgvbQ+LFHfiWBt1OQ@mail.gmail.com>
 <Pine.LNX.4.44L0.1909161205280.1489-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1909161205280.1489-100000@iolanthe.rowland.org>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Wed, 18 Sep 2019 13:22:49 +0200
Message-ID: <CAAeHK+yL9DX9oraq5dN8CSU6LzYN7PnRzppVbiG5b6QM5_ygEg@mail.gmail.com>
Subject: Re: INFO: rcu detected stall in dummy_timer
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     syzbot <syzbot+b24d736f18a1541ad550@syzkaller.appspotmail.com>,
        Felipe Balbi <balbi@kernel.org>, chunfeng.yun@mediatek.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 16, 2019 at 6:32 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Mon, 16 Sep 2019, Andrey Konovalov wrote:
>
> > On Fri, Sep 13, 2019 at 10:35 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> > >
> > > On Fri, 13 Sep 2019, syzbot wrote:
> > >
> > > > syzbot has found a reproducer for the following crash on:
> > > >
> > > > HEAD commit:    f0df5c1b usb-fuzzer: main usb gadget fuzzer driver
> > > > git tree:       https://github.com/google/kasan.git usb-fuzzer
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=1146550d600000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=5c6633fa4ed00be5
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=b24d736f18a1541ad550
> > > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11203fa5600000
> > > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=162cd335600000
> > > >
> > > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > > Reported-by: syzbot+b24d736f18a1541ad550@syzkaller.appspotmail.com
> > > >
> > > > yurex 3-1:0.101: yurex_interrupt - unknown status received: -71
> > > > yurex 5-1:0.101: yurex_interrupt - unknown status received: -71
> > > > yurex 6-1:0.101: yurex_interrupt - unknown status received: -71
> > > > rcu: INFO: rcu_sched self-detected stall on CPU
> > >
> > > Andrey:
> > >
> > > This problem may be a result of overloading dummy_timer.  The kernel
> > > config you are using has CONFIG_HZ=100, but dummy-hcd needs
> > > CONFIG_HZ=1000 (see the comment on line 1789).  That is, lower values
> > > of HZ will occasionally lead to trouble, and this may be an example.
> > >
> > > Can you change the config value for HZ and see if the bug still
> > > reproduces?
> >
> > Hi Alan,
> >
> > I've tried running the reproducer with CONFIG_HZ=1000 and still got
> > the same stall message. It's accompanied by countless "yurex
> > 6-1:0.101: yurex_interrupt - unknown status received: -71" messages,
> > so I believe this is an issue in the yurex driver.
>
> Maybe.  Depends on exactly what the reproducer is doing, something
> which is not at all easy to figure out from the scripts or programs.
>
> I got the impression that the reproducer connects an emulated yurex
> device and then disconnects it -- but maybe that's not right at all.
> Maybe the key point is that the reproducer sends a descriptor listing
> an endpoint address that doesn't actually exist; that would have a
> similar effect.  Can you tell?  (Trying to understand exactly what a
> syzkaller test program does is not for the faint of heart.)
>
> As far as I can remember, the USB spec doesn't say what a device should
> do when the host sends a packet to a non-existent endpoint.  Which
> means that some devices will do nothing at all, leading to the -71
> (-EPROTO) errors you see in the log.  Indeed, there's only one place in
> dummy_hcd.c where -EPROTO occurs -- for the case where an URB is sent
> to an endpoint not supported by the gadget.
>
> This leads to the question: How should the yurex driver (or any USB
> class driver, in fact) respond to a -EPROTO or similar error?  The
> thing is, this sort of error typically arises in two circumstances:
>
>         The device was just unplugged, so of course it can't send
>         any packets back to the host;
>
>         Noise on the bus caused a packet to be lost or corrupted.
>
> In the first case, it doesn't much matter what the driver does because
> the disconnection will be noticed and acted on within a few hundred
> milliseconds (although I suppose a driver could generate a lot of
> kernel-log spam during that time).
>
> In the second case, retrying the lost/corrupted packet is the right
> response.
>
> But retrying is _not_ the right response in cases where the device is
> never going to respond because the endpoint address is invalid.  This
> can happen only in situations where the device provides incorrect
> information (bad descriptors or something of that sort).  The only
> suitable approach I can think of is to limit the number of retries.
>
> Retry-limiting is not the sort of thing we want to add to each
> individual USB class driver.  Maybe it can be handled in the USB core;
> I'll try to write some code for it.  Under normal circumstances the
> issue just doesn't arise, because normal devices aren't malicious.
>
> > Why does dumy_hcd require CONFIG_HZ=1000? The comment doesn't really
> > explain the reason.
>
> Oh, that's simple enough.  USB events tend to happen at millisecond
> intervals.  The data on the USB bus is organized into frames (and
> microframes for high speed and SuperSpeed); a frame lasts one
> millisecond (and a microframe lasts 1/8 ms).  Many host controllers
> report important events when a frame boundary occurs (that's how
> dummy-hcd works).
>
> So for proper timing of the emulation, dummy-hcd requires timer
> interrupts with millisecond resolution.  I suppose the driver could be
> changed to use a high-res timer instead of a normal kernel timer, but
> for now that doesn't seem particularly important.

So what are the practical differences between using CONFIG_HZ=100 and
1000 for dummy-hcd? Is is going to be slower or faster? Or can it get
overloaded with data and cause stalls? Or something else? We're
somewhat hesitant to change CONFIG_HZ as we don't know how it will
affect other parts of the kernel (at some point the USB fuzzer will
become a part of the main syzbot instance that doesn't only fuzz USB).
