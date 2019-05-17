Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D075C04E84
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 15:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E21E520578
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 15:44:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HteBNW8w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729348AbfEQPoT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 11:44:19 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:52557 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729321AbfEQPoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 11:44:17 -0400
Received: by mail-it1-f196.google.com with SMTP id q65so12699812itg.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 08:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xPx/5zsWpr6dpMt2ZdfZYDg9B43iY/qIid2tfZShROw=;
        b=HteBNW8wUCDqU0bkLO1oMqXPuerlO73Sb+ubls7XQp4+T1I6wkiqIIIrucr1VPYBDd
         9CMAy3tx8FyxdMh8fOGTAaNytsvPZCa+9UEi6ACaYFH1Zej/cOm9mCHItTUeYC4h+6e6
         YT3DYxaI9rUg47H8qvp50IEs7H7ryNTFrLVxhosriWTk9X+qCHrVb06Y+d01ORSocVi6
         B7Jywj7VGOE8ZgQAqbsg5DMfcj4YRzKpGr2CNnD+9hwhhctokLzM7e7i8+6fHQqG/gl1
         8JokOfrtJv9ZNeaUPaR049r/17wmxClwC1A9cs0oCgwG9LizXhYlV3jICoTeufCERfg3
         qPsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xPx/5zsWpr6dpMt2ZdfZYDg9B43iY/qIid2tfZShROw=;
        b=j4bdYsr73BxolhTlUNnoUqiNjr/vj3NJzLuhSnrPa67VsJt1kZtN5o15XCGX0NohVh
         Jxfa1hcModWuoA3yflRxnicZZvzibOlc/zmrrFzC5l+CPJIGrH5+V+A8sk/5V1V2SPBL
         x5UHKvH9uIHLUCN7EhLYtkzFDOT2T+jnctV61y6gG5bcwcfLdXKRUHQkAYIKJH4S0YZA
         JbtPdZ362W45G/Y/05RrCb8noVlUU2tTXavZ2miwkCtJV+LUtKh7eSnFeYXGrpRLqnPk
         TlTlP+pdtevifamDWreC1gkLEDErDAi7RZXG5Wo74F9S6YThavK5axo7TCXvCMcbzrxB
         LrOg==
X-Gm-Message-State: APjAAAVWdCRChAqHWDUQDfbiPhOyDNY9i/b9Tr+5i33Hs0d1Kreu1uEd
        mChZuPmektzs94N9KGd0EVop9rMwfr6TJuCtBRK1wg==
X-Google-Smtp-Source: APXvYqxKfTx8+UErI7nWVVGmBjNSSLAV4BzhtyQ6LWivKSlGjVjwNwzOGGok2rEg9D5GeoKicFZJcwwP1WbzcZFMmN0=
X-Received: by 2002:a24:c204:: with SMTP id i4mr17482106itg.83.1558107856462;
 Fri, 17 May 2019 08:44:16 -0700 (PDT)
MIME-Version: 1.0
References: <CACT4Y+Z9GcY-d19ROSXgAq4-d_hOBVArfgGV1VdYcYD_X1coPQ@mail.gmail.com>
 <CAHRSSEw7QAfuKsQhHNZcwizn5zEVA6CjAdO7qh69g3fkXrk7DA@mail.gmail.com>
In-Reply-To: <CAHRSSEw7QAfuKsQhHNZcwizn5zEVA6CjAdO7qh69g3fkXrk7DA@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 17 May 2019 17:44:05 +0200
Message-ID: <CACT4Y+ZLZHbsW3kFD5oXssuOP6LmY0YRRPnWc41CBQ6APJS4MA@mail.gmail.com>
Subject: Re: binder stress testing
To:     Todd Kjos <tkjos@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 17, 2019 at 5:36 PM Todd Kjos <tkjos@google.com> wrote:
>
> From: Dmitry Vyukov <dvyukov@google.com>
> Date: Fri, May 17, 2019 at 3:26 AM
> To: Greg Kroah-Hartman, Arve Hj=C3=B8nnev=C3=A5g, Todd Kjos, Martijn Coen=
en,
> Joel Fernandes, Christian Brauner, open list:ANDROID DRIVERS, LKML
> Cc: syzkaller
>
> > Hi,
> >
> > I have 2 questions re drivers/android/binder.c stress testing.
> >
> > 1. Are there any docs on the kernel interface? Or some examples on how
> > to use it and reference syscall sequences to make it do something
> > meaningful?
> > I hopefully figured out struct layouts and offsets of objects thing,
> > but I still can't figure out handles, pointers, nodes, pointer to
> > nodes... pointer to data (?), references, cookies and where does one
> > get valid values for these.
>
> The kernel interface is not well documented since it isn't intended to
> be used apart from libbinder. The best example for your purposes is
> probably the binderDriverInterfaceTest which you can find at
> https://android.googlesource.com/platform/frameworks/native/+/refs/heads/=
master/libs/binder/tests/binderDriverInterfaceTest.cpp.
>
> The libbinder source is at
> https://android.googlesource.com/platform/frameworks/native/+/refs/heads/=
master/libs/binder.
>
> >
> > 2. In my tests any transaction breaks binder device until the next rebo=
ot.
> > If I open binder device twice, mmap, set context and then the process
> > dies, then everything it released fine, in particular the context
> > (context_mgr_node gone). So the device is ready for a next test:
> >
> > [   40.247970][ T6239] binder: binder_open: 6238:6239
> > [   40.250819][ T6239] binder: 6238:6239 node 1 u0000000000000000
> > c0000000000000000 created
> > [   40.253365][ T6239] binder: binder_mmap: 6238 200a0000-200a2000 (8
> > K) vma f9 pagep 8000000000000025
> > [   40.256454][ T6239] binder: binder_open: 6238:6239
> > [   40.259604][ T6239] binder: binder_mmap: 6238 200c0000-200c2000 (8
> > K) vma f9 pagep 8000000000000025
> > [   40.271526][ T6238] binder: 6238 close vm area 200a0000-200a2000 (8
> > K) vma 180200d9 pagep 8000000000000025
> > [   40.273113][ T6238] binder: 6238 close vm area 200c0000-200c2000 (8
> > K) vma 180200d9 pagep 8000000000000025
> > [   40.275058][   T17] binder: binder_flush: 6238 woke 0 threads
> > [   40.275997][   T17] binder: binder_flush: 6238 woke 0 threads
> > [   40.276968][   T17] binder: binder_deferred_release: 6238 threads
> > 0, nodes 0 (ref 0), refs 0, active transactions 0
> > [   40.278626][   T17] binder: binder_deferred_release: 6238
> > context_mgr_node gone
> > [   40.279756][   T17] binder: binder_deferred_release: 6238 threads
> > 1, nodes 1 (ref 0), refs 0, active transactions 0
> >
> >
> > However, if I also send a transaction between these fd's, then
> > context_mgr_node is not released:
> >
> > [  783.851403][ T6167] binder: binder_open: 6166:6167
> > [  783.858801][ T6167] binder: 6166:6167 node 1 u0000000000000000
> > c0000000000000000 created
> > [  783.862458][ T6167] binder: binder_mmap: 6166 200a0000-200a2000 (8
> > K) vma f9 pagep 8000000000000025
> > [  783.865777][ T6167] binder: binder_open: 6166:6167
> > [  783.867892][ T6167] binder: binder_mmap: 6166 200c0000-200c2000 (8
> > K) vma f9 pagep 8000000000000025
> > [  783.870810][ T6167] binder: 6166:6167 write 76 at 0000000020000180,
> > read 0 at 0000000020000300
> > [  783.872211][ T6167] binder: 6166:6167 BC_TRANSACTION 2 -> 6166 -
> > node 1, data 0000000020000200-00000000200002c0 size 88-24-16
> > [  783.873819][ T6167] binder: 6166:6167 node 3 u0000000000000000
> > c0000000000000000 created
> > [  783.875032][ T6167] binder: 6166 new ref 4 desc 1 for node 3
> > [  783.875860][ T6167] binder:         node 3 u0000000000000000 -> ref =
4 desc 1
> > [  783.876868][ T6167] binder: 6166:6167 wrote 76 of 76, read return 0 =
of 0
> > [  783.886714][ T6167] binder: 6166 close vm area 200a0000-200a2000 (8
> > K) vma 180200d9 pagep 8000000000000025
> > [  783.888161][ T6167] binder: 6166 close vm area 200c0000-200c2000 (8
> > K) vma 180200d9 pagep 8000000000000025
> > [  783.890134][   T27] binder: binder_flush: 6166 woke 0 threads
> > [  783.891036][   T27] binder: binder_flush: 6166 woke 0 threads
> > [  783.892027][ T2903] binder: release 6166:6167 transaction 2 out, sti=
ll active
> > [  783.893097][ T2903] binder: unexpected work type, 4, not freed
> > [  783.893947][ T2903] binder: undelivered TRANSACTION_COMPLETE
> > [  783.894849][ T2903] binder: node 3 now dead, refs 1, death 0
> > [  783.895717][ T2903] binder: binder_deferred_release: 6166 threads
> > 1, nodes 1 (ref 1), refs 0, active transactions 1
> >
> >
> > And all subsequent tests will fail because "BINDER_SET_CONTEXT_MGR
> > already set" presumably to the now unrecoverably dead process:
> >
> > [  831.085174][ T6191] binder: binder_open: 6190:6191
> > [  831.087450][ T6191] binder: BINDER_SET_CONTEXT_MGR already set
> > [  831.088910][ T6191] binder: 6190:6191 ioctl 4018620d 200000c0 return=
ed -16
> > [  831.090626][ T6191] binder: binder_mmap: 6190 200a0000-200a2000 (8
> > K) vma f9 pagep 8000000000000025
> > [  831.092783][ T6191] binder: binder_open: 6190:6191
> > [  831.094076][ T6191] binder: binder_mmap: 6190 200c0000-200c2000 (8
> > K) vma f9 pagep 8000000000000025
> > [  831.096218][ T6191] binder: 6190:6191 write 76 at 0000000020000180,
> > read 0 at 0000000020000300
> > [  831.097606][ T6191] binder: 6190:6191 BC_TRANSACTION 5 -> 6166 -
> > node 1, data 0000000020000200-00000000200002c0 size 88-24-16
> > [  831.099251][ T6191] binder_alloc: 6166: binder_alloc_buf, no vma
> > [  831.100433][ T6191] binder: 6190:6191 transaction failed 29189/-3,
> > size 88-24 line 3157
> > [  831.101559][ T6191] binder: 6190:6191 wrote 76 of 76, read return 0 =
of 0
> > [  831.110317][ T6191] binder: 6190 close vm area 200a0000-200a2000 (8
> > K) vma 180200d9 pagep 8000000000000025
> > [  831.111752][ T6191] binder: 6190 close vm area 200c0000-200c2000 (8
> > K) vma 180200d9 pagep 8000000000000025
> > [  831.113266][ T3344] binder: binder_flush: 6190 woke 0 threads
> > [  831.114147][ T3344] binder: binder_flush: 6190 woke 0 threads
> > [  831.115087][ T3344] binder: undelivered TRANSACTION_ERROR: 29189
> > [  831.115991][ T3344] binder: binder_deferred_release: 6190 threads
> > 1, nodes 0 (ref 0), refs 0, active transactions 0
> > [  831.117525][ T3344] binder: binder_deferred_release: 6190 threads
> > 1, nodes 0 (ref 0), refs 0, active transactions 0
> >
> >
> > The question is: if processes that opened the device and ever mapped
> > it are now completely gone, should it reset the original state when
> > context can be bound again? Is it a bug in binder that it does not? If
> > so, is there some kind of temp work-around for this?
>
> If all the processes that opened the device are gone, everything
> should be cleaned up and leave binder in a useable state. When the
> device is in this state, can you dump out
> /sys/debug/kernel/binder/state and send it to me?


Here it is:


binder state:
dead nodes:
  node 3: u0000000000000000 c0000000000000000 hs 0 hw 0 ls 0 lw 0 is 1
iw 1 tr 1 proc 6193
proc 6193
context binder0
  thread 6194: l 00 need_return 1 tr 0
  node 1: u0000000000000000 c0000000000000000 hs 1 hw 1 ls 2 lw 1 is 0 iw 0=
 tr 1
  ref 4: desc 1 dead node 3 s 1 w 0 d 00000000e77aea3b
  buffer 2: 00000000b2301cfa size 88:24:16 active
  pending transaction 2: 00000000b1591166 from 0:0 to 6193:0 code 0
flags 0 pri 0 r1 node 1 size 88:24 data 00000000b2301cfa



Kernel also said:

[  197.049702][   T12] binder: release 6193:6194 transaction 2 out, still a=
ctive
[  197.050803][   T12] binder: unexpected work type, 4, not freed
[  197.051658][   T12] binder: undelivered TRANSACTION_COMPLETE

Not sure why there is something unexpected. I don't try to fuzz it or
something at this point. Just run a basic test.
Here is the test, it's in syzkaller notation, but hopefully you can
get overall idea:

r0 =3D syz_open_dev$binder(&AUTO=3D'/dev/binder#\x00', 0x0, 0x2)
ioctl$BINDER_SET_CONTEXT_MGR_EXT(r0, AUTO, &AUTO=3D{AUTO, 0x100, 0x0, 0x0})
mmap$binder(&(0x7f00000a0000), 0x2000, 0x1, 0x11, r0, 0x0)
r1 =3D syz_open_dev$binder(&AUTO=3D'/dev/binder#\x00', 0x0, 0x2)
mmap$binder(&(0x7f00000c0000), 0x2000, 0x1, 0x11, r1, 0x0)
ioctl$BINDER_WRITE_READ(r1, AUTO, &AUTO=3D{AUTO, AUTO,
&AUTO=3D[@transaction_sg=3D{AUTO, {0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
AUTO, AUTO, &AUTO=3D{@flat=3D@binder=3D{AUTO, 0x0, 0x0, 0x0}, @fd=3D{AUTO,
AUTO, r0, AUTO, 0x0}, @ptr=3D{AUTO, 0x0, &AUTO=3D""/10, AUTO, 0x0, 0x0}},
&AUTO=3D{AUTO, AUTO, AUTO}}, 0x10}], AUTO, AUTO, &AUTO})
