Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E15F5C7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 18:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B3E9217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 18:29:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390986AbfGRS3W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 14:29:22 -0400
Received: from mga09.intel.com ([134.134.136.24]:20283 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390881AbfGRS3V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 14:29:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jul 2019 11:29:21 -0700
X-IronPort-AV: E=Sophos;i="5.64,279,1559545200"; 
   d="scan'208";a="319724923"
Received: from agluck-desk2.sc.intel.com ([10.3.52.68])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jul 2019 11:29:21 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tony Luck <tony.luck@intel.com>,
        Yongkai Wu <yongkaiwu@tencent.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86/mce: Don't check for "OVER" bit on action optional machine checks
Date:   Thu, 18 Jul 2019 11:29:20 -0700
Message-Id: <20190718182920.32621-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We currently do not process  SRAO (Software Recoverable Action Optional)
machine checks if they are logged with the overflow bit set to 1 in the
machine check bank status register. This is overly conservative.

There are two cases where we could end up with an SRAO+OVER log based
on the SDM volume 3 overwrite rules in "Table 15-8. Overwrite Rules for
UC, CE, and UCR Errors"

1) First a corrected error is logged, then the SRAO error overwrites.
   The second error overwrites the first because uncorrected errors
   have a higher severity than corrected errors.
2) The SRAO error was logged first, followed by a correcetd error.
   In this case the first error is retained in the bank.

So in either case the machine check bank will contain the address
of the SRAO error. So we can process that even if the overflow bit
was set.

Reported-by: Yongkai Wu <yongkaiwu@tencent.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/mce/severity.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
index 210f1f5db5f7..87bcdc6dc2f0 100644
--- a/arch/x86/kernel/cpu/mce/severity.c
+++ b/arch/x86/kernel/cpu/mce/severity.c
@@ -107,11 +107,11 @@ static struct severity {
 	 */
 	MCESEV(
 		AO, "Action optional: memory scrubbing error",
-		SER, MASK(MCI_STATUS_OVER|MCI_UC_AR|MCACOD_SCRUBMSK, MCI_STATUS_UC|MCACOD_SCRUB)
+		SER, MASK(MCI_UC_AR|MCACOD_SCRUBMSK, MCI_STATUS_UC|MCACOD_SCRUB)
 		),
 	MCESEV(
 		AO, "Action optional: last level cache writeback error",
-		SER, MASK(MCI_STATUS_OVER|MCI_UC_AR|MCACOD, MCI_STATUS_UC|MCACOD_L3WB)
+		SER, MASK(MCI_UC_AR|MCACOD, MCI_STATUS_UC|MCACOD_L3WB)
 		),
 
 	/* ignore OVER for UCNA */
-- 
2.20.1

