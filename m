Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37BCFC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 12:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F003E213F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 12:49:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vhDC3rp8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbfCTMt5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 08:49:57 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:50941 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfCTMt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 08:49:57 -0400
Received: by mail-it1-f196.google.com with SMTP id m137so15672141ita.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 05:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E8TumUXS3/MXgkml0adwFz1cs8fRCq3O3njfvQdNHbU=;
        b=vhDC3rp8rg0hA+NHVvDPTd7ndosBpSK4BlpAHRJp5EqztvFawgmPuN2GnVjX1/m0M/
         hmTczl4r0diQdS/Lcf+XmAJORsaDWfoyOTmwiHXGZZr/6rXbok2w74cBEylbRZBZ4jHg
         Kcvlh6YDbGboxSrZfyyJYkUhv3M/AehyvmegEnh9pEkcEFgUkyLVycH6xQdWH/uVhc8l
         TcZwtejO9sA6fhlxcr67QlIJf05QEQl+SxWdhw6g6rKRb7G3Y6h9mFJkOp9UcHEu33qw
         G1L5LgAHW5EPfH+DWPkB91EFp/jvhUFklcnImV74Ud3MKVE4/FgMYdJJe7Qtcj2jpQrz
         iKKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E8TumUXS3/MXgkml0adwFz1cs8fRCq3O3njfvQdNHbU=;
        b=uVn5CRcWJlIfoAf6c1zQzypCzvavhKlUZnWaVcsNSKWEuHX8jYiaPD3FHimaYxcatS
         eq9W+ot4PFWTXN8/vHjtC/YCpD0PjsBp99i9PkQwYsQ3o/fc066O7EdL4erjyCYt2Lkm
         KFixrlhiR/zrCcNSkOE2xOSCcI209Sb1PcykZyXIy0QLACY5dHxxMGl/ZJml2PDp+itv
         KjBBmO2qNlEjkNphhl3C9lsOpt7Tli50XQGYLZmCpDv3KS0sUyZ5or8ZM8CAtZMJtJOp
         SDp4Q2BH1dv9gUrN7J0rufsO+QgWRv5tqpc12z9y8G3jcKwhU2gT43B7tNji0hQvu0Wh
         /FVw==
X-Gm-Message-State: APjAAAUgNyXZQbdcQVaNgqOoTz/Jbua1syUAU5kjb9LWaTUk07nEeZXr
        5oAzAedMqkZ2UxyTq0V3NfB2JPZIEOsZQ3DnpatDnA==
X-Google-Smtp-Source: APXvYqy8YXgMzrPoSNk+IbweLxWTOTUVgzSAq9Sosz2L9D6UEaOvYU4cb6LLRxX8+QczhvYi8w8nPpYExH5ShEzFehM=
X-Received: by 2002:a24:9a86:: with SMTP id l128mr4814098ite.12.1553086195874;
 Wed, 20 Mar 2019 05:49:55 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000010b2fc057fcdfaba@google.com> <0000000000008c75b50583ddb5f8@google.com>
 <20190312040829.GQ2217@ZenIV.linux.org.uk> <491ff1c3-91d6-eaa7-f551-46a4f8b90f5a@i-love.sakura.ne.jp>
 <CACT4Y+ahcZpJ1Q-TKkCJkyhzGc07XFusuwBcKjg_rfAeos8RWA@mail.gmail.com>
 <92a4e5e5-33ca-7b39-16c0-82c7fb742d18@i-love.sakura.ne.jp>
 <CACT4Y+ZQD=raWY4Tp8nrUcpAAbwRt0D3sH65KrTP+JURtQ3n-Q@mail.gmail.com>
 <20190313234040.GH10169@gmail.com> <f3e25790-4edd-9e77-f656-e41d7a992945@i-love.sakura.ne.jp>
In-Reply-To: <f3e25790-4edd-9e77-f656-e41d7a992945@i-love.sakura.ne.jp>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 20 Mar 2019 13:49:44 +0100
Message-ID: <CACT4Y+ZR=GoC6eNkgu4mVzDK9ad_J3DT3ThsUBj_PFK3q5tRag@mail.gmail.com>
Subject: Re: INFO: rcu detected stall in sys_sendfile64 (2)
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        syzbot <syzbot+1505c80c74256c6118a5@syzkaller.appspotmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2019 at 11:52 AM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2019/03/14 8:40, Eric Biggers wrote:
> > On Wed, Mar 13, 2019 at 07:43:38AM +0100, 'Dmitry Vyukov' via syzkaller-bugs wrote:
> >>> Also, humans can sometimes find more simpler C reproducers from syzbot provided
> >>> reproducers. It would be nice if syzbot can accept and use a user defined C
> >>> reproducer for testing.
> >>
> >> It would be more useful to accept patches that make syzkaller create
> >> better reproducers from these people. Manual work is not scalable. We
> >> would need 10 reproducers per day for a dozen of OSes (incl some
> >> private kernels/branches). Anybody is free to run syzkaller manually
> >> and do full manual (perfect) reporting. But for us it become clear
> >> very early that it won't work. Then see above, while that human is
> >> sleeping/on weekend/vacation, syzbot will already bisect own
> >> reproducer. Adding manual reproducer later won't help in any way.
> >> syzkaller already does lots of smart work for reproducers. Let's not
> >> give up on the last mile and switch back to all manual work.
> >>
> >
> > Well, it's very tough and not many people are familiar with the syzkaller
> > codebase, let alone have time to contribute.
>
> Right. I don't read/write go programs. I don't have access to environments
> for running syzbot. But instead I try to write kernel patches.
>
> Also, although anybody is free to do full manual (perfect) reporting,
> I can't afford checking such reports posted to e.g. LKML. I can afford
> checking only https://syzkaller.appspot.com/ .
>
> I have seen a Japanese article which explains how to run syzbot. But I felt that
> that article lacks what to do if syzbot found a bug. If people found a crash
> by running syzbot in their environments, it would be nice if they can export
> the report and import it to https://syzkaller.appspot.com/ (i.e. dashboard
> acts as if a bugzilla).
>
> >                                               But having simplified a lot of
> > the syzkaller reproducers manually, the main things I do are:
>
> Yes. I'm doing similar things. Other things not listed here are:
>
>   Try to remove syscall() which passes EOF as fd argument, for it should be
>   unrelated to the problem unless such call affects subtle timing.
>
>   Try to remove code for testing fuse / tun etc. if the problem seems to be
>   unrelated to fuse / tun etc.
>
> syzbot gets pleased with finding one C reproducer, but I wish that syzbot
> continues trying to find smaller C reproducers by e.g. eliminating unrelated
> calls.
>
> >
> > - Replace bare system calls with proper C library calls.  For example:
> >
> >       #include <sys/syscall.h>
> >
> >       syscall(__NR_socket, 0xa, 6, 0);
> >
> >     becomes:
> >
> >       #include <sys/socket.h>
> >
> >         socket(AF_INET, SOCK_DCCP, 0);
>
> Yes. It would be nice if C reproducers are provided using symbols. I run
> syzbot provided C reproducers under strace because strace gives me more hints
> about symbols and structures.


I will answer re reproducers first.

Thanks for the suggestions, I've filed
https://github.com/google/syzkaller/issues/1070 for this. Lots of them
are implementable within the current framework. Things on kernel
mailing lists (suggestions, bug reports, patches) get lost very
quickly.

As far as I see most of them are related to cosmetics (not saying that
it's not useful, but just won't affect bisection results).
From my experience the most powerful simplifications are possible only
when I have already root caused the bug and understand its mechanics.
Then it's possible to reorder syscalls, remove all/most of threading,
etc. But in that case bisection is not so useful already.

Some of them can alter the load on kernel (e.g. using libc structs and
syscall wrappers) which can lead to triggering of a different bug...
