Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC85CCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 13:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 924CC222C5
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 13:41:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="MbVXQnTq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442860AbfJRNlS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 09:41:18 -0400
Received: from ste-pvt-msa1.bahnhof.se ([213.80.101.70]:42062 "EHLO
        ste-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388276AbfJRNlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 09:41:17 -0400
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id E32133F451;
        Fri, 18 Oct 2019 15:41:14 +0200 (CEST)
Authentication-Results: ste-pvt-msa1.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=MbVXQnTq;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1Q_cdxpoZOJk; Fri, 18 Oct 2019 15:41:10 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id E86303F79C;
        Fri, 18 Oct 2019 15:41:04 +0200 (CEST)
Received: from localhost.localdomain.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 10858360C1D;
        Fri, 18 Oct 2019 15:41:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1571406064; bh=CM0kDaJkew2uovB/LOxOt2lTd8T+CE/y2CkZ2N5cYKs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MbVXQnTqZA1neMRpxQaPGzT+SVBvuwBftmpYWmRQtMZ/Fq6HHjul0g5X5XwlDynyv
         JRwKcZXwuIIHCCCMjZL5LdsJv5+6ciIEbuBSDaPeCHVrkP2xI8w1SOgWOcjs+K8l+q
         BVETaa/98WezoCSKxfTFuIAh679Yn/XC+q5zBl7o=
From:   =?UTF-8?q?Thomas=20Hellstr=C3=B6m=20=28VMware=29?= 
        <thomas_os@shipmail.org>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Hellstrom <thellstrom@vmware.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86-ml <x86@kernel.org>,
        Borislav Petkov <bp@suse.de>
Subject: [PATCH 2/2] x86/cpu/vmware: Fix platform detection VMWARE_PORT macro
Date:   Fri, 18 Oct 2019 15:40:52 +0200
Message-Id: <20191018134052.3023-3-thomas_os@shipmail.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191018134052.3023-1-thomas_os@shipmail.org>
References: <20191018134052.3023-1-thomas_os@shipmail.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Hellstrom <thellstrom@vmware.com>

The platform detection VMWARE_PORT macro uses the VMWARE_HYPERVISOR_PORT
definition, but expects it to be an integer. However, when it was moved
to the new vmware.h include file, it was changed to be a string to better
fit into the VMWARE_HYPERCALL set of macros. This obviously breaks the
platform detection VMWARE_PORT functionality.

Change the VMWARE_HYPERVISOR_PORT and VMWARE_HYPERVISOR_PORT_HB
definitions to be integers, and use __stringify() for their stringified
form when needed.

Fixes: b4dd4f6e3648 ("Add a header file for hypercall definitions")
Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Cc: Borislav Petkov <bp@suse.de>
---
 arch/x86/include/asm/vmware.h | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/vmware.h b/arch/x86/include/asm/vmware.h
index f5fbe3778aef..d20eda0c6ed8 100644
--- a/arch/x86/include/asm/vmware.h
+++ b/arch/x86/include/asm/vmware.h
@@ -4,6 +4,7 @@
 
 #include <asm/cpufeatures.h>
 #include <asm/alternative.h>
+#include <linux/stringify.h>
 
 /*
  * The hypercall definitions differ in the low word of the %edx argument
@@ -20,8 +21,8 @@
  */
 
 /* Old port-based version */
-#define VMWARE_HYPERVISOR_PORT    "0x5658"
-#define VMWARE_HYPERVISOR_PORT_HB "0x5659"
+#define VMWARE_HYPERVISOR_PORT    0x5658
+#define VMWARE_HYPERVISOR_PORT_HB 0x5659
 
 /* Current vmcall / vmmcall version */
 #define VMWARE_HYPERVISOR_HB   BIT(0)
@@ -29,7 +30,7 @@
 
 /* The low bandwidth call. The low word of edx is presumed clear. */
 #define VMWARE_HYPERCALL						\
-	ALTERNATIVE_2("movw $" VMWARE_HYPERVISOR_PORT			\
+	ALTERNATIVE_2("movw $" __stringify(VMWARE_HYPERVISOR_PORT)	\
 		      ", %%dx; inl (%%dx), %%eax",			\
 		      "vmcall", X86_FEATURE_VMCALL,			\
 		      "vmmcall", X86_FEATURE_VMW_VMMCALL)
@@ -39,7 +40,8 @@
  * HB and OUT bits set.
  */
 #define VMWARE_HYPERCALL_HB_OUT						\
-	ALTERNATIVE_2("movw $" VMWARE_HYPERVISOR_PORT_HB ", %%dx; rep outsb", \
+	ALTERNATIVE_2("movw $" __stringify(VMWARE_HYPERVISOR_PORT_HB)	\
+		      ", %%dx; rep outsb",				\
 		      "vmcall", X86_FEATURE_VMCALL,			\
 		      "vmmcall", X86_FEATURE_VMW_VMMCALL)
 
@@ -48,7 +50,8 @@
  * HB bit set.
  */
 #define VMWARE_HYPERCALL_HB_IN						\
-	ALTERNATIVE_2("movw $" VMWARE_HYPERVISOR_PORT_HB ", %%dx; rep insb", \
+	ALTERNATIVE_2("movw $" __stringify(VMWARE_HYPERVISOR_PORT_HB)	\
+		      ", %%dx; rep insb",				\
 		      "vmcall", X86_FEATURE_VMCALL,			\
 		      "vmmcall", X86_FEATURE_VMW_VMMCALL)
 #endif
-- 
2.21.0

