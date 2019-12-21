Return-Path: <SRS0=ztpy=2L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08289C2D0C0
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 08:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE7F6206D3
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 08:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576918156;
	bh=fK1OqlPP2BOyAoHVbXH8LIc2RflvNPU2fIk8Rn5JhV4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=fxmajH8ZVqRlaTpFNrgx3hjHWbx2JxHIZIuyoTF1ARSspFg7QXa9xkVCQqXEeqF3w
	 +ZMk4SoILxcpYXVrLHt+dWdSIFq9egfuKAqiUi4PISoKAw1oUcxgbwUi9NwTQnxLyv
	 L3J2846ns2vpCFWTVWvhUjWDXWMFzszkUD7EAIDM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbfLUItQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Dec 2019 03:49:16 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34503 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbfLUItP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Dec 2019 03:49:15 -0500
Received: by mail-wr1-f66.google.com with SMTP id t2so11624203wrr.1;
        Sat, 21 Dec 2019 00:49:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tH9GwKFKZoJ5vY+eHR+9ufhWpSkZJ1e+/MW4k6qXbI0=;
        b=kcr6+h4oV2KqnboDSzxJL6INQW5FIdDEbFc5TKJJMZxRieNxFZEV2Htc8WQQyocBi+
         zGp5kxbdKrqeZ1gbVvkO6W6wHNI1dVqkeO03gULRvTxrJRhC+87/WZlU4CMsPhqYct2W
         Hz73b1W2cN5V60AMADk49fN0kFgKeGi57KyVlLkAtX5ZgfwPLTzxCA9mfRnWIza5wUQI
         HkMqJyzC2PCmf6nvH3zzBsiIRlTOhbCxv9ALv98N8HMBOeeCw3HIS13w6V2/hmCPvwf2
         FxHYIWKbpgB1KGxUqcZQu9IA+q4R3U6+qvBZweTU6B2WDG3yGbQJiu8TKS5J0s+EKqyu
         veOw==
X-Gm-Message-State: APjAAAUnFOFEeWYZWIHZwLF5FdIMv+BKkOpmtvMUJgqVJxMiMr9V359d
        NbAX5yEz1ud2d3u2w3eERwvRUHLKy/h9diRTa38=
X-Google-Smtp-Source: APXvYqy7FxDH4hiEyAUPYf/k0mhxN3xlRhCD7z369wlrPWIAePF0DnCXAlc7bX87tqddaoBVnmFvALfHz+vYZp34pbw=
X-Received: by 2002:adf:ef10:: with SMTP id e16mr18725296wro.336.1576918153617;
 Sat, 21 Dec 2019 00:49:13 -0800 (PST)
MIME-Version: 1.0
References: <20191220043253.3278951-1-namhyung@kernel.org> <20191220043253.3278951-2-namhyung@kernel.org>
 <20191220093335.GC2844@hirez.programming.kicks-ass.net> <20191220151622.GF2914998@devbig004.ftw2.facebook.com>
In-Reply-To: <20191220151622.GF2914998@devbig004.ftw2.facebook.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Sat, 21 Dec 2019 17:49:02 +0900
Message-ID: <CAM9d7cjmrmyGnYQQ5qUFHYVi2M3kcxt+u+4WQ4PPkoaUgU+5=w@mail.gmail.com>
Subject: Re: [PATCH 1/9] perf/core: Add PERF_RECORD_CGROUP event
To:     Tejun Heo <tj@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tejun,

On Sat, Dec 21, 2019 at 12:16 AM Tejun Heo <tj@kernel.org> wrote:
>
> On Fri, Dec 20, 2019 at 10:33:35AM +0100, Peter Zijlstra wrote:
> > On Fri, Dec 20, 2019 at 01:32:45PM +0900, Namhyung Kim wrote:
> > > To support cgroup tracking, add CGROUP event to save a link between
> > > cgroup path and inode number.  The attr.cgroup bit was also added to
> > > enable cgroup tracking from userspace.
> > >
> > > This event will be generated when a new cgroup becomes active.
> > > Userspace might need to synthesize those events for existing cgroups.
> > >
> > > Cc: Tejun Heo <tj@kernel.org>
> > > Cc: Li Zefan <lizefan@huawei.com>
> > > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> >
> > TJ, is this the right thing to do? ISTR you had concerns on this topic
> > on the past.
>
> Yeah, cgroup->id is now the same as ino (on 64bit ino matchines) and
> fhandle and uniquely identifies a cgroup instance in that boot
> instance.  That said, id -> path mapping can be done from userspace by
> passing the cgroup id to open_by_handle_at(2) and then reading the
> symlink in /proc/self/fd, so this event isn't necessary per-se if the
> goal is mapping back ids to paths.

But we should support offline report even on a different machine.
Also cgroups might go away during the record. so I think we need it
anyway.

Thanks
Namhyung
