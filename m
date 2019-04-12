Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C0A0C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 17:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72CA82077C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 17:14:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbfDLROb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 13:14:31 -0400
Received: from foss.arm.com ([217.140.101.70]:37062 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726711AbfDLROa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 13:14:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 95DD715AB;
        Fri, 12 Apr 2019 10:14:30 -0700 (PDT)
Received: from e108454-lin.cambridge.arm.com (e108454-lin.cambridge.arm.com [10.1.196.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7E5AB3F718;
        Fri, 12 Apr 2019 10:14:28 -0700 (PDT)
From:   Julien Grall <julien.grall@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will.deacon@arm.com,
        christoffer.dall@arm.com, marc.zyngier@arm.com,
        james.morse@arm.com, julien.thierry@arm.com,
        suzuki.poulose@arm.com, Dave.Martin@arm.com,
        ard.biesheuvel@linaro.org, Julien Grall <julien.grall@arm.com>
Subject: [PATCH v2 0/3] arm64/fpsimd: Don't disable softirq when touching FPSIMD/SVE state
Date:   Fri, 12 Apr 2019 18:14:17 +0100
Message-Id: <20190412171420.29065-1-julien.grall@arm.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This patch series keep softirqs enabled while touching FPSIMD/SVE state. For
more details on the impact see patch #3.

This patch series has been benchmarked on Linux 5.1-rc4 with defconfig.

On Juno2:
    * hackbench 100 process 1000 (10 times)
    * .7% quicker

On ThunderX 2:
    * hackbench 1000 process 1000 (20 times)
    * 3.4% quicker

Note that while the benchmark has been done on 5.1-rc4, the patch series is
based on kvm-arm/next as it has few conflicts with the SVE KVM series.

Cheers,

Julien Grall (3):
  arm64/fpsimd: Remove the prototype for sve_flush_cpu_state()
  arch/arm64: fpsimd: Introduce fpsimd_save_and_flush_cpu_state() and
    use it
  arm64/fpsimd: Don't disable softirq when touching FPSIMD/SVE state

 arch/arm64/include/asm/fpsimd.h |   6 +-
 arch/arm64/include/asm/simd.h   |   4 +-
 arch/arm64/kernel/fpsimd.c      | 148 +++++++++++++++++++++++++++++-----------
 arch/arm64/kvm/fpsimd.c         |   3 +-
 4 files changed, 112 insertions(+), 49 deletions(-)

-- 
2.11.0

