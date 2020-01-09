Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F20C32771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 12:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B27D2072A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 12:34:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731065AbgAIMej (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 07:34:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:38020 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729485AbgAIMeK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 07:34:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 44771B220A;
        Thu,  9 Jan 2020 12:34:05 +0000 (UTC)
From:   Thomas Bogendoerfer <tbogendoerfer@suse.de>
To:     Paul Burton <paulburton@kernel.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 05/14] MIPS: SGI-IP27: move IP27 specific macro to IP27 specific header file
Date:   Thu,  9 Jan 2020 13:33:42 +0100
Message-Id: <20200109123353.5656-6-tbogendoerfer@suse.de>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200109123353.5656-1-tbogendoerfer@suse.de>
References: <20200109123353.5656-1-tbogendoerfer@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extracting node id from HUB register is specific to IP27 alias SN0.
Move the macro definition to a SN0 header file.

Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
---
 arch/mips/include/asm/mach-ip27/kernel-entry-init.h | 10 ----------
 arch/mips/include/asm/sn/sn0/hub.h                  | 12 ++++++++++++
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/arch/mips/include/asm/mach-ip27/kernel-entry-init.h b/arch/mips/include/asm/mach-ip27/kernel-entry-init.h
index ef31d9fcf806..3e54f605a70b 100644
--- a/arch/mips/include/asm/mach-ip27/kernel-entry-init.h
+++ b/arch/mips/include/asm/mach-ip27/kernel-entry-init.h
@@ -13,16 +13,6 @@
 #include <asm/sn/agent.h>
 #include <asm/sn/klkernvars.h>
 
-/*
- * Returns the local nasid into res.
- */
-	.macro GET_NASID_ASM res
-	dli	\res, LOCAL_HUB_ADDR(NI_STATUS_REV_ID)
-	ld	\res, (\res)
-	and	\res, NSRI_NODEID_MASK
-	dsrl	\res, NSRI_NODEID_SHFT
-	.endm
-
 /*
  * TLB bits
  */
diff --git a/arch/mips/include/asm/sn/sn0/hub.h b/arch/mips/include/asm/sn/sn0/hub.h
index d78dd76d5dcf..82cadd785b9c 100644
--- a/arch/mips/include/asm/sn/sn0/hub.h
+++ b/arch/mips/include/asm/sn/sn0/hub.h
@@ -37,4 +37,16 @@
 #define UATTR_MSPEC	2
 #define UATTR_UNCAC	3
 
+#ifdef __ASSEMBLY__
+/*
+ * Returns the local nasid into res.
+ */
+	.macro GET_NASID_ASM res
+	dli	\res, LOCAL_HUB_ADDR(NI_STATUS_REV_ID)
+	ld	\res, (\res)
+	and	\res, NSRI_NODEID_MASK
+	dsrl	\res, NSRI_NODEID_SHFT
+	.endm
+#endif
+
 #endif /* _ASM_SN_SN0_HUB_H */
-- 
2.24.1

