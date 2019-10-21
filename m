Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD651CA9EB7
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 17:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B41642077C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 17:24:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="rnuFuFL7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729781AbfJURYX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 13:24:23 -0400
Received: from ste-pvt-msa1.bahnhof.se ([213.80.101.70]:7293 "EHLO
        ste-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728969AbfJURYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 13:24:21 -0400
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 2485A3F859;
        Mon, 21 Oct 2019 19:24:18 +0200 (CEST)
Authentication-Results: ste-pvt-msa1.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=rnuFuFL7;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id twD45rjnv80f; Mon, 21 Oct 2019 19:24:17 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id D59343F882;
        Mon, 21 Oct 2019 19:24:15 +0200 (CEST)
Received: from localhost.localdomain.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id C58D03602F2;
        Mon, 21 Oct 2019 19:24:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1571678654; bh=6ygpk/IX7d3h/HqkkEaPvLmJltNsmHm9bF68PTR8u08=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rnuFuFL7EF7dedH0ajOrrbGFReJ3JCsU9qE0yrwdCuV/SnCYQK2phDzoktFl+88V0
         woS0JviqmOy+bdr0yzFS5Gn2oEWywCzyIAEz076Al9XxYFJxtHkb2fbl/G90qJdoZv
         0AHpPnDsojg6bVjlo9SpRdhpglmQXJDnkwCfFPE8=
From:   =?UTF-8?q?Thomas=20Hellstr=C3=B6m=20=28VMware=29?= 
        <thomas_os@shipmail.org>
To:     linux-kernel@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86-ml <x86@kernel.org>,
        Borislav Petkov <bp@suse.de>
Subject: [PATCH v2 2/2] x86/cpu/vmware: Fix platform detection VMWARE_PORT macro
Date:   Mon, 21 Oct 2019 19:24:03 +0200
Message-Id: <20191021172403.3085-3-thomas_os@shipmail.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191021172403.3085-1-thomas_os@shipmail.org>
References: <20191021172403.3085-1-thomas_os@shipmail.org>
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

Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Cc: Borislav Petkov <bp@suse.de>
Fixes: b4dd4f6e3648 ("Add a header file for hypercall definitions")
Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
---
 arch/x86/include/asm/vmware.h | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/vmware.h b/arch/x86/include/asm/vmware.h
index 3caac90f9761..ac9fc51e2b18 100644
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
-	ALTERNATIVE_2("movw $" VMWARE_HYPERVISOR_PORT ", %%dx; "	\
+	ALTERNATIVE_2("movw $" __stringify(VMWARE_HYPERVISOR_PORT) ", %%dx; " \
 		      "inl (%%dx), %%eax",				\
 		      "vmcall", X86_FEATURE_VMCALL,			\
 		      "vmmcall", X86_FEATURE_VMW_VMMCALL)
@@ -39,7 +40,8 @@
  * HB and OUT bits set.
  */
 #define VMWARE_HYPERCALL_HB_OUT						\
-	ALTERNATIVE_2("movw $" VMWARE_HYPERVISOR_PORT_HB ", %%dx; rep outsb", \
+	ALTERNATIVE_2("movw $" __stringify(VMWARE_HYPERVISOR_PORT_HB) ", %%dx; " \
+		      "rep outsb",					\
 		      "vmcall", X86_FEATURE_VMCALL,			\
 		      "vmmcall", X86_FEATURE_VMW_VMMCALL)
 
@@ -48,7 +50,8 @@
  * HB bit set.
  */
 #define VMWARE_HYPERCALL_HB_IN						\
-	ALTERNATIVE_2("movw $" VMWARE_HYPERVISOR_PORT_HB ", %%dx; rep insb", \
+	ALTERNATIVE_2("movw $" __stringify(VMWARE_HYPERVISOR_PORT_HB) ", %%dx; " \
+		      "rep insb",					\
 		      "vmcall", X86_FEATURE_VMCALL,			\
 		      "vmmcall", X86_FEATURE_VMW_VMMCALL)
 #endif
-- 
2.21.0

