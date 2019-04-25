Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 563ABC43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 16:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A195E20651
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 16:10:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OnNbUkaI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbfDYQKC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 12:10:02 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53753 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbfDYQKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 12:10:01 -0400
Received: by mail-wm1-f66.google.com with SMTP id 26so19213wmj.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 09:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kHfu24V2nbXQ/IUQMqdxKXSBz0OftONrexhtdDDcmec=;
        b=OnNbUkaIqKey5FD39I/mMhgGJ6J90AaU0MfsUf4/yMHh0m75nA9h6sx0SxAlrSru0P
         agUxhMvykSSSY+YGlmuegn/BYFh1TDJGFHMHS0iODqnnUcnoZ0jakM+h5OqhKJm3+Hy2
         M3wSaAZRL3aozz3Uhauk4YLqRVlzraZ3rU+vUm37elDUTIw34N9caVO+QkajMWx0pT1X
         9GgrMO6GXwWz6YvkEPoOzRh3XJSmrk2YrJyyZiH2CoeZGPhVFcdWFd9z5Q1lQLK0dmvH
         upDdZB7NtcqYFB8rhPbxleqV+EPdviqF4quTRoXwhDjfpTVCikeIyR7lEaP9ZIlI3/Wr
         VYAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kHfu24V2nbXQ/IUQMqdxKXSBz0OftONrexhtdDDcmec=;
        b=Zv28jqXHTbIduC1wflhr2elhmgH13AHbvin069Qd61t9BNoW3knCjK4dNPZnigxYay
         9ACqHP90WG6JS1mZ4mg0qvcHZHSZUHtuszbRepxDpafVudwI11mqJIKFWUMfPd2R9NlX
         +IWeseLF7f/A+aS3EdCLkYgUWVspK2c9UE4dAc02z761p+qXJMbiRW2wBtzQSNdrMSIq
         8M/MHih7BSEKoLjGpmi1tOSH93fJQeYszvJ5UzITKWffKUS46wXyKt7+NBIb0wTc2rQM
         CZhvbQB6WuVg0uAmnTi71fNfKfScYQQ2LPqn5m/xnqrKobhl1MhGUoOCdyp2sA+QTi54
         EYRA==
X-Gm-Message-State: APjAAAUehb6AkuQl6Tk/aw/mGvnMYWjU8byV7vL3TpTAPGSsk/b+z1H4
        vMbVdMAzqurqcWBWExRU0MBG2jms25AQpfx5EMfmiA==
X-Google-Smtp-Source: APXvYqz3H4/iLoiWRaQeNU7ZMerLf+kKKfzochV0gZw5KevLdBnY3GwqLv98mSVjgzyEIuUH7AL6GEPsJIfrBVywY64=
X-Received: by 2002:a1c:2109:: with SMTP id h9mr4234995wmh.68.1556208598710;
 Thu, 25 Apr 2019 09:09:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190411014353.113252-1-surenb@google.com> <20190411014353.113252-3-surenb@google.com>
 <20190411153313.GE22763@bombadil.infradead.org> <20190412065314.GC13373@dhcp22.suse.cz>
 <CAKOZuetQH1rVtPdMNgw0sdnzWidd6v9eCWscRiOb7Y+3-JQ14Q@mail.gmail.com>
In-Reply-To: <CAKOZuetQH1rVtPdMNgw0sdnzWidd6v9eCWscRiOb7Y+3-JQ14Q@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 25 Apr 2019 09:09:46 -0700
Message-ID: <CAJuCfpHQm5=QrOiOQ4thA5FmRUQjNGdSfis=iEaNGv7npmMVxQ@mail.gmail.com>
Subject: Re: [RFC 2/2] signal: extend pidfd_send_signal() to allow expedited
 process killing
To:     Daniel Colascione <dancol@google.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        yuzhoujian@didichuxing.com,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Shakeel Butt <shakeelb@google.com>,
        Christian Brauner <christian@brauner.io>,
        Minchan Kim <minchan@kernel.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jann Horn <jannh@google.com>, linux-mm <linux-mm@kvack.org>,
        lsf-pc@lists.linux-foundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2019 at 7:14 AM Daniel Colascione <dancol@google.com> wrote:
>
> On Thu, Apr 11, 2019 at 11:53 PM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > On Thu 11-04-19 08:33:13, Matthew Wilcox wrote:
> > > On Wed, Apr 10, 2019 at 06:43:53PM -0700, Suren Baghdasaryan wrote:
> > > > Add new SS_EXPEDITE flag to be used when sending SIGKILL via
> > > > pidfd_send_signal() syscall to allow expedited memory reclaim of the
> > > > victim process. The usage of this flag is currently limited to SIGKILL
> > > > signal and only to privileged users.
> > >
> > > What is the downside of doing expedited memory reclaim?  ie why not do it
> > > every time a process is going to die?
> >
> > Well, you are tearing down an address space which might be still in use
> > because the task not fully dead yeat. So there are two downsides AFAICS.
> > Core dumping which will not see the reaped memory so the resulting
>
> Test for SIGNAL_GROUP_COREDUMP before doing any of this then. If you
> try to start a core dump after reaping begins, too bad: you could have
> raced with process death anyway.
>
> > coredump might be incomplete. And unexpected #PF/gup on the reaped
> > memory will result in SIGBUS.
>
> It's a dying process. Why even bother returning from the fault
> handler? Just treat that situation as a thread exit. There's no need
> to make this observable to userspace at all.

I've spent some more time to investigate possible effects of reaping
on coredumps and asked Oleg Nesterov who worked on patchsets that
prioritize SIGKILLs over coredump activity
(https://lkml.org/lkml/2013/2/17/118). Current do_coredump
implementation seems to handle the case of SIGKILL interruption by
bailing out whenever dump_interrupted() returns true and that would be
the case with pending SIGKILL. So in the case of race when coredump
happens first and SIGKILL comes next interrupting the coredump seems
to result in no change in behavior and reaping memory proactively
seems to have no side effects.
An opposite race when SIGKILL gets posted and then coredump happens
seems impossible because do_coredump won't be called from get_signal
due to signal_group_exit check (get_signal checks signal_group_exit
while holding sighand->siglock and complete_signal sets
SIGNAL_GROUP_EXIT while holding the same lock). There is a path from
__seccomp_filter calling do_coredump while processing
SECCOMP_RET_KILL_xxx but even then it should bail out when
coredump_wait()->zap_threads(current) checks signal_group_exit().
(Thanks Oleg for clarifying this for me).

If we are really concerned about possible increase in failed coredumps
because of the proactive reaping I could make it conditional on
whether coredumping mm is possible by placing this feature behind
!get_dumpable(mm) condition. Another possibility is to check
RLIMIT_CORE to decide if coredumps are possible (although if pipe is
used for coredump that limit seems to be ignored, so that check would
have to take this into consideration).

On the issue of SIGBUS happening when accessed memory was already
reaped, my understanding that SIGBUS being a synchronous signal will
still have to be fetched using dequeue_synchronous_signal from
get_signal but not before signal_group_exit is checked. So again if
SIGKILL is pending I think SIGBUS will be ignored (please correct me
if that's not correct).

One additional question I would like to clarify is whether per-node
reapers like Roman suggested would make a big difference (All CPUs
that I've seen used for Android are single-node ones, so looking for
more feedback here). If it's important then reaping victim's memory by
the killer is probably not an option.
