Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4EC2C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 17:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA2E820673
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 17:53:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M5diUmqr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729935AbfKHRxP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 12:53:15 -0500
Received: from mail-il1-f178.google.com ([209.85.166.178]:45056 "EHLO
        mail-il1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbfKHRxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 12:53:14 -0500
Received: by mail-il1-f178.google.com with SMTP id o18so5863543ils.12
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 09:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C9TsgJFTcfRwuc/WaCy1JpAsWZBRp62dC/cBlD5yCig=;
        b=M5diUmqrAoGpBQVNj/NZt0ynuDchzXatuHboKTn50HBE6KCQLAak+nVQyXaOcAKnX7
         Wc9plUO/jgMHq/HcqyCxMp55R3K2npPvE+D7TO/cglkFENINKLtlyLtvmiSXw5urmJhS
         Fe01qGaMgW/rpcJ5KiYaidLJ+9C4BrEC2ym59dRxNTs1wboR7Q6zVcSxAUO78StZZTTM
         Da7CqjNYfmBGkdRZJaAkMD1HQAv6AUd034rP+3d+Gzw3BI3JyZT0LJh1RFnm2Fzpm6EI
         lWF2LmmJcs5o+6FmBTU9aNQ1FDI+PtwXi+rBh+bi1hpdAjh3uXDfyriYO8eDt4kbg1d/
         5jHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C9TsgJFTcfRwuc/WaCy1JpAsWZBRp62dC/cBlD5yCig=;
        b=qsgrvUtQ02j/d+t1FYFWpP11UhHjTF7bI2kyfLVBmvOjGSz+i2ePB3iNAZd+HHSDR1
         V/xEB7OlCtTYhUtILQAJ/PerhxyMdIAaRfn2tJ7MO3LI/8kdtE1s9qRgrjuGRf+C6W4J
         Zzof/ZGusyg2gv06z16JY+DTUHPueucacdTsqc7qV2SWqLGVKOKrW5a9auXGjrBl0+s8
         9CAEF/+PxgahdxghvJIfOvoHL8Ogy5/37Xzt/1Sgvhl5pla3+RhO4b8fS6RKyQfm7rAU
         WmgA7yItVW6zSqym2C+tG0ImpuDUxU8BSYm2UZ1HFvYF9nmxo0fadQAkgvJcss6rPTIl
         LpWA==
X-Gm-Message-State: APjAAAVZ4WkViuyw/LNybHoH3yQj+9EMlw/TcSoWFfrkHEHlvKGwUnI8
        7SCjC2OHNs0FHnt/kc3oyRo7aLRIYJT9X8NycRV6oQ==
X-Google-Smtp-Source: APXvYqwOs6JqCzcRGiH00Hf71WJTMZ9paYvQQsox0aJ+DCKj4oP0w0FHCBKbg68rYymi75JgYW3loNUbGCT+bynPCxI=
X-Received: by 2002:a92:ca8d:: with SMTP id t13mr13502229ilo.58.1573235592625;
 Fri, 08 Nov 2019 09:53:12 -0800 (PST)
MIME-Version: 1.0
References: <000000000000c422a80596d595ee@google.com> <6bddae34-93df-6820-0390-ac18dcbf0927@gmail.com>
 <CAHk-=whh5bcxCecEL5Fy4XvQjgBTJ9uqvyp7dW=CLU6VNxS9iA@mail.gmail.com>
 <CANn89iK9mTJ4BN-X3MeSx5LGXGYafXkhZyaUpdXDjVivTwA6Jg@mail.gmail.com> <CAHk-=whNBL63qmO176qOQpkY16xvomog5ocvM=9K55hUgAgOPA@mail.gmail.com>
In-Reply-To: <CAHk-=whNBL63qmO176qOQpkY16xvomog5ocvM=9K55hUgAgOPA@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 8 Nov 2019 09:53:01 -0800
Message-ID: <CANn89iJJiB6avNtZ1qQNTeJwyjW32Pxk_2CwvEJxgQ==kgY0fA@mail.gmail.com>
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

On Fri, Nov 8, 2019 at 9:39 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:

> I'd hope that there is some way to mark the cases we know about where
> we just have a flag. I'm not sure what KCSAN uses right now - is it
> just the "volatile" that makes KCSAN ignore it, or are there other
> ways to do it?

I dunno, Marco will comment on this.

I personally like WRITE_ONCE() since it adds zero overhead on generated code,
and is the facto accessor we used for many years (before KCSAN was conceived)

>
> "volatile" has huge problems with code generation for gcc. It would
> probably be fine for "not_rcu" in this case, but I'd like to avoid it
> in general otherwise, which is why I wonder if there are other
> options.
>
> But worst comes to worst, I'd be ok with a WRITE_ONCE() and a comment
> about why (and the reason being KCSAN, not the questionable
> optimization).

Ok for a single WRITE_ONCE() with a comment.

Hmm, which questionable optimization are you referring to?
