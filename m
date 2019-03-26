Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21EC9C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 22:39:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2E992087C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 22:39:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731644AbfCZWjx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 18:39:53 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44470 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726782AbfCZWjx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 18:39:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CCFFCA78;
        Tue, 26 Mar 2019 15:39:52 -0700 (PDT)
Received: from mammon-tx2.austin.arm.com (mammon-tx2.austin.arm.com [10.118.29.246])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 395773F614;
        Tue, 26 Mar 2019 15:39:52 -0700 (PDT)
From:   Jeremy Linton <jeremy.linton@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, will.deacon@arm.com, rjw@rjwysocki.net,
        lenb@kernel.org, mark.rutland@arm.com, sudeep.holla@arm.com,
        james.morse@arm.com, lorenzo.pieralisi@arm.com,
        linuxarm@huawei.com, Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH 0/4] arm64: SPE ACPI enablement
Date:   Tue, 26 Mar 2019 17:39:34 -0500
Message-Id: <20190326223938.5365-1-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series enables the Arm Statistical Profiling
Extension (SPE) on ACPI platforms.

This is possible because ACPI 6.3 uses a previously
reserved field in the MADT to store the SPE interrupt
number, similarly to how the normal PMU is described.
If a consistent valid interrupt exists across all the
cores in the system, a platform device is registered.
That then triggers the SPE module, which runs as normal.

This version also adds the ability to parse the PPTT for
IDENTICAL cores. We then use this to sanity check the
single SPE device we create. This creates a bit of a
problem with respect to the specification though. The
specification says that its legal for multiple tree's
to exist in the PPTT. We handle this fine, but what
happens in the case of multiple tree's is that the lack
of a common node with IDENTICAL set forces us to assume
that there are multiple non IDENTICAL cores in the
machine.

Jeremy Linton (4):
  ACPI/PPTT: Add function to return ACPI 6.3 Identical tokens
  ACPI/PPTT: Modify node flag detection to find last IDENTICAL
  arm_pmu: acpi: spe: Add initial MADT/SPE probing
  perf: arm_spe: Enable ACPI/Platform automatic module loading

 arch/arm64/include/asm/acpi.h |  3 ++
 drivers/acpi/pptt.c           | 82 ++++++++++++++++++++++++++++++-----
 drivers/perf/arm_pmu_acpi.c   | 69 +++++++++++++++++++++++++++++
 drivers/perf/arm_spe_pmu.c    | 11 ++++-
 include/linux/acpi.h          |  5 +++
 5 files changed, 157 insertions(+), 13 deletions(-)

-- 
2.20.1

