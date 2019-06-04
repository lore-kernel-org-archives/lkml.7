Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A7FAC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 13:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08B6620679
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 13:01:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbfFDNBu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 09:01:50 -0400
Received: from mga07.intel.com ([134.134.136.100]:5100 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727067AbfFDNBu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 09:01:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jun 2019 06:01:49 -0700
X-ExtLoop1: 1
Received: from ahunter-desktop.fi.intel.com ([10.237.72.198])
  by fmsmga005.fm.intel.com with ESMTP; 04 Jun 2019 06:01:48 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Jin Yao <yao.jin@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 00/19] perf intel-pt: Add support for efficient time interval filtering
Date:   Tue,  4 Jun 2019 15:59:58 +0300
Message-Id: <20190604130017.31207-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Here are some patches to add support for efficient time interval filtering.
First there are 3 patches to add perf time interval to the itrace options
structure.  Then changes to Intel PT to support "fast forwarding" to a
particular timestamp.  The filtering is added in patch "perf intel-pt: Add
support for efficient time interval filtering".  After that there are
patches to time-utils, leading up to adding a new test and adding support
multiple explicit time intervals.

The Intel PT changes make time filtering much faster because decoding is
limited to the minimal time ranges needed to support the time intervals.


Adrian Hunter (19):
      perf auxtrace: Add perf time interval to itrace_synth_ops
      perf script: Set perf time interval in itrace_synth_ops
      perf report: Set perf time interval in itrace_synth_ops
      perf intel-pt: Add lookahead callback
      perf intel-pt: Factor out intel_pt_8b_tsc()
      perf intel-pt: Factor out intel_pt_reposition()
      perf intel-pt: Add reposition parameter to intel_pt_get_data()
      perf intel-pt: Add intel_pt_fast_forward()
      perf intel-pt: Factor out intel_pt_get_buffer()
      perf intel-pt: Add support for lookahead
      perf intel-pt: Add support for efficient time interval filtering
      perf time-utils: Treat time ranges consistently
      perf time-utils: Factor out set_percent_time()
      perf time-utils: Prevent percentage time range overlap
      perf time-utils: Fix --time documentation
      perf time-utils: Simplify perf_time__parse_for_ranges() error paths slightly
      perf time-utils: Make perf_time__parse_for_ranges() more logical
      perf tests: Add a test for time-utils
      perf time-utils: Add support for multiple explicit time intervals

 tools/perf/Documentation/perf-diff.txt             |  14 +-
 tools/perf/Documentation/perf-report.txt           |   9 +-
 tools/perf/Documentation/perf-script.txt           |   9 +-
 tools/perf/builtin-report.c                        |   8 +-
 tools/perf/builtin-script.c                        |   8 +-
 tools/perf/tests/Build                             |   1 +
 tools/perf/tests/builtin-test.c                    |   4 +
 tools/perf/tests/tests.h                           |   1 +
 tools/perf/tests/time-utils-test.c                 | 251 ++++++++++++++++
 tools/perf/util/auxtrace.h                         |  34 +++
 .../perf/util/intel-pt-decoder/intel-pt-decoder.c  | 188 ++++++++++--
 .../perf/util/intel-pt-decoder/intel-pt-decoder.h  |   5 +
 tools/perf/util/intel-pt.c                         | 325 +++++++++++++++++++--
 tools/perf/util/time-utils.c                       | 132 ++++++---
 14 files changed, 894 insertions(+), 95 deletions(-)
 create mode 100644 tools/perf/tests/time-utils-test.c


Regards
Adrian
