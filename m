Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 040F1C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 14:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBB982186A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 14:15:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YruH5Z8k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbfDLOPx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 10:15:53 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36394 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbfDLOPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 10:15:52 -0400
Received: by mail-wr1-f68.google.com with SMTP id y13so12207498wrd.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 07:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=isbfV1XuLmSpqEnWQt10kSQKeIpdWz/ULZrB6D6jy+I=;
        b=YruH5Z8k4xgBUu9CWgTjJxHl9UejxUlH4wKD2JYwoVT1K9bMqY2J0WZ4aH0XowCf//
         PLimMyeT9FQxLNkGP5+rF6qZrPR5v40N9+ob4Ni2vTf6QS1ojN17wnaqP1NF/ezgvNpL
         q4t5yrXc2C1MhGV5BLsB7qRIA0KVy6rXdRmdCkue2x8a1iHwKrzOf7t6NJZUj8bUemYd
         brERkcwx4YaBMgOPn1TycG4owa7UkE89eBHGApo1DDT3j34IjoqXmEjBefuTslWywqhW
         s0NUzc7Bnjdn355uD7LTANNF9cpjTDWW2k0Rk6IRkQV79g997xLIlBWM5Rl12JJjGLcF
         oM6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=isbfV1XuLmSpqEnWQt10kSQKeIpdWz/ULZrB6D6jy+I=;
        b=MuB3N91M4p+YuLP5djJkonCt6sez++e+nV03sq9ZiysSQD+pWU1NoHltLEtR4/OtVi
         Th6S4GDGszVI/lxU8L4SKvMUSJHGPjqg23IH7HavRNk/ksbrqnVPJvuSUpnDZwZ5mZHS
         79k5Fgmw1TBe/ImTJigFeMhDRSH7UNpX37FHDiBAr30EBBNZtHRuKFFct3XizW8mhucK
         eNd2S+cQs3V4aFfW80xbHqR62PM3ZqhbhB5qNH2EjKn/plSxbsB8Nd4JVC9ykgpmSY9t
         PVOZT3RJ45BTLpWNSXHDzzRU5GvG3wmifulT0cqBl4+LGXbn0a7tKFGb9iDzXbtstgOp
         d2Qw==
X-Gm-Message-State: APjAAAVVhesmTTLFC6cumeuBgYQBzWz6jlmvT5wgcG7AlBDwBcKeulND
        kiuniJJwsp4ViH42oJ/Z0oPLfb8in9S5msckcTpv7Q==
X-Google-Smtp-Source: APXvYqyTWIVUGogwRz9I6WBbV2kdbjd9f4qSSX9DwdSED9R2DW1oXEigJDSNwpZHBM55VZPccwUi49k0BSHfPsU/Kdc=
X-Received: by 2002:adf:cf0c:: with SMTP id o12mr16912460wrj.16.1555078549686;
 Fri, 12 Apr 2019 07:15:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190411014353.113252-1-surenb@google.com> <20190411014353.113252-3-surenb@google.com>
 <20190411153313.GE22763@bombadil.infradead.org> <CAJuCfpGQ8c-OCws-zxZyqKGy1CfZpjxDKMH__qAm5FFXBcnWOw@mail.gmail.com>
 <CAKOZuetFU4tXE27bxA86zzDfNSCbw83p8fPxfkQ_d_Em0C04Sg@mail.gmail.com>
 <20190411173649.GF22763@bombadil.infradead.org> <CAKOZuet8-en+tMYu_QqVCxmkak44T7MnmRgfJBot0+P_A+Qzkw@mail.gmail.com>
 <20190412064925.GB13373@dhcp22.suse.cz>
In-Reply-To: <20190412064925.GB13373@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 12 Apr 2019 07:15:38 -0700
Message-ID: <CAJuCfpEHhcrGFxsCmPsZu=aPmYDB0yCeb2Fhs405eH3os-amuQ@mail.gmail.com>
Subject: Re: [RFC 2/2] signal: extend pidfd_send_signal() to allow expedited
 process killing
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Daniel Colascione <dancol@google.com>,
        Matthew Wilcox <willy@infradead.org>,
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
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 11:49 PM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Thu 11-04-19 10:47:50, Daniel Colascione wrote:
> > On Thu, Apr 11, 2019 at 10:36 AM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > On Thu, Apr 11, 2019 at 10:33:32AM -0700, Daniel Colascione wrote:
> > > > On Thu, Apr 11, 2019 at 10:09 AM Suren Baghdasaryan <surenb@google.com> wrote:
> > > > > On Thu, Apr 11, 2019 at 8:33 AM Matthew Wilcox <willy@infradead.org> wrote:
> > > > > >
> > > > > > On Wed, Apr 10, 2019 at 06:43:53PM -0700, Suren Baghdasaryan wrote:
> > > > > > > Add new SS_EXPEDITE flag to be used when sending SIGKILL via
> > > > > > > pidfd_send_signal() syscall to allow expedited memory reclaim of the
> > > > > > > victim process. The usage of this flag is currently limited to SIGKILL
> > > > > > > signal and only to privileged users.
> > > > > >
> > > > > > What is the downside of doing expedited memory reclaim?  ie why not do it
> > > > > > every time a process is going to die?
> > > > >
> > > > > I think with an implementation that does not use/abuse oom-reaper
> > > > > thread this could be done for any kill. As I mentioned oom-reaper is a
> > > > > limited resource which has access to memory reserves and should not be
> > > > > abused in the way I do in this reference implementation.
> > > > > While there might be downsides that I don't know of, I'm not sure it's
> > > > > required to hurry every kill's memory reclaim. I think there are cases
> > > > > when resource deallocation is critical, for example when we kill to
> > > > > relieve resource shortage and there are kills when reclaim speed is
> > > > > not essential. It would be great if we can identify urgent cases
> > > > > without userspace hints, so I'm open to suggestions that do not
> > > > > involve additional flags.
> > > >
> > > > I was imagining a PI-ish approach where we'd reap in case an RT
> > > > process was waiting on the death of some other process. I'd still
> > > > prefer the API I proposed in the other message because it gets the
> > > > kernel out of the business of deciding what the right signal is. I'm a
> > > > huge believer in "mechanism, not policy".
> > >
> > > It's not a question of the kernel deciding what the right signal is.
> > > The kernel knows whether a signal is fatal to a particular process or not.
> > > The question is whether the killing process should do the work of reaping
> > > the dying process's resources sometimes, always or never.  Currently,
> > > that is never (the process reaps its own resources); Suren is suggesting
> > > sometimes, and I'm asking "Why not always?"
> >
> > FWIW, Suren's initial proposal is that the oom_reaper kthread do the
> > reaping, not the process sending the kill. Are you suggesting that
> > sending SIGKILL should spend a while in signal delivery reaping pages
> > before returning? I thought about just doing it this way, but I didn't
> > like the idea: it'd slow down mass-killing programs like killall(1).
> > Programs expect sending SIGKILL to be a fast operation that returns
> > immediately.
>
> I was thinking about this as well. And SYNC_SIGKILL would workaround the
> current expectations of how quick the current implementation is. The
> harder part would what is the actual semantic. Does the kill wait until
> the target task is TASK_DEAD or is there an intermediate step that would
> we could call it end of the day and still have a reasonable semantic
> (e.g. the original pid is really not alive anymore).

I think Daniel's proposal was trying to address that. With an input of
how many pages user wants to reclaim asynchronously and return value
of how much was actually reclaimed it contains the condition when to
stop and the reply how successful we could accomplish that. Since it
returns the number of pages reclaimed I assume the call does not
return until it reaped enough pages.

> --
> Michal Hocko
> SUSE Labs
