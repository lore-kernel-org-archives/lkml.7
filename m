Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65645C5B57D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 07:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3290F21721
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 07:00:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qrUIhAHe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbfGBHAS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 03:00:18 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:53175 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfGBHAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 03:00:18 -0400
Received: by mail-pg1-f202.google.com with SMTP id a13so9046906pgw.19
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 00:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=yOqaOJX//F+w8sorh416lvogg9Z8VKLI9eeOfv1vW9Q=;
        b=qrUIhAHe10e4kTsu8VCvWsZh5qubIwFCoZawmgrciNZiYqvn3wfJEsKgI78PjEaN7M
         ezaocYJVTyRzQAVBAQVnC4rm/hwthwx1Iz6G99saMnBWZGcqzn8d33yW0bnIU/DyeIq8
         H4/aFYzczGyaiPC+oXbhSlHmhatA4f6cYboyKhaFcUfPOvqIDgQw/MWjVH+mu6mA7w/M
         4nGv3nQ3h/msxZBmapkhty7WcMcFQhfUdD9sGMfO8Zaa8Lfs6R4da/dVLuhOQo1BQns0
         TJxV9UrKuQcSNsLzDpddMLv4YrxFU+UbwlBB9HUCF12QJA3p9/dTilhrP/PDR7uxX5lp
         JNOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=yOqaOJX//F+w8sorh416lvogg9Z8VKLI9eeOfv1vW9Q=;
        b=ZxiLN83U4FYp6a51+MiCOYCf6SVdIzbBM8BRGEwk1QMYGAbXRBZTT3vyB8Ebc34xO3
         tE/XZm98KHoDaJj5+n/B8arm3hVR7DDCNT8bjxeSJCHk96txexpwL+bejTGNRedPxLWT
         gaoJXzQohWw6qezJvNbB4hesh0/ao8/OEvRDEoSnyYCKVWgOpV6/ibbH8zflnS/hIsfg
         MM3uOUKVxC7KF0kjIWklgYCgI2wjwxp28NNzKh/i7ea2NnnqaWuLN8XjIdyj7Yt3xMAY
         xIswOYNOQqg/xYM3jiC1RdFy5aYOJYyNgVjKwfpbduXzNfYgnHbDKIfSqlszHeSSYDcc
         +zLw==
X-Gm-Message-State: APjAAAUQuK8xbwfupRiv+vouDMr0eefodc2H3iRfqXljfoPrfnFNRzjd
        QaZKXyCk0gGB5DMQ35KxFPpsdDg2kE9Y
X-Google-Smtp-Source: APXvYqwlak+YqNDgmT1apscnrjs8g8+8WUX12Dn6W4ncqk+z1eAih4vN+6wwHAJOIXL5I6pn1mkDvrhg2zJm
X-Received: by 2002:a63:c03:: with SMTP id b3mr29613503pgl.68.1562050817257;
 Tue, 02 Jul 2019 00:00:17 -0700 (PDT)
Date:   Mon,  1 Jul 2019 23:59:48 -0700
Message-Id: <20190702065955.165738-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH 0/7] Optimize cgroup context switch
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
2.22.0.410.gd8fdbe21b5-goog

