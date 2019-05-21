Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D699BC072B5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 21:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF23C21883
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 21:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbfEUVlk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 17:41:40 -0400
Received: from mga11.intel.com ([192.55.52.93]:32413 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726907AbfEUVlk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 17:41:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 May 2019 14:41:38 -0700
X-ExtLoop1: 1
Received: from otc-icl-cdi-210.jf.intel.com ([10.54.55.28])
  by orsmga006.jf.intel.com with ESMTP; 21 May 2019 14:41:38 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 0/9] TopDown metrics support for Icelake
Date:   Tue, 21 May 2019 14:40:46 -0700
Message-Id: <20190521214055.31060-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.14.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Icelake has support for measuring the level 1 TopDown metrics
directly in hardware. This is implemented by an additional METRICS
register, and a new Fixed Counter 3 that measures pipeline SLOTS.

Four TopDown metric events as separate perf events, which map to
internal METRICS register, are exposed. They are topdown-retiring,
topdown-bad-spec, topdown-fe-bound and topdown-be-bound.
Those events do not exist in hardware, but can be allocated by the
scheduler. We use a special 0xff event code, which is reserved for
software. The value of TopDown metric events can be calculated by
multiplying the METRICS (percentage) register with SLOTS fixed counter.

New in Icelake
- Do not require generic counters. This allows to collect TopDown always
  in addition to other events.
- Measuring TopDown per thread/process instead of only per core

Limitation
- To get accurate result and avoid reading the METRICS register multiple
  times, the TopDown metrics events and SLOTS event have to be in the
  same group.
- METRICS and SLOTS registers have to be cleared after each read by SW.
  That is to prevent the lose of precision and a known side effect of
  METRICS register.
- Cannot do sampling read SLOTS and TopDown metric events

Please refer SDM Vol3, 18.3.9.3 Performance Metrics for the details of
TopDown metrics.

Andi Kleen (7):
  perf/core: Support a REMOVE transaction
  perf/x86/intel: Basic support for metrics counters
  perf/x86/intel: Support overflows on SLOTS
  perf/x86/intel: Set correct weight for TopDown metrics events
  perf/x86/intel: Export new TopDown metrics events for Icelake
  perf, tools, stat: Support new per thread TopDown metrics
  perf, tools: Add documentation for topdown metrics

Kan Liang (2):
  perf/x86/intel: Support hardware TopDown metrics
  perf/x86/intel: Disable sampling read slots and topdown

 arch/x86/events/core.c                 |  63 ++++++--
 arch/x86/events/intel/core.c           | 284 +++++++++++++++++++++++++++++++--
 arch/x86/events/perf_event.h           |  31 ++++
 arch/x86/include/asm/msr-index.h       |   3 +
 arch/x86/include/asm/perf_event.h      |  30 ++++
 include/linux/perf_event.h             |   7 +
 kernel/events/core.c                   |   5 +
 tools/perf/Documentation/perf-stat.txt |   9 +-
 tools/perf/Documentation/topdown.txt   | 223 ++++++++++++++++++++++++++
 tools/perf/builtin-stat.c              |  24 +++
 tools/perf/util/stat-shadow.c          |  89 +++++++++++
 tools/perf/util/stat.c                 |   4 +
 tools/perf/util/stat.h                 |   8 +
 13 files changed, 754 insertions(+), 26 deletions(-)
 create mode 100644 tools/perf/Documentation/topdown.txt

-- 
2.14.5

