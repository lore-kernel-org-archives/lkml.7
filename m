Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6512DC282E2
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 00:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CC4821855
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 00:02:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="bI/knyIc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbfDTACn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 20:02:43 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33246 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727539AbfDTACm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 20:02:42 -0400
Received: by mail-lj1-f195.google.com with SMTP id f23so5816979ljc.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 17:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IW4wpUF9ZuQK6A2I5YRkQNjcquz60hfp8qokvg9dFUw=;
        b=bI/knyIcLXFPS9VTo7WFQJgPmlAMPqboUpZmmNcJ0U7YE7sXUALO8yWSbDmyx8nQoS
         v3bZ2QlEVn1M+djyw3kDOKvtm185GeUfHUf7uKFTcoqbfJt27CvFt+MAM7hElBHdnWNw
         EfgAVWIVCoT3gMFEsmJxUo5XM+tzinUWyqdeQkY9+97MTWA84t2OFh4Rmy6BqD1Qbk3q
         Q58DGBJgcDE/jObgma5BLgLCP/lWGM1tPkBuFB52V9sm3yiZiMeLubZwpwV+5vqtv8Fr
         lW1MkXNEXP/55eTheHoYlFY2UDylJ2LOimX9bEpo6fFYTvg8Vpqgc3WlTa4jy0fD10X+
         WtdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IW4wpUF9ZuQK6A2I5YRkQNjcquz60hfp8qokvg9dFUw=;
        b=VnCwYwGo/DcCXInk+UMYNlomyXk+r6wxVBZF8vI3SmcBRrB6yL+jf4fFHoSpCApA4+
         x4zbrNIzHa5nyNDnrfIQkZh/nMuvkdv470GzsMbzspoJMskQ9Cid/CaP2C/FIVEa05MC
         Ri/jfVm6VCokqZLSRFiD/nTYBN/LA6suDTqisvwnE2dH/1tcxxQlE92thqu+exseJE5b
         wM8kB62MJ+VOGsHeDnT4+yBjwO1gKkcKfMxRvTYhzPUVPc2RCqKOF6pC0A2oRKlNJFgt
         g0ufDs2lyZp6oaUFSA/WzN8s9KtrGDlgZyLGJPv3VXkXYS6Xy/6kg3UQWFiW4dLUSr/p
         kVWQ==
X-Gm-Message-State: APjAAAXYc0H9B+ZhltCMIjDtsChhWTdHtEcxwfp1En2wRUvUtlMgwS2C
        FdjfS7CFlrx4HXJyrk7pGJJJJ+W2ntKuSs9TRmEXrQ==
X-Google-Smtp-Source: APXvYqwFK0/0jnM1roZ84rz4g8ubCqbGLDEoUeUkNzbslKx/zs4Hre7qQwvwb+BF8MeLyd2I+srIu7C//Srxm/ztDC8=
X-Received: by 2002:a2e:7114:: with SMTP id m20mr3761689ljc.120.1555718559679;
 Fri, 19 Apr 2019 17:02:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190411175043.31207-1-joel@joelfernandes.org>
 <20190416120430.GA15437@redhat.com> <20190416192051.GA184889@google.com>
 <20190417130940.GC32622@redhat.com> <CAG48ez2Q0t2-rZz8wmGeih=NigYL-CT3+E6NgiPT0AkOQAUPMQ@mail.gmail.com>
 <CEB62F51-E8BF-4EFB-B438-8AF76633FF00@brauner.io> <20190419190247.GB251571@google.com>
 <20190419191858.iwcvqm6fihbkaata@brauner.io> <20190419194902.GE251571@google.com>
 <CAKOZueu3PzD_QgROXFRs8FvD=HTKJLsHDK9GrUdbFoMzx_7HEA@mail.gmail.com>
 <CAHrFyr4REuKFuARAXnhBC67TGzyDGmMONc7XjfUGvf+Qfm7EuQ@mail.gmail.com>
 <CAKOZueuBTwyrLtpVQaoTAgjGSgeHY7392sKv5uAYdy4XKNHKHQ@mail.gmail.com>
 <CAHrFyr6f_CUP__818e1u6TaHd-XpWY6NOxri4yzzR6rNY5rk_w@mail.gmail.com>
 <CAKOZuetiqFx0qW9rdCVWsKQxwaYK2Vis8EXsDba6=F5dp=da6Q@mail.gmail.com>
 <CAHrFyr6FntUgsCRw2b1B9+pjLQ2+pJMTULywRC1woNW4PvtyiQ@mail.gmail.com> <CAKOZuesw9JK6DLhFTxN74rH5PDqGn7qbCQT4aaP1qtahSoRZ8w@mail.gmail.com>
In-Reply-To: <CAKOZuesw9JK6DLhFTxN74rH5PDqGn7qbCQT4aaP1qtahSoRZ8w@mail.gmail.com>
From:   Christian Brauner <christian@brauner.io>
Date:   Sat, 20 Apr 2019 02:02:28 +0200
Message-ID: <CAHrFyr57MLgTDGP2vuixPkW=5odD_F8Jcv57xThVQnnzqN+JpQ@mail.gmail.com>
Subject: Re: [PATCH RFC 1/2] Add polling support to pidfd
To:     Daniel Colascione <dancol@google.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrei Vagin <avagin@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Michal Hocko <mhocko@suse.com>,
        Nadav Amit <namit@vmware.com>, Serge Hallyn <serge@hallyn.com>,
        Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Taehee Yoo <ap420073@gmail.com>, Tejun Heo <tj@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kernel-team <kernel-team@android.com>,
        Tycho Andersen <tycho@tycho.ws>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 20, 2019 at 1:30 AM Daniel Colascione <dancol@google.com> wrote:
>
> On Fri, Apr 19, 2019 at 4:02 PM Christian Brauner <christian@brauner.io> wrote:
> >
> > On Sat, Apr 20, 2019 at 12:35 AM Daniel Colascione <dancol@google.com> wrote:
> > >
> > > On Fri, Apr 19, 2019 at 2:48 PM Christian Brauner <christian@brauner.io> wrote:
> > > >
> > > > On Fri, Apr 19, 2019 at 11:21 PM Daniel Colascione <dancol@google.com> wrote:
> > > > >
> > > > > On Fri, Apr 19, 2019 at 1:57 PM Christian Brauner <christian@brauner.io> wrote:
> > > > > >
> > > > > > On Fri, Apr 19, 2019 at 10:34 PM Daniel Colascione <dancol@google.com> wrote:
> > > > > > >
> > > > > > > On Fri, Apr 19, 2019 at 12:49 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> > > > > > > >
> > > > > > > > On Fri, Apr 19, 2019 at 09:18:59PM +0200, Christian Brauner wrote:
> > > > > > > > > On Fri, Apr 19, 2019 at 03:02:47PM -0400, Joel Fernandes wrote:
> > > > > > > > > > On Thu, Apr 18, 2019 at 07:26:44PM +0200, Christian Brauner wrote:
> > > > > > > > > > > On April 18, 2019 7:23:38 PM GMT+02:00, Jann Horn <jannh@google.com> wrote:
> > > > > > > > > > > >On Wed, Apr 17, 2019 at 3:09 PM Oleg Nesterov <oleg@redhat.com> wrote:
> > > > > > > > > > > >> On 04/16, Joel Fernandes wrote:
> > > > > > > > > > > >> > On Tue, Apr 16, 2019 at 02:04:31PM +0200, Oleg Nesterov wrote:
> > > > > > > > > > > >> > >
> > > > > > > > > > > >> > > Could you explain when it should return POLLIN? When the whole
> > > > > > > > > > > >process exits?
> > > > > > > > > > > >> >
> > > > > > > > > > > >> > It returns POLLIN when the task is dead or doesn't exist anymore,
> > > > > > > > > > > >or when it
> > > > > > > > > > > >> > is in a zombie state and there's no other thread in the thread
> > > > > > > > > > > >group.
> > > > > > > > > > > >>
> > > > > > > > > > > >> IOW, when the whole thread group exits, so it can't be used to
> > > > > > > > > > > >monitor sub-threads.
> > > > > > > > > > > >>
> > > > > > > > > > > >> just in case... speaking of this patch it doesn't modify
> > > > > > > > > > > >proc_tid_base_operations,
> > > > > > > > > > > >> so you can't poll("/proc/sub-thread-tid") anyway, but iiuc you are
> > > > > > > > > > > >going to use
> > > > > > > > > > > >> the anonymous file returned by CLONE_PIDFD ?
> > > > > > > > > > > >
> > > > > > > > > > > >I don't think procfs works that way. /proc/sub-thread-tid has
> > > > > > > > > > > >proc_tgid_base_operations despite not being a thread group leader.
> > > > > > > > > > > >(Yes, that's kinda weird.) AFAICS the WARN_ON_ONCE() in this code can
> > > > > > > > > > > >be hit trivially, and then the code will misbehave.
> > > > > > > > > > > >
> > > > > > > > > > > >@Joel: I think you'll have to either rewrite this to explicitly bail
> > > > > > > > > > > >out if you're dealing with a thread group leader, or make the code
> > > > > > > > > > > >work for threads, too.
> > > > > > > > > > >
> > > > > > > > > > > The latter case probably being preferred if this API is supposed to be
> > > > > > > > > > > useable for thread management in userspace.
> > > > > > > > > >
> > > > > > > > > > At the moment, we are not planning to use this for sub-thread management. I
> > > > > > > > > > am reworking this patch to only work on clone(2) pidfds which makes the above
> > > > > > > > >
> > > > > > > > > Indeed and agreed.
> > > > > > > > >
> > > > > > > > > > discussion about /proc a bit unnecessary I think. Per the latest CLONE_PIDFD
> > > > > > > > > > patches, CLONE_THREAD with pidfd is not supported.
> > > > > > > > >
> > > > > > > > > Yes. We have no one asking for it right now and we can easily add this
> > > > > > > > > later.
> > > > > > > > >
> > > > > > > > > Admittedly I haven't gotten around to reviewing the patches here yet
> > > > > > > > > completely. But one thing about using POLLIN. FreeBSD is using POLLHUP
> > > > > > > > > on process exit which I think is nice as well. How about returning
> > > > > > > > > POLLIN | POLLHUP on process exit?
> > > > > > > > > We already do things like this. For example, when you proxy between
> > > > > > > > > ttys. If the process that you're reading data from has exited and closed
> > > > > > > > > it's end you still can't usually simply exit because it might have still
> > > > > > > > > buffered data that you want to read.  The way one can deal with this
> > > > > > > > > from  userspace is that you can observe a (POLLHUP | POLLIN) event and
> > > > > > > > > you keep on reading until you only observe a POLLHUP without a POLLIN
> > > > > > > > > event at which point you know you have read
> > > > > > > > > all data.
> > > > > > > > > I like the semantics for pidfds as well as it would indicate:
> > > > > > > > > - POLLHUP -> process has exited
> > > > > > > > > - POLLIN  -> information can be read
> > > > > > > >
> > > > > > > > Actually I think a bit different about this, in my opinion the pidfd should
> > > > > > > > always be readable (we would store the exit status somewhere in the future
> > > > > > > > which would be readable, even after task_struct is dead). So I was thinking
> > > > > > > > we always return EPOLLIN.  If process has not exited, then it blocks.
> > > > > > >
> > > > > > > ITYM that a pidfd polls as readable *once a task exits* and stays
> > > > > > > readable forever. Before a task exit, a poll on a pidfd should *not*
> > > > > > > yield POLLIN and reading that pidfd should *not* complete immediately.
> > > > > > > There's no way that, having observed POLLIN on a pidfd, you should
> > > > > > > ever then *not* see POLLIN on that pidfd in the future --- it's a
> > > > > > > one-way transition from not-ready-to-get-exit-status to
> > > > > > > ready-to-get-exit-status.
> > > > > >
> > > > > > What do you consider interesting state transitions? A listener on a pidfd
> > > > > > in epoll_wait() might be interested if the process execs for example.
> > > > > > That's a very valid use-case for e.g. systemd.
> > > > >
> > > > > Sure, but systemd is specialized.
> > > >
> > > > So is Android and we're not designing an interface for Android but for
> > > > all of userspace.
> > >
> > > Nothing in my post is Android-specific. Waiting for non-child
> > > processes is something that lots of people want to do, which is why
> > > patches to enable it have been getting posted every few years for many
> > > years (e.g., Andy's from 2011). I, too, want to make an API for all
> > > over userspace. Don't attribute to me arguments that I'm not actually
> > > making.
> > >
> > > > I hope this is clear. Service managers are quite important and systemd
> > > > is the largest one
> > > > and they can make good use of this feature.
> > >
> > > Service managers already have the tools they need to do their job. The
> >
> > No they don't. Even if they quite often have kludges and run into a lot
> > of problems. That's why there's interest in these features as well.
>
> Yes, and these facilities should have a powerful toolkit that they can
> use to do their job in the right way. This toolkit will probably
> involve pretty powerful kinds of process monitoring. I don't see a
> reason to gate the ability to wait for process death via pidfd on that
> toolkit. Please don't interpret my position as saying that the service
> monitor usecase is unimportant or not worth adding to Linux.

Great. It sounded like it.

<snip>

> >
> > Well, daemons tend to do those things do. System managers and container
> > managers are just an example of a whole class. Even if you just consider system
> > managers like openrc, systemd you have gotten yourself quite a large userbase.
>
> When I said "niche", I didn't mean "unimportant". I meant
> "specialized", as in the people who write these sorts of programs are
> willing to dive in to low-level operational details and get things
> right. I also think the community of people *writing* programs like
> systemd is relatively small.

The point is that these tools are widely used not how many people develop it
and making their live easier and listening to their use-cases as well
is warranted.

<snip-it-just-gets-too-long>

> > FreeBSD obviously has thought about being able to observe
> > more than just NOTE_EXIT in the future.
>
> Yes. Did I say anywhere that we should never be able to observe execs
> and forks? I think that what FreeBSD got *right* is making process
> exit status broadly available. What I think they got wrong is the
> mixing of exit information with other EVFILT_PROCDESC messages.
>
> > > > > wait for processes to exit and to retrieve their exit information.
> > > > >
> > > > > Speaking of pkill: AIUI, in your current patch set, one can get a
> > > > > pidfd *only* via clone. Joel indicated that he believes poll(2)
> > > > > shouldn't be supported on procfs pidfds. Is that your thinking as
> > > > > well? If that's the case, then we're in a state where non-parents
> > > >
> > > > Yes, it is.
> > >
> > > If reading process status information from a pidfd is destructive,
> > > it's dangerous to share pidfds between processes. If reading
> > > information *isn't* destructive, how are you supposed to use poll(2)
> > > to wait for the next transition? Is poll destructive? If you can only
> > > make a new pidfd via clone, you can't get two separate event streams
> > > for two different users. Sharing a single pidfd via dup or SCM_RIGHTS
> > > becomes dangerous, because if reading status is destructive, only one
> > > reader can observe each event. Your proposed edge-triggered design
> > > makes pidfds significantly less useful, because in your design, it's
> > > unsafe to share a single pidfd open file description *and* there's no
> > > way to create a new pidfd open file description for an existing
> > > process.
> > >
> > > I think we should make an API for all of userspace and not just for
> > > container managers and systemd.
> >
> > I mean,  you can go and try making arguments based on syntactical
> > rearrangements of things I said but I'm going to pass.
>
> I'd prefer if we focused on substantive technical issues instead of
> unproductive comments on syntax. I'd prefer to talk about the

Great. Your

"I think we should make an API for all of userspace and not just for
container managers and systemd."

very much sounded like you're mocking my point about being aware of
other usecases apart from Android. Maybe you did not intend it that way.
Very much felt like it.

> technical concerns I raised regarding an edge-triggered event-queue
> design making pidfd file descriptor sharing dangerous.
>
> > My point simply was: There are more users that would be interested
> > in observing more state transitions in the future.
> > Your argument made it sound like they are not worth considering.
> > I disagree.
>
> I believe you've misunderstood me. I've never said that this use case
> is "not worth considering". I would appreciate it if you wouldn't
> claim that I believe these use cases aren't worth considering. My

I didn't claim you believe it rather you made it sound like and you did
dismiss those use-cases as driving factors when thinking about this api.

> point is that these uses would be better served through a dedicated
> process event monitoring facility, one that could replace ptrace. I
> would be thrilled by something like that. The point I'm making, to be
> very clear, is *NOT* that process monitoring is "not worth
> considering", but that process monitoring is subtle and complicated
> enough that it ought to be considered as a standalone project,
> independent of pidfds proper and of the very simple and effective
> pidfd system that Joel has proposed in his patch series.
>
> > > > > can't wait for process exit, and providing this facility is an
> > > > > important goal of the whole project.
> > > >
> > > > That's your goal.
> > >
> > > I thought we all agreed on that months ago that it's reasonable to
> > > allow processes to wait for non-child processes to exit. Now, out of
> >
> > Uhm, I can't remember being privy to that agreement but the threads get
> > so long that maybe I forgot what I wrote?
> >
> > > the blue, you're saying that 1) actually, we want a rich API for all
> > > kinds of things that aren't process exit, because systemd, and 2)
> >
> > - I'm not saying we have to. It just makes it more flexible and is something
> > we can at least consider.
>
> I've spent a few emails and a lot of thought considering the idea. If
> I weren't considering it, I wouldn't have thought through the
> implications of destructive event reads above. My position, *after due
> consideration*, is that we're better off making the pidfd poll()
> system a level-triggered exit-only signal and defer more sophisticated

That's something you'd need to explain in more depth and why if it works
for FreeBSD we can't just do the same.

> monitoring to a separate facility. I'm not saying that we shouldn't be
> able to monitor processes. I'm saying that there are important
> technical and API design reasons why the initial version of the pidfd
> wait system should be simple and support only one thing. The model
> you've proposed has important technical disadvantages, and you haven't
> addressed these technical disadvantages.
>
> > - systemd is an example of another *huge* user of this api. That neither implies
> > this api is "because systemd" it simply makes it worth that we
> > consider this use-case.
> >
> > > actually, non-parents shouldn't be able to wait for process death. I
> >
> > I'm sorry, who has agreed that a non-parent should be able to wait for
> > process death?
>
> Aleksa Sarai, for starters. See [1]. In any case, I don't see where
> your sudden opposition to the idea is coming from. I've been saying
> over and over that it's important that we allow processes to wait for
> the death of non-children. Why are you just objecting now? And on what

First of all, because I haven't been Cced on that thread so I didn't follow it.

> basis are you objecting? Why *shouldn't* we be able to wait for
> process death in a general way? Both FreeBSD and Windows can do it.

Because I consider this to be quite a controversial change with a lot
of implications.
And as I said in the previous mail: If you have the support and the
Acks and Reviews you are more than welcome to do this.
I don't think this is relevant for the polling patchset though. But please, see
my comment below because I think we might have talked about different things...

>
> > I know you proposed that but has anyone ever substantially supported this?
> > I'm happy if you can gather the necessary support for this but I just
> > haven't seen that yet.
>
> I recommend re-reading the whole exithand thread, since we covered a
> lot of the ground that we're also covering here. In any case, there's
> a legitimate technical reason why we'd want to wait for non-child
> death, and I would appreciate it if you didn't just summarily dismiss
> it as "[my] goal". Let's talk about what's best for users, not use
> that kind of unproductive rhetoric.

Wait, to clarify: Are you saying any process should be able to call
waitid(pid/pidfd) on a non-child or are you saying that a process just needs
a way to block until another process has exited and then - if the
parent has reaped it -
read its exit status. I agree with the latter it's the former I find strange.
The mail reads like the latter though.

>
> [1] https://lore.kernel.org/lkml/20181101070036.l24c2p432ohuwmqf@yavin/
