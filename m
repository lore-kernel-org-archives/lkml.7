Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C5DC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 23:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D12B72196E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 23:51:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbfKLXvi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 18:51:38 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:57348 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727004AbfKLXug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 18:50:36 -0500
Received: from [167.98.27.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1iUfve-0008IF-0B; Tue, 12 Nov 2019 23:50:34 +0000
Received: from ben by deadeye with local (Exim 4.93-RC1)
        (envelope-from <ben@decadent.org.uk>)
        id 1iUfvc-00057I-Nz; Tue, 12 Nov 2019 23:50:32 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Josh Poimboeuf" <jpoimboe@redhat.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Tyler Hicks" <tyhicks@canonical.com>,
        "Borislav Petkov" <bp@suse.de>
Date:   Tue, 12 Nov 2019 23:48:09 +0000
Message-ID: <lsq.1573602477.999910664@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 12/25] x86/speculation/taa: Fix printing of
 TAA_MSG_SMT on  IBRS_ALL CPUs
In-Reply-To: <lsq.1573602477.548403712@decadent.org.uk>
X-SA-Exim-Connect-IP: 167.98.27.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.77-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Josh Poimboeuf <jpoimboe@redhat.com>

commit 012206a822a8b6ac09125bfaa210a95b9eb8f1c1 upstream.

For new IBRS_ALL CPUs, the Enhanced IBRS check at the beginning of
cpu_bugs_smt_update() causes the function to return early, unintentionally
skipping the MDS and TAA logic.

This is not a problem for MDS, because there appears to be no overlap
between IBRS_ALL and MDS-affected CPUs.  So the MDS mitigation would be
disabled and nothing would need to be done in this function anyway.

But for TAA, the TAA_MSG_SMT string will never get printed on Cascade
Lake and newer.

The check is superfluous anyway: when 'spectre_v2_enabled' is
SPECTRE_V2_IBRS_ENHANCED, 'spectre_v2_user' is always
SPECTRE_V2_USER_NONE, and so the 'spectre_v2_user' switch statement
handles it appropriately by doing nothing.  So just remove the check.

Fixes: 1b42f017415b ("x86/speculation/taa: Add mitigation for TSX Async Abort")
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Tyler Hicks <tyhicks@canonical.com>
Reviewed-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/kernel/cpu/bugs.c | 4 ----
 1 file changed, 4 deletions(-)

--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -919,10 +919,6 @@ static void update_mds_branch_idle(void)
 
 void arch_smt_update(void)
 {
-	/* Enhanced IBRS implies STIBP. No update required. */
-	if (spectre_v2_enabled == SPECTRE_V2_IBRS_ENHANCED)
-		return;
-
 	mutex_lock(&spec_ctrl_mutex);
 
 	switch (spectre_v2_user) {

