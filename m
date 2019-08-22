Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C84C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 14:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A063F233A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 14:42:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732838AbfHVOmc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 10:42:32 -0400
Received: from foss.arm.com ([217.140.110.172]:47230 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726332AbfHVOmb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 10:42:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E82C8337;
        Thu, 22 Aug 2019 07:42:30 -0700 (PDT)
Received: from e121650-lin.cambridge.arm.com (e121650-lin.cambridge.arm.com [10.1.196.120])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 917F13F706;
        Thu, 22 Aug 2019 07:42:29 -0700 (PDT)
From:   Raphael Gault <raphael.gault@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, catalin.marinas@arm.com,
        will.deacon@arm.com, acme@kernel.org, mark.rutland@arm.com,
        raph.gault+kdev@gmail.com, Raphael Gault <raphael.gault@arm.com>
Subject: [PATCH v4 0/7] arm64: Enable access to pmu registers by user-space
Date:   Thu, 22 Aug 2019 15:42:13 +0100
Message-Id: <20190822144220.27860-1-raphael.gault@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Changes since v3:
* Rebased on will/for-next/perf in order to include this patch [1]
* Re-introduce `mrs` hook used in previous versions
* Invert cpu feature to track homogeneity instead of heterogeneity
* Introduce accessor for boot_cpu_data (see second commit for more info)
* Apply Mark Rutland's comments


The perf user-space tool relies on the PMU to monitor events. It offers an
abstraction layer over the hardware counters since the underlying
implementation is cpu-dependent. We want to allow userspace tools to have
access to the registers storing the hardware counters' values directly.
This targets specifically self-monitoring tasks in order to reduce the
overhead by directly accessing the registers without having to go
through the kernel.
In order to do this we need to setup the pmu so that it exposes its registers
to userspace access.

The first patch add a test to the perf tool so that we can test that the
access to the registers works correctly from userspace.

The second patch introduces an accessor for `boot_cpu_data` which is
static. Including cpu.h turned out to cause a chain of dependencies so I
opted for the accessor since it is not much used.

The third patch add a capability in the arm64 cpufeatures framework in
order to detect when we are running on a homogeneous system.

The fourth patch re introduces the hooks to handling undefined
instruction for `mrs` instructions on pmu-related registers.

The fifth patch focuses on the armv8 pmuv3 PMU support and makes sure that
the access to the pmu registers is enable and that the userspace have
access to the relevent information in order to use them.

The sixth patch put in place callbacks to enable access to the hardware
counters from userspace when a compatible event is opened using the perf
API.

The seventh patch adds a short documentation about PMU counters direct
access from userspace.

[1]: https://lkml.org/lkml/2019/8/20/875

Raphael Gault (7):
  perf: arm64: Add test to check userspace access to hardware counters.
  arm64: cpu: Add accessor for boot_cpu_data
  arm64: cpufeature: Add feature to detect homogeneous systems
  arm64: pmu: Add hook to handle pmu-related undefined instructions
  arm64: pmu: Add function implementation to update event index in
    userpage.
  arm64: perf: Enable pmu counter direct access for perf event on armv8
  Documentation: arm64: Document PMU counters access from userspace

 .../arm64/pmu_counter_user_access.txt         |  42 +++
 arch/arm64/include/asm/cpu.h                  |   2 +-
 arch/arm64/include/asm/cpucaps.h              |   3 +-
 arch/arm64/include/asm/cpufeature.h           |  10 +
 arch/arm64/include/asm/mmu.h                  |   6 +
 arch/arm64/include/asm/mmu_context.h          |   2 +
 arch/arm64/include/asm/perf_event.h           |  14 +
 arch/arm64/kernel/cpufeature.c                |  32 ++-
 arch/arm64/kernel/cpuinfo.c                   |   7 +-
 arch/arm64/kernel/perf_event.c                |  77 ++++++
 drivers/perf/arm_pmu.c                        |  54 ++++
 include/linux/perf/arm_pmu.h                  |   2 +
 tools/perf/arch/arm64/include/arch-tests.h    |   7 +
 tools/perf/arch/arm64/tests/Build             |   1 +
 tools/perf/arch/arm64/tests/arch-tests.c      |   4 +
 tools/perf/arch/arm64/tests/user-events.c     | 254 ++++++++++++++++++
 16 files changed, 512 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/arm64/pmu_counter_user_access.txt
 create mode 100644 tools/perf/arch/arm64/tests/user-events.c

-- 
2.17.1

