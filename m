Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0AEEC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 08:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF43120856
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 08:47:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mtqzapGg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731252AbfCZIrU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 04:47:20 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43893 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbfCZIrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 04:47:19 -0400
Received: by mail-ed1-f65.google.com with SMTP id d26so9967265ede.10
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 01:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mSiF7vv/ICkOOs2atuxNV8P+283yzDdQteOHr9WGdbQ=;
        b=mtqzapGg27sbSw238r8jX2eAtRDVOwL886QMh/umG+DHknomWFEPQ3dkcotHHDMEqA
         6ZvGNji9XUdVYAhF+omP/SIQBTiE9Ev65UjEv4KpRAaSpM8w90glbPhrmqN7YaaYXDRO
         Sl2WTjD+y/7DBt6iOSm0MAsbDHfM88v2YyzgVKlxOllnQNLLb5Ro6GqKuXG+es24hViJ
         fzFS+E5X4t8VbchTkwz1+vooBB1gob4U4IiVRk0yOLHWbt3N/SC04neVwoG2wH7LDf1B
         eyg3mM71iFVz/mS8BZvD75R55DdcTi8w5n2FJkjHRyj3Y4fsB9BqZobCbkUUCBmI6Vq7
         BZIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mSiF7vv/ICkOOs2atuxNV8P+283yzDdQteOHr9WGdbQ=;
        b=A2gi8d+rRDJtanWKORo7ETPYNYlmZil/9XZ4DCVrukwcl+vOsg4t0F9izOfe34s72a
         AFx8kRoBSQmZ6wBXZNClG6vnVaxkXZ3OmT2fotGdbT7NIA1Xy7Q278hUatmBdrvuL8PZ
         XChFlizkJZtuOU1PfbMlXCwBXbpctWVweUtVThyJ5tpOI53xI6PwALP/8R52a09E99Rt
         v1FTR0BmXKVJOlyFTEoRCYu5mP02GDrnTTwexntgEovMGRInyr47pRIzqfmFsrfITTsE
         Q14H/mHqVeK+rWToYhEPkKS6TuAfD2rSlttNfqO3arHoFpaz+9R+YnlFAIhVi8dyHoIs
         WxOA==
X-Gm-Message-State: APjAAAWi2m/3NWO3FcFnPMpOBLlj7Wdt4GFcCgwtQxx7M849hBvxwcsL
        ZlaROGjpv3XHTJr1elPJQcl5cd0Zet4m05d/4HRZXg==
X-Google-Smtp-Source: APXvYqynPskeWVOYbnrpTHZQH/qdQ8Ko+HQt8PY6/1fQxiWrXsEPk+d+q80ko/9/7wMABvieJlZpYW8O01iop/Ade14=
X-Received: by 2002:aa7:c250:: with SMTP id y16mr15997587edo.238.1553590037272;
 Tue, 26 Mar 2019 01:47:17 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000004eade9057ba76eae@google.com> <621f7c52-de52-eb35-bf61-e839adee7ec9@colorfullife.com>
 <CACT4Y+ZStCdg6NhyYAtUZS07NWR=oJzdTZxpD+uyr=3SAVSmVw@mail.gmail.com>
 <3c159449-bcf9-759a-271c-4d4dd6f63802@colorfullife.com> <CACT4Y+YR_zvrS4tDTeZ6hy5HCzgiaZG8TLTUPgRMZHdxnpJP2w@mail.gmail.com>
In-Reply-To: <CACT4Y+YR_zvrS4tDTeZ6hy5HCzgiaZG8TLTUPgRMZHdxnpJP2w@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 26 Mar 2019 09:47:05 +0100
Message-ID: <CACT4Y+Z73E_tLPbPk9gmy0GCTPoJwv9tvA-HPSVBXBVmmKRfeg@mail.gmail.com>
Subject: Re: BUG: corrupted list in freeary
To:     manfred <manfred@colorfullife.com>
Cc:     syzbot <syzbot+c92d3646e35bc5d1a909@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        LKML <linux-kernel@vger.kernel.org>, linux@dominikbrodowski.net,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 3, 2018 at 3:53 PM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Sat, Dec 1, 2018 at 9:22 PM Manfred Spraul <manfred@colorfullife.com> wrote:
> >
> > Hi Dmitry,
> >
> > On 11/30/18 6:58 PM, Dmitry Vyukov wrote:
> > > On Thu, Nov 29, 2018 at 9:13 AM, Manfred Spraul
> > > <manfred@colorfullife.com> wrote:
> > >> Hello together,
> > >>
> > >> On 11/27/18 4:52 PM, syzbot wrote:
> > >>
> > >> Hello,
> > >>
> > >> syzbot found the following crash on:
> > >>
> > >> HEAD commit:    e195ca6cb6f2 Merge branch 'for-linus' of git://git.kernel...
> > >> git tree:       upstream
> > >> console output: https://syzkaller.appspot.com/x/log.txt?x=10d3e6a3400000
> > [...]
> > >> Isn't this a kernel stack overrun?
> > >>
> > >> RSP: 0x..83e008. Assuming 8 kB kernel stack, and 8 kB alignment, we have
> > >> used up everything.
> > > I don't exact answer, that's just the kernel output that we captured
> > > from console.
> > >
> > > FWIW with KASAN stacks are 16K:
> > > https://elixir.bootlin.com/linux/latest/source/arch/x86/include/asm/page_64_types.h#L10
> > Ok, thanks. And stack overrun detection is enabled as well -> a real
> > stack overrun is unlikely.
> > > Well, generally everything except for kernel crashes is expected.
> > >
> > > We actually sandbox it with memcg quite aggressively:
> > > https://github.com/google/syzkaller/blob/master/executor/common_linux.h#L2159
> > > But it seems to manage to either break the limits, or cause some
> > > massive memory leaks. The nature of that is yet unknown.
> >
> > Is it possible to start from that side?
> >
> > Are there other syzcaller runs where the OOM killer triggers that much?
>
> Lots of them:
>
> https://groups.google.com/forum/#!searchin/syzkaller-upstream-moderation/lowmem_reserve
> https://groups.google.com/forum/#!searchin/syzkaller-bugs/lowmem_reserve
>
> But nobody got any hook on the reasons.
>
>
> > >> - Which stress tests are enabled? By chance, I found:
> > >>
> > >> [  433.304586] FAULT_INJECTION: forcing a failure.^M
> > >> [  433.304586] name fail_page_alloc, interval 1, probability 0, space 0,
> > >> times 0^M
> > >> [  433.316471] CPU: 1 PID: 19653 Comm: syz-executor4 Not tainted 4.20.0-rc3+
> > >> #348^M
> > >> [  433.323841] Hardware name: Google Google Compute Engine/Google Compute
> > >> Engine, BIOS Google 01/01/2011^M
> > >>
> > >> I need some more background, then I can review the code.
> > > What exactly do you mean by "Which stress tests"?
> > > Fault injection is enabled. Also random workload from userspace.
> > >
> > >
> > >> Right now, I would put it into my "unknown syzcaller finding" folder.
> >
> > One more idea: Are there further syzcaller runs that end up with
> > 0x010000 in a pointer?
>
> Hard to say. syzbot triggered millions of crashes. I can't say that I
> remember this as distinctive pattern that come up before.
>
> >  From what I see, the sysv sem code that is used is trivial, I don't see
> > that it could cause the observed behavior.
>
> I propose that we postpone further investigation of this until we have
> a reproducer, or this happens more than once, or we gather some other
> information.
> Half of bugs are simple, so even for a crash happened once it makes
> sense to spend 10 minutes looking at the code in case the root cause
> is easy to spot. And hundreds of bugs were fixed this way. But I
> assume you already did this.
> The thing is that there are 100+ known bugs in kernel that lead to
> memory corruptions:
> https://syzkaller.appspot.com/#upstream-open
> We try to catch them reliably with KASAN, but KASAN does not give 100%
> guarantee. So if just one instance of a known bug gets unnoticed,
> leads to a memory corruption, then later it can lead to an
> unexplainable one-off crash like this. At this point higher ROI will
> probably be from spending more time on hundreds of other known bugs
> that have reproducers, happened lots of times, or just simpler. Once
> we get rid of most of them, hopefully such unexplainable crashes will
> go down too.

The working hypothesis for this bug is as follows.

semget provokes OOMs. OOMs now cause kernel stack overflow/corruption
in wb_workfn. So semget is kinda red herring.
Since we now sandbox tests processes with sem sysctl and friends, I
think we can close this report.

#syz invalid

Though the kernel memory corruption on OOMs is still there.
