Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 408F7C43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 12:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2239920896
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 12:53:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729177AbfFKMxc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 08:53:32 -0400
Received: from foss.arm.com ([217.140.110.172]:60656 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727947AbfFKMxb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 08:53:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3927D346;
        Tue, 11 Jun 2019 05:53:31 -0700 (PDT)
Received: from e121650-lin.cambridge.arm.com (unknown [10.1.196.120])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F38F53F557;
        Tue, 11 Jun 2019 05:53:29 -0700 (PDT)
From:   Raphael Gault <raphael.gault@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, catalin.marinas@arm.com,
        will.deacon@arm.com, acme@kernel.org, mark.rutland@arm.com,
        Raphael Gault <raphael.gault@arm.com>
Subject: [PATCH 0/7] arm64: Enable access to pmu registers by user-space
Date:   Tue, 11 Jun 2019 13:53:08 +0100
Message-Id: <20190611125315.18736-1-raphael.gault@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The perf user-space tool relies on the PMU to monitor events. It offers an
abstraction layer over the hardware counters since the underlying
implementation is cpu-dependent. We want to allow userspace tools to have
access to the registers storing the hardware counters' values directly.
This targets specifically self-monitoring tasks in order to reduce the
overhead by directly accessing the registers without having to go
through the kernel.
In order to do this we need to setup the pmu so that it exposes its registers
to userspace access.

The first patch enables the tests for arm64 architecture in the perf
tool to be compiled systematically.

The second patch add a test to the perf tool so that we can test that the
access to the registers works correctly from userspace.

The third patch adds another test similar to the first one but this time
using rseq as mechanism to make sure of the data correctness.

The fourth patch focuses on the armv8 pmuv3 PMU support and makes sure that
the access to the pmu registers is enable and that the userspace have
access to the relevent information in order to use them.

The fifth patch adds a hook to handle faulting access to the pmu
registers. This is necessary in order to have a coherent behaviour
on big.LITTLE environment.

The sixth patch put in place callbacks to enable access to the hardware
counters from userspace when a compatible event is opened using the perf
API.

Raphael Gault (7):
  perf: arm64: Compile tests unconditionally
  perf: arm64: Add test to check userspace access to hardware counters.
  perf: arm64: Use rseq to test userspace access to pmu counters
  arm64: pmu: Add function implementation to update event index in
    userpage.
  arm64: pmu: Add hook to handle pmu-related undefined instructions
  arm64: perf: Enable pmu counter direct access for perf event on armv8
  Documentation: arm64: Document PMU counters access from userspace

 .../arm64/pmu_counter_user_access.txt         |  42 +++
 arch/arm64/include/asm/mmu.h                  |   6 +
 arch/arm64/include/asm/mmu_context.h          |   2 +
 arch/arm64/include/asm/perf_event.h           |  14 +
 arch/arm64/kernel/cpufeature.c                |   4 +-
 arch/arm64/kernel/perf_event.c                |  76 ++++++
 drivers/perf/arm_pmu.c                        |  38 +++
 include/linux/perf/arm_pmu.h                  |   2 +
 tools/perf/arch/arm64/Build                   |   2 +-
 tools/perf/arch/arm64/include/arch-tests.h    |   9 +
 tools/perf/arch/arm64/include/rseq-arm64.h    | 220 +++++++++++++++
 tools/perf/arch/arm64/tests/Build             |   4 +-
 tools/perf/arch/arm64/tests/arch-tests.c      |  10 +
 tools/perf/arch/arm64/tests/rseq-pmu-events.c | 219 +++++++++++++++
 tools/perf/arch/arm64/tests/user-events.c     | 255 ++++++++++++++++++
 15 files changed, 899 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/arm64/pmu_counter_user_access.txt
 create mode 100644 tools/perf/arch/arm64/include/rseq-arm64.h
 create mode 100644 tools/perf/arch/arm64/tests/rseq-pmu-events.c
 create mode 100644 tools/perf/arch/arm64/tests/user-events.c

-- 
2.17.1

