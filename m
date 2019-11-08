Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0431FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 13:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BB532178F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 13:04:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="WBMs6v+U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728983AbfKHNB6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 08:01:58 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38892 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728714AbfKHNB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 08:01:57 -0500
Received: by mail-lj1-f194.google.com with SMTP id v8so6132112ljh.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 05:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E3PC0GBgcRJcw1cBz/t/6fNHbK3513aW1cpvhBViR+w=;
        b=WBMs6v+Uh0xmpwMVXsT7kku+eUv6ehM5s5BtzPv6w6wkzVfa5b1BQxkcRDWq85RGSD
         H5b9mG06oI+OPmDTYOTY+B99OLzic5P1w5a4n7eoYSdJix0QPdu7zK9uNaRtUkB8iDzE
         oS6vhvtkC/z7ModAsNkSJszPrqRGmYrn1sXsI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E3PC0GBgcRJcw1cBz/t/6fNHbK3513aW1cpvhBViR+w=;
        b=ZidCrBqId+JTc4kTgBepjPmvw5L1iBpHHG2VmlzDCHywqsUqTbyUxb2D60t+4g1yEe
         oLb4c7SSYKk5taa32Z+7jYY6CFx0pZlmg0GKU9T6rdnCUc2RF52FmOeiASuIoofzjrKM
         BJX+popk4mjyna7I1Tio62lyrlni8bvnJ0h2c+dCEHJsUa6jyV4MBtuBvMID5uRdagN7
         2/Hk+y8zdwVTVWoMZckjiTxwXPu8jhiLiAr6+gOlNy+A4JHSUgPIDgLdkSjil/J/500l
         LEG3Nc7DWAewnhWS3ayEja+isNwhb/uwW0WHhffiVdOCdmyEwdHcMwrKBP5mNrVt1Uy0
         VkUQ==
X-Gm-Message-State: APjAAAU/mJ2SxEzznYMhSNHN9+2HRlv+kbkHjdmoZQyBCX54lcHEeUVJ
        5Nmy9LOcMD9UTKtAzC197yEZDNkeHttwks51
X-Google-Smtp-Source: APXvYqyFjKen6CS3WKeuslEAOUiLMLvgkLI5pRXG/qK74c6+e1zNbbGvIpzUavZLjoV7FOqoB9rs/A==
X-Received: by 2002:a05:651c:87:: with SMTP id 7mr6917372ljq.20.1573218114921;
        Fri, 08 Nov 2019 05:01:54 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id d28sm2454725lfn.33.2019.11.08.05.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 05:01:54 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v4 21/47] soc: fsl: qe: merge qe_ic.h headers into qe_ic.c
Date:   Fri,  8 Nov 2019 14:00:57 +0100
Message-Id: <20191108130123.6839-22-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191108130123.6839-1-linux@rasmusvillemoes.dk>
References: <20191108130123.6839-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The public qe_ic.h header is no longer included by anything but
qe_ic.c. Merge both headers into qe_ic.c, and drop the unused
constants.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/soc/fsl/qe/qe_ic.c | 52 +++++++++++++++++++-
 drivers/soc/fsl/qe/qe_ic.h | 99 --------------------------------------
 include/soc/fsl/qe/qe_ic.h | 56 ---------------------
 3 files changed, 50 insertions(+), 157 deletions(-)
 delete mode 100644 drivers/soc/fsl/qe/qe_ic.h
 delete mode 100644 include/soc/fsl/qe/qe_ic.h

diff --git a/drivers/soc/fsl/qe/qe_ic.c b/drivers/soc/fsl/qe/qe_ic.c
index 4832884da5bb..0dd5bdb04a14 100644
--- a/drivers/soc/fsl/qe/qe_ic.c
+++ b/drivers/soc/fsl/qe/qe_ic.c
@@ -15,6 +15,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/errno.h>
+#include <linux/irq.h>
 #include <linux/reboot.h>
 #include <linux/slab.h>
 #include <linux/stddef.h>
@@ -25,9 +26,56 @@
 #include <asm/irq.h>
 #include <asm/io.h>
 #include <soc/fsl/qe/qe.h>
-#include <soc/fsl/qe/qe_ic.h>
 
-#include "qe_ic.h"
+#define NR_QE_IC_INTS		64
+
+/* QE IC registers offset */
+#define QEIC_CICR		0x00
+#define QEIC_CIVEC		0x04
+#define QEIC_CIPXCC		0x10
+#define QEIC_CIPYCC		0x14
+#define QEIC_CIPWCC		0x18
+#define QEIC_CIPZCC		0x1c
+#define QEIC_CIMR		0x20
+#define QEIC_CRIMR		0x24
+#define QEIC_CIPRTA		0x30
+#define QEIC_CIPRTB		0x34
+#define QEIC_CHIVEC		0x60
+
+struct qe_ic {
+	/* Control registers offset */
+	u32 __iomem *regs;
+
+	/* The remapper for this QEIC */
+	struct irq_domain *irqhost;
+
+	/* The "linux" controller struct */
+	struct irq_chip hc_irq;
+
+	/* VIRQ numbers of QE high/low irqs */
+	unsigned int virq_high;
+	unsigned int virq_low;
+};
+
+/*
+ * QE interrupt controller internal structure
+ */
+struct qe_ic_info {
+	/* Location of this source at the QIMR register */
+	u32	mask;
+
+	/* Mask register offset */
+	u32	mask_reg;
+
+	/*
+	 * For grouped interrupts sources - the interrupt code as
+	 * appears at the group priority register
+	 */
+	u8	pri_code;
+
+	/* Group priority register offset */
+	u32	pri_reg;
+};
 
 static DEFINE_RAW_SPINLOCK(qe_ic_lock);
 
diff --git a/drivers/soc/fsl/qe/qe_ic.h b/drivers/soc/fsl/qe/qe_ic.h
deleted file mode 100644
index 9420378d9b6b..000000000000
--- a/drivers/soc/fsl/qe/qe_ic.h
+++ /dev/null
@@ -1,99 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * drivers/soc/fsl/qe/qe_ic.h
- *
- * QUICC ENGINE Interrupt Controller Header
- *
- * Copyright (C) 2006 Freescale Semiconductor, Inc. All rights reserved.
- *
- * Author: Li Yang <leoli@freescale.com>
- * Based on code from Shlomi Gridish <gridish@freescale.com>
- */
-#ifndef _POWERPC_SYSDEV_QE_IC_H
-#define _POWERPC_SYSDEV_QE_IC_H
-
-#include <soc/fsl/qe/qe_ic.h>
-
-#define NR_QE_IC_INTS		64
-
-/* QE IC registers offset */
-#define QEIC_CICR		0x00
-#define QEIC_CIVEC		0x04
-#define QEIC_CRIPNR		0x08
-#define QEIC_CIPNR		0x0c
-#define QEIC_CIPXCC		0x10
-#define QEIC_CIPYCC		0x14
-#define QEIC_CIPWCC		0x18
-#define QEIC_CIPZCC		0x1c
-#define QEIC_CIMR		0x20
-#define QEIC_CRIMR		0x24
-#define QEIC_CICNR		0x28
-#define QEIC_CIPRTA		0x30
-#define QEIC_CIPRTB		0x34
-#define QEIC_CRICR		0x3c
-#define QEIC_CHIVEC		0x60
-
-/* Interrupt priority registers */
-#define CIPCC_SHIFT_PRI0	29
-#define CIPCC_SHIFT_PRI1	26
-#define CIPCC_SHIFT_PRI2	23
-#define CIPCC_SHIFT_PRI3	20
-#define CIPCC_SHIFT_PRI4	13
-#define CIPCC_SHIFT_PRI5	10
-#define CIPCC_SHIFT_PRI6	7
-#define CIPCC_SHIFT_PRI7	4
-
-/* CICR priority modes */
-#define CICR_GWCC		0x00040000
-#define CICR_GXCC		0x00020000
-#define CICR_GYCC		0x00010000
-#define CICR_GZCC		0x00080000
-#define CICR_GRTA		0x00200000
-#define CICR_GRTB		0x00400000
-#define CICR_HPIT_SHIFT		8
-#define CICR_HPIT_MASK		0x00000300
-#define CICR_HP_SHIFT		24
-#define CICR_HP_MASK		0x3f000000
-
-/* CICNR */
-#define CICNR_WCC1T_SHIFT	20
-#define CICNR_ZCC1T_SHIFT	28
-#define CICNR_YCC1T_SHIFT	12
-#define CICNR_XCC1T_SHIFT	4
-
-/* CRICR */
-#define CRICR_RTA1T_SHIFT	20
-#define CRICR_RTB1T_SHIFT	28
-
-/* Signal indicator */
-#define SIGNAL_MASK		3
-#define SIGNAL_HIGH		2
-#define SIGNAL_LOW		0
-
-struct qe_ic {
-	/* Control registers offset */
-	u32 __iomem *regs;
-
-	/* The remapper for this QEIC */
-	struct irq_domain *irqhost;
-
-	/* The "linux" controller struct */
-	struct irq_chip hc_irq;
-
-	/* VIRQ numbers of QE high/low irqs */
-	unsigned int virq_high;
-	unsigned int virq_low;
-};
-
-/*
- * QE interrupt controller internal structure
- */
-struct qe_ic_info {
-	u32	mask;	  /* location of this source at the QIMR register. */
-	u32	mask_reg; /* Mask register offset */
-	u8	pri_code; /* for grouped interrupts sources - the interrupt
-			     code as appears at the group priority register */
-	u32	pri_reg;  /* Group priority register offset */
-};
-
-#endif /* _POWERPC_SYSDEV_QE_IC_H */
diff --git a/include/soc/fsl/qe/qe_ic.h b/include/soc/fsl/qe/qe_ic.h
deleted file mode 100644
index 70bb5a0f6535..000000000000
--- a/include/soc/fsl/qe/qe_ic.h
+++ /dev/null
@@ -1,56 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * Copyright (C) 2006 Freescale Semiconductor, Inc. All rights reserved.
- *
- * Authors: 	Shlomi Gridish <gridish@freescale.com>
- * 		Li Yang <leoli@freescale.com>
- *
- * Description:
- * QE IC external definitions and structure.
- */
-#ifndef _ASM_POWERPC_QE_IC_H
-#define _ASM_POWERPC_QE_IC_H
-
-#include <linux/irq.h>
-
-struct device_node;
-struct qe_ic;
-
-#define NUM_OF_QE_IC_GROUPS	6
-
-/* Flags when we init the QE IC */
-#define QE_IC_SPREADMODE_GRP_W			0x00000001
-#define QE_IC_SPREADMODE_GRP_X			0x00000002
-#define QE_IC_SPREADMODE_GRP_Y			0x00000004
-#define QE_IC_SPREADMODE_GRP_Z			0x00000008
-#define QE_IC_SPREADMODE_GRP_RISCA		0x00000010
-#define QE_IC_SPREADMODE_GRP_RISCB		0x00000020
-
-#define QE_IC_LOW_SIGNAL			0x00000100
-#define QE_IC_HIGH_SIGNAL			0x00000200
-
-#define QE_IC_GRP_W_PRI0_DEST_SIGNAL_HIGH	0x00001000
-#define QE_IC_GRP_W_PRI1_DEST_SIGNAL_HIGH	0x00002000
-#define QE_IC_GRP_X_PRI0_DEST_SIGNAL_HIGH	0x00004000
-#define QE_IC_GRP_X_PRI1_DEST_SIGNAL_HIGH	0x00008000
-#define QE_IC_GRP_Y_PRI0_DEST_SIGNAL_HIGH	0x00010000
-#define QE_IC_GRP_Y_PRI1_DEST_SIGNAL_HIGH	0x00020000
-#define QE_IC_GRP_Z_PRI0_DEST_SIGNAL_HIGH	0x00040000
-#define QE_IC_GRP_Z_PRI1_DEST_SIGNAL_HIGH	0x00080000
-#define QE_IC_GRP_RISCA_PRI0_DEST_SIGNAL_HIGH	0x00100000
-#define QE_IC_GRP_RISCA_PRI1_DEST_SIGNAL_HIGH	0x00200000
-#define QE_IC_GRP_RISCB_PRI0_DEST_SIGNAL_HIGH	0x00400000
-#define QE_IC_GRP_RISCB_PRI1_DEST_SIGNAL_HIGH	0x00800000
-#define QE_IC_GRP_W_DEST_SIGNAL_SHIFT		(12)
-
-/* QE interrupt sources groups */
-enum qe_ic_grp_id {
-	QE_IC_GRP_W = 0,	/* QE interrupt controller group W */
-	QE_IC_GRP_X,		/* QE interrupt controller group X */
-	QE_IC_GRP_Y,		/* QE interrupt controller group Y */
-	QE_IC_GRP_Z,		/* QE interrupt controller group Z */
-	QE_IC_GRP_RISCA,	/* QE interrupt controller RISC group A */
-	QE_IC_GRP_RISCB		/* QE interrupt controller RISC group B */
-};
-
-#endif /* _ASM_POWERPC_QE_IC_H */
-- 
2.23.0

