Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8FCBC33C8C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 14:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B76CC222D9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 14:28:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V29OXUfw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728325AbgAGO2n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 09:28:43 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35626 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728129AbgAGO2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 09:28:42 -0500
Received: by mail-pg1-f193.google.com with SMTP id l24so28592126pgk.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 06:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m5lSdpvKrQdoMNKY33r6vQZFxtEtwTJgacT6S/p15LA=;
        b=V29OXUfwm4o6nbaaQVxAuVrKbGji3meV4j+OhIqD7BlXBrA2oYC9ni7MOCSdJb9nBr
         FIR4XXV6k57HZCW4swIB5KLVE+viDHImvGR8BZyhdjbn3X9Y9KJ2OveARgiZu5Ws4oyu
         pI9QwBt7aqRgr4yDb/ym+/NBbv82apnB2AIzh3RRNNAD+VUd15KC6X+YVeMSi2ejBQIK
         ifc5TpiLEXgcZuMPZJd9iPpQwSZsEh+k39If7oIt2A7GM7vKRvXuwZjMtCEew37dToe5
         PeUNiii9ntNBSYDcmHRIlOSmtHg+eNmXB9NsUhsqhvuVqx9m6ukydwBa64MmfAOoODes
         C7pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m5lSdpvKrQdoMNKY33r6vQZFxtEtwTJgacT6S/p15LA=;
        b=JzI5rPTpTquyFa1xOP0B/8uwhDib4MEcm404m2zriTdAmOWGxa2kMWIomcp+4XoHfX
         1AGtSjD6xIKhu9/HjwkQGCmvrCsXzh4l6Zd5gADal+6k++blq9oica5kALAAHIfiA20g
         RUGVXqSiBPDtAUWrshLc/xwe0BGtfeJLGHRgDyK0tNSa4rz04ZsjQBc89oku8i4rj7Of
         0YpzZWe7PVDW07qkUGcqjJaFH0V+JL3VU2Y0IFCToWwWK+SOqkduLZ73QRn1zEZ6WJ0B
         Bu3CiCBAJCwZ+7H/58tdgL+RuPKDYsB/coWjPPFLtWrzIlVSh2ojt0JESCRfmtT2ALbO
         d0jw==
X-Gm-Message-State: APjAAAViOL5EzJdfJ2KR5mqt4cA+7KdW4SR1Pv36+PDOwn4CYycp7Gw3
        aSoPkfR2Ejm+QGbxGbLDSFoFd8x5oU7+Wz1kNcJPFA==
X-Google-Smtp-Source: APXvYqwsvDKv31NioKb+iBX2xS/6+IXQu9qBpvBlOsvPE2Rnfz2aPjulQZ9cl4M3VPWvg1mHrdOQmsWs9sBNXW+eJTo=
X-Received: by 2002:aa7:9629:: with SMTP id r9mr82321097pfg.51.1578407321830;
 Tue, 07 Jan 2020 06:28:41 -0800 (PST)
MIME-Version: 1.0
References: <000000000000d29687059b3f32aa@google.com> <Pine.LNX.4.44L0.2001031159280.1560-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.2001031159280.1560-100000@iolanthe.rowland.org>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 7 Jan 2020 15:28:30 +0100
Message-ID: <CAAeHK+z5sY=CpPhO0QZGE_o1Bo8XA4PG4NT=mprO=9=Rg+1kkQ@mail.gmail.com>
Subject: Re: WARNING in usbhid_raw_request/usb_submit_urb (2)
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     syzbot <syzbot+10e5f68920f13587ab12@syzkaller.appspotmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        ingrassia@epigenesys.com,
        Kernel development list <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 3, 2020 at 6:01 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Fri, 3 Jan 2020, syzbot wrote:
>
> > Hello,
> >
> > syzbot has tested the proposed patch and the reproducer did not trigger
> > crash:
> >
> > Reported-and-tested-by:
> > syzbot+10e5f68920f13587ab12@syzkaller.appspotmail.com
> >
> > Tested on:
> >
> > commit:         ecdf2214 usb: gadget: add raw-gadget interface
> > git tree:       https://github.com/google/kasan.git
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=b06a019075333661
> > dashboard link: https://syzkaller.appspot.com/bug?extid=10e5f68920f13587ab12
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > patch:          https://syzkaller.appspot.com/x/patch.diff?x=177f06e1e00000
> >
> > Note: testing is done by a robot and is best-effort only.
>
> Andrey:
>
> Clearly something strange is going on here.  First, the patch should
> not have changed the behavior; all it did was add some log messages.
> Second, I don't see how the warning could have been triggered at all --
> it seems to be complaining that 2 != 2.

Hi Alan,

It looks like some kind of race in involved here.

There are a few indications of that: 1. there's no C reproducer
generated for this crash (usually happens because of timing
differences when executing syz repro vs C repro), 2. syz repro has
threaded, collide and repeat flags turned on (which means it gets
executed many times with some syscalls scheduled asynchronously).

This also explains the weirdness around the 2 != 2 check being failed.
First the comparison failed, then another thread updated one of the
numbers being compared, and then the printk statement got executed.

>
> Does the reproducer really work?

Yes, it worked for syzbot at the very least. It looks like your patch
introduced some delays which made the bug untriggerable by the same
reproducer. Since this is a race it might be quite difficult to
reproduce this manually (due to timing differences caused by a
different environment setup) as well unfortunately.

Perhaps giving a less invasive patch (that minimizes timing changes
introduced to the code that is suspected of being racy) to syzbot
could be used to debug this.

Thanks!
