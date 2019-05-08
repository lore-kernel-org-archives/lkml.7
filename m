Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA20AC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 17:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97DEF216F4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 17:03:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729116AbfEHRDe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 13:03:34 -0400
Received: from mga03.intel.com ([134.134.136.65]:5322 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728983AbfEHRDF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 13:03:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 May 2019 10:03:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,446,1549958400"; 
   d="scan'208";a="169697589"
Received: from chang-linux-3.sc.intel.com ([172.25.66.171])
  by fmsmga002.fm.intel.com with ESMTP; 08 May 2019 10:03:04 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>
Cc:     Ravi Shankar <ravi.v.shankar@intel.com>,
        "Chang S . Bae" <chang.seok.bae@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v7 13/18] x86/fsgsbase/64: Document GSBASE handling in the paranoid path
Date:   Wed,  8 May 2019 03:02:28 -0700
Message-Id: <1557309753-24073-14-git-send-email-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1557309753-24073-1-git-send-email-chang.seok.bae@intel.com>
References: <1557309753-24073-1-git-send-email-chang.seok.bae@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On a FSGSBASE system, the way to handle GSBASE in the paranoid path
will be different from the existing SWAPGS-based. Document the reason
and what is done by the (new) GSBASE handling. In non-paranoid path,
it will keep working exactly like it does today.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Andi Kleen <ak@linux.intel.com>
---
 Documentation/x86/entry_64.txt | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/x86/entry_64.txt b/Documentation/x86/entry_64.txt
index c1df8eb..2878c56 100644
--- a/Documentation/x86/entry_64.txt
+++ b/Documentation/x86/entry_64.txt
@@ -102,3 +102,20 @@ We try to only use IST entries and the paranoid entry code for vectors
 that absolutely need the more expensive check for the GS base - and we
 generate all 'normal' entry points with the regular (faster) paranoid=0
 variant.
+
+On a FSGSBASE system, however, user space can set GS without kernel
+interaction. It means the value of GS base itself does not imply
+anything, whether a kernel value or a user space value. So, there is
+no longer safe way to check if entering from user mode to kernel mode.
+Instead, this way handles GS base properly with FSGSBASE:
+
+On entry:
+	rdgsbase %rbx
+	GET_PERCPU_BASE %rax   /* see the details in calling.h */
+	wrgsbase %rax
+
+On exit:
+	wrgsbase %rbx
+
+Obviously, for the non-paranoid path, it all keeps working exactly
+likt it does without FSGSBASE.
\ No newline at end of file
-- 
2.7.4

