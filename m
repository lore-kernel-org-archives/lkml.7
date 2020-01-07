Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67DDDC33C9E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 13:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B0102080A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 13:03:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rw+2W7Xo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbgAGNDB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 08:03:01 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:39584 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727814AbgAGNDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 08:03:00 -0500
Received: by mail-qk1-f194.google.com with SMTP id c16so42515867qko.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 05:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cdaq2aRk52TxqNNR8RvwrJcuJacllXaozsgHajXcAbo=;
        b=Rw+2W7XoVqLtdYJ5l5cbHD35TNMp1sIqX+cqVJ713sIGHCQ2deVpZmIwDDc0xJfiDV
         Wo2NKsIJc8uEugos40O++P3Hd0sA86V0x2RtUiB+iZwinQdbdtqoSYr1jDDZwlbT7oqt
         r6gYZ/T9grL9Yjh69TyYkPZJYVjhCbQlPb4c/nLNGJD3d1hgzhWN+54zxkquF9ZqI6jn
         ETqjhj7ZzJNc7dfv/wcozuhsW154q1SR6WEZmLThTFOzaSFVzzT02prFNhcI1pNEMDpP
         W52g9QKY2IQmPO1aHWDfaF0Thf6BSxfk2Pn7Vj82ut96EHitAwPkYeJQXl11QyLzzLgA
         itbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cdaq2aRk52TxqNNR8RvwrJcuJacllXaozsgHajXcAbo=;
        b=RLuVXEKTEx4KYdl1VY99bTQnpoNP1tmbwKqMHl9efRua9xShg99FKkJdCEr7vuQin4
         /7b2kmaThDDpL+e1Xbz8NXnPJtNmCagmwoEEtHKjwY9d0HagQfjPrh5j8qPU8EEgHqKV
         jFX8yVANJJHlI/27LFy6nIcJEOMB0Q6iept5TD3/eKxsugjnu4rTC474qG6KnKzSWqjw
         P2gAoidxeTvnaOfn8uDJfQM6yA6kOd8nJcP3Yj00J1lMdTUt144IrVWwkuizlXFKuB87
         CRuVJGh8NXSOCZkkM1Nn78vRVfVBHC7nRkhLcc0TPGTrBLE8eW3ABE1u+MxILDb2FApV
         obQw==
X-Gm-Message-State: APjAAAV8UXfyEsNzRYRQL+UhgEiSpUwETX3q+RiSerJZGowMsIItXCm+
        2T0EBsKGWDFU6YmBqmALrZqmvr6ODaUIah++0JPi1W619BY=
X-Google-Smtp-Source: APXvYqwMn/uO+eqVUldCKfwNFNt+RFx/DbF7n9TC+5lLcAgn57ILY+sgX2fPETnR3Ko9uZGVyMezXuuf7svl0SuVHI0=
X-Received: by 2002:ae9:e50c:: with SMTP id w12mr80253441qkf.407.1578402179268;
 Tue, 07 Jan 2020 05:02:59 -0800 (PST)
MIME-Version: 1.0
References: <000000000000e728ec057d5c9d90@google.com> <a5478450-f975-228f-1ca6-886a45b654a1@I-love.SAKURA.ne.jp>
 <CACT4Y+YqWgZZFXdX2A2jVYEdHfY9ywGMgRRP5W4Uqdu__rA63g@mail.gmail.com> <bc53fe0b-2c17-4d4f-1c40-f290997d0521@i-love.sakura.ne.jp>
In-Reply-To: <bc53fe0b-2c17-4d4f-1c40-f290997d0521@i-love.sakura.ne.jp>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 7 Jan 2020 14:02:47 +0100
Message-ID: <CACT4Y+bEi9ZsJn0Jm2Lwt-1cijQq=wc5MqYh0qf6R6+wpZVD2Q@mail.gmail.com>
Subject: Re: INFO: rcu detected stall in sys_sendfile64
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     syzbot <syzbot+bcad772bbc241b4c6147@syzkaller.appspotmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        James Morris <jmorris@namei.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 4, 2020 at 12:09 PM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2018/12/20 3:42, Dmitry Vyukov wrote:
> > On Wed, Dec 19, 2018 at 11:13 AM Tetsuo Handa
> > <penguin-kernel@i-love.sakura.ne.jp> wrote:
> >>
> >> On 2018/12/19 18:27, syzbot wrote:
> >>> HEAD commit:    ddfbab46539f Merge tag 'scsi-fixes' of git://git.kernel.or..
> >>> git tree:       upstream
> >>> console output: https://syzkaller.appspot.com/x/log.txt?x=15b87fa3400000
> >>> kernel config:  https://syzkaller.appspot.com/x/.config?x=861a3573f4e78ba1
> >>> dashboard link: https://syzkaller.appspot.com/bug?extid=bcad772bbc241b4c6147
> >>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> >>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13912ccd400000
> >>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=145781db400000
> >>
> >> This is not a LSM problem, for the reproducer is calling
> >> sched_setattr(SCHED_DEADLINE) with very large values.
> >>
> >>   sched_setattr(0, {size=0, sched_policy=0x6 /* SCHED_??? */, sched_flags=0, sched_nice=0, sched_priority=0, sched_runtime=2251799813724439, sched_deadline=4611686018427453437, sched_period=0}, 0) = 0
> >>
> >> I think that this problem is nothing but an insane sched_setattr() parameter.
> >>
> >> #syz invalid
> >
> > Note there was another one with sched_setattr, which turned out to be
> > some serious problem in kernel (sched_setattr should not cause CPU
> > stall for 3 minutes):
> > INFO: rcu detected stall in do_idle
> > https://syzkaller.appspot.com/bug?extid=385468161961cee80c31
> > https://groups.google.com/forum/#!msg/syzkaller-bugs/crrfvusGtwI/IoD_zus4BgAJ
> >
> > Maybe it another incarnation of the same bug, that one is still not fixed.
> >
>
> Can we let syzbot blacklist sched_setattr() for now? There are many stall reports
> doing sched_setattr(SCHED_RR) which makes it difficult to find stall reports not
> using sched_setattr().

Hi Tetsuo,

If we start practice of disabling whole syscalls, I would really like
"for now" to be very well defined. When will it end? How will it
happen? Is the problem on the radar of relevant people? Will it stay
on somebody's radar until it's fixed? Normal practise of project
sheriffing is to file a P1 bug assigned to somebody when something
gets disabled. But I am not sure how we implement this for kernel.
Since the problem is there for a long time and we disable it without
defining any criteria, I afraid we disable it forever (then more bugs
will pile and re-enabling it will be painful). At the very least we
need to acknowledge that we stopping testing schedler for foreseeable
future and schedler maintainers need to be notified about this.
Blacklisting it and un-blacklisting will cause some churn. Was the bug
given at least some attention? Significant number of bugs are
relatively easy to fix and fixing it would solve all of the problems
in a much better way.
