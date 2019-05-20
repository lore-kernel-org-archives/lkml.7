Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50FDDC04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 05:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CC392081C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 05:38:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730179AbfETFiB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 01:38:01 -0400
Received: from mga11.intel.com ([192.55.52.93]:24172 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729493AbfETFiA (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 01:38:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 May 2019 22:38:00 -0700
X-ExtLoop1: 1
Received: from skl.sh.intel.com ([10.239.159.132])
  by fmsmga007.fm.intel.com with ESMTP; 19 May 2019 22:37:58 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v1 0/9] perf diff: diff cycles at basic block level
Date:   Mon, 20 May 2019 21:27:47 +0800
Message-Id: <1558358876-32211-1-git-send-email-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some cases small changes in hot loops can show big differences.
But it's difficult to identify these differences.

perf diff currently can only diff symbols (functions). We can also expand
it to diff cycles of individual programs blocks as reported by timed LBR.
This would allow to identify changes in specific code accurately.

With this patch set, for example,

    perf record -b ./div
    perf record -b ./div
    perf diff --basic-block

     # Cycles diff  Basic block (start:end)
     # ...........  .......................
     #
              -20   native_write_msr (7fff9a069900:7fff9a06990b)
               -3   __indirect_thunk_start (7fff9ac02ca0:7fff9ac02ca0)
                1   __indirect_thunk_start (7fff9ac02cac:7fff9ac02cb0)
                0   rand@plt (490:490)
                0   rand (3af60:3af64)
                0   rand (3af69:3af6d)
                0   main (4e8:4ea)
                0   main (4ef:500)
                0   main (4ef:535)
                0   compute_flag (640:644)
                0   compute_flag (649:659)
                0   __random_r (3ac40:3ac76)
                0   __random_r (3ac40:3ac88)
                0   __random_r (3ac90:3ac9c)
                0   __random (3aac0:3aad2)
                0   __random (3aae0:3aae7)
                0   __random (3ab03:3ab0f)
                0   __random (3ab14:3ab1b)
                0   __random (3ab28:3ab2e)
                0   __random (3ab4a:3ab53)

The "basic-block" is a new perf-diff option, which enables the displaying
of cycles difference of same program basic block amongst two or more
perf.data. The program basic block is the code block between two branches
in a function.

Jin Yao (9):
  perf util: Create block_info structure
  perf util: Add block_info in hist_entry
  perf diff: Check if all data files with branch stacks
  perf diff: Get a list of symbols(functions)
  perf diff: Use hists to manage basic blocks
  perf diff: Link same basic blocks among different data files
  perf diff: Compute cycles diff of basic blocks
  perf diff: Print the basic block cycles diff
  perf diff: Documentation --basic-block option

 tools/perf/Documentation/perf-diff.txt |   5 +
 tools/perf/builtin-diff.c              | 521 ++++++++++++++++++++++++++++++++-
 tools/perf/util/hist.c                 |  24 +-
 tools/perf/util/hist.h                 |   6 +
 tools/perf/util/sort.h                 |   4 +
 tools/perf/util/symbol.c               |  22 ++
 tools/perf/util/symbol.h               |  23 ++
 7 files changed, 594 insertions(+), 11 deletions(-)

-- 
2.7.4

