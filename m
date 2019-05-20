Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B30C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 11:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B63F620645
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 11:37:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732800AbfETLhl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 07:37:41 -0400
Received: from mga04.intel.com ([192.55.52.120]:48121 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725601AbfETLhl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 07:37:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 May 2019 04:37:41 -0700
X-ExtLoop1: 1
Received: from ahunter-desktop.fi.intel.com ([10.237.72.198])
  by fmsmga004.fm.intel.com with ESMTP; 20 May 2019 04:37:39 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 00/22] perf intel-pt: Add support for instructions-per-cycle (IPC)
Date:   Mon, 20 May 2019 14:37:06 +0300
Message-Id: <20190520113728.14389-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Here are some patches that add support for IPC. There are 3 dependent fixes
to start with.  Display of IPC by perf script is in patch 8 "perf script: Add
output of IPC ratio".  Information about Intel PT and IPC is in patch 12
"perf intel-pt: Document IPC usage".  Then there are patches to export IPC
including un-related patch 14 "perf db-export: Add brief documentation" and
un-related patch 22 "perf scripts python: exported-sql-viewer.py: Select find
text when find bar is activated"


Adrian Hunter (22):
      perf intel-pt: Fix itrace defaults for perf script
      perf auxtrace: Fix itrace defaults for perf script
      perf intel-pt: Fix itrace defaults for perf script intel-pt documentation
      perf intel-pt: Factor out intel_pt_update_sample_time
      perf intel-pt: Accumulate cycle count from CYC packets
      perf tools: Add IPC information to perf_sample
      perf intel-pt: Add support for samples to contain IPC ratio
      perf script: Add output of IPC ratio
      perf intel-pt: Record when decoding PSB+ packets
      perf intel-pt: Re-factor TIP cases in intel_pt_walk_to_ip
      perf intel-pt: Accumulate cycle count from TSC/TMA/MTC packets
      perf intel-pt: Document IPC usage
      perf thread-stack: Accumulate IPC information
      perf db-export: Add brief documentation
      perf db-export: Export IPC information
      perf scripts python: export-to-sqlite.py: Export IPC information
      perf scripts python: export-to-postgresql.py: Export IPC information
      perf scripts python: exported-sql-viewer.py: Add IPC information to the Branch reports
      perf scripts python: exported-sql-viewer.py: Add CallGraphModelParams
      perf scripts python: exported-sql-viewer.py: Add IPC information to Call Graph Graph
      perf scripts python: exported-sql-viewer.py: Add IPC information to Call Tree
      perf scripts python: exported-sql-viewer.py: Select find text when find bar is activated

 tools/perf/Documentation/db-export.txt             |  41 +++
 tools/perf/Documentation/intel-pt.txt              |  40 ++-
 tools/perf/Documentation/perf-script.txt           |   5 +-
 tools/perf/builtin-script.c                        |  23 +-
 tools/perf/scripts/python/export-to-postgresql.py  |  36 ++-
 tools/perf/scripts/python/export-to-sqlite.py      |  36 ++-
 tools/perf/scripts/python/exported-sql-viewer.py   | 294 ++++++++++++++++-----
 tools/perf/util/auxtrace.c                         |   3 +-
 tools/perf/util/event.h                            |   2 +
 .../perf/util/intel-pt-decoder/intel-pt-decoder.c  | 141 ++++++++--
 .../perf/util/intel-pt-decoder/intel-pt-decoder.h  |   1 +
 tools/perf/util/intel-pt.c                         |  32 ++-
 .../util/scripting-engines/trace-event-python.c    |   8 +-
 tools/perf/util/thread-stack.c                     |  14 +
 tools/perf/util/thread-stack.h                     |   4 +
 15 files changed, 556 insertions(+), 124 deletions(-)
 create mode 100644 tools/perf/Documentation/db-export.txt


Regards
Adrian
