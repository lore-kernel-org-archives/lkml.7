Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C63C31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 14:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A2DC21743
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 14:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565103466;
	bh=CBIsrxCpotq8Wp+IQPGBa3mdtO92b1KyabUs2cEGAQE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ydBNQ+N8rguku+rgOETdbG8lXSpoMjFElhHYUjTVJDkernsDVhmvjfeb7Sp1rMqto
	 5+5jZwnJ1RlRfexKDmt1NawIUKOyu/n/Mh2DkA6iVNGbFpe+CX8ypE0T1mSZaLlLT8
	 r+BTg9B8oK9iejxQ0rDM4YsrDLxRn8PxvUSb6au0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733244AbfHFO5p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 10:57:45 -0400
Received: from foss.arm.com ([217.140.110.172]:34798 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733218AbfHFO5m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 10:57:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9ED2F1713;
        Tue,  6 Aug 2019 07:57:41 -0700 (PDT)
Received: from filthy-habits.cambridge.arm.com (filthy-habits.cambridge.arm.com [10.1.197.61])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 311163F706;
        Tue,  6 Aug 2019 07:57:40 -0700 (PDT)
From:   Marc Zyngier <maz@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Walleij <linusw@kernel.org>, Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] irqdomain/debugfs: Use PAs to generate fwnode names
Date:   Tue,  6 Aug 2019 15:57:16 +0100
Message-Id: <20190806145716.125421-9-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190806145716.125421-1-maz@kernel.org>
References: <20190806145716.125421-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 include/linux/irqdomain.h | 6 +++---
 kernel/irq/irqdomain.c    | 9 +++++----
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 07ec8b390161..583e7abd07f9 100644
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
index 3078d0e48bba..e7bbab149750 100644
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
-- 
2.20.1

