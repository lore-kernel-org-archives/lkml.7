Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE6BC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 00:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C73C206E6
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 00:30:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h4mMEIaY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbfKNAat (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 19:30:49 -0500
Received: from mail-pg1-f202.google.com ([209.85.215.202]:40552 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbfKNAas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 19:30:48 -0500
Received: by mail-pg1-f202.google.com with SMTP id q1so3162280pgl.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 16:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=VnJePqFNQKWZpRIOr4e8YrOk73ffsduTxdMikg1QHq0=;
        b=h4mMEIaYy+DDwd11rkZOUYKmBgU+lTA/0yfezvdMukeApN8KOP2qGRfMFmcocejBic
         3GiMMx8KQudLKHMaIj6w/putbaGP6INYEG9FNJKS+VjUAWX9g+VBAl27NONtqF38Mc5/
         cfe4mkvs0ckObKg80YhUWq0mglWVBxjsI79FzorKhI41TZXui/9c+Yn9riwr2AxWJqF6
         htVfc0B+gQQ+8f9SGU1FQYnXtUnxapG/PquCfdQHA9go00fS0quZGDIb/XskznruxYO3
         n6Q5k9wpbLdekBhwB8zzYXrX0TywNsy+5RaGqFZkF8AHWvEW0Ya0Fsm1fiWcjn/aCCpx
         UYFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=VnJePqFNQKWZpRIOr4e8YrOk73ffsduTxdMikg1QHq0=;
        b=rI9q4p7OUAIn0F917MrBdc/NYoJeh/8dn1nnlTqolhiOwfBEmI017Afa3XCvc7mz+1
         pSmCvd+0JSmwyjReRzNM8wnOVk6KLQ8FQtff9cU3F6kgb0edS5lySNCNqNykwFFrr0Ua
         7goS/k/K8JyrB8NRfY07me6h0E9xOyg2rmChU6J9jjbpueDH/lJVyCVuVca33BT8nEGD
         FcQkh+YukEqh4SAfgqa4m0wAsZtXp9yuIYv9ooLjOlm7MZv7hGOdvvF4bjIU5bDVCFFz
         wZXlnYYQEc6I/BZBhxgqgPQ/ERuGH/N0Du77xsdUCdGKkLK7FpR1JDLhMi44kSBcqst2
         hYIw==
X-Gm-Message-State: APjAAAXOUhAgEwztZkDUycDXJ/fopFXRN2BrQc7FbOydTzSwoEZ0ZtCf
        UDGOImMEi885FMB1/yErb4m/HnbTSfIQ
X-Google-Smtp-Source: APXvYqwopzHcKvKHJ8hz00r9XQFx2UnaKQyo1LSYRdDeM8hNquvKqTNShGDFGl4vbR1t38V2ozW7qCgviUG3
X-Received: by 2002:a63:b22:: with SMTP id 34mr6890849pgl.90.1573691446181;
 Wed, 13 Nov 2019 16:30:46 -0800 (PST)
Date:   Wed, 13 Nov 2019 16:30:32 -0800
Message-Id: <20191114003042.85252-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: [PATCH v3 00/10] Optimize cgroup context switch
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
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
        Sri Krishna chowdary <schowdary@nvidia.com>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Changbin Du <changbin.du@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Gary Hook <Gary.Hook@amd.com>, Arnd Bergmann <arnd@arndb.de>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid iterating over all per-CPU events during cgroup changing context
switches by organizing events by cgroup.

To make an efficient set of iterators, introduce a min max heap
utility with test.

These patches include a caching algorithm to improve the search for
the first event in a group by Kan Liang <kan.liang@linux.intel.com> as
well as rebasing hit "optimize event_filter_match during sched_in"
from https://lkml.org/lkml/2019/8/7/771.

The v2 patch set was modified by Peter Zijlstra in his perf/cgroup
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git

These patches follow Peter's reorganization and his fixes to the
perf_cpu_context min_heap storage code.

Ian Rogers (8):
  lib: introduce generic min max heap
  perf: Use min_max_heap in visit_groups_merge
  perf: Add per perf_cpu_context min_heap storage
  perf/cgroup: Grow per perf_cpu_context heap storage
  perf/cgroup: Order events in RB tree by cgroup id
  perf: simplify and rename visit_groups_merge
  perf: cache perf_event_groups_first for cgroups
  perf: optimize event_filter_match during sched_in

Kan Liang (1):
  perf/cgroup: Do not switch system-wide events in cgroup switch

Peter Zijlstra (1):
  perf/cgroup: Reorder perf_cgroup_connect()

 include/linux/min_max_heap.h | 134 +++++++++
 include/linux/perf_event.h   |  14 +
 kernel/events/core.c         | 512 ++++++++++++++++++++++++++++-------
 lib/Kconfig.debug            |  10 +
 lib/Makefile                 |   1 +
 lib/test_min_max_heap.c      | 194 +++++++++++++
 6 files changed, 769 insertions(+), 96 deletions(-)
 create mode 100644 include/linux/min_max_heap.h
 create mode 100644 lib/test_min_max_heap.c

-- 
2.24.0.432.g9d3f5f5b63-goog

