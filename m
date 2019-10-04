Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 116B6C47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 18:17:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDD5221D81
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 18:17:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388713AbfJDSRK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 14:17:10 -0400
Received: from mga07.intel.com ([134.134.136.100]:15508 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730555AbfJDSRD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 14:17:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Oct 2019 11:17:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,257,1566889200"; 
   d="scan'208";a="204394783"
Received: from chang-linux-3.sc.intel.com ([172.25.66.185])
  by orsmga002.jf.intel.com with ESMTP; 04 Oct 2019 11:17:02 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
        luto@kernel.org
Cc:     hpa@zytor.com, dave.hansen@intel.com, tony.luck@intel.com,
        ak@linux.intel.com, ravi.v.shankar@intel.com,
        chang.seok.bae@intel.com
Subject: [PATCH v9 08/17] x86/entry/64: Document GSBASE handling in the paranoid path
Date:   Fri,  4 Oct 2019 11:16:00 -0700
Message-Id: <1570212969-21888-9-git-send-email-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1570212969-21888-1-git-send-email-chang.seok.bae@intel.com>
References: <1570212969-21888-1-git-send-email-chang.seok.bae@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On FSGSBASE systems, the way to handle GS base in the paranoid path is
different from the existing SWAPGS-based entry/exit path handling. Document
the reason and what has to be done for FSGSBASE enabled systems.

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

Changes from v8: none

Changes from v7:
* Massaged doc and changelog by Thomas
* Used 'GS base' consistently, instead of 'GSBASE'
---
 Documentation/x86/entry_64.rst | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/x86/entry_64.rst b/Documentation/x86/entry_64.rst
index a48b3f6..0499a40 100644
--- a/Documentation/x86/entry_64.rst
+++ b/Documentation/x86/entry_64.rst
@@ -108,3 +108,12 @@ We try to only use IST entries and the paranoid entry code for vectors
 that absolutely need the more expensive check for the GS base - and we
 generate all 'normal' entry points with the regular (faster) paranoid=0
 variant.
+
+On FSGSBASE systems, however, user space can set GS without kernel
+interaction. It means the value of GS base itself does not imply anything,
+whether a kernel value or a user space value. So, there is no longer a safe
+way to check whether the exception is entering from user mode or kernel
+mode in the paranoid entry code path. So the GS base value needs to be read
+out, saved and the kernel GS base value written. On exit, the saved GS base
+value needs to be restored unconditionally. The non-paranoid entry/exit
+code still uses SWAPGS unconditionally as the state is known.
-- 
2.7.4

