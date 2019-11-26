Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6390DC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 19:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23F232075C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 19:59:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbfKZT7N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 14:59:13 -0500
Received: from mga06.intel.com ([134.134.136.31]:54602 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725970AbfKZT7M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 14:59:12 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Nov 2019 11:59:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,246,1571727600"; 
   d="scan'208";a="220735245"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.41])
  by orsmga002.jf.intel.com with ESMTP; 26 Nov 2019 11:59:12 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] x86/boot/realmode: Fix a comment's incorrect file reference
Date:   Tue, 26 Nov 2019 11:59:11 -0800
Message-Id: <20191126195911.3429-1-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the comment for 'struct real_mode_header' to reference the correct
assembly file, realmode/rm/header.S.  The comment has always incorrectly
referenced realmode.S, which doesn't exist, as defining the associated
asm blob.

Specify the file's path relative to arch/x86 to avoid confusion with
boot/header.S.  Update the comment for 'struct trampoline_header' to
also include the relative path to keep things consistent, and tweak the
dual 64/32 reference so that it doesn't appear to be an extension of the
relative path, i.e. avoid "realmode/rm/trampoline_32/64.S".

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---

The other obvious fix would be to simply delete the comment, but I found
the comment to be quite helpful even though it referenced the incorrect
file.  Without the comment, it's not immediately obvious that the struct
is representative of an asm blob.

 arch/x86/include/asm/realmode.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/realmode.h b/arch/x86/include/asm/realmode.h
index 09ecc32f6524..b35030eeec36 100644
--- a/arch/x86/include/asm/realmode.h
+++ b/arch/x86/include/asm/realmode.h
@@ -14,7 +14,7 @@
 #include <linux/types.h>
 #include <asm/io.h>
 
-/* This must match data at realmode.S */
+/* This must match data at realmode/rm/header.S */
 struct real_mode_header {
 	u32	text_start;
 	u32	ro_end;
@@ -36,7 +36,7 @@ struct real_mode_header {
 #endif
 };
 
-/* This must match data at trampoline_32/64.S */
+/* This must match data at realmode/rm/trampoline_{32,64}.S */
 struct trampoline_header {
 #ifdef CONFIG_X86_32
 	u32 start;
-- 
2.24.0

