Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 387F9C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 15:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FBC825D36
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 15:57:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbfE3P5x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 11:57:53 -0400
Received: from foss.arm.com ([217.140.101.70]:39026 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725961AbfE3P5w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 11:57:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3B1E0341;
        Thu, 30 May 2019 08:57:52 -0700 (PDT)
Received: from eglon.cambridge.arm.com (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 909743F59C;
        Thu, 30 May 2019 08:57:50 -0700 (PDT)
From:   James Morse <james.morse@arm.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Avin <hpa@zytor.com>,
        James Morse <james.morse@arm.com>
Subject: [PATCH] x86/resctrl: Don't stop walking closids when a locksetup group is found
Date:   Thu, 30 May 2019 16:57:42 +0100
Message-Id: <20190530155742.84547-1-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a new control group is created __init_one_rdt_domain() walks all
the other closids to calculate the sets of used and unused bits.

If it discovers a pseudo_locksetup group, it breaks out of the loop.
This means any later closid doesn't get its used bits added to used_b.
These bits will then get set in unused_b, and added to the new
control group's configuration, even if they were marked as exclusive
for a later closid.

When encountering a pseudo_locksetup group, we should continue. This
is because "a resource group enters 'pseudo-locked' mode after the
schemata is written while the resource group is in 'pseudo-locksetup'
mode." When we find a pseudo_locksetup group, its configuration is
expected to be overwritten, we can skip it.

Fixes: dfe9674b04ff6 ("x86/intel_rdt: Enable entering of pseudo-locksetup mode")
Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 333c177a2471..049ccb709957 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2541,8 +2541,15 @@ static int __init_one_rdt_domain(struct rdt_domain *d, struct rdt_resource *r,
 	for (i = 0; i < closids_supported(); i++, ctrl++) {
 		if (closid_allocated(i) && i != closid) {
 			mode = rdtgroup_mode_by_closid(i);
-			if (mode == RDT_MODE_PSEUDO_LOCKSETUP)
-				break;
+			if (mode == RDT_MODE_PSEUDO_LOCKSETUP) {
+				/*
+				 * ctrl values for locksetup aren't relevant
+				 * until the schemata is written, and the mode
+				 * becomes RDT_MODE_PSEUDO_LOCKED.
+				 */
+				continue;
+			}
+
 			/*
 			 * If CDP is active include peer domain's
 			 * usage to ensure there is no overlap
-- 
2.20.1

