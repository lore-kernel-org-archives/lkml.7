Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB34C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 17:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 320FB20B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 17:15:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbfJJRPf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 13:15:35 -0400
Received: from foss.arm.com ([217.140.110.172]:36338 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726479AbfJJRPe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 13:15:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4252928;
        Thu, 10 Oct 2019 10:15:34 -0700 (PDT)
Received: from dawn-kernel.cambridge.arm.com (unknown [10.1.197.116])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3EA723F71A;
        Thu, 10 Oct 2019 10:15:33 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, will@kernel.org,
        mark.rutland@arm.com, catalin.marinas@arm.com, dave.martin@arm.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH 0/3] arm64: Fix support for systems without FP/SIMD
Date:   Thu, 10 Oct 2019 18:15:14 +0100
Message-Id: <20191010171517.28782-1-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes the original support for systems without FP/SIMD.
We have three set of issues with the current code :

1) We detect the absence of FP/SIMD after the SMP cpus are brought
online (i.e, SYSTEM scope). This means, some of the early kernel threads
could run with their TIF_FOREIGN_FPSTATE flag set which might be
inherited by applications forked by them (e.g, modprobe from initramfs).

Also we allow a hotplugged CPU to boot successfully even if it doesn't
have the FP/SIMD when we have decided otherwise at boot and have now
advertised the ELF HWCAP for the userspace.
Fix this by turning this to a BOOT_RESTRICTED_CPU_LOCAL feature to
allow the detection of the feature the very moment a CPU turns up
without FP/SIMD and also prevent a conflict after SMP boot.

2) As mentioned above, some tasks could have the TIF flag set,
which will never be cleared after we detect the capability.
Thus they could get stuck indefinitely in do_notfiy_resume().
Fix this by clearing the TIF flag for such tasks but continuing
to avoid the save/restore of the FP state.

3) The compat ELF_HWCAP bits are statically initialised to indicate
that the FP/SIMD support is available. This must be updated dynamically
to provide the correct flags to the userspace.

Tested with a 32bit Debian Jessie fs on Fast model (with and without
FP support).

Suzuki K Poulose (3):
  arm64: cpufeature: Fix the type of no FP/SIMD capability
  arm64: nofpsmid: Clear TIF_FOREIGN_FPSTATE flag for early tasks
  arm64: cpufeature: Set the FP/SIMD compat HWCAP bits properly

 arch/arm64/kernel/cpufeature.c | 39 ++++++++++++++++++++++++++++++----
 arch/arm64/kernel/fpsimd.c     | 26 ++++++++++++++---------
 2 files changed, 51 insertions(+), 14 deletions(-)

-- 
2.21.0

