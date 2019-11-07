Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED787C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 07:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE23821D6C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 07:48:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbfKGHsX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 02:48:23 -0500
Received: from mga02.intel.com ([134.134.136.20]:5314 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726696AbfKGHsX (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 02:48:23 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2019 23:48:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,277,1569308400"; 
   d="scan'208";a="227748260"
Received: from kbl.sh.intel.com ([10.239.159.163])
  by fmsmga004.fm.intel.com with ESMTP; 06 Nov 2019 23:48:20 -0800
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v7 0/7] perf report: Support sorting all blocks by cycles
Date:   Thu,  7 Nov 2019 15:47:12 +0800
Message-Id: <20191107074719.26139-1-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It would be useful to support sorting for all blocks by the
sampled cycles percent per block. This is useful to concentrate
on the globally hottest blocks.

This patch series implements a new option "--total-cycles" which
sorts all blocks by 'Sampled Cycles%'. The 'Sampled Cycles%' is
block sampled cycles aggregation / total sampled cycles

For example,

perf record -b ./div
perf report --total-cycles --stdio

 # To display the perf.data header info, please use --header/--header-only options.
 #
 #
 # Total Lost Samples: 0
 #
 # Samples: 2M of event 'cycles'
 # Event count (approx.): 2753248
 #
 # Sampled Cycles%  Sampled Cycles  Avg Cycles%  Avg Cycles                                              [Program Block Range]         Shared Object
 # ...............  ..............  ...........  ..........  .................................................................  ....................
 #
            26.04%            2.8M        0.40%          18                                             [div.c:42 -> div.c:39]                   div
            15.17%            1.2M        0.16%           7                                 [random_r.c:357 -> random_r.c:380]          libc-2.27.so
             5.11%          402.0K        0.04%           2                                             [div.c:27 -> div.c:28]                   div
             4.87%          381.6K        0.04%           2                                     [random.c:288 -> random.c:291]          libc-2.27.so
             4.53%          381.0K        0.04%           2                                             [div.c:40 -> div.c:40]                   div
             3.85%          300.9K        0.02%           1                                             [div.c:22 -> div.c:25]                   div
             3.08%          241.1K        0.02%           1                                           [rand.c:26 -> rand.c:27]          libc-2.27.so
             3.06%          240.0K        0.02%           1                                     [random.c:291 -> random.c:291]          libc-2.27.so
             2.78%          215.7K        0.02%           1                                     [random.c:298 -> random.c:298]          libc-2.27.so
             2.52%          198.3K        0.02%           1                                     [random.c:293 -> random.c:293]          libc-2.27.so
             2.36%          184.8K        0.02%           1                                           [rand.c:28 -> rand.c:28]          libc-2.27.so
             2.33%          180.5K        0.02%           1                                     [random.c:295 -> random.c:295]          libc-2.27.so
             2.28%          176.7K        0.02%           1                                     [random.c:295 -> random.c:295]          libc-2.27.so
             2.20%          168.8K        0.02%           1                                         [rand@plt+0 -> rand@plt+0]                   div
             1.98%          158.2K        0.02%           1                                 [random_r.c:388 -> random_r.c:388]          libc-2.27.so
             1.57%          123.3K        0.02%           1                                             [div.c:42 -> div.c:44]                   div
             1.44%          116.0K        0.42%          19                                 [random_r.c:357 -> random_r.c:394]          libc-2.27.so
 ......

This patch series supports both stdio and tui. And also with the supporting
of --percent-limit.

 v7:
 ---
 Use use_browser in report__browse_block_hists and support
 reporting for both stdio and tui modes.
 
 Move block tui browser code from ui/browsers/hists.c
 to block-info.c.

 Impacted patches:
 -----------------
  perf report: Sort by sampled cycles percent per block for stdio
  perf report: Support --percent-limit for --total-cycles
  perf report: Sort by sampled cycles percent per block for tui

 v6:
 ---
 Move block displaying codes from builtin-report.c to
 block-info.c. Two new functions are created in block-info.c
 (report__browse_block_hists, report__tui_browse_block_hists).

 Impacted patches:
 -----------------
  perf report: Sort by sampled cycles percent per block for stdio
  perf report: Support --percent-limit for --total-cycles
  perf report: Sort by sampled cycles percent per block for tui

 v5:
 ---
 1. Move all block functions to block-info.c

 2. Move the code of setting ms(map+sym) in block hist_entry to
    patch 'perf util: Support block formats with compare/sort/display'.
    Because this info is needed for reporting the block range
    (i.e. source line)

 3. Fix a crash issue when tui mode is enabled.

 Impacted patches:
 -----------------
  perf util: Support block formats with compare/sort/display
  perf report: Sort by sampled cycles percent per block for stdio
  perf report: Support --percent-limit for --total-cycles
  perf report: Sort by sampled cycles percent per block for tui

 v4:
 ---
 1. Move the block collection out of block printing.

 2. Use new option '--total-cycles' to replace '-s total_cycles'

 3. Move code for skipping column length calculation to patch:
    'perf diff: Don't use hack to skip column length calculation'

 4. Some minor updates and cleanup.

 v3:
 ---
 1. Move common block info functions to block-info.h/block-info.c

 2. Remove nasty hack for skipping calculation of column length.

 3. Some minor cleanup.

 v2:
 ---
 Rebase to perf/core branch

Jin Yao (7):
  perf diff: Don't use hack to skip column length calculation
  perf util: Cleanup and refactor block info functions
  perf util: Count the total cycles of all samples
  perf util: Support block formats with compare/sort/display
  perf report: Sort by sampled cycles percent per block for stdio
  perf report: Support --percent-limit for --total-cycles
  perf report: Sort by sampled cycles percent per block for tui

 tools/perf/Documentation/perf-report.txt |  11 +
 tools/perf/builtin-annotate.c            |   2 +-
 tools/perf/builtin-diff.c                | 121 +----
 tools/perf/builtin-report.c              |  61 ++-
 tools/perf/builtin-top.c                 |   3 +-
 tools/perf/ui/browsers/hists.c           |   7 +-
 tools/perf/ui/browsers/hists.h           |   2 +
 tools/perf/ui/stdio/hist.c               |  29 +-
 tools/perf/util/Build                    |   1 +
 tools/perf/util/block-info.c             | 545 +++++++++++++++++++++++
 tools/perf/util/block-info.h             |  78 ++++
 tools/perf/util/hist.c                   |  13 +-
 tools/perf/util/hist.h                   |   3 +-
 tools/perf/util/symbol.c                 |  22 -
 tools/perf/util/symbol.h                 |  24 -
 tools/perf/util/symbol_conf.h            |   1 +
 16 files changed, 762 insertions(+), 161 deletions(-)
 create mode 100644 tools/perf/util/block-info.c
 create mode 100644 tools/perf/util/block-info.h

-- 
2.17.1

