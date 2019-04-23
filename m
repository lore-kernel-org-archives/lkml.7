Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8CA4C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 12:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD484206A3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 12:45:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qJn9kQES"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbfDWMpF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 08:45:05 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40139 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727228AbfDWMpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 08:45:05 -0400
Received: by mail-pl1-f196.google.com with SMTP id b3so7483494plr.7
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 05:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=drP+3jXgBFG4XDNGP4blkFr7mTMqlSYTTt2HSdhDEPg=;
        b=qJn9kQES2XCFX4FUrxy3jQm2W9Y0FNjYQBCq7a6EGeb/Hx/VQK3MBTpYlnV8eeUKNN
         r7b0XhkXFd9D/gZVVxjHHdrkW6V0PURsHbFw8lZuG2O6G+RhUjfXLJZW/PjEwt3UQZ4w
         A5Cbc8RjaD65sgstQ8UR+ZHW28iK/3bz+7aoOV3VszQCxTQnbOjs6+FUvmlZtlDXc++q
         OhXF3w+84oUGwYbgwGH9+0uyCS9OHdt+iNom2Bd1Gsbhwnpnh/IM9SxYPOkrwgGJL1Ho
         ahhd2ewaqe/GfkSxkPb7kPFWYPV71xGcUHAXhxkn+LLo4UpSlDoQYTmcCAAuAuJuaEul
         HEqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=drP+3jXgBFG4XDNGP4blkFr7mTMqlSYTTt2HSdhDEPg=;
        b=uYwmurH4OA2e0g+E2zosWlLWwXu+SSb5AF+FuBn8ZSqarg8boWnVY/eAVGf5vYb06n
         TmJutTrQJO3KLwOyj8jgP3Rs7RtzqRK62MvBW/K6f0L9nwYuFY6ar7A8Te9193hWY+PU
         PDVQMnXgf6qkGyNVt0yoiRux6pL8JuwVvDrFme3tYS2uqDnbUVC3/Y9mt9sBymS81/3E
         zXkDnkkD8OqfK0mJvGkpmess2qKbIe7O4VbkevdJ5CkaNf5VNa3nXMlnCgvBaoUIAEyq
         G06OFLMFVFCOFwcM6E8Ffh+pJcMudQL730+V/Lj6Bjw5KhQsckV/eyp6J+y6WwLELvSB
         JYQw==
X-Gm-Message-State: APjAAAVxAN3+MV9MVLMBUiHHZ8OxIb9xR2obhk3621E9CGjhVEybRYja
        ewyz6ZyKKr1hvlCY8Es/A+XqnbRdAYmmbfAC0tJTxg==
X-Google-Smtp-Source: APXvYqx9oxELimY+nvTrKzm48cKNo0fU0EpzqXPj+2RFN3QgJC+DOA3m4ff4sLeo7pzx3SJj88q57khNfIcQFwECWts=
X-Received: by 2002:a17:902:2b89:: with SMTP id l9mr24732595plb.329.1556023503064;
 Tue, 23 Apr 2019 05:45:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAAeHK+zCwXpAb02vaPuanStYCp_x8g92HDEvm_LTN_F+Y_wOfQ@mail.gmail.com>
 <Pine.LNX.4.44L0.1904191429230.1406-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1904191429230.1406-100000@iolanthe.rowland.org>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 23 Apr 2019 14:44:51 +0200
Message-ID: <CAAeHK+w0PCvTsQpqfH-4Q07Dj1TpJtD9VgesgiA+X8+HR=K+QQ@mail.gmail.com>
Subject: Re: UDC hardware for fuzzing [was: Re: INFO: task hung in usb_kill_urb]
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Felipe Balbi <felipe.balbi@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        USB list <linux-usb@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2019 at 8:36 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Wed, 17 Apr 2019, Andrey Konovalov wrote:
>
> > On Tue, Apr 16, 2019 at 8:25 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> > >
> > > On Tue, 16 Apr 2019, syzbot wrote:
> > >
> > > > Hello,
> > > >
> > > > syzbot has tested the proposed patch but the reproducer still triggered
> > > > crash:
> > > > INFO: task hung in usb_kill_urb
> > >
> > > Okay, I think I found the problem.  dummy-hcd doesn't check for
> > > unsupported speeds until it is too late.  Andrey, what values does your
> > > usb-fuzzer gadget driver set for its max_speed field?
> >
> > It's passed from userspace without any validation :( I'll fix this!
> > Thanks for looking into it!
> >
> > I wonder why other people saw this hang as well, they didn't use the
> > dummy hcd module for sure. I guess there are might be other reasons.
>
> Unquestionably it would be for other reasons.  usb_kill_urb() is a
> host-side routine, not used by gadget drivers.  If it fails, the reason
> lies in host controller driver.  And if people aren't using dummy-hcd
> then they must be using a different host controller driver.
>
> Is there any chance you could get hold of a USB device controller for
> more fuzzing tests?  With it, you could test other parts of the USB
> stack: the UDC driver for whatever hardware you get, and the host
> controller driver for whatever you plug the UDC into.
>
> I don't know what types of UDC are readily available for the type of
> computer syzkaller uses.  Perhaps Felipe or other people on the mailing
> list will have some suggestions.

You mean using a hardware UDC and plugging it into a USB host via a
physical USB cable? Yeah, I've tried that. I've used the UDC that's
available on Raspberry Pi Zero which uses the dwc2 driver for running
the reproducers syzkaller generates while having it connected to a
Linux host. It works! =) I also have a USB3380 based UDC that uses the
net2280 gadget driver. It kind of works, I was able to emulate a
SuperSpeed device with it, but the driver crashes all the time.

I haven't tried actual fuzzing of a physical host yet, that is
something on my TODO list. I was more interested in fuzzing non-Linux
hosts this way, but I can try it with Linux as well. The problem here
is that it's difficult to automate this.
