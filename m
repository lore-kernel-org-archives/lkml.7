Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 272F6C10F05
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 14:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3E342183F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 14:41:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729532AbfC2Olg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 10:41:36 -0400
Received: from mga03.intel.com ([134.134.136.65]:50079 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729317AbfC2Olf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 10:41:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Mar 2019 07:41:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,284,1549958400"; 
   d="scan'208";a="138352097"
Received: from tthayer-hp-z620.an.intel.com ([10.122.105.146])
  by orsmga003.jf.intel.com with ESMTP; 29 Mar 2019 07:41:34 -0700
From:   thor.thayer@linux.intel.com
To:     bp@alien8.de, mchehab@kernel.org, james.morse@arm.com,
        atull@kernel.org, richard.gong@intel.com,
        gregkh@linuxfoundation.org
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thor Thayer <thor.thayer@linux.intel.com>
Subject: [PATCH 2/2] EDAC, altera: Use global Stratix10 SMC defines
Date:   Fri, 29 Mar 2019 09:43:59 -0500
Message-Id: <1553870639-23895-2-git-send-email-thor.thayer@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1553870639-23895-1-git-send-email-thor.thayer@linux.intel.com>
References: <1553870639-23895-1-git-send-email-thor.thayer@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thor Thayer <thor.thayer@linux.intel.com>

Use the global Stratix10 SMC defines instead of the local
S10 SMC defines.

Reviewed-by: Richard Gong <richard.gong@intel.com>
Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
---
 drivers/edac/altera_edac.c |  1 +
 drivers/edac/altera_edac.h | 83 ----------------------------------------------
 2 files changed, 1 insertion(+), 83 deletions(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index 761199175c76..8816f74a22b4 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -9,6 +9,7 @@
 #include <linux/ctype.h>
 #include <linux/delay.h>
 #include <linux/edac.h>
+#include <linux/firmware/intel/stratix10-smc.h>
 #include <linux/genalloc.h>
 #include <linux/interrupt.h>
 #include <linux/irqchip/chained_irq.h>
diff --git a/drivers/edac/altera_edac.h b/drivers/edac/altera_edac.h
index 1532ec9c3510..55654cc4bcdf 100644
--- a/drivers/edac/altera_edac.h
+++ b/drivers/edac/altera_edac.h
@@ -372,87 +372,4 @@ struct altr_arria10_edac {
 	struct notifier_block	panic_notifier;
 };
 
-/*
- * Functions specified by ARM SMC Calling convention:
- *
- * FAST call executes atomic operations, returns when the requested operation
- * has completed.
- * STD call starts a operation which can be preempted by a non-secure
- * interrupt. The call can return before the requested operation has
- * completed.
- *
- * a0..a7 is used as register names in the descriptions below, on arm32
- * that translates to r0..r7 and on arm64 to w0..w7.
- */
-
-#define INTEL_SIP_SMC_STD_CALL_VAL(func_num) \
-	ARM_SMCCC_CALL_VAL(ARM_SMCCC_STD_CALL, ARM_SMCCC_SMC_64, \
-	ARM_SMCCC_OWNER_SIP, (func_num))
-
-#define INTEL_SIP_SMC_FAST_CALL_VAL(func_num) \
-	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL, ARM_SMCCC_SMC_64, \
-	ARM_SMCCC_OWNER_SIP, (func_num))
-
-#define INTEL_SIP_SMC_RETURN_UNKNOWN_FUNCTION		0xFFFFFFFF
-#define INTEL_SIP_SMC_STATUS_OK				0x0
-#define INTEL_SIP_SMC_REG_ERROR				0x5
-
-/*
- * Request INTEL_SIP_SMC_REG_READ
- *
- * Read a protected register using SMCCC
- *
- * Call register usage:
- * a0: INTEL_SIP_SMC_REG_READ.
- * a1: register address.
- * a2-7: not used.
- *
- * Return status:
- * a0: INTEL_SIP_SMC_STATUS_OK, INTEL_SIP_SMC_REG_ERROR, or
- *     INTEL_SIP_SMC_RETURN_UNKNOWN_FUNCTION
- * a1: Value in the register
- * a2-3: not used.
- */
-#define INTEL_SIP_SMC_FUNCID_REG_READ 7
-#define INTEL_SIP_SMC_REG_READ \
-	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_REG_READ)
-
-/*
- * Request INTEL_SIP_SMC_REG_WRITE
- *
- * Write a protected register using SMCCC
- *
- * Call register usage:
- * a0: INTEL_SIP_SMC_REG_WRITE.
- * a1: register address
- * a2: value to program into register.
- * a3-7: not used.
- *
- * Return status:
- * a0: INTEL_SIP_SMC_STATUS_OK, INTEL_SIP_SMC_REG_ERROR, or
- *     INTEL_SIP_SMC_RETURN_UNKNOWN_FUNCTION
- * a1-3: not used.
- */
-#define INTEL_SIP_SMC_FUNCID_REG_WRITE 8
-#define INTEL_SIP_SMC_REG_WRITE \
-	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_REG_WRITE)
-
-/*
- * Request INTEL_SIP_SMC_ECC_DBE
- *
- * Sync call used by service driver at EL1 alert EL3 that a Double Bit
- * ECC error has occurred.
- *
- * Call register usage:
- * a0 INTEL_SIP_SMC_ECC_DBE
- * a1 SysManager Double Bit Error value
- * a2-7 not used
- *
- * Return status
- * a0 INTEL_SIP_SMC_STATUS_OK
- */
-#define INTEL_SIP_SMC_FUNCID_ECC_DBE 13
-#define INTEL_SIP_SMC_ECC_DBE \
-	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_ECC_DBE)
-
 #endif	/* #ifndef _ALTERA_EDAC_H */
-- 
2.7.4

