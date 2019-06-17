Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB260C31E44
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 05:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADD2521881
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 05:01:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbfFQFBZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 01:01:25 -0400
Received: from mga01.intel.com ([192.55.52.88]:51879 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbfFQFBY (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 01:01:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jun 2019 22:01:24 -0700
X-ExtLoop1: 1
Received: from skl.sh.intel.com ([10.239.159.132])
  by fmsmga008.fm.intel.com with ESMTP; 16 Jun 2019 22:01:22 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v3 0/7] perf diff: diff cycles at basic block level
Date:   Mon, 17 Jun 2019 20:50:50 +0800
Message-Id: <1560775857-22355-1-git-send-email-yao.jin@linux.intel.com>
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

 # perf record -b ./div
 # perf record -b ./div
 # perf diff -c cycles

 # Event 'cycles'
 #
 # Baseline         Block cycles diff [start:end]  Shared Object     Symbol
 # ........  ....................................  ................  ....................................
 #
     49.03%        -9 [         4ef:         520]  div               [.] main
     49.03%         0 [         4e8:         4ea]  div               [.] main
     49.03%         0 [         4ef:         500]  div               [.] main
     49.03%         0 [         4ef:         51c]  div               [.] main
     49.03%         0 [         4ef:         535]  div               [.] main
     18.82%         0 [       3ac40:       3ac4d]  libc-2.23.so      [.] __random_r
     18.82%         0 [       3ac40:       3ac5c]  libc-2.23.so      [.] __random_r
     18.82%         0 [       3ac40:       3ac76]  libc-2.23.so      [.] __random_r
     18.82%         0 [       3ac40:       3ac88]  libc-2.23.so      [.] __random_r
     18.82%         0 [       3ac90:       3ac9c]  libc-2.23.so      [.] __random_r
     16.29%        -8 [       3aac0:       3aac0]  libc-2.23.so      [.] __random
     16.29%         0 [       3aac0:       3aad2]  libc-2.23.so      [.] __random
     16.29%         0 [       3aae0:       3aae7]  libc-2.23.so      [.] __random
     16.29%         0 [       3ab03:       3ab0f]  libc-2.23.so      [.] __random
     16.29%         0 [       3ab14:       3ab1b]  libc-2.23.so      [.] __random
     16.29%         0 [       3ab28:       3ab2e]  libc-2.23.so      [.] __random
     16.29%         0 [       3ab4a:       3ab53]  libc-2.23.so      [.] __random
      8.11%         0 [         640:         644]  div               [.] compute_flag
      8.11%         0 [         649:         659]  div               [.] compute_flag
      5.46%         0 [       3af60:       3af60]  libc-2.23.so      [.] rand
      5.46%         0 [       3af60:       3af64]  libc-2.23.so      [.] rand
      2.25%         0 [         490:         490]  div               [.] rand@plt
      0.01%        26 [      c00a27:      c00a27]  [kernel.vmlinux]  [k] native_irq_return_iret
      0.00%      -157 [      2bf9f2:      2bfa63]  [kernel.vmlinux]  [k] update_blocked_averages
      0.00%       -56 [      2bf980:      2bf9d3]  [kernel.vmlinux]  [k] update_blocked_averages
      0.00%        48 [      2bf934:      2bf942]  [kernel.vmlinux]  [k] update_blocked_averages
      0.00%         3 [      2bfb38:      2bfb67]  [kernel.vmlinux]  [k] update_blocked_averages

The 'cycles' is a new perf-diff computation selection, which enables
the displaying of cycles difference of same program basic block amongst
two perf.data. The program basic block is the code block between two
branches in a function.

 v3:
 ---
 In v3, the major change is to move most of block stuffs from
 'struct hist_entry' to new structure 'struct block_hist' and
 update the code accordingly. But we still have to keep the 
 block_info in 'struct hist_entry' since we need to compare by 
 block info when inserting new entry to hists.

 Others are minor changes, such as abs() -> labs(), removing
 duplicated ops and etc.

 Changed patches:
  perf diff: Use hists to manage basic blocks per symbol
  perf diff: Link same basic blocks among different data
  perf diff: Print the basic block cycles diff

 v2:
 ---
 Keep standard perf diff format.

 Following is the v1 output.

 # perf diff --basic-block

 # Cycles diff  Basic block (start:end)
 # ...........  .......................
 #
          -208  hrtimer_interrupt (30b9e0:30ba42)
          -157  update_blocked_averages (2bf9f2:2bfa63)
          -126  interrupt_entry (c00880:c0093a)
           -86  hrtimer_interrupt (30bb29:30bb32)
           -74  hrtimer_interrupt (30ba65:30bac4)
           -56  update_blocked_averages (2bf980:2bf9d3)
            48  update_blocked_averages (2bf934:2bf942)
           -35  native_write_msr (267900:26790b)
            26  native_irq_return_iret (c00a27:c00a27)
            22  rcu_check_callbacks (2febb6:2febdc)
           -21  __hrtimer_run_queues (30b220:30b2a3)
            19  pvclock_gtod_notify (14ba0:14c1b)
           -18  task_tick_fair (2c5d29:2c5d41)

Jin Yao (7):
  perf util: Create block_info structure
  perf util: Add block_info in hist_entry
  perf diff: Check if all data files with branch stacks
  perf diff: Use hists to manage basic blocks per symbol
  perf diff: Link same basic blocks among different data
  perf diff: Print the basic block cycles diff
  perf diff: Documentation -c cycles option

 tools/perf/Documentation/perf-diff.txt |  14 +-
 tools/perf/builtin-diff.c              | 383 ++++++++++++++++++++++++++++++++-
 tools/perf/ui/stdio/hist.c             |  27 +++
 tools/perf/util/hist.c                 |  40 +++-
 tools/perf/util/hist.h                 |   9 +
 tools/perf/util/sort.h                 |  13 ++
 tools/perf/util/symbol.c               |  22 ++
 tools/perf/util/symbol.h               |  23 ++
 tools/perf/util/symbol_conf.h          |   1 +
 9 files changed, 522 insertions(+), 10 deletions(-)

-- 
2.7.4

