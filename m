Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C869EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 13:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87A702184E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 13:45:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HF1aUfWt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbfCTNpf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 09:45:35 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:41789 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfCTNpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 09:45:34 -0400
Received: by mail-io1-f66.google.com with SMTP id v10so1987033iom.8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 06:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4Ui5Z2Y9i7YA4CETRzH+AC0PBYmRpqXus5Qh1WWz9e0=;
        b=HF1aUfWtCkvOx3n1QOA/VkhsTvyV/YvROQsppizZFRP3VjlbU/sDsXaGk6J8M3OnsM
         WRuPNfgdGamMAuBcxxgrQS3OAuGqCHEKLIb3LPt9P5zM6ZKcPtiH5Q9ngyUzkcHEvrVu
         NeW7DPIsDm87SkSppA8I7W1ON8CjKFxAmcRdcd2fPBqP9hyPIxfu4fsGupLzt4JnAZz9
         F8kI4FzUc2e/srJXoBxmeRBGCcM2QrXu7fGoqdoP4Uf0QOjSxmRiIbEm8kkWywQ3g6Um
         eY78mEt4NTBOcU65W9YKs0YBZ84ue2tHYaBDUVhOppBeV0dhzD15I3EyodJuQRKlfkG2
         A1UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4Ui5Z2Y9i7YA4CETRzH+AC0PBYmRpqXus5Qh1WWz9e0=;
        b=Zlu7VO+LNqf8pYQ382ZyxHCC+Pa5nL0o8KcDSsS5gpuYRiLnl92HE3IRuDRkF2bsvO
         KqU7xzQlWCjMW4tPyVi8vrxlFvW8jwTegPeJ2xyYH/j8Gfllxm8YgbU2M+tG7axkhQWI
         MwCV/GG/HdiVQQ8qlP+9yxNaXCn6MGfU1UfpHMrEYE0O0E+sFqqlfDF2zAW88DbdQFMP
         qV34OGCNb4ZM8/bA7SMv7CZuSy8p/CXUqVikaZFfSAaaOnj9TI8rXMkoXYFwjkiTr01X
         /h8p/UQheNVDMWbBzvBNJvEFl9VAivjPtx8qqcHDFnoaGiWcDbUtgkdy1AzOBjRIj9aC
         4v0g==
X-Gm-Message-State: APjAAAVxH/TVv/NrE6YMN9YSaU+YqzzFWvMppx4cYZYkHrAhJibBnMXQ
        A80B04RGJmJTgXkAQ9H0u8cnexyMAU7t23EiTj81hA==
X-Google-Smtp-Source: APXvYqyTZnx3lozsEUjlYC3EDtMbkXmoPGaK5O01o/bbrvA25oQ8oFZFRXEAKbHZMyH36LcewFcpXJNeNBnVMoRWbLY=
X-Received: by 2002:a5d:834a:: with SMTP id q10mr5049522ior.271.1553089533428;
 Wed, 20 Mar 2019 06:45:33 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000010b2fc057fcdfaba@google.com> <0000000000008c75b50583ddb5f8@google.com>
 <20190312040829.GQ2217@ZenIV.linux.org.uk> <491ff1c3-91d6-eaa7-f551-46a4f8b90f5a@i-love.sakura.ne.jp>
 <CACT4Y+ahcZpJ1Q-TKkCJkyhzGc07XFusuwBcKjg_rfAeos8RWA@mail.gmail.com>
 <92a4e5e5-33ca-7b39-16c0-82c7fb742d18@i-love.sakura.ne.jp>
 <CACT4Y+ZQD=raWY4Tp8nrUcpAAbwRt0D3sH65KrTP+JURtQ3n-Q@mail.gmail.com>
 <20190313234040.GH10169@gmail.com> <f3e25790-4edd-9e77-f656-e41d7a992945@i-love.sakura.ne.jp>
In-Reply-To: <f3e25790-4edd-9e77-f656-e41d7a992945@i-love.sakura.ne.jp>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 20 Mar 2019 14:45:19 +0100
Message-ID: <CACT4Y+ZoA55zAvnhEakjJvg_QCXKnAP4-CpOBQjS6Yv71puskA@mail.gmail.com>
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


Problem 1 (smaller). Neither providing custom program nor manually
specifying bisection range (as you suggested in another thread
https://groups.google.com/d/msg/syzkaller-bugs/nFeC8-UG1gg/1OTVIuzBAgAJ)
won't make kernel bug bisection reliable. The problems with kernel
bisection are deeper. Consider a bug that is inherently hard to
trigger, even if one provides own reproducer it's still hard to
trigger and bisection can diverge. What happened in the other bug:
bisection diverged because the reproducer triggered another bug. Now
consider that this happens within the bisection range. Even if you
give own range, it won't help. And there are lots of other problems
like, say, large ranges where kernel build is broken.
And this will introduce own problems: e.g. it's very easy to give
syzbot a reproducer that actually don't not trigger the bug for it
(because you can't match its environment precisely).
Also: if you can't bisect locally and can't test, how do you know the
right range generally? Again that one bug was a single corner case.
Also: semi-manual process will also lead to some suboptimal results,
and then other kernel developers will come and ask questions and
somebody will need to answer these questions. But in this case syzbot
is not even accountable for what happened.
I don't think there is a simple substitution for a qualified engineer
doing its job (guiding each step of bisection manually).
It's possible to imagine a very complex workflow (super hard to
implement, test and maintain too) that will allow to do that. And it
becomes mostly offloading build/boot/test of a given configuration to
the cloud. And this brings this us to the second problem.

Problem 2. What you are proposing effectively looks like some kind of
custom workload offloading service for kernel developers. Just instead
of console commands (raw cloud VMs) it has somewhat higher level
interface (e.g. here is kernel config, compiler, command line,
sysctls, machine configuration and test case, go build and test it).
I don't think this should be bolted on top of syzbot.
Developing and running syzbot is already a _huge_ amount of work
(frequently ungrateful). I simply cannot take on developing, testing,
deploying, maintaining and operating another service. And that service
will involve much more complex human interactions, so will be much
more complex overall.
If such service is provided I think it needs to run on Linux
Foundation infrastructure that runs CI and other testing. Yes, I know,
it does not exist. But that would be the right place. It would benefit
work on all other kernel bugs too. Lots of things people attribute to
syzbot are really not specific to syzbot in anyway. For example that
service would help with bisection of all other bugs too. And it seems
that a much simpler solution would be just to provide free VMs for
developers, because you main points seems to be "I would like to do
something custom, but I don't have resources for that". This is out of
scope for syzbot.
The current syzbot scope is: automating as much as possible, solving
common cases at scale (including other OSes and kernel branches),
bringing developers enough information to pick up the bug from there
and do any custom work necessary to debug and fix the bug (there
always will be custom work! even perfect bisection can get you nowhere
re root causing and there are still bugs without reproducers). We can
solve some surrounding problems too _iff_ they are common enough, have
high bang for the buck, reasonably easy to implement and don't cause
long-term maintenance toll. This one does not look like such problem.
Sorry.
