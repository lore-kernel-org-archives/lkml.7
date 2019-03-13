Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 601FAC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 06:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2603E2070D
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 06:43:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YQV56QKL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbfCMGnv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 02:43:51 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:36123 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727080AbfCMGnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 02:43:51 -0400
Received: by mail-it1-f194.google.com with SMTP id v83so1112279itf.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 23:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h35+BhMsBMD98Yt/fh5izfLu/YmzGEs8dSq2OS0pnco=;
        b=YQV56QKLz9LNlTH4Ug+3k3c+IOs4iG7vFdBroESswQQBoy4vfRnM78qf3zYVm1+0uU
         6841dHE6Sx2h86v/aIQc9gQl6zXpoYoqqQOs3qwbXbgj70RN99SvoRvep+pK1b5C9mOi
         OGNO7HE5pIw3PRdjvXKe0j2u63sgtqsvGJAfnKgqMwWOVW9vnaVKpSkdMIiJVkiixEbR
         NNT5jKzj8k+t9jU+7ztdka3n0SkDUJjtFYmyO+qiap50Th6YG4omtxr42JgskAscbcQe
         u9TzSx9m/nyUHUpU4PUvecucTvaIGsIb3uePKjNfcxuddxBBMGtofMVHyc07VjiH9b3S
         4Q1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h35+BhMsBMD98Yt/fh5izfLu/YmzGEs8dSq2OS0pnco=;
        b=pRWLCrmH+6U12kgzpvzBc6eRSda13rwywy3BD2WeeOxals56pL5ucpiCABybtN8PAC
         MKqSSYtte4X+IFIXP7xNtYi5vjGlUbI5UnuiryzniLI6MqrRqjJwQSA7M6+0SaRAcOKs
         kw84isE03E1iKivMPt53lmk0JF8Ik1KHVIyv09osDZJpX0E5Upc8wYlL+LAa5P/218rz
         LQzRRZsXh2+2LYGxXlzIRkSeqdGq+iWqKiv53N9fu4kzirGC4C5dOVS2l0EdnnH5YAcK
         gKn0NKLlcydv+pWoW4HnmXMmwoMcwBEClA50v4hSRT+fLHR1Q0Lvun2g5mXeR8YHymH6
         2tmA==
X-Gm-Message-State: APjAAAUxtBsCigEXuH1jV5v56/BCeOareOlUaQWwnfaEeyD0t0nvYCWd
        pVFOEXqAttVeG/b4VcXgbXaFycAoRXNpS86GcHF7XQ==
X-Google-Smtp-Source: APXvYqy6v26PV8PtIJ7uAUrL6St2uiAD7oGOge30myrSpHkqPkTu5JAXqgMsA2233BMtrgYLmacj0bgPTUOr+beRU90=
X-Received: by 2002:a24:3b01:: with SMTP id c1mr768525ita.144.1552459429517;
 Tue, 12 Mar 2019 23:43:49 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000010b2fc057fcdfaba@google.com> <0000000000008c75b50583ddb5f8@google.com>
 <20190312040829.GQ2217@ZenIV.linux.org.uk> <491ff1c3-91d6-eaa7-f551-46a4f8b90f5a@i-love.sakura.ne.jp>
 <CACT4Y+ahcZpJ1Q-TKkCJkyhzGc07XFusuwBcKjg_rfAeos8RWA@mail.gmail.com> <92a4e5e5-33ca-7b39-16c0-82c7fb742d18@i-love.sakura.ne.jp>
In-Reply-To: <92a4e5e5-33ca-7b39-16c0-82c7fb742d18@i-love.sakura.ne.jp>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 13 Mar 2019 07:43:38 +0100
Message-ID: <CACT4Y+ZQD=raWY4Tp8nrUcpAAbwRt0D3sH65KrTP+JURtQ3n-Q@mail.gmail.com>
Subject: Re: INFO: rcu detected stall in sys_sendfile64 (2)
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     syzbot <syzbot+1505c80c74256c6118a5@syzkaller.appspotmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 10:11 PM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2019/03/13 2:15, Dmitry Vyukov wrote:
> >> Also, this bisection is finding multiple different crash patterns, which
> >> suggests that the crashed tests are not giving correct feedback to syzbot.
> >
> > Treating different crashes as just "crash" is intended. Kernel bugs
> > can manifest in very different ways.
> > Want fun, search for "bpf: sockhash, disallow bpf_tcp_close and update
> > in parallel" in  https://syzkaller.appspot.com/?fixed=upstream
> > It lead to 50+ different failure modes.
> >
>
> But syzbot already found a rather simple C reproducer
> ( https://syzkaller.appspot.com/text?tag=ReproC&x=116fc7a8c00000 ) for this bug.
> Was this reproducer used for bisection?

The C reproducer used for bisection is provided as "C reproducer" in
the bisection report.

> I guess that if this reproducer was used,
> syzbot did not hit "WARNING: ODEBUG bug in netdev_freemem" cases.

Maybe. But we won't have more than 1 in future. Currently syzbot
bisects over a backlog of crashes, some of them accumulated multiple
reproducers over weeks/months/years. When it will bisect newly
reported bugs as they are found, there will be only 1 reproducer. E.g.
these two for this bug were found within a month.

> Also, humans can sometimes find more simpler C reproducers from syzbot provided
> reproducers. It would be nice if syzbot can accept and use a user defined C
> reproducer for testing.

It would be more useful to accept patches that make syzkaller create
better reproducers from these people. Manual work is not scalable. We
would need 10 reproducers per day for a dozen of OSes (incl some
private kernels/branches). Anybody is free to run syzkaller manually
and do full manual (perfect) reporting. But for us it become clear
very early that it won't work. Then see above, while that human is
sleeping/on weekend/vacation, syzbot will already bisect own
reproducer. Adding manual reproducer later won't help in any way.
syzkaller already does lots of smart work for reproducers. Let's not
give up on the last mile and switch back to all manual work.
