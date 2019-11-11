Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62168C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 20:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F38320659
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 20:34:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u1QOyZm7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbfKKUeg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 15:34:36 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45321 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbfKKUeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 15:34:36 -0500
Received: by mail-wr1-f68.google.com with SMTP id z10so10809639wrs.12
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 12:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UHvLQwIVksvr5k5bLuPU04kyrWXF24MECcQaDAhulgU=;
        b=u1QOyZm72auICNe/agQRvD76+7ro+01/Ibi7UBUsLpaNqrFQHH4ZpUdJfJl8c+s7fn
         J9ie6GUM5utLEicdy0ehxuLG6k/hCFHQNEUH1ERdmAbZOeiq0HKKZl7q7mWz8zZjX0IY
         usMkhDVS77iGPpP3y2soiJBqg3pPbNY7D+ITOy4Y8mnyz8g8YFd4AuYmLDGNMipiPYll
         C3Dn39Kfln3vT/1y0elvB/Ki+Ka3pxdk0z/UTVtgv6LplsFDv+5tdUBDlvGvF5rSpbfo
         DJ1ciLjvX4Eltv9CZ0/T5u9ySMuy5c8xsXs3ynCNQwLkwTPSrk9r/9bnRtqxtnXaqScT
         QYgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UHvLQwIVksvr5k5bLuPU04kyrWXF24MECcQaDAhulgU=;
        b=Y1T5gX2xFcHYiMPSLmqZ/fbjCO3f96Dh3U6dR7NynAqFP4scGF8P5dqhxThRwu2nPD
         IQmT5jzhJxZMZSg65HeDhKAPezQQUwERul08exYHcdNYGL7Q1gbPxj3ycE8w45YUsGfN
         APFbdYQowdvvHCkA3CsCvV0geQyarRfpG2M2WXHIfrlHpC5w2WJCjyI21rdFNiCwR/4o
         RtUF3PtNY/Z636X2Cptn+ou6ZtN87dQ1OtjfBH9ROGoJwqDJ6EgL98c5b157iqQ6PrZW
         f/5zLS7QZMIJJaCdjXiEjW9ykp6aO+HLCymIFpAtxEkUS6fpIJ34oqGV6IUDNWLEps1D
         ix3g==
X-Gm-Message-State: APjAAAVi7tDsjz6xmPakC3ZTpC3gZlFGKuPKwNTtiJ0qH2afP56EqIE5
        TmjoEpGKgmvByWjgkVlAtQ+y559fMBasQzq7sDRxxQ==
X-Google-Smtp-Source: APXvYqxMkbEVgLDw+ecBh6mhpn3uCg//2j/aC3/omThzqHg940ogglWEyRJ/mlr28NYV3KAXhCx7RGOs9X042cty6Jo=
X-Received: by 2002:adf:f1c7:: with SMTP id z7mr24268843wro.355.1573504474504;
 Mon, 11 Nov 2019 12:34:34 -0800 (PST)
MIME-Version: 1.0
References: <20191017170531.171244-1-irogers@google.com> <20191023082912.GB22919@krava>
 <20191111142511.GF9365@kernel.org>
In-Reply-To: <20191111142511.GF9365@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 11 Nov 2019 12:34:23 -0800
Message-ID: <CAP-5=fUB-FddKaKOCYfU2Zu+AX88U9dFFmZ4Fdv146vKvQSr1g@mail.gmail.com>
Subject: Re: [PATCH] perf tools: avoid reading out of scope array
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, He Kuang <hekuang@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Arnaldo, this patch shouldn't be added. It was replaced with
the longer v2 patch that addressed the memory issues properly. That
was followed by a number of improved versions.

Ian

On Mon, Nov 11, 2019 at 6:25 AM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Em Wed, Oct 23, 2019 at 10:29:12AM +0200, Jiri Olsa escreveu:
> > On Thu, Oct 17, 2019 at 10:05:31AM -0700, Ian Rogers wrote:
> > > Modify tracepoint name into 2 sys components and assemble at use. This
> > > avoids the sys_name array being out of scope at the point of use.
> > > Bug caught with LLVM's address sanitizer with fuzz generated input of
> > > ":cs\1" to parse_events.
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > >  tools/perf/util/parse-events.y | 36 +++++++++++++++++++++++-----------
> > >  1 file changed, 25 insertions(+), 11 deletions(-)
> > >
> > > diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
> > > index 48126ae4cd13..28be39a703c9 100644
> > > --- a/tools/perf/util/parse-events.y
> > > +++ b/tools/perf/util/parse-events.y
> > > @@ -104,7 +104,8 @@ static void inc_group_count(struct list_head *list,
> > >     struct list_head *head;
> > >     struct parse_events_term *term;
> > >     struct tracepoint_name {
> > > -           char *sys;
> > > +           char *sys1;
> > > +           char *sys2;
> > >             char *event;
> > >     } tracepoint_name;
> > >     struct parse_events_array array;
> > > @@ -425,9 +426,19 @@ tracepoint_name opt_event_config
> > >     if (error)
> > >             error->idx = @1.first_column;
> > >
> > > -   if (parse_events_add_tracepoint(list, &parse_state->idx, $1.sys, $1.event,
> > > -                                   error, $2))
> > > -           return -1;
> > > +        if ($1.sys2) {
> > > +           char sys_name[128];
> > > +           snprintf(&sys_name, sizeof(sys_name), "%s-%s",
> > > +                   $1.sys1, $1.sys2);
> > > +           if (parse_events_add_tracepoint(list, &parse_state->idx,
> > > +                                           sys_name, $1.event,
> > > +                                           error, $2))
> > > +                   return -1;
> > > +        } else
> > > +           if (parse_events_add_tracepoint(list, &parse_state->idx,
> > > +                                           $1.sys1, $1.event,
> > > +                                           error, $2))
> > > +                   return -1;
> >
> > nice catch, please enclose all multiline condition legs with {}
> >
> > other than that
> >
> > Acked-by: Jiri Olsa <jolsa@kernel.org>
>
> Ian, this one isn't applying to my perf/core branch, can you please
> address Jiri's comment and resubmit?
>
> - arnaldo
