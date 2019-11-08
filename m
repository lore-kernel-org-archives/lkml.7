Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF7B8FC6196
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 20:53:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9080F214DB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 20:53:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FKgTzWNM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731238AbfKHUxv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 15:53:51 -0500
Received: from mail-il1-f170.google.com ([209.85.166.170]:33853 "EHLO
        mail-il1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729981AbfKHUxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 15:53:51 -0500
Received: by mail-il1-f170.google.com with SMTP id p6so6332006ilp.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 12:53:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QP8RInZYsAMDu5pw7upwHybwYLWcynuRUEkP7xjdKws=;
        b=FKgTzWNMRiBtDkjkYNoecIIq2/5xMPTsKzTfSUHRLoXdSQeZjsbrb+bCzCw54yxeCa
         UQGOG7dVkvMFq53zok/QccRk66ER+fC9Jb+26+b4Rlo0z33KHqslXGCpQ8s03bxYj7f4
         VyCUcnPchJ5vXtDoc5f0A1KAsuWjJbB/1Hg5Kv+F5EAzB7imF0Scub6gy8yKWa2MUVr6
         7+ndgVnLXqrN5uNqWMHjfoclVzdQwqph547OY5ljE06BgSv0iL3ZeCT8zmKwPKXo1vYX
         Fn/0ZT2yq06dHLRCKV/znbyYhkR9S+lOSEuJXcugyI2L/5pcye8EsinqZ5k5luD6/7Ti
         tNaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QP8RInZYsAMDu5pw7upwHybwYLWcynuRUEkP7xjdKws=;
        b=fuq3sQEoRiHFrEz6sE/D+RhJ5E6N/oL2xtSK4psyt9e7xg768gHkTZESdvsuhR+edR
         zv/4hUf4vB/mg6yvSDhDLzU8SOpZ0EMHhpOp8WwkRr+iOsJeCeavR6i887Yu2dtVLaqV
         INgbWv4Mbe9JQrMYM5eR1ehdTwb3kgYSpst225gK2uMf4cOo3P0IBxh88qJ55lp7rW1K
         hMeDudUFVgwMURES9LWe5zzXmbosH6/aDrkdBgz646wth/dqdabpnsSDyNAkj3MaKuOa
         a5/M6cDyk/JeQ22yb8xwkqmvb3d+MN4FFQAJqUIJUsGOz61rtuJr1IsP/rAaEvwtTzKp
         TOjQ==
X-Gm-Message-State: APjAAAXpZoxvKfjAB5Z3/RTvFkvVvsEFPuCebRNOmdDmIrZE35IBvWTo
        93F7WUpxi9QjFiLyHIhOrK7pMjHGJI5WGDu5PnFNoA==
X-Google-Smtp-Source: APXvYqxevPZ+6IPYvCtrJ8aisbah+vDZsEqjBENlaXAku3DtSoYvhqSOl4PjBdgN1HFqFFSfGhSvtEETkO40ynMhZic=
X-Received: by 2002:a92:99cb:: with SMTP id t72mr13199933ilk.218.1573246429652;
 Fri, 08 Nov 2019 12:53:49 -0800 (PST)
MIME-Version: 1.0
References: <000000000000c422a80596d595ee@google.com> <6bddae34-93df-6820-0390-ac18dcbf0927@gmail.com>
 <CAHk-=whh5bcxCecEL5Fy4XvQjgBTJ9uqvyp7dW=CLU6VNxS9iA@mail.gmail.com>
 <CANn89iK9mTJ4BN-X3MeSx5LGXGYafXkhZyaUpdXDjVivTwA6Jg@mail.gmail.com>
 <CAHk-=whNBL63qmO176qOQpkY16xvomog5ocvM=9K55hUgAgOPA@mail.gmail.com>
 <CANn89iJJiB6avNtZ1qQNTeJwyjW32Pxk_2CwvEJxgQ==kgY0fA@mail.gmail.com>
 <CANn89i+RrngUr11_iOYDuqDvAZnPfG3ieJR025M78uhiwEPuvQ@mail.gmail.com> <CAHk-=wi-aTQx5-gD51QC6UWJYxQv1p1CnrPpfbn4X1S4AC7G-g@mail.gmail.com>
In-Reply-To: <CAHk-=wi-aTQx5-gD51QC6UWJYxQv1p1CnrPpfbn4X1S4AC7G-g@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 8 Nov 2019 12:53:38 -0800
Message-ID: <CANn89iJh-WcvZYQEfdK=RGswQX8e1rp=CR27a6kWQkgK996P7g@mail.gmail.com>
Subject: Re: KCSAN: data-race in __alloc_file / __alloc_file
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        syzbot <syzbot+3ef049d50587836c0606@syzkaller.appspotmail.com>,
        Marco Elver <elver@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 8, 2019 at 12:30 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, Nov 8, 2019 at 9:56 AM Eric Dumazet <edumazet@google.com> wrote:
> >
> > BTW, I would love an efficient ADD_ONCE(variable, value)
> >
> > Using WRITE_ONCE(variable, variable + value) is not good, since it can
> > not use the optimized instructions operating directly on memory.
>
> So I'm having a hard time seeing how this could possibly ever be valid.
>
> Is this a "writer is locked, readers are unlocked" case or something?

per cpu SNMP counters mostly, with no IRQ safety requirements.

Note that this could be implemented using local{64}_add() on arches like x86_64,
while others might have to fallback to WRITE_ONCE(variable, variable + add)

>
> Because we don't really have any sane way to do that any more
> efficiently, unless we'd have to add new architecture-specific
> functions for it (like we do have fo the percpu ops).
>
> Anyway, if you have a really hot case you care about, maybe you could
> convince the gcc people to just add it as a peephole optimization?
> Right now, gcc ends up doing some strange things with volatiles, and
> basically disables a lot of stuff over them. But with a test-case,
> maybe you can convince somebody that certain optimizations are still
> fine. A "read+add+write" really does the exact same accesses as an
> add-to-memory instruction, but gcc has some logic to disable that
> instruction fusion.
>
>           Linus
