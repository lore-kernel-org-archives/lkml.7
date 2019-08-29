Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90544C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 06:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 639502073F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 06:40:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbfH2GkH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 02:40:07 -0400
Received: from foss.arm.com ([217.140.110.172]:39576 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbfH2GkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 02:40:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7836C28;
        Wed, 28 Aug 2019 23:40:06 -0700 (PDT)
Received: from entos-d05.shanghai.arm.com (entos-d05.shanghai.arm.com [10.169.40.35])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2C1E93F246;
        Wed, 28 Aug 2019 23:42:25 -0700 (PDT)
From:   Jianyong Wu <jianyong.wu@arm.com>
To:     netdev@vger.kernel.org, pbonzini@redhat.com,
        sean.j.christopherson@intel.com, maz@kernel.org,
        richardcochran@gmail.com, Mark.Rutland@arm.com,
        Will.Deacon@arm.com, suzuki.poulose@arm.com
Cc:     linux-kernel@vger.kernel.org, Steve.Capper@arm.com,
        Kaly.Xin@arm.com, justin.he@arm.com, jianyong.wu@arm.com
Subject: [RFC PATCH 0/3] arm64: enable virtual kvm ptp for arm64
Date:   Thu, 29 Aug 2019 02:39:49 -0400
Message-Id: <20190829063952.18470-1-jianyong.wu@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kvm ptp targets to provide high precision time sync between guest
and host in virtualization environment. This patch enable kvm ptp
for arm64.

This patch set base on [1][2][3]

[1]https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/
commit/?h=kvm/hvc&id=125ea89e4a21e2fc5235410f966a996a1a7148bf
[2]https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/
commit/?h=kvm/hvc&id=464f5a1741e5959c3e4d2be1966ae0093b4dce06
[3]https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/
commit/?h=kvm/hvc&id=6597490e005d0eeca8ed8c1c1d7b4318ee014681

Jianyong Wu (3):
  Export psci_ops.conduit symbol as modules will use it.
  reorganize ptp_kvm modules to make it arch-independent.
  Enable ptp_kvm for arm64

 arch/arm64/include/asm/arch_timer.h  |  3 +
 arch/arm64/kvm/arch_ptp_kvm.c        | 76 +++++++++++++++++++++++
 arch/x86/kvm/arch_ptp_kvm.c          | 92 ++++++++++++++++++++++++++++
 drivers/clocksource/arm_arch_timer.c |  6 +-
 drivers/firmware/psci/psci.c         |  6 ++
 drivers/ptp/Kconfig                  |  2 +-
 drivers/ptp/Makefile                 |  1 +
 drivers/ptp/{ptp_kvm.c => kvm_ptp.c} | 77 ++++++-----------------
 include/asm-generic/ptp_kvm.h        | 12 ++++
 include/linux/arm-smccc.h            | 16 ++++-
 include/linux/psci.h                 |  1 +
 virt/kvm/arm/psci.c                  | 17 +++++
 12 files changed, 246 insertions(+), 63 deletions(-)
 create mode 100644 arch/arm64/kvm/arch_ptp_kvm.c
 create mode 100644 arch/x86/kvm/arch_ptp_kvm.c
 rename drivers/ptp/{ptp_kvm.c => kvm_ptp.c} (63%)
 create mode 100644 include/asm-generic/ptp_kvm.h

-- 
2.17.1

