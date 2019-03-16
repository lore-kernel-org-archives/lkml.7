Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9703C10F03
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 19:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86AB3218FE
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 19:37:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F9vNt+ox"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbfCPThc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 15:37:32 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:44073 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbfCPThc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 15:37:32 -0400
Received: by mail-io1-f65.google.com with SMTP id u12so11094637iop.11
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2019 12:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=roFVcsGaN00PW1oT7om/Ux/WLpjkxYlnnHm7GR3L4fs=;
        b=F9vNt+oxgki07eeTTkB3cFCrbRJ9jHI3hXR5jaXpnD1+eqRAmVfuPZhZQsqdL3ZYOZ
         Esv/CVk4A97aNvRlZk6Vln8zrIo9pi3+K98uA88GKeDxQO4gkYxpYRrw4/t2u447PTA2
         WTDBfZyLJzOCDucFvinzMORvPCPl8cFR8eja58ztsV8VrWUZETJfnGHY3Y8yvdwsSXOk
         NK7NOYyfza7UrWPZvbHJsxaObHp8Ze8rs1xoAb6eFYQb0+Y3jYhJrL3JmdxxZx/SHn1J
         pN5Ljj96gmETjwexz26zWahoKoouIgbDSgselZNDgUSta1uBcD4Ywu4IyiyJPDXHuar1
         9mdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=roFVcsGaN00PW1oT7om/Ux/WLpjkxYlnnHm7GR3L4fs=;
        b=GuTfHSaVRgFv9TUYfCnshSvd4d4RgtuJSEhOcHLL+kFM4haQbhlzxldgEgc9QLFZs4
         U3oGhLyFhuYmyen6O9SCUWxa6EK+apwI0E6NZkbELfAIopBALE2vIuO3Ja+nKVR2vwTp
         6hj1x9Fz9TWn0Ueht1rJTgnj5ek4d0e4QPD3tTO/41y2u+otx/FH33CQkjfEiuvUMYOY
         JswVv/YGHuPauIZolFoYcnkezTNH4orboBHBrZdWGSUT2sxuHxoJ5Fnzxk8RGr4QRtux
         cRA3ZQbMZDPxXcPYf1PAa8DKlte/lBbGZGITzdWbw74NE5xEIBLa9AwS49T4LchvBZ1o
         Uabw==
X-Gm-Message-State: APjAAAVgM01LZ+M9bpk3tbAvJgs2sjYKDBt3TSoMVF7uMCfBMJ+9zusv
        cqHDgq0cA85zXATLTFKhzfI2lqzSsfBhkUVWb7wlrw==
X-Google-Smtp-Source: APXvYqy5LdYjujwPG/GNIDMO7QbqBavPdokKpFKKOT0T9N5h6/PLHHuFvolyXiha0nYiMpVo6ooeYiDsZ9jT6+c0Il4=
X-Received: by 2002:a5d:968a:: with SMTP id m10mr2444564ion.134.1552765050651;
 Sat, 16 Mar 2019 12:37:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAEXW_YQMnbN+e-janGbZc5MH6MwdUdXNfonpLUu5O2nsSkJyeg@mail.gmail.com>
 <20190314204911.GA875@sultan-box.localdomain> <20190314231641.5a37932b@oasis.local.home>
 <CAKOZuetZHJzmQy3n001x4+rmWoWHEgUv2Zvow9W5+xvukxp1JQ@mail.gmail.com>
 <20190315180306.sq3z645p3hygrmt2@brauner.io> <20190315181324.GA248160@google.com>
 <20190315182426.sujcqbzhzw4llmsa@brauner.io> <20190315184903.GB248160@google.com>
 <CAJuCfpGp_9fE9MPGVCWjnTaeBE0K_Q22LS1pBqhp7zW2M=dbGw@mail.gmail.com>
 <CAKOZueuauUXRyrvhzBD0op6W4TAnydSx92bvrPN2VRWERX8iQg@mail.gmail.com> <20190316185726.jc53aqq5ph65ojpk@brauner.io>
In-Reply-To: <20190316185726.jc53aqq5ph65ojpk@brauner.io>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Sat, 16 Mar 2019 12:37:18 -0700
Message-ID: <CAJuCfpF-uYpUZ1RO99i2qEw5Ou4nSimSkiQvnNQ_rv8ogHKRfw@mail.gmail.com>
Subject: Re: [RFC] simple_lmk: Introduce Simple Low Memory Killer for Android
To:     Christian Brauner <christian@brauner.io>
Cc:     Daniel Colascione <dancol@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        Tim Murray <timmurray@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        linux-mm <linux-mm@kvack.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 16, 2019 at 11:57 AM Christian Brauner <christian@brauner.io> wrote:
>
> On Sat, Mar 16, 2019 at 11:00:10AM -0700, Daniel Colascione wrote:
> > On Sat, Mar 16, 2019 at 10:31 AM Suren Baghdasaryan <surenb@google.com> wrote:
> > >
> > > On Fri, Mar 15, 2019 at 11:49 AM Joel Fernandes <joel@joelfernandes.org> wrote:
> > > >
> > > > On Fri, Mar 15, 2019 at 07:24:28PM +0100, Christian Brauner wrote:
> > > > [..]
> > > > > > why do we want to add a new syscall (pidfd_wait) though? Why not just use
> > > > > > standard poll/epoll interface on the proc fd like Daniel was suggesting.
> > > > > > AFAIK, once the proc file is opened, the struct pid is essentially pinned
> > > > > > even though the proc number may be reused. Then the caller can just poll.
> > > > > > We can add a waitqueue to struct pid, and wake up any waiters on process
> > > > > > death (A quick look shows task_struct can be mapped to its struct pid) and
> > > > > > also possibly optimize it using Steve's TIF flag idea. No new syscall is
> > > > > > needed then, let me know if I missed something?
> > > > >
> > > > > Huh, I thought that Daniel was against the poll/epoll solution?
> > > >
> > > > Hmm, going through earlier threads, I believe so now. Here was Daniel's
> > > > reasoning about avoiding a notification about process death through proc
> > > > directory fd: http://lkml.iu.edu/hypermail/linux/kernel/1811.0/00232.html
> > > >
> > > > May be a dedicated syscall for this would be cleaner after all.
> > >
> > > Ah, I wish I've seen that discussion before...
> > > syscall makes sense and it can be non-blocking and we can use
> > > select/poll/epoll if we use eventfd.
> >
> > Thanks for taking a look.
> >
> > > I would strongly advocate for
> > > non-blocking version or at least to have a non-blocking option.
> >
> > Waiting for FD readiness is *already* blocking or non-blocking
> > according to the caller's desire --- users can pass options they want
> > to poll(2) or whatever. There's no need for any kind of special
> > configuration knob or non-blocking option. We already *have* a
> > non-blocking option that works universally for everything.
> >
> > As I mentioned in the linked thread, waiting for process exit should
> > work just like waiting for bytes to appear on a pipe. Process exit
> > status is just another blob of bytes that a process might receive. A
> > process exit handle ought to be just another information source. The
> > reason the unix process API is so awful is that for whatever reason
> > the original designers treated processes as some kind of special kind
> > of resource instead of fitting them into the otherwise general-purpose
> > unix data-handling API. Let's not repeat that mistake.
> >
> > > Something like this:
> > >
> > > evfd = eventfd(0, EFD_NONBLOCK | EFD_CLOEXEC);
> > > // register eventfd to receive death notification
> > > pidfd_wait(pid_to_kill, evfd);
> > > // kill the process
> > > pidfd_send_signal(pid_to_kill, ...)
> > > // tend to other things
> >
> > Now you've lost me. pidfd_wait should return a *new* FD, not wire up
> > an eventfd.
> >

Ok, I probably misunderstood your post linked by Joel. I though your
original proposal was based on being able to poll a file under
/proc/pid and then you changed your mind to have a separate syscall
which I assumed would be a blocking one to wait for process exit.
Maybe you can describe the new interface you are thinking about in
terms of userspace usage like I did above? Several lines of code would
explain more than paragraphs of text.

> > Why? Because the new type FD can report process exit *status*
> > information (via read(2) after readability signal) as well as this
> > binary yes-or-no signal *that* a process exited, and this capability
> > is useful if you want to the pidfd interface to be a good
> > general-purpose process management facility to replace the awful
> > wait() family of functions. You can't get an exit status from an
> > eventfd. Wiring up an eventfd the way you've proposed also complicates
> > wait-causality information, complicating both tracing and any priority
> > inheritance we might want in the future (because all the wakeups gets
> > mixed into the eventfd and you can't unscramble an egg). And for what?
> > What do we gain by using an eventfd? Is the reason that exit.c would
> > be able to use eventfd_signal instead of poking a waitqueue directly?
> > How is that better? With an eventfd, you've increased path length on
> > process exit *and* complicated the API for no reason.
> >
> > > ...
> > > // wait for the process to die
> > > poll_wait(evfd, ...);
> > >
> > > This simplifies userspace
> >
> > Not relative to an exit handle it doesn't.
> >
> > >, allows it to wait for multiple events using
> > > epoll
> >
> > So does a process exit status handle.
> >
> > > and I think kernel implementation will be also quite simple
> > > because it already implements eventfd_signal() that takes care of
> > > waitqueue handling.
> >
> > What if there are multiple eventfds registered for the death of a
> > process? In any case, you need some mechanism to find, upon process
> > death, a list of waiters, then wake each of them up. That's either a
> > global search or a search in some list rooted in a task-related
> > structure (either struct task or one of its friends). Using an eventfd
> > here adds nothing, since upon death, you need this list search
> > regardless, and as I mentioned above, eventfd-wiring just makes the
> > API worse.
> >
> > > If pidfd_send_signal could be extended to have an optional eventfd
> > > parameter then we would not even have to add a new syscall.
> >
> > There is nothing wrong with adding a new system call. I don't know why
> > there's this idea circulating that adding system calls is something we
> > should bend over backwards to avoid. It's cheap, and support-wise,
> > kernel interface is kernel interface. Sending a signal has *nothing*
> > to do with wiring up some kind of notification and there's no reason
> > to mingle it with some kind of event registration.
>
>
> I agree with Daniel.
> One design goal is to not stuff clearly delinated tasks related to
> process management into the same syscall. That will just leave us with a
> confusing api. Sending signals is part of managing a process while it is
> running. Waiting on a process to end is clearly separate from that.
> It's important to keep in mind that the goal of the pidfd work is to end
> up with an api that is of use to all of user space concerned with
> process management not just a specific project.

I'm not bent on adding or not adding a new syscall as long as
functionality is there.
Thanks!
