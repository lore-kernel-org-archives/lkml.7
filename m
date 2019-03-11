Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DAA5C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FF8E20643
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:51:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728159AbfCKSvT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 14:51:19 -0400
Received: from mga01.intel.com ([192.55.52.88]:21034 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726942AbfCKSvS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 14:51:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Mar 2019 11:51:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,468,1544515200"; 
   d="scan'208";a="326310855"
Received: from agluck-desk.sc.intel.com ([10.3.52.160])
  by fmsmga006.fm.intel.com with ESMTP; 11 Mar 2019 11:51:18 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tony Luck <tony.luck@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Ashok Raj <ashok.raj@intel.com>
Subject: [PATCH] x86, mce: Fix machine_check_poll() tests for which errors to log
Date:   Mon, 11 Mar 2019 11:51:18 -0700
Message-Id: <20190311185118.32667-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There has been a lurking "TBD" in the machine check poll routine ever
since it was first split out from the machine check handler. The potential
issue is that the poll routine may have just begun a read from the STATUS
register in a machine check bank when the hardware logs an error in that
bank and signals a machine check. That race used to be pretty small back
when machine checks were broadcast, but the addition of local machine check
means that the poll code could continue running and clear the error from the
bank before the local machine check handler on another CPU gets around to
reading it.

Fix the code to be sure to only process errors that need to be processed
in the poll code, leaving other logged errors alone for the machine check
handler to find and process.

Fixes: b79109c3bbcf ("x86, mce: separate correct machine check poller and fatal exception handler")
Fixes: ed7290d0ee8f ("x86, mce: implement new status bits")
Reported-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/mce/core.c | 42 ++++++++++++++++++++++++++++------
 1 file changed, 35 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 6ce290c506d9..806551b381ae 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -712,19 +712,47 @@ bool machine_check_poll(enum mcp_flags flags, mce_banks_t *b)
 
 		barrier();
 		m.status = mce_rdmsrl(msr_ops.status(i));
+
+		/* If this entry is not valid, ignore it */
 		if (!(m.status & MCI_STATUS_VAL))
 			continue;
 
 		/*
-		 * Uncorrected or signalled events are handled by the exception
-		 * handler when it is enabled, so don't process those here.
-		 *
-		 * TBD do the same check for MCI_STATUS_EN here?
+		 * If we are logging everything (at CPU online) or this
+		 * is a corrected error, then we must log it.
 		 */
-		if (!(flags & MCP_UC) &&
-		    (m.status & (mca_cfg.ser ? MCI_STATUS_S : MCI_STATUS_UC)))
-			continue;
+		if ((flags & MCP_UC) || (m.status & MCI_STATUS_UC) == 0)
+			goto log_it;
+
+		/*
+		 * Older systems that do not support software error recovery
+		 * should skip over uncorrected errors, but log everything else
+		 */
+		if (!mca_cfg.ser) {
+			if (m.status & MCI_STATUS_UC)
+				continue;
+			goto log_it;
+		}
+
+		/* Log "not enabled" (speculative) errors */
+		if (!(m.status & MCI_STATUS_EN))
+			goto log_it;
+
+		/*
+		 * Log UCNA (SDM: 15.6.3 "UCR Error Classification")
+		 * UC == 1 && PCC == 0 && S == 0
+		 */
+		if (!(m.status & MCI_STATUS_PCC) && !(m.status & MCI_STATUS_S))
+			goto log_it;
+
+		/*
+		 * Skip anything else. Presumption is that our read of this
+		 * bank is racing with a machine check. Leave the log alone
+		 * for do_machine_check() to deal with it.
+		 */
+		continue;
 
+log_it:
 		error_seen = true;
 
 		mce_read_aux(&m, i);
-- 
2.19.1

