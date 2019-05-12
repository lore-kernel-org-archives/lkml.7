Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E45DFC04A6B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 16:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD3C32133D
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 16:50:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbfELQum (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 12:50:42 -0400
Received: from git.icu ([163.172.180.134]:53598 "EHLO git.icu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726478AbfELQum (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 12:50:42 -0400
Received: from localhost.localdomain (minicloud.parqtec.unicamp.br [143.106.167.126])
        by git.icu (Postfix) with ESMTPSA id 393F0221934;
        Sun, 12 May 2019 16:50:37 +0000 (UTC)
From:   Shawn Landden <shawn@git.icu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Shawn Landden <shawn@git.icu>
Subject: [PATCH] powerpc: add simd.h implementation specific to PowerPC
Date:   Sun, 12 May 2019 13:50:32 -0300
Message-Id: <20190512165032.19942-1-shawn@git.icu>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is safe to do SIMD in an interrupt on PowerPC.
Only disable when there is no SIMD available
(and this is a static branch).

Tested and works with the WireGuard (Zinc) patch I wrote that needs this.
Also improves performance of the crypto subsystem that checks this.

Buglink: https://bugzilla.kernel.org/show_bug.cgi?id=203571
Signed-off-by: Shawn Landden <shawn@git.icu>
---
 arch/powerpc/include/asm/simd.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)
 create mode 100644 arch/powerpc/include/asm/simd.h

diff --git a/arch/powerpc/include/asm/simd.h b/arch/powerpc/include/asm/simd.h
new file mode 100644
index 000000000..b3fecb95a
--- /dev/null
+++ b/arch/powerpc/include/asm/simd.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#include <asm/cpu_has_feature.h>
+
+/*
+ * may_use_simd - whether it is allowable at this time to issue SIMD
+ *                instructions or access the SIMD register file
+ *
+ * As documented in Chapter 6.2.1 Machine Status Save/Restore Registers
+ * of Power ISA (2.07 and 3.0), all registers are saved/restored in an interrupt.
+ */
+static inline bool may_use_simd(void)
+{
+	return !cpu_has_feature(CPU_FTR_FPU_UNAVAILABLE);
+}
-- 
2.21.0.1020.gf2820cf01a

