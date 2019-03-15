Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 096C1C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 08:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D168A218AC
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 08:13:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728539AbfCOINl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 04:13:41 -0400
Received: from mga02.intel.com ([134.134.136.20]:56884 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727557AbfCOINl (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 04:13:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Mar 2019 01:13:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,481,1544515200"; 
   d="scan'208";a="134268094"
Received: from skl.sh.intel.com ([10.239.159.132])
  by orsmga003.jf.intel.com with ESMTP; 15 Mar 2019 01:13:38 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v1 0/3] perf: Support a new coresum event qualifier
Date:   Sat, 16 Mar 2019 00:04:13 +0800
Message-Id: <1552665856-27741-1-git-send-email-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The coresum event qualifier which sums up the event counts for both
hardware threads in a core. For example,

perf stat -e cpu/event=0,umask=0x3,coresum=1/,cpu/event=0,umask=0x3/

In this example, we count the event 'ref-cycles' per-core and per-CPU in
one perf stat command-line.

We can already support per-core counting with --per-core, but it's
often useful to do this together with other metrics that are collected
per CPU (per hardware thread). So this patch series supports this
per-core counting on a event level.

Jin Yao (3):
  perf: Add a coresum event qualifier
  perf stat: Support coresum event qualifier
  perf test: Add a simple test for term coresum

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

