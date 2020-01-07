Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7463EC33C8C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 13:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44F5D20656
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 13:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578404833;
	bh=xHG/+D+YkX5Hjc50gFa6FcSPYm3jMMqthARpnF8b3NE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=kpNvIApNc50/Wpd6o+8duCpzpdFPGP0fYxBXzh1PLtaBuUkxn9USWIFWUpeRmtSPl
	 X6TPeREzBUMfp6+i+cqXe35pQBIFuYDNEjEyS0T+0U7CF7yaUTHD7kAcWtsAnBYa4f
	 WDB37Ho8Y8Uqzb7lituF4WN5FoRk3pAObiHLswkk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbgAGNrM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 08:47:12 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:56014 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727559AbgAGNrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 08:47:11 -0500
Received: by mail-wm1-f65.google.com with SMTP id q9so19013082wmj.5;
        Tue, 07 Jan 2020 05:47:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8XK3B4MMozP9yKcm5IfVABl7Lsz84+DB5PqI1j3k5Ko=;
        b=jtyPFR/TUolpNf2JqZnmp2+ntTO0V06UW3fQHiM0QSfHcsRP1NKwLljlLINLRdhhjP
         7ZPmDXtwQNS5nO3x8UxTQkMH9YqNvA8XP0TxrDExg5Pxu1RIscmNz8f68eu6c9TWI9gm
         0G7SJyoTQ2/aq7FXBuZeAPwWlVXLFD7k19OLdMw5A3iw9yw+Fh2esvm3y6S87p4rUznb
         zucYjBFJG++0EntUIwE0DqfOpcytAAdZNiGj4UJEWdao6S8NcCMP0B4a97mHfUqldtbl
         4UTb2yJAAjOwS23xRl1hhDrhvE7JC70H3cqlGdTjwJ8k0aBFcMQWb4t1TmzXoKzUluyz
         wRAw==
X-Gm-Message-State: APjAAAVGQHWSyWp/gcaYw52flMLOubbVpFfSLW0CLz2EbMIAUn5DhffI
        1EyTW/edr73km+Pvp8hM8+vhwkwd+a2vr7WmVfk=
X-Google-Smtp-Source: APXvYqzH8Bi56kPpGoqqNAaf4qfeVd3nfEB9o9KncVhc3t/y31gnwrFmaR3MaClwFTRACrox6TEZss0hxzCrCq/vxkY=
X-Received: by 2002:a1c:7205:: with SMTP id n5mr41647374wmc.9.1578404829239;
 Tue, 07 Jan 2020 05:47:09 -0800 (PST)
MIME-Version: 1.0
References: <20191223060759.841176-1-namhyung@kernel.org> <20191223060759.841176-2-namhyung@kernel.org>
 <20200107125131.GZ2844@hirez.programming.kicks-ass.net>
In-Reply-To: <20200107125131.GZ2844@hirez.programming.kicks-ass.net>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 7 Jan 2020 22:46:58 +0900
Message-ID: <CAM9d7ch78fdk+-uqsdRDN6mVZ0Q-gP+0bQHYygFhBNJyuPDfGA@mail.gmail.com>
Subject: Re: [PATCH 1/9] perf/core: Add PERF_RECORD_CGROUP event
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

Happy new year!

On Tue, Jan 7, 2020 at 9:51 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Dec 23, 2019 at 03:07:51PM +0900, Namhyung Kim wrote:
>
> > @@ -7564,6 +7567,105 @@ void perf_event_namespaces(struct task_struct *task)
> >                       NULL);
> >  }
> >
> > +/*
> > + * cgroup tracking
> > + */
> > +#ifdef CONFIG_CGROUPS
> > +
>
> <snip>
>
> > +
> > +#endif
> > +
> >  /*
> >   * mmap tracking
> >   */
>
> > @@ -12581,6 +12685,12 @@ static void perf_cgroup_css_free(struct cgroup_subsys_state *css)
> >       kfree(jc);
> >  }
> >
> > +static int perf_cgroup_css_online(struct cgroup_subsys_state *css)
> > +{
> > +     perf_event_cgroup(css->cgroup);
> > +     return 0;
> > +}
> > +
> >  static int __perf_cgroup_move(void *info)
> >  {
> >       struct task_struct *task = info;
> > @@ -12602,6 +12712,7 @@ static void perf_cgroup_attach(struct cgroup_taskset *tset)
> >  struct cgroup_subsys perf_event_cgrp_subsys = {
> >       .css_alloc      = perf_cgroup_css_alloc,
> >       .css_free       = perf_cgroup_css_free,
> > +     .css_online     = perf_cgroup_css_online,
> >       .attach         = perf_cgroup_attach,
> >       /*
> >        * Implicitly enable on dfl hierarchy so that perf events can
>
> CONFIG_CGROUPS vs CONFIG_CGROUP_PERF ?

Oh, I just saw this after sending v4 right before..
I think it should use CONFIG_CGROUP_PERF, will change.

>
> Other than that, I see nothing wrong here.

Thanks for the review!
Namhyung
