Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BABA2C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 10:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E77C20811
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 10:14:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbfC1KOF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 06:14:05 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41798 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725779AbfC1KOE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 06:14:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B7B9915AB;
        Thu, 28 Mar 2019 03:14:03 -0700 (PDT)
Received: from queper01-lin.local (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 34B3B3F59C;
        Thu, 28 Mar 2019 03:14:01 -0700 (PDT)
From:   Quentin Perret <quentin.perret@arm.com>
To:     edubezval@gmail.com, rui.zhang@intel.com, javi.merino@kernel.org,
        viresh.kumar@linaro.org, amit.kachhap@gmail.com, rjw@rjwysocki.net,
        will.deacon@arm.com, catalin.marinas@arm.com
Cc:     daniel.lezcano@linaro.org, dietmar.eggemann@arm.com,
        ionela.voinescu@arm.com, quentin.perret@arm.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/3] arm64: defconfig: Enable CONFIG_ENERGY_MODEL
Date:   Thu, 28 Mar 2019 10:13:50 +0000
Message-Id: <20190328101352.25657-2-quentin.perret@arm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190328101352.25657-1-quentin.perret@arm.com>
References: <20190328101352.25657-1-quentin.perret@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The recently introduced Energy Model (EM) framework manages power cost
tables for the CPUs of the system. Its only user right now is the
scheduler, in the context of Energy Aware Scheduling (EAS).

However, the EM framework also offers a generic infrastructure that
could replace subsystem-specific implementations of the same concepts,
as this is the case in the thermal framework.

So, in order to prepare the migration of the thermal subsystem to use
the EM framework, enable it in the default arm64 defconfig, which is the
most commonly used architecture for IPA. This will also compile-in all
of the EAS code, although it won't be enabled by default -- EAS requires
to use the 'schedutil' CPUFreq governor while arm64 defaults to
'performance'.

Signed-off-by: Quentin Perret <quentin.perret@arm.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 2d9c39033c1a..3c09bdaaefd3 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -97,6 +97,7 @@ CONFIG_XEN=y
 CONFIG_COMPAT=y
 CONFIG_HIBERNATION=y
 CONFIG_WQ_POWER_EFFICIENT_DEFAULT=y
+CONFIG_ENERGY_MODEL=n
 CONFIG_ARM_CPUIDLE=y
 CONFIG_CPU_FREQ=y
 CONFIG_CPU_FREQ_STAT=y
-- 
2.21.0

