Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE078C2D0CD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 13:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F66A20716
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 13:17:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hVc1G40w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbfLQNRr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 08:17:47 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44466 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbfLQNRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 08:17:47 -0500
Received: by mail-qt1-f196.google.com with SMTP id t3so1344157qtr.11
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 05:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jrOhow0LERvVTgRWMw8HjxYHfftJQbyUzenQeDRKpNw=;
        b=hVc1G40wmuN29e/V1ueLNufDTB45hvOZ5AF9oM1WAvEa/QR/fTBSORPWG6C+ygzNaV
         rThxGsF56pUYCA76xBVQl0426ovktTX6Sn0HtZkugW/EqsBY7b1ZIINrUcC46kGWzJ9d
         PDqZSdpqX0CPn+d57OdicAvLhKDRLrEkLBonFp9s8EvYcnaspQbo8li69dmaxHH8JFew
         YvvT9sjg8WXmfOCSqaQTb9AKsaCpt3JgAnCL66dKflhei7iJj1z7g3K7tJpoG573SIgF
         uGkJtLGqVbnkyNGFkKIBWK9hMx0rgpwRnU65W964t8po8Smp4nHg9TFZ1lMIsfFgT/Cp
         1Qsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jrOhow0LERvVTgRWMw8HjxYHfftJQbyUzenQeDRKpNw=;
        b=AZHozFJep6zG1/PslB0gOs9/wEWbhB1JKcW8ZOPybOaNBdbleuCMo8XGKXR9wSNqXR
         kwccAzKBUEHO5np1I73zanD9zFj1rhGWqxIssdNGb5tqtO3/3qLlZ+/si39RdILG3uby
         soQ/udIfdAm7CHk721q16c1pvBDGWKNdkRG32XoVYu/ioZh2sV26bFMGyK7TzQQ9SMaD
         cJWxMrwKF+MSk9WT2hOfvMTVHmSa5brDHeUBGGvgBKM6Iuhwmns68ATK1QC1921JjrT0
         7BrA86DzDNQGYSgFDrZ73JMLpOv5zh+pXqQrgCf2X3+/2fFW4RS0rXv4KpUhcJO6sDhN
         hSZg==
X-Gm-Message-State: APjAAAXm8+ltiZpmux5cUuacURfDC34bBHL/I4DUc+LX4ESiKc6R/UDE
        BmAp73mw/UfPGoiev4ZWyhCW9DcA+u/UbpyJx09viA==
X-Google-Smtp-Source: APXvYqxwtGuGXBWkQlbdxv1qeyjlfPK7XOWDAqVQbUNaEvZbhMfR/yIMHD1HskM9LCBNZgFWCmDonw5xqZVQRSIuCnE=
X-Received: by 2002:aed:2465:: with SMTP id s34mr4450549qtc.158.1576588665910;
 Tue, 17 Dec 2019 05:17:45 -0800 (PST)
MIME-Version: 1.0
References: <CAAeHK+yz3dtfx0Jfd4sbOcN8tSxp8+qAvW609sP_yJC5q6vq8A@mail.gmail.com>
 <Pine.LNX.4.44L0.1912161002080.1406-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1912161002080.1406-100000@iolanthe.rowland.org>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 17 Dec 2019 14:17:34 +0100
Message-ID: <CACT4Y+ZpJ9a8hw4vStUJZDZLh0kvphAKOXCSCYjXxgX4CYmD_g@mail.gmail.com>
Subject: Re: Re: general protection fault in usb_set_interface
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        syzbot <syzbot+7fa38a608b1075dfd634@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>, mans@mansr.com,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2019 at 4:05 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Mon, 16 Dec 2019, Andrey Konovalov wrote:
>
> > On Fri, Dec 13, 2019 at 8:51 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> > >
> > > On Fri, 13 Dec 2019, Andrey Konovalov wrote:
> > >
> > > > > > Let's retry here:
> > > > >
> > > > > > #syz test: https://github.com/google/kasan.git f0df5c1b
> > > > >
> > > > > This bug is already marked as fixed. No point in testing.
> > > > >
> > > >
> > > > Hm, that explains some of the weirdness. It doesn't explain though
> > > > neither why the patch was actually tested when Alan requested it nor
> > > > why syzbot sent no reply.
> > >
> > > In the meantime, is there any way to get syzbot to test the new patch
> > > with the old reproducer?  Perhaps tell it to re-open this bug?
> >
> > No, we can only test this manually now. I can run the reproducer for
> > you. Should I revert the fix for this bug and then apply your patch?
> > What's the expected result?
>
> Please simply run the patch as it is, with no other changes.  The
> expected result is a use-after-free Read in usbvision_v4l2_open, just
> as with c7b0ec009a216143df30.

I can't figure this out now.
According to the database, there was a test job for that bug from you
on Dec 10, it finished with some error and the result was mailed. But
I can't find it anywhere as well.

I've filed https://github.com/google/syzkaller/issues/1547
"dashboard/app: show jobs on bug page", which I think will be useful
and will shed some light on such cases and make it more transparent
for you, it will also show the result even if you did not receive it
over email.
Thanks
