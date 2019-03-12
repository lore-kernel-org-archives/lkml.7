Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C2BC10F00
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F20932083D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:09:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbfCLRJk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:09:40 -0400
Received: from mga01.intel.com ([192.55.52.88]:58030 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726141AbfCLRJj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:09:39 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Mar 2019 10:09:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,471,1544515200"; 
   d="scan'208";a="141381808"
Received: from agluck-desk.sc.intel.com (HELO agluck-desk) ([10.3.52.160])
  by orsmga002.jf.intel.com with ESMTP; 12 Mar 2019 10:09:38 -0700
Date:   Tue, 12 Mar 2019 10:09:38 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ashok Raj <ashok.raj@intel.com>,
        "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Subject: [PATCH v2] x86, mce: Fix machine_check_poll() tests for which errors
Message-ID: <20190312170938.GA23035@agluck-desk>
References: <20190311185118.32667-1-tony.luck@intel.com>
 <SN6PR12MB26399CBAEFB6C500D456255DF8480@SN6PR12MB2639.namprd12.prod.outlook.com>
 <20190311204217.GA1810@agluck-desk>
 <SN6PR12MB2639C9CC6B5BA0A1F1FE771DF8480@SN6PR12MB2639.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR12MB2639C9CC6B5BA0A1F1FE771DF8480@SN6PR12MB2639.namprd12.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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

V2: Update comment to make it clear that only Intel CPUs with software
error recovery reach the final few tests on whether to log.

 arch/x86/kernel/cpu/mce/core.c | 44 ++++++++++++++++++++++++++++------
 1 file changed, 37 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 6ce290c506d9..663e8b82eacc 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -712,19 +712,49 @@ bool machine_check_poll(enum mcp_flags flags, mce_banks_t *b)
 
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
+		 * Newer Intel systems that support software error
+		 * recovery need to make additional checks. Other
+		 * CPUs should skip over uncorrected errors, but log
+		 * everything else.
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

