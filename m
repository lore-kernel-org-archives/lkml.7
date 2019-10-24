Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E67CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 11:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3743621925
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 11:51:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fCanMbbT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439447AbfJXLvf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 07:51:35 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38477 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729203AbfJXLve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 07:51:34 -0400
Received: by mail-qk1-f193.google.com with SMTP id p4so23101922qkf.5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 04:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fn71rS6ReHvy4UBLvwf94Jworjf0D0oVW+GNxGRscwE=;
        b=fCanMbbThrjQ8BD1rKmwg7faRCTM9M3H48xUKhe8TvnCH1bzJfuGFeLvZ5W6+aAXV0
         nm6R1jR9Hsv7ETPrzmmHJ6GzAoOKpw2yuc/ZnWZqvLypmiRPxlSBrFUYOowfg02DQCx5
         nGOBmTZtj219z7P+SAO7uKe3pZChryDOLtwiIwUENGEvMy11k338XaT3srqPR4vgoWsb
         u+qIimV7ArVdxpwHJLD+te8PR7+I5bheOqtXrCcddeXoyFpVv0/2TEOlen9dBOUbLtiq
         Uth+M7QzikkXJPW/M9656ra3UVRFKMxE0TtCvOWisoK0c/gWpOo5fbJlJrxQxJWy9fVG
         fYGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fn71rS6ReHvy4UBLvwf94Jworjf0D0oVW+GNxGRscwE=;
        b=AgQe3DaU8HHXsW9HmksNcATWid5UZLeP37XqhPwTfEZGO7z8zoSmgsXVV5K+kfBQ8p
         +kV5q4OLHgFH37AQt2Te5skTuziLHeaSyFPeJbwLsAZyrjolr0IlC6pGAyVfWa2ysqro
         pqxd649oiCLxsAZATmZqWrToGvx5iYek8uN08aFz4QgAT/SOHqlbzCPggqR7H+QLnwFz
         1ZYs0YYfVjkphQf/Gm18EAGPFVwi9qgcqq1X+Fgon8nootL2A+raIhATncfp2gNX7KXI
         lfYOTSV1knp3WvRgmEzurX5U8e/UFm6jYOH/o/N3qCGbnmUqiITpGUJ4BmrD0scPu/rF
         1gaA==
X-Gm-Message-State: APjAAAWgmhLtlCUwm/tfPhs68Ojrdb0u1GG5vzN1ahetZqY0V47bZL8h
        C/Z3zVr5exIDrkVziJJrBrskeYTtGr+1Eu36Wnozeg==
X-Google-Smtp-Source: APXvYqy9hgBd93nPeWGRHTk3cy25U/c44xf7hFfKXooycp0aSt7g/D0iewfPfLS973ff2Y3BmC8nPcng6i/Dm+0JgnY=
X-Received: by 2002:a37:4a87:: with SMTP id x129mr2134986qka.43.1571917893077;
 Thu, 24 Oct 2019 04:51:33 -0700 (PDT)
MIME-Version: 1.0
References: <20191009114809.8643-1-christian.brauner@ubuntu.com>
 <20191021113327.22365-1-christian.brauner@ubuntu.com> <20191023121603.GA16344@andrea.guest.corp.microsoft.com>
 <CACT4Y+Y86HFnQGHyxv+f32tKDJXnRxmL7jQ3tGxVcksvtK3L7Q@mail.gmail.com> <20191024113155.GA7406@andrea.guest.corp.microsoft.com>
In-Reply-To: <20191024113155.GA7406@andrea.guest.corp.microsoft.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 24 Oct 2019 13:51:20 +0200
Message-ID: <CACT4Y+Z2-mm6Qk0cecJdiA5B_VsQ1v8k2z+RWrDQv6dTNFXFog@mail.gmail.com>
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

On Thu, Oct 24, 2019 at 1:32 PM Andrea Parri <parri.andrea@gmail.com> wrote:
>
> > How these later loads can be completely independent of the pointer
> > value? They need to obtain the pointer value from somewhere. And this
> > can only be done by loaded it. And if a thread loads a pointer and
> > then dereferences that pointer, that's a data/address dependency and
> > we assume this is now covered by READ_ONCE.
>
> The "dependency" I was considering here is a dependency _between the
> load of sig->stats in taskstats_tgid_alloc() and the (program-order)
> later loads of *(sig->stats) in taskstats_exit().  Roughly speaking,
> such a dependency should correspond to a dependency chain at the asm
> or registers level from the first load to the later loads; e.g., in:
>
>   Thread [register r0 contains the address of sig->stats]
>
>   A: LOAD r1,[r0]       // LOAD_ACQUIRE sig->stats
>      ...
>   B: LOAD r2,[r0]       // LOAD *(sig->stats)
>   C: LOAD r3,[r2]
>
> there would be no such dependency from A to C.  Compare, e.g., with:
>
>   Thread [register r0 contains the address of sig->stats]
>
>   A: LOAD r1,[r0]       // LOAD_ACQUIRE sig->stats
>      ...
>   C: LOAD r3,[r1]       // LOAD *(sig->stats)
>
> AFAICT, there's no guarantee that the compilers will generate such a
> dependency from the code under discussion.

Fixing this by making A ACQUIRE looks like somewhat weird code pattern
to me (though correct). B is what loads the address used to read
indirect data, so B ought to be ACQUIRE (or LOAD-DEPENDS which we get
from READ_ONCE).

What you are suggesting is:

addr = ptr.load(memory_order_acquire);
if (addr) {
  addr = ptr.load(memory_order_relaxed);
  data = *addr;
}

whereas the canonical/non-convoluted form of this pattern is:

addr = ptr.load(memory_order_consume);
if (addr)
  data = *addr;

Moreover the second load of ptr is not even atomic in our case, so it
is a subject to another data race?
