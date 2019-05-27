Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 334FCC07542
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 19:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19B74208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 19:09:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbfE0TJB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 15:09:01 -0400
Received: from mga14.intel.com ([192.55.52.115]:48012 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726758AbfE0TJA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 15:09:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 May 2019 12:08:59 -0700
X-ExtLoop1: 1
Received: from otc-lr-04.jf.intel.com ([10.54.39.157])
  by FMSMGA003.fm.intel.com with ESMTP; 27 May 2019 12:08:59 -0700
From:   kan.liang@linux.intel.com
To:     mingo@kernel.org, acme@redhat.com, peterz@infradead.org,
        vincent.weaver@maine.edu, linux-kernel@vger.kernel.org
Cc:     alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        jolsa@redhat.com, eranian@google.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 2/3] perf/x86/regs: Check reserved bits
Date:   Mon, 27 May 2019 12:07:56 -0700
Message-Id: <1558984077-7773-2-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1558984077-7773-1-git-send-email-kan.liang@linux.intel.com>
References: <1558984077-7773-1-git-send-email-kan.liang@linux.intel.com>
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

Add PERF_REG_X86_RESERVED for reserved bits on X86.
Check the reserved bits in perf_reg_validate().

Fixes: 878068ea270e ("perf/x86: Support outputting XMM registers")
Reported-by: Vince Weaver <vincent.weaver@maine.edu>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

Changes since V1:
- Rename REG_RESERVED to PERF_REG_X86_RESERVED

 arch/x86/kernel/perf_regs.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/perf_regs.c b/arch/x86/kernel/perf_regs.c
index 07c30ee..bb7e113 100644
--- a/arch/x86/kernel/perf_regs.c
+++ b/arch/x86/kernel/perf_regs.c
@@ -74,6 +74,9 @@ u64 perf_reg_value(struct pt_regs *regs, int idx)
 	return regs_get_register(regs, pt_regs_offset[idx]);
 }
 
+#define PERF_REG_X86_RESERVED	(((1ULL << PERF_REG_X86_XMM0) - 1) & \
+				 ~((1ULL << PERF_REG_X86_MAX) - 1))
+
 #ifdef CONFIG_X86_32
 #define REG_NOSUPPORT ((1ULL << PERF_REG_X86_R8) | \
 		       (1ULL << PERF_REG_X86_R9) | \
@@ -86,7 +89,7 @@ u64 perf_reg_value(struct pt_regs *regs, int idx)
 
 int perf_reg_validate(u64 mask)
 {
-	if (!mask || (mask & REG_NOSUPPORT))
+	if (!mask || (mask & (REG_NOSUPPORT | PERF_REG_X86_RESERVED)))
 		return -EINVAL;
 
 	return 0;
@@ -112,7 +115,7 @@ void perf_get_regs_user(struct perf_regs *regs_user,
 
 int perf_reg_validate(u64 mask)
 {
-	if (!mask || (mask & REG_NOSUPPORT))
+	if (!mask || (mask & (REG_NOSUPPORT | PERF_REG_X86_RESERVED)))
 		return -EINVAL;
 
 	return 0;
-- 
2.7.4

