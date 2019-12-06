Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6DA6C43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 23:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8834F20707
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 23:15:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cl4LbJJk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbfLFXPs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 18:15:48 -0500
Received: from mail-pj1-f74.google.com ([209.85.216.74]:33120 "EHLO
        mail-pj1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbfLFXPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 18:15:48 -0500
Received: by mail-pj1-f74.google.com with SMTP id z12so4420537pju.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 15:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=hVC/6epJlDfcBUXJAxx30qUP4KbNEPi/fuTxvexGqSc=;
        b=cl4LbJJkkmqJ4VKoltvj/IrOEsVBfTTpL/SRWOQl3Jq6UksZE+OeWvWuNPmiki5PDu
         pzkWtOpMAK0O0WlKe1LWizfCVxoRl4uqa87AlS/DQDSK1U5vztu/t3iXVOcsvmxIr/az
         wfurPR/2P9Suzx088AkcEl+m0sB5EWdoAJww21RbHvzUFU4+TGGj96JNxMWZuZw9dSh9
         jMg4Y1tNrQcIS/1y6d056FmDpXJb9zwzAaUH5IgSxuvhNeBfh5vM73dvfSjHL0GVBkVK
         ar7NbSCBo7Hrtvfnoprcgm6bbopfs8dOe0uXVgdlcbwVV9Q0UuFnQrTb5giR/UAX93f7
         zREQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hVC/6epJlDfcBUXJAxx30qUP4KbNEPi/fuTxvexGqSc=;
        b=LLoz1wtfjJRO3mh+9Ns9cnGhbpiKfA7aaR1Wx0rI8HXIZiGGTmQZfMzd6dZ1A7Y4K6
         STj5LEgki/M3hK6BzMgrj1g2Hge+iqcvu86XWQgjO7aVLvvgeXZw2EySNCEHBeOsrdAU
         HKNUrifpWMhoimS6aoR5Urg276pz3W+PhuauM7Ygl7Efx7aw9v/Hl8NL6xJWgB6mPxWH
         0iPFZdW1J2N7bCsOqABL0YPfY5tkH0mKpG0p0HP7XwVs2rskuVvS5MmrPuMM4wJQrYlW
         YfJXF74ylYfAX4v9EePZl0Ck9mbroow+GO4Gko6cHiERqCnGopj2meDqIVMbixXvEKaa
         SQTA==
X-Gm-Message-State: APjAAAX1JNzBufRTGfiAZGuUMdogcwXQsmpOHY+I1sAfPSL/gw0gJ61g
        kKZNCbxp5NhDUlDdPEHYQIpLtGDsi2Af
X-Google-Smtp-Source: APXvYqxAOMPrRQsPE7h4PPvw/muMJ8ww5BB6dKx8nSaubJHT/+ChcqfacZah4Sh55rDPgOKHUcdPQSg028cr
X-Received: by 2002:a63:6787:: with SMTP id b129mr6290229pgc.103.1575674147241;
 Fri, 06 Dec 2019 15:15:47 -0800 (PST)
Date:   Fri,  6 Dec 2019 15:15:29 -0800
In-Reply-To: <20191116011845.177150-1-irogers@google.com>
Message-Id: <20191206231539.227585-1-irogers@google.com>
Mime-Version: 1.0
References: <20191116011845.177150-1-irogers@google.com>
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
Subject: [PATCH v5 00/10] Optimize cgroup context switch
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
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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

The v5 patch set renames min_max_heap to min_heap as suggested by
Peter Zijlstra, it also addresses comments around preferring
__always_inline over inline.

The v4 patch set addresses review comments on the v3 patch set by
Peter Zijlstra.

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
  lib: introduce generic min-heap
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

 include/linux/min_heap.h   | 135 +++++++++
 include/linux/perf_event.h |  15 +
 kernel/events/core.c       | 542 +++++++++++++++++++++++++++++--------
 lib/Kconfig.debug          |  10 +
 lib/Makefile               |   1 +
 lib/test_min_heap.c        | 194 +++++++++++++
 6 files changed, 783 insertions(+), 114 deletions(-)
 create mode 100644 include/linux/min_heap.h
 create mode 100644 lib/test_min_heap.c

-- 
2.24.0.393.g34dc348eaf-goog

