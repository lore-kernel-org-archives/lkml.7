Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB0E8C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 18:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE78E2087E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 18:16:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eOjJlMG+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729539AbfKHSQL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 13:16:11 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:41576 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728235AbfKHSQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 13:16:11 -0500
Received: by mail-oi1-f193.google.com with SMTP id e9so6040077oif.8
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 10:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5tUkPEobvq0D1LVe3HBgFyeSBazbNDJmhpV7AqtazYk=;
        b=eOjJlMG++cIiJCf+41ocgxmN10k5xlvB3wJ0CksO002FTLGIfa1fJAK3O6Jkuvb+fx
         PoYCLNW6D9YGSl/MRBgAgccJM9ZYaMcSWBKOR7v209fCgig2SLt9Ica4sc8EHdCSh8XH
         Ux1kOwoLofwMYcXkC1qfLwNF+V8nJ+gsHx/B6VSj99yDTpBiHFF7QN7BQjdI0F/qpINc
         9OuIsii0Utk16W6qPPnOPqVSFO9J2+ryFGyMIdT+r6lw0e2eERLZDQDBX+lKlXDdfOG5
         5aoWOUYIE9AeSKenvkd6IZDEUieVABlwMtLu3qTnx16lM/SXZWP7UC29idEKMbV/UIQM
         LPug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5tUkPEobvq0D1LVe3HBgFyeSBazbNDJmhpV7AqtazYk=;
        b=TBNMc6e4knf2XEgt9AzMx/UFr2JaVGzo6QTZbaDL6DeKE3+GXrGLtYeakjl9ATB6FO
         uEPrhj3d/SrxXYfZRXy0qtktDfR3fmM9yy0k89rCaWc8qpF/zTZFFZCXIxoYt/iiuJRX
         4Z+PXG83UwfpLux7SKaUYYiUHcpPfCI/rrm5aspJLpCagkrVK1mfHFGVYLamiXIecFDE
         2qZimB5lrIduecHcwhH9HztF17Oy09xkp8puncDbngbu1DJLttExHhyQjFf2F0J/eGnV
         +faEYMpnYjfFceQUzLL2FC15tBwTefkozBzVPiovUtjwLJmvBZa49W7kwGFSXeeSxv+B
         kgKw==
X-Gm-Message-State: APjAAAWJSBv+yjIqF+uM1FO/mtGUwwmZNU5tda2bpddMZWaTUAEkbn2U
        lCOHq/GC+pK7f6AzWu0ga9urAJPrGPNGOEwRGW+3Kw==
X-Google-Smtp-Source: APXvYqxRJMUbSON3GrNlz4n2lBEX4xlXNxzvn2DMVWHU2QEnT8Nd2kjm7NF/1I3KGh6JRBri/HehhFEFXd1Cw4pZHpY=
X-Received: by 2002:aca:fc0d:: with SMTP id a13mr10989363oii.83.1573236969814;
 Fri, 08 Nov 2019 10:16:09 -0800 (PST)
MIME-Version: 1.0
References: <000000000000c422a80596d595ee@google.com> <6bddae34-93df-6820-0390-ac18dcbf0927@gmail.com>
 <CAHk-=whh5bcxCecEL5Fy4XvQjgBTJ9uqvyp7dW=CLU6VNxS9iA@mail.gmail.com>
 <CANn89iK9mTJ4BN-X3MeSx5LGXGYafXkhZyaUpdXDjVivTwA6Jg@mail.gmail.com>
 <CAHk-=whNBL63qmO176qOQpkY16xvomog5ocvM=9K55hUgAgOPA@mail.gmail.com>
 <CANn89iJJiB6avNtZ1qQNTeJwyjW32Pxk_2CwvEJxgQ==kgY0fA@mail.gmail.com> <CAHk-=wiZdSoweA-W_8iwLy6KLsd-DaZM0gN9_+f-aT4KL64U0g@mail.gmail.com>
In-Reply-To: <CAHk-=wiZdSoweA-W_8iwLy6KLsd-DaZM0gN9_+f-aT4KL64U0g@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Fri, 8 Nov 2019 19:15:58 +0100
Message-ID: <CANpmjNOuRp0gdekQeodXm8O_yiXm7mA8WZsXZNmFfJYMs93x8w@mail.gmail.com>
Subject: Re: KCSAN: data-race in __alloc_file / __alloc_file
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Eric Dumazet <edumazet@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        syzbot <syzbot+3ef049d50587836c0606@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Nov 2019 at 19:05, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, Nov 8, 2019 at 9:53 AM Eric Dumazet <edumazet@google.com> wrote:
> >
> > I personally like WRITE_ONCE() since it adds zero overhead on generated code,
> > and is the facto accessor we used for many years (before KCSAN was conceived)
>
> So I generally prefer WRITE_ONCE() over adding "volatile" to random
> data structure members.
>
> Because volatile *does* have potentially absolutely horrendous
> overhead on generated code. It just happens to be ok for the simple
> case of writing once to a variable.
>
> In fact, you bring that up yourself in your next email when you ask
> for "ADD_ONCE()". Exactly because gcc generates absolutely horrendous
> garbage for volatiles, for no actual good reason. Gcc *could* generate
> a single add-to-memory instruction. But no, that's not at all what gcc
> does.
>
> So for the kernel, we've generally had the rule to avoid 'volatile'
> data structures as much as humanly possible, because it actually does
> something much worse than it could do, and the source code _looks_
> simple when the volatile is hidden in the data structures.
>
> Which is why we have READ_ONCE/WRITE_ONCE - it puts the volatile in
> the code, and makes it clear not only what is going on, but also the
> impact it has on code generation.
>
> But at the same time, I don't love WRITE_ONCE() when it's not actually
> about writing once. It might be better to have another way to show
> "this variable is a flag that we set to a single value". Even if maybe
> the implementation is then the same (ie we use a 'volatile' assignment
> to make KCSAN happy).

(+some LKMM folks, in case I missed something on what the LKMM defines
as data race.)

KCSAN does not use volatile to distinguish accesses. Right now
READ_ONCE, WRITE_ONCE, atomic bitops, atomic_t (+ some arch specific
primitives) are treated as marked atomic operations.

The goal is to cover all primitives that the LKMM declares as
marked/atomic. A data race is then detected for concurrent conflicting
accesses where at least one is plain unmarked. In the end the LKMM
should decide what KCSAN determines as a data race. As far as I can
tell, none of the reported data races so far are false positives in
that sense.

Many thanks,
-- Marco
