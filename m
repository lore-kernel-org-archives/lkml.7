Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BBF2CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 18:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AA6821929
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 18:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fwQs8Hts"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504200AbfJXS4E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 14:56:04 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46021 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504187AbfJXS4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 14:56:00 -0400
Received: by mail-pg1-f193.google.com with SMTP id r1so14759560pgj.12
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 11:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zIsOYlF+Hfsx0uQ6HDxs/ZLm/Efmg1cPtI+tKoRa+Ng=;
        b=fwQs8HtsbJC9TUXndyJvvRCSoM3v6KN1oAJTDP4jM6iDp7RiEChmUmkSfgcD9hrL32
         dx4RALPc8vlvE5fZ/IQbv0hnM6XhYSw01JxzCQbLwgA0U4VbrnHk7p1AmgcsbwUweSnT
         FIjrOwiJF5IE7d1++6ArnJN3EZAH9wAePU20+J7wEZYcQUvvMQJPZX/t/m1/TWMAKDoX
         jvFHVfTgM5DBQG2eLVTWNpVQX4tJoaIP29Oapbf6H3Q+ogUaYIdWv8KQ/loM6fGpi6kt
         ERDAVhC7vZAsJ+NLuPJFLEkDkdKn0boNcGRQ5CpiNLbMVUBSG7stG68qLSb1aevbFfYI
         tkrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zIsOYlF+Hfsx0uQ6HDxs/ZLm/Efmg1cPtI+tKoRa+Ng=;
        b=V6kJCvicRCZaXBFKgzFxsbwc6CM826JjEh1LIg0ybRWHK/QWWx1I0wkWBf74jvF0RM
         SUixIi0PejUtQtn/dRioyuYKLN3JiHO9V/E4Mggqc/O8Nq9kvmTWmqI4Il8iVGKNTbBN
         awREPxoAvvLbfYacItuxp3hxdgMoqYLJZTUWr6glKs70vHnuPO0caTJ3bo99sfTmHiLZ
         Cap1/u6W4whuO6c1MLP3OqlGOAcrU1a6FAzYVmYjDmB+k7IVg2ETfbJ9VC7UopBkosrJ
         68k319OaS23N2r6e1E7HTlgG/NQfJVzudpGz4txmN8VwhTHVoxJWBZIlYtlh/GGwEQFO
         wf6Q==
X-Gm-Message-State: APjAAAXYT+kwx+K8OIcEBUrltKQJ43gYhMz5GZ8AyKThfYBWmJWQ7fES
        DBuVahah+MbBYAre6TiH1NrJp9ONOjCoKvi0La7TCA==
X-Google-Smtp-Source: APXvYqwaOT3FEr+3qKwPmfNbI0gl2kNtUMfI82LNX1yvphFCTA/cRn6O4jDY8NzKyj6NhNKToKL6mL0jsxkmXM0wkH8=
X-Received: by 2002:a63:541e:: with SMTP id i30mr18286107pgb.130.1571943359247;
 Thu, 24 Oct 2019 11:55:59 -0700 (PDT)
MIME-Version: 1.0
References: <CAAeHK+xHTtkSRkMv5kV1hKcR3mhTPkyfUparka3oRBSs6U8yLQ@mail.gmail.com>
 <Pine.LNX.4.44L0.1910241336130.1318-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1910241336130.1318-100000@iolanthe.rowland.org>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 24 Oct 2019 20:55:48 +0200
Message-ID: <CAAeHK+yu2MYmh86wJ_DxYoUEU-vp9R+jXRVMh_SpsSNFdHVO7g@mail.gmail.com>
Subject: Re: divide error in dummy_timer
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     syzbot <syzbot+8ab8bf161038a8768553@syzkaller.appspotmail.com>,
        "Jacky . Cao @ sony . com" <Jacky.Cao@sony.com>,
        Felipe Balbi <balbi@kernel.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2019 at 7:57 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Thu, 24 Oct 2019, Andrey Konovalov wrote:
>
> > > Is this really the sort of thing we need to catch?  It isn't a bug in
> > > any existing kernel code, as far as I know.  Maybe only gadgetfs and
> > > configfs need to worry about it.
> >
> > Hi Alan,
> >
> > Do you mean that the gadget driver must ensure that the max packet
> > size in the endpoint descriptor is not zero? Do HCDs rely on that? I
> > can add this check into the driver we use for USB fuzzing.
>
> Well, if there are any gadget drivers in the kernel which do set an
> endpoint's maxpacket size to 0, they should be fixed.  I'm not aware of
> any.
>
> Of course, gadget drivers in userspace are always suspect.  That's why
> I suggested having gadgetfs and configfs perform this check.  Even so
> it's not really a _security_ risk, because only the superuser is
> allowed to run a userspace gadget driver.  (Although obviously it is
> better to have a clean failure than to crash the system when a buggy
> program runs with superuser privileges.)
>
> Yes, HCDs do depend on endpoints having reasonable maxpacket values.  I
> suppose the core should check for this.  Currently we check for values
> that are too large or invalid in other ways (like high-speed bulk
> endpoints with maxpacket != 512), but we don't check for 0.

Oh, I think I've confused the terms here. I meant to ask about UDCs.
The question is whether it's OK to try and emulate a gadget with
maxpacket = 0 on a board with a hardware UDC? Or can it cause issues?
The fact that HCDs must ensure correct maxpacket values of course
makes sense.

>
> In fact, that sounds like a much better solution to the problem
> overall.  Let's see if this patch fixes the bug...
>
> Alan Stern
>
> #syz test: https://github.com/google/kasan.git 22be26f7
>
>  drivers/usb/core/config.c |    5 +++++
>  1 file changed, 5 insertions(+)
>
> Index: usb-devel/drivers/usb/core/config.c
> ===================================================================
> --- usb-devel.orig/drivers/usb/core/config.c
> +++ usb-devel/drivers/usb/core/config.c
> @@ -348,6 +348,11 @@ static int usb_parse_endpoint(struct dev
>
>         /* Validate the wMaxPacketSize field */
>         maxp = usb_endpoint_maxp(&endpoint->desc);
> +       if (maxp == 0) {
> +               dev_warn(ddev, "config %d interface %d altsetting %d endpoint 0x%X has wMaxPacketSize 0, skipping\n",
> +                   cfgno, inum, asnum, d->bEndpointAddress);
> +               goto skip_to_next_endpoint_or_interface_descriptor;
> +       }
>
>         /* Find the highest legal maxpacket size for this endpoint */
>         i = 0;          /* additional transactions per microframe */
>
