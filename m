Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0851EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 10:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C93D32075D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 10:11:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h0eAQJ1t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731172AbfCZKLb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 06:11:31 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:34044 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbfCZKLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 06:11:31 -0400
Received: by mail-it1-f193.google.com with SMTP id l4so2384478ite.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 03:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xmEwjK6q+d5zUPkyRUG8lAHrpxBSqSUrJuNg8YUWIbE=;
        b=h0eAQJ1tFQhCQNnnYfmtD8kGQcbiowqKDly7ZksN8OHLI6GJM642Z244VEvqhl3/EI
         gXIIwibjqVKd8KnQVzW93hucScKgaU85F0ILdqR42S7B+gPxxRTVKm+w3lfHz7V9bZrp
         RQFs7q0on+qh9KU/626kv0qdhUg0Xa5nyG8qqoDzMlQ8soa/liu9uhvol50H+QaanU5T
         idaXC4uoDCHmhtvJpq+zxREXFGEdNnsvHDvgJ6RbxN+8MZSdAzpiaOlcYyPBhHBlU3m7
         ipOicjboUcl0LVCIjSzQ2v/N+3a84uGgI9H774p+35aCMnXeVwkDdEINSy3GuVsxqe8b
         2Wbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xmEwjK6q+d5zUPkyRUG8lAHrpxBSqSUrJuNg8YUWIbE=;
        b=OQZxMqt9StOtnQItRH6IYkELn5Ej35gbfKmDd28EWbdzEgz35bcDxUH1fLxe7lmV+h
         lM7mopKuV4lSct7H7s9BdTId4IYyaRfkj2O9L86M/HLjN5Y8WjuYIWAmclHVbseEfOLG
         5P3ioIl6a2jfOKjgAyTmK8+FfnBpUYmVZU0rBmCPFr9rK8yGQNLx2vO6P0IbDBsjLZZr
         Akybn3Iq4gWj6yHIuotkzBVgPFbzRMfncu3Mm9EOQlKHzwLDlm1KSBfsUxGT+Bv3pRah
         0JXmFdg6Sa2s6bCULO4coc61bdteuNyZLlCk62u4beXUEQ5DEXJfFLhBf+c+6YDuolrz
         fRTw==
X-Gm-Message-State: APjAAAUqwaWbCjyK2fBRBlSX4eMvuEkDB9f9/vzdF2WXiW202lnB1oP+
        +DbGAsr7irAXC7tftPyBX+NNNXULwCv2abR+2mBsjQ==
X-Google-Smtp-Source: APXvYqxFBTS8Y0kphZc8fPBB0fBkg79BIHxtFotfYAPpUUHiss3qoq2mIepG9CydUJo+ByTqvdkIwW4o/1tbeFOaTnY=
X-Received: by 2002:a24:9a86:: with SMTP id l128mr2831273ite.12.1553595089448;
 Tue, 26 Mar 2019 03:11:29 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000958aa50584c851b7@google.com> <alpine.DEB.2.21.1903240058290.1798@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1903240058290.1798@nanos.tec.linutronix.de>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 26 Mar 2019 11:11:18 +0100
Message-ID: <CACT4Y+a3R+MBu207hU=tHa2JZKd6HPUDfLZFET-eMi-GRJdPfA@mail.gmail.com>
Subject: Re: BUG: soft lockup in kvm_vm_release
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     syzbot <syzbot+6349a512c2938b2ad058@syzkaller.appspotmail.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 24, 2019 at 1:04 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Sat, 23 Mar 2019, syzbot wrote:
>
> > syzbot has bisected this bug to:
> >
> > commit 80eb865768703c0f85a0603762742ae1dedf21f0
> > Author: Andrea Parri <andrea.parri@amarulasolutions.com>
> > Date:   Tue Nov 27 11:01:10 2018 +0000
> >
> >    sched/fair: Clean up comment in nohz_idle_balance()
>
> I.m pretty sure that this bisect is bogus. The commit changes a comment not
> code.
>
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1362209b200000
> > start commit:   57902dc0 Merge tag 'riscv-for-linus-5.0-rc7' of git://git...
> > git tree:       upstream
> > final crash:    https://syzkaller.appspot.com/x/report.txt?x=10e2209b200000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=1762209b200000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=ee434566c893c7b1
> > dashboard link: https://syzkaller.appspot.com/bug?extid=6349a512c2938b2ad058
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14287e78c00000
> >
> > Reported-by: syzbot+6349a512c2938b2ad058@syzkaller.appspotmail.com
> > Fixes: 80eb86576870 ("sched/fair: Clean up comment in nohz_idle_balance()")
> >
> > For information about bisection process see: https://goo.gl/tpsmEJ#bisection
>
> If I understand that correctly, then the bisect does not try to revert the
> commit which it identified on top of the tree where it started to bisect.
>
> I think that'd be a reasonably simple to do extra data point, at least when
> the commit reverts cleanly on head.

Hi Thomas,

Interesting. You mean revert on the start commit and check if kernel
still crashes?

I've got several suggestions on how some results can be tentatively
marked as "suspicious". But the question is: if we mark a result as
"suspicious", what then? How should reporting be different or what?
If syzbot does not report bisection results, people start complaining
"why there are no bisection results?"; "why didn't syzbot just bisect
it to find the right people to CC?"; or even that this does not count
as a bug report without bisection.
So we are kind of between 2 fires here.
And this test will have false positives too. I can see at least 3
common reasons for this:
 - reproducer triggering 2+ bugs at the same time
 - unrelated kernel bug that triggers of simple programs, or fires
episodically on random programs
 - if we found the right commit and it itself fixes a bug in the
subsystem, then we will now hit that bug instead
So in a sense we will just add more flakiness on top of flakiness,
potentially making the whole thing even more nonsensical. E.g. we can
find the right commit, but then say that it's wrong.

But I am adding this to
https://github.com/google/syzkaller/issues/1051 where I am collecting
all feedback/ideas re bisection.
