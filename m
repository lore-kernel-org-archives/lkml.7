Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B68ABC5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 13:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 816D42085B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 13:04:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="bDajsWfp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbfKHNEL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 08:04:11 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36704 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728568AbfKHNBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 08:01:54 -0500
Received: by mail-lj1-f194.google.com with SMTP id k15so6145199lja.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 05:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E9MniY1Iee5HGhOe/xollIck0/KPXWyQbXSm1b3gOvo=;
        b=bDajsWfplKpWFRgWa9+5AcH5s7mUz+tVMUeaGmAnvs5lygB0KRw7gr+WcsNLD3m45P
         OesGBRU+qKygYqbmr7NvuAz/1ADHbOQOtfbg6TDLC3bz0eJkZBjhtqcGfNWNP2qQPqb6
         Nx8PqBDNb/gTB/zdoksaHza3n6jEEkzx8ZNfk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E9MniY1Iee5HGhOe/xollIck0/KPXWyQbXSm1b3gOvo=;
        b=PC3QlRM3f63CPW2H52aDZQ/ptTEP+eUtLZUm/JnkRc0litIF7IKs3GqHD+YyzChB5W
         4TOHr1fOBKCkfxuNDnRZ0vd53wPL7bdseXC5PCA0LsZVr7Y7vgjNSSyrToSM8wxY3H9G
         pq5ueBM9Y1NFBk3dh0aFurNkeoW5fR1AK9M1fiFSFn1vVK0vvbvkqefypbnX3Ebw+KV7
         mFDHntuin8LgfdIozWGkStBNgvQSaGS8TSr1VrHZxYbvTX8b9p7lw2II+QhxpOPsrzyk
         OEi8M573ynmmeOadrLUesHpwxH4OHiIE/ayhn75W+LbBbwlgF0zqctpkNNov7G1dSskd
         bOqg==
X-Gm-Message-State: APjAAAXFM29gxqxJZWErlQIDAjjNcQwsWeFE6PhyUufeqlQOxdEtTJsm
        VyjkqVr86d6BnnZN08gh+YlEeg==
X-Google-Smtp-Source: APXvYqyKyV6JCnPD+aPYjT+LGUqDe3jck22G3eNjzM5okv/Y25KvJX+MpQ3r3uUDO8m/KbOIvP1OsA==
X-Received: by 2002:a2e:994f:: with SMTP id r15mr6795909ljj.18.1573218111413;
        Fri, 08 Nov 2019 05:01:51 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id d28sm2454725lfn.33.2019.11.08.05.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 05:01:50 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v4 18/47] soc: fsl: qe: don't use NO_IRQ in qe_ic.c
Date:   Fri,  8 Nov 2019 14:00:54 +0100
Message-Id: <20191108130123.6839-19-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191108130123.6839-1-linux@rasmusvillemoes.dk>
References: <20191108130123.6839-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver is currently PPC-only, and on powerpc, NO_IRQ is 0, so
this doesn't change functionality. However, not every architecture
defines NO_IRQ, and some define it as -1, so the detection of a failed
irq_of_parse_and_map() (which returns 0 on failure) would be wrong on
those. So to prepare for allowing this driver to build on other
architectures, drop all references to NO_IRQ.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/soc/fsl/qe/qe_ic.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/soc/fsl/qe/qe_ic.c b/drivers/soc/fsl/qe/qe_ic.c
index 4839dcd5c5d3..8f74bc6efd5c 100644
--- a/drivers/soc/fsl/qe/qe_ic.c
+++ b/drivers/soc/fsl/qe/qe_ic.c
@@ -282,7 +282,7 @@ static const struct irq_domain_ops qe_ic_host_ops = {
 	.xlate = irq_domain_xlate_onetwocell,
 };
 
-/* Return an interrupt vector or NO_IRQ if no interrupt is pending. */
+/* Return an interrupt vector or 0 if no interrupt is pending. */
 unsigned int qe_ic_get_low_irq(struct qe_ic *qe_ic)
 {
 	int irq;
@@ -293,12 +293,12 @@ unsigned int qe_ic_get_low_irq(struct qe_ic *qe_ic)
 	irq = qe_ic_read(qe_ic->regs, QEIC_CIVEC) >> 26;
 
 	if (irq == 0)
-		return NO_IRQ;
+		return 0;
 
 	return irq_linear_revmap(qe_ic->irqhost, irq);
 }
 
-/* Return an interrupt vector or NO_IRQ if no interrupt is pending. */
+/* Return an interrupt vector or 0 if no interrupt is pending. */
 unsigned int qe_ic_get_high_irq(struct qe_ic *qe_ic)
 {
 	int irq;
@@ -309,7 +309,7 @@ unsigned int qe_ic_get_high_irq(struct qe_ic *qe_ic)
 	irq = qe_ic_read(qe_ic->regs, QEIC_CHIVEC) >> 26;
 
 	if (irq == 0)
-		return NO_IRQ;
+		return 0;
 
 	return irq_linear_revmap(qe_ic->irqhost, irq);
 }
@@ -320,7 +320,7 @@ static void qe_ic_cascade_low(struct irq_desc *desc)
 	unsigned int cascade_irq = qe_ic_get_low_irq(qe_ic);
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 
-	if (cascade_irq != NO_IRQ)
+	if (cascade_irq != 0)
 		generic_handle_irq(cascade_irq);
 
 	if (chip->irq_eoi)
@@ -333,7 +333,7 @@ static void qe_ic_cascade_high(struct irq_desc *desc)
 	unsigned int cascade_irq = qe_ic_get_high_irq(qe_ic);
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 
-	if (cascade_irq != NO_IRQ)
+	if (cascade_irq != 0)
 		generic_handle_irq(cascade_irq);
 
 	if (chip->irq_eoi)
@@ -347,10 +347,10 @@ static void qe_ic_cascade_muxed_mpic(struct irq_desc *desc)
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 
 	cascade_irq = qe_ic_get_high_irq(qe_ic);
-	if (cascade_irq == NO_IRQ)
+	if (cascade_irq == 0)
 		cascade_irq = qe_ic_get_low_irq(qe_ic);
 
-	if (cascade_irq != NO_IRQ)
+	if (cascade_irq != 0)
 		generic_handle_irq(cascade_irq);
 
 	chip->irq_eoi(&desc->irq_data);
@@ -386,7 +386,7 @@ static void __init qe_ic_init(struct device_node *node, unsigned int flags)
 	qe_ic->virq_high = irq_of_parse_and_map(node, 0);
 	qe_ic->virq_low = irq_of_parse_and_map(node, 1);
 
-	if (qe_ic->virq_low == NO_IRQ) {
+	if (!qe_ic->virq_low) {
 		printk(KERN_ERR "Failed to map QE_IC low IRQ\n");
 		kfree(qe_ic);
 		return;
@@ -423,8 +423,7 @@ static void __init qe_ic_init(struct device_node *node, unsigned int flags)
 	irq_set_handler_data(qe_ic->virq_low, qe_ic);
 	irq_set_chained_handler(qe_ic->virq_low, low_handler);
 
-	if (qe_ic->virq_high != NO_IRQ &&
-			qe_ic->virq_high != qe_ic->virq_low) {
+	if (qe_ic->virq_high && qe_ic->virq_high != qe_ic->virq_low) {
 		irq_set_handler_data(qe_ic->virq_high, qe_ic);
 		irq_set_chained_handler(qe_ic->virq_high, high_handler);
 	}
-- 
2.23.0

