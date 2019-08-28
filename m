Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 678A0C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 19:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30B6C208C2
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 19:31:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X5FVdJNR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbfH1Tbe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 15:31:34 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:38053 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbfH1Tbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 15:31:33 -0400
Received: by mail-io1-f65.google.com with SMTP id p12so1920577iog.5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 12:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OPq6eHkfSEMrDtXlZHggTT9FiJjZ14kSQYk2XHwhvZA=;
        b=X5FVdJNR8hI2vWzGUiUbRUHPEpCZwqGopCVHHOg1zU6Xv0LSn9tFaafxTc+PSVyUgN
         Vm9lcNVXvcysI5VUvchwYyYLL8XsUoK3sEf1fG9iKq6VYYFUMHQGb1CWVntYjb2tX9VH
         TVsEy0gIeCkRNl2gTTDCG0cBfUPu2cWbxHHRT/qXCwcMneOdOeEM4VN3U6oGhdyHqSXl
         jiGvbNXzLq2WFQU67xGtBr+wsJQ7XK2hMwX35pccBS1AtYoKylZk89YeZCcGzV5E+tw7
         m3k1o9yvBLyYa0v64T0q03UjqhHP7jRjJrNwFl0OB5mnqZkarX61QVHM6FQxyytmUlCs
         lGjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OPq6eHkfSEMrDtXlZHggTT9FiJjZ14kSQYk2XHwhvZA=;
        b=LGNEL7wnQ+BpAN0uaGJHGfMst1nrmq8KCzzSht4TTg30RH2mGQjByE+gWHcXp4hg3r
         IdJ17V/17sUuBIbIjOZCpfO6OkpcATCeIdFOhOmKfsvabKn3JsrNLDWkTLHCGMMaqeef
         C+Y+LMy5j0+eB18w9eoAfg5NUh8Ef73f8kODfMTbl0LjfM+Sj8HK4cT0FlykvrFRyaT8
         iR/GuQXpF6IGz1KU6HJ4L7jqutIqZXnuINhDQPz5Mjub5dJpqYumGNM3NHDIMK9Jym36
         BegJqjbN74CxXX6lksempvRu/NvkJ/vt7J4WSdbd5C45SxiI5wgsUIkR+ox526tmbb1R
         6sCg==
X-Gm-Message-State: APjAAAWPhHFL8mijbmPO6JwQfZ9YlwpTwanYQhVvvfaHRpCRHpveTkIZ
        Vr61XPOG9vZWMlaUIAG499eoMUpZYsAChT4akB4KSw==
X-Google-Smtp-Source: APXvYqyZx1HtW0OkfrtQ29V/XqVXQQUk7BQodnXXtHFG8tFy4rV5ofzUcZqV/dV+JMGYWsVQaP5eYfgNSUyhT2J7lQc=
X-Received: by 2002:a6b:720e:: with SMTP id n14mr2596211ioc.139.1567020692511;
 Wed, 28 Aug 2019 12:31:32 -0700 (PDT)
MIME-Version: 1.0
References: <1566869956-7154-1-git-send-email-ilubashe@akamai.com>
In-Reply-To: <1566869956-7154-1-git-send-email-ilubashe@akamai.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Wed, 28 Aug 2019 13:31:21 -0600
Message-ID: <CANLsYkwZm9ehopjDMXNw-3JOj8MPeT_shPPJBOeLNe7BUtibmA@mail.gmail.com>
Subject: Re: [PATCH 0/5] perf: Treat perf_event_paranoid and kptr_restrict
 like the kernel does it
To:     Igor Lubashev <ilubashe@akamai.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        James Morris <jmorris@namei.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Aug 2019 at 19:40, Igor Lubashev <ilubashe@akamai.com> wrote:
>
> This is a follow up series to the ensure perf treats perf_event_paranoid and
> kptr_restrict in a way that is similar to the kernel's.  That includes use of
> capabilities instead of euid==0, when possible, as well as adjusting the logic
> and fixing bugs.
>
> Prior discussion: https://lkml.kernel.org/lkml/cover.1565188228.git.ilubashe@akamai.com
>
> ===  Testing notes ===
>
> I have tested on x86 with perf binary installed according to
> Documentation/admin-guide/perf-security.rst (cap_sys_admin, cap_sys_ptrace,
> cap_syslog assigned to the perf executable).
>
> I tested each permutation of:
>
>   * 7 commits:
>       1. HEAD of perf/core
>       2. patch 01 on top of perf/core
>       3. patches 01-02 on top of perf/core
>       4. patches 01-03 on top of perf/core
>       5. patches 01-04 on top of perf/core
>       6. patches 01-05 on top of perf/core
>       7. HEAD of perf/cap (with known bug fixed by patch 01 of this series)
>
>   * 2 build environments: with and without libcap-dev
>
>   * 3 kernel.kptr_restrict values: 0, 1, 2
>
>   * 4 kernel.perf_event_paranoid values: -1, 0, 1, 2
>
>   * 2 users: root and non-root
>
> Total: 336 permutations
>
> Each permutation consisted of:
>   perf test
>   perf record -e instructions -- sleep 1
>
> All test runs were expected.  Also, as expected, the following permutation (just
> that permutation) resulted in segmentation failure:
>  commit:                     perf/cap
>  build:                      no libcap-dev
>  kernel.kptr_restrict:       0
>  kernel.perf_event_paranoid: 2
>  user:                       non-root
>
> The perf/cap commit was included in the test to ensure that we can reproduce the
> crash and hence test that the patch series fixes the crash, while retaining the
> desired behavior of perf/cap.
>
> === Series Contents ===
>
>   01: perf event: Check ref_reloc_sym before using it
>     Fix the pre-existing cause of the crash above: use of ref_reloc_sym without
>     a check for NULL
>
>   02: perf tools: Use CAP_SYS_ADMIN with perf_event_paranoid checks
>     Replace the use of euid==0 with a check for CAP_SYS_ADMIN whenever
>     perf_event_paranoid level is verified.
>     * This patch has been reviewed previously and is unchanged.
>     * I kept Acks and Sign-offs.
>
>   03: perf util: kernel profiling is disallowed only when perf_event_paranoid>1
>     Align perf logic regarding perf_event_paranoid to match kernel's.
>     This has been reported by Arnaldo.
>
>   04: perf symbols: Use CAP_SYSLOG with kptr_restrict checks
>     Replace the use of uid and euid with a check for CAP_SYSLOG when
>     kptr_restrict is verified (similar to kernel/kallsyms.c and lib/vsprintf.c).
>     Consult perf_event_paranoid when kptr_restrict==0 (see kernel/kallsyms.c).
>     * A previous version of this patch has been reviewed previously, but I
>     * modified it in a non-trivial way, so I removed Acks.
>
>   05: perf: warn perf_event_paranoid restrict kernel symbols
>     Warn that /proc/sys/kernel/perf_event_paranoid can also restrict kernel
>     symbols.
>
> Igor Lubashev (5):
>   perf event: Check ref_reloc_sym before using it
>   perf tools: Use CAP_SYS_ADMIN with perf_event_paranoid checks
>   perf util: kernel profiling is disallowed only when perf_event_paranoid > 1
>   perf symbols: Use CAP_SYSLOG with kptr_restrict checks
>   perf: warn that perf_event_paranoid can restrict kernel symbols
>
>  tools/perf/arch/arm/util/cs-etm.c    |  3 ++-

For the coresight part:

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

>  tools/perf/arch/arm64/util/arm-spe.c |  3 ++-
>  tools/perf/arch/x86/util/intel-bts.c |  3 ++-
>  tools/perf/arch/x86/util/intel-pt.c  |  2 +-
>  tools/perf/builtin-record.c          |  2 +-
>  tools/perf/builtin-top.c             |  2 +-
>  tools/perf/builtin-trace.c           |  2 +-
>  tools/perf/util/event.c              |  7 ++++---
>  tools/perf/util/evsel.c              |  2 +-
>  tools/perf/util/symbol.c             | 15 ++++++++++++---
>  10 files changed, 27 insertions(+), 14 deletions(-)

For the set:

Tested-by: Mathieu Poirier <mathieu.poirier@linaro.org>

>
> --
> 2.7.4
>
