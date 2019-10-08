Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DEDAC10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 12:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 628B72070B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 12:13:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oGwprOSq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730875AbfJHMNQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 08:13:16 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45747 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730495AbfJHMNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 08:13:15 -0400
Received: by mail-lf1-f68.google.com with SMTP id r134so11732458lff.12
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 05:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s7TeC0T6RMo+DV5zh9VGnRky/RxVHf7djwfKldi77Gs=;
        b=oGwprOSq5uz0buXavhPbkUipjj/ItbAMGFUGIPOh10w9N8Gnqc42IezXixm8chw3H2
         crtjZsQREUEI/3yZL/BeupvL5yrikuSn5Aqap+q6Y+rcjeYHlN0DB1eiAXe+MXnjAoj/
         5yGuwF42l+mXJYKo007U0z1DdDw62+PPFQK/BRnlcewVjWluIKVQ7nulB1TxK3x1nJE6
         yO8VoFDIV29yT2lGpgrHq9sDJD0l/8l9E7qK53dF+pQnlROEllIEmCOdcUheoWt69vkk
         jG7c+VSdlcba7aYT2qiyWFcQ0VXsJwckmvNVJ6eb3O2UihBRmtMVrs+VRkeTC6bcxdra
         a7Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s7TeC0T6RMo+DV5zh9VGnRky/RxVHf7djwfKldi77Gs=;
        b=cZcYaI9IbeyE45fAycRH10Sr3YdEA8hef3HOBkYlDkoevzFCBV35rBFjcG7jnMNShK
         F95QDHoa5jjhGsMj5IngTMxVT3IeANLCRP4zOJ2ioph/9vE87l+v0g39LjDubHh0+S/W
         JHp+GdF33MuL/x4pHqdFNM8QdxYv01ooeSut8heEThR2DwW2dvfjLNjqcgAjZyX1MZ8u
         SG+TiqHTyf2kfJcs19Gy5p4bLV3B8EMaRVrFNupKlTEmr0yjvt18EJ228NocX8c1TvMN
         2UCoY61AlflVW8hzreBktvuwFS6g+ejHARnrnwxfwvk+MeeelP+7DYt+LJy+o+YFdF8t
         KmjQ==
X-Gm-Message-State: APjAAAUwAa6OeNb0Z6RDTN15GQzVAPBJcR6JFQFSgHnTzoS+Shg/5JFB
        Vq+94NrOlUi+h8kzXWBO603plG8A6O9njfma69Y=
X-Google-Smtp-Source: APXvYqyrQX9V0JZiEZV1yLj/7lxYzAanBWIVNkK+zpCKLDTDECN56fnvhrrCy9Z0CwYY6HBW+WU5DVNODpskazCdjec=
X-Received: by 2002:a05:6512:50f:: with SMTP id o15mr4783830lfb.149.1570536792731;
 Tue, 08 Oct 2019 05:13:12 -0700 (PDT)
MIME-Version: 1.0
References: <CADkTA4PBT374CY+UNb85WjQEaNCDodMZu=MgpG8aMYbAu2eOGA@mail.gmail.com>
 <20191002020100.GA6436@castle.dhcp.thefacebook.com> <CADkTA4Mbai=Q5xgKH9-md_g73UsHiKnEauVgMWev+-sG8FVNSA@mail.gmail.com>
 <20191002181914.GA7617@castle.DHCP.thefacebook.com> <CADkTA4PmGBR7YdOXvi6sEDJ+uztuB7x2G95TCcW2u_iqjwhUNQ@mail.gmail.com>
 <20191004000913.GA5519@castle.DHCP.thefacebook.com> <CADkTA4OJok3cmYCcDKtxBXQ5xtK1EMujh7_AgLnVaeRr18TH9w@mail.gmail.com>
 <CADkTA4PKc6VEQYvXk4-EWMJPyOrzWQEsk4p6O_BMFo6kvT2jYg@mail.gmail.com> <20191007232754.GB11171@tower.DHCP.thefacebook.com>
In-Reply-To: <20191007232754.GB11171@tower.DHCP.thefacebook.com>
From:   Bruce Ashfield <bruce.ashfield@gmail.com>
Date:   Tue, 8 Oct 2019 08:13:01 -0400
Message-ID: <CADkTA4NKDn4jd2BQaGk+JEnM3B5GMDudsBi6V4YwK3Soq9q9pA@mail.gmail.com>
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

On Mon, Oct 7, 2019 at 7:28 PM Roman Gushchin <guro@fb.com> wrote:
>
> On Mon, Oct 07, 2019 at 04:11:07PM -0400, Bruce Ashfield wrote:
> > On Mon, Oct 7, 2019 at 8:54 AM Bruce Ashfield <bruce.ashfield@gmail.com> wrote:
> > >
> > > On Thu, Oct 3, 2019 at 8:09 PM Roman Gushchin <guro@fb.com> wrote:
> > > >
> > > > On Wed, Oct 02, 2019 at 05:59:36PM -0400, Bruce Ashfield wrote:
> > > > > On Wed, Oct 2, 2019 at 2:19 PM Roman Gushchin <guro@fb.com> wrote:
> > > > > >
> > > > > > On Wed, Oct 02, 2019 at 12:18:54AM -0400, Bruce Ashfield wrote:
> > > > > > > On Tue, Oct 1, 2019 at 10:01 PM Roman Gushchin <guro@fb.com> wrote:
> > > > > > > >
> > > > > > > > On Tue, Oct 01, 2019 at 12:14:18PM -0400, Bruce Ashfield wrote:
> > > > > > > > > Hi all,
> > > > > > > > >
> > > > > > > >
> > > > > > > > Hi Bruce!
> > > > > > > >
> > > > > > > > > The Yocto project has an upcoming release this fall, and I've been trying to
> > > > > > > > > sort through some issues that are happening with kernel 5.2+ .. although
> > > > > > > > > there is a specific yocto kernel, I'm testing and seeing this with
> > > > > > > > > normal / vanilla
> > > > > > > > > mainline kernels as well.
> > > > > > > > >
> > > > > > > > > I'm running into an issue that is *very* similar to the one discussed in the
> > > > > > > > > [REGRESSION] ptrace broken from "cgroup: cgroup v2 freezer" (76f969e)
> > > > > > > > > thread from this past may: https://lkml.org/lkml/2019/5/12/272
> > > > > > > > >
> > > > > > > > > I can confirm that I have the proposed fix for the initial regression report in
> > > > > > > > > my build (05b2892637 [signal: unconditionally leave the frozen state
> > > > > > > > > in ptrace_stop()]),
> > > > > > > > > but yet I'm still seeing 3 or 4 minute runtimes on a test that used to take 3 or
> > > > > > > > > 4 seconds.
> > > > > > > >
> > > > > > > > So, the problem is that you're experiencing a severe performance regression
> > > > > > > > in some test, right?
> > > > > > >
> > > > > > > Hi Roman,
> > > > > > >
> > > > > > > Correct. In particular, running some of the tests that ship with strace itself.
> > > > > > > The performance change is so drastic, that it definitely makes you wonder
> > > > > > > "What have I done wrong? Since everyone must be seeing this" .. and I
> > > > > > > always blame myself first.
> > > > > > >
> > > > > > > >
> > > > > > > > >
> > > > > > > > > This isn't my normal area of kernel hacking, so I've so far come up empty
> > > > > > > > > at either fixing it myself, or figuring out a viable workaround. (well, I can
> > > > > > > > > "fix" it by remove the cgroup_enter_frozen() call in ptrace_stop ...
> > > > > > > > > but obviously,
> > > > > > > > > that is just me trying to figure out what could be causing the issue).
> > > > > > > > >
> > > > > > > > > As part of the release, we run tests that come with various applications. The
> > > > > > > > > ptrace test that is causing us issues can be boiled down to this:
> > > > > > > > >
> > > > > > > > > $ cd /usr/lib/strace/ptest/tests
> > > > > > > > > $ time ../strace -o log -qq -esignal=none -e/clock ./printpath-umovestr>ttt
> > > > > > > > >
> > > > > > > > > (I can provide as many details as needed, but I wanted to keep this initial
> > > > > > > > > email relatively short).
> > > > > > > > >
> > > > > > > > > I'll continue to debug and attempt to fix this myself, but I grabbed the
> > > > > > > > > email list from the regression report in May to see if anyone has any ideas
> > > > > > > > > or angles that I haven't covered in my search for a fix.
> > > > > > > >
> > > > > > > > I'm definitely happy to help, but it's a bit hard to say anything from what
> > > > > > > > you've provided. I'm not aware of any open issues with the freezer except
> > > > > > > > some spurious cgroup frozen<->not frozen transitions which can happen in some
> > > > > > > > cases. If you'll describe how can I reproduce the issue, and I'll try to take
> > > > > > > > a look asap.
> > > > > > >
> > > > > > > That would be great.
> > > > > > >
> > > > > > > I'll attempt to remove all of the build system specifics out of this
> > > > > > > (and Richard Purdie
> > > > > > > on the cc' of this can probably help provide more details / setup info as well).
> > > > > > >
> > > > > > > We are running the built-in tests of strace. So here's a cut and paste of what I
> > > > > > > did to get the tests available (ignore/skip what is common sense or isn't needed
> > > > > > > in your test rig).
> > > > > > >
> > > > > > > % git clone https://github.com/strace/strace.git
> > > > > > > % cd strace
> > > > > > > % ./bootstrap
> > > > > > > # the --enable flag isn't strictly required, but may break on some
> > > > > > > build machines
> > > > > > > % ./configure --enable-mpers=no
> > > > > > > % make
> > > > > > > % make check-TESTS
> > > > > > >
> > > > > > > That last step will not only build the tests, but run them all .. so
> > > > > > > ^c the run once
> > > > > > > it starts, since it is a lot of noise (we carry a patch to strace that
> > > > > > > allows us to build
> > > > > > > the tests without running them).
> > > > > > >
> > > > > > > % cd tests
> > > > > > > % time strace -o log -qq -esignal=none -e/clock ./printpath-umovestr > fff
> > > > > > > real    0m2.566s
> > > > > > > user    0m0.284s
> > > > > > > sys     0m2.519
> > > > > > >
> > > > > > > On pre-cgroup2 freezer kernels, you see a run time similar to what I have above.
> > > > > > > On the newer kernels we are testing, it is taking 3 or 4 minutes to
> > > > > > > run the test.
> > > > > > >
> > > > > > > I hope that is simple enough to setup and try. Since I've been seeing
> > > > > > > this on both
> > > > > > > mainline kernels and the yocto reference kernels, I don't think it is
> > > > > > > something that
> > > > > > > I'm carrying in the distro/reference kernel that is causing this (but
> > > > > > > again, I always
> > > > > > > blame myself first). If you don't see that same run time, then that
> > > > > > > does point the finger
> > > > > > > back at what we are doing and I'll have to apologize for chewing up some of your
> > > > > > > time.
> > > > > >
> > > > > > Thank you for the detailed description!
> > > > > > I'll try to reproduce the issue and will be back
> > > > > > by the end of the week.
> > > > >
> > > > > Thanks again!
> > > > >
> > > > > While discussing the issue with a few yocto folks today, it came up that
> > > > > someone wasn't seeing the same behaviour on the opensuse v5.2 kernel
> > > > > (but I've yet to figure out exactly where to find that tree) .. but when I do,
> > > > > I'll try and confirm that and will look for patches or config differences that
> > > > > could explain the results.
> > > > >
> > > > > I did confirm that 5.3 shows the same thing today, and I'll do a 5.4-rc1 test
> > > > > tomorrow.
> > > > >
> > > > > We are also primarily reproducing the issue on qemux86-64, so I'm also
> > > > > going to try and rule out qemu (but the same version of qemu with just
> > > > > the kernel changing shows the issue).
> > > >
> > > > Hi Bruce!
> > > >
> > > > I've tried to follow your steps, but unfortunately failed to reproduce the issue.
> > > > I've executed the test on my desktop running 5.2 and cgroup v1 (Fedora 30),
> > > > and also a qemu vm with vanilla 5.1 and 5.3 and cgroup v2 mounted by default.
> > > > In all cases the test execution time was about 4.5 seconds.
> > >
> > > Hi Roman,
> > >
> > > Thanks for the time you spent on this. I had *thought* that I ruled out my
> > > config before posting .. but clearly, it is either not my config or something
> > > else in the environment.
> > >
> > > >
> > > > Looks like something makes your setup special. If you'll provide your
> > > > build config, qemu arguments or any other configuration files, I can try
> > > > to reproduce it on my side.
> > >
> > > Indeed. I'm going to dive back in and see what I can find. If I can
> > > find something
> > > that is reproducible in a completely different environment and easy to configure
> > > components, I'll follow up with details.
> > >
> > > When I figure out what is going on with the config here, I'll follow up as well,
> > > so the solution can be captured in any archives.
> >
> > Actually, now that I think about it.
> >
> > Would it be possible to see the .config that you used for testing (and even how
> > you launched the VM) ?.
> >
> > I just built a 5.2.17 kernel and the long runtimes persist here. I'm not seeing
> > anything in my .config that is jumping out, and am now looking at how we are
> > launching qemu .. but it would be helpful to have a known good baseline for
> > comparison.
> >
> > If you've already tossed that config, no worries, I'll muddle along
> > and figure it
> > out eventually.
>
> Hi Bruce!
>
> Can you, please, try to reproduce it on a fresh Fedora (or any other public
> distro) installation? I've tried to reproduce it on my Fedora 30 running 5.2,
> and wasn't successful.

That was my plan today. I'll fire up a new VM and run the test there as well
(after which, I can pull the .config myself).

Richard: (not sure if you are still reading these) .. do we have any easily
accessible images that we could share that show the problem ? If not, that
is probably something I can look into for the future.

>
> Thanks!
>
> PS I don't have that particular config by me now, will try to find and send
> to you.

I can report that I was able to see the problem again on a freshly cloned
linux-stable 5.2.17 yesterday. When I pulled in the x86_64_defconfig, the
test time went to ~4 seconds.

So I've been looking through the config delta's and late last night, I was
able to move the runtime back to a failed 4 minute state by adding the
CONFIG_PREEMPT settings that we have by default in our reference
kernel.

# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
CONFIG_PREEMPT=y
CONFIG_PREEMPT_COUNT=y
CONFIG_PREEMPT_RCU=y
CONFIG_DEBUG_PREEMPT=y
# CONFIG_PREEMPTIRQ_EVENTS is not set
# CONFIG_PREEMPT_TRACER is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set

Where in the x86_64_defconfig, it was PREEMPT_VOLUNTARY. I
only ran this test late last night, so I haven't had a chance to see what
else changed in the config, or compare it to fedora or other default
configurations .. but I thought it was still useful to share that finding.

Bruce



-- 
- Thou shalt not follow the NULL pointer, for chaos and madness await
thee at its end
- "Use the force Harry" - Gandalf, Star Trek II
