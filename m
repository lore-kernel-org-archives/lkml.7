Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3510BC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 11:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15D72214E0
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 11:08:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393149AbfIFLIk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 07:08:40 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47068 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392362AbfIFLIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 07:08:31 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i6C6N-00077J-8o; Fri, 06 Sep 2019 13:08:27 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id B372C1C0E26;
        Fri,  6 Sep 2019 13:08:16 +0200 (CEST)
Date:   Fri, 06 Sep 2019 11:08:16 -0000
From:   "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/gic-v3: Dynamically allocate PPI partition
 descriptors
Cc:     Marc Zyngier <maz@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <156776809671.24167.4067545080989857248.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     52085d3f2028d853f8d6ce7ead2f8a504f6077fa
Gitweb:        https://git.kernel.org/tip/52085d3f2028d853f8d6ce7ead2f8a504f6077fa
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Thu, 18 Jul 2019 13:05:17 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Tue, 20 Aug 2019 10:23:34 +01:00

irqchip/gic-v3: Dynamically allocate PPI partition descriptors

Again, PPIs are becoming a variable set. Let's hack the PPI partition
code to make the top-level array dynamically allocated.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v3.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 869a805..f5dbdbf 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -52,7 +52,7 @@ struct gic_chip_data {
 	u64			flags;
 	bool			has_rss;
 	unsigned int		ppi_nr;
-	struct partition_desc	*ppi_descs[16];
+	struct partition_desc	**ppi_descs;
 };
 
 static struct gic_chip_data gic_data __read_mostly;
@@ -1354,7 +1354,8 @@ static int gic_irq_domain_select(struct irq_domain *d,
 	 * then we need to match the partition domain.
 	 */
 	if (fwspec->param_count >= 4 &&
-	    fwspec->param[0] == 1 && fwspec->param[3] != 0)
+	    fwspec->param[0] == 1 && fwspec->param[3] != 0 &&
+	    gic_data.ppi_descs)
 		return d == partition_get_domain(gic_data.ppi_descs[fwspec->param[1]]);
 
 	return d == gic_data.domain;
@@ -1375,6 +1376,9 @@ static int partition_domain_translate(struct irq_domain *d,
 	struct device_node *np;
 	int ret;
 
+	if (!gic_data.ppi_descs)
+		return -ENOMEM;
+
 	np = of_find_node_by_phandle(fwspec->param[3]);
 	if (WARN_ON(!np))
 		return -EINVAL;
@@ -1531,6 +1535,10 @@ static void __init gic_populate_ppi_partitions(struct device_node *gic_node)
 	if (!parts_node)
 		return;
 
+	gic_data.ppi_descs = kcalloc(gic_data.ppi_nr, sizeof(*gic_data.ppi_descs), GFP_KERNEL);
+	if (!gic_data.ppi_descs)
+		return;
+
 	nr_parts = of_get_child_count(parts_node);
 
 	if (!nr_parts)
@@ -1582,7 +1590,7 @@ static void __init gic_populate_ppi_partitions(struct device_node *gic_node)
 		part_idx++;
 	}
 
-	for (i = 0; i < 16; i++) {
+	for (i = 0; i < gic_data.ppi_nr; i++) {
 		unsigned int irq;
 		struct partition_desc *desc;
 		struct irq_fwspec ppi_fwspec = {
