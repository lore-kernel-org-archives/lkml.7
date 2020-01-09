Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C94C32771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 10:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0459A20656
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 10:59:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PXIZJXWg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730492AbgAIK7i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 05:59:38 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35001 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728635AbgAIK7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 05:59:37 -0500
Received: by mail-qk1-f194.google.com with SMTP id z76so5558174qka.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 02:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dCNOcIvcdKs5VnegyeyX0voUYsS8MT1fv2QnGIGtFeg=;
        b=PXIZJXWgB9pqyWBTYsCQeatEYlOikQeEY2u3jun0UEbnKKJjr4NnNjKXhN0t++c/k9
         rrNyekbDvEj0z9SWw05LZ3nc1LeunA6+iNV4dQtAV0q5ijf/2Ko/QpfIkLNbkFdFPJnG
         scLo5fdzuNAeHRU78GoSa5uYRjFLF3oHqrRnecdB8JYHlWUwkZRAS6LLq0E3N3M53ZKg
         0+oCwW+s2kdo6mG6pd2Amdas9nyYlA5MTehIi4eAlsxawfSB5Hkt6HajPMf1cn71qEI6
         KrtVDzQdjayB+dNoXdUdFoKSOWGKw3/2Lh2IHscwRIwS/voDXKAHvdLn+gSvMF52yxbx
         GaFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dCNOcIvcdKs5VnegyeyX0voUYsS8MT1fv2QnGIGtFeg=;
        b=LO5TAdKYidEFxXSUwot2HFXb2Ic+CGcYGTVThysG7XWqmeqDvUfB5zt0cB3tueST+s
         7KaxRDuOIT8C8zt371A9jUCuswvVYpNL/G8kJ9cZrAHXkM0zWgt3t8e+YqIKB4WfanTm
         WDj58/3213YXRAAisuLnhEnc3+WgrxtcRturyWviGR48BueVgCVA2AhPx8uv93b1fITX
         AstVu0l2ZCjfhxCXROU6NLNnn/+iFQyX1UXJsU8RqjruUaHKdS6SPNSd/nhhB6PqmFnN
         Y7I8tC4sOo79WzvstRHpqiNhh4ldG4elmTQoixr1sU0kXQLLjo0Cyyjzku/6b/wKZUPU
         KuWQ==
X-Gm-Message-State: APjAAAVtHA7qhlLcgQUTOKOJSBpvmUTIcCwmkVBWpPCkpO03QUJUwtRk
        vhXC+wbd5Xo+GDMeaPZDJLp7hJk8+UJ9XK0ZPuUbKQ==
X-Google-Smtp-Source: APXvYqxCy9yDe3ceogRt2g5I1KXrmKwVZZ2Ot53tqeDlGj1eolEGmxHyyCEhqetjz5bZepQwdUDGehh124dz9QxD+AM=
X-Received: by 2002:a37:5841:: with SMTP id m62mr8705070qkb.256.1578567576238;
 Thu, 09 Jan 2020 02:59:36 -0800 (PST)
MIME-Version: 1.0
References: <0000000000007523a60576e80a47@google.com> <CACT4Y+b3AmVQMjPNsPHOXRZS4tNYb6Z9h5-c=1ZwZk0VR-5J5Q@mail.gmail.com>
 <20180928070042.GF3439@hirez.programming.kicks-ass.net> <CACT4Y+YFmSmXjs5EMNRPvsR-mLYeAYKypBppYq_M_boTi8a9uQ@mail.gmail.com>
In-Reply-To: <CACT4Y+YFmSmXjs5EMNRPvsR-mLYeAYKypBppYq_M_boTi8a9uQ@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 9 Jan 2020 11:59:25 +0100
Message-ID: <CACT4Y+ZBYYUiJejNbPcZWS+aHehvkgKkTKm0gvuviXGGcirJ5g@mail.gmail.com>
Subject: Re: BUG: MAX_LOCKDEP_CHAINS too low!
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     syzbot <syzbot+aaa6fa4949cc5d9b7b25@syzkaller.appspotmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 9:56 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> >> > Hello,
> >> >
> >> > syzbot found the following crash on:
> >> >
> >> > HEAD commit:    c307aaf3eb47 Merge tag 'iommu-fixes-v4.19-rc5' of git://gi..
> >> > git tree:       upstream
> >> > console output: https://syzkaller.appspot.com/x/log.txt?x=13810df1400000
> >> > kernel config:  https://syzkaller.appspot.com/x/.config?x=dfb440e26f0a6f6f
> >> > dashboard link: https://syzkaller.appspot.com/bug?extid=aaa6fa4949cc5d9b7b25
> >> > compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> >> >
> >> > Unfortunately, I don't have any reproducer for this crash yet.
> >> >
> >> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> >> > Reported-by: syzbot+aaa6fa4949cc5d9b7b25@syzkaller.appspotmail.com
> >>
> >> +LOCKDEP maintainers,
> >>
> >> What does this BUG mean? And how should it be fixed?
> >>
> >> Thanks
> >>
> >> > BUG: MAX_LOCKDEP_CHAINS too low!
> >
> > Is the his result of endlessly loading and unloading modules?
> >
> > In which case, the fix is: don't do that then.
>
> No modules involved, we don't have any modules in the image. Must be
> something else.
> Perhaps syzkaller just produced a workload so diverse that nobody ever produced.

Peter, Ingo,

This really plagues syzbot testing for more than a year now. These four:

BUG: MAX_LOCKDEP_KEYS too low!
https://syzkaller.appspot.com/bug?id=8a18efe79140782a88dcd098808d6ab20ed740cc

BUG: MAX_LOCKDEP_ENTRIES too low!
https://syzkaller.appspot.com/bug?id=3d97ba93fb3566000c1c59691ea427370d33ea1b

BUG: MAX_LOCKDEP_CHAINS too low!
https://syzkaller.appspot.com/bug?id=bf037f4725d40a8d350b2b1b3b3e0947c6efae85

BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!
https://syzkaller.appspot.com/bug?id=381cb436fe60dc03d7fd2a092b46d7f09542a72a


Now running testing I only see a stream of different lockdep bugs mostly:

2020/01/09 11:41:51 vm-13: crash: BUG: MAX_LOCKDEP_ENTRIES too low!
2020/01/09 11:43:09 vm-9: crash: INFO: task hung in register_netdevice_notifier
2020/01/09 11:44:00 vm-26: crash: no output from test machine
2020/01/09 11:44:11 vm-8: crash: BUG: MAX_LOCKDEP_ENTRIES too low!
2020/01/09 11:44:28 vm-19: crash: BUG: MAX_LOCKDEP_ENTRIES too low!
2020/01/09 11:46:20 vm-27: crash: BUG: MAX_LOCKDEP_ENTRIES too low!
2020/01/09 11:46:41 vm-15: crash: BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!
2020/01/09 11:46:45 vm-28: crash: BUG: MAX_LOCKDEP_ENTRIES too low!
2020/01/09 11:46:47 vm-29: crash: BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!
2020/01/09 11:46:49 vm-22: crash: BUG: MAX_LOCKDEP_ENTRIES too low!
2020/01/09 11:46:50 vm-10: crash: no output from test machine
2020/01/09 11:46:52 vm-18: crash: BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!
2020/01/09 11:46:53 vm-23: crash: BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!
2020/01/09 11:47:17 vm-20: crash: lost connection to test machine
2020/01/09 11:47:48 vm-5: crash: BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!
2020/01/09 11:47:56 vm-14: crash: WARNING in restore_regulatory_settings
2020/01/09 11:48:19 vm-2: crash: BUG: MAX_LOCKDEP_ENTRIES too low!
2020/01/09 11:48:21 vm-7: crash: BUG: MAX_LOCKDEP_ENTRIES too low!
2020/01/09 11:48:22 vm-3: crash: BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!
2020/01/09 11:48:40 vm-25: crash: BUG: MAX_LOCKDEP_CHAINS too low!

Should we just bump the limits there?

Or are there some ID leaks in lockdep? syzbot has a bunch of very
simple reproducers for these bugs, so not really a maximally diverse
load. And I think I saw these bugs massively when testing just a
single subsystem too, e.g. netfilter.
