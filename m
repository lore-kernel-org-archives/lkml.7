Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59E7AC3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 23:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2840E20659
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 23:52:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sda3+gFD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728407AbfH3Xw4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 19:52:56 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:42148 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728221AbfH3Xwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 19:52:55 -0400
Received: by mail-io1-f65.google.com with SMTP id n197so15515346iod.9
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 16:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Grw5m/9iyUfRxEC4Tarb8ft6trOlHmlqrEuwyBK7mxE=;
        b=sda3+gFD5O8yZ1fUjM5uXTheXQ6e0+FiglpdmzVjctbs5fP9p7YBKrRlm59QGlYI3Q
         q50h2ta+dGegC9ZECilJATbl3ScVRdLKb5gbSsnCWhxrkbHq9OBv8gE535x3vzZ75OXQ
         jZm2bk0EbyQiMYR4pwkSWwEKtDZPovJonbQN/lF6hke6tvIce850OQG9HAH6rlYPA6Xd
         S5mQNY7/lKnYp1OVFBYYQTAIUcklMjUJNPRzS9Xpv4RLFuHVWVkVwgD047pteUNrYj87
         +V+hmj+lX0kTn6H8MPq/m+PVjxKvsLN5j6OY+HBdLtB+NYBp47RlZTKnOwsH9hxR/Ohi
         xyFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Grw5m/9iyUfRxEC4Tarb8ft6trOlHmlqrEuwyBK7mxE=;
        b=OWyjME75Y2QxHUAfz65YC6DXyWSwjXQTRRdWzzu+jVmGpxCj5egTOKrCN17nrAOvlk
         CRazhbXegm6QOWKSxrupGkdWFzQsRNwikEeHHzNMEiG+7boyG9A2tqmtiDkWQA0zPdBk
         1J3GIpsd7H/HHVei4G4DkJQtxOv+W3yDRmDkJjHZj4ZI/yZOl0QFGKxaYovhjwLSOOUI
         /JEAhgk/HYBNYfvthmyPOG+mHPqiMdNW7NZX5b/B8SOeMSTBose/QZd+iZqxKWQeufMp
         uui0J9dONqGJkrFv7v/lu/6rriyOfC9hQyAecyzVgoEiWMO2SS3pTkbwkihSyr/cN+si
         MFyw==
X-Gm-Message-State: APjAAAV/KhtFjZuZ3nOnlK2/jdgeuaseMsfbiDWWaBDt5l4SLPPGOEqi
        1jE6BjnYFgrni8wW6BbWAQcAtk0nPL11Muk2D1vYZQ==
X-Google-Smtp-Source: APXvYqxShgmN9+QrN64msqGZbYS5AEmQHAMjlF4KP/j1UgA/zTJvz+HZ1LVcxO5K5H9KMIcTlOd5RXSv421gn9pK0Ds=
X-Received: by 2002:a02:b609:: with SMTP id h9mr18318588jam.36.1567209174320;
 Fri, 30 Aug 2019 16:52:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190828073130.83800-1-namhyung@kernel.org> <20190828073130.83800-2-namhyung@kernel.org>
 <20190828094459.GG2369@hirez.programming.kicks-ass.net> <CAM9d7cja=jh9ASa4ffCca34AHcB-aRkyWj9hAQbEoQf8qOcg9w@mail.gmail.com>
 <20190830073448.GZ2369@hirez.programming.kicks-ass.net> <CAM9d7chvUy5kdHbvXvmrQ39Vojgy0ZZY3smbMQfWZzTxzy0wTg@mail.gmail.com>
In-Reply-To: <CAM9d7chvUy5kdHbvXvmrQ39Vojgy0ZZY3smbMQfWZzTxzy0wTg@mail.gmail.com>
From:   Stephane Eranian <eranian@google.com>
Date:   Fri, 30 Aug 2019 16:52:42 -0700
Message-ID: <CABPqkBSNsBr7+z_BptRFGSE6Cp3vkbiVXrk+t89UgDW5c-Vf-Q@mail.gmail.com>
Subject: Re: [PATCH 1/9] perf/core: Add PERF_RECORD_CGROUP event
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2019 at 3:49 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> On Fri, Aug 30, 2019 at 4:35 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Fri, Aug 30, 2019 at 12:46:51PM +0900, Namhyung Kim wrote:
> > > Hi Peter,
> > >
> > > On Wed, Aug 28, 2019 at 6:45 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > > >
> > > > On Wed, Aug 28, 2019 at 04:31:22PM +0900, Namhyung Kim wrote:
> > > > > To support cgroup tracking, add CGROUP event to save a link between
> > > > > cgroup path and inode number.  The attr.cgroup bit was also added to
> > > > > enable cgroup tracking from userspace.
> > > > >
> > > > > This event will be generated when a new cgroup becomes active.
> > > > > Userspace might need to synthesize those events for existing cgroups.
> > > > >
> > > > > As aux_output change is also going on, I just added the bit here as
> > > > > well to remove possible conflicts later.
> > > >
> > > > Why do we want this?
> > >
> > > I saw below [1] and thought you have the patch introduced aux_output
> > > and it's gonna to be merged soon.
> > > Also the tooling patches are already in the acme/perf/core
> > > so I just wanted to avoid conflicts.
> > >
> > > Anyway, I'm ok with changing it.  Will remove in v2.
> >
> > I seem to have confused both you and Arnaldo with this. This email
> > questions the Changelog as a whole, not just the aux thing (I send a
> > separate email for that).
> >
> > This Changelog utterly fails to explain to me _why_ we need/want cgroup
> > tracking. So why do I want to review and possibly merge this? Changelog
> > needs to answer this.
>
> OK.  How about this?
>
> Systems running a large number of jobs in different cgroups want to
> profiling such jobs precisely.  This includes container hosting systems
> widely used today.  Currently perf supports namespace tracking but
> the systems may not use (cgroup) namespace for their jobs.  Also
> it'd be more intuitive to see cgroup names (as they're given by user
> or sysadmin) rather than numeric cgroup/namespace id even if they
> use the namespaces.
>

In data centers you care about attributing samples to a job not such
much to a process.
A job may have multiple processes which may come and go. The cgroup on
the other hand
stays around for the entire lifetime of the job. It is much easier to
map a cgroup name to a particular
job than it is to map a pid back to a job name, especially for offline
post-processing.

Hope this clarifies why we would like this feature upstream.


>
> Thanks,
> Namhyung
