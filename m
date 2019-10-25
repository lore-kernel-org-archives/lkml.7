Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53F35CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 12:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FE0721D7B
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 12:42:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="RkT8iPQG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504615AbfJYMmj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 08:42:39 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43871 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440328AbfJYMlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 08:41:17 -0400
Received: by mail-lj1-f195.google.com with SMTP id s4so1662969ljj.10
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 05:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1cMUUEEaqLgFID6Rj+SOVy/wiDu2Od0ETCBosPApTXM=;
        b=RkT8iPQGc64p6Dti5IejG1G8J3GY7xJjHLBh9m/iqrMosaYO0iEp2O2kheCemPguID
         Yj8DB2aRS/LT/vf2lao7eSjn2FQcUy+SP5Y+bwJI5sf0f//E/YWFUujVzRv7VwkH3r8X
         WdFSP6vBfURbbrKxiSSmo+C0sAWmb2EBgF6oU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1cMUUEEaqLgFID6Rj+SOVy/wiDu2Od0ETCBosPApTXM=;
        b=UGYuGaI60uiQKQ9LJ+lawQtpsNG6Rw7fv65y285FnL8zfkRfCGBs4urebnkUxU2pku
         2NFXl/jHSD7oJmblikmRVCLR0eLb2RK5x7dqzy+uTh8OTK9k3d8V/33i8YNCH4hL/3Pt
         O9WszP70rhKycXGdFf9m/N4clURn3aYxJF+xM+isv2CEYcfx2V9jscNolc70ZjfWBHyo
         ry65jYN6Cqi79Qfx0pPBosj4vHnoSDAKK/jXw7SoI2hUkoL5JbALcn7/DWMVKIYv5CXw
         iQKUuhNH/vMbSRd+Gz+9P/dGxRjhKzGahSTDu4Sb4J25sw2WjBNd+puTH3GBXG2YAPjw
         iJ/w==
X-Gm-Message-State: APjAAAVmX+p3BTz4zaPxrZ7+D6DauNQ9RYNQVgmNRzRq37gtahZJ2RK6
        py+akgQpqmMPt5lneJ0cSzGdjA==
X-Google-Smtp-Source: APXvYqwZKDa09TpRzvgnaDL2KQpgsamPI5WzmMdwjrYiCBoRb24b5RkaOwqC9NeA4wCbQ+UZAxCzKA==
X-Received: by 2002:a2e:8793:: with SMTP id n19mr2255901lji.139.1572007274261;
        Fri, 25 Oct 2019 05:41:14 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id 10sm821028lfy.57.2019.10.25.05.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 05:41:13 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>,
        Valentin Longchamp <valentin.longchamp@keymile.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v2 09/23] soc: fsl: qe: move qe_ic_cascade_* functions to qe_ic.c
Date:   Fri, 25 Oct 2019 14:40:44 +0200
Message-Id: <20191025124058.22580-10-linux@rasmusvillemoes.dk>
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

These functions are only ever called through a function pointer, and
therefore it makes no sense for them to be "static inline" - gcc has
no choice but to emit a copy in each translation unit that takes the
address of one of these (currently various platform code under
arch/powerpc/). So move them into qe_ic.c and leave ordinary extern
declarations in the header file.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/soc/fsl/qe/qe_ic.c | 58 +++++++++++++++++++++++++++++++++++
 include/soc/fsl/qe/qe_ic.h | 62 +++-----------------------------------
 2 files changed, 63 insertions(+), 57 deletions(-)

diff --git a/drivers/soc/fsl/qe/qe_ic.c b/drivers/soc/fsl/qe/qe_ic.c
index 7b1870d2866a..a847b2672e90 100644
--- a/drivers/soc/fsl/qe/qe_ic.c
+++ b/drivers/soc/fsl/qe/qe_ic.c
@@ -402,6 +402,64 @@ unsigned int qe_ic_get_high_irq(struct qe_ic *qe_ic)
 	return irq_linear_revmap(qe_ic->irqhost, irq);
 }
 
+void qe_ic_cascade_low_ipic(struct irq_desc *desc)
+{
+	struct qe_ic *qe_ic = irq_desc_get_handler_data(desc);
+	unsigned int cascade_irq = qe_ic_get_low_irq(qe_ic);
+
+	if (cascade_irq != NO_IRQ)
+		generic_handle_irq(cascade_irq);
+}
+
+void qe_ic_cascade_high_ipic(struct irq_desc *desc)
+{
+	struct qe_ic *qe_ic = irq_desc_get_handler_data(desc);
+	unsigned int cascade_irq = qe_ic_get_high_irq(qe_ic);
+
+	if (cascade_irq != NO_IRQ)
+		generic_handle_irq(cascade_irq);
+}
+
+void qe_ic_cascade_low_mpic(struct irq_desc *desc)
+{
+	struct qe_ic *qe_ic = irq_desc_get_handler_data(desc);
+	unsigned int cascade_irq = qe_ic_get_low_irq(qe_ic);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+
+	if (cascade_irq != NO_IRQ)
+		generic_handle_irq(cascade_irq);
+
+	chip->irq_eoi(&desc->irq_data);
+}
+
+void qe_ic_cascade_high_mpic(struct irq_desc *desc)
+{
+	struct qe_ic *qe_ic = irq_desc_get_handler_data(desc);
+	unsigned int cascade_irq = qe_ic_get_high_irq(qe_ic);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+
+	if (cascade_irq != NO_IRQ)
+		generic_handle_irq(cascade_irq);
+
+	chip->irq_eoi(&desc->irq_data);
+}
+
+void qe_ic_cascade_muxed_mpic(struct irq_desc *desc)
+{
+	struct qe_ic *qe_ic = irq_desc_get_handler_data(desc);
+	unsigned int cascade_irq;
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+
+	cascade_irq = qe_ic_get_high_irq(qe_ic);
+	if (cascade_irq == NO_IRQ)
+		cascade_irq = qe_ic_get_low_irq(qe_ic);
+
+	if (cascade_irq != NO_IRQ)
+		generic_handle_irq(cascade_irq);
+
+	chip->irq_eoi(&desc->irq_data);
+}
+
 void __init qe_ic_init(struct device_node *node, unsigned int flags,
 		       void (*low_handler)(struct irq_desc *desc),
 		       void (*high_handler)(struct irq_desc *desc))
diff --git a/include/soc/fsl/qe/qe_ic.h b/include/soc/fsl/qe/qe_ic.h
index 714a9b890d8d..f3492eb13052 100644
--- a/include/soc/fsl/qe/qe_ic.h
+++ b/include/soc/fsl/qe/qe_ic.h
@@ -74,62 +74,10 @@ void qe_ic_set_highest_priority(unsigned int virq, int high);
 int qe_ic_set_priority(unsigned int virq, unsigned int priority);
 int qe_ic_set_high_priority(unsigned int virq, unsigned int priority, int high);
 
-static inline void qe_ic_cascade_low_ipic(struct irq_desc *desc)
-{
-	struct qe_ic *qe_ic = irq_desc_get_handler_data(desc);
-	unsigned int cascade_irq = qe_ic_get_low_irq(qe_ic);
-
-	if (cascade_irq != NO_IRQ)
-		generic_handle_irq(cascade_irq);
-}
-
-static inline void qe_ic_cascade_high_ipic(struct irq_desc *desc)
-{
-	struct qe_ic *qe_ic = irq_desc_get_handler_data(desc);
-	unsigned int cascade_irq = qe_ic_get_high_irq(qe_ic);
-
-	if (cascade_irq != NO_IRQ)
-		generic_handle_irq(cascade_irq);
-}
-
-static inline void qe_ic_cascade_low_mpic(struct irq_desc *desc)
-{
-	struct qe_ic *qe_ic = irq_desc_get_handler_data(desc);
-	unsigned int cascade_irq = qe_ic_get_low_irq(qe_ic);
-	struct irq_chip *chip = irq_desc_get_chip(desc);
-
-	if (cascade_irq != NO_IRQ)
-		generic_handle_irq(cascade_irq);
-
-	chip->irq_eoi(&desc->irq_data);
-}
-
-static inline void qe_ic_cascade_high_mpic(struct irq_desc *desc)
-{
-	struct qe_ic *qe_ic = irq_desc_get_handler_data(desc);
-	unsigned int cascade_irq = qe_ic_get_high_irq(qe_ic);
-	struct irq_chip *chip = irq_desc_get_chip(desc);
-
-	if (cascade_irq != NO_IRQ)
-		generic_handle_irq(cascade_irq);
-
-	chip->irq_eoi(&desc->irq_data);
-}
-
-static inline void qe_ic_cascade_muxed_mpic(struct irq_desc *desc)
-{
-	struct qe_ic *qe_ic = irq_desc_get_handler_data(desc);
-	unsigned int cascade_irq;
-	struct irq_chip *chip = irq_desc_get_chip(desc);
-
-	cascade_irq = qe_ic_get_high_irq(qe_ic);
-	if (cascade_irq == NO_IRQ)
-		cascade_irq = qe_ic_get_low_irq(qe_ic);
-
-	if (cascade_irq != NO_IRQ)
-		generic_handle_irq(cascade_irq);
-
-	chip->irq_eoi(&desc->irq_data);
-}
+void qe_ic_cascade_low_ipic(struct irq_desc *desc);
+void qe_ic_cascade_high_ipic(struct irq_desc *desc);
+void qe_ic_cascade_low_mpic(struct irq_desc *desc);
+void qe_ic_cascade_high_mpic(struct irq_desc *desc);
+void qe_ic_cascade_muxed_mpic(struct irq_desc *desc);
 
 #endif /* _ASM_POWERPC_QE_IC_H */
-- 
2.23.0

