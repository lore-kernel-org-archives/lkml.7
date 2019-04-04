Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C477EC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CCB3205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554370622;
	bh=26CJLkFUWaQHEhOCX4hhbPn19xu/Hjo/OikKmOyssm4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2kxxFK4EgvM5FrgVsUDYVBLmmO1YOtI3T2dYwTdepx37QK+A1ucCuucVFx0dXlNMJ
	 WuWwc3ohtG23EkhHQipIQpnrge+tBCx/JJFQcm0luMv7pia2ou2hZkBrnLWDG595ap
	 nRdcuqA18qQVFoC0PFM30kNMLZH+kk7V/3hiiZ98=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732409AbfDDJhB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:37:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:43296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732109AbfDDJFR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:05:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DB69214AF;
        Thu,  4 Apr 2019 09:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368717;
        bh=26CJLkFUWaQHEhOCX4hhbPn19xu/Hjo/OikKmOyssm4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AXKMH2SKhuy1TUmIWKYiMNA6raI03fsfohty8S2XwQn01JJmyzA0B8qfrpMhJZ6nK
         SLu3Y1bkRTZffEfnQkYt8BZWwNmUNeoC0AFMHTIf0gX2hbgnZoxwvzB0Xt9b3H1oQ6
         /jh5l0QPjS3TPPInNCcu+WnlOeKZ4C3r+aBjlHNw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "David E. Box" <david.e.box@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 127/187] platform/x86: intel_pmc_core: Fix PCH IP sts reading
Date:   Thu,  4 Apr 2019 10:47:44 +0200
Message-Id: <20190404084609.204267332@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084603.119654039@linuxfoundation.org>
References: <20190404084603.119654039@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 2d272a3e0176..e0dcdb3cc070 100644
--- a/drivers/platform/x86/intel_pmc_core.c
+++ b/drivers/platform/x86/intel_pmc_core.c
@@ -333,7 +333,8 @@ static int pmc_core_ppfear_sts_show(struct seq_file *s, void *unused)
 	     index < PPFEAR_MAX_NUM_ENTRIES; index++, iter++)
 		pf_regs[index] = pmc_core_reg_read_byte(pmcdev, iter);
 
-	for (index = 0; map[index].name; index++)
+	for (index = 0; map[index].name &&
+	     index < pmcdev->map->ppfear_buckets * 8; index++)
 		pmc_core_display_map(s, index, pf_regs[index / 8], map);
 
 	return 0;
diff --git a/drivers/platform/x86/intel_pmc_core.h b/drivers/platform/x86/intel_pmc_core.h
index 93a7e99e1f8b..3f9711b03cb4 100644
--- a/drivers/platform/x86/intel_pmc_core.h
+++ b/drivers/platform/x86/intel_pmc_core.h
@@ -39,7 +39,7 @@
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



