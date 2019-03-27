Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B919CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 09:58:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AA842070B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 09:58:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732972AbfC0J6l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 05:58:41 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38083 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731668AbfC0J6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 05:58:40 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2R9wIJi2804316
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 27 Mar 2019 02:58:18 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2R9wHCY2804313;
        Wed, 27 Mar 2019 02:58:17 -0700
Date:   Wed, 27 Mar 2019 02:58:17 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Tony Luck <tipbot@zytor.com>
Message-ID: <tip-f19501aa07f18268ab14f458b51c1c6b7f72a134@git.kernel.org>
Cc:     ashok.raj@intel.com, tony.luck@intel.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        Yazen.Ghannam@amd.com, mingo@kernel.org, hpa@zytor.com,
        x86@kernel.org, bp@suse.de, linux-edac@vger.kernel.org
Reply-To: tglx@linutronix.de, mingo@redhat.com, Yazen.Ghannam@amd.com,
          linux-edac@vger.kernel.org, mingo@kernel.org,
          ashok.raj@intel.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
          tony.luck@intel.com, bp@suse.de, x86@kernel.org
In-Reply-To: <20190312170938.GA23035@agluck-desk>
References: <20190312170938.GA23035@agluck-desk>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:ras/core] x86/mce: Fix machine_check_poll() tests for error
 types
Git-Commit-ID: f19501aa07f18268ab14f458b51c1c6b7f72a134
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  f19501aa07f18268ab14f458b51c1c6b7f72a134
Gitweb:     https://git.kernel.org/tip/f19501aa07f18268ab14f458b51c1c6b7f72a134
Author:     Tony Luck <tony.luck@intel.com>
AuthorDate: Tue, 12 Mar 2019 10:09:38 -0700
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Wed, 27 Mar 2019 10:53:49 +0100

x86/mce: Fix machine_check_poll() tests for error types

There has been a lurking "TBD" in the machine check poll routine ever
since it was first split out from the machine check handler. The
potential issue is that the poll routine may have just begun a read from
the STATUS register in a machine check bank when the hardware logs an
error in that bank and signals a machine check.

That race used to be pretty small back when machine checks were
broadcast, but the addition of local machine check means that the poll
code could continue running and clear the error from the bank before the
local machine check handler on another CPU gets around to reading it.

Fix the code to be sure to only process errors that need to be processed
in the poll code, leaving other logged errors alone for the machine
check handler to find and process.

 [ bp: Massage a bit and flip the "== 0" check to the usual !(..) test. ]

Fixes: b79109c3bbcf ("x86, mce: separate correct machine check poller and fatal exception handler")
Fixes: ed7290d0ee8f ("x86, mce: implement new status bits")
Reported-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: linux-edac <linux-edac@vger.kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Cc: Yazen Ghannam <Yazen.Ghannam@amd.com>
Link: https://lkml.kernel.org/r/20190312170938.GA23035@agluck-desk
---
 arch/x86/kernel/cpu/mce/core.c | 44 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 37 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index b7fb541a4873..e558ca77cfe8 100644
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
+		if ((flags & MCP_UC) || !(m.status & MCI_STATUS_UC))
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
