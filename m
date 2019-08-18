Return-Path: <SRS0=w4Fx=WO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B20AC3A589
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 14:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D4642087E
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 14:41:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="bMNp5vwb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfHROlL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Aug 2019 10:41:11 -0400
Received: from pio-pvt-msa3.bahnhof.se ([79.136.2.42]:34326 "EHLO
        pio-pvt-msa3.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbfHROlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 10:41:10 -0400
X-Greylist: delayed 435 seconds by postgrey-1.27 at vger.kernel.org; Sun, 18 Aug 2019 10:41:08 EDT
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTP id 04C143FA8F;
        Sun, 18 Aug 2019 16:33:54 +0200 (CEST)
Authentication-Results: pio-pvt-msa3.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=bMNp5vwb;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa3.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa3.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Hl06DgOgFEbZ; Sun, 18 Aug 2019 16:33:50 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTPA id 25E013FA80;
        Sun, 18 Aug 2019 16:33:49 +0200 (CEST)
Received: from localhost.localdomain.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 9944B360199;
        Sun, 18 Aug 2019 16:33:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1566138829; bh=+gvFllwm2xL1rOjRElI9TJunZdE8KRIVqV6Hn+uXfGc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bMNp5vwb74I8dQhEqA65CktFFL/pb3QuCBK8dMfNQxYgONfwTt6s71JZpytrF8YFD
         9hyrED24JUS4xY748zFe0kkckkZ9ROc4kRQocvce+yHcb83kBrp2RKQ082zNrYqV+B
         LnozrJvSNFMcBue5t2kCYQE9fSQRpEKK8ReVPvV8=
From:   =?UTF-8?q?Thomas=20Hellstr=C3=B6m=20=28VMware=29?= 
        <thomas_os@shipmail.org>
To:     linux-kernel@vger.kernel.org, pv-drivers@vmware.com
Cc:     Thomas Hellstrom <thellstrom@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Doug Covelli <dcovelli@vmware.com>
Subject: [PATCH 2/4] x86/vmware: Add a header file for hypercall definitions
Date:   Sun, 18 Aug 2019 16:33:14 +0200
Message-Id: <20190818143316.4906-3-thomas_os@shipmail.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190818143316.4906-1-thomas_os@shipmail.org>
References: <20190818143316.4906-1-thomas_os@shipmail.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Hellstrom <thellstrom@vmware.com>

This is intended to be used by drivers using the backdoor, and
we follow the kvm example using alternatives self-patching to
choose between vmcall, vmmcall and inl instructions.

This patch defines two new x86 cpu feature flags.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: <x86@kernel.org>
Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
Reviewed-by: Doug Covelli <dcovelli@vmware.com>
---
 MAINTAINERS                        |  1 +
 arch/x86/include/asm/cpufeatures.h |  2 ++
 arch/x86/include/asm/vmware.h      | 13 +++++++++++++
 3 files changed, 16 insertions(+)
 create mode 100644 arch/x86/include/asm/vmware.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 1bd7b9c2d146..412206747270 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17203,6 +17203,7 @@ M:	"VMware, Inc." <pv-drivers@vmware.com>
 L:	virtualization@lists.linux-foundation.org
 S:	Supported
 F:	arch/x86/kernel/cpu/vmware.c
+F:	arch/x86/include/asm/vmware.h
 
 VMWARE PVRDMA DRIVER
 M:	Adit Ranadive <aditr@vmware.com>
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 998c2cc08363..69cecc3bc9cb 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -232,6 +232,8 @@
 #define X86_FEATURE_VMMCALL		( 8*32+15) /* Prefer VMMCALL to VMCALL */
 #define X86_FEATURE_XENPV		( 8*32+16) /* "" Xen paravirtual guest */
 #define X86_FEATURE_EPT_AD		( 8*32+17) /* Intel Extended Page Table access-dirty bit */
+#define X86_FEATURE_VMW_VMCALL		( 8*32+18) /* VMware prefers VMCALL hypercall instruction */
+#define X86_FEATURE_VMW_VMMCALL		( 8*32+19) /* VMware prefers VMMCALL hypercall instruction */
 
 /* Intel-defined CPU features, CPUID level 0x00000007:0 (EBX), word 9 */
 #define X86_FEATURE_FSGSBASE		( 9*32+ 0) /* RDFSBASE, WRFSBASE, RDGSBASE, WRGSBASE instructions*/
diff --git a/arch/x86/include/asm/vmware.h b/arch/x86/include/asm/vmware.h
new file mode 100644
index 000000000000..22d2dbfba90f
--- /dev/null
+++ b/arch/x86/include/asm/vmware.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 or MIT */
+#ifndef _ASM_X86_VMWARE_H
+#define _ASM_X86_VMWARE_H
+
+#include <asm/cpufeatures.h>
+#include <asm/alternative.h>
+
+#define VMWARE_HYPERCALL \
+	ALTERNATIVE_2(".byte 0xed", \
+		      ".byte 0x0f, 0x01, 0xc1", X86_FEATURE_VMW_VMCALL,	\
+		      ".byte 0x0f, 0x01, 0xd9", X86_FEATURE_VMW_VMMCALL)
+
+#endif
-- 
2.20.1

