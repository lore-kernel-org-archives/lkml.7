Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B434EC04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 11:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93FA32146F
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 11:57:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbfE0L5r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 07:57:47 -0400
Received: from albert.telenet-ops.be ([195.130.137.90]:51088 "EHLO
        albert.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbfE0L5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 07:57:47 -0400
Received: from ramsan ([84.194.111.163])
        by albert.telenet-ops.be with bizsmtp
        id HPxl200053XaVaC06Pxlzt; Mon, 27 May 2019 13:57:45 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hVEG9-0001Op-2Q; Mon, 27 May 2019 13:57:45 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hVEG9-0000jO-0u; Mon, 27 May 2019 13:57:45 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] genirq/irqdomain: Remove WARN_ON() on out-of-memory condition
Date:   Mon, 27 May 2019 13:57:42 +0200
Message-Id: <20190527115742.2693-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to print a backtrace when memory allocation fails, as
the memory allocation core already takes care of that.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 kernel/irq/irqdomain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index a453e229f99caf40..e7d17cc3a3d7bb76 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -139,7 +139,7 @@ struct irq_domain *__irq_domain_add(struct fwnode_handle *fwnode, int size,
 
 	domain = kzalloc_node(sizeof(*domain) + (sizeof(unsigned int) * size),
 			      GFP_KERNEL, of_node_to_nid(of_node));
-	if (WARN_ON(!domain))
+	if (!domain)
 		return NULL;
 
 	if (fwnode && is_fwnode_irqchip(fwnode)) {
-- 
2.17.1

