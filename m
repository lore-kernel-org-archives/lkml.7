Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F397EC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 11:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C23CB2087E
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 11:10:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730051AbfHALJ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 07:09:59 -0400
Received: from smtp05.smtpout.orange.fr ([80.12.242.127]:23949 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfHALJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 07:09:59 -0400
Received: from localhost.localdomain ([176.167.121.156])
        by mwinf5d09 with ME
        id jn9q200093NZnML03n9qj6; Thu, 01 Aug 2019 13:09:56 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 01 Aug 2019 13:09:56 +0200
X-ME-IP: 176.167.121.156
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
        allison@lohutok.net, tglx@linutronix.de, clg@kaod.org,
        groug@kaod.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] powerpc/xive: Add some error handling code to 'xive_spapr_init()'
Date:   Thu,  1 Aug 2019 13:09:56 +0200
Message-Id: <20190801110956.8517-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'xive_irq_bitmap_add()' can return -ENOMEM.
In this case, we should free the memory already allocated and return
'false' to the caller.

Also add an error path which undoes the 'tima = ioremap(...)'

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
NOT compile tested (I don't have a cross compiler and won't install one).
So if some correction or improvement are needed, feel free to propose and
commit it directly.
---
 arch/powerpc/sysdev/xive/spapr.c | 36 +++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/sysdev/xive/spapr.c b/arch/powerpc/sysdev/xive/spapr.c
index 52198131c75e..b3ae0b76c433 100644
--- a/arch/powerpc/sysdev/xive/spapr.c
+++ b/arch/powerpc/sysdev/xive/spapr.c
@@ -64,6 +64,17 @@ static int xive_irq_bitmap_add(int base, int count)
 	return 0;
 }
 
+static void xive_irq_bitmap_remove_all(void)
+{
+	struct xive_irq_bitmap *xibm, *tmp;
+
+	list_for_each_entry_safe(xibm, tmp, &xive_irq_bitmaps, list) {
+		list_del(&xibm->list);
+		kfree(xibm->bitmap);
+		kfree(xibm);
+	}
+}
+
 static int __xive_irq_bitmap_alloc(struct xive_irq_bitmap *xibm)
 {
 	int irq;
@@ -723,7 +734,7 @@ bool __init xive_spapr_init(void)
 	u32 val;
 	u32 len;
 	const __be32 *reg;
-	int i;
+	int i, err;
 
 	if (xive_spapr_disabled())
 		return false;
@@ -748,23 +759,26 @@ bool __init xive_spapr_init(void)
 	}
 
 	if (!xive_get_max_prio(&max_prio))
-		return false;
+		goto err_unmap;
 
 	/* Feed the IRQ number allocator with the ranges given in the DT */
 	reg = of_get_property(np, "ibm,xive-lisn-ranges", &len);
 	if (!reg) {
 		pr_err("Failed to read 'ibm,xive-lisn-ranges' property\n");
-		return false;
+		goto err_unmap;
 	}
 
 	if (len % (2 * sizeof(u32)) != 0) {
 		pr_err("invalid 'ibm,xive-lisn-ranges' property\n");
-		return false;
+		goto err_unmap;
 	}
 
-	for (i = 0; i < len / (2 * sizeof(u32)); i++, reg += 2)
-		xive_irq_bitmap_add(be32_to_cpu(reg[0]),
-				    be32_to_cpu(reg[1]));
+	for (i = 0; i < len / (2 * sizeof(u32)); i++, reg += 2) {
+		err = xive_irq_bitmap_add(be32_to_cpu(reg[0]),
+					  be32_to_cpu(reg[1]));
+		if (err < 0)
+			goto err_mem_free;
+	}
 
 	/* Iterate the EQ sizes and pick one */
 	of_property_for_each_u32(np, "ibm,xive-eq-sizes", prop, reg, val) {
@@ -775,8 +789,14 @@ bool __init xive_spapr_init(void)
 
 	/* Initialize XIVE core with our backend */
 	if (!xive_core_init(&xive_spapr_ops, tima, TM_QW1_OS, max_prio))
-		return false;
+		goto err_mem_free;
 
 	pr_info("Using %dkB queues\n", 1 << (xive_queue_shift - 10));
 	return true;
+
+err_mem_free:
+	xive_irq_bitmap_remove_all();
+err_unmap:
+	iounmap(tima);
+	return false;
 }
-- 
2.20.1

