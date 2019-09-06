Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7885C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 11:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB939208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 11:09:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403873AbfIFLJU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 07:09:20 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47086 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392393AbfIFLIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 07:08:34 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i6C6R-0007AJ-2j; Fri, 06 Sep 2019 13:08:31 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 84F291C0E2C;
        Fri,  6 Sep 2019 13:08:17 +0200 (CEST)
Date:   Fri, 06 Sep 2019 11:08:17 -0000
From:   "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqdomain/debugfs: Use PAs to generate fwnode names
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <156776809750.24167.8355011487380954374.tip-bot2@tip-bot2>
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

Commit-ID:     b977fcf477c176e5f41775f0ea139f935b0f25b7
Gitweb:        https://git.kernel.org/tip/b977fcf477c176e5f41775f0ea139f935b0f25b7
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Wed, 31 Jul 2019 15:13:19 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 07 Aug 2019 14:24:54 +01:00

irqdomain/debugfs: Use PAs to generate fwnode names

Booting a large arm64 server (HiSi D05) leads to the following
shouting at boot time:

[   20.722132] debugfs: File 'irqchip@(____ptrval____)-3' in directory 'domains' already present!
[   20.730851] debugfs: File 'irqchip@(____ptrval____)-3' in directory 'domains' already present!
[   20.739560] debugfs: File 'irqchip@(____ptrval____)-3' in directory 'domains' already present!
[   20.748267] debugfs: File 'irqchip@(____ptrval____)-3' in directory 'domains' already present!
[   20.756975] debugfs: File 'irqchip@(____ptrval____)-3' in directory 'domains' already present!
[   20.765683] debugfs: File 'irqchip@(____ptrval____)-3' in directory 'domains' already present!
[   20.774391] debugfs: File 'irqchip@(____ptrval____)-3' in directory 'domains' already present!

and many more... Evidently, we expect something a bit more informative
than ____ptrval____, and certainly we want all of our domains, not just
the first one.

For that, turn the %p used to generate the fwnode name into something
that won't be repainted (%pa). Given that we've now fixed all users to
pass a pointer to a PA, it will actually do the right thing.

Acked-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 include/linux/irqdomain.h |  6 +++---
 kernel/irq/irqdomain.c    |  9 +++++----
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 07ec8b3..583e7ab 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -220,7 +220,7 @@ static inline struct device_node *irq_domain_get_of_node(struct irq_domain *d)
 
 #ifdef CONFIG_IRQ_DOMAIN
 struct fwnode_handle *__irq_domain_alloc_fwnode(unsigned int type, int id,
-						const char *name, void *data);
+						const char *name, phys_addr_t *pa);
 
 enum {
 	IRQCHIP_FWNODE_REAL,
@@ -241,9 +241,9 @@ struct fwnode_handle *irq_domain_alloc_named_id_fwnode(const char *name, int id)
 					 NULL);
 }
 
-static inline struct fwnode_handle *irq_domain_alloc_fwnode(void *data)
+static inline struct fwnode_handle *irq_domain_alloc_fwnode(phys_addr_t *pa)
 {
-	return __irq_domain_alloc_fwnode(IRQCHIP_FWNODE_REAL, 0, NULL, data);
+	return __irq_domain_alloc_fwnode(IRQCHIP_FWNODE_REAL, 0, NULL, pa);
 }
 
 void irq_domain_free_fwnode(struct fwnode_handle *fwnode);
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 3078d0e..e7bbab1 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -31,7 +31,7 @@ struct irqchip_fwid {
 	struct fwnode_handle	fwnode;
 	unsigned int		type;
 	char			*name;
-	void *data;
+	phys_addr_t		*pa;
 };
 
 #ifdef CONFIG_GENERIC_IRQ_DEBUGFS
@@ -62,7 +62,8 @@ EXPORT_SYMBOL_GPL(irqchip_fwnode_ops);
  * domain struct.
  */
 struct fwnode_handle *__irq_domain_alloc_fwnode(unsigned int type, int id,
-						const char *name, void *data)
+						const char *name,
+						phys_addr_t *pa)
 {
 	struct irqchip_fwid *fwid;
 	char *n;
@@ -77,7 +78,7 @@ struct fwnode_handle *__irq_domain_alloc_fwnode(unsigned int type, int id,
 		n = kasprintf(GFP_KERNEL, "%s-%d", name, id);
 		break;
 	default:
-		n = kasprintf(GFP_KERNEL, "irqchip@%p", data);
+		n = kasprintf(GFP_KERNEL, "irqchip@%pa", pa);
 		break;
 	}
 
@@ -89,7 +90,7 @@ struct fwnode_handle *__irq_domain_alloc_fwnode(unsigned int type, int id,
 
 	fwid->type = type;
 	fwid->name = n;
-	fwid->data = data;
+	fwid->pa = pa;
 	fwid->fwnode.ops = &irqchip_fwnode_ops;
 	return &fwid->fwnode;
 }
