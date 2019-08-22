Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E498C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 21:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B917233FC
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 21:29:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z6HymoiN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390039AbfHVV3T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 17:29:19 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39080 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730242AbfHVV3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 17:29:18 -0400
Received: by mail-wm1-f68.google.com with SMTP id i63so7130877wmg.4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 14:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=abk/fHiB5arccADE4hjcjXei5qBzPz06VPd+ovt4c7U=;
        b=Z6HymoiNrfDvmuXKNP47F4pXs/IWLPsbv3bDkBxbvnmiXGGp3+NJYUXU+nVZiHjHOL
         X7/cjTWNhStOdDrdJ5DNaQOkv4BW2KQn7obTPnlh8spVWZ1f0LPI91drZ0pYASqkXbVA
         LpIq9ZpDBEE2/YWQyjz2D+41CI9dY2XomHR5dDHtOIyMGTAlSqCQ+UAX+mG8Rf2yiiBb
         OgZK2iAivQHaezJSk7B+8RuMpkhpHjCyESvZktm7IoRZZ2bm66BaBOGbms6eTtqchhot
         aF7ZJbKW+1KiGpeIjIZ6ryxdZbWqxi5rU9etq9NILB5Dk3JUsEAiylDM1sSNGJwnK7fB
         ixcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=abk/fHiB5arccADE4hjcjXei5qBzPz06VPd+ovt4c7U=;
        b=hskJMOw6Q8Zntf/cjKsim+rEKOPGoY7yj9jV+RXEUBEoycvPG7CTEWrYlteKOpWWT1
         p4niDhJPN19BcIBstajiaFpv2K9eTxvUx4Kz7GE76wB3SHnVeuKrUxNSRkooJn4KzYLh
         qtLtYOvHHrE/9d319oHp4q0HCVJaJI0yz8YIYdOC5I1DNvpqxffRobiqzgWsS1nf+LQM
         xv9JdprONjN50Z8wFdOKZkr+gudlUC96BtuCU+J/31zoz6f4YneKaXGMls18IFpzn3iC
         01rV7MkG/9WdMcSxwqwS6XCkjk8O5xlkeNWanN0VIo8nhm2mTNXTI7J8i9WI4syLCCrz
         CMhA==
X-Gm-Message-State: APjAAAUvnFIqCnFE+i1JRoZ1vhO6E78+gKwBEWgixuBDVar3QlGfQPrE
        iiB8bifAaoDN+t3ErQ+uYxiKwSDtUNNJTSt2+5xBgg==
X-Google-Smtp-Source: APXvYqzTDaHrpYtZDyX5sO5xcuQItXl5PGCNVrqcUG85MZXFaE7uhViXyMROxlaIUnmTW8OOeZFpBft1GRNqgY7OGbI=
X-Received: by 2002:a1c:c5c4:: with SMTP id v187mr1152547wmf.30.1566509355910;
 Thu, 22 Aug 2019 14:29:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190724234500.253358-1-nums@google.com> <20190807203812.GA20129@kernel.org>
In-Reply-To: <20190807203812.GA20129@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 22 Aug 2019 14:29:03 -0700
Message-ID: <CAP-5=fURDxS6DSjc34MNOgqb_UX4YKHT5uHHtzi0X9qVQ8ZqcQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] Perf uninitialized value fixes
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Numfor Mbiziwo-Tiapo <nums@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Song Liu <songliubraving@fb.com>, mbd@fb.com,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 7, 2019 at 1:38 PM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Em Wed, Jul 24, 2019 at 04:44:57PM -0700, Numfor Mbiziwo-Tiapo escreveu:
> > These patches are all warnings that the MSAN (Memory Sanitizer) build
> > of perf has caught.
> >
> > To build perf with MSAN enabled run:
> > make -C tools/perf CLANG=1 CC=clang EXTRA_CFLAGS="-fsanitize=memory\
> >  -fsanitize-memory-track-origins"
> >
> > (The -fsanitizer-memory-track-origins makes the bugs clearer but
> > isn't strictly necessary.)
> >
> > (Additionally, llvm might have to be installed and clang might have to
> > be specified as the compiler - export CC=/usr/bin/clang).
> >
> > The patches "Fix util.c use of uninitialized value warning" and "Fix
> > annotate.c use of uninitialized value error" build on top of each other
> > (the changes in Fix util.c use of uninitialized value warning must be
> > made first).
> >
> > When running the commands provided in the repro instructions, MSAN will
> > generate false positive uninitialized memory errors. This is happening
> > because libc is not MSAN-instrumented. Finding a way to build libc with
> > MSAN will get rid of these false positives and allow the real warnings
> > mentioned in the patches to be shown.
>
> So this is because I'm not running a glibc linked with MSAN? Do you have
> any pointer to help building glibc with MSAN? I want to do that inside a
> container so that I can use these sanitizers, thanks,
>
> [root@quaco ~]# perf record -o - ls / | perf --no-pager annotate -i -  --stdio
> ==29732==WARNING: MemorySanitizer: use-of-uninitialized-value
> ==29733==WARNING: MemorySanitizer: use-of-uninitialized-value
>     #0 0xcc136d in add_path /home/acme/git/perf/tools/lib/subcmd/exec-cmd.c:130:6
>     #1 0xcc075e in setup_path /home/acme/git/perf/tools/lib/subcmd/exec-cmd.c:146:2
>     #2 0x71298d in main /home/acme/git/perf/tools/perf/perf.c:512:2
>     #0 0xcc136d in add_path /home/acme/git/perf/tools/lib/subcmd/exec-cmd.c:130:6
>     #1 0xcc075e in setup_path /home/acme/git/perf/tools/lib/subcmd/exec-cmd.c:146:2
>     #2 0x71298d in main /home/acme/git/perf/tools/perf/perf.c:512:2
>     #3 0x7f45b9e29f32 in __libc_start_main (/lib64/libc.so.6+0x23f32)
>     #4 0x447dcd in _start (/home/acme/bin/perf+0x447dcd)
>
>   Uninitialized value was created by a heap allocation
>     #3 0x7fd6433cff32 in __libc_start_main (/lib64/libc.so.6+0x23f32)
>     #4 0x447dcd in _start (/home/acme/bin/perf+0x447dcd)
>
>   Uninitialized value was created by a heap allocation
>     #0 0x4507d2 in malloc /home/acme/git/llvm/projects/compiler-rt/lib/msan/msan_interceptors.cc:916:3
>     #1 0x7f45b9e7fc47 in __vasprintf_internal (/lib64/libc.so.6+0x79c47)
>
> SUMMARY: MemorySanitizer: use-of-uninitialized-value /home/acme/git/perf/tools/lib/subcmd/exec-cmd.c:130:6 in add_path
> Exiting
>     #0 0x4507d2 in malloc /home/acme/git/llvm/projects/compiler-rt/lib/msan/msan_interceptors.cc:916:3
>     #1 0x7fd643425c47 in __vasprintf_internal (/lib64/libc.so.6+0x79c47)
>
> SUMMARY: MemorySanitizer: use-of-uninitialized-value /home/acme/git/perf/tools/lib/subcmd/exec-cmd.c:130:6 in add_path
> Exiting
> [root@quaco ~]#
>
> > Numfor Mbiziwo-Tiapo (3):
> >   Fix util.c use of uninitialized value warning
> >   Fix annotate.c use of uninitialized value error
> >   Fix sched-messaging.c use of uninitialized value errors
> >
> >  tools/perf/bench/sched-messaging.c |  3 ++-
> >  tools/perf/util/annotate.c         | 15 +++++++++++----
> >  tools/perf/util/header.c           |  2 +-
> >  3 files changed, 14 insertions(+), 6 deletions(-)

Thanks Arnaldo! Debugging the issue it isn't down glibc, there are
interceptors in the sanitizers for asprintf to recognize it as a
source of memory allocation. The problem is the sanitizers don't
support _FORTIFY_SOURCE [1] and this is causing the false positives.
The following patch works to resolve the false-positive issue for me:

-----
--- a/tools/lib/subcmd/Makefile
+++ b/tools/lib/subcmd/Makefile
@@ -20,7 +20,13 @@ MAKEFLAGS += --no-print-directory
LIBFILE = $(OUTPUT)libsubcmd.a

CFLAGS := $(EXTRA_WARNINGS) $(EXTRA_CFLAGS)
-CFLAGS += -ggdb3 -Wall -Wextra -std=gnu99 -U_FORTIFY_SOURCE
-D_FORTIFY_SOURCE=2 -fPIC
+CFLAGS += -ggdb3 -Wall -Wextra -std=gnu99 -fPIC
+
+ifeq ($(DEBUG),0)
+  ifeq ($(feature-fortify-source), 1)
+    CFLAGS += -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=2
+  endif
+endif

ifeq ($(CC_NO_CLANG), 0)
  CFLAGS += -O3
-----

Thanks,
Ian

[1] https://github.com/google/sanitizers/wiki/AddressSanitizer#faq

> > --
> > 2.22.0.657.g960e92d24f-goog
>
> --
>
> - Arnaldo
