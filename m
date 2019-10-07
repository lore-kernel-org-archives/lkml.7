Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4844ECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 12:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8A9021721
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 12:54:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jfd94PeK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbfJGMy0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 08:54:26 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37950 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728235AbfJGMyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 08:54:23 -0400
Received: by mail-lj1-f194.google.com with SMTP id b20so13525999ljj.5
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 05:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XYCbCK3D33RbRqp+80xDSdT8pyVogdmhLycJBaZ2cDI=;
        b=Jfd94PeK8CA2IyFwpY+m/dIC0eO/tqer8Txp3M+goe6ik0mx4soa6Axj7GE3RBomCR
         eXxiySzjufruT7uqng6ib2yRmV3SpcrJGr7OqGDtZrA8lONZ4+EOIa4BnT5zE89TVTeQ
         piC/0IhchciRnE4lI5lMdfndzlV2XT9t+HnL9sGwaEVnn+UAloQh4D+iM0gsFelrdLB2
         Zq1eBmspK2FW3wlkjRlQyNjalVR2LHTR2Nr/EZZnA3hFfJI7iCJJG9Qgosv08Wj8VsbN
         7YHvyLkGbO79m5niS6m7a8weTMuNlYxu/Q38QOxaHRpIvSEx3lmre1uwr7//o4DsGUZW
         pJ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XYCbCK3D33RbRqp+80xDSdT8pyVogdmhLycJBaZ2cDI=;
        b=Xi/CylxeH1TMU2VYxlEPvG+i6w0/o/OaUlP+IMvDxCWwNWqV4sRx294jp2W+zxtfNr
         SlaED6y6ZT5JhNycLiZeGkagSHvhaZsojkMAMKLtRtboEkBYdE83baZhxDvuwSvFS+y8
         88wpYJYGENGbCeuZ1Idv6PPSekzfdlwxJD7hMl7ICWytOnFdYM4nJGrlO+SaZqRHf44r
         b2sN32Ly0sPfa+XN3C+IfrACg1UfqHipoUNAWKdyuKhhBVXb9cBOCTMUtqHK9Q4rY1Z1
         r8WF4kTqrzyfeR/q960C3hNJeRk0sFoc+GloQYIPTNvfQuVv7eDmumoyEuBvBBIDx5pY
         WSgw==
X-Gm-Message-State: APjAAAXdDuh5Hg3UYFTd4Vev5rUGu+cV5L8pCa0EB879aT5LeywlCgIZ
        5bkFZXgD+TfcioGWI4h1nsPeq1XmVcHazM9EEQE9AqZj
X-Google-Smtp-Source: APXvYqxLRH+JmIZIQvgfKwrBKE8dDuw8GwCX71X/OMdD0YA4HrCjIT0Ebl6+5rVjWXHsQr0V6KJ7Am7uj6RvkEGOzIM=
X-Received: by 2002:a2e:8645:: with SMTP id i5mr16045361ljj.32.1570452860506;
 Mon, 07 Oct 2019 05:54:20 -0700 (PDT)
MIME-Version: 1.0
References: <CADkTA4PBT374CY+UNb85WjQEaNCDodMZu=MgpG8aMYbAu2eOGA@mail.gmail.com>
 <20191002020100.GA6436@castle.dhcp.thefacebook.com> <CADkTA4Mbai=Q5xgKH9-md_g73UsHiKnEauVgMWev+-sG8FVNSA@mail.gmail.com>
 <20191002181914.GA7617@castle.DHCP.thefacebook.com> <CADkTA4PmGBR7YdOXvi6sEDJ+uztuB7x2G95TCcW2u_iqjwhUNQ@mail.gmail.com>
 <20191004000913.GA5519@castle.DHCP.thefacebook.com>
In-Reply-To: <20191004000913.GA5519@castle.DHCP.thefacebook.com>
From:   Bruce Ashfield <bruce.ashfield@gmail.com>
Date:   Mon, 7 Oct 2019 08:54:08 -0400
Message-ID: <CADkTA4OJok3cmYCcDKtxBXQ5xtK1EMujh7_AgLnVaeRr18TH9w@mail.gmail.com>
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

On Thu, Oct 3, 2019 at 8:09 PM Roman Gushchin <guro@fb.com> wrote:
>
> On Wed, Oct 02, 2019 at 05:59:36PM -0400, Bruce Ashfield wrote:
> > On Wed, Oct 2, 2019 at 2:19 PM Roman Gushchin <guro@fb.com> wrote:
> > >
> > > On Wed, Oct 02, 2019 at 12:18:54AM -0400, Bruce Ashfield wrote:
> > > > On Tue, Oct 1, 2019 at 10:01 PM Roman Gushchin <guro@fb.com> wrote:
> > > > >
> > > > > On Tue, Oct 01, 2019 at 12:14:18PM -0400, Bruce Ashfield wrote:
> > > > > > Hi all,
> > > > > >
> > > > >
> > > > > Hi Bruce!
> > > > >
> > > > > > The Yocto project has an upcoming release this fall, and I've been trying to
> > > > > > sort through some issues that are happening with kernel 5.2+ .. although
> > > > > > there is a specific yocto kernel, I'm testing and seeing this with
> > > > > > normal / vanilla
> > > > > > mainline kernels as well.
> > > > > >
> > > > > > I'm running into an issue that is *very* similar to the one discussed in the
> > > > > > [REGRESSION] ptrace broken from "cgroup: cgroup v2 freezer" (76f969e)
> > > > > > thread from this past may: https://lkml.org/lkml/2019/5/12/272
> > > > > >
> > > > > > I can confirm that I have the proposed fix for the initial regression report in
> > > > > > my build (05b2892637 [signal: unconditionally leave the frozen state
> > > > > > in ptrace_stop()]),
> > > > > > but yet I'm still seeing 3 or 4 minute runtimes on a test that used to take 3 or
> > > > > > 4 seconds.
> > > > >
> > > > > So, the problem is that you're experiencing a severe performance regression
> > > > > in some test, right?
> > > >
> > > > Hi Roman,
> > > >
> > > > Correct. In particular, running some of the tests that ship with strace itself.
> > > > The performance change is so drastic, that it definitely makes you wonder
> > > > "What have I done wrong? Since everyone must be seeing this" .. and I
> > > > always blame myself first.
> > > >
> > > > >
> > > > > >
> > > > > > This isn't my normal area of kernel hacking, so I've so far come up empty
> > > > > > at either fixing it myself, or figuring out a viable workaround. (well, I can
> > > > > > "fix" it by remove the cgroup_enter_frozen() call in ptrace_stop ...
> > > > > > but obviously,
> > > > > > that is just me trying to figure out what could be causing the issue).
> > > > > >
> > > > > > As part of the release, we run tests that come with various applications. The
> > > > > > ptrace test that is causing us issues can be boiled down to this:
> > > > > >
> > > > > > $ cd /usr/lib/strace/ptest/tests
> > > > > > $ time ../strace -o log -qq -esignal=none -e/clock ./printpath-umovestr>ttt
> > > > > >
> > > > > > (I can provide as many details as needed, but I wanted to keep this initial
> > > > > > email relatively short).
> > > > > >
> > > > > > I'll continue to debug and attempt to fix this myself, but I grabbed the
> > > > > > email list from the regression report in May to see if anyone has any ideas
> > > > > > or angles that I haven't covered in my search for a fix.
> > > > >
> > > > > I'm definitely happy to help, but it's a bit hard to say anything from what
> > > > > you've provided. I'm not aware of any open issues with the freezer except
> > > > > some spurious cgroup frozen<->not frozen transitions which can happen in some
> > > > > cases. If you'll describe how can I reproduce the issue, and I'll try to take
> > > > > a look asap.
> > > >
> > > > That would be great.
> > > >
> > > > I'll attempt to remove all of the build system specifics out of this
> > > > (and Richard Purdie
> > > > on the cc' of this can probably help provide more details / setup info as well).
> > > >
> > > > We are running the built-in tests of strace. So here's a cut and paste of what I
> > > > did to get the tests available (ignore/skip what is common sense or isn't needed
> > > > in your test rig).
> > > >
> > > > % git clone https://github.com/strace/strace.git
> > > > % cd strace
> > > > % ./bootstrap
> > > > # the --enable flag isn't strictly required, but may break on some
> > > > build machines
> > > > % ./configure --enable-mpers=no
> > > > % make
> > > > % make check-TESTS
> > > >
> > > > That last step will not only build the tests, but run them all .. so
> > > > ^c the run once
> > > > it starts, since it is a lot of noise (we carry a patch to strace that
> > > > allows us to build
> > > > the tests without running them).
> > > >
> > > > % cd tests
> > > > % time strace -o log -qq -esignal=none -e/clock ./printpath-umovestr > fff
> > > > real    0m2.566s
> > > > user    0m0.284s
> > > > sys     0m2.519
> > > >
> > > > On pre-cgroup2 freezer kernels, you see a run time similar to what I have above.
> > > > On the newer kernels we are testing, it is taking 3 or 4 minutes to
> > > > run the test.
> > > >
> > > > I hope that is simple enough to setup and try. Since I've been seeing
> > > > this on both
> > > > mainline kernels and the yocto reference kernels, I don't think it is
> > > > something that
> > > > I'm carrying in the distro/reference kernel that is causing this (but
> > > > again, I always
> > > > blame myself first). If you don't see that same run time, then that
> > > > does point the finger
> > > > back at what we are doing and I'll have to apologize for chewing up some of your
> > > > time.
> > >
> > > Thank you for the detailed description!
> > > I'll try to reproduce the issue and will be back
> > > by the end of the week.
> >
> > Thanks again!
> >
> > While discussing the issue with a few yocto folks today, it came up that
> > someone wasn't seeing the same behaviour on the opensuse v5.2 kernel
> > (but I've yet to figure out exactly where to find that tree) .. but when I do,
> > I'll try and confirm that and will look for patches or config differences that
> > could explain the results.
> >
> > I did confirm that 5.3 shows the same thing today, and I'll do a 5.4-rc1 test
> > tomorrow.
> >
> > We are also primarily reproducing the issue on qemux86-64, so I'm also
> > going to try and rule out qemu (but the same version of qemu with just
> > the kernel changing shows the issue).
>
> Hi Bruce!
>
> I've tried to follow your steps, but unfortunately failed to reproduce the issue.
> I've executed the test on my desktop running 5.2 and cgroup v1 (Fedora 30),
> and also a qemu vm with vanilla 5.1 and 5.3 and cgroup v2 mounted by default.
> In all cases the test execution time was about 4.5 seconds.

Hi Roman,

Thanks for the time you spent on this. I had *thought* that I ruled out my
config before posting .. but clearly, it is either not my config or something
else in the environment.

>
> Looks like something makes your setup special. If you'll provide your
> build config, qemu arguments or any other configuration files, I can try
> to reproduce it on my side.

Indeed. I'm going to dive back in and see what I can find. If I can
find something
that is reproducible in a completely different environment and easy to configure
components, I'll follow up with details.

When I figure out what is going on with the config here, I'll follow up as well,
so the solution can be captured in any archives.

Thanks again,

Bruce

>
> Thanks!
>
> Roman



-- 
- Thou shalt not follow the NULL pointer, for chaos and madness await
thee at its end
- "Use the force Harry" - Gandalf, Star Trek II
