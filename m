Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 281CBC4360C
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 21:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE90020842
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 21:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ra54M5jq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbfJBV7v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 17:59:51 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38976 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727818AbfJBV7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 17:59:51 -0400
Received: by mail-lf1-f67.google.com with SMTP id 72so223051lfh.6
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 14:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5vzSux9eQKxJFF9GRNL8OortCb//QnofpEzbbxkuctE=;
        b=Ra54M5jqFtuH94od5Ka7bDqh25FpHc3nVnYPZRs8I3Y0C8fFqpUchmN8+rNEtvqB92
         PXgW2L3tMOunKrQAoBtmp5Yy/EvcmMDKbdEe6fV8hBcs+iKg3g9YWc/vby6KgBonpJyM
         hTcAwuciZnbcFvRs6h0b228r6IDKsLYvegnQKkm7hFn9Uak7tlCSL40EiBkNN4G1FmIa
         BF+rYyjdNXoK4uRXx/gthtzOOuSbaqyVeTPQ+5kAbzWuEkTjDmXo1CDsL+MG89F58BfL
         0Trqp805S+AAN8GHOBYfSr1pnXQFJrCJMRhy6b4mytoYyA4Y23f5QfsnH5DDupFG5Icm
         Yu8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5vzSux9eQKxJFF9GRNL8OortCb//QnofpEzbbxkuctE=;
        b=UfNqrN0lylHBhOnaW954WiSwTo0hQvmsPJSKfHn2HImvtN4ZiNnyIsKoMPc7itzWuu
         IKrHIray1Ry/pMFgA7s7nmIK9TruhJZ95ju9d2UIWOKF/PEasOqoQwXAkvlT9XZrGv0z
         twPVxy0MYIVD/TFDoPYk773i5LJT4QFP4oItil2ktspxOr3axOios9c7ya9nnt2QMtQb
         NSSKGiD1nA9nDw3Fq8//4W2YxOBQTAXMIXYax3Ja8L+oPMu741HxwbDE3vpEwlIWJpqk
         N/Mzsb0D3guaaBC/C3k5DYrMVsXYyIhq67wo3VCQdkDkI3d3nB1t5dpTNxx0cwcpShjm
         bNVA==
X-Gm-Message-State: APjAAAVuJQJIGYuSEPv7KVhuL9BbCCVDxuVFCb/yxGIgJsb79U1EJEX/
        W2iQPsBddslhLCSjBFhum2fomN3Z7xGD150v3sPsDUSoCSOarg==
X-Google-Smtp-Source: APXvYqzpHTdtzstQ7/aG1r2T4ZNucopug1JAYDvlX47NOST/EJWbQndDIvxJiGN2+f29gwor8k+1jyY4XED5po0KGBY=
X-Received: by 2002:a19:c80b:: with SMTP id y11mr3820786lff.184.1570053588707;
 Wed, 02 Oct 2019 14:59:48 -0700 (PDT)
MIME-Version: 1.0
References: <CADkTA4PBT374CY+UNb85WjQEaNCDodMZu=MgpG8aMYbAu2eOGA@mail.gmail.com>
 <20191002020100.GA6436@castle.dhcp.thefacebook.com> <CADkTA4Mbai=Q5xgKH9-md_g73UsHiKnEauVgMWev+-sG8FVNSA@mail.gmail.com>
 <20191002181914.GA7617@castle.DHCP.thefacebook.com>
In-Reply-To: <20191002181914.GA7617@castle.DHCP.thefacebook.com>
From:   Bruce Ashfield <bruce.ashfield@gmail.com>
Date:   Wed, 2 Oct 2019 17:59:36 -0400
Message-ID: <CADkTA4PmGBR7YdOXvi6sEDJ+uztuB7x2G95TCcW2u_iqjwhUNQ@mail.gmail.com>
Subject: Re: ptrace/strace and freezer oddities and v5.2+ kernels
To:     Roman Gushchin <guro@fb.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tj@kernel.org" <tj@kernel.org>,
        Richard Purdie <richard.purdie@linuxfoundation.org>,
        "oleg@redhat.com" <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 2, 2019 at 2:19 PM Roman Gushchin <guro@fb.com> wrote:
>
> On Wed, Oct 02, 2019 at 12:18:54AM -0400, Bruce Ashfield wrote:
> > On Tue, Oct 1, 2019 at 10:01 PM Roman Gushchin <guro@fb.com> wrote:
> > >
> > > On Tue, Oct 01, 2019 at 12:14:18PM -0400, Bruce Ashfield wrote:
> > > > Hi all,
> > > >
> > >
> > > Hi Bruce!
> > >
> > > > The Yocto project has an upcoming release this fall, and I've been trying to
> > > > sort through some issues that are happening with kernel 5.2+ .. although
> > > > there is a specific yocto kernel, I'm testing and seeing this with
> > > > normal / vanilla
> > > > mainline kernels as well.
> > > >
> > > > I'm running into an issue that is *very* similar to the one discussed in the
> > > > [REGRESSION] ptrace broken from "cgroup: cgroup v2 freezer" (76f969e)
> > > > thread from this past may: https://lkml.org/lkml/2019/5/12/272
> > > >
> > > > I can confirm that I have the proposed fix for the initial regression report in
> > > > my build (05b2892637 [signal: unconditionally leave the frozen state
> > > > in ptrace_stop()]),
> > > > but yet I'm still seeing 3 or 4 minute runtimes on a test that used to take 3 or
> > > > 4 seconds.
> > >
> > > So, the problem is that you're experiencing a severe performance regression
> > > in some test, right?
> >
> > Hi Roman,
> >
> > Correct. In particular, running some of the tests that ship with strace itself.
> > The performance change is so drastic, that it definitely makes you wonder
> > "What have I done wrong? Since everyone must be seeing this" .. and I
> > always blame myself first.
> >
> > >
> > > >
> > > > This isn't my normal area of kernel hacking, so I've so far come up empty
> > > > at either fixing it myself, or figuring out a viable workaround. (well, I can
> > > > "fix" it by remove the cgroup_enter_frozen() call in ptrace_stop ...
> > > > but obviously,
> > > > that is just me trying to figure out what could be causing the issue).
> > > >
> > > > As part of the release, we run tests that come with various applications. The
> > > > ptrace test that is causing us issues can be boiled down to this:
> > > >
> > > > $ cd /usr/lib/strace/ptest/tests
> > > > $ time ../strace -o log -qq -esignal=none -e/clock ./printpath-umovestr>ttt
> > > >
> > > > (I can provide as many details as needed, but I wanted to keep this initial
> > > > email relatively short).
> > > >
> > > > I'll continue to debug and attempt to fix this myself, but I grabbed the
> > > > email list from the regression report in May to see if anyone has any ideas
> > > > or angles that I haven't covered in my search for a fix.
> > >
> > > I'm definitely happy to help, but it's a bit hard to say anything from what
> > > you've provided. I'm not aware of any open issues with the freezer except
> > > some spurious cgroup frozen<->not frozen transitions which can happen in some
> > > cases. If you'll describe how can I reproduce the issue, and I'll try to take
> > > a look asap.
> >
> > That would be great.
> >
> > I'll attempt to remove all of the build system specifics out of this
> > (and Richard Purdie
> > on the cc' of this can probably help provide more details / setup info as well).
> >
> > We are running the built-in tests of strace. So here's a cut and paste of what I
> > did to get the tests available (ignore/skip what is common sense or isn't needed
> > in your test rig).
> >
> > % git clone https://github.com/strace/strace.git
> > % cd strace
> > % ./bootstrap
> > # the --enable flag isn't strictly required, but may break on some
> > build machines
> > % ./configure --enable-mpers=no
> > % make
> > % make check-TESTS
> >
> > That last step will not only build the tests, but run them all .. so
> > ^c the run once
> > it starts, since it is a lot of noise (we carry a patch to strace that
> > allows us to build
> > the tests without running them).
> >
> > % cd tests
> > % time strace -o log -qq -esignal=none -e/clock ./printpath-umovestr > fff
> > real    0m2.566s
> > user    0m0.284s
> > sys     0m2.519
> >
> > On pre-cgroup2 freezer kernels, you see a run time similar to what I have above.
> > On the newer kernels we are testing, it is taking 3 or 4 minutes to
> > run the test.
> >
> > I hope that is simple enough to setup and try. Since I've been seeing
> > this on both
> > mainline kernels and the yocto reference kernels, I don't think it is
> > something that
> > I'm carrying in the distro/reference kernel that is causing this (but
> > again, I always
> > blame myself first). If you don't see that same run time, then that
> > does point the finger
> > back at what we are doing and I'll have to apologize for chewing up some of your
> > time.
>
> Thank you for the detailed description!
> I'll try to reproduce the issue and will be back
> by the end of the week.

Thanks again!

While discussing the issue with a few yocto folks today, it came up that
someone wasn't seeing the same behaviour on the opensuse v5.2 kernel
(but I've yet to figure out exactly where to find that tree) .. but when I do,
I'll try and confirm that and will look for patches or config differences that
could explain the results.

I did confirm that 5.3 shows the same thing today, and I'll do a 5.4-rc1 test
tomorrow.

We are also primarily reproducing the issue on qemux86-64, so I'm also
going to try and rule out qemu (but the same version of qemu with just
the kernel changing shows the issue).

I just wanted to add those data points in case that strace test doesn't
reproduce the problem for you. I'll follow up if I learn anything more during
my debug on Thursday.

Bruce

>
> Thank you!
>
> Roman



-- 
- Thou shalt not follow the NULL pointer, for chaos and madness await
thee at its end
- "Use the force Harry" - Gandalf, Star Trek II
