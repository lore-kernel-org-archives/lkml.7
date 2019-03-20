Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20920C10F05
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 11:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2BCB2186A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 11:33:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="mRAEamYd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbfCTLd5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 07:33:57 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36980 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbfCTLd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 07:33:56 -0400
Received: by mail-qt1-f193.google.com with SMTP id z16so572843qtn.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 04:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=d4Z5Mqmi4LJpbgIxofUDgn3+z5lt3XVSz/v98zM6dGA=;
        b=mRAEamYdksjPsuTT3gCoilF0nl1WVeaMZxrp1TGoeVeQ2DV/jRTfE84LyIcdoznqET
         1JMcsEKSvlvTNUOo4WathfgwTJMeKT2I7E8FU4K5gKtP7VYRExdXFSSyLq4DyQo4J9+0
         AWCC6EAjjQKAtdovCCY6NFWpZHC98Dq7Nlu3o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=d4Z5Mqmi4LJpbgIxofUDgn3+z5lt3XVSz/v98zM6dGA=;
        b=RqcL4s/ENn0FYbUBRDVxIORTOwLHSaexeAeWDYrJnOrCERRruanes/r4TWd2yGmeFE
         PySHQ6bPMxZ5TJ4KTGc2CpNGtw+uAT+pAohRmu4ghlaoyC/b4mAyhCPEMZvgAs2HcNDC
         66pVRN67pOugr/RI1VUq6dj39V0PHuC9ORwLqOUWriDwfJUe3Gto2MdOQRMqlEjc7jIg
         iQLzvo/65nRmwHVDmd/NANh/mNetaj79HnsU/G87s5Jj8/ozG9f1tdQXDpgj/tw9UJRX
         SBw5UZ8Eiz94xSgCgWHuNn71nhEcBcA9k0MCs3Qak0xt6d9WdcWOZ6uYn+fl2uYAIX8h
         DWIw==
X-Gm-Message-State: APjAAAUsT8Wxg7BrIU0s3nZX19dTloOtDZAq3JZMH7KhbB4CWDKrRinT
        gxfOJPWvhuydqNYAQFx3bxqarw==
X-Google-Smtp-Source: APXvYqzkMfTtf1uGPNkRoUzX4rFJebsuzIDcrB0bSeB6XFbGSXfe+v9DxOGTZ1whbs3Rlygi+TBr6w==
X-Received: by 2002:a0c:9e9a:: with SMTP id r26mr6005557qvd.57.1553081635138;
        Wed, 20 Mar 2019 04:33:55 -0700 (PDT)
Received: from [192.168.0.109] (c-73-216-90-110.hsd1.va.comcast.net. [73.216.90.110])
        by smtp.gmail.com with ESMTPSA id 91sm912671qtf.62.2019.03.20.04.33.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 04:33:54 -0700 (PDT)
Date:   Wed, 20 Mar 2019 07:33:51 -0400
User-Agent: K-9 Mail for Android
In-Reply-To: <CAKOZuet3-VhmC3oHtEbPPvdiar_k_QXTf0TkgmH9LiwmW-_oNA@mail.gmail.com>
References: <20190317015306.GA167393@google.com> <20190317114238.ab6tvvovpkpozld5@brauner.io> <CAKOZuetZPhqQqSgZpyY0cLgy0jroLJRx-B93rkQzcOByL8ih_Q@mail.gmail.com> <20190318002949.mqknisgt7cmjmt7n@brauner.io> <20190318235052.GA65315@google.com> <20190319221415.baov7x6zoz7hvsno@brauner.io> <CAKOZuessqcjrZ4rfGLgrnOhrLnsVYiVJzOj4Aa=o3ZuZ013d0g@mail.gmail.com> <20190319231020.tdcttojlbmx57gke@brauner.io> <20190320015249.GC129907@google.com> <CAKOZuetJzg_EiyuK7Pa13X3LKuBbreg7zJ5g4uQv_uV4wpmZjg@mail.gmail.com> <20190320035953.mnhax3vd47ya4zzm@brauner.io> <CAKOZuet3-VhmC3oHtEbPPvdiar_k_QXTf0TkgmH9LiwmW-_oNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: pidfd design
To:     Daniel Colascione <dancol@google.com>,
        Christian Brauner <christian@brauner.io>
CC:     Suren Baghdasaryan <surenb@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        Tim Murray <timmurray@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        linux-mm <linux-mm@kvack.org>,
        kernel-team <kernel-team@android.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Message-ID: <4A06C5BB-9171-4E70-BE31-9574B4083A9F@joelfernandes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On March 20, 2019 3:02:32 AM EDT, Daniel Colascione <dancol@google=2Ecom> =
wrote:
>On Tue, Mar 19, 2019 at 8:59 PM Christian Brauner
><christian@brauner=2Eio> wrote:
>>
>> On Tue, Mar 19, 2019 at 07:42:52PM -0700, Daniel Colascione wrote:
>> > On Tue, Mar 19, 2019 at 6:52 PM Joel Fernandes
><joel@joelfernandes=2Eorg> wrote:
>> > >
>> > > On Wed, Mar 20, 2019 at 12:10:23AM +0100, Christian Brauner
>wrote:
>> > > > On Tue, Mar 19, 2019 at 03:48:32PM -0700, Daniel Colascione
>wrote:
>> > > > > On Tue, Mar 19, 2019 at 3:14 PM Christian Brauner
><christian@brauner=2Eio> wrote:
>> > > > > > So I dislike the idea of allocating new inodes from the
>procfs super
>> > > > > > block=2E I would like to avoid pinning the whole pidfd
>concept exclusively
>> > > > > > to proc=2E The idea is that the pidfd API will be useable
>through procfs
>> > > > > > via open("/proc/<pid>") because that is what users expect
>and really
>> > > > > > wanted to have for a long time=2E So it makes sense to have
>this working=2E
>> > > > > > But it should really be useable without it=2E That's why
>translate_pid()
>> > > > > > and pidfd_clone() are on the table=2E  What I'm saying is,
>once the pidfd
>> > > > > > api is "complete" you should be able to set CONFIG_PROCFS=3DN
>- even
>> > > > > > though that's crazy - and still be able to use pidfds=2E This
>is also a
>> > > > > > point akpm asked about when I did the pidfd_send_signal
>work=2E
>> > > > >
>> > > > > I agree that you shouldn't need CONFIG_PROCFS=3DY to use
>pidfds=2E One
>> > > > > crazy idea that I was discussing with Joel the other day is
>to just
>> > > > > make CONFIG_PROCFS=3DY mandatory and provide a new
>get_procfs_root()
>> > > > > system call that returned, out of thin air and independent of
>the
>> > > > > mount table, a procfs root directory file descriptor for the
>caller's
>> > > > > PID namspace and suitable for use with openat(2)=2E
>> > > >
>> > > > Even if this works I'm pretty sure that Al and a lot of others
>will not
>> > > > be happy about this=2E A syscall to get an fd to /proc?
>> >
>> > Why not? procfs provides access to a lot of core kernel
>functionality=2E
>> > Why should you need a mountpoint to get to it?
>> >
>> > > That's not going
>> > > > to happen and I don't see the need for a separate syscall just
>for that=2E
>> >
>> > We need a system call for the same reason we need a getrandom(2):
>you
>> > have to bootstrap somehow when you're in a minimal environment=2E
>> >
>> > > > (I do see the point of making CONFIG_PROCFS=3Dy the default btw=
=2E)
>> >
>> > I'm not proposing that we make CONFIG_PROCFS=3Dy the default=2E I'm
>> > proposing that we *hardwire* it as the default and just declare
>that
>> > it's not possible to build a Linux kernel that doesn't include
>procfs=2E
>> > Why do we even have that button?
>> >
>> > > I think his point here was that he wanted a handle to procfs no
>matter where
>> > > it was mounted and then can later use openat on that=2E Agreed that
>it may be
>> > > unnecessary unless there is a usecase for it, and especially if
>the /proc
>> > > directory being the defacto mountpoint for procfs is a universal
>convention=2E
>> >
>> > If it's a universal convention and, in practice, everyone needs
>proc
>> > mounted anyway, so what's the harm in hardwiring CONFIG_PROCFS=3Dy?
>If
>> > we advertise /proc as not merely some kind of optional debug
>interface
>> > but *the* way certain kernel features are exposed --- and there's
>> > nothing wrong with that --- then we should give programs access to
>> > these core kernel features in a way that doesn't depend on
>userspace
>> > kernel configuration, and you do that by either providing a
>> > procfs-root-getting system call or just hardwiring the "/proc/"
>prefix
>> > into VFS=2E
>> >
>> > > > Inode allocation from the procfs mount for the file descriptors
>Joel
>> > > > wants is not correct=2E Their not really procfs file descriptors
>so this
>> > > > is a nack=2E We can't just hook into proc that way=2E
>> > >
>> > > I was not particular about using procfs mount for the FDs but
>that's the only
>> > > way I knew how to do it until you pointed out anon_inode (my grep
>skills
>> > > missed that), so thank you!
>> > >
>> > > > > C'mon: /proc is used by everyone today and almost every
>program breaks
>> > > > > if it's not around=2E The string "/proc" is already de facto
>kernel ABI=2E
>> > > > > Let's just drop the pretense of /proc being optional and bake
>it into
>> > > > > the kernel proper, then give programs a way to get to /proc
>that isn't
>> > > > > tied to any particular mount configuration=2E This way, we
>don't need a
>> > > > > translate_pid(), since callers can just use procfs to do the
>same
>> > > > > thing=2E (That is, if I understand correctly what translate_pid
>does=2E)
>> > > >
>> > > > I'm not sure what you think translate_pid() is doing since
>you're not
>> > > > saying what you think it does=2E
>> > > > Examples from the old patchset:
>> > > > translate_pid(pid, ns, -1)      - get pid in our pid namespace
>> >
>> > Ah, it's a bit different from what I had in mind=2E It's fair to want
>to
>> > translate PIDs between namespaces, but the only way to make the
>> > translate_pid under discussion robust is to have it accept and
>produce
>> > pidfds=2E (At that point, you might as well call it translate_pidfd=
=2E)
>We
>> > should not be adding new APIs to the kernel that accept numeric
>PIDs:
>>
>> The traditional pid-based api is not going away=2E There are users that
>> have the requirement to translate pids between namespaces and also
>doing
>> introspection on these namespaces independent of pidfds=2E We will not
>> restrict the usefulness of this syscall by making it only work with
>> pidfds=2E
>>
>> > it's not possible to use these APIs correctly except under very
>> > limited circumstances --- mostly, talking about init or a parent
>>
>> The pid-based api is one of the most widely used apis of the kernel
>and
>> people have been using it quite successfully for a long time=2E Yes,
>it's
>> rac, but it's here to stay=2E
>>
>> > talking about its child=2E
>> >
>> > Really, we need a few related operations, and we shouldn't
>necessarily
>> > mingle them=2E
>>
>> Yes, we've established that previously=2E
>>
>> >
>> > 1) Given a numeric PID, give me a pidfd: that works today: you just
>> > open /proc/<pid>
>>
>> Agreed=2E
>>
>> >
>> > 2) Given a pidfd, give me a numeric PID: that works today: you just
>> > openat(pidfd, "stat", O_RDONLY) and read the first token (which is
>> > always the numeric PID)=2E
>>
>> Agreed=2E
>>
>> >
>> > 3) Given a pidfd, send a signal: that's what pidfd_send_signal
>does,
>> > and it's a good start on the rest of these operations=2E
>>
>> Agreed=2E
>>
>> > 5) Given a pidfd in NS1, get a pidfd in NS2=2E That's what
>translate_pid
>> > is for=2E My preferred signature for this routine is
>translate_pid(int
>> > pidfd, int nsfd) -> pidfd=2E We don't need two namespace arguments=2E
>Why
>> > not? Because the pidfd *already* names a single process, uniquely!
>>
>> Given that people are interested in pids we can't just always return
>a
>> pidfd=2E That would mean a user would need to do get the pidfd read
>from
>> <pidfd>/stat and then close the pidfd=2E If you do that for a 100 pids
>or
>> more you end up allocating and closing file descriptors constantly
>for
>> no reason=2E We can't just debate pids away=2E So it will also need to =
be
>> able to yield pids e=2Eg=2E through a flag argument=2E
>
>Sure, but that's still not a reason that we should care about pidfds
>working separately from procfs=2E=2E

Agreed=2E I can't imagine pidfd being anything but a proc pid directory ha=
ndle=2E So I am confused what Christian meant=2E Pidfd *is* a procfs direct=
ory fid  always=2E That's what I gathered from his pidfd_send_signal patch =
but let me know if I'm way off in the woods=2E

For my next revision, I am thinking of adding the flag argument Christian =
mentioned to make translate_pid return an anon_inode FD which can be used f=
or death status, given a <pid>=2E Since it is thought that translate_pid ca=
n be made to return a pid FD, I think it is ok to have it return a pid stat=
us FD for the purposes of the death status as well=2E

Joel Fernandes, Android kernel team
Sent from k9-mail on Android
