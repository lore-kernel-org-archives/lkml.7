Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99594C3A589
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 02:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78BD0206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 02:33:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbfHPCdE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 22:33:04 -0400
Received: from mga09.intel.com ([134.134.136.24]:24671 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726245AbfHPCdC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 22:33:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Aug 2019 19:33:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,391,1559545200"; 
   d="scan'208";a="194894474"
Received: from genxtest-ykzhao.sh.intel.com ([10.239.143.71])
  by fmsmga001.fm.intel.com with ESMTP; 15 Aug 2019 19:33:01 -0700
From:   Zhao Yakui <yakui.zhao@intel.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org
Cc:     Zhao Yakui <yakui.zhao@intel.com>,
        Jason Chen CJ <jason.cj.chen@intel.com>
Subject: [RFC PATCH 02/15] x86/acrn: Add two APIs to add/remove driver-specific upcall ISR handler
Date:   Fri, 16 Aug 2019 10:25:43 +0800
Message-Id: <1565922356-4488-3-git-send-email-yakui.zhao@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1565922356-4488-1-git-send-email-yakui.zhao@intel.com>
References: <1565922356-4488-1-git-send-email-yakui.zhao@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After the ACRN hypervisor sends the upcall notify interrupt, the upcall ISR
handler will be served. Now almost nothing is handled in upcall ISR handler
except acking EOI.
The driver-specific ISR handler is registered by the driver, which helps to
handle the real notification from ACRN hypervisor.
This is similar to that in XEN/HyperV.

Co-developed-by: Jason Chen CJ <jason.cj.chen@intel.com>
Signed-off-by: Jason Chen CJ <jason.cj.chen@intel.com>
Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
---
 arch/x86/include/asm/acrn.h |  3 +++
 arch/x86/kernel/cpu/acrn.c  | 12 ++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/arch/x86/include/asm/acrn.h b/arch/x86/include/asm/acrn.h
index 4adb13f..857e6244 100644
--- a/arch/x86/include/asm/acrn.h
+++ b/arch/x86/include/asm/acrn.h
@@ -8,4 +8,7 @@ extern void acrn_hv_callback_vector(void);
 #endif
 
 extern void acrn_hv_vector_handler(struct pt_regs *regs);
+
+extern void acrn_setup_intr_irq(void (*handler)(void));
+extern void acrn_remove_intr_irq(void);
 #endif /* _ASM_X86_ACRN_H */
diff --git a/arch/x86/kernel/cpu/acrn.c b/arch/x86/kernel/cpu/acrn.c
index 95db5c4..a1ce52a 100644
--- a/arch/x86/kernel/cpu/acrn.c
+++ b/arch/x86/kernel/cpu/acrn.c
@@ -56,6 +56,18 @@ __visible void __irq_entry acrn_hv_vector_handler(struct pt_regs *regs)
 	set_irq_regs(old_regs);
 }
 
+void acrn_setup_intr_irq(void (*handler)(void))
+{
+	acrn_intr_handler = handler;
+}
+EXPORT_SYMBOL_GPL(acrn_setup_intr_irq);
+
+void acrn_remove_intr_irq(void)
+{
+	acrn_intr_handler = NULL;
+}
+EXPORT_SYMBOL_GPL(acrn_remove_intr_irq);
+
 const __initconst struct hypervisor_x86 x86_hyper_acrn = {
 	.name                   = "ACRN",
 	.detect                 = acrn_detect,
-- 
2.7.4

