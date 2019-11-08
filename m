Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6311FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 18:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 844802087E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 18:18:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="odPKyS18"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729151AbfKHSS3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 13:18:29 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51559 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbfKHSS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 13:18:29 -0500
Received: by mail-wm1-f67.google.com with SMTP id q70so7131068wme.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 10:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YFWgg2ppFdsSmvg1LO5Op3wVrU8obP4yfGKEavUKWnE=;
        b=odPKyS18+DSSsImN1b6xBaUshgxpKtpxWVGaSny1LSRPawCj0YlfQAbxynL4QzAcLp
         dTRQYG78FTiX7zHN/GcrlcEPpgQcXl36mZXEqOL9c6wFcnGVWO9NpWTd72QJ++CFC0lQ
         KsMMuG3RuuKWrBBc85IkXpqzjEC5O5NLUeohSJZdiKLXoKJNY2XqiaPLfxxf1A9AQ4/Z
         UxUcs29U0W4lqKrfKGeMUUJyz7KArVlugWeKGmoYQG1NoKiwB9IEVO/zxXsAmXH4U2/y
         NpcBIcIAGJnn89f+Mh9a4UIEccmrwelPlOqmsd5HaCrME4UO7IyDLFjGm0GUSVwfmchr
         TP1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YFWgg2ppFdsSmvg1LO5Op3wVrU8obP4yfGKEavUKWnE=;
        b=QZWvG3ao90mH2WvSVmMS4rViJPjuCzMweTaIjw01l5kZ89Wg/PpWSD8jxOAJ0CUKPA
         8E1Nvfst42AQJLvyq3jcZNeHQ4pKnEROaHX8I6QPpLyAP0O0N+uxCQn7WE3sGo49ru4k
         3xiCUERL7J8NjS1xJsTC3MakmIJhCHpQcKfzImhjIsDAHe0LzJZrwqFdtmz6nTHRWo5M
         KI5iZtbl650nhMcHahf97LJ5pNEgTHbIcT7nR5TWALLJg1W2q7/hYhZBJy5AP4Q7rFEw
         Dk6w6LslaqrGXNX+tTHpnMGn+Cw3bAsB0F91PnOnSBUZYO0A/+s80k0d/8k6cyWss2Va
         W/mQ==
X-Gm-Message-State: APjAAAXyQQmsdM/TO4whhRM00Mkvm0MP68YFYWpje2tcK3NmDr/1nTW/
        jqMC153q1C8Zxbic1QC4+hEr2YBh0j5aIrqs8lGBAg==
X-Google-Smtp-Source: APXvYqyU6oVLGbDhInMDhJxLdE4qvb46gnjNmeO+08bYNzQOCoi0whdlXnTfSIjGUb8cBku2xStC02eJfl/G99qaqrY=
X-Received: by 2002:a1c:a791:: with SMTP id q139mr9275963wme.155.1573237105658;
 Fri, 08 Nov 2019 10:18:25 -0800 (PST)
MIME-Version: 1.0
References: <20191030223448.12930-1-irogers@google.com> <20191107221428.168286-1-irogers@google.com>
 <20191107222315.GA7261@kernel.org>
In-Reply-To: <20191107222315.GA7261@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 8 Nov 2019 10:18:14 -0800
Message-ID: <CAP-5=fVNYbZoEmFzxMj850eorOtRJAouzvCFObxZRZT2G7YOCg@mail.gmail.com>
Subject: Re: [PATCH v6 00/10] Improvements to memory usage by parse events
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 7, 2019 at 2:23 PM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Em Thu, Nov 07, 2019 at 02:14:18PM -0800, Ian Rogers escreveu:
> > The parse events parser leaks memory for certain expressions as well
> > as allowing a char* to reference stack, heap or .rodata. This series
> > of patches improves the hygeine and adds free-ing operations to
> > reclaim memory in the parser in error and non-error situations.
> >
> > The series of patches was generated with LLVM's address sanitizer and
> > libFuzzer:
> > https://llvm.org/docs/LibFuzzer.html
> > called on the parse_events function with randomly generated input. With
> > the patches no leaks or memory corruption issues were present.
> >
> > The v6 patches address a C90 compilation issue.
>
> Please take a look at what is in my perf/core branch, to see what is
> left, if something needs fixing, please send a patch on top of that,

Thanks, just the last patch remaining. I resent it rebased on your
perf/core branch:
https://lkml.org/lkml/2019/11/8/1103
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/log/?h=perf/core

Thanks,
Ian

> Thanks,
>
> - Arnaldo
>
> > The v5 patches add initial error print to the set, as requested by
> > Jiri Olsa. They also fix additional 2 missed frees in the patch
> > 'before yyabort-ing free components' and remove a redundant new_str
> > variable from the patch 'add parse events handle error' as spotted by
> > Stephane Eranian.
> >
> > The v4 patches address review comments from Jiri Olsa, turning a long
> > error message into a single warning, fixing the data type in a list
> > iterator and reordering patches.
> >
> > The v3 patches address review comments from Jiri Olsa improving commit
> > messages, handling ENOMEM errors from strdup better, and removing a
> > printed warning if an invalid event is passed.
> >
> > The v2 patches are preferable to an earlier proposed patch:
> >    perf tools: avoid reading out of scope array
> >
> > Ian Rogers (10):
> >   perf tools: add parse events handle error
> >   perf tools: move ALLOC_LIST into a function
> >   perf tools: avoid a malloc for array events
> >   perf tools: splice events onto evlist even on error
> >   perf tools: ensure config and str in terms are unique
> >   perf tools: add destructors for parse event terms
> >   perf tools: before yyabort-ing free components
> >   perf tools: if pmu configuration fails free terms
> >   perf tools: add a deep delete for parse event terms
> >   perf tools: report initial event parsing error
> >
> >  tools/perf/arch/powerpc/util/kvm-stat.c |   9 +-
> >  tools/perf/builtin-stat.c               |   2 +
> >  tools/perf/builtin-trace.c              |  16 +-
> >  tools/perf/tests/parse-events.c         |   3 +-
> >  tools/perf/util/metricgroup.c           |   2 +-
> >  tools/perf/util/parse-events.c          | 239 +++++++++++----
> >  tools/perf/util/parse-events.h          |   7 +
> >  tools/perf/util/parse-events.y          | 390 +++++++++++++++++-------
> >  tools/perf/util/pmu.c                   |  32 +-
> >  9 files changed, 511 insertions(+), 189 deletions(-)
> >
> > --
> > 2.24.0.432.g9d3f5f5b63-goog
>
> --
>
> - Arnaldo
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20191107222315.GA7261%40kernel.org.
