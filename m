Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE94ECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 17:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CC1620684
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 17:59:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729304AbfJGR7y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 13:59:54 -0400
Received: from mga11.intel.com ([192.55.52.93]:33632 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728079AbfJGR7x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 13:59:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Oct 2019 10:59:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,269,1566889200"; 
   d="scan'208";a="193161241"
Received: from unknown (HELO labuser-Ice-Lake-Client-Platform.jf.intel.com) ([10.54.55.65])
  by fmsmga007.fm.intel.com with ESMTP; 07 Oct 2019 10:59:52 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     jolsa@kernel.org, namhyung@kernel.org, ak@linux.intel.com,
        vitaly.slobodskoy@intel.com, pavel.gerasimov@intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 00/10] Stitch LBR call stack
Date:   Mon,  7 Oct 2019 10:59:00 -0700
Message-Id: <20191007175910.2805-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Start from Haswell, Linux perf can utilize the existing Last Branch
Record (LBR) facility to record call stack. However, the depth of the
reconstructed LBR call stack limits to the number of LBR registers.
E.g. on skylake, the depth of reconstructed LBR call stack is <= 32
That's because HW will overwrite the oldest LBR registers when it's
full.

However, the overwritten LBRs may still be retrieved from previous
sample. At that moment, HW hasn't overwritten the LBR registers yet.
Perf tools can stitch those overwritten LBRs on current call stacks to
get a more complete call stack.

To determine if LBRs can be stitched, the physical index of LBR
registers is required. A new sample type is introduced in patch 1 & 2
to dump the LBR Top-of-Stack (TOS) information for perf tools.
Besides, the maximum number of LBRs is required as well. Patch 3 & 4
retrieve the capabilities information from sysfs and save them in perf
header.
Patch 5 & 6 implements the LBR stitching approach.
Users can use the options introduced in patch 7-10 to enable the LBR
stitching approach for perf report, script, top and c2c.

The stitching approach base on LBR call stack technology. The known
limitations of LBR call stack technology still apply to the approach,
e.g. Exception handing such as setjmp/longjmp will have calls/returns
not match.
This approach is not full proof. There can be cases where it creates
incorrect call stacks from incorrect matches. There is no attempt
to validate any matches in another way. So it is not enabled by default.
However in many common cases with call stack overflows it can recreate
better call stacks than the default lbr call stack output. So if there
are problems with LBR overflows this is a possible workaround.

Performance impact:
The processing time may increase with the LBR stitching approach
enabled. The impact depends on the number of samples with stitched LBRs.

For sqlite's tcltest,
perf record --call-graph lbr -- make tcltest
perf report --stitch-lbr

There are 4.11% samples has stitched LBRs.
Total number of samples:                        2833728
The number of samples with stitched LBRs        116478

The processing time of perf report increases 6.8%
Without --stitch-lbr:                           55906106 usec
With --stitch-lbr:                              59728701 usec

For a simple test case tchain_edit with 43 depth of call stacks.
perf record --call-graph lbr -- ./tchain_edit
perf report --stitch-lbr

There are 99.9% samples has stitched LBRs.
Total number of samples:                        10915
The number of samples with stitched LBRs        10905

The processing time of perf report increases 67.4%
Without --stitch-lbr:                           11970508 usec
With --stitch-lbr:                              20036055 usec

The source code of tchain_edit.c is something like as below.
noinline void f43(void)
{
        int i;
        for (i = 0; i < 10000;) {

                if(i%2)
                        i++;
                else
                        i++;
        }
}

noinline void f42(void)
{
        int i;
        for (i = 0; i < 100; i++) {
                f43();
                f43();
                f43();
        }
}

noinline void f41(void)
{
        int i;
        for (i = 0; i < 100; i++) {
                f42();
                f42();
                f42();
        }
}

noinline void f40(void)
{
        f41();
}

... ...

noinline void f32(void)
{
        f33();
}

noinline void f31(void)
{
        int i;

        for (i = 0; i < 10000; i++) {
                if(i%2)
                        i++;
                else
                        i++;
        }

        f32();
}

noinline void f30(void)
{
        f31();
}

... ...

noinline void f1(void)
{
        f2();
}

int main()
{
        f1();
}

Kan Liang (10):
  perf/core, x86: Add PERF_SAMPLE_LBR_TOS
  perf tools: Support PERF_SAMPLE_LBR_TOS
  perf pmu: Add support for PMU capabilities
  perf header: Support CPU PMU capabilities
  perf machine: Refine the function for LBR call stack reconstruction
  perf tools: Stitch LBR call stack
  perf report: Add option to enable the LBR stitching approach
  perf script: Add option to enable the LBR stitching approach
  perf top: Add option to enable the LBR stitching approach
  perf c2c: Add option to enable the LBR stitching approach

 arch/x86/events/intel/lbr.c                   |   9 +
 include/linux/perf_event.h                    |   1 +
 include/uapi/linux/perf_event.h               |   4 +-
 kernel/events/core.c                          |  12 +
 tools/include/uapi/linux/perf_event.h         |   4 +-
 tools/perf/Documentation/perf-c2c.txt         |  11 +
 tools/perf/Documentation/perf-report.txt      |  11 +
 tools/perf/Documentation/perf-script.txt      |  11 +
 tools/perf/Documentation/perf-top.txt         |   9 +
 .../Documentation/perf.data-file-format.txt   |  16 +
 tools/perf/builtin-c2c.c                      |   6 +
 tools/perf/builtin-record.c                   |   3 +
 tools/perf/builtin-report.c                   |   6 +
 tools/perf/builtin-script.c                   |   6 +
 tools/perf/builtin-stat.c                     |   1 +
 tools/perf/builtin-top.c                      |  11 +
 tools/perf/util/branch.h                      |  10 +-
 tools/perf/util/env.h                         |   3 +
 tools/perf/util/event.h                       |   1 +
 tools/perf/util/evsel.c                       |  16 +-
 tools/perf/util/evsel.h                       |   1 +
 tools/perf/util/header.c                      | 110 +++++++
 tools/perf/util/header.h                      |   1 +
 tools/perf/util/machine.c                     | 303 ++++++++++++++----
 tools/perf/util/perf_event_attr_fprintf.c     |   2 +-
 tools/perf/util/pmu.c                         |  87 +++++
 tools/perf/util/pmu.h                         |  12 +
 tools/perf/util/synthetic-events.c            |   8 +
 tools/perf/util/thread.c                      |   3 +
 tools/perf/util/thread.h                      |  18 ++
 tools/perf/util/top.h                         |   1 +
 31 files changed, 626 insertions(+), 71 deletions(-)

-- 
2.17.1

