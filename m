Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E5BFC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 659752083D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553257104;
	bh=hSXjzSAYi/RAPFsO4j2ttsZsw+eohgoYzDX8fLqipSY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=si1K++2N4VNwLbiGmVTJI+OzLyrmXSKb/YRKEOvFXT7C8Ku7Dv783Q8Ne9TVgAau1
	 sTlWxFC751HTUOJv7fuF463SdjkSv3/gdu8DYwX98CdyktpNRmUZitV7OQ6qQkjLHl
	 frMQg3sPKwo5ARCPnnHq8ENntoIAT4cBUCxbJjeA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390491AbfCVMSW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:18:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:57190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390477AbfCVMSU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:18:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1ADA2083D;
        Fri, 22 Mar 2019 12:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553257099;
        bh=hSXjzSAYi/RAPFsO4j2ttsZsw+eohgoYzDX8fLqipSY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1uZyzrof53o29mJDthnRBc2gSLdbX8Jvu8BqyaZE/biKHpw2u/hPyXrZZK4mZOlWQ
         CIGhgKXBUUx7DVjo4Gt4fX+xMjM0ae+I5fE897dyBkLtEJLc3jZQ8QdVxbSLTGckdm
         S94bqjrTeFKXAKg9Z+IiGao2sF4ImawW6D6uZTy8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Lu=C3=ADs=20Mendes?= <luis.p.mendes@gmail.com>,
        Leigh Brown <leigh@solinno.co.uk>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH 5.0 132/238] PCI: pci-bridge-emul: Create per-bridge copy of register behavior
Date:   Fri, 22 Mar 2019 12:15:51 +0100
Message-Id: <20190322111306.268960400@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111258.383569278@linuxfoundation.org>
References: <20190322111258.383569278@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>

commit 59f81c35e0df840f7112cb296dde48df84a67c79 upstream.

The behavior of the different registers of the PCI-to-PCI bridge is
currently encoded in two global arrays, shared by all instances of
PCI-to-PCI bridge emulation.

However, we will need to tweak the behavior on a per-bridge basis, to
accommodate for different capabilities of the platforms where this
code is used. In preparation for this, create a per-bridge copy of the
register behavior arrays, so that they can later be tweaked on a
per-bridge basis.

Fixes: 1f08673eef123 ("PCI: mvebu: Convert to PCI emulated bridge config space")
Reported-by: Luís Mendes <luis.p.mendes@gmail.com>
Reported-by: Leigh Brown <leigh@solinno.co.uk>
Tested-by: Leigh Brown <leigh@solinno.co.uk>
Tested-by: Luis Mendes <luis.p.mendes@gmail.com>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: stable@vger.kernel.org
Cc: Luís Mendes <luis.p.mendes@gmail.com>
Cc: Leigh Brown <leigh@solinno.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pci/pci-bridge-emul.c |   80 +++++++++++++++++++++++++++---------------
 drivers/pci/pci-bridge-emul.h |    8 +++-
 2 files changed, 60 insertions(+), 28 deletions(-)

--- a/drivers/pci/pci-bridge-emul.c
+++ b/drivers/pci/pci-bridge-emul.c
@@ -24,29 +24,6 @@
 #define PCI_CAP_PCIE_START	PCI_BRIDGE_CONF_END
 #define PCI_CAP_PCIE_END	(PCI_CAP_PCIE_START + PCI_EXP_SLTSTA2 + 2)
 
-/*
- * Initialize a pci_bridge_emul structure to represent a fake PCI
- * bridge configuration space. The caller needs to have initialized
- * the PCI configuration space with whatever values make sense
- * (typically at least vendor, device, revision), the ->ops pointer,
- * and optionally ->data and ->has_pcie.
- */
-void pci_bridge_emul_init(struct pci_bridge_emul *bridge)
-{
-	bridge->conf.class_revision |= PCI_CLASS_BRIDGE_PCI << 16;
-	bridge->conf.header_type = PCI_HEADER_TYPE_BRIDGE;
-	bridge->conf.cache_line_size = 0x10;
-	bridge->conf.status = PCI_STATUS_CAP_LIST;
-
-	if (bridge->has_pcie) {
-		bridge->conf.capabilities_pointer = PCI_CAP_PCIE_START;
-		bridge->pcie_conf.cap_id = PCI_CAP_ID_EXP;
-		/* Set PCIe v2, root port, slot support */
-		bridge->pcie_conf.cap = PCI_EXP_TYPE_ROOT_PORT << 4 | 2 |
-			PCI_EXP_FLAGS_SLOT;
-	}
-}
-
 struct pci_bridge_reg_behavior {
 	/* Read-only bits */
 	u32 ro;
@@ -284,6 +261,55 @@ const static struct pci_bridge_reg_behav
 };
 
 /*
+ * Initialize a pci_bridge_emul structure to represent a fake PCI
+ * bridge configuration space. The caller needs to have initialized
+ * the PCI configuration space with whatever values make sense
+ * (typically at least vendor, device, revision), the ->ops pointer,
+ * and optionally ->data and ->has_pcie.
+ */
+int pci_bridge_emul_init(struct pci_bridge_emul *bridge)
+{
+	bridge->conf.class_revision |= PCI_CLASS_BRIDGE_PCI << 16;
+	bridge->conf.header_type = PCI_HEADER_TYPE_BRIDGE;
+	bridge->conf.cache_line_size = 0x10;
+	bridge->conf.status = PCI_STATUS_CAP_LIST;
+	bridge->pci_regs_behavior = kmemdup(pci_regs_behavior,
+					    sizeof(pci_regs_behavior),
+					    GFP_KERNEL);
+	if (!bridge->pci_regs_behavior)
+		return -ENOMEM;
+
+	if (bridge->has_pcie) {
+		bridge->conf.capabilities_pointer = PCI_CAP_PCIE_START;
+		bridge->pcie_conf.cap_id = PCI_CAP_ID_EXP;
+		/* Set PCIe v2, root port, slot support */
+		bridge->pcie_conf.cap = PCI_EXP_TYPE_ROOT_PORT << 4 | 2 |
+			PCI_EXP_FLAGS_SLOT;
+		bridge->pcie_cap_regs_behavior =
+			kmemdup(pcie_cap_regs_behavior,
+				sizeof(pcie_cap_regs_behavior),
+				GFP_KERNEL);
+		if (!bridge->pcie_cap_regs_behavior) {
+			kfree(bridge->pci_regs_behavior);
+			return -ENOMEM;
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * Cleanup a pci_bridge_emul structure that was previously initilized
+ * using pci_bridge_emul_init().
+ */
+void pci_bridge_emul_cleanup(struct pci_bridge_emul *bridge)
+{
+	if (bridge->has_pcie)
+		kfree(bridge->pcie_cap_regs_behavior);
+	kfree(bridge->pci_regs_behavior);
+}
+
+/*
  * Should be called by the PCI controller driver when reading the PCI
  * configuration space of the fake bridge. It will call back the
  * ->ops->read_base or ->ops->read_pcie operations.
@@ -312,11 +338,11 @@ int pci_bridge_emul_conf_read(struct pci
 		reg -= PCI_CAP_PCIE_START;
 		read_op = bridge->ops->read_pcie;
 		cfgspace = (u32 *) &bridge->pcie_conf;
-		behavior = pcie_cap_regs_behavior;
+		behavior = bridge->pcie_cap_regs_behavior;
 	} else {
 		read_op = bridge->ops->read_base;
 		cfgspace = (u32 *) &bridge->conf;
-		behavior = pci_regs_behavior;
+		behavior = bridge->pci_regs_behavior;
 	}
 
 	if (read_op)
@@ -383,11 +409,11 @@ int pci_bridge_emul_conf_write(struct pc
 		reg -= PCI_CAP_PCIE_START;
 		write_op = bridge->ops->write_pcie;
 		cfgspace = (u32 *) &bridge->pcie_conf;
-		behavior = pcie_cap_regs_behavior;
+		behavior = bridge->pcie_cap_regs_behavior;
 	} else {
 		write_op = bridge->ops->write_base;
 		cfgspace = (u32 *) &bridge->conf;
-		behavior = pci_regs_behavior;
+		behavior = bridge->pci_regs_behavior;
 	}
 
 	/* Keep all bits, except the RW bits */
--- a/drivers/pci/pci-bridge-emul.h
+++ b/drivers/pci/pci-bridge-emul.h
@@ -107,15 +107,21 @@ struct pci_bridge_emul_ops {
 			   u32 old, u32 new, u32 mask);
 };
 
+struct pci_bridge_reg_behavior;
+
 struct pci_bridge_emul {
 	struct pci_bridge_emul_conf conf;
 	struct pci_bridge_emul_pcie_conf pcie_conf;
 	struct pci_bridge_emul_ops *ops;
+	struct pci_bridge_reg_behavior *pci_regs_behavior;
+	struct pci_bridge_reg_behavior *pcie_cap_regs_behavior;
 	void *data;
 	bool has_pcie;
 };
 
-void pci_bridge_emul_init(struct pci_bridge_emul *bridge);
+int pci_bridge_emul_init(struct pci_bridge_emul *bridge);
+void pci_bridge_emul_cleanup(struct pci_bridge_emul *bridge);
+
 int pci_bridge_emul_conf_read(struct pci_bridge_emul *bridge, int where,
 			      int size, u32 *value);
 int pci_bridge_emul_conf_write(struct pci_bridge_emul *bridge, int where,


