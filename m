Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EFA3C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 06:09:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 745962186A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 06:09:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfDLGJf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 02:09:35 -0400
Received: from mga11.intel.com ([192.55.52.93]:15191 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbfDLGJe (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 02:09:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Apr 2019 23:09:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,340,1549958400"; 
   d="scan'208";a="148609837"
Received: from skl.sh.intel.com ([10.239.159.132])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Apr 2019 23:09:32 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v4 0/4] perf: Support a new 'percore' event qualifier
Date:   Fri, 12 Apr 2019 21:59:46 +0800
Message-Id: <1555077590-27664-1-git-send-email-yao.jin@linux.intel.com>
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

 v4:
 ---
 Add percore qualifier to documantation.
 Rebase to latest perf/core branch

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

 tools/perf/Documentation/perf-list.txt |  12 ++++
 tools/perf/Documentation/perf-stat.txt |   4 ++
 tools/perf/builtin-stat.c              |  21 +++++++
 tools/perf/tests/parse-events.c        |  10 ++-
 tools/perf/util/evsel.c                |   2 +
 tools/perf/util/evsel.h                |   3 +
 tools/perf/util/parse-events.c         |  27 +++++++++
 tools/perf/util/parse-events.h         |   1 +
 tools/perf/util/parse-events.l         |   1 +
 tools/perf/util/stat-display.c         | 107 ++++++++++++++++++++++++---------
 tools/perf/util/stat.c                 |   8 ++-
 11 files changed, 163 insertions(+), 33 deletions(-)

-- 
2.7.4

