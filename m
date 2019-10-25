Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2692BCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 12:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8A8021D81
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 12:41:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="bUV9btda"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504533AbfJYMl2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 08:41:28 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35012 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440335AbfJYMlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 08:41:18 -0400
Received: by mail-lj1-f194.google.com with SMTP id m7so2562612lji.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 05:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JPHV3mej2fB3lfgpw6935p5PEecuoQPDNdhF76v2gl8=;
        b=bUV9btdaAbzUUTulPviXAiFJt/y5HiDckg3QQcNHdMMTPKSZXLyWUK3836LOYGb7Ea
         6GmnHFLcUm0wi8jumB9dZrLNJFjZxmWysv2eijZsaYD6IICV3GFXl+tWby9zUqTAO80f
         WoXVMlRuYnw6c0MygecBezz9FUnOgzFwnDlLA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JPHV3mej2fB3lfgpw6935p5PEecuoQPDNdhF76v2gl8=;
        b=Nv6LNartC+oyvCPZ4OZOBdRtVcDGtdvw2SfT6ffLI2bufL4RVyFqyB6sPi9QHufVrk
         HHVM2BZcFapMoSPLITOcAbDx6mLdsOXRHrA0amxhvkksxbLvDzKpUhUhJAyrgOJWicUv
         26DD33e8WaP6OVXfhMlmgnKoZkeoHEOsCrtNK53hNXGgYe/lIigCmmSKfEkfT769OOYu
         3PE508vh+8GGyqunaIHr9dmAztRKvEPO1GR1S3CMycSXdAUDuszJCA2s8K9AMYwV1f7N
         N8DWM6E13J3lJIyWbmYsVnIwifxQNwqPEZdu4ogLIhqOkL/puURD8WmCL9y+m/RPzdGR
         4Ilg==
X-Gm-Message-State: APjAAAVx5DDEhkXB55xizmJOekfT/XasZJpZjh0HoEaoms1BHNu5QImh
        7bPTSexucswqJzvHuq52Uekoqw==
X-Google-Smtp-Source: APXvYqw/oNpSoGf0HychWr3zkFhvDIDZp39aOxLLA4Y37BiJRnhMt3VbkvqipDKWR/80GLP4Dk3rpA==
X-Received: by 2002:a2e:9058:: with SMTP id n24mr2360035ljg.114.1572007276785;
        Fri, 25 Oct 2019 05:41:16 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id 10sm821028lfy.57.2019.10.25.05.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 05:41:16 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>,
        Valentin Longchamp <valentin.longchamp@keymile.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v2 11/23] soc: fsl: qe: rename qe_ic_cascade_low_mpic -> qe_ic_cascade_low
Date:   Fri, 25 Oct 2019 14:40:46 +0200
Message-Id: <20191025124058.22580-12-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191025124058.22580-1-linux@rasmusvillemoes.dk>
References: <20191018125234.21825-1-linux@rasmusvillemoes.dk>
 <20191025124058.22580-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The qe_ic_cascade_{low,high}_mpic functions are now used as handlers
both when the interrupt parent is mpic as well as ipic, so remove the
_mpic suffix.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 arch/powerpc/platforms/83xx/misc.c            | 2 +-
 arch/powerpc/platforms/85xx/corenet_generic.c | 4 ++--
 arch/powerpc/platforms/85xx/mpc85xx_mds.c     | 4 ++--
 arch/powerpc/platforms/85xx/mpc85xx_rdb.c     | 4 ++--
 arch/powerpc/platforms/85xx/twr_p102x.c       | 4 ++--
 drivers/soc/fsl/qe/qe_ic.c                    | 4 ++--
 include/soc/fsl/qe/qe_ic.h                    | 4 ++--
 7 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/platforms/83xx/misc.c b/arch/powerpc/platforms/83xx/misc.c
index 779791c0570f..835d082218ae 100644
--- a/arch/powerpc/platforms/83xx/misc.c
+++ b/arch/powerpc/platforms/83xx/misc.c
@@ -100,7 +100,7 @@ void __init mpc83xx_qe_init_IRQ(void)
 		if (!np)
 			return;
 	}
-	qe_ic_init(np, 0, qe_ic_cascade_low_mpic, qe_ic_cascade_high_mpic);
+	qe_ic_init(np, 0, qe_ic_cascade_low, qe_ic_cascade_high);
 	of_node_put(np);
 }
 
diff --git a/arch/powerpc/platforms/85xx/corenet_generic.c b/arch/powerpc/platforms/85xx/corenet_generic.c
index 7ee2c6628f64..2ed9e84ca03a 100644
--- a/arch/powerpc/platforms/85xx/corenet_generic.c
+++ b/arch/powerpc/platforms/85xx/corenet_generic.c
@@ -50,8 +50,8 @@ void __init corenet_gen_pic_init(void)
 
 	np = of_find_compatible_node(NULL, NULL, "fsl,qe-ic");
 	if (np) {
-		qe_ic_init(np, 0, qe_ic_cascade_low_mpic,
-				qe_ic_cascade_high_mpic);
+		qe_ic_init(np, 0, qe_ic_cascade_low,
+				qe_ic_cascade_high);
 		of_node_put(np);
 	}
 }
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_mds.c b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
index 5ca254256c47..24211a1787b2 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_mds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
@@ -288,8 +288,8 @@ static void __init mpc85xx_mds_qeic_init(void)
 	}
 
 	if (machine_is(p1021_mds))
-		qe_ic_init(np, 0, qe_ic_cascade_low_mpic,
-				qe_ic_cascade_high_mpic);
+		qe_ic_init(np, 0, qe_ic_cascade_low,
+				qe_ic_cascade_high);
 	else
 		qe_ic_init(np, 0, qe_ic_cascade_muxed_mpic, NULL);
 	of_node_put(np);
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
index d3c540ee558f..093867879081 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
@@ -66,8 +66,8 @@ void __init mpc85xx_rdb_pic_init(void)
 #ifdef CONFIG_QUICC_ENGINE
 	np = of_find_compatible_node(NULL, NULL, "fsl,qe-ic");
 	if (np) {
-		qe_ic_init(np, 0, qe_ic_cascade_low_mpic,
-				qe_ic_cascade_high_mpic);
+		qe_ic_init(np, 0, qe_ic_cascade_low,
+				qe_ic_cascade_high);
 		of_node_put(np);
 
 	} else
diff --git a/arch/powerpc/platforms/85xx/twr_p102x.c b/arch/powerpc/platforms/85xx/twr_p102x.c
index 720b0c0f03ba..2e0fb23854c0 100644
--- a/arch/powerpc/platforms/85xx/twr_p102x.c
+++ b/arch/powerpc/platforms/85xx/twr_p102x.c
@@ -45,8 +45,8 @@ static void __init twr_p1025_pic_init(void)
 #ifdef CONFIG_QUICC_ENGINE
 	np = of_find_compatible_node(NULL, NULL, "fsl,qe-ic");
 	if (np) {
-		qe_ic_init(np, 0, qe_ic_cascade_low_mpic,
-				qe_ic_cascade_high_mpic);
+		qe_ic_init(np, 0, qe_ic_cascade_low,
+				qe_ic_cascade_high);
 		of_node_put(np);
 	} else
 		pr_err("Could not find qe-ic node\n");
diff --git a/drivers/soc/fsl/qe/qe_ic.c b/drivers/soc/fsl/qe/qe_ic.c
index 0ff802816c0c..f3659c312e13 100644
--- a/drivers/soc/fsl/qe/qe_ic.c
+++ b/drivers/soc/fsl/qe/qe_ic.c
@@ -402,7 +402,7 @@ unsigned int qe_ic_get_high_irq(struct qe_ic *qe_ic)
 	return irq_linear_revmap(qe_ic->irqhost, irq);
 }
 
-void qe_ic_cascade_low_mpic(struct irq_desc *desc)
+void qe_ic_cascade_low(struct irq_desc *desc)
 {
 	struct qe_ic *qe_ic = irq_desc_get_handler_data(desc);
 	unsigned int cascade_irq = qe_ic_get_low_irq(qe_ic);
@@ -415,7 +415,7 @@ void qe_ic_cascade_low_mpic(struct irq_desc *desc)
 		chip->irq_eoi(&desc->irq_data);
 }
 
-void qe_ic_cascade_high_mpic(struct irq_desc *desc)
+void qe_ic_cascade_high(struct irq_desc *desc)
 {
 	struct qe_ic *qe_ic = irq_desc_get_handler_data(desc);
 	unsigned int cascade_irq = qe_ic_get_high_irq(qe_ic);
diff --git a/include/soc/fsl/qe/qe_ic.h b/include/soc/fsl/qe/qe_ic.h
index fb10a7606acc..3c8220cedd9a 100644
--- a/include/soc/fsl/qe/qe_ic.h
+++ b/include/soc/fsl/qe/qe_ic.h
@@ -74,8 +74,8 @@ void qe_ic_set_highest_priority(unsigned int virq, int high);
 int qe_ic_set_priority(unsigned int virq, unsigned int priority);
 int qe_ic_set_high_priority(unsigned int virq, unsigned int priority, int high);
 
-void qe_ic_cascade_low_mpic(struct irq_desc *desc);
-void qe_ic_cascade_high_mpic(struct irq_desc *desc);
+void qe_ic_cascade_low(struct irq_desc *desc);
+void qe_ic_cascade_high(struct irq_desc *desc);
 void qe_ic_cascade_muxed_mpic(struct irq_desc *desc);
 
 #endif /* _ASM_POWERPC_QE_IC_H */
-- 
2.23.0

