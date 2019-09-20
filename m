Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D34C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 23:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97F552073F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 23:05:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eJpkOX5i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407042AbfITXFp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 19:05:45 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:46604 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407007AbfITXFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 19:05:44 -0400
Received: by mail-io1-f65.google.com with SMTP id c6so6650539ioo.13
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 16:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rGpXWgfcyYZWJL8n2+Ik9dQNFelwopW6WQlt8ye2PV8=;
        b=eJpkOX5iM6q92V4fU+lzNxm/1cbcyChsBVXC+577aFux9yT4bNcahng78RT2btI63z
         Kx6Fc1EzmSn5p+V1PVpi4aSN19Htl4m6qNqLCg6WueRY7e2WYkxWbxZtngklzI+9DYMV
         JsukC9oLoKjcNNboCOBGSNn7mj+0jFdMtxLTJtmROYZtAkNCtrY9uQHqDcoXKJpSJlle
         85F3UWgzZjuWrPYjMmjcXMXEPlNr8A2HPz+pFC1M4OxM/r2jHZrAjtD3Nxf8WZtE/gHp
         c0ZvzfRCh0pVyRLcOIjStwzfwdRfB5RmGxUTRa8z/BBlKfxJZPOt01WZu4T1ffukJYzb
         i6CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rGpXWgfcyYZWJL8n2+Ik9dQNFelwopW6WQlt8ye2PV8=;
        b=hkiyV43Oow6jwAmtarkeOhOwxOaoTN6Aq8taWiSn8K/+5/Vz9snGgws8jiKpk/bVXo
         9rXU/kFmaMnnzr+WVHVvAUIjOXgPGevUq6sho+C99mXOGKGt6q/kqybCEyJ3Mhx+M6Fd
         UtAEx7wGD9YR0Z5OCc5j/SnDLikzk6rJwE9EnZZi18aQCxjHDDbpANzfbPddSwSWlweD
         SkWoYjLvPMTHuPHxxyocpzFGNEcSzOMrHIRLvsnZx3ejMZaucnkKPWi9h7HzRtRVjLDE
         gGq829xra/4ZigAvsi6qlYtAea0GIIB4ic/ZOJgBu0DNqaWBFDJdVywmNnY6ex33W4XH
         hgFQ==
X-Gm-Message-State: APjAAAXrA6M0J3jLcISdZbJaWCXess2cOXLhWJPI2zmSfljJ6LySZchk
        2bITzf7IIkkkMlfFtDneKzbyywdE2ovpmVIFZNeU1A==
X-Google-Smtp-Source: APXvYqxnCkci2DCe3BsOxT7RCmkUxPB8N3WW2siakEitMDrJJ4c2cZjxTABe45Vl16Jr57N0M+cCaK/OQUh//T7EgAI=
X-Received: by 2002:a5d:8908:: with SMTP id b8mr585572ion.237.1569020743892;
 Fri, 20 Sep 2019 16:05:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190904062603.90165-1-eranian@google.com> <20190920191223.GC26850@krava>
In-Reply-To: <20190920191223.GC26850@krava>
From:   Stephane Eranian <eranian@google.com>
Date:   Fri, 20 Sep 2019 16:05:32 -0700
Message-ID: <CABPqkBSAhH5425UTfse2QVk5jdfryqGHbmnJus8bJRbHR5sV3Q@mail.gmail.com>
Subject: Re: [PATCH] perf record: fix priv level with branch sampling for paranoid=2
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, mingo@elte.hu,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2019 at 12:12 PM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Tue, Sep 03, 2019 at 11:26:03PM -0700, Stephane Eranian wrote:
> > Now that the default perf_events paranoid level is set to 2, a regular user
> > cannot monitor kernel level activity anymore. As such, with the following
> > cmdline:
> >
> > $ perf record -e cycles date
> >
> > The perf tool first tries cycles:uk but then falls back to cycles:u
> > as can be seen in the perf report --header-only output:
> >
> >   cmdline : /export/hda3/tmp/perf.tip record -e cycles ls
> >   event : name = cycles:u, , id = { 436186, ... }
> >
> > This is okay as long as there is way to learn the priv level was changed
> > internally by the tool.
> >
> > But consider a similar example:
> >
> > $ perf record -b -e cycles date
> > Error:
> > You may not have permission to collect stats.
> >
> > Consider tweaking /proc/sys/kernel/perf_event_paranoid,
> > which controls use of the performance events system by
> > unprivileged users (without CAP_SYS_ADMIN).
> > ...
> >
> > Why is that treated differently given that the branch sampling inherits the
> > priv level of the first event in this case, i.e., cycles:u? It turns out
> > that the branch sampling code is more picky and also checks exclude_hv.
> >
> > In the fallback path, perf record is setting exclude_kernel = 1, but it
> > does not change exclude_hv. This does not seem to match the restriction
> > imposed by paranoid = 2.
> >
> > This patch fixes the problem by forcing exclude_hv = 1 in the fallback
> > for paranoid=2. With this in place:
> >
> > $ perf record -b -e cycles date
> >   cmdline : /export/hda3/tmp/perf.tip record -b -e cycles ls
> >   event : name = cycles:u, , id = { 436847, ... }
> >
> > And the command succeeds as expected.
> >
> > Signed-off-by: Stephane Eranian <eranian@google.com>
> > ---
> >  tools/perf/util/evsel.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > index 85825384f9e8..3cbe06fdf7f7 100644
> > --- a/tools/perf/util/evsel.c
> > +++ b/tools/perf/util/evsel.c
> > @@ -2811,9 +2811,11 @@ bool perf_evsel__fallback(struct evsel *evsel, int err,
> >               if (evsel->name)
> >                       free(evsel->name);
> >               evsel->name = new_name;
> > -             scnprintf(msg, msgsize,
> > -"kernel.perf_event_paranoid=%d, trying to fall back to excluding kernel samples", paranoid);
> > +             scnprintf(msg, msgsize, "kernel.perf_event_paranoid=%d, trying "
> > +                       "to fall back to excluding kernel and hypervisor "
> > +                       " samples", paranoid);
>
> extra space in here        ^
>
>         Warning:
>         kernel.perf_event_paranoid=2, trying to fall back to excluding kernel and hypervisor  samples
>
> other than that it looks good to me
>
Fixed in v2.

> Acked-by: Jiri Olsa <jolsa@redhat.com>
>
> thanks,
> jirka
