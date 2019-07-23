Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F10AC7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 08:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E70E3223A1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 08:51:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dDyLgy1t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731788AbfGWIvs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 04:51:48 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:40404 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730819AbfGWIvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 04:51:48 -0400
Received: by mail-io1-f67.google.com with SMTP id h6so80122595iom.7
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 01:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jKZWXKcNg9v61aofsNn7pfpi8sojhmIuCOYr5uBtJUg=;
        b=dDyLgy1taxrD1RQdm4eNI7DbTMaTOveTgtYMehR7CdFTrjX1XO8CA+xfe5ohyJWLAU
         Rd9xcdsur+HnbAR5rLAij2rlF6gI1u1tNFGHOMfORwdj6FzeAhrs6UZ0ADqtJgwjTAk7
         Bhe5YMDVH2LcpRqkd/rNORTEgRE/JInjfMSa5cdP+CICGc8uMu6WJucKRy0ZasUYJJGw
         EarEt3cYsqMAjoZtG9B9dZZRJ9lYANPRG64iWrYP+XUAs/PmSq/Ta2qGMIp1TZA7vHJE
         wF6It7t2maBptfOsCxFH/RviFu935z7HOih0Nx/LcFZaS2beai0xXul5BbGRJ0UAtT4h
         ZE3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jKZWXKcNg9v61aofsNn7pfpi8sojhmIuCOYr5uBtJUg=;
        b=nTg0m9OomPjQj+RGIS2tvblpB2R778Z3KjiaAY4TTHgHo1Ue2H0rXzbrmyLJU13Uts
         Q0YnPClMNyVemwh7n87XKvU3SAeuu1MjFkzitSc6/VCX4Qjoz3F8ND/allcKhH7syGI6
         e/nkPiDbj9sxq9Kr15C4PHIiSlxCoInMTQcc+MlaIngu8woGD4yIFB7daskIloe4ExMF
         oRTdeYD9FX8ITMf5HN2ybea6+Yd5SYif2Yz2/344d719v+A/SKu4KxCE2posl/NoDGGb
         kMtX9Xel0NRB0Adbivx20cARnI9r9F6PEE48FxH20hmz30OQG8ZW57ibvQgXKzYIN9Jx
         7m9Q==
X-Gm-Message-State: APjAAAUVDRaBL8Oaqj4UdjHjHRmVcdpKgC7EIDD/5dXol4pJKmmbNUpU
        WxZC/xMh+r/nXUetIHmHDuL1aThVd7+a04POZDiIiw==
X-Google-Smtp-Source: APXvYqywWFoajhq50ncpggzq1ue+aVOnNrhhF9uTgVHieKTwX0+kkYCQEU7rQ44IVmTYd0uj3MNjIRxN3y6hiPzyrMI=
X-Received: by 2002:a5e:c241:: with SMTP id w1mr65555660iop.58.1563871907136;
 Tue, 23 Jul 2019 01:51:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190705191055.GT26519@linux.ibm.com> <20190706042801.GD11665@mit.edu>
 <20190706061631.GV26519@linux.ibm.com> <20190706150226.GG11665@mit.edu>
 <20190706180311.GW26519@linux.ibm.com> <20190707011655.GA22081@linux.ibm.com>
 <CACT4Y+asYe-uH9OV5R0Nkb-JKP4erYUZ68S9gYNnGg6v+fD20w@mail.gmail.com>
 <20190714184915.GK26519@linux.ibm.com> <20190715132911.GG3419@hirez.programming.kicks-ass.net>
 <CACT4Y+bmgdOExBHnLJ+jgWKWQzNK9CFT6_eTxFE3hoK=0YresQ@mail.gmail.com>
 <20190715134651.GI3419@hirez.programming.kicks-ass.net> <CACT4Y+bGgyZWbRQ7QNCHRLU0Zq2+cONSbyaycfzwvToqMwiwBQ@mail.gmail.com>
In-Reply-To: <CACT4Y+bGgyZWbRQ7QNCHRLU0Zq2+cONSbyaycfzwvToqMwiwBQ@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 23 Jul 2019 10:51:35 +0200
Message-ID: <CACT4Y+biWSJvia2rcS9-Q0-GCiaQ9U7Qq=vDA+MY2Gz5mbxTNA@mail.gmail.com>
Subject: Re: INFO: rcu detected stall in ext4_write_checks
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        syzbot <syzbot+4bfbbf28a2e50ab07368@syzkaller.appspotmail.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        David Miller <davem@davemloft.net>, eladr@mellanox.com,
        Ido Schimmel <idosch@mellanox.com>,
        Jiri Pirko <jiri@mellanox.com>,
        John Stultz <john.stultz@linaro.org>,
        linux-ext4@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 12:03 PM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Mon, Jul 15, 2019 at 3:46 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Mon, Jul 15, 2019 at 03:33:11PM +0200, Dmitry Vyukov wrote:
> > > On Mon, Jul 15, 2019 at 3:29 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > > >
> > > > On Sun, Jul 14, 2019 at 11:49:15AM -0700, Paul E. McKenney wrote:
> > > > > On Sun, Jul 14, 2019 at 05:48:00PM +0300, Dmitry Vyukov wrote:
> > > > > > But short term I don't see any other solution than stop testing
> > > > > > sched_setattr because it does not check arguments enough to prevent
> > > > > > system misbehavior. Which is a pity because syzkaller has found some
> > > > > > bad misconfigurations that were oversight on checking side.
> > > > > > Any other suggestions?
> > > > >
> > > > > Keep the times down to a few seconds?  Of course, that might also
> > > > > fail to find interesting bugs.
> > > >
> > > > Right, if syzcaller can put a limit on the period/deadline parameters
> > > > (and make sure to not write "-1" to
> > > > /proc/sys/kernel/sched_rt_runtime_us) then per the in-kernel
> > > > access-control should not allow these things to happen.
> > >
> > > Since we are racing with emails, could you suggest a 100% safe
> > > parameters? Because I only hear people saying "safe", "sane",
> > > "well-behaving" :)
> > > If we move the check to user-space, it does not mean that we can get
> > > away without actually defining what that means.
> >
> > Right, well, that's part of the problem. I think Paul just did the
> > reverse math and figured that 95% of X must not be larger than my
> > watchdog timeout and landed on 14 seconds.
> >
> > I'm thinking 4 seconds (or rather 4.294967296) would be a very nice
> > number.
> >
> > > Now thinking of this, if we come up with some simple criteria, could
> > > we have something like a sysctl that would allow only really "safe"
> > > parameters?
> >
> > I suppose we could do that, something like:
> > sysctl_deadline_period_{min,max}. I'll have to dig back a bit on where
> > we last talked about that and what the problems where.
> >
> > For one, setting the min is a lot harder, but I suppose we can start at
> > TICK_NSEC or something.
>
>
> Now syzkaller will drop CAP_SYS_NICE for the test process:
> https://github.com/google/syzkaller/commit/f3ad68446455acbe562e0057931e6256b8b991e8
> I will close this bug report as invalid once the change reaches all
> syzbot instances, if nobody plans any other on this bug.

#syz invalid
