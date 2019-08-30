Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6252C3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 22:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A49C32343A
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 22:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567205393;
	bh=LoojBEqOKyclyDEg7MlS/m0RPebqTIIXbjRYzf3SNpE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=E+F4vzpRWYppnlfbjtTjkJpz1zunjB7XbW3PDmFpxT0PalbdLQtwuvNe+rla07cM1
	 SKzYRjEirSzsnchYUCpAosQ/9MvGLX9eoB2H4LX7p/QevAf0yZKkdTWAoe/hUTmnlR
	 /Fi52nl2YTHcah+Fy0QWNwSfKY73LLmcSyJQxKGE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbfH3Wtw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 18:49:52 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54825 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728111AbfH3Wtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 18:49:52 -0400
Received: by mail-wm1-f66.google.com with SMTP id k2so7449979wmj.4
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 15:49:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f5WdOIPu1oiEeaXbTGBed5WeVzN99HYIaxurb769P28=;
        b=IIBCQI80HrX+eO4h047UouohclR9DBZDKs+xZVoBY7HX4sBbI+aQskJcBI1tX5IqK/
         M1qcN4e9FW6OULlNbIRTGTR7r1d8l864t0NEZ+tECG//bJBWBq4NaQUvrPClJD8lfbKS
         v1AX3WJx/00ijbEHDYGouZidC6D3xCG9CBtW4MqlxtjKiKcLIAPUze7MSUrxyH7KU0p1
         PcFdij+V/KiSIm+Uwc7o/hCXvUhqBL8fV2dWAfFAjHrt0PhUGZQbq3j29V1t2In3+X1V
         3lUxi01uXP7U66zq6XBUBopa6hqTIIw5Sul+wH9QJcCPLgF8BZ2ulvYa9xcSfnF1jNjZ
         UV3w==
X-Gm-Message-State: APjAAAVktIJeAdIfB9XQhh3ud2wUz+CqiEF6fkYN+9z5H/AoCQTDjrR2
        2zzzXRkCQNGBbRlhdc40cyV1cYHtAUCMcKEM2r8=
X-Google-Smtp-Source: APXvYqym3YXjGzc33FgToZ209zBn7zZDfRVDiv9g/acwXUBz0eQINswVvQYb0JxOaQm1ZVIpUmb2lu0BuFv7MQLVhU4=
X-Received: by 2002:a7b:c198:: with SMTP id y24mr20732420wmi.131.1567205389892;
 Fri, 30 Aug 2019 15:49:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190828073130.83800-1-namhyung@kernel.org> <20190828073130.83800-2-namhyung@kernel.org>
 <20190828094459.GG2369@hirez.programming.kicks-ass.net> <CAM9d7cja=jh9ASa4ffCca34AHcB-aRkyWj9hAQbEoQf8qOcg9w@mail.gmail.com>
 <20190830073448.GZ2369@hirez.programming.kicks-ass.net>
In-Reply-To: <20190830073448.GZ2369@hirez.programming.kicks-ass.net>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Sat, 31 Aug 2019 07:49:38 +0900
Message-ID: <CAM9d7chvUy5kdHbvXvmrQ39Vojgy0ZZY3smbMQfWZzTxzy0wTg@mail.gmail.com>
Subject: Re: [PATCH 1/9] perf/core: Add PERF_RECORD_CGROUP event
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2019 at 4:35 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Aug 30, 2019 at 12:46:51PM +0900, Namhyung Kim wrote:
> > Hi Peter,
> >
> > On Wed, Aug 28, 2019 at 6:45 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Wed, Aug 28, 2019 at 04:31:22PM +0900, Namhyung Kim wrote:
> > > > To support cgroup tracking, add CGROUP event to save a link between
> > > > cgroup path and inode number.  The attr.cgroup bit was also added to
> > > > enable cgroup tracking from userspace.
> > > >
> > > > This event will be generated when a new cgroup becomes active.
> > > > Userspace might need to synthesize those events for existing cgroups.
> > > >
> > > > As aux_output change is also going on, I just added the bit here as
> > > > well to remove possible conflicts later.
> > >
> > > Why do we want this?
> >
> > I saw below [1] and thought you have the patch introduced aux_output
> > and it's gonna to be merged soon.
> > Also the tooling patches are already in the acme/perf/core
> > so I just wanted to avoid conflicts.
> >
> > Anyway, I'm ok with changing it.  Will remove in v2.
>
> I seem to have confused both you and Arnaldo with this. This email
> questions the Changelog as a whole, not just the aux thing (I send a
> separate email for that).
>
> This Changelog utterly fails to explain to me _why_ we need/want cgroup
> tracking. So why do I want to review and possibly merge this? Changelog
> needs to answer this.

OK.  How about this?

Systems running a large number of jobs in different cgroups want to
profiling such jobs precisely.  This includes container hosting systems
widely used today.  Currently perf supports namespace tracking but
the systems may not use (cgroup) namespace for their jobs.  Also
it'd be more intuitive to see cgroup names (as they're given by user
or sysadmin) rather than numeric cgroup/namespace id even if they
use the namespaces.

Thanks,
Namhyung
