Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D492C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 13:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C1662087E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 13:04:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="g7KiSRPb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728309AbfKHNBt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 08:01:49 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37440 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728124AbfKHNBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 08:01:47 -0500
Received: by mail-lj1-f194.google.com with SMTP id l20so6125874lje.4
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 05:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T+KHWoZFWeQroCzQkpqKDeeI72keMT8L4+xk/eIgXuc=;
        b=g7KiSRPbHuKdA4T55GMOn6guYsU05eaRICujvFXBMGKOpj8SC4wtrUyKKg2agYBpoz
         PA66ZOI+bmBdzpVYqMkfb1rg8JE8NDUJXNiqKBar+Dgsse23jloTa41gZYL1ig6Stles
         oji8dS8Fbe7CLnGwghIisbdwPd/7zLBIl3FII=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T+KHWoZFWeQroCzQkpqKDeeI72keMT8L4+xk/eIgXuc=;
        b=EDOoyfkK7mF0rSshgi/V/OV5Mac/sMwGpVmYrUa2ofGXkxYHheHwXTmaEAbasTGkU5
         oSxQpypt7tjDX01ZJWMCY03s6qk8S486g0RwvB18rcNFyHlFuPQFwdykcY2oW99b0Hh4
         FtriGmbKuxjln6Dv5KbNfnG+PTJA0311u7G7h5vA0k27QiXQGHQMp/sh0vtuvIGPyJz3
         LVRLCK28RKlUWCM3TqlhMS0AjlYqFl2xyczPEwYGMTcrQMAhJHAMl5H6jl6tFHVAuAgf
         b0iW+d1LW0SS0fk/zc4ZypnrM+lwaFehGKIvFQISCz/LFWaFpqJNSqz1/m5IstlOfMxm
         s9OQ==
X-Gm-Message-State: APjAAAW2WgykpNUbTzz8xYBrQkOON9aSUHfBC5E+L558EBfUccw6TkGZ
        lC7yD/giWbssH5DoJtBj6Hq4VQ==
X-Google-Smtp-Source: APXvYqwjJFDfItRqpbHph7Wn5Fp0iYV8+40RahfeG8ylFCG12x2egtOJdyqJsWYibZVpf6JWdEELhw==
X-Received: by 2002:a2e:478a:: with SMTP id u132mr6704339lja.181.1573218103348;
        Fri, 08 Nov 2019 05:01:43 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id d28sm2454725lfn.33.2019.11.08.05.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 05:01:42 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v4 12/47] soc: fsl: qe: move calls of qe_ic_init out of arch/powerpc/
Date:   Fri,  8 Nov 2019 14:00:48 +0100
Message-Id: <20191108130123.6839-13-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191108130123.6839-1-linux@rasmusvillemoes.dk>
References: <20191108130123.6839-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Having to call qe_ic_init() from platform-specific code makes it
awkward to allow building the QE drivers for ARM. It's also a needless
duplication of code, and slightly error-prone: Instead of the caller
needing to know the details of whether the QUICC Engine High and QUICC
Engine Low are actually the same interrupt (see e.g. the machine_is()
in mpc85xx_mds_qeic_init), just let the init function choose the
appropriate handlers after it has parsed the DT and figured it out. If
the two interrupts are distinct, use separate handlers, otherwise use
the handler which first checks the CHIVEC register (for the high
priority interrupts), then the CIVEC.

All existing callers pass 0 for flags, so continue to do that from the
new single caller. Later cleanups will remove that argument
from qe_ic_init and simplify the body, as well as make qe_ic_init into
a proper init function for an IRQCHIP_DECLARE, eliminating the need to
manually look up the fsl,qe-ic node.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 arch/powerpc/platforms/83xx/km83xx.c          |  1 -
 arch/powerpc/platforms/83xx/misc.c            | 16 ----------
 arch/powerpc/platforms/83xx/mpc832x_mds.c     |  1 -
 arch/powerpc/platforms/83xx/mpc832x_rdb.c     |  1 -
 arch/powerpc/platforms/83xx/mpc836x_mds.c     |  1 -
 arch/powerpc/platforms/83xx/mpc836x_rdk.c     |  1 -
 arch/powerpc/platforms/83xx/mpc83xx.h         |  2 --
 arch/powerpc/platforms/85xx/corenet_generic.c | 10 -------
 arch/powerpc/platforms/85xx/mpc85xx_mds.c     | 27 -----------------
 arch/powerpc/platforms/85xx/mpc85xx_rdb.c     | 17 -----------
 arch/powerpc/platforms/85xx/twr_p102x.c       | 15 ----------
 drivers/soc/fsl/qe/qe_ic.c                    | 29 +++++++++++++++++--
 include/soc/fsl/qe/qe_ic.h                    |  7 -----
 13 files changed, 26 insertions(+), 102 deletions(-)

diff --git a/arch/powerpc/platforms/83xx/km83xx.c b/arch/powerpc/platforms/83xx/km83xx.c
index 273145aed90a..5c6227f7bc37 100644
--- a/arch/powerpc/platforms/83xx/km83xx.c
+++ b/arch/powerpc/platforms/83xx/km83xx.c
@@ -34,7 +34,6 @@
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
 #include <soc/fsl/qe/qe.h>
-#include <soc/fsl/qe/qe_ic.h>
 
 #include "mpc83xx.h"
 
diff --git a/arch/powerpc/platforms/83xx/misc.c b/arch/powerpc/platforms/83xx/misc.c
index 779791c0570f..6935a5b9fbd1 100644
--- a/arch/powerpc/platforms/83xx/misc.c
+++ b/arch/powerpc/platforms/83xx/misc.c
@@ -14,7 +14,6 @@
 #include <asm/io.h>
 #include <asm/hw_irq.h>
 #include <asm/ipic.h>
-#include <soc/fsl/qe/qe_ic.h>
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
 
@@ -90,24 +89,9 @@ void __init mpc83xx_ipic_init_IRQ(void)
 }
 
 #ifdef CONFIG_QUICC_ENGINE
-void __init mpc83xx_qe_init_IRQ(void)
-{
-	struct device_node *np;
-
-	np = of_find_compatible_node(NULL, NULL, "fsl,qe-ic");
-	if (!np) {
-		np = of_find_node_by_type(NULL, "qeic");
-		if (!np)
-			return;
-	}
-	qe_ic_init(np, 0, qe_ic_cascade_low_mpic, qe_ic_cascade_high_mpic);
-	of_node_put(np);
-}
-
 void __init mpc83xx_ipic_and_qe_init_IRQ(void)
 {
 	mpc83xx_ipic_init_IRQ();
-	mpc83xx_qe_init_IRQ();
 }
 #endif /* CONFIG_QUICC_ENGINE */
 
diff --git a/arch/powerpc/platforms/83xx/mpc832x_mds.c b/arch/powerpc/platforms/83xx/mpc832x_mds.c
index b428835e5919..1c73af104d19 100644
--- a/arch/powerpc/platforms/83xx/mpc832x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc832x_mds.c
@@ -33,7 +33,6 @@
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
 #include <soc/fsl/qe/qe.h>
-#include <soc/fsl/qe/qe_ic.h>
 
 #include "mpc83xx.h"
 
diff --git a/arch/powerpc/platforms/83xx/mpc832x_rdb.c b/arch/powerpc/platforms/83xx/mpc832x_rdb.c
index 4588ce632484..87f68ca06255 100644
--- a/arch/powerpc/platforms/83xx/mpc832x_rdb.c
+++ b/arch/powerpc/platforms/83xx/mpc832x_rdb.c
@@ -22,7 +22,6 @@
 #include <asm/ipic.h>
 #include <asm/udbg.h>
 #include <soc/fsl/qe/qe.h>
-#include <soc/fsl/qe/qe_ic.h>
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
 
diff --git a/arch/powerpc/platforms/83xx/mpc836x_mds.c b/arch/powerpc/platforms/83xx/mpc836x_mds.c
index 4a4efa906d35..5b484da9533e 100644
--- a/arch/powerpc/platforms/83xx/mpc836x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc836x_mds.c
@@ -41,7 +41,6 @@
 #include <sysdev/fsl_pci.h>
 #include <sysdev/simple_gpio.h>
 #include <soc/fsl/qe/qe.h>
-#include <soc/fsl/qe/qe_ic.h>
 
 #include "mpc83xx.h"
 
diff --git a/arch/powerpc/platforms/83xx/mpc836x_rdk.c b/arch/powerpc/platforms/83xx/mpc836x_rdk.c
index 9923059cb111..b7119e443920 100644
--- a/arch/powerpc/platforms/83xx/mpc836x_rdk.c
+++ b/arch/powerpc/platforms/83xx/mpc836x_rdk.c
@@ -17,7 +17,6 @@
 #include <asm/ipic.h>
 #include <asm/udbg.h>
 #include <soc/fsl/qe/qe.h>
-#include <soc/fsl/qe/qe_ic.h>
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
 
diff --git a/arch/powerpc/platforms/83xx/mpc83xx.h b/arch/powerpc/platforms/83xx/mpc83xx.h
index 459145623334..d343f6ce2599 100644
--- a/arch/powerpc/platforms/83xx/mpc83xx.h
+++ b/arch/powerpc/platforms/83xx/mpc83xx.h
@@ -73,10 +73,8 @@ extern int mpc834x_usb_cfg(void);
 extern int mpc831x_usb_cfg(void);
 extern void mpc83xx_ipic_init_IRQ(void);
 #ifdef CONFIG_QUICC_ENGINE
-extern void mpc83xx_qe_init_IRQ(void);
 extern void mpc83xx_ipic_and_qe_init_IRQ(void);
 #else
-static inline void __init mpc83xx_qe_init_IRQ(void) {}
 #define mpc83xx_ipic_and_qe_init_IRQ mpc83xx_ipic_init_IRQ
 #endif /* CONFIG_QUICC_ENGINE */
 
diff --git a/arch/powerpc/platforms/85xx/corenet_generic.c b/arch/powerpc/platforms/85xx/corenet_generic.c
index 7ee2c6628f64..8c1bb3941642 100644
--- a/arch/powerpc/platforms/85xx/corenet_generic.c
+++ b/arch/powerpc/platforms/85xx/corenet_generic.c
@@ -24,7 +24,6 @@
 #include <asm/mpic.h>
 #include <asm/ehv_pic.h>
 #include <asm/swiotlb.h>
-#include <soc/fsl/qe/qe_ic.h>
 
 #include <linux/of_platform.h>
 #include <sysdev/fsl_soc.h>
@@ -38,8 +37,6 @@ void __init corenet_gen_pic_init(void)
 	unsigned int flags = MPIC_BIG_ENDIAN | MPIC_SINGLE_DEST_CPU |
 		MPIC_NO_RESET;
 
-	struct device_node *np;
-
 	if (ppc_md.get_irq == mpic_get_coreint_irq)
 		flags |= MPIC_ENABLE_COREINT;
 
@@ -47,13 +44,6 @@ void __init corenet_gen_pic_init(void)
 	BUG_ON(mpic == NULL);
 
 	mpic_init(mpic);
-
-	np = of_find_compatible_node(NULL, NULL, "fsl,qe-ic");
-	if (np) {
-		qe_ic_init(np, 0, qe_ic_cascade_low_mpic,
-				qe_ic_cascade_high_mpic);
-		of_node_put(np);
-	}
 }
 
 /*
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_mds.c b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
index 5ca254256c47..4bc49e5ec0b6 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_mds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
@@ -45,7 +45,6 @@
 #include <sysdev/fsl_pci.h>
 #include <sysdev/simple_gpio.h>
 #include <soc/fsl/qe/qe.h>
-#include <soc/fsl/qe/qe_ic.h>
 #include <asm/mpic.h>
 #include <asm/swiotlb.h>
 #include "smp.h"
@@ -270,33 +269,8 @@ static void __init mpc85xx_mds_qe_init(void)
 	}
 }
 
-static void __init mpc85xx_mds_qeic_init(void)
-{
-	struct device_node *np;
-
-	np = of_find_compatible_node(NULL, NULL, "fsl,qe");
-	if (!of_device_is_available(np)) {
-		of_node_put(np);
-		return;
-	}
-
-	np = of_find_compatible_node(NULL, NULL, "fsl,qe-ic");
-	if (!np) {
-		np = of_find_node_by_type(NULL, "qeic");
-		if (!np)
-			return;
-	}
-
-	if (machine_is(p1021_mds))
-		qe_ic_init(np, 0, qe_ic_cascade_low_mpic,
-				qe_ic_cascade_high_mpic);
-	else
-		qe_ic_init(np, 0, qe_ic_cascade_muxed_mpic, NULL);
-	of_node_put(np);
-}
 #else
 static void __init mpc85xx_mds_qe_init(void) { }
-static void __init mpc85xx_mds_qeic_init(void) { }
 #endif	/* CONFIG_QUICC_ENGINE */
 
 static void __init mpc85xx_mds_setup_arch(void)
@@ -371,7 +345,6 @@ static void __init mpc85xx_mds_pic_init(void)
 	BUG_ON(mpic == NULL);
 
 	mpic_init(mpic);
-	mpc85xx_mds_qeic_init();
 }
 
 static int __init mpc85xx_mds_probe(void)
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
index d3c540ee558f..14b5a61d49c1 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
@@ -23,7 +23,6 @@
 #include <asm/udbg.h>
 #include <asm/mpic.h>
 #include <soc/fsl/qe/qe.h>
-#include <soc/fsl/qe/qe_ic.h>
 
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
@@ -44,10 +43,6 @@ void __init mpc85xx_rdb_pic_init(void)
 {
 	struct mpic *mpic;
 
-#ifdef CONFIG_QUICC_ENGINE
-	struct device_node *np;
-#endif
-
 	if (of_machine_is_compatible("fsl,MPC85XXRDB-CAMP")) {
 		mpic = mpic_alloc(NULL, 0, MPIC_NO_RESET |
 			MPIC_BIG_ENDIAN |
@@ -62,18 +57,6 @@ void __init mpc85xx_rdb_pic_init(void)
 
 	BUG_ON(mpic == NULL);
 	mpic_init(mpic);
-
-#ifdef CONFIG_QUICC_ENGINE
-	np = of_find_compatible_node(NULL, NULL, "fsl,qe-ic");
-	if (np) {
-		qe_ic_init(np, 0, qe_ic_cascade_low_mpic,
-				qe_ic_cascade_high_mpic);
-		of_node_put(np);
-
-	} else
-		pr_err("%s: Could not find qe-ic node\n", __func__);
-#endif
-
 }
 
 /*
diff --git a/arch/powerpc/platforms/85xx/twr_p102x.c b/arch/powerpc/platforms/85xx/twr_p102x.c
index 720b0c0f03ba..b099f5607120 100644
--- a/arch/powerpc/platforms/85xx/twr_p102x.c
+++ b/arch/powerpc/platforms/85xx/twr_p102x.c
@@ -19,7 +19,6 @@
 #include <asm/udbg.h>
 #include <asm/mpic.h>
 #include <soc/fsl/qe/qe.h>
-#include <soc/fsl/qe/qe_ic.h>
 
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
@@ -31,26 +30,12 @@ static void __init twr_p1025_pic_init(void)
 {
 	struct mpic *mpic;
 
-#ifdef CONFIG_QUICC_ENGINE
-	struct device_node *np;
-#endif
-
 	mpic = mpic_alloc(NULL, 0, MPIC_BIG_ENDIAN |
 			MPIC_SINGLE_DEST_CPU,
 			0, 256, " OpenPIC  ");
 
 	BUG_ON(mpic == NULL);
 	mpic_init(mpic);
-
-#ifdef CONFIG_QUICC_ENGINE
-	np = of_find_compatible_node(NULL, NULL, "fsl,qe-ic");
-	if (np) {
-		qe_ic_init(np, 0, qe_ic_cascade_low_mpic,
-				qe_ic_cascade_high_mpic);
-		of_node_put(np);
-	} else
-		pr_err("Could not find qe-ic node\n");
-#endif
 }
 
 /* ************************************************************************
diff --git a/drivers/soc/fsl/qe/qe_ic.c b/drivers/soc/fsl/qe/qe_ic.c
index f170926ce4d1..a062efac398b 100644
--- a/drivers/soc/fsl/qe/qe_ic.c
+++ b/drivers/soc/fsl/qe/qe_ic.c
@@ -314,10 +314,10 @@ unsigned int qe_ic_get_high_irq(struct qe_ic *qe_ic)
 	return irq_linear_revmap(qe_ic->irqhost, irq);
 }
 
-void __init qe_ic_init(struct device_node *node, unsigned int flags,
-		       void (*low_handler)(struct irq_desc *desc),
-		       void (*high_handler)(struct irq_desc *desc))
+static void __init qe_ic_init(struct device_node *node, unsigned int flags)
 {
+	void (*low_handler)(struct irq_desc *desc);
+	void (*high_handler)(struct irq_desc *desc);
 	struct qe_ic *qe_ic;
 	struct resource res;
 	u32 temp = 0, ret;
@@ -349,6 +349,13 @@ void __init qe_ic_init(struct device_node *node, unsigned int flags,
 		kfree(qe_ic);
 		return;
 	}
+	if (qe_ic->virq_high != qe_ic->virq_low) {
+		low_handler = qe_ic_cascade_low_mpic;
+		high_handler = qe_ic_cascade_high_mpic;
+	} else {
+		low_handler = qe_ic_cascade_muxed_mpic;
+		high_handler = NULL;
+	}
 
 	/* default priority scheme is grouped. If spread mode is    */
 	/* required, configure cicr accordingly.                    */
@@ -381,6 +388,22 @@ void __init qe_ic_init(struct device_node *node, unsigned int flags,
 	}
 }
 
+static int __init qe_ic_of_init(void)
+{
+	struct device_node *np;
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,qe-ic");
+	if (!np) {
+		np = of_find_node_by_type(NULL, "qeic");
+		if (!np)
+			return -ENODEV;
+	}
+	qe_ic_init(np, 0);
+	of_node_put(np);
+	return 0;
+}
+subsys_initcall(qe_ic_of_init);
+
 void qe_ic_set_highest_priority(unsigned int virq, int high)
 {
 	struct qe_ic *qe_ic = qe_ic_from_irq(virq);
diff --git a/include/soc/fsl/qe/qe_ic.h b/include/soc/fsl/qe/qe_ic.h
index bfaa233d8328..a47a0d26acbd 100644
--- a/include/soc/fsl/qe/qe_ic.h
+++ b/include/soc/fsl/qe/qe_ic.h
@@ -54,16 +54,9 @@ enum qe_ic_grp_id {
 };
 
 #ifdef CONFIG_QUICC_ENGINE
-void qe_ic_init(struct device_node *node, unsigned int flags,
-		void (*low_handler)(struct irq_desc *desc),
-		void (*high_handler)(struct irq_desc *desc));
 unsigned int qe_ic_get_low_irq(struct qe_ic *qe_ic);
 unsigned int qe_ic_get_high_irq(struct qe_ic *qe_ic);
 #else
-static inline void qe_ic_init(struct device_node *node, unsigned int flags,
-		void (*low_handler)(struct irq_desc *desc),
-		void (*high_handler)(struct irq_desc *desc))
-{}
 static inline unsigned int qe_ic_get_low_irq(struct qe_ic *qe_ic)
 { return 0; }
 static inline unsigned int qe_ic_get_high_irq(struct qe_ic *qe_ic)
-- 
2.23.0

