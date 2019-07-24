Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28AADC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 22:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F03842189F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 22:38:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HwgQFcrh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387639AbfGXWiV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 18:38:21 -0400
Received: from mail-ua1-f73.google.com ([209.85.222.73]:42360 "EHLO
        mail-ua1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387405AbfGXWiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 18:38:21 -0400
Received: by mail-ua1-f73.google.com with SMTP id q23so4964805uam.9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 15:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/OdAqPiF1xWdTZ/ZfHZoBALhbJoXYbQBR0LMCwNsRrE=;
        b=HwgQFcrhnNg7v2WMGx6MNnftTwCwZZDi2E9lai14jYwmJHNuTLCeFa/58BvYNH5PaF
         o3RXMfzX2FPVfC+8A6QQ4ezAMNoQpOhQJztEkws0GJIpa9hhVSr1PPiBz/chZzLB7Eq0
         f5KtKMVbrPaxp1AhHgjTSmnEN0zvT4J8B96Tce+ErNNbaLld2JOAU3cjU4sYlkF92z1x
         iQ5YOf70OxovsRh9oM/sd6Rm4FtMHdBjp/ngxT0ETcw5z7oT6dDgqgzEp1Zp4kjAZzBf
         wgO0Qva3595ic3PtegqstA98eDUM2CLEVqFI5tTKnnjqNGwwfZsFgaBJqTZeFDGFLUvJ
         wFbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/OdAqPiF1xWdTZ/ZfHZoBALhbJoXYbQBR0LMCwNsRrE=;
        b=G67iHbIQV/DpmDhfigqUPvz3n2vlLOJKVk6DPkUw7GJSXWOGAuHeOqxbtHmNyb9+B7
         eDK9nwtFi0nhzi5bFgTA96Hq94bJ4D6lqp7iSP46MJgRiWl3WqIWPkTFSlQ/AoglO9q3
         xqMJHmTZwRX3HJPyltfhwMk3YlU810pqt4R/PUrLFVVYsRzRyueAp7LmaK+wY15Eryvn
         hH79QSp79yG+iXnO35DebbtNpChPCvm1aAgIg2q/bzMbbq24Q6l7nI/6MbdlU8KRylcl
         b1KVzMTKHuhgVTXcrETiKRv8nxK5e12OeMm/UPoLS18zNwtxi9wNtDEqpNyOyuGa2aWf
         ARTw==
X-Gm-Message-State: APjAAAXRuqU4pDbDTMsiEm5+2okO5rL3FgvVFAyi0Et97oxFwPOgDFsw
        Vmcv2ex4gwx8eenqQ+/VDsRNG4sDflUj
X-Google-Smtp-Source: APXvYqyyOOGauiY5/JIE27DRN6vaVbjAX4LZqXmZl+IayjuBOdYQMlbh/hTEfj30zwVITmVixcyafcVFs1iD
X-Received: by 2002:ab0:6619:: with SMTP id r25mr6421786uam.33.1564007900317;
 Wed, 24 Jul 2019 15:38:20 -0700 (PDT)
Date:   Wed, 24 Jul 2019 15:37:39 -0700
In-Reply-To: <20190702065955.165738-1-irogers@google.com>
Message-Id: <20190724223746.153620-1-irogers@google.com>
Mime-Version: 1.0
References: <20190702065955.165738-1-irogers@google.com>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
Subject: [PATCH v2 0/7] Optimize cgroup context switch
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Organize per-CPU perf event groups by cgroup then by group/insertion index.
To support cgroup hierarchies, a set of iterators is needed in
visit_groups_merge. To make this unbounded, use a per-CPU allocated
buffer. To make the set of iterators fast, use a min-heap ordered by
the group index.

These patches include a caching algorithm that avoids a search for the
first event in a group by Kan Liang <kan.liang@linux.intel.com> and the
set of patches as a whole have benefitted from conversation with him.

Version 2 of these patches addresses review comments and fixes bugs
found by Jiri Olsa and Peter Zijlstra.

Ian Rogers (7):
  perf: propagate perf_install_in_context errors up
  perf/cgroup: order events in RB tree by cgroup id
  perf: order iterators for visit_groups_merge into a min-heap
  perf: avoid a bounded set of visit_groups_merge iterators
  perf: cache perf_event_groups_first for cgroups
  perf: avoid double checking CPU and cgroup
  perf: rename visit_groups_merge to ctx_groups_sched_in

 include/linux/perf_event.h |   8 +
 kernel/events/core.c       | 511 +++++++++++++++++++++++++++++--------
 2 files changed, 414 insertions(+), 105 deletions(-)

-- 
2.22.0.709.g102302147b-goog

