Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14171CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 13:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA12E20659
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 13:14:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="msl1HfiQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502435AbfJXNOE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 09:14:04 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33355 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502405AbfJXNOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 09:14:04 -0400
Received: by mail-qk1-f195.google.com with SMTP id 71so19468922qkl.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 06:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JQHcyUnSIp339K9FKmfDYw9UCbM8Q9Ch8P2/s1FBU9s=;
        b=msl1HfiQYnIpkl7hU80XjsF7bZtllIkrpxf3WO7plSCw75gbGg9RfOzqf2ThJZSI9i
         hySC5uA444uiteodVBFS1PuxXkqcIBEAGVnS9rhaFOgYInfKZb2HE4tv+ORlaR3bd5V7
         6bULjoWlbDAk3UE14BgBJOacrxfygYoQHHuPXVPNi0LoRJcSqnb/qH5qPywqpal6Veo4
         nSXSq5u5REQ7ylpz/K9g4INW6rc8Emxwne+UJN6j7alhtV4PJe+7UK7ju1lsMeLtp7eY
         G1B/60+BQkYSYGxZlGD9iZnpGHT9I2XFZhaoNBH2iEhi+A4e9IbyLeZNH/UH0opzzvl3
         E/Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JQHcyUnSIp339K9FKmfDYw9UCbM8Q9Ch8P2/s1FBU9s=;
        b=GD9qlSxr009oDJ5ypE+FQyGn299H7ACw6zEBWNm/OhSd8XedgTIAyw7hRh3WUwydbR
         KEK6XV4n0DrYH1VxgCIsSNJRy0oirK7oNvVtljPRxxPUecnM7+arD+uhF7ebWovtSgDU
         lM212OBPQrJPk4KoWWXX6cmnNmqBWQYWS44AnO0Ht90tWCuWo6MLssOwN9lxcXze+2/U
         LYeeZafw2kfT0zUE0a8XG0VxC2NbA3cjFKFIXBhenFoIz6j4tz9qDhxwhGOhB/03QMAY
         m38zHE7ND4DOmxn2aG73FW9Yo71+yied71wvecN18ob46ite4L/vpwITvp+2xvnLbkg6
         yfHQ==
X-Gm-Message-State: APjAAAVrfce+jNwIflWg4f8kD0Gvj83LXsGEm+5T04VOWZ7umzFQTkNS
        YRcYgHGjVz1u1vm7FcxS5U7igU7KlZi7mXS6vq58bQ==
X-Google-Smtp-Source: APXvYqwZ7apFX/YX+sP24Otc+tiWUNJLzt1FSVCurx1ko1dlteIYXugGs1AhlFccwEmG7l/NhWDo20oDb1SkZ5RCcGw=
X-Received: by 2002:a05:620a:a11:: with SMTP id i17mr3508638qka.8.1571922840980;
 Thu, 24 Oct 2019 06:14:00 -0700 (PDT)
MIME-Version: 1.0
References: <20191009114809.8643-1-christian.brauner@ubuntu.com>
 <20191021113327.22365-1-christian.brauner@ubuntu.com> <20191023121603.GA16344@andrea.guest.corp.microsoft.com>
 <CACT4Y+Y86HFnQGHyxv+f32tKDJXnRxmL7jQ3tGxVcksvtK3L7Q@mail.gmail.com>
 <20191024113155.GA7406@andrea.guest.corp.microsoft.com> <CACT4Y+Z2-mm6Qk0cecJdiA5B_VsQ1v8k2z+RWrDQv6dTNFXFog@mail.gmail.com>
 <20191024130502.GA11335@andrea.guest.corp.microsoft.com>
In-Reply-To: <20191024130502.GA11335@andrea.guest.corp.microsoft.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 24 Oct 2019 15:13:48 +0200
Message-ID: <CACT4Y+ahUr11pQQ7=dw80Abj5owUPnPdufbMYvsKLM6iDg5QQg@mail.gmail.com>
Subject: Re: [PATCH v6] taskstats: fix data-race
To:     Andrea Parri <parri.andrea@gmail.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Will Deacon <will@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, bsingharora@gmail.com,
        Marco Elver <elver@google.com>,
        stable <stable@vger.kernel.org>,
        syzbot <syzbot+c5d03165a1bd1dead0c1@syzkaller.appspotmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2019 at 3:05 PM Andrea Parri <parri.andrea@gmail.com> wrote:
>
> On Thu, Oct 24, 2019 at 01:51:20PM +0200, Dmitry Vyukov wrote:
> > On Thu, Oct 24, 2019 at 1:32 PM Andrea Parri <parri.andrea@gmail.com> wrote:
> > >
> > > > How these later loads can be completely independent of the pointer
> > > > value? They need to obtain the pointer value from somewhere. And this
> > > > can only be done by loaded it. And if a thread loads a pointer and
> > > > then dereferences that pointer, that's a data/address dependency and
> > > > we assume this is now covered by READ_ONCE.
> > >
> > > The "dependency" I was considering here is a dependency _between the
> > > load of sig->stats in taskstats_tgid_alloc() and the (program-order)
> > > later loads of *(sig->stats) in taskstats_exit().  Roughly speaking,
> > > such a dependency should correspond to a dependency chain at the asm
> > > or registers level from the first load to the later loads; e.g., in:
> > >
> > >   Thread [register r0 contains the address of sig->stats]
> > >
> > >   A: LOAD r1,[r0]       // LOAD_ACQUIRE sig->stats
> > >      ...
> > >   B: LOAD r2,[r0]       // LOAD *(sig->stats)
> > >   C: LOAD r3,[r2]
> > >
> > > there would be no such dependency from A to C.  Compare, e.g., with:
> > >
> > >   Thread [register r0 contains the address of sig->stats]
> > >
> > >   A: LOAD r1,[r0]       // LOAD_ACQUIRE sig->stats
> > >      ...
> > >   C: LOAD r3,[r1]       // LOAD *(sig->stats)
> > >
> > > AFAICT, there's no guarantee that the compilers will generate such a
> > > dependency from the code under discussion.
> >
> > Fixing this by making A ACQUIRE looks like somewhat weird code pattern
> > to me (though correct). B is what loads the address used to read
> > indirect data, so B ought to be ACQUIRE (or LOAD-DEPENDS which we get
> > from READ_ONCE).
> >
> > What you are suggesting is:
> >
> > addr = ptr.load(memory_order_acquire);
> > if (addr) {
> >   addr = ptr.load(memory_order_relaxed);
> >   data = *addr;
> > }
> >
> > whereas the canonical/non-convoluted form of this pattern is:
> >
> > addr = ptr.load(memory_order_consume);
> > if (addr)
> >   data = *addr;
>
> No, I'd rather be suggesting:
>
>   addr = ptr.load(memory_order_acquire);
>   if (addr)
>     data = *addr;
>
> since I'd not expect any form of encouragement to rely on "consume" or
> on "READ_ONCE() + true-address-dependency" from myself.  ;-)

But why? I think kernel contains lots of such cases and it seems to be
officially documented by the LKMM:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/memory-model/Documentation/explanation.txt
address dependencies and ppo
Am I missing something? Why do we need acquire with address dependency?

> IAC, v6 looks more like:
>
>   addr = ptr.load(memory_order_consume);
>   if (!!addr)
>     *ptr = 1;
>   data = *ptr;
>
> to me (hence my comments/questions ...).
>
> Thanks,
>   Andrea
