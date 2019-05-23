Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8440C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 18:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89EFF20868
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 18:37:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731669AbfEWSh6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 14:37:58 -0400
Received: from mga07.intel.com ([134.134.136.100]:48859 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731338AbfEWSh4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 14:37:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 May 2019 11:37:56 -0700
X-ExtLoop1: 1
Received: from otc-lr-04.jf.intel.com ([10.54.39.157])
  by fmsmga001.fm.intel.com with ESMTP; 23 May 2019 11:37:56 -0700
From:   kan.liang@linux.intel.com
To:     vincent.weaver@maine.edu
Cc:     ak@linux.intel.com, peterz@infradead.org,
        alexander.shishkin@linux.intel.com, acme@redhat.com,
        jolsa@redhat.com, eranian@google.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 2/2] perf/x86/regs: Check reserved bits
Date:   Thu, 23 May 2019 11:36:56 -0700
Message-Id: <1558636616-4891-2-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1558636616-4891-1-git-send-email-kan.liang@linux.intel.com>
References: <1558636616-4891-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The perf fuzzer triggers a warning which map to:

	if (WARN_ON_ONCE(idx >= ARRAY_SIZE(pt_regs_offset)))
		return 0;

The bits between XMM registers and generic registers are reserved.
But perf_reg_validate() doesn't check these bits.

Add REG_RESERVED for reserved bits.
Check the reserved bits in perf_reg_validate().

Fixes: 878068ea270e ("perf/x86: Support outputting XMM registers")
Reported-by: Vince Weaver <vincent.weaver@maine.edu>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/kernel/perf_regs.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/perf_regs.c b/arch/x86/kernel/perf_regs.c
index 86ffe5a..3f8c1fc 100644
--- a/arch/x86/kernel/perf_regs.c
+++ b/arch/x86/kernel/perf_regs.c
@@ -79,6 +79,9 @@ u64 perf_reg_value(struct pt_regs *regs, int idx)
 	return regs_get_register(regs, pt_regs_offset[idx]);
 }
 
+#define REG_RESERVED	(((1ULL << PERF_REG_X86_XMM0) - 1) & \
+			~((1ULL << PERF_REG_X86_MAX) - 1))
+
 #ifdef CONFIG_X86_32
 #define REG_NOSUPPORT ((1ULL << PERF_REG_X86_R8) | \
 		       (1ULL << PERF_REG_X86_R9) | \
@@ -91,7 +94,7 @@ u64 perf_reg_value(struct pt_regs *regs, int idx)
 
 int perf_reg_validate(u64 mask)
 {
-	if (!mask || (mask & REG_NOSUPPORT))
+	if (!mask || (mask & (REG_NOSUPPORT | REG_RESERVED)))
 		return -EINVAL;
 
 	return 0;
@@ -117,7 +120,7 @@ void perf_get_regs_user(struct perf_regs *regs_user,
 
 int perf_reg_validate(u64 mask)
 {
-	if (!mask || (mask & REG_NOSUPPORT))
+	if (!mask || (mask & (REG_NOSUPPORT | REG_RESERVED)))
 		return -EINVAL;
 
 	return 0;
-- 
2.7.4

