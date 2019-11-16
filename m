Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC6C6C432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 01:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A410720733
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 01:18:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m+oUr6LD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbfKPBSv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 20:18:51 -0500
Received: from mail-pg1-f202.google.com ([209.85.215.202]:50177 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbfKPBSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 20:18:51 -0500
Received: by mail-pg1-f202.google.com with SMTP id u197so8548471pgc.17
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 17:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ZUzmEblzCu4i0QMDAqcjBIhHaYZF4xUnc6EPrpjs8GA=;
        b=m+oUr6LD7SGcMf5IM6mu649+U7cxDVK+6g8YT9MGNVLJ9cx9LrADDukztI6B9Hdnti
         5mnXHqBvDq5aocbnFBMpMLxXb8GF2lYtffx6D8JuV8Ct/VubYzztje4WJmsjwnuIUrY7
         BVJOSZodhzi3VPTcF36gL2evRaZMJ0YE1pwU0OxxMGXdxX+3U/SLwdlRM30AZaBnQbXM
         0FjnWff5BoxXiNIHoqrsIC/p6OflT/KeDLJez03xU8EofC27VvRsso7MzofXrrUJm5gU
         UoiHBCaKxkbshJf4OBsXORLzNDrtmwHv5CFL3YdrV5jHYkpnUf/hPbEOlubMkF/KZ+aI
         tgBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ZUzmEblzCu4i0QMDAqcjBIhHaYZF4xUnc6EPrpjs8GA=;
        b=gYvZaEGn5wVTXP5w2KHUhB55W2FtwCI0CeyzDArhcFLfWAxJUl95xUWV6x2XKviTOI
         j02vfeQt9l2UFAjJuHlwZ4A3/bTxuuhBiP4tYiniXrd4PIbup37Y36wTPx+FD2Os7nEU
         zd0Ahg0X3xZ1BlNpePlR6BTlw8zLLW6MmQYRkq/4vOJvypif2I2PnHz+epFPGyW3Y+fz
         Yv6R+dp4fNAXii9zMoWyz1BSYz/6pXLcLfSlg2nSiwggxM0YHRLmo6XjHWQrVmRu6jzS
         7ScymCOwN6jdLAYBfK47mLzeqI2X/V83U+TXs6CkHO86FfIhA5mnYpSNGdLALJrCZTta
         Qhbw==
X-Gm-Message-State: APjAAAUnddJMR/u15LXKqNQW1RnCtqaMHrnZqG+eiqgvIykvM5sthvaa
        At7Ilea0oVpwpEXDBtESiTVcSM8CT7Ln
X-Google-Smtp-Source: APXvYqxzKdtjV5hPEMecJBIE7pKadM9wdZYvUIHMoFXQsvB2JpF2ZovkxrEWglOY1jZUxeQvwR1g1Rgau1WZ
X-Received: by 2002:a63:f40e:: with SMTP id g14mr16147727pgi.132.1573867129795;
 Fri, 15 Nov 2019 17:18:49 -0800 (PST)
Date:   Fri, 15 Nov 2019 17:18:35 -0800
In-Reply-To: <20191114003042.85252-1-irogers@google.com>
Message-Id: <20191116011845.177150-1-irogers@google.com>
Mime-Version: 1.0
References: <20191114003042.85252-1-irogers@google.com>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: [PATCH v4 00/10] Optimize cgroup context switch
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

 include/linux/min_max_heap.h | 133 +++++++++
 include/linux/perf_event.h   |  15 +
 kernel/events/core.c         | 543 +++++++++++++++++++++++++++--------
 lib/Kconfig.debug            |  10 +
 lib/Makefile                 |   1 +
 lib/test_min_max_heap.c      | 194 +++++++++++++
 6 files changed, 782 insertions(+), 114 deletions(-)
 create mode 100644 include/linux/min_max_heap.h
 create mode 100644 lib/test_min_max_heap.c

-- 
2.24.0.432.g9d3f5f5b63-goog

