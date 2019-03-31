Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA6E0C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 04:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0DDF21726
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 04:47:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fYONZllw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbfCaErM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 00:47:12 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41756 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfCaErM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 00:47:12 -0400
Received: by mail-ot1-f67.google.com with SMTP id 64so5605514otb.8
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2019 21:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N10+ICWZPz8HQk9LeagnflXLIl2Hso1t/TO/QeUqXy8=;
        b=fYONZllw1A39Pp24o5a8YvapRNO7aRT4w9HdWafI8jYVhYwoXr77sveyi5eegYnKfp
         FFVi1imJpqF1Gbu/1/xBbyvQ6vW5adFKcV57jwzhG7SaQ27aXUZFTU+Zf4wZNNq9XMrr
         FIs536rsAAzqLsABLrOSdy7HPXwESqNO6Qh6SyJ7KxKCZh3aM7rCc/TuVu42zDejsHNK
         RT52bwlSnE0zy8me/Cyf0LMHZfdK3/nIRjSwmANNEvfFZU6AwReqIJ4jqrxFwSaZ6J+A
         xZ0CNdnAlrKsq6vlxq4f5759NMxrv5V6YzTgMl7pin4Ovok4TB593kJheZoYvfAaM73M
         4iOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N10+ICWZPz8HQk9LeagnflXLIl2Hso1t/TO/QeUqXy8=;
        b=m628HBnbbwC/lXXnclXhx7HgqjLl55Iigzaq78dG4fVv9EyNHpUHOVh+m1AdS6fAt6
         RjHmxeTTPO1QMmS8n12B2+aYxjgg39Sj9GW+D0huWSSgFYf5drf84TXPTp+I9H/erTiL
         1vx1dmOxq/kmQO9kHxF0l4FWyVpQt0S5TIXIifQh0/FnhoA4WUUJtMvpbptzdPyqroxv
         c0+2L4MCs9VXS87xLvLXCXVUIO5/1OUJro3NoBR9TZMWtKEfLdtpAklqYZvnOjdT57fd
         AAcXfcY5euu6o5fn2kDGPDj0PHFIpR2NOP+0KGl7IGQTJE9Fz3oPisq68Q2+bWuZdrtr
         Nu9g==
X-Gm-Message-State: APjAAAX883Pkqq06iVtc1z6kk+YX/n1Tupt/9XHK39ued5rrlhCqWBF9
        hUIv3I3wHjC5Ob8Csv4ibcaL4aUB0i9YlZMoJLNSgQ==
X-Google-Smtp-Source: APXvYqxafKdObzeRxzGc7gW0Ttekmge23YgLy6e3+BK6r2o2174JNqs/wvC8vPlF/zu3L7SkFT9zaiYf+moSjzLxIeA=
X-Received: by 2002:a9d:694c:: with SMTP id p12mr39641095oto.242.1554007631275;
 Sat, 30 Mar 2019 21:47:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190329155425.26059-1-christian@brauner.io> <CAHk-=wjq4dTPcz-qsvhpm5F42SDHCoqEWv1V=rs_kt6MC=ZThA@mail.gmail.com>
 <CAKOZueuDWWYtg9gUpUgTG2k-gVPE1KBEkstr5eP=FC2EzdmaoA@mail.gmail.com>
 <CAHk-=wjka0W1g3asQp2H=5ot=kkS-Mp+Cx6KHr0rNkGFfCOLYA@mail.gmail.com>
 <CAHk-=wi1kQDVN22qv7M=bWU+CngZZXcPAMKCsDZMeuY3k2tkyg@mail.gmail.com>
 <20190331010716.GA189578@google.com> <CAG48ez387kGbD_dLqEbZ1U9rKFbfP0EF9cMVjQT6nwc9=Y9CNw@mail.gmail.com>
 <20190331040810.GB189578@google.com>
In-Reply-To: <20190331040810.GB189578@google.com>
From:   Jann Horn <jannh@google.com>
Date:   Sun, 31 Mar 2019 06:46:44 +0200
Message-ID: <CAG48ez2gb94SqS30Ai4+VBHhnzBp5Po9_u00nMrvUW6Wqq6hPA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] pid: add pidfd_open()
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Colascione <dancol@google.com>,
        Christian Brauner <christian@brauner.io>,
        Andrew Lutomirski <luto@kernel.org>,
        David Howells <dhowells@redhat.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Kees Cook <keescook@chromium.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Kerrisk-manpages <mtk.manpages@gmail.com>,
        Jonathan Kowalski <bl0pbl33p@gmail.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 31, 2019 at 6:08 AM Joel Fernandes <joel@joelfernandes.org> wrote:
> On Sun, Mar 31, 2019 at 04:34:57AM +0200, Jann Horn wrote:
> > On Sun, Mar 31, 2019 at 3:07 AM Joel Fernandes <joel@joelfernandes.org> wrote:
> > > As I said I don't really care about "pidfd" solving any racing issues with
> > > /proc/<pid>/* accesses - because I still find it hard to imagine that the pid
> > > number can be reused easily from the time you know which <pid> to deal with,
> > > to the time when you want to read, say, the /proc/<pid>/status file.
> >
> > There have been several Android security bugs related to PID reuse.
>
> Yes PID reuse will be a problem till we have pidfd_clone and
> pidfd_send_signal (and any other pidfd related syscalls). I've never denied
> PID reuse is *currently* a problem and the set of pidfd syscalls being
> proposed are designed to avoid those. So I'm not fully sure what you mean.
> Anyway, I would love to see those security bugs you mentioned if you could
> point me to them.

https://bugs.chromium.org/p/project-zero/issues/detail?id=851
"Android: racy getpidcon usage permits binder service replacement"

https://bugs.chromium.org/p/project-zero/issues/detail?id=853
"Android: debuggerd mitigation bypass and infoleak"

https://bugs.chromium.org/p/project-zero/issues/detail?id=1404
"Android: Hardware Service Manager Arbitrary Service Replacement due
to getpidcon"

https://bugs.chromium.org/p/project-zero/issues/detail?id=1406
"Android: Permission bypass in KeyStore service due to getpidcon"

https://bugs.chromium.org/p/project-zero/issues/detail?id=1741
"Android: getpidcon() usage in hardware binder servicemanager permits
ACL bypass"

> > > I am yet
> > > to see any real data to show that such overflow happens - you literally need
> > > 32k process deaths and forks in such a short time frame
> >
> > This seems very inaccurate to me.
> >
> > The time frame in which the PID has to wrap around is not the time
> > between process death and use of the PID. It is the time between *the
> > creation* of the old process and the use of the PID. Consider the
> > following sequence of events:
> >
> >  - process A starts with PID 1000
> >  - some time passes in which some process repeatedly forks, with PIDs
> > wrapping around to 999
> >  - process B starts an attempt to access process A (using PID 1000)
> >  - process A dies
> >  - process C spawns with PID 1000
> >  - process B accidentally accesses process C
> >
> > Also, it's probably worth clarifying that here, "processes" means "threads".
> >
> > If there are a lot of active processes, that reduces the number of
> > times you have to clone() to get the PID to wrap around.
>
> Ok, that's fair and I take your point. But I wonder what access you're
> talking about, is it killing the process? If yes, pidfd_clone +
> pidfd_send_signal will solve that in the race free way without relying on the
> PID number.

Sure, given a pidfd_clone() syscall, as long as the parent of the
process is giving you a pidfd for it and you don't have to deal with
grandchildren created by fork() calls outside your control, that
works.

> Is it accessing /proc/<pid>/? then see below.

> > > and on 64-bit, that
> > > number is really high
> >
> > Which number is really high on 64-bit? Checking on a walleye phone,
> > pid_max is still only 32768:
> >
> > walleye:/ # cat /proc/sys/kernel/pid_max
> > 32768
> > walleye:/ #
>
> Ok. I was talking about the theoretical limit of pid_max on a 64-bit
> platform. But since we are talking about NOT relying on the PID number in the
> first place, we can move on from this point.

(pid_t is a signed 32-bit value, that's UAPI.)

> > > that its not even an issue. And if this is really an
> > > issue, then you can just open a handle to /proc/<pid> at process creation
> > > time and keep it around. If the <pid> is reused, you can still use openat(2)
> > > on that handle without any races.
> >
> > But not if you want to implement something like killall in a
> > race-free way, for example.
>
> I am not at all talking about killing processes in your last quote of my
> email above, I'm talking about access to /proc/<pid>/ files.
>
> As I said, at the time of process creation, you can obtain an fd by opening
> /proc/<pid>/ and keep it open. Then you can do an openat(2) on that fd
> without worrying at <pid> reuse, no? And then access all the files that way.

Yeah, if you're the parent of a process with a termination signal, that works.

> As for killall in Android. I don't think that "killing processes by name" is
> relied on for the runtime operation of Android. That would be a very bad
> idea. Low memory killer does not kill processes by name. It kills processes
> by the PID number using kill(2) which we'd like to replace with
> pidfd_send_signal.

Yeah, I somehow lost context when replying to your mail here; sorry
about that. I didn't mean to imply that this is a usecase on Android.
