Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9533C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 01:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B44C920835
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 01:06:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbfCSBGX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 21:06:23 -0400
Received: from mga07.intel.com ([134.134.136.100]:35823 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726579AbfCSBGW (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 21:06:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Mar 2019 18:06:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,495,1544515200"; 
   d="scan'208";a="283811098"
Received: from skl.sh.intel.com ([10.239.159.132])
  by orsmga004.jf.intel.com with ESMTP; 18 Mar 2019 18:06:20 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v3 0/4] perf: Support a new 'percore' event qualifier
Date:   Tue, 19 Mar 2019 16:56:52 +0800
Message-Id: <1552985816-20915-1-git-send-email-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'percore' event qualifier which sums up the event counts for both
hardware threads in a core. For example,

perf stat -e cpu/event=0,umask=0x3,percore=1/,cpu/event=0,umask=0x3/

In this example, we count the event 'ref-cycles' per-core and per-CPU in
one perf stat command-line.

We can already support per-core counting with --per-core, but it's
often useful to do this together with other metrics that are collected
per CPU (per hardware thread). So this patch series supports this
per-core counting on a event level.

 v3:
 ---
 Simplify the patch: "perf: Add a 'percore' event qualifier"
 Other patches don't have changes.

 v2:
 ---
 1. Change 'coresum' to 'percore'.
 2. Move the aggregate counts printing to a seperate patch.

Jin Yao (4):
  perf: Add a 'percore' event qualifier
  perf stat: Factor out aggregate counts printing
  perf stat: Support 'percore' event qualifier
  perf test: Add a simple test for term 'percore'

 tools/perf/Documentation/perf-stat.txt |   4 ++
 tools/perf/builtin-stat.c              |  21 +++++++
 tools/perf/tests/parse-events.c        |  10 ++-
 tools/perf/util/evsel.c                |   2 +
 tools/perf/util/evsel.h                |   3 +
 tools/perf/util/parse-events.c         |  27 +++++++++
 tools/perf/util/parse-events.h         |   1 +
 tools/perf/util/parse-events.l         |   1 +
 tools/perf/util/stat-display.c         | 108 ++++++++++++++++++++++++---------
 tools/perf/util/stat.c                 |   8 ++-
 10 files changed, 151 insertions(+), 34 deletions(-)

-- 
2.7.4

