Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D841C43215
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 07:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0795520730
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 07:49:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OnqqB6zA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbfKPHtZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 02:49:25 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54834 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbfKPHtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 02:49:25 -0500
Received: by mail-wm1-f67.google.com with SMTP id z26so11820146wmi.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 23:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wrU9oNm+m55B0W8NFjsrIht/+mTQtS5ufyY+zIn4ZzU=;
        b=OnqqB6zAgc0Kl4pYd4aSiHtVcXDvOOaDYZL8BfRbDyf87Bz8JAIboY3pjGD6m4KxZz
         +aEWt/iLz1tKtlWkCZ/so6OuGR+Y0b6s65hv50pzubV+f9RXxz0tG1AaKrp5pPoEd4il
         H7FueI9GwiPAMVw+6T8oWgLMIyAwp6DjMMJp/njT43JIpiSLX9Qy3MJmD66xt1HB0rew
         6+fYjfT/yWAWlNSTEheboxtNmZiCMvqes4ml9D8lVC8hjo/RNilG+NkkxyiqndAyDItL
         nllDS0YtVTT/cawjQ2Na7nNNqcjXmETZiLu0ZGsoo53HUWBczht9Z2Impz8Fz7gK4GOf
         CZDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wrU9oNm+m55B0W8NFjsrIht/+mTQtS5ufyY+zIn4ZzU=;
        b=FDRJBxko4/V6Lrm8qrbz5YGhdkc5YWgdo/dJWUy13eTo9cS0gzYyineOQ8SPlv8l3W
         B5Hi5lpqPTPG8l9XTnZIDRCCiJcb4/pglEcyc1Ns4Oj7K79tnLfACDUa9o1es3lNuv3g
         llY9eI41zonovP9PQc36U2nes1uGR4cDOGO4gMd6ROFnLl+s/LkEAgA+/KX1uN/BhGxR
         YPHe07QxU/pqyL0ILxMGjc/4UyjfALiHxI7nMSojNj7Y+GICxnp8FXL8twW7EYPJLkU3
         /gsQdm4MFwDmYrBiQcxz2iCfvEp7l0tExeuUjv8ahtlksRreyKiPWrdYu+UYuQCfIUwk
         HcHA==
X-Gm-Message-State: APjAAAWTHBQoSI2+1Fksedf/meQUhoWtQcQKn8TNl7XF9oPm1JrzptdY
        LntaPZjW1s2Mv3lUzBywJ0fKwpE8isFgZktZuWyT7A==
X-Google-Smtp-Source: APXvYqxN9tEkdJJjcZLwbRx7aPwN6Bp5OBx7h7U4ZY1KJj5bVXNsCVyqUfMiNg5LRjCPKVJeKHHR3LZiNgn4KRenY3U=
X-Received: by 2002:a05:600c:218c:: with SMTP id e12mr14565355wme.30.1573890562501;
 Fri, 15 Nov 2019 23:49:22 -0800 (PST)
MIME-Version: 1.0
References: <20191107222315.GA7261@kernel.org> <20191108181533.222053-1-irogers@google.com>
 <20191111120220.GC9791@krava>
In-Reply-To: <20191111120220.GC9791@krava>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 15 Nov 2019 23:49:10 -0800
Message-ID: <CAP-5=fUyVyg888bB-4K3o73kQbqo=G=8T9OFy0C=qtWTJjCOrw@mail.gmail.com>
Subject: Re: [PATCH] perf tools: report initial event parsing error
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Allison Randal <allison@lohutok.net>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Adrian Hunter <adrian.hunter@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 4:02 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Fri, Nov 08, 2019 at 10:15:33AM -0800, Ian Rogers wrote:
>
> SNIP
>
> > diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> > index 43c05eae1768..46a72ecac427 100644
> > --- a/tools/perf/builtin-trace.c
> > +++ b/tools/perf/builtin-trace.c
> > @@ -3016,11 +3016,18 @@ static bool evlist__add_vfs_getname(struct evlist *evlist)
> >  {
> >       bool found = false;
> >       struct evsel *evsel, *tmp;
> > -     struct parse_events_error err = { .idx = 0, };
> > -     int ret = parse_events(evlist, "probe:vfs_getname*", &err);
> > +     struct parse_events_error err;
> > +     int ret;
> >
> > -     if (ret)
> > +     bzero(&err, sizeof(err));
>
> hum, what's the problem with the zero init above?

There are 3 patterns for initializing parse_events_error in the code,
bzero, memset and {.idx =0,}. I made all instances use bzero for
consistency.

Thanks,
Ian

> jirka
>
