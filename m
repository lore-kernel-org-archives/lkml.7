Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D5B7C4360F
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 18:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A026218AC
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 18:57:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="PEOSV/ty"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbfCPS5c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 14:57:32 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40126 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726629AbfCPS5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 14:57:32 -0400
Received: by mail-wr1-f66.google.com with SMTP id t5so12853022wri.7
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2019 11:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ub1vGtP2nqrjRrbh30R9ZByYojTMeHTd+2HpvROIIfs=;
        b=PEOSV/ty7J4mmCwKHP50HLDgs/WxvMAOUTvNowgO/d33chQaEaG9S7fMEQNWbo9Feh
         vCveiCzrHvJ2YPoSGWk8B6ktkVK0G3GGs3QJR9RvN2AJ7s8VvSkPhmU+Mz0iL96DrYNR
         feYiRmyabAeVx1Nq6xx3D0wQ2J/9ZqdrqYxlYatBIia+PQrtn49j2HVPOX/rwcGEu2i5
         w8Og5d4rNgBIDd71szH8aIFviEeJCww5L2NsvzcqQUlrjiUIQ+4g5MsYqHzDjQcT0Tct
         hK+geQmuoxl9qBdM54Q+kPAZbODUokL8QV9RnswBHMAz6B9py1DLyppz2AMgxpeOrV78
         IsZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ub1vGtP2nqrjRrbh30R9ZByYojTMeHTd+2HpvROIIfs=;
        b=bQ3IPeQlhvwgiJoNNpR3oUh5TlmrxNU09yWiMee1I6+Zvw8nHbNmxIghT8P3SOgWFI
         DcFBVVjhOdDC85pHB+jDe/XIKR1RneOHaRmP1o19rgiaeUUHmtxqXUrwFqhIomXD+icp
         /gZi1qV9ijqH0CsjYmyxBEepxJ+5Lpus30IJD4a12Xj7wd6iujz8zvZsUTYWKcWJsfLP
         O6RGbBzrZyXv0fWXWOqSr9l1cB+T+jktHKjo0VS3ijN7EQ7A6LZBAuLgNxBsi2y1sVPu
         oeLz4B4om84uJo5D2rs9SWb6j+Rn1CtmqYoxyafvXaax/FJbWmDBYHPXeD3Haw1M0hxV
         3mAg==
X-Gm-Message-State: APjAAAXh3+7KRPrYbXHerH1I1rl7PWW36TWk+N/qkUPY3KQw4fNJt6i4
        tU5MNAQs1m/G+mS7Os0UvN+Tpg==
X-Google-Smtp-Source: APXvYqx00gtEKaFTrLOhwFBQ3Sgss+e+CmJEE30+2vf4COBOVu55ifr0muaCyuB3ZRZPQNIUrA8oJQ==
X-Received: by 2002:adf:eac6:: with SMTP id o6mr6283404wrn.77.1552762649351;
        Sat, 16 Mar 2019 11:57:29 -0700 (PDT)
Received: from brauner.io (p200300EA6F1466D1DD26CBB71DBC50AF.dip0.t-ipconnect.de. [2003:ea:6f14:66d1:dd26:cbb7:1dbc:50af])
        by smtp.gmail.com with ESMTPSA id b3sm5457613wrx.57.2019.03.16.11.57.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 16 Mar 2019 11:57:28 -0700 (PDT)
Date:   Sat, 16 Mar 2019 19:57:27 +0100
From:   Christian Brauner <christian@brauner.io>
To:     Daniel Colascione <dancol@google.com>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        Tim Murray <timmurray@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        linux-mm <linux-mm@kvack.org>,
        kernel-team <kernel-team@android.com>
Subject: Re: [RFC] simple_lmk: Introduce Simple Low Memory Killer for Android
Message-ID: <20190316185726.jc53aqq5ph65ojpk@brauner.io>
References: <CAEXW_YQMnbN+e-janGbZc5MH6MwdUdXNfonpLUu5O2nsSkJyeg@mail.gmail.com>
 <20190314204911.GA875@sultan-box.localdomain>
 <20190314231641.5a37932b@oasis.local.home>
 <CAKOZuetZHJzmQy3n001x4+rmWoWHEgUv2Zvow9W5+xvukxp1JQ@mail.gmail.com>
 <20190315180306.sq3z645p3hygrmt2@brauner.io>
 <20190315181324.GA248160@google.com>
 <20190315182426.sujcqbzhzw4llmsa@brauner.io>
 <20190315184903.GB248160@google.com>
 <CAJuCfpGp_9fE9MPGVCWjnTaeBE0K_Q22LS1pBqhp7zW2M=dbGw@mail.gmail.com>
 <CAKOZueuauUXRyrvhzBD0op6W4TAnydSx92bvrPN2VRWERX8iQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKOZueuauUXRyrvhzBD0op6W4TAnydSx92bvrPN2VRWERX8iQg@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 16, 2019 at 11:00:10AM -0700, Daniel Colascione wrote:
> On Sat, Mar 16, 2019 at 10:31 AM Suren Baghdasaryan <surenb@google.com> wrote:
> >
> > On Fri, Mar 15, 2019 at 11:49 AM Joel Fernandes <joel@joelfernandes.org> wrote:
> > >
> > > On Fri, Mar 15, 2019 at 07:24:28PM +0100, Christian Brauner wrote:
> > > [..]
> > > > > why do we want to add a new syscall (pidfd_wait) though? Why not just use
> > > > > standard poll/epoll interface on the proc fd like Daniel was suggesting.
> > > > > AFAIK, once the proc file is opened, the struct pid is essentially pinned
> > > > > even though the proc number may be reused. Then the caller can just poll.
> > > > > We can add a waitqueue to struct pid, and wake up any waiters on process
> > > > > death (A quick look shows task_struct can be mapped to its struct pid) and
> > > > > also possibly optimize it using Steve's TIF flag idea. No new syscall is
> > > > > needed then, let me know if I missed something?
> > > >
> > > > Huh, I thought that Daniel was against the poll/epoll solution?
> > >
> > > Hmm, going through earlier threads, I believe so now. Here was Daniel's
> > > reasoning about avoiding a notification about process death through proc
> > > directory fd: http://lkml.iu.edu/hypermail/linux/kernel/1811.0/00232.html
> > >
> > > May be a dedicated syscall for this would be cleaner after all.
> >
> > Ah, I wish I've seen that discussion before...
> > syscall makes sense and it can be non-blocking and we can use
> > select/poll/epoll if we use eventfd.
> 
> Thanks for taking a look.
> 
> > I would strongly advocate for
> > non-blocking version or at least to have a non-blocking option.
> 
> Waiting for FD readiness is *already* blocking or non-blocking
> according to the caller's desire --- users can pass options they want
> to poll(2) or whatever. There's no need for any kind of special
> configuration knob or non-blocking option. We already *have* a
> non-blocking option that works universally for everything.
> 
> As I mentioned in the linked thread, waiting for process exit should
> work just like waiting for bytes to appear on a pipe. Process exit
> status is just another blob of bytes that a process might receive. A
> process exit handle ought to be just another information source. The
> reason the unix process API is so awful is that for whatever reason
> the original designers treated processes as some kind of special kind
> of resource instead of fitting them into the otherwise general-purpose
> unix data-handling API. Let's not repeat that mistake.
> 
> > Something like this:
> >
> > evfd = eventfd(0, EFD_NONBLOCK | EFD_CLOEXEC);
> > // register eventfd to receive death notification
> > pidfd_wait(pid_to_kill, evfd);
> > // kill the process
> > pidfd_send_signal(pid_to_kill, ...)
> > // tend to other things
> 
> Now you've lost me. pidfd_wait should return a *new* FD, not wire up
> an eventfd.
> 
> Why? Because the new type FD can report process exit *status*
> information (via read(2) after readability signal) as well as this
> binary yes-or-no signal *that* a process exited, and this capability
> is useful if you want to the pidfd interface to be a good
> general-purpose process management facility to replace the awful
> wait() family of functions. You can't get an exit status from an
> eventfd. Wiring up an eventfd the way you've proposed also complicates
> wait-causality information, complicating both tracing and any priority
> inheritance we might want in the future (because all the wakeups gets
> mixed into the eventfd and you can't unscramble an egg). And for what?
> What do we gain by using an eventfd? Is the reason that exit.c would
> be able to use eventfd_signal instead of poking a waitqueue directly?
> How is that better? With an eventfd, you've increased path length on
> process exit *and* complicated the API for no reason.
> 
> > ...
> > // wait for the process to die
> > poll_wait(evfd, ...);
> >
> > This simplifies userspace
> 
> Not relative to an exit handle it doesn't.
> 
> >, allows it to wait for multiple events using
> > epoll
> 
> So does a process exit status handle.
> 
> > and I think kernel implementation will be also quite simple
> > because it already implements eventfd_signal() that takes care of
> > waitqueue handling.
> 
> What if there are multiple eventfds registered for the death of a
> process? In any case, you need some mechanism to find, upon process
> death, a list of waiters, then wake each of them up. That's either a
> global search or a search in some list rooted in a task-related
> structure (either struct task or one of its friends). Using an eventfd
> here adds nothing, since upon death, you need this list search
> regardless, and as I mentioned above, eventfd-wiring just makes the
> API worse.
> 
> > If pidfd_send_signal could be extended to have an optional eventfd
> > parameter then we would not even have to add a new syscall.
> 
> There is nothing wrong with adding a new system call. I don't know why
> there's this idea circulating that adding system calls is something we
> should bend over backwards to avoid. It's cheap, and support-wise,
> kernel interface is kernel interface. Sending a signal has *nothing*
> to do with wiring up some kind of notification and there's no reason
> to mingle it with some kind of event registration.


I agree with Daniel.
One design goal is to not stuff clearly delinated tasks related to
process management into the same syscall. That will just leave us with a
confusing api. Sending signals is part of managing a process while it is
running. Waiting on a process to end is clearly separate from that.
It's important to keep in mind that the goal of the pidfd work is to end
up with an api that is of use to all of user space concerned with
process management not just a specific project.
