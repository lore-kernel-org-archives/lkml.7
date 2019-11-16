Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FEA9C432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 01:20:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF8DA20733
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 01:20:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JnOR++G1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727586AbfKPBUC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 20:20:02 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41962 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbfKPBUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 20:20:02 -0500
Received: by mail-wr1-f67.google.com with SMTP id b18so11402223wrj.8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 17:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QTpUnVTihwBZz4hpsJtod/7VpEMVOsKpXr22lx70xUo=;
        b=JnOR++G16eQtJ0Wq/tVSl+kCJk7giA7NfFLOOMF2kubJJvffrEPbhOAeCuJxzwSsTA
         3AY2P7DloE5nLc5KPpp6xhwWy2ysrEXvYzqHRX/QTKyDyKAgpAt6SbGNZ9Do8t4MrH/3
         ERU9hDn3YgzqP6e57q1VHF4mK08o6V3vkwh5iX7+aMiy/soeTqeZj68Ak6DCY6wEn89d
         plk+ViIm35JnI4oXnS10lb90W62H0gXfU3MMjLrojeTAPXJ3mDTvQAZ3YUpYQ+NwfnKk
         Q7muZ8HGgTQZhAYcDMNbqZqeesHn9JyYjpMU+75rYpPASWXnoSblqJJQhZEX2WuF/urs
         1FfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QTpUnVTihwBZz4hpsJtod/7VpEMVOsKpXr22lx70xUo=;
        b=lhG9V1Uv5Jhpp2KSHYIIXQ40QcNKOn174PLXhzFeRi91WPQmYF4sVGyem+JWrG+6Oj
         +pE6MVCqZ9MwBi9xPFA04HA6qblkSLeo61nu6MCdgG6IOzw7/70ssfnzZRLJmnS+rdE2
         S1qtFyNkASDSd6APMO+3IUYFZet7PE2aNRN5OyQo9EGcTfcDbvjSSK/UgFHagnVg++Yh
         kLv0JVv90XQRxIsNpJZ0AVbmIfx+BZ+6cUs4O+oLz5kAaCX+s/nDr+ihOlD75JZ/wK1h
         DRcuei+TpcuSyOcnnY8VGg5wdwB741nAzisGkWNOAGw8uVxqLlFf/5RTVFWp/9gZ4Lb2
         e71Q==
X-Gm-Message-State: APjAAAUvGOmnvzRyUoEv5ah1wiv6FVAW6vT+Fr+h/OmccxRtVILFVvsN
        4lJWwOzxRrtFlamqNHooAkM5Oq/iwjm4H9JcBAXTBQ==
X-Google-Smtp-Source: APXvYqwJn0IGSoa08aCMkQ1CK0/l8R0gRJBD+7+IkLJrE8vH4x8owInRwB2Sw7jhFU8ODvW6Apr4ez56VqT3V8UBYVI=
X-Received: by 2002:adf:91e1:: with SMTP id 88mr19864673wri.16.1573867199840;
 Fri, 15 Nov 2019 17:19:59 -0800 (PST)
MIME-Version: 1.0
References: <20191114003042.85252-1-irogers@google.com> <20191114003042.85252-5-irogers@google.com>
 <20191114095114.GP4131@hirez.programming.kicks-ass.net>
In-Reply-To: <20191114095114.GP4131@hirez.programming.kicks-ass.net>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 15 Nov 2019 17:19:48 -0800
Message-ID: <CAP-5=fVj42gS8oQAG+jp3A+VJQcAHTexaO_4mNvLhdopf6B8vg@mail.gmail.com>
Subject: Re: [PATCH v3 04/10] perf: Add per perf_cpu_context min_heap storage
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Petr Mladek <pmladek@suse.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Qian Cai <cai@lca.pw>, Joe Lawrence <joe.lawrence@redhat.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Gary Hook <Gary.Hook@amd.com>, Arnd Bergmann <arnd@arndb.de>,
        Kan Liang <kan.liang@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2019 at 1:51 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Nov 13, 2019 at 04:30:36PM -0800, Ian Rogers wrote:
> > +     if (cpuctx) {
> > +             event_heap = (struct min_max_heap){
> > +                     .data = cpuctx->itr_storage,
> > +                     .size = 0,
>
> C guarantees that unnamed fields get to be 0

Agreed, this is kept here to aid readability. Do you feel strongly
about not having this? It appears to be kept elsewhere for clarity
too:
$ grep -r "\..*= 0," arch/ kernel/ tools/|wc -l
2528

> > +                     .cap = cpuctx->itr_storage_cap,
> > +             };
> > +     } else {
> > +             event_heap = (struct min_max_heap){
> > +                     .data = itrs,
> > +                     .size = 0,
>
> idem.
>
> > +                     .cap = ARRAY_SIZE(itrs),
> > +             };
> > +             /* Events not within a CPU context may be on any CPU. */
> > +             __heap_add(&event_heap, perf_event_groups_first(groups, -1));
> > +
>
> suprious whitespace

Done.



> > +     }
> > +     evt = event_heap.data;
> > +
> >       __heap_add(&event_heap, perf_event_groups_first(groups, cpu));
