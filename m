Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BDB7C4CEC8
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 20:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1BB9208C2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 20:07:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbfILUHy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 16:07:54 -0400
Received: from mga01.intel.com ([192.55.52.88]:35544 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726008AbfILUHx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 16:07:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Sep 2019 13:07:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,489,1559545200"; 
   d="scan'208";a="336688201"
Received: from chang-linux-3.sc.intel.com ([172.25.66.185])
  by orsmga004.jf.intel.com with ESMTP; 12 Sep 2019 13:07:51 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     ravi.v.shankar@intel.com, chang.seok.bae@intel.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v8 01/17] x86/ptrace: Prevent ptrace from clearing the FS/GS selector
Date:   Thu, 12 Sep 2019 13:06:42 -0700
Message-Id: <1568318818-4091-2-git-send-email-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1568318818-4091-1-git-send-email-chang.seok.bae@intel.com>
References: <1568318818-4091-1-git-send-email-chang.seok.bae@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a ptracer writes a ptracee's FS/GS base with a different value, the
selector is also cleared. This behavior is not correct as the selector
should be preserved.

Update only the base value and leave the selector intact. To simplify the
code further remove the conditional checking for the same value as this
code is not performance-critical.

The only recognizable downside of this change is when the selector is
already nonzero on write. The base will be reloaded according to the
selector. But the case is highly unexpected in real usages.

Suggested-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
---

Changes from v7:
* Fixed to call correct helper functions
* Massaged changelog by Thomas
* Used '[FS|GS] base' consistently, instead of '[FS|GS]BASE'
---
 arch/x86/kernel/ptrace.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
index 3c5bbe8..df222e2 100644
--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -370,22 +370,12 @@ static int putreg(struct task_struct *child,
 	case offsetof(struct user_regs_struct,fs_base):
 		if (value >= TASK_SIZE_MAX)
 			return -EIO;
-		/*
-		 * When changing the FS base, use do_arch_prctl_64()
-		 * to set the index to zero and to set the base
-		 * as requested.
-		 */
-		if (child->thread.fsbase != value)
-			return do_arch_prctl_64(child, ARCH_SET_FS, value);
+		x86_fsbase_write_task(child, value);
 		return 0;
 	case offsetof(struct user_regs_struct,gs_base):
-		/*
-		 * Exactly the same here as the %fs handling above.
-		 */
 		if (value >= TASK_SIZE_MAX)
 			return -EIO;
-		if (child->thread.gsbase != value)
-			return do_arch_prctl_64(child, ARCH_SET_GS, value);
+		x86_gsbase_write_task(child, value);
 		return 0;
 #endif
 	}
-- 
2.7.4

