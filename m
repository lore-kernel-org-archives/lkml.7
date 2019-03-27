Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1346C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D86D2070B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553710745;
	bh=acFINRyM2LlSgsBrefbKF/BvQ25H1G+r928NVg8F7tc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HJG85XhWeErU0KTmKMUM4eQ2zOeDymeyADL8L4svSL/EdjKr0G9raUwyNumdmyS0I
	 Bd6ff2Uj9OJAXjITCx2tlbmKsAOXoFqMExsH1tebMgP2coCT68EpKcJ2DU5Z5eWhEO
	 YVLtQtS6DNTcWOTaznhhUj8WlD0eGQfGSzGSJck8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390655AbfC0STE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:19:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:36244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389555AbfC0STC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:19:02 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9385920643;
        Wed, 27 Mar 2019 18:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710741;
        bh=acFINRyM2LlSgsBrefbKF/BvQ25H1G+r928NVg8F7tc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oCf2tzkrycMx9SvGpnnghdw2r8PFqn/52U0b57HlrHDSgZthLTZPb7MA11RgSHPex
         951smGJPqTO6apwxBh9ttRZsldddt7yNnnl7/pdc84k68p+MSNy+JfS25Uj84XRXp+
         kqEKO+d/M6c+dgZfJaZMwdJZan4kPVsRZHH90Lyg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>,
        "David E. Box" <david.e.box@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 083/123] platform/x86: intel_pmc_core: Fix PCH IP sts reading
Date:   Wed, 27 Mar 2019 14:15:47 -0400
Message-Id: <20190327181628.15899-83-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327181628.15899-1-sashal@kernel.org>
References: <20190327181628.15899-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>

[ Upstream commit 0e68eeea9894feeba2edf7ec63e4551b87f39621 ]

A previous commit "platform/x86: intel_pmc_core: Make the driver PCH
family agnostic <c977b98bbef5898ed3d30b08ea67622e9e82082a>" provided
better abstraction to this driver but has some fundamental issues.

e.g. the following condition

for (index = 0; index < pmcdev->map->ppfear_buckets &&
	index < PPFEAR_MAX_NUM_ENTRIES; index++, iter++)

is wrong because for CNL, PPFEAR_MAX_NUM_ENTRIES is hardcoded as 5 which
is _wrong_ and even though ppfear_buckets is 8, the loop fails to read
all eight registers needed for CNL PCH i.e. PPFEAR0 and PPFEAR1. This
patch refactors the pfear show logic to correctly read PCH IP power
gating status for Cannonlake and beyond.

Cc: "David E. Box" <david.e.box@intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Fixes: c977b98bbef5 ("platform/x86: intel_pmc_core: Make the driver PCH family agnostic")
Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/intel_pmc_core.c | 3 ++-
 drivers/platform/x86/intel_pmc_core.h | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
index 17e08b42b0a9..aaeb0242a99d 100644
--- a/drivers/platform/x86/intel_pmc_core.c
+++ b/drivers/platform/x86/intel_pmc_core.c
@@ -222,7 +222,8 @@ static int pmc_core_ppfear_sts_show(struct seq_file *s, void *unused)
 	     index < PPFEAR_MAX_NUM_ENTRIES; index++, iter++)
 		pf_regs[index] = pmc_core_reg_read_byte(pmcdev, iter);
 
-	for (index = 0; map[index].name; index++)
+	for (index = 0; map[index].name &&
+	     index < pmcdev->map->ppfear_buckets * 8; index++)
 		pmc_core_display_map(s, index, pf_regs[index / 8], map);
 
 	return 0;
diff --git a/drivers/platform/x86/intel_pmc_core.h b/drivers/platform/x86/intel_pmc_core.h
index 3d225a9cc09f..1f13426eb61a 100644
--- a/drivers/platform/x86/intel_pmc_core.h
+++ b/drivers/platform/x86/intel_pmc_core.h
@@ -38,7 +38,7 @@
 #define SPT_PMC_SLP_S0_RES_COUNTER_STEP		0x64
 #define PMC_BASE_ADDR_MASK			~(SPT_PMC_MMIO_REG_LEN - 1)
 #define MTPMC_MASK				0xffff0000
-#define PPFEAR_MAX_NUM_ENTRIES			5
+#define PPFEAR_MAX_NUM_ENTRIES			12
 #define SPT_PPFEAR_NUM_ENTRIES			5
 #define SPT_PMC_READ_DISABLE_BIT		0x16
 #define SPT_PMC_MSG_FULL_STS_BIT		0x18
-- 
2.19.1

